/**********************************************
   GAMEMODE: ALFA STYLE ROLEPLAY (BASIC VERSION)
   MADE BY: ChatGPT + Abolfazl
************************************************/

#include <a_samp>
#include <zcmd>
#include <sscanf2>

// =========================
//     VARIABLES
// =========================
new PlayerLogged[MAX_PLAYERS];
new PlayerPassword[MAX_PLAYERS][32];

// =========================
//     ON GAMEMODE INIT
// =========================
public OnGameModeInit()
{
    print("====================================");
    print("       ALFA STYLE RP LOADED         ");
    print("====================================");

    SetGameModeText("ALFA RP BASIC");
    AddPlayerClass(0, 1527.0, -1687.0, 13.5, 0, 0,0,0,0,0,0);

    // --- ADD CARS ---
    AddStaticVehicle(411, 1500.0, -1700.0, 13.3, 0, 0, 0); // Infernus
    AddStaticVehicle(560, 1510.0, -1700.0, 13.3, 0, 0, 0);  // Sultan
    AddStaticVehicle(522, 1520.0, -1700.0, 13.3, 0, 0, 0);  // NRG-500

    return 1;
}

// =========================
//     PLAYER CONNECT
// =========================
public OnPlayerConnect(playerid)
{
    PlayerLogged[playerid] = 0;
    SendClientMessage(playerid, -1, "به آلفا رول پلی خوش آمدی !");
    SendClientMessage(playerid, -1, "برای شروع /register یا /login بزن.");
    return 1;
}

// =========================
//     LOGIN & REGISTER
// =========================

CMD:register(playerid, params[])
{
    if(PlayerLogged[playerid] == 1)
        return SendClientMessage(playerid, -1, "شما قبلا وارد شده‌اید!");

    new pass[32];
    if(sscanf(params, "s", pass)) return SendClientMessage(playerid, -1, "استفاده: /register [password]");

    format(PlayerPassword[playerid], 32, pass);
    PlayerLogged[playerid] = 1;

    SendClientMessage(playerid, -1, "ثبت‌نام شدید و وارد شدید.");
    return 1;
}

CMD:login(playerid, params[])
{
    new pass[32];
    if(sscanf(params, "s", pass)) return SendClientMessage(playerid, -1, "استفاده: /login [password]");

    if(!strcmp(pass, PlayerPassword[playerid], true))
    {
        PlayerLogged[playerid] = 1;
        SendClientMessage(playerid, -1, "با موفقیت وارد شدید");
    }
    else SendClientMessage(playerid, -1, "رمز اشتباه است!");

    return 1;
}

// =========================
//     MAIN MENU
// =========================

CMD:menu(playerid)
{
    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "منو اصلی", 
    "ثبت‌نام / ورود\n"
    "شغل‌ها\n"
    "ماشین‌ها\n"
    "تلپورت‌ها\n"
    "خروج",
    "انتخاب", "بستن");
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 1 && response)
    {
        switch(listitem)
        {
            case 0: SendClientMessage(playerid, -1, "برای ثبت‌نام /register [pass] و برای ورود /login [pass]");
            case 1: ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "شغل‌ها", "کارگر\nراننده تاکسی\nپستچی", "انتخاب", "بازگشت");
            case 2: ShowPlayerDialog(playerid, 3, DIALOG_STYLE_LIST, "ماشین‌ها", "ماشین اسپرت\nموتور NRG\nسوپرا", "اسپاون", "بازگشت");
            case 3: ShowPlayerDialog(playerid, 4, DIALOG_STYLE_LIST, "تلپورت‌ها", "اسپاون اصلی\nبانک\nاداره پلیس", "برو", "بازگشت");
        }
    }

    // شغل‌ها
    if(dialogid == 2 && response)
    {
        switch(listitem)
        {
            case 0: SendClientMessage(playerid, -1, "شغل: کارگر فعال شد.");
            case 1: SendClientMessage(playerid, -1, "شغل: تاکسی‌ران فعال شد.");
            case 2: SendClientMessage(playerid, -1, "شغل: پستچی فعال شد.");
        }
    }

    // ماشین‌ها
    if(dialogid == 3 && response)
    {
        switch(listitem)
        {
            case 0: CreateVehicle(411, 1500, -1700, 13.3, 0, 0, 0, 0);
            case 1: CreateVehicle(522, 1505, -1700, 13.3, 0, 0, 0, 0);
            case 2: CreateVehicle(560, 1510, -1700, 13.3, 0, 0, 0, 0);
        }
        SendClientMessage(playerid, -1, "ماشین اسپاون شد.");
    }

    // تلپورت‌ها
    if(dialogid == 4 && response)
    {
        switch(listitem)
        {
            case 0: SetPlayerPos(playerid, 1527.0, -1687.0, 13.5);
            case 1: SetPlayerPos(playerid, 1500.0, -1500.0, 13.5);
            case 2: SetPlayerPos(playerid, 1540.0, -1670.0, 13.5);
        }
        SendClientMessage(playerid, -1, "تلپورت شدید.");
    }

    return 1;
}
