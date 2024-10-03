Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2C8CF34B2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 16:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swOHn-00053V-B0; Thu, 03 Oct 2024 12:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOHJ-0004jc-7H
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:02:14 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swOHF-0006Id-Lc
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 12:02:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso10880325e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727971324; x=1728576124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZE4Ya70wcZxe1oSW/DEc6u3Q93jhrwN3YL6W9Z4x9pY=;
 b=Bvlzz28+8gAwLK76jJGVhjx8lVG9n1jNMBi6O67HACOfD0korYaYkpujbH43hBAeQI
 bDy0LBNtYthuYxcTe03L8i2Pfxfm7ju98Go8XKRtRa33s0M0ZaUjlpXd64kqCXZeIYiS
 l4O7PhfENWDgSeEDGrWvNITSiG1dEzUFPEAD79AQGrAE33fZz+l0RjS63AcT4PXXcbac
 9z0/PF4xrptTXR+ah970NUaHmCmAuQvPSyQ6D3BeeRRWY3AFOI0HfR5LFsqQdYA+R33C
 46hdypeexxORwXrl9b27DjDknPEEuxPAxwX1lvcD0r+ZvP1tKcNooKhEszlFzf7iUwsP
 ZMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727971324; x=1728576124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZE4Ya70wcZxe1oSW/DEc6u3Q93jhrwN3YL6W9Z4x9pY=;
 b=dFTFsgz/FSYbVovn5wxNDrmfE6pwWBlsmGKkTUYplMNUQET1EUxImRIqD5hudg3Ue5
 8gN/pDs/BP9ZcHQibq6dBxBODVntTjHATeTxar8t/B/2vqYKoYNkfTX4GCyciDhe8cS1
 E8pv80PbRbTILBoPGYcIGcF6DMB/+aKIGBwR9sPaSH3bU2gc+JenZMDib8jh8u1P/tER
 ZBfgqbYkTSmZ+j0273fgfUcQa5AnPPijVjzbc4wgT5MTJpk6kSPKOWCI2Oj894d2prTU
 pwFe4MjGEaiFRgsNpP4iRySK7d8CmBNP42vCh8fim+B+VDnVCJrjiBgbq/LUgbx6Ksxi
 Y3vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVracgATd72mkccVYzDAHRqU7vICoDxFZU+K8YXwwIwS4g5NnfwSCAsRh5/Y6/GEt1xxTMTITiRh95@nongnu.org
X-Gm-Message-State: AOJu0YxBceeHfxTX1iwIT8V9z3H8VyZeCVg1y/uCAyGUP5poroTs3DVI
 8S8GmGbcCFBh9dGB5uuIMrUYxKdj6uxbbj+2imDmsJycsIflOIrs0p1B4JE0dec=
X-Google-Smtp-Source: AGHT+IHWZQ9mssilUnv4Xjg1bn9DYHYRKV+eMJ7lf6nGkDtF7R8zx35xwHAZJJEsBJqtn/KX7K71aw==
X-Received: by 2002:a05:600c:1d8f:b0:42c:bae0:f057 with SMTP id
 5b1f17b1804b1-42f777b9dfcmr61045145e9.8.1727971323859; 
 Thu, 03 Oct 2024 09:02:03 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a02eb3csm47907335e9.43.2024.10.03.09.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 09:02:02 -0700 (PDT)
Message-ID: <0c28a435-0af6-450f-8558-14dddc6cb6a6@linaro.org>
Date: Thu, 3 Oct 2024 18:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-9-philmd@linaro.org>
 <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <257b0de0-6744-4ae8-a2c5-f05eec29a3f0@redhat.com>
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

On 30/9/24 16:32, Thomas Huth wrote:
> On 30/09/2024 09.34, Philippe Mathieu-Daudé wrote:
>> Replace a pair of memcpy() + tswap32() by stl_endian_p(),
>> which also swap the value using target endianness.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/xtensa/xtfpga.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>> index 228f00b045..521fe84b01 100644
>> --- a/hw/xtensa/xtfpga.c
>> +++ b/hw/xtensa/xtfpga.c
>> @@ -438,11 +438,9 @@ static void xtfpga_init(const XtfpgaBoardDesc 
>> *board, MachineState *machine)
>>               const size_t boot_sz = TARGET_BIG_ENDIAN ? sizeof(boot_be)
>>                                                        : sizeof(boot_le);
>>               uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
>> -            uint32_t entry_pc = tswap32(entry_point);
>> -            uint32_t entry_a2 = tswap32(tagptr);
>> -            memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
>> -            memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 4, entry_point);
>> +            stl_endian_p(TARGET_BIG_ENDIAN, boot + 8, tagptr);
> 
> Why don't you simply use stl_p() here?

We want to remove the tswap32() calls...


