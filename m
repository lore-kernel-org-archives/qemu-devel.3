Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B16C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8L5-0002Cl-Nc; Thu, 25 Jul 2024 19:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8L3-0001zs-36; Thu, 25 Jul 2024 19:57:37 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8L1-0001Ph-8D; Thu, 25 Jul 2024 19:57:36 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cb57e25387so312497a91.3; 
 Thu, 25 Jul 2024 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951853; x=1722556653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUv4NqlnXySQF9jn8Uwsa6TDpSmluDe+/wcl41bzcMI=;
 b=jMXKhxABSClT6EHBdJGnYIlTxXFp/tM+meOc19FazHt2RfUa8g3ZFy+7NDA6lvbSLy
 uGe5gETPBmNrkRMYK4ibzp5BHuhTR1wcR2j5Jwej33EYh6j18pDKKyrLy4VW1KX0R2P5
 LNP5/76H3+zJiqIFYyL2kWRDLltJd8DCnTxaw8We3w1dKX1MbrQqvESkfjxXm1286N1+
 B03tk1lxRnsVyBbwoWDJOe68OVgQ7yMdsiC6ZJQ+n8c4ckooRccR9Tok1I1Dy6+lV/HN
 p4XeU2uwb6kEYsN/U/IlU9fBpsnHfH4W20t1iAuivLasqEVnexgCYAv9MbDTbox5lYo+
 aMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951853; x=1722556653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUv4NqlnXySQF9jn8Uwsa6TDpSmluDe+/wcl41bzcMI=;
 b=eZvPMhjbOrQRDiu3HF90eshPmPf1WV/9cY9BH8praP67Kz3H6jVxpZbsxrkk5zL6vk
 giltss8Effks7enbiPYZkY0wU6ZssQZk2/GgH3tyKLT50OMrdo5xLQIISbPK1/QydvWm
 Y5R4h4ne5ejleOWSW5+Yb0QR9vzHiPHsWN2+11un3pYsaFlQUhQTOzb+HmLPU35v5Zef
 85gVFsAhpB9QiGyM7F9qAMv8lYL2GGnkhEtZ0V1udbsRreJcsk2thjs8+WP0uJ87Jf1i
 xEemRJh1tXEm2QjLbOkBTKY51EC9Ikg+sURtNyZhC+bPbKgV9gh3xrN5pwPuT2lEbUCy
 QHhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+rPmJSodqA2lrOtrIbzzsrUn/BypYHTRjt8rfhaRZr1MUUwGOpHdci5czLjpDoQ5a8TUGj2Oua+CG7EZoVy80v8Lb
X-Gm-Message-State: AOJu0Yzga+vE2gHc6xsZwsLMP0+33I7diO6+XKJD8Wmq5JxQS4k9NMIC
 qqWZC6iPzEM28LuW1x2Kb2r/a3bkztGzZJw37BbI6R3Vv47velTJESjd5A==
X-Google-Smtp-Source: AGHT+IED06H3Do7ZXMA/AO4yUnJoBY1SQt60I5fJykt3WrHArq1DNK+KNlxAVE5GEHhR3V1rDwCy8w==
X-Received: by 2002:a17:90a:39ca:b0:2c8:6308:ad78 with SMTP id
 98e67ed59e1d1-2cf2ebd4811mr4073196a91.34.1721951852891; 
 Thu, 25 Jul 2024 16:57:32 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 52/96] pnv/xive2: Dump more END state with 'info pic'
Date: Fri, 26 Jul 2024 09:53:25 +1000
Message-ID: <20240725235410.451624-53-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Additional END state 'info pic' information as added.  The 'ignore',
'crowd' and 'precluded escalation control' bits of an Event Notification
Descriptor are all used when delivering an interrupt targeting a VP-group
or crowd.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c             | 7 +++++--
 include/hw/ppc/xive2_regs.h | 7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ac914b3d1c..1f150685bf 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -89,7 +89,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
     pq = xive_get_field32(END2_W1_ESn, end->w1);
 
     g_string_append_printf(buf,
-                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c "
+                           "  %08x %c%c %c%c%c%c%c%c%c%c%c%c%c %c%c "
                            "prio:%d nvp:%02x/%04x",
                            end_idx,
                            pq & XIVE_ESB_VAL_P ? 'P' : '-',
@@ -98,12 +98,15 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
                            xive2_end_is_enqueue(end)  ? 'q' : '-',
                            xive2_end_is_notify(end)   ? 'n' : '-',
                            xive2_end_is_backlog(end)  ? 'b' : '-',
+                           xive2_end_is_precluded_escalation(end) ? 'p' : '-',
                            xive2_end_is_escalate(end) ? 'e' : '-',
                            xive2_end_is_escalate_end(end) ? 'N' : '-',
                            xive2_end_is_uncond_escalation(end)   ? 'u' : '-',
                            xive2_end_is_silent_escalation(end)   ? 's' : '-',
                            xive2_end_is_firmware1(end)   ? 'f' : '-',
                            xive2_end_is_firmware2(end)   ? 'F' : '-',
+                           xive2_end_is_ignore(end) ? 'i' : '-',
+                           xive2_end_is_crowd(end)  ? 'c' : '-',
                            priority, nvp_blk, nvp_idx);
 
     if (qaddr_base) {
@@ -676,7 +679,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
-                          xive_get_field32(END2_W6_IGNORE, end.w7),
+                          xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
 
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index ec5d6ec2d6..4349d009d0 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -97,6 +97,7 @@ typedef struct Xive2End {
         uint32_t       w6;
 #define END2_W6_FORMAT_BIT         PPC_BIT32(0)
 #define END2_W6_IGNORE             PPC_BIT32(1)
+#define END2_W6_CROWD              PPC_BIT32(2)
 #define END2_W6_VP_BLOCK           PPC_BITMASK32(4, 7)
 #define END2_W6_VP_OFFSET          PPC_BITMASK32(8, 31)
 #define END2_W6_VP_OFFSET_GEN1     PPC_BITMASK32(13, 31)
@@ -111,6 +112,8 @@ typedef struct Xive2End {
 #define xive2_end_is_notify(end)                \
     (be32_to_cpu((end)->w0) & END2_W0_UCOND_NOTIFY)
 #define xive2_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END2_W0_BACKLOG)
+#define xive2_end_is_precluded_escalation(end)          \
+    (be32_to_cpu((end)->w0) & END2_W0_PRECL_ESC_CTL)
 #define xive2_end_is_escalate(end)                      \
     (be32_to_cpu((end)->w0) & END2_W0_ESCALATE_CTL)
 #define xive2_end_is_uncond_escalation(end)              \
@@ -123,6 +126,10 @@ typedef struct Xive2End {
     (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE1)
 #define xive2_end_is_firmware2(end)              \
     (be32_to_cpu((end)->w0) & END2_W0_FIRMWARE2)
+#define xive2_end_is_ignore(end)                \
+    (be32_to_cpu((end)->w6) & END2_W6_IGNORE)
+#define xive2_end_is_crowd(end)                 \
+    (be32_to_cpu((end)->w6) & END2_W6_CROWD)
 
 static inline uint64_t xive2_end_qaddr(Xive2End *end)
 {
-- 
2.45.2


