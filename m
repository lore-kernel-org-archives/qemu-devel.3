Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163CBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 06:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXbN8-0002xl-GO; Sat, 27 Jul 2024 02:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXbN6-0002vU-Uq
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 02:57:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXbN5-0002Ih-7W
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 02:57:40 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso10945965ad.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 23:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722063457; x=1722668257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJ+RaV8FXelDALRpY5ji624PDjGirc8lcspEnvshpLw=;
 b=Dh95X9YyJAztmpxXnjDjHIii5+PsW/ZkDQdqQShqhk5yjIBXHPmi2lpyIIaLFMEDPK
 loN+iUrNsmIFa7FSCCRS8uC334vUET1Y0FBLPt3wuTvZexJ9tDHX5AAunp1tJU0ocRFK
 gtyH4IQe9tCQXo4a5QgS6zSY5dr8YNqCKjeq4RVcB2X8eYW0M/Ezh/rzAaw129KbcPFZ
 O6iTeYXc73S1G1++efGmw0+0furowgQeerv/jm3DKg7+69cpK4PSJ+K3HmabqlAa0bNj
 iXcLSUs5qptQ9/Wbyg6gr3G0pLJpmoRDpzXMscFkoWDUcAnDuOkIuZ/ngm4xkYspYax/
 pKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722063457; x=1722668257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lJ+RaV8FXelDALRpY5ji624PDjGirc8lcspEnvshpLw=;
 b=ODTbDIjgQFVa+glJ2gcTnQRUDRe9GgoIW3h0IZEtI8INkbwdx/R/DDMCbjA0uIUEOE
 ++lqQeBK4c1O4Nok6/c3gMzze+571arRdeOgKwlvmwaVTttv0Lu3Gizml4ugBltXOVNn
 tI53beFmuSvj991G28nqmYOx/BGvZzaaHt9lVT1hArFaDKiuix4XSRJXGmZ7Qr4h8jaH
 qn/OWj0TDeHj+z/dnkrBkOKAuaH+2MSLZyGqqtef8XswHSP4Nm6YoIsky33aK+Pz4Dhs
 RrGwQWkYaADt6O175TIPLIgHq5Zevg2dXRd3PLHG9keFJherz8LDVKk5pTKB2sVTFcJP
 sT4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYimyY2BHj3nRc4ajIJSQDjw5znLWyho/apJm0H30lwdEzAqpwE4WlHaXadzB94GIEWx+WlWppmgFA5jF8QHNrwUFcwNs=
X-Gm-Message-State: AOJu0Ywsg4jIPwDBSG3ms0n80+o/sZZDxyytfQs/uzs40DZjLUS3s+7B
 VF0wcca+zSpx20UT21uQ5fXlPJfTSNCB6AdZZnnBjOioDMs+Ifiyq1YBEMoaqJINuUAYZSluvCb
 jRSMqEw==
X-Google-Smtp-Source: AGHT+IFIwOwjai8vKqADvYBcuNIR4Ujz1UsWXIAGmj/3SDCeNs2ViVbznG+TVoaCJ62JjFlynggRoA==
X-Received: by 2002:a17:902:f54b:b0:1fb:4f8f:f212 with SMTP id
 d9443c01a7336-1ff0491b171mr23737895ad.60.1722063456865; 
 Fri, 26 Jul 2024 23:57:36 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ef238dsm43881545ad.180.2024.07.26.23.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 23:57:36 -0700 (PDT)
Message-ID: <5c63bc0d-c342-4e31-a21b-3900c5d23da2@linaro.org>
Date: Sat, 27 Jul 2024 16:57:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/96] ppc-for-9.1-2 queue
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20240725235410.451624-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/26/24 09:52, Nicholas Piggin wrote:
> Apologies this is so late after soft-freeze, apologies. I was waiting
> on "accel/kvm: Extract common KVM vCPU {creation,parking} code" to be
> merged upsream then ran into last minute CI problems. This PR is very
> contained to ppc code so I hope it will not inconvenience anybody.
> 
> Thanks,
> Nick
> 
> The following changes since commit 029e13a8a56a2931e7c24c0db52ae7256b932cb0:
> 
>    Merge tag 'bsd-user-for-9.1-pull-request' ofgitlab.com:bsdimp/qemu into staging (2024-07-25 09:53:57 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.1-2-20240726-1
> 
> for you to fetch changes up to d741ecffd2ca260ce7875a4596f17736b5ccb7c3:
> 
>    target/ppc: Remove includes from mmu-book3s-v3.h (2024-07-26 09:51:34 +1000)
> 
> ----------------------------------------------------------------
> 
> * Fixes for pseries migration bugs.
> * Graceful handling of vCPU hotplug failure in KVM.
> * Many improvements to powernv machine model.
> * Move more instructions to decodetree.
> * Most of the remaining large MMU cleanup.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

