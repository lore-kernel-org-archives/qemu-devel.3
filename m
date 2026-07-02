Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17137C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLan-0007W0-7h; Thu, 02 Jul 2026 13:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLal-0007Ua-6B
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:52:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLai-0006Si-KZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:52:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8478fe07f65so1964751b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014767; x=1783619567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S+LSPSJC47ehc7kv4+S4odxeEs8KMNtGq4W8RkxYpfk=;
 b=U+8P9xj+wRPjkfPRrbknRVo3uxm7Po4v9WPztc5ZX9BrnxkI7Gk+rTvw6KnaWE+E15
 77sQp/hBavPWeYd6IhGTUs2zqAjA3JkBJpKAFVGKcwKdpHM6zKr2YDmHqLRp5eq83k0x
 cKgJKJjDL5soPrwkMpBKup5w/oih7Vd2fU28+d0Kce3OiJ8tkCSsK5Z7qegyUMkL80EU
 Eo1+g7DZ9Pm1H0tlAsUtrfWYwpyD7Kf4wvZD4L/7eKRb13HWIn9YvwxLYX+rtBVDRRNg
 bMqKJ6Ow4X7LRcdyqvC/XSOh6x21/pUH0uAIa1k+wRyg0xWqESw3fuaOq4EOXx/6dHiF
 MxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014767; x=1783619567;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S+LSPSJC47ehc7kv4+S4odxeEs8KMNtGq4W8RkxYpfk=;
 b=DjE4p2zxzBdLzUeUDQmbhpE42FWbKo1DjM97OJb5/e1m0q29Xe6VuOKXuCf6YbgvE8
 nXLedAwlJOJueun09u9P4uTVXSzHO40LghZDf9rQmvl8odf0URvKHruM3UzpqLxgFdrQ
 x/48zj66QTpXUSXedltiksxk2qBZFPOqzM4KIHciujD1qLJ79UEg1yrfwB5WsH60hGUz
 c0bSmjLaYlRV5zi9mBjZT9VAr9ISialqTEqwyd37ric6w34C3Rh0jXB1I1mjNxKcc/2C
 ADLDH9+/0sD4kg0ZsaB67guAGc2lSBOPMw87sRzNjMG2txeCPlCAGlvT7QlrciQbXr3M
 jnvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0WD/EskQ39SoKH+MosFt3kUpR/Mcu3Fnntz2Aty5eB10ic8R4GQF5vENLVsCOvs1P2rCxNmhhXlJH@nongnu.org
X-Gm-Message-State: AOJu0YypKszWcAcPF4Rw3cW16pbSfr5Bfd/ZIeQAt6+Hod/5hJFh4u5u
 uD4d+utasDTBBL6QSFykvjLU9swGnIC8rAezeXz+f+dm74/D6xdsiuZWz9pfRhYeG2g=
X-Gm-Gg: AfdE7cllOx7FjeNIUfWToJ3gBNSYebw1ic93E8yM+IZ4QhcIPLqDKXRHWRbudpxULWA
 DVQ2CAMSajQRG3N4TVsu7nH72G3yCXPrw3NZ9B6Kc4BgjBWCDi2f5W1rRvfKnB64Ua4ssPQe7do
 tfunXFDm7SKGuL7xAkoehUs1yUWR4FYi/YGLgR6EB8vfIVg3UAw7a6BzS/KvoOAyOSFQ9Bou0MN
 u2g9ASfP98UXnm3ZzvOGWCFbW9tL6dZAMTb/eZ5p4ohxnUkDIRx+Tbg3FOhbVWTtbC2qrLs+8bN
 GeJZ8lXJuF9DOu3fEfh1mzVjCukyzhxAvWVPa46DqRZNcpwLf9CMf4XAD7PcLw8reH3byhZd6/+
 qP4CFGr2CwYxrfKAhM2elJ4Bck8kJFRKV8h0+rTS87BtpYF31eKyyT3ntp46RpLQqEssujaCBVs
 MjCIIb738ajYu/VjhfxihI84JWHkN5xjAPwQCBvhR+OTcIQoNAxRYci/2SbQ==
X-Received: by 2002:a05:6a00:9299:b0:847:968d:b101 with SMTP id
 d2e1a72fcca58-847c0741985mr6530976b3a.21.1783014766904; 
 Thu, 02 Jul 2026 10:52:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6db74fsm1767100b3a.10.2026.07.02.10.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:52:46 -0700 (PDT)
Message-ID: <b89f1fc2-509a-444a-b844-4e3adbb5abec@linaro.org>
Date: Thu, 2 Jul 2026 10:52:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/33] accel: Use GdbBreakpointType enum
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-24-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-24-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Include '_gdbstub_' in the AccelOpsClass handlers to emphasize
> we are handling gdbstub-related requests.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   accel/kvm/kvm-cpus.h          | 11 ++++++++---
>   include/accel/accel-cpu-ops.h |  9 ++++++---
>   include/system/hvf_int.h      |  9 ++++++---
>   include/system/kvm.h          |  9 ++++++---
>   target/arm/internals.h        |  5 +++--
>   accel/hvf/hvf-accel-ops.c     | 20 +++++++++++---------
>   accel/kvm/kvm-accel-ops.c     |  6 +++---
>   accel/kvm/kvm-all.c           | 14 ++++++++------
>   accel/tcg/tcg-accel-ops.c     | 17 ++++++++++-------
>   gdbstub/system.c              | 12 ++++++------
>   target/arm/hvf/hvf.c          | 12 +++++++-----
>   target/arm/hyp_gdbstub.c      |  8 ++++----
>   target/arm/kvm.c              | 12 +++++++-----
>   target/i386/hvf/hvf.c         |  8 +++++---
>   target/i386/kvm/kvm.c         | 12 +++++++-----
>   target/loongarch/kvm/kvm.c    |  8 +++++---
>   target/ppc/kvm.c              | 12 +++++++-----
>   target/riscv/kvm/kvm-cpu.c    |  8 +++++---
>   target/s390x/kvm/kvm.c        |  8 +++++---
>   19 files changed, 119 insertions(+), 81 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

