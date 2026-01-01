Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D4EEE645E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 03:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vb9oc-0002IF-Nc; Wed, 31 Dec 2025 22:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oa-0002FV-CP
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:32 -0500
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vb9oZ-0003iS-0C
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 22:57:32 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 4A16E1D00094;
 Wed, 31 Dec 2025 22:57:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 31 Dec 2025 22:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1767239849; x=
 1767326249; bh=6fyzSOGF3J3sK3rUPNRf+S64qCJyfcyRpDCjhsebDvs=; b=Y
 NkBd40JKw+70LE3XWWKf494p6cvTe715Pkkj8xPuNivXAnzBXNalbWJ3faTQ1Fc1
 kLf7zBHNdTrMmmKN0JEV6sg7iErnaBa4RE7O/Ayb8ri78aW9gUP1V0c9ts3w6wuT
 L5oyr2uNplozBsGpEuExQBnhSDIyAAobfs5RoP1iFc5tBfYcNsQZM7xQlu6dB50u
 kK7PTvygG5LNvkuGiu7vQbqj1x+p5S3y/rKcWiG0QlboLvlRAGgT9bBQqcqpg6vr
 hmsfJBmvGCjqE6ku5AjsnO0t8D2bhO0q/C0A4Er27xWD/bTjJA/LRu3jkIzP8pf1
 pVjXUOGT9iIIkOUUD1qdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1767239849; x=1767326249; bh=6
 fyzSOGF3J3sK3rUPNRf+S64qCJyfcyRpDCjhsebDvs=; b=O3CRWK5wVrnoWDVDe
 6lC5kvaNGYOdd1oxResMHvubqmwNoUt+WNdwcNi8c98dEx0a7DmAbQ6ALjhop3VZ
 tT9YC/J5hrk++S0Ni6qrYA5PhNPazqrZLJ9kRYzN+OmVwtMJ5Y8AXFzpaM2nFcaT
 q2q0g+h55CiCAxJJnSF/510YGC+UD2woR5HFa15q4W8un+s18wKP1KxzDnzxYc1G
 n3Teqi8XqEY+MX5G2a44cbTaeQp92amloOJxHb1A4X6r+oUsxkxBFEkWrJhJxQQI
 lKea3tG5bIwS5RJOPy+kOw8+N34lWfUTs/O6VNN4go2DPARkQF6cz/hB70iXdquG
 eDt5A==
X-ME-Sender: <xms:qfBVaZY5wQ33Z0Hs5qz8GgU8bBSTk6yBITi-vM6wDJ82rmbC8KWGIw>
 <xme:qfBVaX1AHFHZEEEUi3pbn4Kxwoa8T8ucImdkX1-MbpAVRRRCJowY3zi8edb5A1POp
 WIZwVQJ6IBNxxITBYOZGdzQ79NulRSyhKQ6oguqmp9LOcwgtPaxoEpw>
X-ME-Received: <xmr:qfBVaZXLsfiPxx9vXmaZ46PzAnfiCYMu0lL8QAMlA3WOVL3yOa97oxKwScxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvvefuff
 fkofgjfhgggfestdekredtredttdenucfhrhhomhepvehhrgguucflrggslhhonhhskhhi
 uceotghhrggusehjrggslhhonhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefgie
 etjefhleehfeeiteejgfeljeffhfeuffdvudeijefgueeuuedvvdekjefhleenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsg
 hlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsg
 grlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghl
 sehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:qfBVaRUQwmzu1Ng4bkKQ1QuG5vITAgvdEmgU5Fzm2DlN_e3KDt3vSw>
 <xmx:qfBVaYcy0Rzzyxe4inrqC4Ia75hNOFrPTNuOtZA9LyNWpoQ-W8E0xA>
 <xmx:qfBVaaVOfek6z4tba9lvqt_BAkSMBBXekWnhuzmLtGNkXK8Cq8VhIw>
 <xmx:qfBVaRfE8QLIsADGIBcCl_nqiOfDRdF5azQQ-XajfsN6f7GnxRjGtw>
 <xmx:qfBVadCC1JKaNsh5oJgPmSCQD5FqjqI6TWhNaFszenIc4X6fPU7pquxt>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 22:57:29 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2840daa6;
 Thu, 1 Jan 2026 03:57:26 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v2 4/7] ati-vga: Implement PM4_MICRO_CNTL register
Date: Wed, 31 Dec 2025 22:55:52 -0500
Message-ID: <20260101035555.1300511-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260101035555.1300511-1-chad@jablonski.xyz>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=chad@jablonski.xyz;
 helo=fout-b3-smtp.messagingengine.com
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

The PM4_MICRO_CNTL register has a single flag that is used by drivers to
enable processing of CCE commands from the CCE FIFO. Reverse engineering
uncovered additional debug fields, many of which have an unclear purpose.
They have been omitted for now but could be added if needed.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 7 +++++++
 hw/display/ati_cce.h  | 2 ++
 hw/display/ati_regs.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index a4bef92efd..5f52739d33 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -540,6 +540,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
               (s->cce.no_update << 27) |
               (s->cce.buffer_size_l2qw & 0x7ffffff);
         break;
+    case PM4_MICRO_CNTL:
+        val = s->cce.freerun ? PM4_MICRO_FREERUN : 0;
+        break;
     default:
         break;
     }
@@ -990,6 +993,10 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
         s->cce.buffer_mode = (data >> 28) & 0xf;
         break;
     }
+    case PM4_MICRO_CNTL: {
+        s->cce.freerun = data & PM4_MICRO_FREERUN;
+        break;
+    }
     default:
         break;
     }
diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
index 25a2430c60..a6a9aa87c4 100644
--- a/hw/display/ati_cce.h
+++ b/hw/display/ati_cce.h
@@ -21,6 +21,8 @@ typedef struct ATIPM4MicrocodeState {
 
 typedef struct ATICCEState {
     ATIPM4MicrocodeState microcode;
+    /* MicroCntl */
+    bool freerun;
     /* BufferCntl */
     uint32_t buffer_size_l2qw;
     bool no_update;
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 4d1ccc1434..d7118449f5 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -392,6 +392,9 @@
 #define PM4_BUFFER_CNTL_64BM_64VCBM_64INDBM     0x00000008
 #define PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO   0x0000000f
 
+/* PM4_MICRO_CNTL bit constants */
+#define PM4_MICRO_FREERUN                       0x40000000
+
 /* DP_DATATYPE bit constants */
 #define DST_8BPP                                0x00000002
 #define DST_15BPP                               0x00000003
-- 
2.51.2


