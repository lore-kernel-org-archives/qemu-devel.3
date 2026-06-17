Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452DECD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZj1W-0007Js-Oa; Wed, 17 Jun 2026 01:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1U-0007J4-JV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1T-0003uV-76
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2c6c57c5c07so513075ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 22:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781674870; x=1782279670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lp7xEj51Z44lN7tJkr0UCrWIcX0S3C7ow2fXXn9SBtw=;
 b=bvcWgiPv/EcCPDv2af9GlRDileMq+lWMUK7FRIi/eNhX+uvP654S0B3nYKJzPvChVy
 7m5HRQQy7KdZK0newa9FAsHA6nDb7gTrd0jgjBPCe36+wkvomarPbHH+EBGz1IDD0elf
 EjICgTSVPrNN9vmbsdQGjRr3bw8nfu51SY95HvEX9IffGXu17o2pXTYGNvnL9n5bvX3j
 cKh6hyFADUXR5cJ30FLupFS2/6EtoVUidTfZZ17N5AbVHx9TIw338cxTuKe2PiYnlnOf
 2mv9WAKpYwiahXfUSqvf9w0cbj63a0iH6H5qZnhDZj4HN2JXp6N11dp8Q621QyDar/Dv
 Gdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781674870; x=1782279670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lp7xEj51Z44lN7tJkr0UCrWIcX0S3C7ow2fXXn9SBtw=;
 b=ghgIQid5D/S66Jx8doW4yPUR9AKeOzsLgtHbViRkiogSJRiNvRck+FsVliBJ6NK3n5
 HhCW31I/vZWKryt6z3xz5kJdFfwvafiyZXAEWXPwiZ3qdazuXofYhnwQorOEj2pxCFjX
 cYe6n5OSj71AmagUX9SQbk0bPg0XJUBkipS0tKGyaNZZ509+5KoCKJQ4M6KKRaeXqGBq
 KH0XlyzmXLX5iX5lqHQYDnCwHPLkvqw20pdx08p/zLGI6scWU2kCnzia22o8LICtVvQG
 0K7aI3IGEk0Vquh/MKCOggA3paRKyqyeEANfzBkpOmf5lbrSaCLxmQ1AgkvOa7wbSgos
 n72A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zFeIGLJ2y9vDT9IQQhm8sUXNiiJmmSiPubFwooVHDwOoC91ErirCsBDWDUN7omvUmUY16OqxK3Aqr@nongnu.org
X-Gm-Message-State: AOJu0Yz/QVHEnDggR3nL5yotixj5ZS5sMSfb6ZxtMtLks4YzOU/H5vkc
 ctxisZVhYsGkXASofJaLGSkvpzCStG/HDzVSJN/QyvoJ989rhuxQEHhW
X-Gm-Gg: AfdE7ckA1NLX+4Jk16DRpsWooMLeobijXwjRZBfMoZ8zL7lHTQ2lJUQcZstXLxrfaVY
 1zcljF3S3MvvDuZ/YDBQowxg5orj554nQ6kd8JgThHeVBVZmuUdACR+lJv8yo2z/PIvODR441MK
 UYsCYso7UoTY+faA8uJsKfgVsGCxSryYt5bSwQ6uY2ZUOFQaAdERzQMDjvpSLLqIHL8IjOJVN2L
 Jt5PvCkvYXaFAVRGTV00KSBPnUNFd7BrBv7U9jNuCDMjrdgO4PcvEKQKpYh+BdWQjsvQRHeeD/C
 cdhrYuUaBBbqWWX7WM2pMMdctMPELV7OgWpjP4QqRdHfHMHhlP6biVoNfYjm5RG7DNMIj8+IFgg
 AiQWJCslnxbjdx+dVoVpSAZ6z6ypbr70PLT/G6Al27rz6/F2FIqyZUzunMUzU1An1mdHM4NDPA4
 rBw7MlcSHeUdVwPJrf94TNkpIVe5omiJRkLee7IfwpqupxEFj/52ffj4hT7wiSTL6QXXaESbkQG
 CHitQd51t4NsHl1YJlgrUFjjtbXBBYDDWPRHaEJaIs=
X-Received: by 2002:a17:903:2411:b0:2c0:ca93:1303 with SMTP id
 d9443c01a7336-2c6bbf93604mr20397155ad.6.1781674869654; 
 Tue, 16 Jun 2026 22:41:09 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433078264sm149294725ad.65.2026.06.16.22.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 22:41:09 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: alistair.francis@wdc.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/riscv: Avoid NULL deref in IMSIC CSR write
Date: Wed, 17 Jun 2026 15:09:26 +0930
Message-ID: <20260617054034.1020724-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617054034.1020724-1-joel@jms.id.au>
References: <20260617054034.1020724-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

rmw_xireg_aia() and rmw_xtopei() were changed to store the IMSIC
callback's value in a local before passing it back to the caller.
For write only CSR accesses that pointer is NULL, causing a crash when
guest programs write to xireg or xtopei, such as when the guest sets up
the IMSIC.

This only happens when setting aia=aplic-imsic so none of the existing
boot tests caught it.

Fix it by guarding the pointer dereference as done for other CSRs.

Fixes: 63469ad75dcc ("target/riscv: Fix arguments to board IMSIC emulation callbacks")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/csr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ec931a8c3ddf..4502f2ab4788 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2732,7 +2732,9 @@ static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
                                     AIA_MAKE_IREG(isel, priv, virt, vgein,
                                                   riscv_cpu_mxl_bits(env)),
                                     &wide_val, new_val, wr_mask);
-            *val = wide_val;
+            if (val) {
+                *val = wide_val;
+            }
         }
     } else {
         isel_reserved = true;
@@ -3008,7 +3010,9 @@ static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
                     AIA_MAKE_IREG(ISELECT_IMSIC_TOPEI, priv, virt, vgein,
                                   riscv_cpu_mxl_bits(env)),
                     &wide_val, new_val, wr_mask);
-    *val = wide_val;
+    if (val) {
+        *val = wide_val;
+    }
 
 done:
     if (ret) {
-- 
2.47.3


