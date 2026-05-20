Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D04CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgfd-0005Qz-LA; Wed, 20 May 2026 09:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgfO-0005BB-5w; Wed, 20 May 2026 09:08:55 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgfM-00015K-CA; Wed, 20 May 2026 09:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=LC9bKd4Qtj1tEl3bYbyNA60x+Rpmdf4R4qYkGxNHFPw=; b=I/LdRPl05wzeuK9
 7infxsGxuc9Jo+96yj02dBNCiKqH134M9gqpnoNCqLwas5BQIQo7/MbVcMIdmrBlU50hxaEt0JRdl
 PWfzf9m6NTA+irD7zMcv1Kay71vGvswbI5hZXDZ2Ga4YyNRkbAvtF+ZIfBafWI7ALE8++kT1lsDts
 Gc=;
Date: Wed, 20 May 2026 15:13:04 +0200
Subject: [PATCH v3 12/14] target/riscv: Move target_long.h inclusion away
 from cpu.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-12-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=947;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=WNPVJcGZF9fEBox/zQpjXcWF3BpmjENPAtKaUoqTTLY=;
 b=HlCioW3nikMMMXOCaknk2MsXdOgACokTRR/Kpj5aROuej61kZMwTByD+9n5IqIeHjP3v3o9zD
 GRboYptnP8wBtC/6o229XTwYDqP+K5j1PR5zQUGw4lEWx6L9s1IyQ1K
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h       | 1 -
 target/riscv/internals.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 78b4f47d2d..0c96bb73da 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -26,7 +26,6 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
-#include "exec/target_long.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
 #include "qemu/int128.h"
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index e143a86f97..f2644eb3b6 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -20,6 +20,7 @@
 #define RISCV_CPU_INTERNALS_H
 
 #include "exec/cpu-common.h"
+#include "exec/target_long.h"
 #include "hw/core/registerfields.h"
 #include "fpu/softfloat-types.h"
 #include "target/riscv/cpu_bits.h"

-- 
2.52.0


