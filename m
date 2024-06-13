Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB8EC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHobl-00072e-Hx; Thu, 13 Jun 2024 13:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobk-00072N-28
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sHobh-0002bU-Sl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:51:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f32a3b9491so12758525ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718301088; x=1718905888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8autl19bVxJ1EmNApzpMe0+seS7D389FfkBNh56MRQ4=;
 b=TlWLCpmu8Z0Fun7C4oRUVc3MjM1aqUyj034vGJnVZWevweKCpdubceq7Zx12ybqydu
 qTF57Tnzc5CYJdSjhukysOuR/8s9se6/ZLmwSrArpV4jsy65IWNXXy0/V3cGRTfHA6cO
 p/2/RJ09pmOtEvKMDjaJqaMFpg9j0XZJYZZVOOlw0knOwSvszU9Juwex2XQrDF9rIq4k
 44T0xYmS7pYeJTl4Q3ki80ln0d/HbL7DvZsKgqEYCBoVxf3S1EX8MdZYg2RuwSgGK90J
 VbHAsKpy37JXX1aAb+7KKnc3edsdLsgwoZ/KDRgyXEij+GHntee/KdifKzi76e3Rh0UR
 frEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718301088; x=1718905888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8autl19bVxJ1EmNApzpMe0+seS7D389FfkBNh56MRQ4=;
 b=w/R6NC+SVkPhvJvROGupI8aPQz7+ImRIdomuwWSV8LO4E8yh/Vf7Fn7FVgdBb8U201
 4JGdOEPCoK4y8uElkrhWkjHRNz/FVeQuJwJVKo6QzTnZKpWOLox48Tp97b7YWNsa5Rzv
 ELp+LLQWv0WMs1msvp2FarN0PPwWKVADH2XzB9Mn9XKrI4ttxlBJiE9m3r8cJdKfApf4
 EtuH10aTQiSWO9TDNbOHMVhd0vwmu4olD5K19oNe7a68GcbV/53tT6Vekn12oHoJnGQH
 Z/cajGLulJNId2Cw3pXlk6KDvKQi8/kxbS2t1aaCMtsfQbcXbZctYTvaUHGlsZa8zYx9
 91nw==
X-Gm-Message-State: AOJu0Yytw40u6ah4xfyumPIpsKGtat1dCQiXe6OpvPaOni/EtUdpI8KE
 iUF+XRlzz8S6R+xcrHgQs2g5I89MeLSEOcf2aKbdsSRfoh2DGPVWQvQq8dzfXq6slJGIiXZ8Jpl
 DMk9O8TASm5wCI65uPxYE0yIu0+TXwvTWu87JK4ubm1LvMyfy0yalv0tjwTOOPqGdS4KQ0FAmqE
 E3xOQcsFDD+W8SO+BIh0KDG/23Njrh4hMobgf/Yw==
X-Google-Smtp-Source: AGHT+IHVwF2x0AzJbT8r6OD3FiGli4d4zXZyCjdK4Y3v3vUto3NO1y5AjoRK2Vqz0UVd12bmDKXMUg==
X-Received: by 2002:a17:902:b18b:b0:1f7:3a4:f669 with SMTP id
 d9443c01a7336-1f862a13d03mr3186495ad.69.1718301088193; 
 Thu, 13 Jun 2024 10:51:28 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55d7dsm16780865ad.14.2024.06.13.10.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:51:27 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 0/5] Improve the performance of RISC-V vector
 unit-stride/whole register ld/st instructions
Date: Fri, 14 Jun 2024 01:51:17 +0800
Message-Id: <20240613175122.1299212-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

Sorry for the quick update the version, this version fixes the
cross-page probe checking bug that I forgot to apply to the v3 version.

This RFC patch set tries to fix the issue of
https://gitlab.com/qemu-project/qemu/-/issues/2137.

In this RFC, we added patches that
1. Provide a fast path to direct access the host ram for some vector
   load/store instructions (e.g. unmasked vector unit-stride load/store
   instructions) and perform virtual address resolution once for the
   entire vector at beginning of helper function. (Thanks for Richard
   Henderson's suggestion)
2. Replace the group elements load/store TCG ops by the group element
   load/store flow in helper functions with some assumption (e.g. no
   masking, continuous memory load/store, the endian of host and guest
   architecture are the same). (Thanks for Richard Henderson's
   suggestion)
3. Try inline the vector load/store related functions that corresponding
   most of the execution time.

This version can improve the performance of the test case provided in
https://gitlab.com/qemu-project/qemu/-/issues/2137#note_1757501369
- QEMU user mode (vlen=512): from ~51.8 sec. to ~4.5 sec.
- QEMU system mode (vlen=512): from ~125.6 sec to ~6.6 sec.

This RFC is tested with SPEC CPU2006 with test input.
We will try to measure the performance on SPEC CPU2006 benchmarks.

Series based on riscv-to-apply.next branch (commit d82f37f).

Changes from v3:
- patch 2
    - Modify vext_cont_ldst_pages for corss-page checking
- patch 3
    - Modify vext_ldst_whole for vext_cont_ldst_pages

Previous version:
- v1: https://lore.kernel.org/all/20240215192823.729209-1-max.chou@sifive.com/
- v2: https://lore.kernel.org/all/20240531174504.281461-1-max.chou@sifive.com/
- v3: https://lore.kernel.org/all/20240613141906.1276105-1-max.chou@sifive.com/

Max Chou (5):
  accel/tcg: Avoid unnecessary call overhead from
    qemu_plugin_vcpu_mem_cb
  target/riscv: rvv: Provide a fast path using direct access to host ram
    for unmasked unit-stride load/store
  target/riscv: rvv: Provide a fast path using direct access to host ram
    for unit-stride whole register load/store
  target/riscv: rvv: Provide group continuous ld/st flow for unit-stride
    ld/st instructions
  target/riscv: Inline unit-stride ld/st and corresponding functions for
    performance

 accel/tcg/ldst_common.c.inc             |   8 +-
 target/riscv/insn_trans/trans_rvv.c.inc |   3 +
 target/riscv/vector_helper.c            | 854 +++++++++++++++++++-----
 target/riscv/vector_internals.h         |  48 ++
 4 files changed, 745 insertions(+), 168 deletions(-)

-- 
2.34.1


