Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0E606A33D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ikNgehVX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO9AD-000835-UB; Tue, 03 Nov 2026 02:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO9A9-00081v-MR
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:42:33 -0500
Received: from mail-dy2-x0a.google.com ([2607:f8b0:4864:36::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tewaro@theorem.dev>)
 id 1xO9A6-0007C6-UU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 02:42:33 -0500
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-35eaf84cc66so3592562eec.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 23:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1793691749; x=1794296549;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hBR3Q8/PVmi6xDuhh2qQoulPZ5gx8KQVVwhpxkXgPVg=;
 b=ikNgehVXpvR1zBSdJobEF9+gAGYL6PIMXy2ZxugP4Dniaxe3IM/lor46sbYWVylDQV
 5YDMDEbzyLVlxrKQ9HeYVEJGIvrl3V0nzbPprQy//5TQOmiLeFtlFT7XLOPS3Jys9bWv
 /yANZY8/q1RPkIDGSHaoBUE563faKU0TuFljVEjnKAqoLO46DV4bO2BKwUECbWG+G7uL
 XsXXD2SziGsSOTvIoS+stJOYPqdC29czi6vJaocC2DdRcDyGJPGXI11Ibxgub7aJaBtO
 9N5nmCpknoMf5F/OTo/2wy6QKSN4KA8pIGR6TuG0f+lkKqicrrpF05fmPKPGjm93rbKa
 v9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793691749; x=1794296549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hBR3Q8/PVmi6xDuhh2qQoulPZ5gx8KQVVwhpxkXgPVg=;
 b=ywJTxesM+Gdtm7W3JDvenv1cUoS0IXXAhGOOCepEwGx/2x7GcbKVIuOV9R8gdc+jDv
 egtgISgL6TL0Rcqn999faOzoWjB9pCJC7Lso0pp71z5hk2kBzPmgXBoOb3ou/hPu0ATD
 P/yxp2LFeLDXb96d9OFqwXpjJjdZrH2FLgJYQYYAPHA3GataHg3emlNlHJdP8hddn6iF
 Cr8yA5/PVnkKpAZa6dvyqJ4fQbWPcmtkhUBoI4QAgMkDNIfP/ycy0YiUEWHlq4N3wZ76
 4+cvYSPzqejjnC5dUXbXUaTgmcVnOTEl6iPdT6mtGWDoU3Vmij91Upq1ZKmulnK+0j+P
 u0Yw==
X-Gm-Message-State: APuU4Z/w2pM6uv8nhgjrY+RXwGFTmdEPM4SARKscBtuShWyCNwiN4ksf
 0RLvTHslYBg09R3aOwS0ueAxhLqh7Dqg/own5UavD7FjURPyHQBWwVone/cQxy0kezE+0BRg6yD
 ZUDWjZ+8E2RCE
X-Gm-Gg: AYBFou0WtmVdr1fqKuw21e33+fRPOX51+HR3Ol7vi7mW1qTfxlaqEayNXwcKylovero
 z8LUBqSV1F7mii2bSrHFsR+JkdR5qyEWetQporuLGJcINnvrAKz0167iJDuMdlLUbqrrXlSu/Vn
 ZESyGqN9xco7Wp1VlKfxPSVgjuqz4WYr9jVdWDLWumseqfwpQeApBLA954bd42DnG0VBgCQd6lK
 HSigCpX1SJJrKjIZ3IM3p4JL6XA3GcU6dQ+OrI1UIyBi5u7jInoSzvviDetquVqY3eE8ajjH/M9
 ImwNNojJHhRr/4vsInJq6UwnjabhhyP3q3KRZ9Oo8V0f/Z1rTTazJN2Xpe57b0jpn26S1AgjvBL
 AbG1n92j5R7m2KSXn1todFvRGneHl/MLV8nLOqihHaok5ZIDJlwok0/I9y6qAO1+c3ofciuxTfi
 fOpoe/scqP1bd5L2UmwYR0404B0RwXZMhATgFrO3lhIMSicnayFtB9CsCx/ENnMHOu6SXsQd0k+
 PNLcAZqXFo/OCnjUHfVyqZkwFTuom3gjBhqGoyfu4KOYvP4zcQduWi1nRE5i4lCYMRIFPf7grNu
 fhAQepFHu5uSAHtFEuexZsmrFusAPELeN0z2UXlxSqQgdAHJVQyApjFouNRDwfJuB/Ie+PI=
X-Received: by 2002:a05:693c:895c:10b0:369:f05d:6c5c with SMTP id
 5a478bee46e88-36a4240f66emr20018179eec.28.1793691748988; 
 Mon, 02 Nov 2026 23:42:28 -0800 (PST)
Received: from tewaros-MacBook-Pro.local
 ([2601:647:6300:1230:9da3:3d82:7292:c937])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a5fb97sm48742599eec.23.2026.11.02.23.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 23:42:28 -0800 (PST)
From: tewaro <tewaro@theorem.dev>
To: qemu-devel@nongnu.org
Cc: disclosures@theorem.dev, tewaro <tewaro@tewaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH 1/2] target/riscv: write mstatus.GVA on every trap into M-mode
Date: Mon,  2 Nov 2026 23:42:13 -0800
Message-ID: <9c108816bf40bd4023f23ecc32527a7fc92c1747.1793677944.git.tewaro@theorem.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793677945.git.tewaro@theorem.dev>
References: <cover.1793677945.git.tewaro@theorem.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::a;
 envelope-from=tewaro@theorem.dev; helo=mail-dy2-x0a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On every trap into M-mode, mstatus.GVA should be set to 1 if mtval
holds a guest virtual address and to 0 otherwise [1].
riscv_cpu_do_interrupt() only ever sets it, and only when V = 1 and
tval is nonzero. That has two effects:

- GVA is never cleared. After one guest-page fault, every later trap
  into M-mode, including an ecall, reports GVA = 1.
- GVA stays 0 when HLV, HLVX or HSV faults, because those run with
  V = 0. The spec names this case ("SPV=0 but GVA=1").

The HS-mode path already computes write_gva for hstatus.GVA. Use it
for mstatus.GVA too.

[1] Privileged ISA v1.12, 8.2.1
https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4594
Signed-off-by: tewaro <tewaro@theorem.dev>
---
 target/riscv/tcg/cpu_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 063525cfc5..55b370294a 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -2416,9 +2416,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             }
             env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
                                      env->virt_enabled);
-            if (env->virt_enabled && tval) {
-                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
-            }
+            env->mstatus = set_field(env->mstatus, MSTATUS_GVA, write_gva);
 
             mtval2 = env->guest_phys_fault_addr;
 
-- 
2.54.0 (Apple Git-157)


