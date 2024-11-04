Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066CCD11199
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ks3-0000ry-Co; Sun, 03 Nov 2024 19:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krq-00083o-FC; Sun, 03 Nov 2024 19:22:50 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kro-0002p9-RF; Sun, 03 Nov 2024 19:22:50 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e7086c231so3039973b3a.0; 
 Sun, 03 Nov 2024 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679767; x=1731284567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WwBo0jIjtqBSBwsn7hROT+x0KuPSJ7wyOc1nHG67tI=;
 b=K/qEH2EkVTwd4iSzjeD+4P6PurJua+57V7v/S6iFe3zQGfMnnPhLkPcFkeQRdiNooB
 kqPI9JgOxgg87ZLJLP6ERbJBGgxwfmioe4tvlrNNrq5tr5EHGZVKeoTopISedzFZOgsI
 rbF2jkO3mBbZkqFhgcOy0scoPnS62NJBmCpbz17NFhvrEjuNWGBNQ2H0XEOyjrBQx32p
 HBgvP3G9edWDn7qE2feM5CcLfGWDQPhKI9WGdhG8G8Ph4HY7CIfKiYEfGPO9kTSbJYif
 A47bvmgQj8ewuPBezZhnMcEpvQnWKDwnjHanrjmbpvhCVPI4hhNLW3EyKi2uJGcMNHRE
 819Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679767; x=1731284567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WwBo0jIjtqBSBwsn7hROT+x0KuPSJ7wyOc1nHG67tI=;
 b=gwh+rWOnm+f8VJisaPQ0Kg/AGHN+Vj+2tWDaVDN/2xNsdrngq5RWEUlP10w6P8ZXQk
 15ZyyoYk4l/hrmgls2nATCAoJwwC4jla6aINMD34W6c+7RX23/B5yY8oHYcA6cGLsRXl
 W043GKqT4yFcN/GNGDH8A2AP81CPTUw19bbi9y6JfWC0QmtMpWwhxgIWvW0Xn5q9Gzeb
 kB71o9LC531NVkHZnJTNGuqvuYF4WKoZV3W8E9YIhMazFFcfgdc69LB50YQM1jNWp3yE
 5zOg82EP15hqb26K/SKN3vaNxuxZCQm12+9Lfs3jQKwKdrlz9B6dLXg3fnPuwmJxJKjw
 zTmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3JNOZVi0Q76tecIj8AD7f/WXYbd8Fc/xqq7ixBqOmAAhwcrCdrIbpPGmANLQf7oEISk1nBwQ25A==@nongnu.org
X-Gm-Message-State: AOJu0YxeNu8cazXDqNPQT960rckCM9dYGI3tb4QUw1Xu5aowKr4Mu10J
 G3lL2hONXZ5/51+81vKb9pVErMykvvjLrzoC/ukMYbwp1mcHRTMCHiNiNA==
X-Google-Smtp-Source: AGHT+IHEDju3nuEQnuwITS6/E5Mw7V/IQFA8dxgXkF16pNTgVlpSl4G1dlWKrnHyFqhbpIqdj+2qLw==
X-Received: by 2002:a05:6a20:43ac:b0:1d8:a759:525c with SMTP id
 adf61e73a8af0-1d9a851df61mr42449271637.39.1730679766896; 
 Sun, 03 Nov 2024 16:22:46 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 60/67] pnv/xive2: TIMA support for 8-byte OS context push for
 PHYP
Date: Mon,  4 Nov 2024 10:18:49 +1000
Message-ID: <20241104001900.682660-61-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

PHYP uses 8-byte writes to the 2nd doubleword of the OS context
line when dispatching an OS level virtual processor.  This
support was not used by OPAL/Linux and so was never added.

Without this support, the XIVE code doesn't notice that a new
context is being pushed and fails to check for unpresented
pending interrupts for that context.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c  |  2 ++
 hw/intc/xive2.c | 24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8460bd622a..82c676b151 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -596,6 +596,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, xive2_tm_push_os_ctx,
+                                                     NULL },
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 2e41bd9edb..d1df35e9b3 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -597,17 +597,31 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
 void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size)
 {
-    uint32_t cam = value;
-    uint32_t qw1w2 = cpu_to_be32(cam);
+    uint32_t cam;
+    uint32_t qw1w2;
+    uint64_t qw1dw1;
     uint8_t nvp_blk;
     uint32_t nvp_idx;
     bool vo;
     bool do_restore;
 
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
-
     /* First update the thead context */
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+    switch (size) {
+    case 4:
+        cam = value;
+        qw1w2 = cpu_to_be32(cam);
+        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+        break;
+    case 8:
+        cam = value >> 32;
+        qw1dw1 = cpu_to_be64(value);
+        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1dw1, 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
 
     /* Check the interrupt pending bits */
     if (vo) {
-- 
2.45.2


