Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97B6CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcuc-0000Lw-0m; Fri, 21 Nov 2025 20:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbwJ-0007Kk-9A
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:57:24 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbw9-0001br-Lj
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:57:21 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so4432895a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763773011; x=1764377811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iLEP31p2q67fyTZDvOclkWnM5THQY23jVRVbitVYWqI=;
 b=j9oHgxxSApHP/bbVcmcjTCsG9fD6GuOSkpm0dMjHqVPn84VPgy7/bBSsqRCbvSY7G1
 Ck5v5C4e4uxdg0otgrTGLyx3XzVOhgtnX9BMlHvGGwBoOek9d8XMMiZUNJnUVyLYKTRK
 h92p7kZBe7MNTqoUZpNC+03Lf6DNgADWcMkpdrd75NAmJeS5lAXkCRtORnen4xbnSQOM
 Ojirm+Evjqo4oo5IxnpaxzvTvuhLvk7DSM7F8EHRCjHaxgldGKbuQfth4JOkaiTw/abw
 rHwd/yQfkeezkfsZqd7qQ/FzV/6k30Gtg5JC/5G5/Z+dB0+icLT1ksNOBrVK5dN5uPhQ
 6Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763773011; x=1764377811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLEP31p2q67fyTZDvOclkWnM5THQY23jVRVbitVYWqI=;
 b=RZOc4YyqCDiBWiR2kil+iQBhc9d5Rp2yWRMf5Mv58hm4RFGoEBgFa9ecuQKAqhX9mC
 43L7wEI7LLSdd45FfZkqYV+Jv1rOHmJZ3tC14U4U9QYnAqdwSjpK08baodl2Z0czF8al
 kKYbYV2Ttj+UB6lRQHKlf5ho2ytK1FPT3K7ktgbMa36hoP0YE3hO2ESGzhxN74Ofa7/Q
 peXetwZJaesEdrcRxS+7Ayz8//yuP9BsMFZ3QqSu+Lx3iw+hXn06Zn2IBrkUaM19zx27
 asvDcxpM2zFnDZ51GB6UV5jz8lDyaEjq+Pftc1YOpSinVHmrz0Kx/0vLyhK8FXLQwAy+
 bIFw==
X-Gm-Message-State: AOJu0YxEWPmfSigvPGts42EBCuK7jro0I2yj+BzQ4BCLz5R1E3OdaZI8
 TkdQO9XHrWQO8zadVaYyB4vAWJak5EFrVpoNBphw61w6udWU/qW2y54xdadQmN2b+uu/xUZcveS
 DskSc/k1K/A==
X-Gm-Gg: ASbGncvPbTGH0swp7WgDM3FfWBaek3oMebdarizKvATw4+3TChsGa8FhLWsMD9lnhJa
 N9+nt3VFuVDM0oxdzIGc6vwDt229RPNPnMZKWceU/LxadatXJFVuz1EvjpDRaP/1Dzob6nZ6icD
 QFROjpCgLLdS8EtKlaxp76j8Xw87e6m0PUTQh1iFm49Qrfb5sMRmT0or5bB93giFSmIkI4UcJVJ
 sakNX2p10mSlWeVrftCLWt2jfYI5dU2VRM4jEXSzi8aM0SdNjEckSnigA8dhqmTTrIdGSqLue+T
 UD7ptzTUl18lb/RZ5NPCdvpU7YjT/+DnlsCa+1l+CnCju52dT1k96dxGOqCaVyv0x+Z9H5DVTi5
 VP2QnysH2IBoLqwBVO6Ajivj9YjnVmA6UqbfMNkYkUttWI/IWQV1KXS8dxPX/VbN0tCcSTvD3MB
 YcQS2rYrgm9qQwVRlj5VcfbwTGc+O2tIXG4OeWT0qETQr+/ltCxDZ/VIRjy6T0
X-Google-Smtp-Source: AGHT+IHWcb4RKS7iqER8mCdDuj0STip9RUovE2X2+ev2r6OYPEl8ZKJV/LvXwo1MwRvs07MDSpLMUw==
X-Received: by 2002:a05:600c:3b05:b0:475:e007:baf1 with SMTP id
 5b1f17b1804b1-477c1133955mr21845385e9.34.1763732705088; 
 Fri, 21 Nov 2025 05:45:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba201sm11207379f8f.32.2025.11.21.05.45.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 00/21] accel/tcg: Remove most MO_TE uses in
 cpu_ld/st_code/data()
Date: Fri, 21 Nov 2025 14:44:42 +0100
Message-ID: <20251121134503.30914-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Quick attempt to remove MO_TE uses for fixed-endianness targets.

v3: convert all CODE uses, almost all DATA uses (except PPC/MIPS).
v2: convert all but mips targets and remove unexplicit API.

Superseeded: <20251120201919.8460-1-philmd@linaro.org>

Philippe Mathieu-Daudé (21):
  accel/tcg: Add endianness variants of cpu_ld{uw,l,q}_code()
  target/alpha: Use little-endian variant of cpu_ldl_code()
  target/loongarch: Use little-endian variant of cpu_ldl_code()
  target/sparc: Use big-endian variant of cpu_ldl_code()
  target/s390x: Use big-endian variant of cpu_ld{uw,l}_code()
  target/riscv: Use little-endian variant of cpu_ld{l,q}_code()
  target/ppc: Replace cpu_ldl_code() by explicit endianness variants
  target/mips: Replace cpu_ld{uw,l}_code() by explicit endianness
    variants
  accel/tcg: Remove non-explicit endian cpu_ld*_code() helpers
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  target/tricore: Use little-endian variant of cpu_ld/st_data*()
  target/rx: Use little-endian variant of cpu_ld/st_data*()
  target/m68k: Use little-endian variant of cpu_ld/st_data*()
  target/s390x: Use little-endian variant of cpu_ld/st_data*()
  target/sparc: Use little-endian variant of cpu_ld/st_data*()
  target/i386: Use little-endian variant of cpu_ld/st_data*()
  target/hppa: Use little-endian variant of cpu_ld/st_data*()
  target/riscv: Use little-endian variant of cpu_ld/st_data*() for
    vector
  target/sh4: Replace cpu_stl_data() by explicit endianness variants
  target/mips: Use big-endian variant of cpu_ld/st_data*() for MSA
  accel/tcg: Remove non-explicit endian cpu_ld/st*_data*() helpers

 include/accel/tcg/cpu-ldst.h         |  79 +++++---------
 target/hexagon/macros.h              |   6 +-
 target/i386/ops_sse.h                |  12 +--
 target/i386/tcg/seg_helper.h         |  12 +--
 linux-user/vm86.c                    |   4 +-
 target/alpha/mem_helper.c            |   2 +-
 target/hexagon/op_helper.c           |   6 +-
 target/hppa/op_helper.c              |  44 ++++----
 target/i386/tcg/mem_helper.c         |   8 +-
 target/i386/tcg/mpx_helper.c         |  28 ++---
 target/i386/tcg/seg_helper.c         |  16 +--
 target/i386/tcg/system/excp_helper.c |   8 +-
 target/i386/tcg/system/svm_helper.c  |  48 ++++-----
 target/loongarch/tcg/tcg_cpu.c       |   2 +-
 target/m68k/fpu_helper.c             |  12 +--
 target/m68k/op_helper.c              |  88 ++++++++--------
 target/mips/tcg/msa_helper.c         |  51 +++++----
 target/mips/tcg/system/tlb_helper.c  |  22 +++-
 target/ppc/tcg-excp_helper.c         |  16 +--
 target/riscv/translate.c             |   2 +-
 target/riscv/vector_helper.c         |  12 +--
 target/riscv/zce_helper.c            |   4 +-
 target/rx/helper.c                   |  14 +--
 target/rx/op_helper.c                |   6 +-
 target/s390x/tcg/mem_helper.c        |  54 +++++-----
 target/s390x/tcg/vec_helper.c        |   8 +-
 target/sh4/op_helper.c               |   6 +-
 target/sparc/int32_helper.c          |   2 +-
 target/sparc/ldst_helper.c           |   6 +-
 target/tricore/op_helper.c           | 152 +++++++++++++--------------
 30 files changed, 360 insertions(+), 370 deletions(-)

-- 
2.51.0


