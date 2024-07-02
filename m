Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27431C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdJn-0004Jg-Db; Tue, 02 Jul 2024 09:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOdJm-0004It-3Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:13:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOdJj-0003J7-91
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:13:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so29349745e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719925985; x=1720530785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+rmne+xyIGF6fQn4FWIMhtON6Ac6PmjVIP071xB9hBs=;
 b=zk8fxBO7EwvB+62CskFWvvwBFok1bf0A5oKF4oaT7L1pD4y3shhLvgM0TA8uPuj09x
 AMLsYhSVQe/44rY1svnFq2esmArnebMBSpfJLDQVSD3DFRDxlllwdt8I6tIzJfjcjkbA
 dH86n5dcJ67HfLiwxIvu3LFiuEPmTT8ZXY+bMRk1w4eSGI03KmwWhCkN9xzCzTupbUbE
 Y3M5mcJvjyEBxyb/lav3turIxyyT1G1esPT3rqFyA2iwPKtWbQ6ODo5VughjHJnfIgrP
 DuIPoVWfJW6H1a0tIVjLxM6TMykB7tyqjN11ZbkwDmdT3Q98RowmtdhFV0LsjI6vkW9p
 MmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719925985; x=1720530785;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rmne+xyIGF6fQn4FWIMhtON6Ac6PmjVIP071xB9hBs=;
 b=Db/HNx/UXY3/wVLEwXkIQknTvBDqPEqgB8k2WTALtlvFeXaCodhz1ELk6BGNLeOuis
 QrEpTJdTDvTvzu7ykNRK7ZhYb3la5TziGw5VCOyBF8DHkO0tdgl+scOwHVS9XfL/Z5yy
 3VHpu3RKZpbJEDPB4P5iQ6fvbC/AyKHIZ0+gLwHB/LSCb3hgvKQ9PbkZdf+KmyqLxcGB
 e6l67Mk8Pqa5TGbmjvzsFIdSzvb+rnOnZ19ZnVA6N4TymdQJnzpnOmZGFxwfbYo/Sen3
 PgFFVgqDxh/tmirvgKUBrS2bEdRUlmRGrgr8Y/49xQFGVhBB+02cQ+nbgDP7Y9vHR4l+
 iHOg==
X-Gm-Message-State: AOJu0YzgAjfNckajdV4iwYrXNinWDwl89vEC4eEUJxOPkLp+CtBN7RjC
 oZolSga+POO1JVynKGqhMkWvU6/Ib9P6kPs11Oc5VcwWHKuE0dqgsMeJ8TfeQUQicZ2Zth3YHET
 k
X-Google-Smtp-Source: AGHT+IEfFdP3R21zK5iz4TXiMBKSDULHnevuZjctwq5h/ol416Fkmes/zOWqDtHS8+GpNDyhUGzQwg==
X-Received: by 2002:a5d:5253:0:b0:367:88c2:bcfc with SMTP id
 ffacd0b85a97d-36788c2bd4dmr1127742f8f.1.1719925984974; 
 Tue, 02 Jul 2024 06:13:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e146bsm13174866f8f.57.2024.07.02.06.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 06:13:04 -0700 (PDT)
Message-ID: <c64e9127-8932-4ad1-abee-90d349300181@linaro.org>
Date: Tue, 2 Jul 2024 15:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/23] hw/sd/sdcard: Generate random RCA value
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shengtan Mao <stmao@google.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-10-philmd@linaro.org>
 <37f83be9-deb5-42a1-b704-14984351d803@linaro.org>
Content-Language: en-US
In-Reply-To: <37f83be9-deb5-42a1-b704-14984351d803@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/6/24 11:44, Philippe Mathieu-Daudé wrote:
> On 21/6/24 10:05, Philippe Mathieu-Daudé wrote:
>> Rather than using the obscure 0x4567 magic value,
>> use a real random one.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sd/sd.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)


> Hmm the NPCM7xx test is failing:
> 
> ▶  58/450 ERROR:../tests/qtest/npcm7xx_sdhci-test.c:101:sdwrite_read: 
> assertion failed: (!memcmp(rmsg, msg, len)) ERROR
> 
> But booting various Linux / FreeBSD guests on SD cards works,
> so I suppose the test (or TYPE_NPCM7XX_SDHCI model) need some
> rework.
> 
> $ git grep 0x4567
> tests/qtest/npcm7xx_sdhci-test.c:47:    sdhci_cmd_regs(qts, 
> NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
> tests/qtest/npcm7xx_sdhci-test.c-48- SDHC_SELECT_DESELECT_CARD);
> 
> In tests/qtest/libqos/sdhci-cmd.h:
> 
> /* CMD Reg */
> #define SDHC_SEND_RELATIVE_ADDR (3 << 8)
> #define SDHC_SELECT_DESELECT_CARD (7 << 8)
> 
> IIUC setup_sd_card():
> 
> card address is queried ...:
> 
>      sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0,
>                     SDHC_SEND_RELATIVE_ADDR);
> 
> ... but then ignored and magic 0x4567 is used instead:
> 
>      sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
>                     SDHC_SELECT_DESELECT_CARD);
> 
> OK, so this test need rework. I see the sdhci_read_cmd()
> method but it reads the SDHC_BDATA FIFO register, not sure
> this is what should be used to read the RCA from R6 command
> response.
> 
> Shengtan, Nuvoton folks, what do you think?

More than 1 week passed so I'll have a look at it myself.

Regards,

Phil.


