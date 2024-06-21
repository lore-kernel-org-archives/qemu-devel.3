Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADCC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKaol-0006Z0-OW; Fri, 21 Jun 2024 05:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKaoj-0006Xx-Ve
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:44:26 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKaoi-0001B0-7P
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:44:25 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52c819f6146so2237234e87.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718963062; x=1719567862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=giND5ZqoCuA5kAoC9wsVR4KinqQC2QGq888+RQsQI2w=;
 b=wJPCwb8nLEEJJpwYKvsWwMHzvR0z3EPmDHRDundkPiZWtbifCoBXkhTsZKT8B1o+qb
 EWHbvKVJnzw3ssIc7ZhZN4z6JhoA1BIZeDXb1DTHH1TPaIP8LMu5aXPKiqhjUamo3H/v
 QTjszBm0cpE2FANrD8QzkKgTLe76hvXpMoa2Rm4ITs3T9OLBAgJGe7Z+JpBh2JVjtQIQ
 Q5wSWm2sCraKTC/7pIpNNL0KGpffDkJr+8ucwCluzo6L4IHzscZxBFmGmeat/zqMBzuk
 zvFQweZ/fHII9+q6tfHPWD+KWASo49O+JQ1m1PqCjvCx4flSiGlKGyD8or6+1z4yDR3H
 VRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718963062; x=1719567862;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=giND5ZqoCuA5kAoC9wsVR4KinqQC2QGq888+RQsQI2w=;
 b=VE6fye57PB2dPDkaI5N9XsR1HZ+CtI85kb/vnwaoUZ5DaFKran6fZGfcaviOr71/7T
 +cQsiATBdFrJHenEXGraG64GpH28XH23q4aw2tWaJ3lfUD5zBeNxiGjVB+Fyt6le596B
 2JCxclpIhSFYgSjcvjCi89m1/zTUQdhzRP2lKrk4gGsb19s156hvY5z4arVZlDnpl/a9
 f1t+2EfNMXiEZa+3XfTm6W2ZBhaUHegmWTBgPuZJlrQLAPGEDOxFJP4EZ88mPPgcIlUi
 vmR4qAelR5EI1J1DnawSw81f/A7HT/2rzD7aMEHWKyfjTIT1B4x8Ds2p7S42jfSrmqbf
 XSxw==
X-Gm-Message-State: AOJu0Yw9mWJtMscyg8iFPBvpTPMltpnsh00pn0crw/xbUQ+frIdPKB9q
 JKkGq9tdxVYjreaCY5oPEbsQwjDeYFTX7EnLTTkKMSVp7z6lD90cIbKn/NiDO/AWOlomgd0SKnJ
 R
X-Google-Smtp-Source: AGHT+IFfjgbVG4MaUaTChvxfAnJmhtgmr/O8Cc8QAQanKj8KM6bSAhxxEQ9qhDVjcUbrzSJHaO/bZw==
X-Received: by 2002:a05:6512:1053:b0:52c:9e51:c3f with SMTP id
 2adb3069b0e04-52ccaa919aemr6475614e87.42.1718963061778; 
 Fri, 21 Jun 2024 02:44:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf48b445sm64272066b.82.2024.06.21.02.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 02:44:21 -0700 (PDT)
Message-ID: <37f83be9-deb5-42a1-b704-14984351d803@linaro.org>
Date: Fri, 21 Jun 2024 11:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/23] hw/sd/sdcard: Generate random RCA value
To: qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shengtan Mao <stmao@google.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-10-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240621080554.18986-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/6/24 10:05, Philippe Mathieu-Daudé wrote:
> Rather than using the obscure 0x4567 magic value,
> use a real random one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 30239b28bc..e1f13e316a 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -46,6 +46,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/timer.h"
>   #include "qemu/log.h"
> +#include "qemu/guest-random.h"
>   #include "qemu/module.h"
>   #include "sdmmc-internal.h"
>   #include "trace.h"
> @@ -469,11 +470,6 @@ static void sd_set_csd(SDState *sd, uint64_t size)
>       sd->csd[15] = (sd_crc7(sd->csd, 15) << 1) | 1;
>   }
>   
> -static void sd_set_rca(SDState *sd)
> -{
> -    sd->rca += 0x4567;
> -}
> -
>   FIELD(CSR, AKE_SEQ_ERROR,               3,  1)
>   FIELD(CSR, APP_CMD,                     5,  1)
>   FIELD(CSR, FX_EVENT,                    6,  1)
> @@ -1055,7 +1051,7 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
>       case sd_identification_state:
>       case sd_standby_state:
>           sd->state = sd_standby_state;
> -        sd_set_rca(sd);
> +        qemu_guest_getrandom_nofail(&sd->rca, sizeof(sd->rca));
>           return sd_r6;

Hmm the NPCM7xx test is failing:

▶  58/450 ERROR:../tests/qtest/npcm7xx_sdhci-test.c:101:sdwrite_read: 
assertion failed: (!memcmp(rmsg, msg, len)) ERROR

But booting various Linux / FreeBSD guests on SD cards works,
so I suppose the test (or TYPE_NPCM7XX_SDHCI model) need some
rework.

$ git grep 0x4567
tests/qtest/npcm7xx_sdhci-test.c:47:    sdhci_cmd_regs(qts, 
NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
tests/qtest/npcm7xx_sdhci-test.c-48- 
SDHC_SELECT_DESELECT_CARD);

In tests/qtest/libqos/sdhci-cmd.h:

/* CMD Reg */
#define SDHC_SEND_RELATIVE_ADDR (3 << 8)
#define SDHC_SELECT_DESELECT_CARD (7 << 8)

IIUC setup_sd_card():

card address is queried ...:

     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0,
                    SDHC_SEND_RELATIVE_ADDR);

... but then ignored and magic 0x4567 is used instead:

     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
                    SDHC_SELECT_DESELECT_CARD);

OK, so this test need rework. I see the sdhci_read_cmd()
method but it reads the SDHC_BDATA FIFO register, not sure
this is what should be used to read the RCA from R6 command
response.

Shengtan, Nuvoton folks, what do you think?

Thanks,

Phil.

