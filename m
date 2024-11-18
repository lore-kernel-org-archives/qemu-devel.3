Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F5FD49205
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCync-0005pr-35; Mon, 18 Nov 2024 05:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCymq-0005M4-Jq; Mon, 18 Nov 2024 05:15:17 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCyml-0008K5-UB; Mon, 18 Nov 2024 05:15:13 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B5AC925400B8;
 Mon, 18 Nov 2024 05:15:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Mon, 18 Nov 2024 05:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1731924910; x=1732011310; bh=eKPdc+0xnhbS9XwqwCCdNQo8FgV2Dtc/
 tstz7c+G7PI=; b=frESxbxM3N9pCMrmmoqERJizZG+wlAVdG1mqNOOiy0PbvUsW
 /ieidBnBVaDcJzMMBxFrAmOqCWvf1ZpyN4lDjGLhkQiE/ODHSZxQ9EzsdiP3VoJg
 YGh88IpiudOAKZdTTrUxnph9R0ZTIFnZaDfcVHRS2Ot6HliSjQ3OetUAH4qcrIl2
 dCPv3w9V2g3hWAfZgg/5YwxvhMc8VJMFb5/HO878iXrB33IQYBlOtBAfUwApBRPJ
 0PDcsK6jarzYS+oa8kfY/5UvaP0k3lRnOypNquR3mlmxBXYngAq4CHmn4q0wvyv3
 19oTdq0ICFYIrGJWu3tgeY9hOnTY5Spa2xptBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731924910; x=
 1732011310; bh=eKPdc+0xnhbS9XwqwCCdNQo8FgV2Dtc/tstz7c+G7PI=; b=J
 Z5LOCcbkjXV7YB2/F9AIHUAXJuGQt5GFlq6ArmeWQDsT3QcxenbdtcbapQQ39NY8
 v3fXx6mdQACMsYCZemjj0Wd5fgyrpp1wjI5qTx5QPBZPmXq0clT4JX5noHh7VGOG
 IkNY5CXIEsJ450ColAthPmpK7CuVAe5bCmLBYb8co4fEKs6VDsHa2wdQ2LPGqa7B
 LX3UQ/9S9LX3s9xRKUg5WwqtQ/UJwV3ujxUXDU31C3U4gsJmSziQ57oV21hGAjwj
 fesN8yjb0B1MRFhbK6WJ9WBAf2YaVXUnz/sD9rg3MrkJ6rJQueWACfyiKnzB+5Hw
 5STUoJ1vaMMnsHqPqZmmQ==
X-ME-Sender: <xms:rhM7Zz-eRRejEq5aOOIy0Bcqq3RHbMjvFEvWEK76RWSCPVc06ant4w>
 <xme:rhM7Z_sW20BOIs6ppMk2aYmdLsKEprenixfIk5eULLxoNdI095qq-Qi-B9Mmr4AFw
 wlbEQ1UAPYMkKas4as>
X-ME-Received: <xmr:rhM7ZxCjskSgg3PkxtDBMc-VhLtkpFl2_WqiRJOch_dLXPHNgwf6MazlL663hwV9r7LEL3DfNe-hKMnxEQD2nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphht
 thhopehqvghmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuh
 hstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:rhM7Z_c5MzYg8QXbqJUOsWaw-7T4x7j309RiQkDGAv9-qJCLWh5O-w>
 <xmx:rhM7Z4Nc2_dxtfcM1-NACW-TrekrpyFBXBPLRaCQxikqbpZ4KI-aEg>
 <xmx:rhM7ZxmyLgG_Z0Si_GlE8-DX_LR-OXVgrJxKzA8j3AfS0QObq82WbQ>
 <xmx:rhM7ZyvcjcSAVP9B6zHaawCEsjckPrgE6O70Xb3q8PPSKRiHSqhrwQ>
 <xmx:rhM7Z0AR43Mel1iePJpdLo9oi7JHexpeK2OOspNc4pJtBkRplDPImBid>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 05:15:09 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 18 Nov 2024 11:14:19 +0100
Subject: [PATCH for-9.2 3/4] hw/nvme: SR-IOV VFs must hardwire pci
 interrupt pin register to zero
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-nvme-fixes-v1-3-02d107dbdcc0@samsung.com>
References: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
In-Reply-To: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=8FsyptW+qB1cLIkS6SNQ7iw7y55WO0Fxsme0yttl0wY=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2M3RTZYSnZ6S2NueXdRN1pEemJsY3A1RDg2Cld0YS9xbEgyTEtWYy9xVlMy
 SThhd1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbk94T2x
 BQW9KRUUzaHJ6RnRUdzNweURrSC8wNnJidlhQcC9OV3BBTmhOVVU4NkNVVGRFSUVKWUk3a25TWg
 pGb1FWd2toWmRsV05sZ1doTXVibGZmK0RwVHRUSlJ6VVlIOWRxUmFnb1BPc0RZaWJEMUhLTmtJN
 zhWaVR1UUtaCnlMZ0lzU0hmdkZVZ0lsV3Q0Q3ZvcVo4NHM4eVZiNk5OZzQ1RFo4ckg2SXQxQ2xU
 N1VqcTRobnlua1ZkYkU2QVAKUUoxRUlMWWpNTFFxT3EzZ2JtamFKMXBXbWFuejNLVzBjcDZmWVN
 nQUZNa0xKY1RqZ0pvaGg3c2xZcmJZMHZkVAowR05RYzZmUWZvVHlnZUNkMkpqTng2ck1iN3pQc3
 hjTUpqd1RPd3E5WVcrTzRZYm1iMHRWS0k4Qi9sMnJMQWZaCjN6SXJRNkMrRjAzZ0NNa1BzMUVyY
 lFWcWJyVHB4cDBvckJneUlBbXBacnZnQ1ltN2NDdjhFNlNSCj1kU1pSCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
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

From: Klaus Jensen <k.jensen@samsung.com>

The PCI Interrupt Pin Register does not apply to VFs and MUST be
hardwired to zero.

Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a38f460a78599bc191c17a2a376e865a74744e58..61c114c66d1565696430589aeb27d7c4a5d2220a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -656,6 +656,12 @@ static void nvme_irq_check(NvmeCtrl *n)
     if (msix_enabled(pci)) {
         return;
     }
+
+    /* vfs does not implement intx */
+    if (pci_is_vf(pci)) {
+        return;
+    }
+
     if (~intms & n->irq_status) {
         pci_irq_assert(pci);
     } else {
@@ -8544,7 +8550,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     unsigned nr_vectors;
     int ret;
 
-    pci_conf[PCI_INTERRUPT_PIN] = 1;
+    pci_conf[PCI_INTERRUPT_PIN] = pci_is_vf(pci_dev) ? 0 : 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
 
     if (n->params.use_intel_id) {

-- 
2.45.2


