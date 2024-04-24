Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94660C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 04:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzUDc-0002o0-Ok; Wed, 24 Apr 2024 00:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzUDb-0002ns-Gr
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 00:26:51 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzUDX-0001lq-Pw
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 00:26:51 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6eb86aeeb2cso3980092a34.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 21:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713932806; x=1714537606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nb1yKhS9MX3ZvQ7w50UcNUgzrrYeIqAHVsJ2gIL0ANs=;
 b=yEDTeLvtQdX/6JOXIHvrcInJKbfUjtqhriqVfkjrWsbEdJxUYz5ofT8FSnWtzzktXr
 tuz45/By5yK9mTsL/C02D2GxDqQhHv68wh1maiIMyDQ7f00qM9kiYvSkWjXNy54doOAz
 KRfGCMdM7JgFCilLJhkO4Z43EMl0QeZxGG9Wd4/7WKYOJTUQM+i5LTFzQ5eoMOraiW8O
 LaYh7m6ZmTyaCg6UMOikqY9RiIAX2CVRzwq7NvrVzTKDgTl7d/jY7cfV3d/uFVt4OSYh
 QXibxDeuR0ledG94Wn9+gNktJ33GXantaLIX0Fsvq5INOvehCADOR/Fv20ePqjHw1Z1S
 rolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713932806; x=1714537606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb1yKhS9MX3ZvQ7w50UcNUgzrrYeIqAHVsJ2gIL0ANs=;
 b=UHJrgmmX6ixwgN7bCoyJNwuENWYeAizKstBqLVrK4pJq91a7GDynz+wp165Bfb75Jd
 08s8xrue8isxZECok98pYa61tfRIuqNGtQW3TAvrI9JH87VkFKR+UtL2Gq1fNtTaeplV
 1z4t+FjwetkPEe95xEbY8cDLQ13qvKb7hYb6XlMag5xWM9Za+UsGFU+2wK/RDOYH/stv
 nxmJFG3UCDuWVgZu/B/oOOffWnBO3mmd8fznjZIHx0XtBjfotrNHGmAkwv7mbB0rbpM3
 F0yTP5aD7P+l8J6tWZclss6MMg//95RIsESokA7lGvtjkAcm8MUaVUYYKpy51UjH3pMX
 rYww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqv/BqnddgW2qCQ4Wyf1ygR4Md6l+XgAaLvJHtqcQYlEybEly7ZuSqBv1xK0jwRE8E5oYK/M9oBw3BdLYeXvR7c90oe8g=
X-Gm-Message-State: AOJu0YyVdp2cadB1MCo7/JpxC98jaBKPT3VhLTaVpU6PFbYAik74T4us
 6Qpv3xJ/0jgWSaSOtkYh3Z5M41N1O8xHxL+wRnyphu/ecVSPLXoQXw+UJiyT+RU=
X-Google-Smtp-Source: AGHT+IFQwlx2xsnupjxhpH4z6sMZdxMvL8AIbWCOuIuxNOG4K1uCXu/syCohdlKnEc3R3mKC7oaAYg==
X-Received: by 2002:a05:6808:48:b0:3c6:1412:3541 with SMTP id
 v8-20020a056808004800b003c614123541mr1395298oic.34.1713932805699; 
 Tue, 23 Apr 2024 21:26:45 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a62e802000000b006ed4f616ec4sm10456190pfi.57.2024.04.23.21.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 21:26:45 -0700 (PDT)
Message-ID: <139e4e28-324d-4f42-bd8a-d390e0acd4c9@linaro.org>
Date: Tue, 23 Apr 2024 21:26:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/63] First batch of i386 and build system patch for QEMU
 9.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240423150951.41600-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 4/23/24 08:08, Paolo Bonzini wrote:
> The following changes since commit 62dbe54c24dbf77051bafe1039c31ddc8f37602d:
> 
>    Update version for v9.0.0-rc4 release (2024-04-16 18:06:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 254fade7854a6b3d5b7c54a4ca74c25bb928da14:
> 
>    target/i386/translate.c: always write 32-bits for SGDT and SIDT (2024-04-23 16:08:50 +0200)
> 
> ----------------------------------------------------------------
> * cleanups for stubs
> * do not link pixman automatically into all targets
> * optimize computation of VGA dirty memory region
> * kvm: use configs/ definition to conditionalize debug support
> * hw: Add compat machines for 9.1
> * target/i386: add guest-phys-bits cpu property
> * target/i386: Introduce Icelake-Server-v7 and SierraForest models
> * target/i386: Export RFDS bit to guests
> * q35: SMM ranges cleanups
> * target/i386: basic support for confidential guests
> * linux-headers: update headers
> * target/i386: SEV: use KVM_SEV_INIT2 if possible
> * kvm: Introduce support for memory_attributes
> * RAMBlock: Add support of KVM private guest memfd
> * Consolidate use of warn_report_once()
> * pythondeps.toml: warn about updates needed to docs/requirements.txt
> * target/i386: always write 32-bits for SGDT and SIDT

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


