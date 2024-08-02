Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D1CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsRC-00046x-RE; Fri, 02 Aug 2024 09:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsRA-0003xJ-EG
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:35:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsR6-0000YZ-Dj
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:35:14 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso68647595ad.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605710; x=1723210510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nr7RZucfirVPxeHMYTFTuPY8dZXbvNxt/F1EO8XL/Oo=;
 b=Z30MdH5tThE8gLcHmbXBlViCxqg7AANPNodqG1CTjKWJhJDcXF+mDShPeIejh3CsaC
 7gDUbCYvrLE39FDHV7dLzxRkwkQ5tlbZAHxeatcf/IKFwgBUJpB9oVexa09Fg2PQfyUz
 N0L84qabvTGxR0wXW3wp6upQNv56+FsHfy8qpvYIvs1bZzrKq9f2UG0iy/qD1dx4/yV8
 qsO7iVb9oGBUGy3UEcMioro+zxBcWbkRSG5ggCvAaqRo9vVIUGkuNGCO8244ETCE8jUS
 2C+iYOz1jFsAZlsDFqdzvV85GzeRmy5k+gEyD5I46vKYYWUn8PXVpNdjoqOb+RAL/RL2
 dWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605710; x=1723210510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nr7RZucfirVPxeHMYTFTuPY8dZXbvNxt/F1EO8XL/Oo=;
 b=uMgQxNKY2k9N0OzD8xKqCY63rBT/TlamNeOOafkMoY0vgMVOS0e2Qfvnt3BAUjyMrh
 W9Sfeq0l85KwHGpYtoRpHgsBh4+SSL4Wde/MvPNZH+vOptQIWVIThrn+cXkhMZPhXKYk
 WlG4c32DD6/b+qfhRhGVQ1ZTU0d7CVLMaax7QD5+MQVaesbPqrlmIm1L/uU0wBXC6Zc3
 REVTwSIMZDqXnWHfF8v8w2eHH0rbzlAcX85dwdo6aBTZCldpi4mGLJAgAjYM9NWVy6Bv
 xk3HB6PWXI8wFYuIjXdJsAxxiKRCuZuJbXKZ82/H5YnaXKaTAjsGiEv0CTFeZu05XUYm
 +cbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKzQLqRqn+1ceUXCBqibEwjfbLTlB1YV/8gV6frFnsHnbXN7cjTRG8zAc2++4fFp2fORFLMOCwkO779blwEdL6fkEvHZU=
X-Gm-Message-State: AOJu0YwLPXJzhuPKh6czLuMI/xcUkK/gbF9w6uHuYcemSenbsViCEUlv
 hu/8i8wNTZBVrgFrzuMO7bmUHPDHs4MPHn0+RwAlSTmiPtP5sk98y7JVHBb9K/Y=
X-Google-Smtp-Source: AGHT+IG7cYFkRmF73sv1Txcm4OddYHztxLcc+VAbFwFI4basjSmB8Rt0HKxrk0rP3k7/OiwjK+cADA==
X-Received: by 2002:a17:902:e850:b0:1fc:3dad:25ed with SMTP id
 d9443c01a7336-1ff5723e533mr43422735ad.9.1722605709942; 
 Fri, 02 Aug 2024 06:35:09 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592ac867sm16912445ad.277.2024.08.02.06.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:35:09 -0700 (PDT)
Message-ID: <241c734c-c718-4c86-9816-f4cf9bc75f9b@linaro.org>
Date: Fri, 2 Aug 2024 23:35:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] bsd-user: Define RISC-V system call structures and
 constants
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-13-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-13-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin<mark.corbin@embecsom.com>
> 
> Introduced definitions for the RISC-V system call interface, including
> the 'target_pt_regs' structure that outlines the register storage
> layout during a system call.
> Added constants for hardware machine identifiers.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke<jrtc27@jrtc27.com>
> ---
>   bsd-user/riscv/target_syscall.h | 38 +++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 bsd-user/riscv/target_syscall.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

