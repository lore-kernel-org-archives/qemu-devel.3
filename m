Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F9606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFFo42SI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2HT-00058j-Ma; Thu, 05 Nov 2026 13:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2H7-00056M-Ab
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:33:27 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2H3-0007cH-NE
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:33:24 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-3514b90bb89so4244879eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793903600; x=1794508400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pkzSMe5TXc03KOVNMjdAF67pSs69m4jsQa6dvekI638=;
 b=XFFo42SIR6ISJSy0RP8j9drRki+oQyzGrJxB9htUci98zU1lS+BB+n7RyZjXTIkSwy
 DWgXhfYEsExpWFvyPYVqrCPUY835J5aPEg37xyNORIMgzNdx9Lclo3Vv+b0DZMUynWgg
 eKGjcagXh2O7WiDAuKJb28kJXa4UklIEZxZRhit9yOXUYSmw8F6JW3dQU/v2zCejC+41
 RGo2nR6aXRTFSetLmLB3Dx0sk+HWSpKPob4N5H597TGA9/lwbBKy0ivBA/EmX9duPkS4
 HN8U7b9erNwqI2WGhLHvguuIGcEoSHvtBHAygtyAaXoacuuAsXW6x9/6ViFSwJDVZRHp
 nM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903600; x=1794508400;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pkzSMe5TXc03KOVNMjdAF67pSs69m4jsQa6dvekI638=;
 b=gswLASiwbpXGCMjvWK4tk0IxGhbQ6f15UdFEOXQv75MiQ9dRGmkXrp1PMC4gakGNjt
 GAu4NEs7G1TEbjTptAjRQeIVrm9XfeveJb1xK4GqEuFoFVCU4obhwZjtgAKbC2zXJb+q
 NP3yoe/OCKBa3/I9PBHcvaWdVNuFM1EqahLL/yBE2OsyE5bgbBr/iGkFBNzUu3iLJ/nM
 10K2EOK1c1pAIu9UJ83B97tbn1zB1xpHRSx9Tnx3bKfvaPQFRldKCdC2kGcsMp1WjF2y
 Qgd4X9SXqXG1UqO73neRMwuWA57JpF6B6VDYcotRpLvsJviAeV0I6HYssxvAuaIylZYz
 dwbQ==
X-Gm-Message-State: APuU4Z9c1jgqjE994PJtJhM88/QYolNx0KeL/moT3m6SKMs0+qDhfHwH
 WoSDB8adpgB5WQyz/NCjmdLlU4ZL7Pzag9iav3itMq1IuehvOZPzKY3LYMpyBpDlUwQ=
X-Gm-Gg: AYBFou1w50BcVLS4VKKIbilp872w32grSdVHhevlP8vlr9pOQMReBXhqAA/lbY0Rb+R
 6aACtHiQUntcwWmqvorIOM0UT+1Okty5fQknlHt8gf9GLTRPcHa3YSPdef0f+vHzIoL98K77ozY
 SLKQ0I30yrcqVLRyAYA+1cagZ7LyXBE9w8qjcr4uXRIHhMO/ANgid6iR50m7tm0yU/+8wqCWKB7
 zZ1mazzK4xG/nFEamQgH29GFJXnzW5r76vLXqycct812E1FMLf1Z4hwg5RpxOEExm7wWDjTRiqf
 jjiqcxfYC+J1+P8XF7f+wgvOiPiRDVJJn4lUdC7IrSVh8AfS215ln45NOxUXJUdLujBjOmM2J4Z
 H0alhI205vwg8jt2Zo55ZXb5A/9Fp3Y/fgYCQkVhHIUo09l0/SFrHktxv4GYZsEGU50H9uJFANz
 S9kSaUGhfYTCvsVc2JxzqRUlySPFtUyI4+LZBrtrgE/PWe8DJa/i1WS54Ey8+ynE++puwhflAXf
 evgihftowUCdu1DFjk6Etj6nOn2lPx0A/Wc0vSMzugCL5LR9dCEHxSsTqIJ8l/d7EUR7+FEPxg0
 OO9TgGs9cNJkKJwBlcMpG2gb2nBRtMsOlOrqTQap4IBuDpKQnfN6+d0Dj5tjVCoRgCa52Q==
X-Received: by 2002:a05:693c:62ce:b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-36a42362451mr27729773eec.11.1793903599992; 
 Thu, 05 Nov 2026 10:33:19 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36f66086a4asm277795eec.0.2026.11.05.10.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:33:19 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 0/3] Register accel-$cpu_type for all targets
Date: Fri,  6 Nov 2026 02:33:06 +0800
Message-ID: <20261105183310.1614-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A multi-target system binary links more than one target.
accel_cpu_register_type() creates the abstract parent accel-$cpu_type for each
target that has an AccelCPU subclass. ARM, i386, RISC-V, and PowerPC call it.
Other targets have no such subclass, and machine init skips a missing class.

test-multi-target checks the parent only for the CPU types that register it.

This is an alternative to gating accelerator CPU types with is_available. The
RISC-V TCG and KVM gates are reverted here as redundant.

v3: https://lore.kernel.org/qemu-devel/20261031170925.789-1-luoyonggang@gmail.com/

Changes v3 -> v4:

- Drop accel-cpu-target.c and the once-per-TARGET_BASE_ARCH build. Register the
  parent with accel_cpu_register_type() only where an AccelCPU subclass exists
- Call it from ARM, i386, RISC-V, and PowerPC. v3 registered a parent for every
  linked target
- Check those parents from test_qom_types_are_unique(). v3 expected one for
  every target in the test

Yonggang Luo (3):
  accel: register CPU parent only for AccelCPU subclasses
  Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
    targets"
  Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
    targets"

 accel/accel-common.c           |  6 ++----
 include/accel/accel-cpu.h      |  2 ++
 target/arm/cpu.c               |  2 ++
 target/i386/cpu.c              |  2 ++
 target/ppc/cpu_init.c          |  2 ++
 target/riscv/cpu.c             |  8 ++++++++
 target/riscv/kvm/kvm-cpu.c     |  2 --
 target/riscv/tcg/tcg-cpu.c     |  1 -
 tests/unit/test-multi-target.c | 25 +++++++++++++++++++++++++
 9 files changed, 43 insertions(+), 7 deletions(-)

-- 
2.55.0.windows.3


