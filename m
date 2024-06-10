Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C164DC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 08:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGan3-0001bf-Qt; Mon, 10 Jun 2024 04:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGan1-0001bT-QS
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:54:07 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGamz-0006LX-PD
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:54:07 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c3051aee3fso615586a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1718009644; x=1718614444;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ys6924jVG+1OGlqII39GlwPFQ6zFdxt98zDoiOMjFtk=;
 b=ZERCTHuB8wg7CGTQ2pKEgLqomZIJfMMXQhK32TCG2RNHVXlQRIfGSgmNn8KTKOJn/W
 UQM8JEovs7f569rkjPInQhwC3x6cs2uI46PVXYvWIeOh5Atu2ajTUoHAmR1UgPEgo0+B
 zfoxrShQIerekqv0D+AWDS/WyaEzcpj6vQxi7INJ+AriwlU1Qs2OntKg+0BKKdLlxzBv
 cepy0UYGt/ouM9GQ53LfFOBrVEJ/rKzOfVGNpYvIcmMBxwqXoj76y5uxA5L6HU7BtxEn
 /RaIIbJkJ6pFvj2dGWCnvNqJX+QAZgCGUX8Fq8r3im6WpDuzrbD1VSpWZQUTK4QcaLJm
 MaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718009644; x=1718614444;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ys6924jVG+1OGlqII39GlwPFQ6zFdxt98zDoiOMjFtk=;
 b=AVDDIdo7NR7TAHB9lfxwl2XYcU9r/F01cAupPQLTUZ47dxIR5e+aQ9eOAx1v1ZGmXa
 AR+6e+2YRMjywPR7XaSyhUBwdJRgBPnidO57Vxg7QMIQhwGP7ie11aBKztOgkospWwbh
 ehtlXgGG6j40B3VEMPWgIprjaXoLpIMWb5h9RoLjLrOzAG5KFn+bUsmCtAxwExvFjl8/
 f7ay6/6jO/mWTiFfszWC1+es0cnWG+kisj/9hm7MllvTvdX+0BAJqearx89ZFyvkoK4V
 VQdWc4VSNZjC74yTWdNhQTGYV8mFajkz01zVkjXlXGVPpo4hg9VYOygXjTRDDoV5zhA8
 gJQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2vTr2Xu3yRrJsKlRKJed9dMMKtOekvmLTOGR2hqcLcQW+tHAEYoOH6PiGpScGTxr7V7yoB9YtFUybRUwVMnQlrFvc1M4=
X-Gm-Message-State: AOJu0YzKriaN4M2+lMQaMKmpgjVQ/azOhcz3bmbmaKa0cTJEBpXZnduI
 5ngCCxYJg7rGCs3t1/XnVuz4/mjfXfWwtmvu2lFt9hDwuJRnfnPTjucYfZXBrLo=
X-Google-Smtp-Source: AGHT+IH+7Kq5rxG8PQqwoR6WOO0vEcRZuQWkXnXOL3aSQMl9bA96Tr8MvkM+DRYkuUeCoRUOvm20dg==
X-Received: by 2002:a17:90a:4093:b0:2bd:8378:af81 with SMTP id
 98e67ed59e1d1-2c2bcad0e96mr7958384a91.4.1718009643805; 
 Mon, 10 Jun 2024 01:54:03 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c383e33sm8004709a91.40.2024.06.10.01.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 01:54:03 -0700 (PDT)
Message-ID: <3bae86e3-29ea-4b91-9395-28c80478223d@daynix.com>
Date: Mon, 10 Jun 2024 17:54:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw: Moves int_clamp() implementations to header
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-3-phil@philjordan.eu>
 <16786a0d-4cf5-4e62-9db1-a2f448f4b8a6@daynix.com>
 <CAGCz3vtoof+EKnmjX=mAiCQ7Dy=gpXTN3eciZxMHCgnAfb7SiQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAGCz3vtoof+EKnmjX=mAiCQ7Dy=gpXTN3eciZxMHCgnAfb7SiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/10 17:50, Phil Dennis-Jordan wrote:
> On Sun, 9 Jun 2024 at 11:00, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/06/09 5:20, Phil Dennis-Jordan wrote:
>>> Both hw/input/hid.c and hw/usb/dev-wacom.c define identical versions
>>> (aside from code formatting) of a clamping function, int_clamp().
>>> (marked inline) To avoid duplication and to enable further re-use, this
>>> change moves the function into qemu/cutils.h.
>>
>> Wht about replacing int_clamp(a, b, c) with MIN(MAX(a, b), c)?
>> MIN(MAX(a, b), c) has a few advantages:
>> - It works with any integer types
>>     (so you can replace even uint_clamp() in hw/display/vga.c)
> 
> Well, that can of course also be achieved by wrapping MIN(MAX(v, min),
> max) in a new CLAMP(v, min, max) macro.
> 
>> - It makes clear that b is the minimum value and c is the maximum value
>>     while it is not with int_clamp()
> 
> I guess this aspect is rather subjective. When I see a MIN(MAX(
> construct I generally feel the need to triple-check to make sure which
> way around it is. (The minimum value is passed to MAX, the maximum to
> MIN.)
> 
> On the other hand, there is precedent and convention for a clamp()
> function with that order of parameters in other APIs and programming
> languages: C++ std::clamp, Java Math.clamp(), OpenCL kernels and
> OpenGL shaders can both use a built-in clamp() function, etc.

That sounds convincing. Please add the CLAMP macro.

