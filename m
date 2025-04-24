Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1948BC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 17:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u80Go-0005XD-VP; Thu, 24 Apr 2025 13:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u80Gb-0005Vi-A6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:21:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u80GZ-0007sm-5l
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:21:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2295d78b433so15798915ad.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745515297; x=1746120097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4BQ5bxXGz7ozA/B2d3oI47M2ZMNNOQURnDzigwlTCPs=;
 b=PXj4LZb9gdG8FWna2swdG87f3SKDrYj0+e1yjmdG54G6SdoW0yrGXa+XTsZWJitQ6+
 Sl4eKnheSjbYKX2xrdIa7tObmX04PqyacWydd8Lex4rfuiHkX6jZiExaafbi8nWkX+w1
 8B0dIIJQBwbIwH5UuQ9scTlIINNF3/fa/3i5Tka+QD9zAhg41eVcLWWfVtJP8sNjv6yC
 ZDvqCRlGE/H132y8CvBpUGL+0yD72EGIGbgzc5BzIXugUcActlQ6Ug9pBD8+x481n0tJ
 JKPNyhcO4vx9OCacShwPISv9XNIp2whZTBKJXDy2f6YVafln4tlVbygkdJUlpUrEShzN
 LOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745515297; x=1746120097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4BQ5bxXGz7ozA/B2d3oI47M2ZMNNOQURnDzigwlTCPs=;
 b=U7LloJI+dSOYnSUVe6EbI+7sSIFeuGUvbLhMg1gva5Q4k5udgtIhM9tHdd9+83iIKs
 V0s4+nl/N5q+FObMux4CBHoIhRJK1fLynqtwgHucwSDmmy8Rxm008V3nMYl4f9wChMX8
 O+n2vRSZOBFBOrc8znfsKV+7arBYBu8Q9ZR7ceGkOxAGwN4o8/C20MH8GZ9OQ5LJ229S
 PtiC3YVxN8rmZ3wsl1CuX3AetsFggM9O9EygNwvGntNXBVN+axnPLBcU8AcNwZ5YuaAr
 ycUSXMb4mjrJdTspCel/di2yXJZV9ByL76XNTBlGUICaM3fcOMOd6plM5JL7Zb9PsNSd
 Enxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFPVGxN0bNKBz+y2p6l1BY5eZCWdIVoi2NHLkU3ILujGhMHb+Zwfl4fT4MwQbEeDpS3zUC3+onkjOP@nongnu.org
X-Gm-Message-State: AOJu0YwsYT7DKGhtpR/g7VWWH+B9nb18sc/ZbZLbd2lBkbdROfm9cQzi
 vgiLfVWvU289hgsMpUaXVy9heud+8PPs0yxqgxb52r5ET8BiG1uEZNqVu4PiXyE=
X-Gm-Gg: ASbGncudPOs/gXQRql4foLB23lYAXVotISYo8vtFSORN/9LX72PeiAFOurJXsxJU66N
 SFnvXPfYPE90DwOmJwQ40w0s85/P5GnrySJlt81d2U+P4a7b6sEZpZhLK0VRw8Iyhp/IY/uDLvg
 ly5G14CSMcp5he2EjcK3r1AcKRUtWe3tqN4c87r0rD+D262rbfGqm6Cw3HZ0hLSlQ4v2LAhBnf4
 iS//OACFElblZBDhm9Ux+OtoFuQDJTKIxFcX3Nt3p4/hwxepKu8JGKUh3Qgq+aH5DzGeyveMBN1
 pga3x6OyhA8lvkq3m7OnlamEN4sAcszf9Er6yep7iAV/+XqTwmP30+67infH4qwp90QFvFeQeM9
 erPtMKVE=
X-Google-Smtp-Source: AGHT+IF89llR1qZkeJRMGrvGSmWqs2GKhwXilsMQZLaO7faQyoMAXIU7MU/6eXYLJ+4lyttbkih3Lw==
X-Received: by 2002:a17:902:f606:b0:224:c47:cb7 with SMTP id
 d9443c01a7336-22dbd350b7fmr5073965ad.0.1745515297020; 
 Thu, 24 Apr 2025 10:21:37 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db510272csm16199205ad.177.2025.04.24.10.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 10:21:36 -0700 (PDT)
Message-ID: <c38a3c62-636f-452e-9474-7aacdcd4c0f7@linaro.org>
Date: Thu, 24 Apr 2025 10:21:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] accel/tcg: Extract probe API out of
 'exec/exec-all.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250424094653.35932-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/24/25 02:46, Philippe Mathieu-Daudé wrote:
> +++ b/include/accel/tcg/probe.h
> @@ -0,0 +1,110 @@
> +/*
> + * Probe guest virtual addresses for access permissions.
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#ifndef ACCEL_TCG_PROBE_H
> +#define ACCEL_TCG_PROBE_H
> +
> +#ifndef CONFIG_TCG
> +#error Can only include this header with TCG
> +#endif

Please don't add these.
All these do is force extra #ifdefs in the users.

As another example, this patch set produces

https://gitlab.com/rth7680/qemu/-/jobs/9819262393
https://gitlab.com/rth7680/qemu/-/jobs/9819262193


aarch64-linux-gnu-gcc -Ilibqemu-aarch64-softmmu.a.p -I. -I.. -Itarget/arm -I../target/arm 
-Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 
-I/usr/lib/aarch64-linux-gnu/glib-2.0/include -fdiagnostics-color=auto -Wall -Winvalid-pch 
-Werror -std=gnu11 -O2 -g -Wempty-body -Wendif-labels -Wexpansion-to-defined 
-Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self 
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration 
-Wold-style-definition -Wredundant-decls -Wshadow=local -Wstrict-prototypes -Wtype-limits 
-Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi 
-Wno-shift-negative-value -isystem /builds/rth7680/qemu/linux-headers -isystem 
linux-headers -iquote . -iquote /builds/rth7680/qemu -iquote /builds/rth7680/qemu/include 
-iquote /builds/rth7680/qemu/host/include/aarch64 -iquote 
/builds/rth7680/qemu/host/include/generic -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
-D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero 
-fzero-call-used-regs=used-gpr -fPIE -isystem../linux-headers -isystemlinux-headers 
-DCOMPILING_PER_TARGET '-DCONFIG_TARGET="aarch64-softmmu-config-target.h"' 
'-DCONFIG_DEVICES="aarch64-softmmu-config-devices.h"' -MD -MQ 
libqemu-aarch64-softmmu.a.p/target_arm_debug_helper.c.o -MF 
libqemu-aarch64-softmmu.a.p/target_arm_debug_helper.c.o.d -o 
libqemu-aarch64-softmmu.a.p/target_arm_debug_helper.c.o -c ../target/arm/debug_helper.c
In file included from /builds/rth7680/qemu/include/exec/helper-proto-common.h:16,
                  from /builds/rth7680/qemu/include/exec/helper-proto.h:10,
                  from ../target/arm/debug_helper.c:14:
/builds/rth7680/qemu/include/accel/tcg/getpc.h:12:2: error: #error Can only include this 
header with TCG
    12 | #error Can only include this header with TCG
       |  ^~~~~


r~

