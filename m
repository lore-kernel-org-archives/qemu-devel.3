Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678EAD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krq-00083q-K2; Sun, 03 Nov 2024 19:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krJ-0006Gq-Kx; Sun, 03 Nov 2024 19:22:17 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krI-0002m0-1g; Sun, 03 Nov 2024 19:22:17 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so32182455ad.2; 
 Sun, 03 Nov 2024 16:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679734; x=1731284534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eJLIy23RXCVfnR0kGtJ7WuLAA+UoTfJmrCBuGO1Brw=;
 b=DqdCspEZxZ+eBoT06hfH3gdYH+rZ/QOWaSW7f+TSFQtg9V4eiGl+pSdJSncg19g2Ov
 2XLu5Oogm5rwQagEJHsS5Ab5Am62xYzxHRR6qazAp52DN5NbR1VjJ+3JoCknmYQP1l3Y
 dB+xLDC6olnFa2/ThSD76zG2WY3gyLOB+vPSjleyhSWOSrQNV6vhJBYLOl4XbZ8Je2o0
 zT055qepglhAVLJlLhUhZHB/De7HB+J76+VxCWkdvfml8I5dIlXwlYbUNbWiTrhS5rw+
 zxmlPqErsbljq4SF7u3tGosxx23aDrI+0yqYJc+l0XT9U4l6FLxIyVqw0OJZ4FcMYN/B
 KB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679734; x=1731284534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eJLIy23RXCVfnR0kGtJ7WuLAA+UoTfJmrCBuGO1Brw=;
 b=KEB7v39bD9g80v9BsrLpM4YSWCxzTS0geaYmBkILRBOEs3hlTsE0FuL8zUUqRkvUdV
 1M3oSNTOPktA2jnazdibkphTeNK3RHC/J3svfUh9kovBpqDzyOy7C1Y1IISdgoEvyfFi
 LuX5uuevX0/KbM9iRUKwEJg/wWgZkg71rUo6OTAENtH8IyzyLlZ7CQXr8b5DUJOrc1tw
 L0dFFtV5QWMfKBWOUDPJ8dHccErcmTRpMhtWOkcJsbTUfZWvrGE5z/xuyOX2wYa0ygRV
 7Ovev63jVEclCK13ZmyDuzLAdjGhta55CrLOihFyqtCoSln3XSqSPk8rJhXD7Zs6B4mv
 yZhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURykoD3J63LfzvX+oXX+obK+j6p8V+I3s/ndAh6YCwu1QDsKH6zhbQ3gRsb7zDD+fl3DcByK7Z9g==@nongnu.org
X-Gm-Message-State: AOJu0YxiutWCWNBIsIqZoOQLGPxQA+yeEklMOgp4Yubal/70Psp+H/+H
 T+weehailJsYy7xhAJt+AIjOoyzw7xt+yRq6nywy2wGpEL17UKCxmlveGw==
X-Google-Smtp-Source: AGHT+IG2gsfF64h2JmUTMYTImFNGscCNPQPKHtTOEBTD2uGSsEZI8Q9Io0b4PbJkqpbHei/njmBEXQ==
X-Received: by 2002:a17:902:e741:b0:20c:cf39:fe2d with SMTP id
 d9443c01a7336-210f74f48e4mr248299805ad.5.1730679733945; 
 Sun, 03 Nov 2024 16:22:13 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 51/67] pnv/xive2: Support for "OS LGS Push" TIMA operation
Date: Mon,  4 Nov 2024 10:18:40 +1000
Message-ID: <20241104001900.682660-52-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Adds support for single byte writes to offset 0x15 of the TIMA address
space.  This offset holds the Logical Server Group Size (LGS) field.
The field is used to evenly distribute the interrupt load among the
members of a group, but is unused in the current implementation so we
just support the writing of the value for now.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4532cfc467..caa8dc74b6 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -341,6 +341,19 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
     xive_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
 }
 
+static void xive_tctx_set_lgs(XiveTCTX *tctx, uint8_t ring, uint8_t lgs)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    regs[TM_LGS] = lgs;
+}
+
+static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive_tctx_set_lgs(tctx, TM_QW1_OS, value & 0xff);
+}
+
 /*
  * Adjust the IPB to allow a CPU to process event queues of other
  * priorities during one physical interrupt cycle.
@@ -525,6 +538,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
                                                      NULL },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
+                                                     NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
-- 
2.45.2


