Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8422DC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrWO-0002FY-1o; Wed, 02 Jul 2025 03:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrWL-0002Ey-Qf
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:04:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrWE-0001Bk-N0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:04:39 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso40733465e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751439868; x=1752044668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wegkB1A7qbHCes9bLlKBD8zsvYhBn3nxVgC92MR7xo0=;
 b=nCiyeLYl2iSnNrLy44B2izwdn52hnDhx/5W2uxYD/GDCZQGIucHlNMrd7Wo+4t5fhw
 nA4z1tqaPtHoWuV0wpG16td4/4ftdZz+gm1kuSMRbpbtzUCM0e06IHJ1hwecBWJSErDm
 5ET4ZAUE/R0Jtef6r1fxpgXlQsZl68Uq+6mhv4ESTKPG2fn8wcPZka2Xhn8nOxnAQc4h
 8R1opSffFKJE3khJK96fE30fX3mQllns5FmZ9VCVA8ECh3a1CBzyLoFOp60BP2wC++jG
 thI6S0c7f2iJWhxNt2VzVGiBNIcR4oCoSo1dGn+1+dggwLio+pcQtV229UC0sxBBGy1N
 V7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751439868; x=1752044668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wegkB1A7qbHCes9bLlKBD8zsvYhBn3nxVgC92MR7xo0=;
 b=HC6tHymefrtlRGrPDrThx1pFOItL1gpMlO6s6rr65XX4wgSREZcscYQ1gU0B9KOTfi
 M33Ra1R11eIixjRae/gxEZCuK4oBYoMGT6CzySHhvsQ2RGZbtskO85zPBcWu0gXgcr7I
 gBhOSGa1VnSkPaX9HLzlpf1A27XlTtnO3viGNkoOSVA6UzBoxkQ7/p+o+l0eyhLjYoCJ
 F3+Rozb+3cx5vA1Gn71bfXXJnbxDYYCRDyU2+Ph0lKfyexY0oang80MAfh99J4DoHN9o
 Hmv46kShWrpfZo6KuWhzKazFKrOMlwVbiZ4fWG/QeGWwspr5g5vILjUwTF36R5JINxUe
 /JcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKunymrgtcC5pJro509sb/ETAkp+JEM/7N12NqwZ17VRC9KMxEnkSPJ/LJwI2e6tTywj/XglsYbzMC@nongnu.org
X-Gm-Message-State: AOJu0YyfvNHK/arD6OtkDuK6dEB8cJx3KZOQpQTqx5VxKV/zbe+vt0wx
 uQXN9zagoKWrr+dpcNCUteWbJYxMd8Wqqc5T3Zxx/QfZvdIJLWCXKgudXpKL975m4LM=
X-Gm-Gg: ASbGncvhFT4E0g62cSNFmUmQIUSW98quSHjYj0C7RZuwFLWrTNHplibyM0DvyQ+0UYf
 2ee/va94dRRDlCK9Lr4iJQ8XCaDAGA8P/J5nNlU5TQSAW9FIurguvWoWp4ReMuLn9r27jVs0R8k
 gGFeguhwfpyTmnmiToShKiJSM5wpX98GmOnSIxw0YcVHnERVRurDUPMx8DFFA2FN6isvYNO9kfC
 CG8YgQx+lr9Pmr2ObSiXyDf6DAs2CZtGeyKsfkn2d90dU/s8nn42kt4+dP9+feUPi1Qy3lw/FX9
 SucKrTXo/9TD/4gA0+v+3iwhlAijmUlI9WLxstzvWxJrm2Ujrbdb5zwt4jKFOlnGZUrgBOL61PQ
 E5dFmmSfd+WMcP6dzjStwyMb/syaDg4m5EWkAVgc+
X-Google-Smtp-Source: AGHT+IHMEDfzNhH9WeE3ThNkoloeKp3JnMKcEEQfMQJDQIyTAyW1Euis8/xXX3rQ5KM8HH+PwnJTEg==
X-Received: by 2002:a05:600c:4752:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-454a36e2baamr19877985e9.10.1751439867922; 
 Wed, 02 Jul 2025 00:04:27 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390c88sm198432515e9.8.2025.07.02.00.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 00:04:26 -0700 (PDT)
Message-ID: <e273f8c9-6479-4ae7-95a4-5f3a3053ad76@linaro.org>
Date: Wed, 2 Jul 2025 09:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/arm: Add PCA9554 to ARM target
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Ed Tanous <etanous@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <ed@tanous.net>, Patrick Williams <patrick@stwcx.xyz>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
 <20250701203400.71677-2-etanous@nvidia.com>
 <f7e9fcba-e844-42e3-8e4c-9cc67a3069e7@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f7e9fcba-e844-42e3-8e4c-9cc67a3069e7@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 2/7/25 08:47, Cédric Le Goater wrote:
> Hello Ed,
> 
> On 7/1/25 22:33, Ed Tanous wrote:
>> From: Ed Tanous <ed@tanous.net>
>>
>> There are arm targets that are connected to this io expander,
>> specifically some varieties of Aspeed 2600 BMCs.  Add it to Kconfig to
>> allow use.
>>
>> Signed-off-by: Ed Tanous <etanous@nvidia.com>
>> ---
>>   hw/arm/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index f543d944c3..6ea86534d5 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -532,6 +532,7 @@ config ASPEED_SOC
>>       select I2C
>>       select DPS310
>>       select PCA9552
>> +    select PCA9554

Note, these i2c devices 1/ aren't part of the SoC, but boards/machines,
2/ nor are they required to have a functional machine (i.e. a i2c link
could get cut or an i2c device ending dead).

I'd prefer 1/ add a ASPEED_MACHINE layer selecting ASPEED_SOC and the
external devices, and 2/ use "imply" statement instead of "select" for
devices, as per docs/devel/kconfig.rst:

   Boards specify their constituent devices using ``imply`` and
   ``select`` directives.  A device should be listed under ``select``
   if the board cannot be started at all without it.  It should be
   listed under ``imply`` if (depending on the QEMU command line)
   the board may or may not be started without it.  Boards default to
   true, but also have a ``depends on`` clause to limit them to the
   appropriate targets.
   For some targets, not all boards may be supported by hardware
   virtualization, in which case they also depend on the ``TCG``
   symbol, other symbols that are commonly used as dependencies for
   boards include libraries (such as ``FDT``) or ``TARGET_BIG_ENDIAN``
   (possibly negated).

My 2 cents.

Regards,

Phil.

