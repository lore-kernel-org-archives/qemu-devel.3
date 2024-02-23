Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AE6C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZCa-0002QN-2S; Fri, 23 Feb 2024 12:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdYwM-0000G6-HN
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:02:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdYw7-0005Cl-DB
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:02:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso359811f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708707726; x=1709312526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6vQybCmDPVJnTiBWw1yInCXOFZfP90yFhohqv+AegO8=;
 b=tFtl/58OAdDQKB4b2M7fpW4YUPdYQznh+WxeRFGBfZelNI76Kmdw7cbO0T4TUGLGdr
 ukhNtZDmMVJI6HtYSQH0mEeZVPoG9BJTjL0OE40aeaOHZ93Aeu9E1tUXkTGyWf3ftJil
 hmzhYVYgPu2Hqtqqa+SbYvNgNOf1JPrqBbh4rhel3tt4q5/C2s7/pvh7sirZwQzTMbRs
 w/ncl2qjVuorvYbEslwgC6UPRha+mNi7zgpTrHZGxzWxVionHsy98PCquuL4dL+z9GBT
 94vk0GEPu7kck3tDAVSHJY9aY5lUWXNwR3cqN99kKWePkWEakr+HAosy2vAOm4z2n8Po
 CwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707726; x=1709312526;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6vQybCmDPVJnTiBWw1yInCXOFZfP90yFhohqv+AegO8=;
 b=PwRK2NxiSDCpAstiXJKCohOO7VwWvWamkFz9qpJgt5JBlYEn9FCMt9k1xCmhA8qauA
 A6UkjyyvbsnJKzFRTL/3oZ7VZieW+hz8FlCyfPVO81EkOcNIX6xKJXiujSd+WDtbPUq6
 +qarvY2LOmMIdfla9m2H2Z1JRG2m8BfPw8qMoT8il9s5kbV7RccOat8LGrXEYNUjKGaz
 E4nnLWDr7dS5Y9w+LSTnlCnqqP+oVKOdkNpMbFrMDNONvBaE5+VNiRfZyI0CcnDRMuPo
 FzLV23npTuALrDNxOsDE4i/QmQU13jQSfrqbfgFB5WlNrm3zuD7SCY99cR/lTmYiHCnt
 XovQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcfP0HgQ3/HW+QVbb4R/TU2440/yAh75D4oupm1OQaOutmtuso9/xp4cJSo8oXMXk6eFjcofgWoHk0MYj8znJ3VbhJems=
X-Gm-Message-State: AOJu0YxR/9QCGZoeu+yRp5ZrtHb/xrLoI/FDxJIBKZ4CYCe2BUgp9l1r
 U3fS0macCjDVKx3oTqYqub9KMr2tw+mYHIDGhXbsqNWlcEUnQtlxFgORqqAM5LzjAQuZ6T0c/Z0
 z
X-Google-Smtp-Source: AGHT+IFRS5tIXfm+kpupPs8EWDjRaVvbqmWDcOFWOjo2Hn0pyXYZwHaMpJrhOiksfuvplWWPerHM+Q==
X-Received: by 2002:adf:f08b:0:b0:33d:2012:a2a7 with SMTP id
 n11-20020adff08b000000b0033d2012a2a7mr193098wro.64.1708707725763; 
 Fri, 23 Feb 2024 09:02:05 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 cm7-20020a5d5f47000000b0033d6fe3f6absm3549758wrb.62.2024.02.23.09.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:02:05 -0800 (PST)
Message-ID: <f3eda3a9-3907-4d23-8cdc-bb5de3af90c4@linaro.org>
Date: Fri, 23 Feb 2024 18:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] acpi, qom: move object_resolve_type_unambiguous to
 core QOM
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23/2/24 13:43, Paolo Bonzini wrote:
> object_resolve_type_unambiguous provides a useful functionality, that
> is currently emulated for example by usb_bus_find().  Move it to core
> code and add error reporting for increased generality.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qom/object.h | 13 +++++++++++++
>   hw/i386/acpi-build.c | 19 ++++---------------
>   qom/object.c         | 16 ++++++++++++++++
>   3 files changed, 33 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


