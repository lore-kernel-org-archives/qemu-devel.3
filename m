Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07733C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSv4-0006eU-LD; Fri, 07 Jun 2024 02:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSv2-0006dA-73
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:17:44 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSuz-00076V-Oq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:17:43 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso1773545a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717741059; x=1718345859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eFRQd03Kvn7MPBMeYVmVS/L5BOooUFmA+uzo+8dGzK4=;
 b=myXb3FvKYbWgGsurAGdPSywe1DLvx7JqaMCb+JzSHBrhb962P8ngxmwbLgfdacdRiY
 rI/1+82rTa4WGBTmwrzYf11m1t5ECWQFdmOmZZnimJUM4WGPZvGAPIEalxAJl59MbnXE
 AYdk4DtSoNYsFHyM2BtSA1H3AB3ykjglAWEb8y0KdD3cP3NwXttk8Jd4843UUH40fM95
 D24bl2VEaLiUqnHHVS8Dlq51VzTbKx4F3OqiLOSWYNaAfLOLNvn5T3klofQ2sYGCNH92
 gkOkNKtEjScMjuOuPffbM4CEVC/MjgPifb8RSMVrtGxAU2bJTPvp1LtfPrdWqZk1CAWt
 pgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717741059; x=1718345859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eFRQd03Kvn7MPBMeYVmVS/L5BOooUFmA+uzo+8dGzK4=;
 b=oYk8CZVPL4K+MPBgAz0+kl3nCY9uk/ZPNDr7YzCz44vXFuREgzYMhH7VxR90b+O3iD
 mJE4zcCj5pE2SQZhVYLMn+XP+5Ax3G/yfptHHOo4stU8oUu6GaXGTA4hs6k4wtQT6zKX
 YWUzAK9bbNSTfZEeYIfx+F5Au29YUl6URnfPKAjMIuCX1aI1Ku0fWV14t3LHn37+kuFE
 zSOAlDRlugUBRGy3mWCcbOuue+oeG0T+UgszT6imdd2yn8WXPJ8nuonN1jhVRiFNg9bY
 lPsBM2SD5uPR46Hp2cYXxSPS5NcTY1MffafTgJstOgNc4nVCs37euHGJ3/0I8+ON5Pgp
 Hdlg==
X-Gm-Message-State: AOJu0YwHcqdP9R1mB+WOAMRpQy6r283Xaifl2uMSa0S8TzmC46aPTqRk
 UH2KxwcPXnoLgLPu4YZpwBul1Z7AGdMOBX/VFvqDWtl66EYdPf3+mrS9Grt4SMI=
X-Google-Smtp-Source: AGHT+IGAw3PKAJdQ9l8vXEXASFmSaE5p6dVK1KounakkZzQARLugPJj0ja9uz5GP3CDfb1eHg9l04g==
X-Received: by 2002:a50:ab4b:0:b0:579:cd1c:8d69 with SMTP id
 4fb4d7f45d1cf-57c4deb9686mr1484494a12.2.1717741059154; 
 Thu, 06 Jun 2024 23:17:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.231])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae23405asm2209714a12.82.2024.06.06.23.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 23:17:38 -0700 (PDT)
Message-ID: <58ea1275-b71c-4098-b7e6-cde428a2eabb@linaro.org>
Date: Fri, 7 Jun 2024 08:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/apic: Add hint on boot failure because of disabling
 x2APIC
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240606140858.2157106-1-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606140858.2157106-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 6/6/24 16:08, Zhao Liu wrote:
> Currently, the Q35 supports up to 4096 vCPUs (since v9.0), but for TCG
> cases, if x2APIC is not actively enabled to boot more than 255 vCPUs (
> e.g., qemu-system-i386 -M pc-q35-9.0 -smp 666), the following error is
> reported:
> 
> Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:449:
> qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
> Aborted (core dumped)
> 
> This error can be resolved by setting x2apic=on in -cpu. In order to
> better help users deal with this scenario, add the error hint to
> instruct users on how to enable the x2apic feature.

Why not automatically set x2apic=on in this case instead?

> Then, the error
> report becomes the following:
> 
> Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:448:
> qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
> Try x2apic=on in -cpu.
> Aborted (core dumped)
> 
> Note since @errp is &error_abort, error_append_hint() can't be applied
> on @errp. And in order to separate the exact error message from the
> (perhaps effectively) hint, adding a hint via error_append_hint() is
> also necessary. Therefore, introduce @local_error in
> apic_common_set_id() to handle both the error message and the error
> hint.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/intc/apic_common.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


