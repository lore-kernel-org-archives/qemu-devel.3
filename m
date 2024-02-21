Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59516C5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcth8-00019C-Oc; Wed, 21 Feb 2024 15:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcth6-00015n-Np
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:59:56 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcth5-0005pI-4L
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:59:56 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so3903059f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708549192; x=1709153992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TJHUmTcTe52nfZvKCbbOOWWrx0DcS8/ew3ywUAipXKk=;
 b=dPpqBMIghkYKwpwXyhXSTbUOMwGCsDuyRF8En3x+c6SRz/930XWNccsUtwGLbpDOZV
 onb4P/UMXhvR+wSKxjGNIbQUzshKA4mAD0zPL2YfvgYF/ZBoUaZSxwG6lvE+qV/NrHB1
 g9Mg/rQGppKI2o8uuxfEyn+1jq0ReGO5lvKYclpEI9Bw98seDBOBcwPcS2DiXbZXw0Vl
 JfR4zOB2f9AXs6xeCXnc1MK/DN8IrDg1Ep0NEv9ESkTRFAxe5fg6kwcm8+BboXv2xzIl
 zpQWLKIShlr4e9tevy0V+wAbmmylGU8G/X6jINtKXr/glnEnsCjzUFzjkwxYUvWjbljw
 r1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708549192; x=1709153992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TJHUmTcTe52nfZvKCbbOOWWrx0DcS8/ew3ywUAipXKk=;
 b=Qd4FUFlgcV/ids1tMEY6xwX6hPctEMav311Bp7l9WEaZX992HzlNzSftUi8YAIT4e9
 fjjcyLhFPVBLy1D84g4TA2VqP8TmyP6jpJIINehsGOGEX3YIR8u4A1R+fXP8b1lJgbUm
 gWRBrsC2RDgjyGdKr9fHWwUz1ku8wWHgrlhCKqKCxT2SFoBT2NTymfbA5PbUkKsu3Qju
 pKqvhXcNkVWiO2V+GecHJPHPZopKFKu26GsXVZByEbzNtfI58yzLKkcnbMa4BJ1sRXjY
 Sp467arMJdQz2C2rF+p+6Tz2sdscik6SiaGUchX1Ht7Lf7sAgU6Tj2VLk74Kup1bCliC
 MXOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuAdewwaQHAotmN8adVHQLH7w/cgWu2lUkaGFJMlKVtnZ/RaPdkcWDPRGKuwigT1xQZK9jy8usbJ+FSmiU1j5SLbY1IxA=
X-Gm-Message-State: AOJu0YyBKL2HAjtVDgiJ8Cz1n7uq8Lx7T3VAccFBkWZeCFbhRPKV/bg0
 3L4XOlAPYBxUlzLTKeNO9+wRyJYwGLgwptFiniKEEirbgodxH4OINgcmzi/VzVU=
X-Google-Smtp-Source: AGHT+IEiwwvhL1jXvLVKdXVU6B4j4XAUExgqOwCKBOvJE8vc3ySuGqaoZB9bupwOs63okZUYurmhSA==
X-Received: by 2002:adf:a488:0:b0:33d:15d7:1164 with SMTP id
 g8-20020adfa488000000b0033d15d71164mr10188002wrb.25.1708549192424; 
 Wed, 21 Feb 2024 12:59:52 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 bt21-20020a056000081500b0033d1f25b798sm18164842wrb.82.2024.02.21.12.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:59:51 -0800 (PST)
Message-ID: <5c0bbc43-b5bb-41b8-8c4c-3d58efb687ce@linaro.org>
Date: Wed, 21 Feb 2024 21:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output
 payload space zeroing
Content-Language: en-US
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221185425.1088766-1-nifan.cxl@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240221185425.1088766-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi,

On 21/2/24 19:53, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The whole mailbox output payload space is already zeroed after copying
> out the input payload, which happens before processing the specific mailbox
> command:
> https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204

Since "latest" isn't stable, this link won't be accurate in 6 months.

Please use the current release:
https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204

> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 7 -------
>   1 file changed, 7 deletions(-)


