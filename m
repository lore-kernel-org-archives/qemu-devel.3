Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F1EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 00:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgXKX-0004oy-Ft; Sun, 05 Jul 2026 20:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXKV-0004oc-FH
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:36:59 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgXKT-0003r2-RG
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 20:36:59 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-383adaa461fso914908a91.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 17:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783298216; x=1783903016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=z/Mrm/xAStmFh045e9yRYG+pscd+SFMM8U2/zFtcBpo=;
 b=QONlbMuVGNUOhIYQOZ6n55iGILfgzSrrR+5MWVzkmo5rV1l7bdY+JKuAnX5jCLZXTh
 X2Eyax+5AWZFJrfvUTmcAfPa5TyB1Beho7u3HY5zeNyfHXt7E+dxZoaYYG7KhJfuntNd
 5cCWQiDE17pk7ega0sUbWrUowrTJXZv8cfsSjDf+ARbUlyOQxXMK06LWgxT2uGEn2G9r
 +VN1MoArsfIxEGzet/4qgYi6wf+1Rrf64HyDxCcxLIy0TMBKZlelgArBLrhJGpP8IkrR
 BbSBD30zbBqkC6IhVW5Xcg+if8uetLL1PX2jaDn2Ze6RHQ/lqKn8Ts/kzQY5TiDfmTU0
 JLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783298216; x=1783903016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z/Mrm/xAStmFh045e9yRYG+pscd+SFMM8U2/zFtcBpo=;
 b=jEQrjcY4OXv8Di0xt+G9vPCo6Iw7OMrV2NyDY6n3//d7U4h05muDtjmsMouCH4Wk8p
 Zdv7crKVfk9vvu6Q3tckhP6iH4fPPgW9qAp5yOjihl7kUunfyZc0m4thNCoPn9oX988Y
 Zt9/fm9OzYq5b5aJvfsmLD/7B7VlVClcKKSWOS6+lYb1HUI7fIjzOV6Jbg6SjtmAIUIF
 WKdr9ZwyJCd5OdZrK1uuAWDqhpIzWiyWNHfbU1dzjx4gKgGq8LvLoGesYYZoFxPjeud7
 nqGdYQsF1ouxacbvbcaBrCaqMq2rNEdVWa5hQar6jyKzqggkXkRZCHKnr34uyJcK1nph
 VsXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1VSZ3KsmVx65DUY9trv5xzOtUXyuFFWjoztGsspx0RrFAvU6UVWLJb1zRQZdj+mObcam/PmXE7B3u@nongnu.org
X-Gm-Message-State: AOJu0YzJ8dz0on3oGryEzbzkNoeC+UomV6PxM6eGIAU16netnkfShVg5
 qh09EtD8Z/pfxgYsGFV119JFq29EcZ89ffDC55/baclCgvksU4rmWxEK
X-Gm-Gg: AfdE7cmZpfzoHVyRSrVAg4oHTcoSJrkhZBkfB0BJ0haycI5Z+EwaVvc7ipKw4qnQX/W
 me1v+tDA5OPTb2wAFd27jdhHJYve6c6NmCJvme1kkr/dUq7Qlm3++tL6Fhe4Z4VfihYqXaxqSXI
 td9pdCqD+mgXP5ASJ4fGxJGEsPDr72eRAARz/AjW5P24LKaljis7dkf0CD5mB21eQXOjprXACvl
 05+EgwrxkGBHn249of5UuaMnBYGBSlPl1Lw/0TFcYeZ3tN6BYFdy3OQNC3s9qG8AZ6/g2dHiRiT
 MtGVUPGUNMVhaaEabFO6qYgLKruKdb8t9hdhlLSdAAjNIJrPdAH2dxG5ju7JIa5lz7vnLL4CaWd
 h+YbtApLnVXzYzF1NSiLsk4A/Nnpp2LycDCMQPln960ylrck/v4TQPBeYUZQpftJFQc94UDnhBR
 N2ZC+nEZjwesR8rDNlLpG+8mWwdsmAoQ==
X-Received: by 2002:a17:90b:4b90:b0:382:3dcc:1487 with SMTP id
 98e67ed59e1d1-3829f00022amr7144799a91.25.1783298215737; 
 Sun, 05 Jul 2026 17:36:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f3c8b19c7sm28844899eec.4.2026.07.05.17.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 17:36:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair.francis@wdc.com, tangtao1634@phytium.com.cn, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/pci/pcie_doe: Check mailbox length for overflows
Date: Mon,  6 Jul 2026 10:36:47 +1000
Message-ID: <20260706003647.75945-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alistair Francis <alistair.francis@wdc.com>

It was possible that a guest could overflow the `doe_cap->write_mbox`
buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
`doe_cap->write_mbox_len` would continue to increment and there were no
bounds checks on the length when offsetting into doe_cap->write_mbox.

This patch adds a check and reports a guest error if we would overflow.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/pci/pcie_doe.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pcie_doe.c b/hw/pci/pcie_doe.c
index 2210f86968..765ebea42c 100644
--- a/hw/pci/pcie_doe.c
+++ b/hw/pci/pcie_doe.c
@@ -356,8 +356,14 @@ void pcie_doe_write_config(DOECap *doe_cap,
         if (size != DWORD_BYTE) {
             return;
         }
-        doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
-        doe_cap->write_mbox_len++;
+        if (doe_cap->write_mbox_len < PCI_DOE_DW_SIZE_MAX) {
+            doe_cap->write_mbox[doe_cap->write_mbox_len] = val;
+            doe_cap->write_mbox_len++;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Mailbox write length (%d) is overflowing\n",
+                          doe_cap->write_mbox_len);
+        }
         break;
     case PCI_EXP_DOE_CAP:
         /* fallthrough */
-- 
2.54.0


