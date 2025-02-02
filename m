Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFC0C02194
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2025 05:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teSKL-0003IL-VU; Sun, 02 Feb 2025 00:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1teSKJ-0003HM-Os; Sun, 02 Feb 2025 00:15:24 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1teSKH-0001jK-Ib; Sun, 02 Feb 2025 00:15:23 -0500
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D7BCB25400AA;
 Sun,  2 Feb 2025 00:15:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Sun, 02 Feb 2025 00:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1738473319; x=
 1738559719; bh=KL4PaRWuVVuptRx33btOLrCCHbGi+MoL6PpakmHIIEQ=; b=E
 pb19CseUf5iD9pyyJOW0iD9T91uNR7YgI9fnMWCS58Tk71tcBGanYg9aNLNBSvSI
 JFCOzpjdgol0lIfDbXyyiCZvdZ38a5kmfuMDJO6zaT7qbiGoRKnCxq519mnLF5XM
 CF2epyuFY/3NezQgZfmLu0Vvo10J8+n848+wpi/XW3tITgzrCVHxVuXYlfsMUj4N
 /1UtEjH1wAO+8UyARU6Ywza4bcI8gLoN94SVz01v/YqPplX2L++OCNPBX5vIqqtM
 Lt6iX6BAwgdaCtYLOBBQAI+QCknL5zxHSu7RBdigBq6YHGNGFzCB1XxZOf5LVCq9
 CP7vfqnlOGxYZSBWC8JTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1738473319; x=1738559719; bh=K
 L4PaRWuVVuptRx33btOLrCCHbGi+MoL6PpakmHIIEQ=; b=zegN21me9iHW4Ro6o
 y1aCnekH+fibl8aIs0KqMQCy7v/0hTha8unA7lpqSfxHeiaBm9u6Jd7iFFqTF2O/
 jP+WRKBCyLZ8m84KUjCotTz76dnuLq0m8qZVGF6mtg69DXbbw8a1cPQir6uIvRZv
 W+2FNZDOLLCs7rdBwR9WPFgp87qUksE+ybTigsMOBT84l/6zAND97PhGamrR0bM/
 Cs25OS8UHdgSdrzo3JpUkADM0WI0Us9PWkY+fNh3iMiVZGkGD4mhd89m/2WYEc7X
 /a1+MO45Ryax8S3WgbPdvQyIOgg4c6LWJR6E/dEyr/nq6xdjkvrETUV83emjji5d
 Q+w3w==
X-ME-Sender: <xms:Zv-eZ1RLGbrjSmU_Y-XI-hm8YfxNBz4LctCerAX6OCFUtgFR13GcHA>
 <xme:Zv-eZ-ym2Idi4DvP75ki8Kmz2XNqhQ_cZ6ycI0-iF04x13PKTZsNFifw04dgGRHmH
 9rLEN8wucrXXCYTaDA>
X-ME-Received: <xmr:Zv-eZ61yJ_5bF7S25yG8_YStbCip2ZIKQCAW-o8cgfd2yAq-zIuDOJYzug2LKvMAjg7oRlaN1mEopdDffMNec5gYLPAWK1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpehjuhhlihgruceomhhiughnihhghhhtsehtrhgrihhnfihithdrtghhqe
 enucggtffrrghtthgvrhhnpeeihffggfelieegieehleeflefhkedttdelhefggfejueev
 tdehledvteekvdetkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehmihgunhhighhhthesthhrrghinhifihhtrdgthhdpnhgspghrtghpthht
 ohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlse
 hnohhnghhnuhdrohhrghdprhgtphhtthhopehlihifvghiudehudeksehgmhgrihhlrdgt
 ohhmpdhrtghpthhtohepsghmvghnghdrtghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
 epqhgvmhhuqdhrihhstghvsehnohhnghhnuhdrohhrghdprhgtphhtthhopegusggrrhgs
 ohiirgesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtohepphgrlhhmvghrse
 gurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhs
 seifuggtrdgtohhmpdhrtghpthhtohepiihhihifvghipghlihhusehlihhnuhigrdgrlh
 hisggrsggrrdgtohhmpdhrtghpthhtohepmhhiughnihhghhhtsehtrhgrihhnfihithdr
 tghh
X-ME-Proxy: <xmx:Zv-eZ9CtMqoa8PSDL4B7f39uvf9KDS9j_wdp_LbHOEf41yndTwW2kA>
 <xmx:Zv-eZ-ilwNefdKyyxJ0Nf7PmGaFp58EZxzv3gKReYoilXmPoBnUpZg>
 <xmx:Zv-eZxqw25QmXrTnvfgobJcS6BIPPpVmFz4ojePi1TqE1wX9HFBITQ>
 <xmx:Zv-eZ5joVhjR62Ddcga-ntxRUqyllGHDpTGKFqmHsCH4eAYHx0ec5g>
 <xmx:Z_-eZ5PijnseJ_Ftsa8R09dLCF0CGu4urHyA8jsNMMB9JpulCC5BL-hV>
Feedback-ID: ic5914928:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 00:15:15 -0500 (EST)
From: julia <midnight@trainwit.ch>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, julia <midnight@trainwit.ch>
Subject: [PATCH 1/1] target/riscv: log guest errors when reserved bits are set
 in PTEs
Date: Sun,  2 Feb 2025 16:15:05 +1100
Message-ID: <20250202051505.1846933-2-midnight@trainwit.ch>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250202051505.1846933-1-midnight@trainwit.ch>
References: <20250202051505.1846933-1-midnight@trainwit.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.155; envelope-from=midnight@trainwit.ch;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

For instance, QEMUs newer than b6ecc63c569bb88c0fcadf79fb92bf4b88aefea8
would silently treat this akin to an unmapped page (as required by the
RISC-V spec, admittedly). However, not all hardware platforms do (e.g.
CVA6) which leads to an apparent QEMU bug.

Instead, log a guest error so that in future, incorrectly set up page
tables can be debugged without bisecting QEMU.

Signed-off-by: julia <midnight@trainwit.ch>
---
 target/riscv/cpu_helper.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1dfc4ecbf..87adf16a49 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1226,14 +1226,27 @@ restart:
             ppn = pte >> PTE_PPN_SHIFT;
         } else {
             if (pte & PTE_RESERVED) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
             if (!pbmte && (pte & PTE_PBMT)) {
+                /* Reserved without Svpbmt. */
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
+                              "and Svpbmt extension is disabled: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
             if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
+                /* Reserved without Svnapot extension */
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
+                              "and Svnapot extension is disabled: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
@@ -1244,14 +1257,19 @@ restart:
             /* Invalid PTE */
             return TRANSLATE_FAIL;
         }
+
         if (pte & (PTE_R | PTE_W | PTE_X)) {
             goto leaf;
         }
 
-        /* Inner PTE, continue walking */
         if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
+            /* D, A, and U bits are reserved in non-leaf/inner PTEs */
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: D, A, or U bits set in non-leaf PTE: "
+                          "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
+                          __func__, pte_addr, pte);
             return TRANSLATE_FAIL;
         }
+        /* Inner PTE, continue walking */
         base = ppn << PGSHIFT;
     }
 
@@ -1261,10 +1279,17 @@ restart:
  leaf:
     if (ppn & ((1ULL << ptshift) - 1)) {
         /* Misaligned PPN */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PPN bits in PTE is misaligned: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
+                      __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
     if (!pbmte && (pte & PTE_PBMT)) {
         /* Reserved without Svpbmt. */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
+                      "and Svpbmt extension is disabled: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x%" PRIx64 "\n",
+                      __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
 
-- 
2.47.0


