Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763A4C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 19:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wg64n-0003Z9-Jq; Sat, 04 Jul 2026 15:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wg64l-0003Yb-J1; Sat, 04 Jul 2026 15:30:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wg64j-0004af-Lh; Sat, 04 Jul 2026 15:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=C6Pg/+IORPXnNr+yqmdfhM4Ez2VDvmIdA8NElynuFXo=; b=p7ulJalh0mbdtUZtbxKE4AlhSw
 M6HAvkbqsIhcre7Qnz6kvavdjPLjnDQm+fPv4/QLnXjliVbxp0Xh06liI16SBC/YuaEM8sAsLUOqo
 L1pEhUGJoTtNLe+z2xb5RHl0lhyooYX2u7bobqoleLNtbPq1EFmcSeVNVixeedJgbXjthafyU80qU
 Sa1vHb791ptPjORy/kOSis4YmHosBJ2JB3eke54Of2IOfQR9QPmufKCeASghcSI6i4Eu0ofpfiBfs
 a6ARAOsCb8pWnax1H+MudUc0wJOhuV7KxvAdHbSBTiLQOUK1hFEYeZkg+jbQwXJV3XCy9hSPUUBFr
 wOQjMWsWETm3Nm67Zg+cLzk1EWD9fWQGtbl8u5CK5xP7kyq9O33qohGcw6CngXk70+Mm56rkdiDiC
 AOzkjn6f2KVz02NuIUFlAgqnL9L8TUzVHBKehnDIxO3Y9mqQsCBGOadU00Kh/iEzF7wSQdK8Jks6v
 cr+KuF+quARA5wRKifAQ05U7F4TrVkFRHsbKxRjpdSwgTxJZUsyvDDkBeZsJjEEsN0khcJXa55l54
 EwKqXNe+mdtsSC+ngcndL0GKzIYGUpkaO96o6r9/1dzxL/eW/wUJQlVx8BOnJFSGY+Svqo52QDm9x
 85JaBYXV3DQuKQN2hj5gvr7bkJXsBRmt9ndXF7XVM=;
Received: from [2a02:8012:2f01:0:b3f4:44c3:c2e7:b860]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wg64b-0015BI-57; Sat, 04 Jul 2026 20:30:45 +0100
Message-ID: <ebca8322-0e62-47bd-a4df-d5f52d5d4e39@ilande.co.uk>
Date: Sat, 4 Jul 2026 20:30:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Jacobson <mhjacobson@me.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20260702022927.46510-1-mhjacobson@me.com>
 <20260702022927.46510-5-mhjacobson@me.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20260702022927.46510-5-mhjacobson@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:b3f4:44c3:c2e7:b860
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 4/5] hw/m68k: add working floppy controller for q800
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/07/2026 03:29, Matt Jacobson wrote:

> Switch the Quadra 800 machine to the working SWIM2 floppy controller.
> Hook up the HeadSel bit on the VIA to control the head selection (the
> IWM does not handle this part itself).
> 
> Signed-off-by: Matt Jacobson <mhjacobson@me.com>
> ---
>   hw/m68k/q800.c            |  5 +++--
>   hw/misc/mac_via.c         | 16 ++++++++++++++++
>   include/hw/m68k/q800.h    |  4 ++--
>   include/hw/misc/mac_via.h |  3 +++
>   4 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ab64250c47..a6997ef802 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -47,7 +47,7 @@
>   #include "hw/audio/asc.h"
>   #include "hw/nubus/mac-nubus-bridge.h"
>   #include "hw/display/macfb.h"
> -#include "hw/block/swim.h"
> +#include "hw/block/swim2.h"
>   #include "net/net.h"
>   #include "net/util.h"
>   #include "qapi/error.h"
> @@ -338,6 +338,7 @@ static void q800_machine_init(MachineState *machine)
>       /* VIA 1 */
>       object_initialize_child(OBJECT(machine), "via1", &m->via1,
>                               TYPE_MOS6522_Q800_VIA1);
> +    m->via1.swim = &m->swim;

This doesn't look right: in general we should avoid accessing a device state struct 
directly unless it is absolutely unavoidable.

>       dinfo = drive_get(IF_MTD, 0, 0);
>       if (dinfo) {
>           qdev_prop_set_drive(DEVICE(&m->via1), "drive",
> @@ -511,7 +512,7 @@ static void q800_machine_init(MachineState *machine)
>       /* SWIM floppy controller */
>   
>       object_initialize_child(OBJECT(machine), "swim", &m->swim,
> -                            TYPE_SWIM);
> +                            TYPE_SWIM2);
>       sysbus = SYS_BUS_DEVICE(&m->swim);
>       sysbus_realize(sysbus, &error_fatal);
>       memory_region_add_subregion(&m->macio, SWIM_BASE - IO_BASE,
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 26ee230dcc..09197fe519 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -31,6 +31,7 @@
>   #include "hw/core/qdev-properties-system.h"
>   #include "system/block-backend.h"
>   #include "system/rtc.h"
> +#include "hw/block/swim2.h"
>   #include "trace.h"
>   #include "qemu/log.h"
>   
> @@ -1080,6 +1081,17 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
>       mos6522_write(ms, addr, val, size);
>   
>       switch (addr) {
> +    case VIA_REG_A:
> +    case VIA_REG_ANH: {
> +        const bool sel = (ms->a & VIA1A_vHeadSel) != 0;
> +
> +        if (v1s->swim) {
> +            swim2_set_sel(v1s->swim, sel);
> +        }
> +
> +        break;
> +    }

Can you move this into a separate via1_swim_update(v1s) function as done for the rtc 
and adb devices as below? If possible I'd like to minimise the per-device logic in 
mos6522_q800_via1_write().

>       case VIA_REG_B:
>           via1_rtc_update(v1s);
>           via1_adb_update(v1s);
> @@ -1224,6 +1236,10 @@ static void mos6522_q800_via1_reset_hold(Object *obj, ResetType type)
>   
>       /* Timer calibration hack */
>       v1s->timer_hack_state = 0;
> +
> +    if (v1s->swim) {
> +        swim2_set_sel(v1s->swim, false);
> +    }

Given that SWIM2 is also a TYPE_DEVICE, you should be able to expose the sel signal 
as a GPIO on the SWIM2 device in a similar way as to how "nubus-irq" is defined in 
mos6522_q800_via2_init() but with just 1 signal. This allows you to connect the 
signal with qdev_connect_gpio_out() (see hw/m68k/q800.c) and drive it using the qemu 
IRQ functions, which should avoid having to reference the SWIM2 device itself 
directly at all.

>   }
>   
>   static void mos6522_q800_via1_realize(DeviceState *dev, Error **errp)
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 77551b9592..2a20314d57 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -33,7 +33,7 @@
>   #include "hw/char/escc.h"
>   #include "hw/core/or-irq.h"
>   #include "hw/scsi/esp.h"
> -#include "hw/block/swim.h"
> +#include "hw/block/swim2.h"
>   #include "hw/nubus/mac-nubus-bridge.h"
>   #include "hw/display/macfb.h"
>   #include "hw/misc/djmemc.h"
> @@ -59,7 +59,7 @@ struct Q800MachineState {
>       ESCCState escc;
>       OrIRQState escc_orgate;
>       SysBusESPState esp;
> -    Swim swim;
> +    SWIM2State swim;
>       MacNubusBridge mac_nubus_bridge;
>       MacfbNubusState macfb;
>       DJMEMCState djmemc;
> diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
> index 114f41db4c..e23735b47c 100644
> --- a/include/hw/misc/mac_via.h
> +++ b/include/hw/misc/mac_via.h
> @@ -13,6 +13,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/misc/mos6522.h"
>   #include "hw/input/adb.h"
> +#include "hw/block/swim2.h"
>   #include "qom/object.h"
>   
>   
> @@ -77,6 +78,8 @@ struct MOS6522Q800VIA1State {
>   
>       /* SETUPTIMEK hack */
>       int timer_hack_state;
> +
> +    SWIM2State *swim;
>   };


ATB,

Mark.


