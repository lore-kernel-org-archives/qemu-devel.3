Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C43ECD997
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 19:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5V4-0006Vo-LH; Thu, 05 Feb 2026 14:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V3-0006Ul-45
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:49 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5V0-00031D-Im
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:48 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-436263e31abso778958f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321525; x=1770926325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BL6hmjytF8QyzFqPZLkSXIPl8zzLGZ1QoCPt5JE4jcA=;
 b=ZwJ2DNRhtQhXxdb80GzZC8fIJ0SDRPRLs16MxcAvJJ2691WREWrZlHpDnWKe5LsOFy
 uPkpx9YmHQxIOTbGCjxaJfbHBZlKlrvsHz3OstIV+ef6MTQZXuwBS/ea/lacXSrtumIm
 3RJ4O4R6TBvEuqBGQNpc4536vryETcsFKZ8XElthn9EkscEN+oCHxnOph/nwOZr4Rcvs
 hIJ0qX6mWcwtX9bM4yjdquWwsy0L3Yx9V/Kj884QRd5YsF/05P2B14VJtHKFaU86uFZy
 G3xjD8IC9AdYgpItn4wCnTtKixmlApVxsrkTxrNGEPUMrrobNoSAu1TGkkouq/j5Vx0U
 iX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321525; x=1770926325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BL6hmjytF8QyzFqPZLkSXIPl8zzLGZ1QoCPt5JE4jcA=;
 b=IjyUccJEdG/+6KCLGlebfTMecbXNao0PrV74TGDA7nwYgLR6oG3TGolGrnEqW4S61M
 jTULDp0Ky7ED9n/daEpFXH66oYtOB/HNd5lErXoP8KC/PzkDeED8K0aaphyeUv5+Gooc
 qr7esf2kITq01K+32iEt7NdYEmdWwynP4CfQynbt5a9O7e0WFbWl8S7DsF72eaUCM8v/
 jz4oLIwEzwi9z0zgaboeCA9m82t203PwkpinXjGsTEefQdKt4eV/C/rzk1QYEsH0rHxy
 eBa8MMdowBpF1PVJ3LgsD39+qNgjWnD9CGsfAUbddcDoMiS87SiFaZU8BzIAjnXqQ3aw
 g93A==
X-Gm-Message-State: AOJu0YzBfAF37JKBxDleJSjnzr47sp7vWxL+Kw/i8nR5m8SmxwgIREH9
 mQuq3HSr+UO7UncE4V/4V1wsRjeQBeu3RUPnblryK1QjkqRNMF7G98NDqPhp9HGOgKs=
X-Gm-Gg: AZuq6aLWKyo88UdLtkrHtybeFc3EqZq4g9jTMpMUbtopeQAMPeaSlxJAntpNqi8oJhP
 FGP0uPiTZ1r8uuGRpKDqr+GHn0HmZXjTLlwhyst9px0W2eyDVgUwzpgiDf/Lr/nzv8SLiuF2dwE
 UJFKYR23gjM0q45UzXrAc2c+cgJE0/4qrhxPk1IW6EDEG8NM86vNri12oqLp3xK4UB4BCrD5lCu
 mtupfOeaUjJzNDr9BwZj7dWrdtrejU8v3uG59d3eCZJORLjkF6bZYyJTGqGPSEbVUm6nHwkJxH0
 TmzzT1XHIEOFCJAAWO1vqGqbU07L/qaGTlzJXt2vJGe6XYYK04qV0EVf/uWr+1zOWYDglNYBNCp
 toDkz8dmV5oQXsGcx/g0Ve18+PLDfbwFGVCrY61r7+K9VpXKK7EGoSx5CHdWPyqUlARHwCYKsEN
 Y6k9IKqqJWF+h76wUDI1Y=
X-Received: by 2002:a05:6000:250f:b0:435:bbda:3f4e with SMTP id
 ffacd0b85a97d-4362938b19bmr694535f8f.31.1770321524708; 
 Thu, 05 Feb 2026 11:58:44 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:44 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 02/29] hw/core: Add Remote Port header helpers
Date: Thu,  5 Feb 2026 20:57:57 +0100
Message-ID: <20260205195824.2610192-3-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce core packet handling logic for Remote Port
protocol. This includes helpers for encoding and decoding
packet headers and payload.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-proto.c         | 82 +++++++++++++++++++++++++++++
 include/hw/core/remote-port-proto.h |  8 +++
 2 files changed, 90 insertions(+)
 create mode 100644 hw/core/remote-port-proto.c

diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
new file mode 100644
index 0000000000..1653fe7b78
--- /dev/null
+++ b/hw/core/remote-port-proto.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Remote-port protocol
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "hw/core/remote-port-proto.h"
+
+static const char *rp_cmd_names[RP_CMD_max + 1] = {
+    [RP_CMD_nop] = "nop",
+    [RP_CMD_hello] = "hello",
+    [RP_CMD_cfg] = "cfg",
+    [RP_CMD_read] = "read",
+    [RP_CMD_write] = "write",
+    [RP_CMD_interrupt] = "interrupt",
+    [RP_CMD_sync] = "sync",
+    [RP_CMD_ats_req] = "ats_request",
+    [RP_CMD_ats_inv] = "ats_invalidation",
+};
+
+const char *rp_cmd_to_string(enum rp_cmd cmd)
+{
+    assert(cmd <= RP_CMD_max);
+    return rp_cmd_names[cmd];
+}
+
+int rp_decode_hdr(struct rp_pkt *pkt)
+{
+    int used = 0;
+
+    pkt->hdr.cmd = be32_to_cpu(pkt->hdr.cmd);
+    pkt->hdr.len = be32_to_cpu(pkt->hdr.len);
+    pkt->hdr.id = be32_to_cpu(pkt->hdr.id);
+    pkt->hdr.flags = be32_to_cpu(pkt->hdr.flags);
+    pkt->hdr.dev = be32_to_cpu(pkt->hdr.dev);
+    used += sizeof pkt->hdr;
+    return used;
+}
+
+int rp_decode_payload(struct rp_pkt *pkt)
+{
+    int used = 0;
+
+    switch (pkt->hdr.cmd) {
+    /* TBD */
+    default:
+        break;
+    }
+    return used;
+}
+
+void rp_encode_hdr(struct rp_pkt_hdr *hdr, uint32_t cmd, uint32_t id,
+                   uint32_t dev, uint32_t len, uint32_t flags)
+{
+    hdr->cmd = cpu_to_be32(cmd);
+    hdr->len = cpu_to_be32(len);
+    hdr->id = cpu_to_be32(id);
+    hdr->dev = cpu_to_be32(dev);
+    hdr->flags = cpu_to_be32(flags);
+}
diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
index cbe1498df0..1d8e1b25da 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -302,4 +302,12 @@ struct rp_pkt {
     };
 };
 
+const char *rp_cmd_to_string(enum rp_cmd cmd);
+int rp_decode_hdr(struct rp_pkt *pkt);
+int rp_decode_payload(struct rp_pkt *pkt);
+
+void rp_encode_hdr(struct rp_pkt_hdr *hdr,
+                   uint32_t cmd, uint32_t id, uint32_t dev, uint32_t len,
+                   uint32_t flags);
+
 #endif
-- 
2.43.0


