Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9373FCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQoU-00048I-Ow; Wed, 10 Jun 2026 17:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eduardoaugustoabc@gmail.com>)
 id 1wXQiv-0002Ss-Jn
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:44:33 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eduardoaugustoabc@gmail.com>)
 id 1wXQis-0005Tv-KL
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:44:33 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-51788280e71so78505751cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781127869; x=1781732669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dlv+8Imj57oONK12MPkAjhVurrOAgyR3W0zf0Sr0KSo=;
 b=UPc2I8NxS9bhnnDGPBVQWXkSZ+TqxPuv2yAKVpuBaFfQMN8UNYniC7WVwKQrMaT9Hj
 rnHcIEtkVOq9MVGTuL0ICh1NJ/bnHtFqqxkMDc+t+vaT/RgusqliFcYoUt3siJ8nf3Fw
 G/H0VZH8NOJTjA4F1JrvE7pJS7GjQCp1yNfwvRvt/ZaP4sosnVOw73aczoMgqMbUW4OH
 1y4zq1a0OtvBEsqy3HW2mZJA4vuPvHXOu91sGLQaXKCNTDphs/GSCE4fKJgvSu3xHIJK
 mLJxOnqVFUV4erBbDl+ZSED65koZBVz4/KM6qd6bW6AgfTILLfEGThN1TyzeFdidLD0t
 9VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127869; x=1781732669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlv+8Imj57oONK12MPkAjhVurrOAgyR3W0zf0Sr0KSo=;
 b=QdGCxK9B/yXJKvB5qgNh1vprWYOJM8J3ymvX45nZq4Q2AVYd3Pq0UFDZjVHkrRlgtw
 1nPL4h9AXjc3fXVKMHAAGAIZSlFf0OnnEJtz0NZWu72kGuN5DcEjW6jUgPOaKyGRaW8P
 2xIkVRGFFpOFDrNeKsZSlyS9IEtlwruc6Kp+O+wGFIg49Se/8Uptu9S94q1/eKJ4WGiE
 NY9zPvuvGEfOzRyqi5KXvUcyFT//C/wfa36Cx3o6Ryottp+5M6BylitDbQWBLdBrpPNF
 az8BCNccHN+iLoeFCwXTmUOM8RUP1CJHp0CwdKu2enpUylFUJM/DFuthbwPfXm3L8VK8
 5p3Q==
X-Gm-Message-State: AOJu0Yy0f8kyrTLfJooq0/eQJALmHiQus4qgGAkuQkrXLkK4oW/lrURV
 Q+RFuE7Vc7FMMaeqPq9srjuVqG9pV0BZRn0W+IKTBlecQmg6oNGCowfG7IHgKWzm
X-Gm-Gg: Acq92OG1kob3xB7n4QhcLVHv/TdOcO4lTx3w1B5ELyCxwR9FMBYeLqNialSKlqGq1qr
 Fisk+HdodQ9+I+KqVZOqGNg9T5TxDOoj8qJyqUVAhuMEkHJXTo/FIQvRLpj53UjzZaUyadIBke3
 WT6x/jDs9Ka4saZjtUJWrhplVk59iTrfgqlH4teKk7+BIpMjbJsF1RIZbu0e7Nt+R9Ld732YIOp
 BwC6df/Ur4iRq8TT9K2sszXyNskxZwqqOLAycx+rlXIW9KTsCn94L7WAiLR1LOUZ38a3ZN2AFLr
 SGN3HFblcf3637GfHTPfxT/N71jMEfJEJ0CZyDSfgqYdDQhauXcAIpIARfWg3ZkwlYO+x+XBpht
 7vq28kNrWI+gLF2bLUtcHW2PB75ZQ9dhXjXy0k4Om38qoNG3oCl4y5yoEblVvuLQQgCLo2D5UHX
 9r6BGIw2N8WankR5seeagNwYKx302d0Zk+0l4nBjuhsxEE1+JoyAD8uic4ps/3eTHMjRZyp8u1A
 sc5ERmDrVeJdq/5dhM1HU5Nf/cKt0xscQaQBlKNHHm3rDF/PKnkbMKCDY8dWmGdX1fpT3LBEH4o
 azcB/4kkUa8=
X-Received: by 2002:a05:622a:96:b0:517:7a6b:52ca with SMTP id
 d75a77b69052e-517ee1bf564mr1050981cf.33.1781127868971; 
 Wed, 10 Jun 2026 14:44:28 -0700 (PDT)
Received: from eduardo-Inspiron-3583.semfio.usp.br (nat.ime.usp.br.
 [143.107.45.1]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6dc44da2fsm21372037e0c.9.2026.06.10.14.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:44:28 -0700 (PDT)
From: Eduardo Augusto <eduardoaugustoabc@gmail.com>
X-Google-Original-From: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Eduardo Augusto <eduardoaugustoabc@gmail.com>
Subject: [PATCH] hw/nvme: Remove unreachable directive receive code
Date: Wed, 10 Jun 2026 18:44:08 -0300
Message-Id: <20260610214408.82442-1-eduardoaugustoabc@ime.usp.br>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=eduardoaugustoabc@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Jun 2026 17:49:38 -0400
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

From: Eduardo Augusto <eduardoaugustoabc@gmail.com>

nvme_directive_receive() rejects unsupported directive types and
operations before reaching the switch statement.

Remove the redundant switch blocks and keep the valid identify return
parameters path directly.

Signed-off-by: Eduardo Augusto <eduardoaugustoabc@gmail.com>
---
 hw/nvme/ctrl.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c..175daf8a5d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7554,25 +7554,13 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    switch (dtype) {
-    case NVME_DIRECTIVE_IDENTIFY:
-        switch (doper) {
-        case NVME_DIRECTIVE_RETURN_PARAMS:
-            if (ns->endgrp && ns->endgrp->fdp.enabled) {
-                id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-                id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-                id.persistent |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
-            }
-
-            return nvme_c2h(n, (uint8_t *)&id, trans_len, req);
-
-        default:
-            return NVME_INVALID_FIELD | NVME_DNR;
-        }
-
-    default:
-        return NVME_INVALID_FIELD;
+    if (ns->endgrp && ns->endgrp->fdp.enabled) {
+        id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
+        id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
+        id.persistent |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
     }
+
+    return nvme_c2h(n, (uint8_t *)&id, trans_len, req);
 }
 
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
-- 
2.34.1


