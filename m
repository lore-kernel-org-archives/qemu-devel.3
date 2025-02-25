Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D28C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmuW3-0007aZ-3d; Tue, 25 Feb 2025 07:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmuW1-0007a5-5O
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:58:25 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmuVy-0004tO-HA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:58:24 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6fb2a6360efso38481537b3.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 04:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740488300; x=1741093100; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HcD3XyFdA7mIEZd2U7bF/99wQU+mKGDluKiAz/FnbU8=;
 b=SXFEjORdw97b1/6IzUo4BY/wFO1h2o3pgw6TwW/Ajbv9YxHQTIQ02FYmD3idrkPYYQ
 DRRFDZze4aH4ZbgiN4HHDK45/pN1Z9bKFs9KLqZ5d6n1l9JwITMXAiJzlJKIa0ya+zH0
 yKpC62rdvpnoU6JRSDfVafvgCzig3NuIgdNag0BPfmdDE44L8+WIyfSsVsIOBFIUI6/p
 rIfAIKa3cKw7QEtsOnNNDQvog67BMdIr01nRBfNBjNsNNN9CT1UKpG8gpQscyMuip1QB
 oR/QiFSSzxAnTBnOLVnRSsTpKJLCAD4I/qkqGTGQ2i1lo1Wb1MxutB6q5lVydxL4uReD
 KkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740488300; x=1741093100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HcD3XyFdA7mIEZd2U7bF/99wQU+mKGDluKiAz/FnbU8=;
 b=Rkxzl5ZfF5Fce9nfljia7pTLsCvV7AkEvRea8+do4D/hieiRhIpcUN1Oe+SATmdidb
 lPBZthdlrO9rtN8saZcLzllYpJc6X7Oz+d2UJ6r+S9UcUN/HoGNzHMabirbSU3vsSoMl
 UdXYgjVCTJWUjWmVpwLnIQMbh0sx89+A6Q2L3aJ+mX8+heS48EBhwQptgLDtU9KnWeVr
 CevaYVqBaD6rJJAwONZX/wj+mN6U3KXquQSFHi84GQEUqyyrGsjhWjHz7sM7u/fQDTJq
 q4hUNuAdLrwblv8q6tGqs/RbZgqzG2jvVdfCziNWHX6/nvI42Ap8zEPJNG1nKFWFgOTI
 YTKg==
X-Gm-Message-State: AOJu0YyIeReEz9EVZZ8PcfWCkjgrjZP+bLC/3jwBbbzeZp0sM2RJ66zz
 OUKYngxp80lp/LEoA+c9o49jn6dSO5beoOVTh3ATjiU5KU963WOWUrEwPcYHkbH3W1l8OiAXkpp
 wQAHLqyCEV1Ur+zIxZ00K24Z3QGl+S6gj/Jf+Vg==
X-Gm-Gg: ASbGncuStPVudKRHLjj3N/kgn4Pbiy6sAwT4bEYIey0vRstQ0+EMOjc8ULfidusz+td
 jghCi2PVDeMJ70th5X6yCcASfh6OyqDOLE8McUF58jjWTX2+QcAQZJg9afzX3yWrHtnbjVhBHQp
 /GrO7AtEvO
X-Google-Smtp-Source: AGHT+IFJGqsF/1/07NizGOi9RM65qu+ErOBwGSqW4RVu2c/PUrwXkKITGbcjiebNiYnZp8WSE0rZpNzB/xrNIaP7fWw=
X-Received: by 2002:a05:690c:680a:b0:6f0:23da:49a3 with SMTP id
 00721157ae682-6fbcc1f4e1cmr135351037b3.8.1740488300504; Tue, 25 Feb 2025
 04:58:20 -0800 (PST)
MIME-Version: 1.0
References: <CGME20250225124423eucas1p150140ffe95a53e4d802b3594a89707b8@eucas1p1.samsung.com>
 <20250225124418.3530474-1-m.szyprowski@samsung.com>
In-Reply-To: <20250225124418.3530474-1-m.szyprowski@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 12:58:09 +0000
X-Gm-Features: AWEUYZlMIyIRLm1wtCUTLekpu1_Y4EzA4klC8cgAPng6t618gIvSnQSfEUnkfWE
Message-ID: <CAFEAcA_MJ5YwLi04Be+n1TCKuQmU+3fgAznvzpPonJw0FHqH3w@mail.gmail.com>
Subject: Re: [PATCH] linux-user: add support for the AARCH64 ILP32 ABI
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 25 Feb 2025 at 12:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> This patch adds support for the AARCH64 ILP32 ABI [1] to the QEMU
> linux-user AARCH64 port.
>
> The ILP32 ABI was initially developed quite some time ago [2] to
> facilitate porting legacy code to the new AARCH64 architecture. However,
> it appears that most legacy code is still used as ARMv7 (ARM 32-bit)
> binaries, running on ARM 64-bit CPUs through the 32-bit EL0 compatibility
> feature of those CPUs. As a result, the ILP32 ABI has not been widely
> adopted.

Firm "no" on adding this to the QEMU linux-user mode emulation
until/unless the ILP32 ABI is supported in mainline Linux
kernels, I'm afraid (which I do not expect it ever will be).

thanks
-- PMM

