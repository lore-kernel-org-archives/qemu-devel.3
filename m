Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F53C54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 12:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siv12-0001bD-NJ; Tue, 27 Aug 2024 08:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1siv11-0001aF-N7; Tue, 27 Aug 2024 08:09:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1siv0z-0005Px-03; Tue, 27 Aug 2024 08:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NZ2EACNXRvSWtuvIlSmReKDhxL1kEjovg+5s6j3m6IA=; b=U0/ZHl2g+ViFWjTmH1JlBxX8OH
 UxeBh2NvivEqbPF9paW9fe89TPucIWuYH6dAEHF43r8mR/tLtccQyeaQ6tHgLj0PXYvARvrPJ+air
 llmK+3oxaZc2gZIn8vUT3wkjK+BWZR6aJDWCJUpEy8EMnHemGAf/7lYK4FOJZbwqeqpcqkSTN9eee
 qOdHyXJ3VMH02AcjW+79rA5CxeDfAXJIdTe1Z2sdL8LT0ZBDKfPgUga6TNqulQW5GsYRJpverwV5c
 KhcjvV0zCW+VJxp85TPUW9s4xpR7UeSxyM1IMFCOF/ppQGhv6y9+pkN2S0iCvPsAuCQZpyoBB726T
 pNYuWHGNAOdH8wNjp6tGPg5qXL7WhqkGQaGYbGunC22m8JwDK0ESNGIfJo9qRh0dcLqyMFzQ7Cx05
 9hzYt65Q33HDtA46Qv6AiWzsZabWPmXpSABnCw8YOHM6QlhbIQM/2HRGQ2+LzWPMsJOYs9CpYGvFj
 u+b+GVIh5geet/mcW4rL4/0/9MLOPVcHVCTRew/f+doGcQKTIFPPydulvCtpeudrKk60lk2l+yHLw
 wAkNS0lb0SHW0JmyJKzT2S/93LPHA/heDB+uBwMoPmzVQbRFPxQxTqk5KlaOobFS1vsSd8iBO0dI5
 mNxB2DRxqhS2CP2JThr+u1R8GWp7amv5oIVtZjPZQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1siv0e-000174-Qy; Tue, 27 Aug 2024 13:09:21 +0100
Message-ID: <0a691100-7c80-40bc-b02b-dccdad510e1c@ilande.co.uk>
Date: Tue, 27 Aug 2024 13:09:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240827100207.3502764-1-mjt@tls.msk.ru>
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
In-Reply-To: <20240827100207.3502764-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] mark <zlib.h> with for-crc32 in a consistent manner
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/08/2024 11:02, Michael Tokarev wrote:

> in many cases, <zlib.h> is only included for crc32 function,
> and in some of them, there's a comment saying that, but in
> a different way.  In one place (hw/net/rtl8139.c), there was
> another #include added between the comment and <zlib.h> include.
> 
> Make all such comments to be on the same line as #include, make
> it consistent, and also add a few missing comments, including
> hw/nvram/mac_nvram.c which uses adler32 instead.
> 
> There's no code changes.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/net/cadence_gem.c             | 2 +-
>   hw/net/dp8393x.c                 | 2 +-
>   hw/net/ftgmac100.c               | 3 +--
>   hw/net/i82596.c                  | 2 +-
>   hw/net/imx_fec.c                 | 3 +--
>   hw/net/lan9118.c                 | 3 +--
>   hw/net/mcf_fec.c                 | 3 +--
>   hw/net/npcm7xx_emc.c             | 3 +--
>   hw/net/rtl8139.c                 | 4 +---
>   hw/net/smc91c111.c               | 3 +--
>   hw/net/stellaris_enet.c          | 2 +-
>   hw/nvram/mac_nvram.c             | 2 +-
>   target/arm/helper.c              | 2 +-
>   target/arm/tcg/helper-a64.c      | 2 +-
>   target/loongarch/tcg/op_helper.c | 2 +-
>   15 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index ec7bf562e5..12857d9d7d 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -23,7 +23,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include <zlib.h> /* For crc32 */
> +#include <zlib.h> /* for crc32 */
>   
>   #include "hw/irq.h"
>   #include "hw/net/cadence_gem.h"
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index bf0652da1b..6d143bac5c 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -27,7 +27,7 @@
>   #include "qapi/error.h"
>   #include "qemu/module.h"
>   #include "qemu/timer.h"
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   #include "qom/object.h"
>   #include "trace.h"
>   
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 80f9cd56d5..c68db4e15f 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -24,8 +24,7 @@
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
>   
> -/* For crc32 */
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   
>   /*
>    * FTGMAC100 registers
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index 6cc8292a65..d786086a51 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -19,7 +19,7 @@
>   #include "qemu/module.h"
>   #include "trace.h"
>   #include "i82596.h"
> -#include <zlib.h>       /* For crc32 */
> +#include <zlib.h> /* for crc32 */
>   
>   #if defined(ENABLE_DEBUG)
>   #define DBG(x)          x
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 8c91d20d44..dfc3fb0d9a 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -33,8 +33,7 @@
>   #include "net/eth.h"
>   #include "trace.h"
>   
> -/* For crc32 */
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   
>   #define IMX_MAX_DESC    1024
>   
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index 91d81b410b..c38ea40ada 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -22,8 +22,7 @@
>   #include "qapi/error.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> -/* For crc32 */
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   #include "qom/object.h"
>   
>   //#define DEBUG_LAN9118
> diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
> index e6902716bd..9db64f08c5 100644
> --- a/hw/net/mcf_fec.c
> +++ b/hw/net/mcf_fec.c
> @@ -16,8 +16,7 @@
>   #include "hw/net/mii.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/sysbus.h"
> -/* For crc32 */
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   
>   //#define DEBUG_FEC 1
>   
> diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
> index d1583b6f9b..7f25bca448 100644
> --- a/hw/net/npcm7xx_emc.c
> +++ b/hw/net/npcm7xx_emc.c
> @@ -29,8 +29,7 @@
>   
>   #include "qemu/osdep.h"
>   
> -/* For crc32 */
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   
>   #include "hw/irq.h"
>   #include "hw/qdev-clock.h"
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 03a204ef8a..69a78ad677 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -48,10 +48,8 @@
>    *  2011-Mar-22  Benjamin Poirier:  Implemented VLAN offloading
>    */
>   
> -/* For crc32 */
> -
>   #include "qemu/osdep.h"
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   
>   #include "hw/pci/pci_device.h"
>   #include "hw/qdev-properties.h"
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index 702d0e8e83..a00a76009e 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -17,8 +17,7 @@
>   #include "qapi/error.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> -/* For crc32 */
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   #include "qom/object.h"
>   
>   /* Number of 2k memory pages available.  */
> diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
> index db95766e29..8e2ce3bf29 100644
> --- a/hw/net/stellaris_enet.c
> +++ b/hw/net/stellaris_enet.c
> @@ -15,7 +15,7 @@
>   #include "net/net.h"
>   #include "qemu/log.h"
>   #include "qemu/module.h"
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   #include "qom/object.h"
>   
>   //#define DEBUG_STELLARIS_ENET 1

For the hw/net devices there are separate net_crc32() and net_crc32_le() functions 
from net/net.c which are intended for (most) network devices where the "standard" 
polynomials are used.

I did start a series years ago that replaced all the hw/net instances with these 
functions with the aim being to isolate the single zlib dependency to net/net.c, but 
it's still languishing on the TODO pile...

> diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
> index fe9df9fa35..83c6724c0a 100644
> --- a/hw/nvram/mac_nvram.c
> +++ b/hw/nvram/mac_nvram.c
> @@ -35,7 +35,7 @@
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "trace.h"
> -#include <zlib.h>
> +#include <zlib.h> /* for adler32 */
>   
>   #define DEF_SYSTEM_SIZE 0xc10
>   
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0a582c1cd3..3f77b40734 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -19,7 +19,7 @@
>   #include "qemu/crc32c.h"
>   #include "qemu/qemu-print.h"
>   #include "exec/exec-all.h"
> -#include <zlib.h> /* For crc32 */
> +#include <zlib.h> /* for crc32 */
>   #include "hw/irq.h"
>   #include "sysemu/cpu-timers.h"
>   #include "sysemu/kvm.h"
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 21a9abd90a..56b431faf5 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -33,7 +33,7 @@
>   #include "qemu/int128.h"
>   #include "qemu/atomic128.h"
>   #include "fpu/softfloat.h"
> -#include <zlib.h> /* For crc32 */
> +#include <zlib.h> /* for crc32 */
>   
>   /* C2.4.7 Multiply and divide */
>   /* special cases for 0 and LLONG_MIN are mandated by the standard */
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index fe79c62fa4..b17208e5b9 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -14,7 +14,7 @@
>   #include "exec/cpu_ldst.h"
>   #include "internals.h"
>   #include "qemu/crc32c.h"
> -#include <zlib.h>
> +#include <zlib.h> /* for crc32 */
>   #include "cpu-csr.h"
>   
>   /* Exceptions helpers */


ATB,

Mark.


