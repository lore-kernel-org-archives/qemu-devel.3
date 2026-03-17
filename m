Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C66AF3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QDs-0004Y4-QT; Tue, 17 Mar 2026 04:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2QCG-0001V9-7h; Tue, 17 Mar 2026 04:54:40 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2QCC-0006mv-1Y; Tue, 17 Mar 2026 04:54:38 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 2931BEC018A;
 Tue, 17 Mar 2026 04:54:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 04:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1773737675; x=1773824075; bh=Uk9MA9tCfcMmewYjnYM+atZAq2o5WV3m
 ZNIROPc+VbU=; b=dLAvuKIKXsp5E5QYLQZLEHrA4l+XXzYIs+ee48HpVGpuel3c
 Z9reL2sJn1gEA1r5bOUrwas1tF72sYdm1rlA+3xtLacQ0IeZc11FSuuuDGlRlQRF
 hEHIQd13Xq2DsJFTXrGfY6VQcZco/UEtcLRYRWFl+QEkCrjCTOPtiFUhE37qpn5w
 ap7gKf3xe2BFDH+hoA2hOJhAeEbpw/gLUTmx/nPQPHtS8d2AOX6alKi1AtmL9sJ3
 TvrFO+qdsRfP4Vmt6CWrl4WmZGA/pPW/fhInOsjigoQfrZZfqZMg6xmHnVuEvwol
 vR194irhAstUmlTLEtvZ0sRPSQuSPwnUB2ejFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773737675; x=
 1773824075; bh=Uk9MA9tCfcMmewYjnYM+atZAq2o5WV3mZNIROPc+VbU=; b=P
 05gHrRk50boF7LyQTqfnAHpslNZsdIfwDihpqgX5/8qcNanT/1uA6/U2uLNpge4G
 TuagWj1kxB9IiMXAumUtY9rcCUs4DxtOHjoRuIPViYkIiQD+VU7Nua4rTc40QZnO
 L7M/jjtwxIGDGSpjQl2/9AaWej0hWS2V2SZiXQqx01LhMY0peUZZOb/EJ0TFdy8p
 nTVmMkEo0CFY+zBuwojqvnhlti6if+vpaZ+aZW8GaAylhx6ZpFxOGcsASYcqGeKG
 uQ+qUC61HxBBXYGoeXay5ILQ05epf5ic3a1eHQWAHDaz77qMi6rddEwuhiy5WZZQ
 epHqveJGtbIgmKcLTFWfg==
X-ME-Sender: <xms:yha5aQwu_Gguvc4xiaLMYckAPOK3_Wq66JcjjdrxbQvGXsZtTMRt5A>
 <xme:yha5aQRhhgCSel3Dae95Pcrpk_y0elxZs7H1rv8x5jlyKSZoZl4GCjDtCQ7jKMnY4
 UHnHKmOliL4DPH-a_7hFyS0CF9vKjTMxBWV5J8w_x17i_rjed_i5bk>
X-ME-Received: <xmr:yha5aUg31F4itluJRlBsy1BaLU0ttTi5n6OzN4f4YOt5Gpuuzv8Se6eBtyuMypfSyYEmTA9yFgeARXXlUMxubQi4-_vvInRKNDs8jDJfxUPP3FmJSreurneouHxP2Wk3F43ZWwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudevgefgffeiteevfffhhefggefh
 ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
 hssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpth
 htohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghroh
 drihhtpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthho
 pehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotg
 hksehnohhnghhnuhdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhn
 ghdrtghomhdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:yha5afkZGqPeDVAGAwi3ZmrM5GZywPQLF_Shr9yZ40lffvB2jrEoUA>
 <xmx:yha5afuZHEwxJwMAP91RG6P4agfPO0arQ7bq7MpIrrWvv8HI2iMDiw>
 <xmx:yha5aVbHdcVpbmB0ckEALa7A4hyVXLq2eLbanRGqMNfdB5xP7URMjA>
 <xmx:yha5aXBTBb14b2YLSKMd95rkNnPdo6sFXHAAWIlB8lEhLjQsGZk23Q>
 <xmx:yxa5aeJ5hHgQHOqHN3fmg5pL_-U_Ukv_YL-_USYgLBHlIiUwZNfb2cd7>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 04:54:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 17 Mar 2026 09:48:58 +0100
Subject: [PATCH RFC 2/2] hw/nvme: allow MDTS above 9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-lift-iovmax-dma-limit-v1-2-38729170683f@samsung.com>
References: <20260317-lift-iovmax-dma-limit-v1-0-38729170683f@samsung.com>
In-Reply-To: <20260317-lift-iovmax-dma-limit-v1-0-38729170683f@samsung.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=AVY0YDCoRdcQyYMsgFxQ2C/TR9/zyEgfbkciAqZdxHc=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR201RnNYbCtTWjNBeGpvQnNOc1kvK1JHcFgzCmN2a3BySHRYbnNNNlh6ZURY
 UE1LeVlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcHVSYkZ
 BQW9KRUUzaHJ6RnRUdzNwc09BSUFLaWhJajVuSTdwd3BsWUlXREtZeWI0aTBVZ0o5S2NKRVFzMQ
 pJaGZqUFRhWjJTVU00bDRNWDNhQStuazlKd2NGK1FhZm80K0JKeG1YenFCUFZPSjdGeXBVaTV4e
 mQvdjAxNEVUCmFCNzFWaE40bVE5c2FjQ0FRdm5TeEpjZUVXTjhkVHRJdnFzTHEwa1lXdkFZRXE2
 bFoxaTh0RktiUFkwTmhDelQKSng2SWNNenQ1dG5ZV1ZYUFNkUFV3Wk52bHIvcWZ0QUhmVUUwZUV
 jTm5sMkhRUm9NbW41di9QRGJQcHJJRnBDNwpkV2lwT2VSakpuckwxWVpsVmQ3YnE0YThjOGJrNE
 k5YUcyVXNkeUUwa2x0UkF4T2U1Uko0NHA5RmtCVVcraEw5CmlkWmdkSDN2WlRncXZXUG1hYjM3Z
 2oxZ1paeXFwKzVQV3hoWGFEbEJJbXN4c29DVHluNWRXNk1VCj0vMVh6Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

With the IOV_MAX restriction lifted at the dma-helpers level, remove the
restriction on MDTS.

Still require mdts to be set (i.e., non-zero) since it has a direct
impact on how much many may be used internally.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd427a..480694cc2e14 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -851,10 +851,6 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg, hwaddr addr, size_t len)
             return NVME_INVALID_USE_OF_CMB | NVME_DNR;
         }
 
-        if (sg->iov.niov + 1 > IOV_MAX) {
-            goto max_mappings_exceeded;
-        }
-
         if (cmb) {
             return nvme_map_addr_cmb(n, &sg->iov, addr, len);
         } else {
@@ -866,18 +862,9 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg, hwaddr addr, size_t len)
         return NVME_INVALID_USE_OF_CMB | NVME_DNR;
     }
 
-    if (sg->qsg.nsg + 1 > IOV_MAX) {
-        goto max_mappings_exceeded;
-    }
-
     qemu_sglist_add(&sg->qsg, addr, len);
 
     return NVME_SUCCESS;
-
-max_mappings_exceeded:
-    NVME_GUEST_ERR(pci_nvme_ub_too_many_mappings,
-                   "number of mappings exceed 1024");
-    return NVME_INTERNAL_DEV_ERROR | NVME_DNR;
 }
 
 static inline bool nvme_addr_is_dma(NvmeCtrl *n, hwaddr addr)
@@ -8626,8 +8613,8 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         host_memory_backend_set_mapped(n->pmr.dev, true);
     }
 
-    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
-        error_setg(errp, "mdts exceeds IOV_MAX");
+    if (!n->params.mdts) {
+        error_setg(errp, "mdts must be set");
         return false;
     }
 

-- 
2.51.0


