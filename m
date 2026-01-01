Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BACEEB57C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9ob-0002Gb-Tr; Wed, 31 Dec 2025 22:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oa-0002FS-61
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:32 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oY-0003iJ-8d
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:31 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7DA3C7A0098;
 Wed, 31 Dec 2025 22:57:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 31 Dec 2025 22:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767239849; x=
 1767326249; bh=ygHQ47XsQ65iTRBvZyvIraYIcSs8DRfSbeQqPcnxVz8=; b=W
 ueyv8XMY1jTMf0Bi7j8XZ3B2sauu5gO1rmLDvoqG4snuG/XEWAKywY2WPquyniVv
 Ht71rJjQWOGNsHOfp4bF2K6blNsmqGdx95SAoyxkqFXYrnX39L57Q1aJxTmljn+z
 D8FITXZejPzCj9YaYQtFLTyFliYOZa81VayX2w58B/9g6y1V90zAuFtS2oSyOHtg
 LpDN0+qyVRxnuhFeX/W//RGIGvQFWDcKDphCXNTcisGDvMQSwOKa55eqrdrgBKCd
 6C96Q2hLOBuehEf7TVG6/A1Baug3C+t8P8j7EVFvfgsIh7AHxXsqucrvR31bAR1R
 wAETXEuQ3tY99C6UvEavA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767239849; x=1767326249; bh=y
 gHQ47XsQ65iTRBvZyvIraYIcSs8DRfSbeQqPcnxVz8=; b=d7e476DuIRTfbjoLl
 Vmi8t0B/kZPQogk4eFTeLFxtPOxfX+4YOkeMWT2NYfyZw6zRjDCiexvljmV7ru+J
 Ox/MFb/bUlzrGK9hx9/HEPircZCftMPOsybBRL7+7506ORpj8ZcZrh+q8UVkvh8P
 f7apoyje8XhYZeDwLfMnqPsi86brUnWT/vXcUzJTYZCz/LKjKlrG92k3rC0HBud2
 oyRzhhWvF33kYC38VWrmJW5CpDSjdOyTYn0ZVtlb5rBRhOvx/yNQY/tFRWpN9x/M
 D8D5qXnIWMzoHGM/waFG9zc+4kgT0fnS+dADFmzOIOICplL3t7w9tJZc9auAuXAL
 fU//A==
X-ME-Sender: <xms:qfBVaTKXiKkm7b6eczX9bLF6bdLgPkwVgiXFWiTTfmRA-AHWsw_Pyw>
 <xme:qfBVaelD6VZmQ6k8O68B7iC-Omo-ylBeEqib-ZGtqEHntyqxriA6JBOz2Kwbdp7pv
 yRkSxqYZYIzDDKsb66xCmUODKFEnFN8aI7ttdSwj96cCD-dHQPplN0p>
X-ME-Received: <xmr:qfBVaZFIn3HEWWfYOYJykWxeGMZdKKv1pjBQvJKpDnUczx7UGNO8EaE6jbv5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptg
 hhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:qfBVaWGvegisPxC_soZIApTKHb1Z27EIEAqYQ-FKLxpqi0eGynmdmQ>
 <xmx:qfBVaeNNmwvbRetjT6eq_W9v9c_QGR8RNZ87Y3c89f363rW7TcJpFg>
 <xmx:qfBVadGc7yqWEcqdQGLHD9eileR-Em3e5QnEREUWjhHsOETAhFs3AQ>
 <xmx:qfBVadOUaMteEAqvu633UHtrx10imP-GN0mmcgDUixMOpsNaLsi9Gw>
 <xmx:qfBVadxA5UDqQWOa0xm-AQjWs-s7WzH5qpJ2L65vUZUUUULe2oFsBIsg>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:29 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 034ab7b5;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 3/7] ati-vga: Implement PM4_BUFFER_CNTL register
Date: Wed, 31 Dec 2025 22:55:51 -0500
Message-ID: <20260101035555.1300511-4-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260101035555.1300511-1-chad@jablonski.xyz>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b3-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

The PM4_BUFFER_CNTL register is used to set up the CCE FIFO. These are
straightforward reads and writes. Future CCE patches make use of this
state.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 11 +++++++++++
 hw/display/ati_cce.h  |  4 ++++
 hw/display/ati_regs.h | 12 ++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index e291926470..a4bef92efd 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -535,6 +535,11 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
          */
         s->cce.microcode.raddr = s->cce.microcode.addr;
         break;
+    case PM4_BUFFER_CNTL:
+        val = ((s->cce.buffer_mode & 0xf) << 28) |
+              (s->cce.no_update << 27) |
+              (s->cce.buffer_size_l2qw & 0x7ffffff);
+        break;
     default:
         break;
     }
@@ -979,6 +984,12 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->cce.microcode.addr += 1;
         break;
     }
+    case PM4_BUFFER_CNTL: {
+        s->cce.buffer_size_l2qw = data & 0x7ffffff;
+        s->cce.no_update = (data >> 27) & 1;
+        s->cce.buffer_mode = (data >> 28) & 0xf;
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
index f2ef1345de..25a2430c60 100644
--- a/hw/display/ati_cce.h
+++ b/hw/display/ati_cce.h
@@ -21,6 +21,10 @@ typedef struct ATIPM4MicrocodeState {
 
 typedef struct ATICCEState {
     ATIPM4MicrocodeState microcode;
+    /* BufferCntl */
+    uint32_t buffer_size_l2qw;
+    bool no_update;
+    uint8_t buffer_mode;
 } ATICCEState;
 
 #endif /* ATI_CCE_H */
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7127748ff..4d1ccc1434 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -378,7 +378,19 @@
 #define PC_BUSY                                 0x80000000
 
 #define BUS_MASTER_DIS                          0x00000040
+
+
+/* PM4_BUFFER_CNTL buffer mode bit constants */
 #define PM4_BUFFER_CNTL_NONPM4                  0x00000000
+#define PM4_BUFFER_CNTL_192PIO                  0x00000001
+#define PM4_BUFFER_CNTL_192BM                   0x00000002
+#define PM4_BUFFER_CNTL_128PIO_64INDBM          0x00000003
+#define PM4_BUFFER_CNTL_128BM_64INDBM           0x00000004
+#define PM4_BUFFER_CNTL_64PIO_128INDBM          0x00000005
+#define PM4_BUFFER_CNTL_64BM_128INDBM           0x00000006
+#define PM4_BUFFER_CNTL_64PIO_64VCBM_64INDBM    0x00000007
+#define PM4_BUFFER_CNTL_64BM_64VCBM_64INDBM     0x00000008
+#define PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO   0x0000000f
 
 /* DP_DATATYPE bit constants */
 #define DST_8BPP                                0x00000002
-- 
2.51.2


