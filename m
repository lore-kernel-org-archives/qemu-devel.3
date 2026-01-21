Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FB8C44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vifdX-0007W5-Dk; Wed, 21 Jan 2026 16:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vifdV-0007Oe-HP
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:21:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vifdT-0006a2-T9
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:21:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso3481645e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 13:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769030466; x=1769635266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ORVjiz/m/2XsSeSwpvcyE8nim/jyoNM6xAv4uhQ5SJ0=;
 b=n1mmXott0L5i9K5fued09oB+m2KxaouwceXYSSw5wKy6u45iLs+9n4t2INfPv35UiW
 s1X7XeAAK9Lio3Xwbi8l7WJHfQeFmgIV8lPlLrjFu4x2SVe56BIYEnjkx1dDmxmNl9o0
 ZqgMiIEXdfXq9g63ogWI9yYcJFjMV5ZDfduB8yMpHqVeVUeWVILV7GfyLElMX1MTO9UA
 B7KTAFEjkhmZ9X6+avWcbtZxs7dIh16WvYu3S7GLIY/sev0Bz5rNR4RoraD8ts0grs2x
 jM7ftQNBNVDDIX776wPs1w/VkufEc0jytBFWfBZUuNVcqTNrtqJGs2bOj4FQTem9CSbq
 yZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769030466; x=1769635266;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ORVjiz/m/2XsSeSwpvcyE8nim/jyoNM6xAv4uhQ5SJ0=;
 b=r6R7AwtAykIe8zln0onvx+5czrsYQ+SNrlO/rvkTKLYIasK/6+1Ur4BWS4AUKv53jI
 jMIKVgcicyYnwgaw2YH7010k0mK5Mc0Q71No4Z6OzjBaiGmxCbTT1i0S5wMZvEWRGQGs
 DftA6RYdvMC4GKrrzdlvwkJOY+IgvY3PmUriOxd6tDeHxHm1QjRci4du8ncUK+Z6T9f6
 kw81QkSK1vPJLlb/xnHh4vjJcDFPh2Q71oN3C/VW8Vd4zk4ZAF5okilIRTKCZDQy8a3Q
 eNOSy/i/mV17FO6yG2B5PM2wWxGC4O5b3nd2PQMkJPC/efD1+F7BvFF/CvIJK2pVKVwk
 GeRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrEPTKEijLsaBzHHNKfVhGlhEAaG8A5seiO2wxds/n+lSCJte1E9jCtHSwDEKGSI6gLtbPmLA8uEoC@nongnu.org
X-Gm-Message-State: AOJu0Yy+b7oySBeaTJaADTUN6Y4LA2kfVA0uEQKgkkNUIdbS2c/SlfyL
 O8Sj2UHHP6yy5+ONzDRa4TxhVjulSjPMaDWVQbW0oTDcCCbBiZD4/wv8gcz7hOiLAJA=
X-Gm-Gg: AZuq6aLvWw31RV+UC1DPnoS2LsjHTCBeZ6GpAusvwPoV9Gq7FLDEZX4IgF+3J0YQ11u
 511yUXFaJGItjhhWGRd/eeATysyfc2VP/z5mrlHiuA26IoNt5w6TFv02sV/UeFq/TujAWvN5VtZ
 pK2b9hdQ7oGPIm8Trqr38l6FNTSJ6Vm55DyrQ3zuEcArWbEIQ5lzN9/OIxyOOqwZIhhTHI/c9FL
 Xh81XjovnOKVBTejok8W6GcrUeXGhRW+IEicihUXBFvWcwcKSiK6G2FZ4RcvPjXyRrGjw+DHxRb
 GxE3W1Pi1vomZquQXit/LuddQKnwVMTAbBf+BjL1KWDb3KyG22rk5Qjy8zMIw9GkLgJ+xUuMyeZ
 EfYZH7PGTMHSxamzUEfKSEKSlF4MdultjioieeC5GoFfozicyt6dmUqryVFSCmdOuna/RjQo9Eo
 +Y2OVAZKa0rMkQ69PxhvhxB4bCCyxGq9C+aOUm8jqmN8wWh55tBTBqotYFzgtbF1CY
X-Received: by 2002:a05:600c:34d6:b0:47d:3ead:7440 with SMTP id
 5b1f17b1804b1-4801eb131b2mr280552775e9.32.1769030465997; 
 Wed, 21 Jan 2026 13:21:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435924ae723sm12654862f8f.41.2026.01.21.13.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 13:21:05 -0800 (PST)
Message-ID: <e32c09de-85f7-4b71-9d1f-1af9a51abd87@linaro.org>
Date: Wed, 21 Jan 2026 22:21:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] vmapple: making it work on the latest macOS host
 releases
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260114152220.89640-1-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260114152220.89640-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cc'ing Akihiko

On 14/1/26 16:22, Mohamed Mediouni wrote:
> Support for newer guest OSes isn't part of this series.
> 
> v4:
> Rebase and resend without the RFC tag as I didn't get feedback.
> Drop patch 1 (version I posted was incomplete anyways). Last patch isn't worth it too tbh.
> 
> v2->v3:
> Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
> Address comments
> 
> v1->v2:
> Remove some lines that shouldn't have been present...
> 
> Mohamed Mediouni (3):
>    vmapple: apple-gfx: make it work on the latest macOS release
>    Revert "hw/arm: Do not build VMapple machine by default"
>    vmapple: apple-gfx: move legacy memory management APIs away from
>      inline
> 
>   configs/devices/aarch64-softmmu/default.mak |  1 -
>   hw/display/apple-gfx-mmio.m                 | 70 ++++++++++++++++-----
>   hw/display/apple-gfx.h                      | 13 ++++
>   hw/display/apple-gfx.m                      | 47 +++++++++++++-
>   4 files changed, 114 insertions(+), 17 deletions(-)
> 


