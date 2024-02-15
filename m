Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F22C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raftd-0004di-Vy; Thu, 15 Feb 2024 12:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raftb-0004dN-4i
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:51:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raftZ-00006n-7H
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:51:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-411a5b8765bso7151435e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019495; x=1708624295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oTzsyQOgrjaydu2FFPKjsjrYmE42/gc3kn0BTtwcx6o=;
 b=fWzgZtYrQKDNIT1zwnpDmfup3KkAHMgJO7MNy6ESirM9f7H18V7tlAUS2iyqrBaU/H
 CIGpXx3YkAOf34vLLdD1o/j/s56Io0dSYBQ+ff5q5UVRA0e6QDxIaOeVMqdQ47EDf2BL
 YiWLMOuVhcc9bv+Aa7loxgbiJUecM3cl7RoHLLt5MDyBrMSNc3bHH5theLLc375qSUcF
 bUia4m8c4LLX63IzncoZh6nmXXESCx5oRdEBtQQBYOpJaC6POj6Wum5Ix35DwrgxUEYu
 SfGdkkMvncfS8lKfgwE1tijUcpEhNAoeXebFYrAiMaqU/4eFZDCauQcZEWhW55mdZOi2
 n5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019495; x=1708624295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oTzsyQOgrjaydu2FFPKjsjrYmE42/gc3kn0BTtwcx6o=;
 b=h2yTlb48M/4YbulsI+y+Z9J+v+oHhRjC12eLAtI1jG03zXZxygvw3HoLBcicHZwTyp
 3m5JEW6jfQSRL1a/tHJhXDxnpYAMLKBsjEug0IZ1XZ3UlNJ7UqtolK7aa6mRl2LGK8qk
 I6Hq7VHeVVylWs04DRaB/ixssthDXyTjZRUXQrLGuzUdkTsfUrUDAUgT1hT8FKtYbsve
 crAeBq++9uYlDVcJn2acHmrNcMrTge5ZS55VamwFKZLRNSHWZpHMHk1a9F6NM8tw7dso
 3J08K6HvI+P/le72druT3q2VjUCMexeUTCGWn9uVGcXxsg3512Au5O35TTmCA3aLooqc
 ZXWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHv3l7HwiG9jmm7gUwcdqyK9t1vFNABE33IUoBBdhNAxqtnsOHZLvJ5DC9AsKim1nzrIUfon2b9wyTdwaPi9cT2SdhOA8=
X-Gm-Message-State: AOJu0YzGvFpOS4m+1sOam+IVi1hTaYSzy85nkLxBq0oKNgqLZ01kBRXo
 GYng8FXt8n3JmhJC6mgnqtoob3jvNuUAX3750HLL0jAagX4uzR+0B5wiKcYTENCB5pc7ZkD1YP2
 g5pQ=
X-Google-Smtp-Source: AGHT+IFtwKRozmx4ZtfZEa+R/OW49HQ0YsoerVY/t0nZaMKiK727zaGkKQEPHRcG/UQlumX+1Gk6yw==
X-Received: by 2002:a05:600c:4f91:b0:412:17ac:3df1 with SMTP id
 n17-20020a05600c4f9100b0041217ac3df1mr2365421wmq.14.1708019495671; 
 Thu, 15 Feb 2024 09:51:35 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a05600c044e00b004104bc8d841sm5680826wmb.13.2024.02.15.09.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:51:35 -0800 (PST)
Message-ID: <8d661a64-b8ba-4dcd-a6dc-d0b7a203e502@linaro.org>
Date: Thu, 15 Feb 2024 18:51:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] mips: do not list individual devices from configs/
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: shentey@gmail.com, balaton@eik.bme.hu
References: <20240213155005.109954-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213155005.109954-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 13/2/24 16:49, Paolo Bonzini wrote:

> Bernhard Beschow (1):
>    hw/mips/Kconfig: Remove ISA dependencies from MIPSsim board
> 
> Paolo Bonzini (8):

>    isa: clean up Kconfig selections for ISA_SUPERIO
>    isa: fix ISA_SUPERIO dependencies
>    isa: specify instance_size in isa_superio_type_info
>    isa: extract FDC37M81X to a separate file

I'm a bit reluctant with the USB changes so far, so I'm queuing
these 5 patches meanwhile.

Regards,

Phil.

