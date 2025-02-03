Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDA6C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 06:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tepna-00037A-GE; Mon, 03 Feb 2025 01:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1tepnX-00036k-Cx; Mon, 03 Feb 2025 01:19:07 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <midnight@trainwit.ch>)
 id 1tepnV-000335-9u; Mon, 03 Feb 2025 01:19:07 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 051241140086;
 Mon,  3 Feb 2025 01:19:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 03 Feb 2025 01:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=trainwit.ch; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1738563541; x=1738649941; bh=kILXHVU9Jt4NKRrxlWtCy
 +Kuu9/FXdLPV8WhIsEs/Qs=; b=EKcz34t32+ehIdn569VXGs941MmYAhtUU83R+
 gOwpSVS9C2yl8Ni88Db2R1SqA/Wd4aTe7IxePenL36k3BJR9NKkO9D0n9VwuGSh+
 b0/jFHC3ozYpWRJiryWCSyDnd4C5+JUu0XgMi76Zk2rd1wylClCuwHQeC/FS7t2m
 Zlow6Y9SIA7Rn1MjiDQXe4XQeLO3O8UMFYFgaDfikdF5DdLYlbFYnBHbc35LmbtB
 rMcbhzv+J5d29CIwhuxHGyWuKPMZyJjmRq4RDscIHJAEQnfFTqcRmtaXW/DXdRLF
 gCZmKWAYEjOP0hheTngIFFpQgPmrxkClNuCQ9GjlQDJfPc1fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1738563541; x=1738649941; bh=kILXHVU9Jt4NKRrxlWtCy+Kuu9/FXdLPV8W
 hIsEs/Qs=; b=RFC3gu3ui0m+IzohtsMoZWYNptPrrp+b41S/uwmA+SNxtSmLRVR
 i5NAG5lC2D0KfcK/cTpK+N+2ZHo9FeXOSrCRI6JXaxqYZc3bPKe+uZjEpXEscn0v
 mc7IXROnfqyk2XBgZenRFBLhOP9+gBK1omDfqTskQGv+bxQKer6DwwONaMC4AeOc
 q5HEUeZeTYDKj9s0Sy1G9dGc8kjp7dWJNafqB8TzWGXIi8bSFN38/qK05vsqrYId
 Gb1qvVzGb9MaFCnp8LqJtLCx26u3yiZiYKG7IhW4KUc99iS/vDh1RX9WWuM3vekH
 +nvJoU90bKyNrgThlkXx130MFPLxxBHOHOw==
X-ME-Sender: <xms:1F-gZ4NmbamIlh0AF6DMQGpTyqRY4PJ_z3qm6FksBqd2WN-8vIJtlA>
 <xme:1F-gZ-9zaNCjuuNka0mk87SRoJQtSZyRX2Kx4qhgd1jiopFpcRml6jo4lE6_1Wp3S
 n1WomU9OHcE_-JC1Rw>
X-ME-Received: <xmr:1F-gZ_RuVq7tLqBD1UE6eisykER9uJHQLRuSUTHGTJAOGObEnF8Ixv4gzLDfvd-Bu3BFr1mQT8ah4zQMWeMn6-EgznicXVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
 hfhrohhmpehjuhhlihgruceomhhiughnihhghhhtsehtrhgrihhnfihithdrtghhqeenuc
 ggtffrrghtthgvrhhnpedvffejleeiheegteefteeiffefteetheelgfevheegkeetlefg
 ffetheekieevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehmihgunhhighhhthesthhrrghinhifihhtrdgthhdpnhgspghrtghpthhtohep
 ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnoh
 hnghhnuhdrohhrghdprhgtphhtthhopegusggrrhgsohiirgesvhgvnhhtrghnrghmihgt
 rhhordgtohhmpdhrtghpthhtoheplhhifigvihduhedukeesghhmrghilhdrtghomhdprh
 gtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehqvghm
 uhdqrhhishgtvhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepiihhihifvghipghlih
 husehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepsghmvghnghdrtghn
 sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihhsthgrihhrrdhfrhgrnhgtihhsse
 ifuggtrdgtohhmpdhrtghpthhtohepmhhiughnihhghhhtsehtrhgrihhnfihithdrtghh
X-ME-Proxy: <xmx:1F-gZwviTwjDyWzL405B6Aa3Wg-D4jJZtlTFClVG1J4faCgDWQeiYA>
 <xmx:1F-gZwflgHc3w3nCUxXcAHxXVHAEAG7Uf8rkKRME4e0PPnuRGdaZGA>
 <xmx:1F-gZ01qAGVdAHpPagv-17EmjUERIyTkVtlczlP_Mfd1W6v7yOTXVg>
 <xmx:1F-gZ08CSJhv7hqlQaidbfayk4DCYl_EE4PhfSwFPYcMbGWfnOWhSA>
 <xmx:1V-gZ46bHWYcOCRyO5q_gVDxgHbpInsZMGlaT7zSmY0MET3TZKXsdz7b>
Feedback-ID: ic5914928:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:18:56 -0500 (EST)
From: julia <midnight@trainwit.ch>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 julia <midnight@trainwit.ch>
Subject: [PATCH v2 1/1] target/riscv: log guest errors when reserved bits are
 set in PTEs
Date: Mon,  3 Feb 2025 17:18:52 +1100
Message-ID: <20250203061852.2931556-1-midnight@trainwit.ch>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=midnight@trainwit.ch; helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
index e1dfc4ecbf..3dd8e06044 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1226,14 +1226,27 @@ restart:
             ppn = pte >> PTE_PPN_SHIFT;
         } else {
             if (pte & PTE_RESERVED) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
             if (!pbmte && (pte & PTE_PBMT)) {
+                /* Reserved without Svpbmt. */
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
+                              "and Svpbmt extension is disabled: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                              __func__, pte_addr, pte);
                 return TRANSLATE_FAIL;
             }
 
             if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
+                /* Reserved without Svnapot extension */
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
+                              "and Svnapot extension is disabled: "
+                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
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
+                          "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
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
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
     if (!pbmte && (pte & PTE_PBMT)) {
         /* Reserved without Svpbmt. */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
+                      "and Svpbmt extension is disabled: "
+                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
+                      __func__, pte_addr, pte);
         return TRANSLATE_FAIL;
     }
 
-- 
2.47.0


