Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6198C3DA42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRIYW-0001BH-GF; Tue, 09 Jul 2024 17:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRIYU-00015X-SJ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:39:22 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRIYS-0004RD-Gm
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:39:22 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52ea33671ffso5169411e87.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720561157; x=1721165957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2bMJhXP2mOiq8Y0nEa1hF7/NfI0P/ETBfTA2iJyHUDg=;
 b=WFXWcH+4D8wl01u2KtBCwS5N7zDEBMyKJB0LNj8Fx0VrnQkaP+hBZ89uWoWQAgM13v
 fUwbZIOidoVyeXxQMAoe/PU1gq1h13fuwvg6UEd0rU2nRcRRRr7Y0iQEjWJGaNgoLSIP
 B0xNF8hGnzwpyB34QZQHcRRV7/00SykeGyzbYtr7IeMD1lQQlCWC2PxE0ADp2BZ2f+d3
 oqW/vriTrvKZJR5ZhUefIwIjsJyQn4sl16ztUQcvIc3QoP/ENIjQHNqx6Q2b0Px7xIQI
 Wu2XEBeQSmeOhzxB1W/IhJbH/CuSQHlJK9/9oORecD6Ml0ug2SP9ftrwuB2wQTkgZuIQ
 HkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720561157; x=1721165957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bMJhXP2mOiq8Y0nEa1hF7/NfI0P/ETBfTA2iJyHUDg=;
 b=Wj1xMQznHYqyQXPhQhncfYzSXbDwik0ml93OwWZiVr9557F0IfQHhteeDoHwwNzEcO
 5bt5KEd8I+6T+gg8KdXxPZg12Xwttns+gWGOymC9HrveGNF8bxlRI6ONsn8ICybgaiB8
 RT2Gzn+XfpKylU7s+DTP+4BZ1XLWJ6JopXRrT9r6eKtO9vTwtqpuW5chKEkUfcEPIohG
 lEQjG2Qf1EtjaSNf862nhf1CRUV8hbI+9NXwNfJGshN9bdpW28QFfUdujAStQAuAI/kk
 th+j5LaxgBHEm8jvY/51FlE7n4Bc9nHTQz5CCzSkyBmaw7m6zuReCSvtXQlIKFqjJoMB
 reQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM3FrBf22rswPgX+WT1ecto3Oax/Wi0YzhaUFK5z9g/hfPb+y2axmmACnSYhUfvhMNZnalqVNBHo98RYnirg5r+Xnvtyw=
X-Gm-Message-State: AOJu0YzTfiK+3U8eMZl4TtRedMm7hLX3Fyh65MZHRWrd1UBtoPMPy4jF
 qiadLv+sVmKH6sqzfsoO0lFXVkLJ1OylxOOFXxKuh+Vof3/LlFMh2u7+ShHXMQ4=
X-Google-Smtp-Source: AGHT+IFsEueX6tlA+xujgr6T1ZJRYqHVVFfvPICp55TFyioqW0UaAl1C/oRwc/jOVlwgT4Ixq+52ww==
X-Received: by 2002:a05:6512:3088:b0:52e:987f:cfc6 with SMTP id
 2adb3069b0e04-52eb99d33f6mr2435240e87.51.1720561156688; 
 Tue, 09 Jul 2024 14:39:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266e861339sm69095865e9.12.2024.07.09.14.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 14:39:16 -0700 (PDT)
Message-ID: <fc8b71b9-e946-4161-8750-fffe37d3c925@linaro.org>
Date: Tue, 9 Jul 2024 23:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v47 00/19] hw/sd/sdcard: Add eMMC support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
References: <20240709152556.52896-1-philmd@linaro.org>
 <e9c273ff-32bd-40fc-8f50-cb47784cf741@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e9c273ff-32bd-40fc-8f50-cb47784cf741@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 9/7/24 17:58, Cédric Le Goater wrote:
> On 7/9/24 5:25 PM, Philippe Mathieu-Daudé wrote:
>> Since v42:
>> - Stick to spec v4.3 (re-simplified EXT_CSD register & migrate)
>> - Fill CID register
>> - Few changes to CSD register
>> - Implement 'boot-mode' reset timing
>> - Add 'boot-size' property
>>
>> Change required for aspeed branch:
>> -- >8 --
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 8c0e36badd..563816b710 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -344,3 +344,3 @@ static void sdhci_attach_drive(SDHCIState *sdhci, 
>> DriveInfo *dinfo, bool emmc,
>>           if (emmc) {
>> -            qdev_prop_set_uint8(card, "boot-config", boot_emmc ? 0x48 
>> : 0x0);
>> +            qdev_prop_set_uint64(card, "boot-size", 1 * MiB);
>>           }
>> (I'm still reluctant to merge patches 16-18)...
> 
> Then, please drop all changes related to the boot partitions. I will keep
> the original patches in my tree and address the feature when I have time.
> TYPE_EMMC is already great to have.

As you mentioned on today's community call, eMMC is a chipset soldered
on a board, so our boards exactly knows what size to expect on the card,
and whether boot partitions are present or not. I find the way of
building the drive image described in patch #16 cumbersome, but I'm OK
to make some concession on it, since "it works" as it. If necessary
we'll improve and deprecate the current properties. I'll repost and
plan to merge as-is (modulo review comments).

Regards,

Phil.

