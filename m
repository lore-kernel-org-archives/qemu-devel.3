Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46E1C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 15:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1radR6-0003A0-6p; Thu, 15 Feb 2024 10:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radR4-00039X-BZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:14:02 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1radR2-0004wQ-Hy
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 10:14:02 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51187830d6dso1146822e87.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708010038; x=1708614838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pVkwg7e76rKm8e6yuFEwM2uCRybD+MrwwSn4FVSHl0U=;
 b=eUN8mGWOb1xqh7tBbbfFe6JUhPBGM2CwjT77kth/oCKFZcriPNASMvTCOJpvKfMY6i
 HJDZd2XYPsjWz/fSCo8o4jzXcKc4zmhGBtcqzJa4b8LEsEfh+hfv5ipy06rH5AG34SIK
 1xvryo8fKj7zubi3VwOCcGkyx64B74HvXDJ6qMxHuChrxsZxD83EFHqevd7qfdzq5VF/
 alK1hlQxIu4JdyRJSnQDW1H+E8vEpOVncoM2BtqMVVHWpO9tsy2Sx4B9w7c0mzxw1DGa
 NKJaX3VH43qUs8O3kVCOcENUx4/hCRiQARV3FpvhO86OIn0ex8pAkWqJoQdQikZUJXeb
 IwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708010038; x=1708614838;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pVkwg7e76rKm8e6yuFEwM2uCRybD+MrwwSn4FVSHl0U=;
 b=ET2DPhDu5rj9zMef3LYd9qPTGeltq104OLbqP3nLMXXEyZVJVhNaZr949A8NwfXQTX
 49m3JYLvvWcj4EYjU/0JYEkl2J27Uz4TFsIf2eGjXF74fAz+czvq+IX5HLNvqxBio0AQ
 bPiaOPf3c69cYtYqI3/g+GGx7MfpVZRDt5mqABQwaHZm710XB0KjwuSdmUk/6iegynbr
 aFScc/wL4JDrdwv9WkpOfT3AuPISOTcnHfytF93E81gs1pJ+6MCB/h7y6MXojvtSfLCr
 CbW9nsdd2AY9GgpKNdnWxrwRO7/KDaIYv1YXSIBDNvbM1djh/ZA9qVL4nnrNK1ogK2J6
 Bv2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI/qPCKL0+2cn89IkzMXMbphYGoRsO5XY2D9wYDaEjkComwPVvzn1vlJPwze5RvoIBtfBGG3/K2iqiz2V/tEBbTFB/kmk=
X-Gm-Message-State: AOJu0YzH6O9rw4VRu7NuZXnh7u86IVtcYgdLPUD4+2BgGHFNnrRMjOir
 OVRBYVxXgYfwrEhh5OX4w5LzVnAW/P4qucrHsgeWMQNrX/rn3etWOibiS3t7+OU=
X-Google-Smtp-Source: AGHT+IEd3Gv9jImjAqVw66mOtTrIm0n/lIfOfVMdOBHHl61HtPyDPDsmQxRI4Yn2w1zbbhuqGrfhpQ==
X-Received: by 2002:a05:6512:68f:b0:512:8d90:7dd2 with SMTP id
 t15-20020a056512068f00b005128d907dd2mr418739lfe.65.1708010038623; 
 Thu, 15 Feb 2024 07:13:58 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 tl16-20020a170907c31000b00a3d21455aedsm652344ejc.127.2024.02.15.07.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 07:13:58 -0800 (PST)
Message-ID: <3b33548a-b0df-4cbb-9b9b-6f6686a8d38f@linaro.org>
Date: Thu, 15 Feb 2024 16:13:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] hw/ide/ahci: Rename AHCI PCI function as 'pdev'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240213081201.78951-1-philmd@linaro.org>
 <20240213081201.78951-4-philmd@linaro.org>
 <be91e350-20e4-4c60-908c-c19b0b663bc6@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <be91e350-20e4-4c60-908c-c19b0b663bc6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 13/2/24 17:32, Richard Henderson wrote:
> On 2/12/24 22:11, Philippe Mathieu-Daudé wrote:
>> We want to access AHCIPCIState::ahci field. In order to keep
>> the code simple (avoiding &ahci->ahci), rename the current
>> 'ahci' variable as 'pdev'
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   hw/i386/pc_q35.c | 15 ++++++++-------
>>   hw/mips/boston.c | 10 +++++-----
>>   2 files changed, 13 insertions(+), 12 deletions(-)
> 

I'll handle this empty reply as a R-b tag :) Thanks!

