Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F04C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRC8f-0002Xn-MZ; Mon, 16 Jun 2025 11:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uRC8V-0002OC-QN; Mon, 16 Jun 2025 11:52:39 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uRC8S-00044M-9K; Mon, 16 Jun 2025 11:52:39 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei B20C17389
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1750089120;
 cv=none;
 b=AsG7YFQQWVqR6a2Uc5LrKDmiiLeOS+Xo3D5TvWdAsFTJ/Z/O9qkRIQ8e37DlVJaZynsHqekehc0ZXD/QJDjXBwk+VilWM7SeBN4VOg8V409nYkOpZviSj4K1crXxYkVDoBbhVXip4Xdk7kVNW2Pupdz4rs2Hphy8A7VhOG+7ZL/RZXjBeOY29jCpUNfkvV8tBbiXVzm3NKvbPLpawQUAaVcdTm3JxurmBgngmH+FGYXyVrBddOwfDNryf/sKJ9zlbiG+h+IUIUNljrZqmKxpF8Ta7J2wP/Mr1lXp+TzvJMqrj3j3ny5RjcMU1vTS6XoHsN/+UD6VXhr6oIonEWUkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1750089120; c=relaxed/simple;
 bh=xwjkPl8NeSHmZR6/B86A6bnYGCIQGsZXeJmjL1O1fWw=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=rl1eDOiOJov0p8fEBfVun2ynnI1G/K2sDxJgQlMYUx7x85IRT6ln7gdD4WykS+ifVx1hWjUnMT/48dXvP3zIzGuObSl8FwKL2y2Upts0M5ab3TpYxMC1YRiUzPiqscCco+tSKyfbxWZkXNbZgHsJ3HXJDChOfcO0JwURqETITw0IGg04gA8zDyI+KTLETbIWFucn8W1lANziGmHQCJAd4J/GQ2jqzCBEUI0+SQu0ah9EKaN9dN8fRrwOU/HdQUQnl0wZeplbqCzEr09BDOsM6XNHfPEZJcXZfkfKH/cty69Vu5UI0xi9RuG21vwWKc8h3kYOUxKtkpKFIlIqk8cB0w==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750089119;
 bh=xwjkPl8NeSHmZR6/B86A6bnYGCIQGsZXeJmjL1O1fWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UB32phdYayN4xdsvinvny+ll6lGzs/Mre+6v5ZjTIPNBFx5P8oBtDZMYjsDU8Q2B9
 gK+jjkZ5XJvEPUkgFOJ6knfqyrydw0MStoigOaXYFwCcX68RzoO31bYDaIw9hKpUGl
 W5uXhZ3As0ExsBNarmNPJVd+aVNomd6a8efe8EDYW5tLZmMHGv/Lbam9wq93xhKLtt
 ptPJCXgvDkw7zVHvTHdW6OFwoW0kikJU9fMHN5gmmX7lbo4h/CJuFMU4tNEZ2vyfAB
 AZQwOTh1KcS9ZCyMZ/nLh5yvEJrnxXLEtdrX3q/MjaqV8wrfXXgBsA04nJ/QvH3SuQ
 t1x2Xjqc5mLVg==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id B20C17389;
 Mon, 16 Jun 2025 23:51:55 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 6/6] treewide: fix paths for relocated files in comments
Date: Mon, 16 Jun 2025 11:51:30 -0400
Message-ID: <20250616.qemu.relocated.06@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616.qemu.relocated@sean.taipei>
References: <20250616.qemu.relocated@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After the docs directory restructuring, several comments
refer to paths that no longer exist.

Replace these references to the current file locations
so readers can find the correct files.

Related commits
---------------

  189c099f75f (Jul 2021)
    docs: collect the disparate device emulation docs into one section
    Rename  docs/system/{ => devices}/nvme.rst

  5f4c96b779f (Feb 2023)
    docs/system/loongarch: update loongson3.rst and rename it to virt.rst
    Rename  docs/system/loongarch/{loongson3.rst => virt.rst}

  fe0007f3c1d (Sep 2023)
    exec: Rename cpu.c -> cpu-target.c
    Rename  cpus-common.c => cpu-common.c

  42fa9665e59 (Apr 2025)
    exec: Restrict 'cpu_ldst.h' to accel/tcg/
    Rename  include/{exec/cpu_ldst.h => accel/tcg/cpu-ldst.h}

Signed-off-by: Sean Wei <me@sean.taipei>
---
 docs/spin/tcg-exclusive.promela | 4 ++--
 hw/nvme/ctrl.c                  | 2 +-
 target/arm/cpu.c                | 2 +-
 target/loongarch/README         | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/spin/tcg-exclusive.promela b/docs/spin/tcg-exclusive.promela
index c91cfca9f7..1d03af850b 100644
--- a/docs/spin/tcg-exclusive.promela
+++ b/docs/spin/tcg-exclusive.promela
@@ -1,6 +1,6 @@
 /*
  * This model describes the implementation of exclusive sections in
- * cpus-common.c (start_exclusive, end_exclusive, cpu_exec_start,
+ * cpu-common.c (start_exclusive, end_exclusive, cpu_exec_start,
  * cpu_exec_end).
  *
  * Author: Paolo Bonzini <pbonzini@redhat.com>
@@ -65,7 +65,7 @@
                              }
 #define COND_BROADCAST(c)    c++
 
-// this is the logic from cpus-common.c
+// this is the logic from cpu-common.c
 
 mutex_t mutex;
 cond_t exclusive_cond;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd935507bc..5810bfbe7a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -22,7 +22,7 @@
  *
  * Usage
  * -----
- * See docs/system/nvme.rst for extensive documentation.
+ * See docs/system/devices/nvme.rst for extensive documentation.
  *
  * Add options:
  *      -drive file=<file>,if=none,id=<drive_id>
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e025e241ed..90cf924938 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2672,7 +2672,7 @@ static const char *arm_gdb_get_core_xml_file(CPUState *cs)
  * linux syscall TIF_TAGGED_ADDR setting, not TBI in general.
  *
  * There should be a better place to put this, but we need this in
- * include/exec/cpu_ldst.h, and not some place linux-user specific.
+ * include/accel/tcg/cpu-ldst.h, and not some place linux-user specific.
  *
  * Note that arm-*-user will never set tagged_addr_enable.
  */
diff --git a/target/loongarch/README b/target/loongarch/README
index 0b9dc0d40a..1ffd3422d2 100644
--- a/target/loongarch/README
+++ b/target/loongarch/README
@@ -11,7 +11,7 @@
 
 - System emulation
 
-  You can reference docs/system/loongarch/loongson3.rst to get the information about system emulation of LoongArch.
+  You can reference docs/system/loongarch/virt.rst to get the information about system emulation of LoongArch.
 
 - Linux-user emulation
 
-- 
2.49.0


