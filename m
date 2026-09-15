Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B6DC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vax-0007TU-Ec; Tue, 15 Sep 2026 12:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vav-0007Ou-Du
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:17 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vat-0003NF-Ev
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:16 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f55efe7so486436966b.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488074; x=1790092874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kzY3C97Ry7/KN1BDc2Cc436tkZ6bbNabswQ4SxnVX1o=;
 b=H1Xl1SOY5k2qryqatXRiKIfEl1V8lMXZaeFDio0Wq/2i2Yop8n4HgRtZaCTypv7uuS
 jWU+HQ0IJj8wEij7mjFUCfCFK/g6ItrK9RKJxKp5Ox4BI5ZMify0eG1VBYjxsZUgyFHu
 yHxSpQISep3oQtALXAg/kV1pyWz2w7H69mCLiiiJwGGxEPV6eQlUsAWpf6vCxMZTrj71
 pmzJoOzjwUTpdcZmHhKK7cLrj1353bCc2G2KULlZI110gGSdf/yqny6bBBs5cU/RxlVf
 CnEHq7HMOB6KtCMY42O0qbtU82TXfcF3Vr4sScoT2ds9hmHYYWYrWZCXu2MYhexmQkZc
 PA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488074; x=1790092874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kzY3C97Ry7/KN1BDc2Cc436tkZ6bbNabswQ4SxnVX1o=;
 b=r99eVy3WrEj6D2tsFf8GJ1BzS6S6rfrzI65fH42Z99ftdmiMKoBvSAE0LgaEcTgKhG
 mGe3GZ3eplabrQWIIFYeHpHvajfklGffZQGj6mrv9bulQ6+EmpjoMwte+ixOY+eza9Gi
 pOc3BREA6JeQEZMFl3Waa5ToDr9BBULQKj/eQ9O4YKIntgZ/+YylaSrx0u4ljetWX3mP
 k45bB9lnBYblaBZ6HKQJvHvnM5oviOGDlnlTRCiBGAmniuRdHN8BMFeuE+HSameF36ju
 OFC81M/+0Wv9F+BPSs1NAFRC1NSOI2qFzmAd5l8xIljCqwcA7g/diZ/jCCmXrrkslCJS
 CoQQ==
X-Gm-Message-State: AFuF++kFLhbxN3aai8vJij8XXBGzF5M2HXHrpF/IvQPZ5oDn6ISczHRb
 gsNuFrf6TFPV2kNL1TO9lUur83Tpm6D4wj22o3tPzf2X1YROIAFGbgc11/YCqg==
X-Gm-Gg: AYBFou2cDnO2bZACJfhWDktUix6jrR2fbFT5VbCnTcqIZnYHLl22BGMnRdpFwSnmZ92
 1qH45cqNf9qun35feO06abnA094oeXlaQFi2GDUR+CvzApiUMCSaoHq54Hau0B2UT5DElP7awjc
 qTrLfnQwTDv6TmWl43+RDHT4ynJNaJ+7ofRxT6RX/VAEoiddWYaTevd33eChsu/p+vQl2+Q8CG4
 PTWs5wVxruPm0Xar3ji20/60b2RBfJAguoTpANTrJtIVwQ/HBWHYAJUjErOm+tgLthQCz2R7a9G
 q9p8GhudIWWbc5B45zhYKupKML8vfBCEUw9yHnu34SWWJEiAqb3hfq+38JWetdGhv3/o4uO/VNG
 L/s9XhfkDrjcI9OfF95dWSxJJ6ftzXosSzdEZtovjrM3/p91GEj81lRw6gNzmEHEvF/lKCz91+p
 PioR+TL9sKZUJryiBwde9HBSDYIuOHW36rirGCAJpYJA/YQKeKLe6Fl9RJpiHzv0ORNcznlyD27
 CEc7LNWLhMMhoYCe4RJeus7D1pwnnQdMNNqO7M8vExokw==
X-Received: by 2002:a17:906:6a23:b0:c16:66dc:3ab7 with SMTP id
 a640c23a62f3a-c29b84c99fbmr513031866b.10.1789488073831; 
 Tue, 15 Sep 2026 09:01:13 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:13 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 02/20] hw/core: Add Remote Port header helpers
Date: Tue, 15 Sep 2026 18:00:26 +0200
Message-ID: <20260915160044.345788-3-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

Preserved existing MIT license for hw/core/remote-port-proto.c.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-proto.c         | 83 +++++++++++++++++++++++++++++
 include/hw/core/remote-port-proto.h |  8 +++
 2 files changed, 91 insertions(+)
 create mode 100644 hw/core/remote-port-proto.c

diff --git a/hw/core/remote-port-proto.c b/hw/core/remote-port-proto.c
new file mode 100644
index 0000000000..fed52a9734
--- /dev/null
+++ b/hw/core/remote-port-proto.c
@@ -0,0 +1,83 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
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
index 16f3752877..f7995ff430 100644
--- a/include/hw/core/remote-port-proto.h
+++ b/include/hw/core/remote-port-proto.h
@@ -296,4 +296,12 @@ struct rp_pkt {
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


