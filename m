Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C0CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlLa-0002Du-79; Fri, 04 Oct 2024 12:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlLQ-00020Z-Ty
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:39:59 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlLM-0006qf-5H
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:39:54 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fac3f20f1dso27049821fa.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059990; x=1728664790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OduKhiXCyYFySIBtIZ3CtR/jspZalHt3tyCkSIlunGo=;
 b=ixBaspbj/nqI6/gBTmYRt/ITBm6V+/tvnm0rfIqDvC6ESzzSLGi5bKnu0BVlN/ndT8
 whVsRJtYDlVq7kcBHdRkT1VkYwzlyv/asW9CqoijTy8nyPT6BC92aYnEDZl36dfFZEoC
 q+DFoIEpGLrb7njiIisUBraNNjabIN96oslB554cI7g+AFL+74IAx3vqXba+Ma5SfdJ+
 ny1ZuZ/WkmyEqOn+SGS0LaKlA/DDks2CgAUNhOYqgkurlQ3hR516fWntkWfmVtwxM6Xi
 Ue7UkoMOPZjCDwXzuEwJ7ChCtJRAl/1Spgem7VUhki55xqvVaN1mIidw/avPInW/1I3K
 K3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059990; x=1728664790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OduKhiXCyYFySIBtIZ3CtR/jspZalHt3tyCkSIlunGo=;
 b=mWG+S4IDS3v5IFMNx3GI1zAwAQAasATzr+JzbRHJaHJGMTpTPoKyh2TMG0mWEHvQvm
 jOZq8HYae2wEUaHRZfennRR2mGm8FuhHtB/Wj3lnc4Wy5Q0xkrwvgSZnWmk9avylglX8
 lL3R+eyt6e9hqjSz7/2+xBIM5M+5F5tMQvxkh5HhLNd6mDyootxpdLAEaZMxQ/A0oPIn
 7QorolU+D/5cWnRP/wNp64xOs4S7dxZuLHEbRQ24Td60uu0ebTRBKZxqpCdW3zqiNRkB
 G1ymz5pu9PdhEUup3XJpDIrtGbYyjrzf44hgzSm3J5ZCmgjcVnNKwJCL8ho4bX8nrtlT
 w+sA==
X-Gm-Message-State: AOJu0YwRiGxtfFrjRA7D3/qcKrO0bX5x70giaGvfChh7Ha5zceirXV3G
 +wdCQnmm7ZckFIom5VOxGUIk2l5Jizcjn9UxoLVGcscylXlAa3FgsYd3tm7E+EXlNFRMZGwtRUf
 fmzbP1Q==
X-Google-Smtp-Source: AGHT+IFN41KCa3rQKIQLm9FRgNXP9TI22UuiVASOiLeECzngWfDBpupAX0t2k5IkMlSp/I1qiUwNpw==
X-Received: by 2002:a2e:511a:0:b0:2ef:c281:54f7 with SMTP id
 38308e7fff4ca-2faf3d6e4a7mr14502871fa.37.1728059989804; 
 Fri, 04 Oct 2024 09:39:49 -0700 (PDT)
Received: from [192.168.132.175] ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9ab2b19sm222001fa.5.2024.10.04.09.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 09:39:49 -0700 (PDT)
Message-ID: <ee7d7f37-50d8-4cb1-a95e-1214f9ac8f0a@linaro.org>
Date: Fri, 4 Oct 2024 13:39:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/25] misc: Use explicit endian LD/ST API
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/24 18:30, Philippe Mathieu-Daudé wrote:
> For targets (or HW) which are only built for a particular
> endianness, the generic LD/ST helpers are defined as the
> target endianness variant. For example, on big-endian
> targets, stl_p() is equivalent of stl_be_p().
> 
> This series replaces in bulk these LD/ST calls.

This is the first part where we only convert the targets
built for a single endianness.

The rest (MIPS, ARM, PPC, MicroBlaze and Xtensa) will be
handled in different series.

I'm keeping hw/virtio/virtio-config-io.c last. Possibly
current API will then be restricted to user-emu & system/
to avoid further uses.

$ git grep -wlE '(ld|st)t?u?[wlq]_p'
hw/mips/bootloader.c
hw/mips/fuloong2e.c
hw/mips/malta.c
hw/ppc/spapr.c
hw/ppc/spapr_vhyp_mmu.c
target/arm/cpu.c
target/arm/gdbstub.c
target/arm/gdbstub64.c
target/microblaze/gdbstub.c
target/mips/gdbstub.c
target/ppc/gdbstub.c
target/ppc/mmu-hash64.h
target/xtensa/gdbstub.c

accel/tcg/user-exec.c
hw/virtio/virtio-config-io.c
include/exec/cpu-all.h
include/gdbstub/helpers.h
monitor/hmp-cmds-target.c
system/ioport.c
system/memory_ldst.c.inc


> This is helpful for the single binary project where we
> want to build a single binary for multiple targets of
> different endianness.
> 
> Philippe Mathieu-Daudé (25):
>    gdbstub/helpers: Have ldtul_p() definition use ldn_p()
>    target/hexagon: Replace ldtul_p() -> ldl_p()
>    target/alpha: Replace ldtul_p() -> ldq_p()
>    target/s390x: Replace ldtul_p() -> ldq_p()
>    gdbstub/helpers: Introduce ldtul_$endian_p() helpers
>    target/alpha: Use explicit little-endian LD/ST API
>    target/hexagon: Use explicit little-endian LD/ST API
>    hw/i386: Use explicit little-endian LD/ST API
>    target/i386: Use explicit little-endian LD/ST API
>    target/avr: Use explicit little-endian LD/ST API
>    linux-user/i386: Use explicit little-endian LD/ST API
>    target/loongarch: Use explicit little-endian LD/ST API
>    target/sh4: Use explicit little-endian LD/ST API
>    target/tricore: Use explicit little-endian LD/ST API
>    target/rx: Use explicit little-endian LD/ST API
>    target/riscv: Use explicit little-endian LD/ST API
>    hw/m68k: Use explicit big-endian LD/ST API
>    target/m68k: Use explicit big-endian LD/ST API
>    hw/sparc: Use explicit big-endian LD/ST API
>    target/sparc: Use explicit big-endian LD/ST API
>    target/hppa: Use explicit big-endian LD/ST API
>    hw/s390x: Use explicit big-endian LD/ST API
>    target/s390x: Use explicit big-endian LD/ST API
>    target/openrisc: Use explicit big-endian LD/ST API
>    hw/ppc/e500: Use explicit big-endian LD/ST API
> 
>   hw/m68k/bootinfo.h                   |  28 ++---
>   include/gdbstub/helpers.h            |   6 +-
>   hw/i386/multiboot.c                  |  36 +++---
>   hw/i386/x86-common.c                 |  26 ++---
>   hw/m68k/mcf5208.c                    |   2 +-
>   hw/m68k/next-cube.c                  |   2 +-
>   hw/m68k/q800.c                       |   4 +-
>   hw/ppc/ppce500_spin.c                |  24 ++--
>   hw/s390x/ipl.c                       |   4 +-
>   hw/s390x/s390-pci-inst.c             | 166 +++++++++++++--------------
>   hw/sparc/leon3.c                     |  42 +++----
>   hw/sparc/sun4m.c                     |   6 +-
>   hw/sparc64/sun4u.c                   |   6 +-
>   linux-user/i386/signal.c             |   4 +-
>   target/alpha/gdbstub.c               |   2 +-
>   target/avr/gdbstub.c                 |   4 +-
>   target/hexagon/gdbstub.c             |  10 +-
>   target/hppa/gdbstub.c                |   2 +-
>   target/i386/gdbstub.c                |  30 ++---
>   target/i386/tcg/sysemu/excp_helper.c |   4 +-
>   target/i386/xsave_helper.c           |  32 +++---
>   target/loongarch/gdbstub.c           |   8 +-
>   target/m68k/gdbstub.c                |   2 +-
>   target/m68k/helper.c                 |  10 +-
>   target/openrisc/gdbstub.c            |   2 +-
>   target/riscv/gdbstub.c               |  14 +--
>   target/rx/cpu.c                      |   2 +-
>   target/rx/gdbstub.c                  |  24 ++--
>   target/s390x/gdbstub.c               |  34 +++---
>   target/s390x/ioinst.c                |   2 +-
>   target/sh4/gdbstub.c                 |  36 +++---
>   target/sparc/gdbstub.c               |   6 +-
>   target/tricore/gdbstub.c             |   2 +-
>   33 files changed, 292 insertions(+), 290 deletions(-)
> 


