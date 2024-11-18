Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7901CD49205
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCynb-0005oG-Sx; Mon, 18 Nov 2024 05:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCyms-0005MU-BF; Mon, 18 Nov 2024 05:15:19 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCymq-0008KU-PA; Mon, 18 Nov 2024 05:15:18 -0500
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 96C59114019B;
 Mon, 18 Nov 2024 05:15:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 05:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1731924912; x=1732011312; bh=fIdnaVMp0/2z9dMrnCl/TLqQ5Ylu2ihk
 ckUe2/tOJXs=; b=ZFsYwbLSHD9xCLvCe9b7tqn9R9Zq1K70VKhXc5WG/o90fcWy
 R+b9T58FTIuEy+DR2N/Hqf9wd+gT3Tpob9Y14/IDeQBo1DcruLRLurjBt68EO4Kv
 ZL4BDJEgGDmZXHe19GpyPPvTFu5DYlDGjf9Evj6w+drwPm2bvRySAUW0a2crSm+k
 QQmDojha0YUvASzkc1XM3ELK/Z44LLtBIub9OiI8mdDhM+7UL3+eGk09AN5reBPy
 19FWb4Sj/K0d/gnNtTAMnBm9I41pIWKm3EMCe9+5P9Z4FDg4YB/6KOKvWTfQchbr
 jy92QYEMoU3i43AmpU7nwg+q3WdjxUIKpjZ9Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731924912; x=
 1732011312; bh=fIdnaVMp0/2z9dMrnCl/TLqQ5Ylu2ihkckUe2/tOJXs=; b=I
 Qh9kPxKrFxOCHpzilOnolWCgAl+UwMvUUNHxymWWzVgHvy8MJBBS0SSOQ7CBOJZm
 R+OyQCkcDXqJoKAFvYEdePx78BPFdXGJtmOGkmwidT+plIKkpvKgWC2ol8eO0cq2
 AC7HIfYb9pu6gAY+pHf9FBCdGfv722ihOarkh9wVqQAIMKvrgeQrkwYKkq1JLWFQ
 4VLT3aso4vchSjqtE5msYhqkrRSMfW5dwngNHSxJsi3itM2YxcQ+3PtNiPjflQHx
 YvawEHWDiMoTU8fhiYxcxWbkKv7Mny7LlaMcZ4RTnvcdWJnkNMJCSMRRYJpd12XF
 4jcMx87spLSHIzBaIH3RQ==
X-ME-Sender: <xms:sBM7Z3wBTrsqt8GiZyex1E_zJlZUkaYMQ-JpdNGvqIoJql6bYUnA7w>
 <xme:sBM7Z_Ql0gNQGA0-bx18Ut22LC549kCrz0cZd813y1SWbtrRd8re67c3N1jX7tGGl
 Oz0mIgVRPlPYVt1BLQ>
X-ME-Received: <xmr:sBM7ZxW54_qk9u51Oa2DQEszyQLiekY4LvyCJ6ys3-W5t7xNTGs6-32HRfEvtJAkAYuYzdA23NsV3MKf13ap8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphht
 thhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvg
 hmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:sBM7ZxgYfoUO0VQgXPCNMadRmjGUU9GLIdn1SThuImglWGFBIR21hQ>
 <xmx:sBM7Z5CWuWJsG_fR9cI9p5c4KiadKIb0mBHgD-8zPgWkOJ8a7EyreQ>
 <xmx:sBM7Z6IX8fOytqeiANRsHYg-3jQ5lIwFAgRnyeuntZIRLTMIAyRUqA>
 <xmx:sBM7Z4At2DCo3DqTkm_TkTn2xeO8PA7WXFXv92-43Fy4guHfP33o-g>
 <xmx:sBM7ZzAVoUFeTmocjLzaENdXga-XZ9kD94dDm-BcpN8SuCAcbQHvMlQG>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 05:15:11 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 18 Nov 2024 11:14:20 +0100
Subject: [PATCH for-9.2 4/4] hw/nvme: take a reference on the subsystem on
 vf realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-nvme-fixes-v1-4-02d107dbdcc0@samsung.com>
References: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
In-Reply-To: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=U8nYbfifAWFGsbALmvnqAi+L4a04ZKCu8fQJt4ne/+0=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2M3RTZaVUFtLzI4eG9NMHlNaEZkUE8zb0ZpCk04Z29PYzJ6Mk9hMERWTkNP
 dVpPSllrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbk94T21
 BQW9KRUUzaHJ6RnRUdzNwclBVSC9SeUV1bUx6b0hkUllUakl6bUdpSlphU0RFQWV3LzA2RnJ0OA
 pYWEdUaFhHTlNVWU13VjRDMTJYKzNPaDhQa0hhOVgzTEFlWXZ2VU0rRUx2MWRJeVBYeGF4ZmNCU
 GFNalJUTlp5CkVlM3ZESUNmMnV2aGQxT0dlM3dxODFDYmtZVGcxTVNaMkxsdDB6cHMya2N0UnNa
 ZW9CZmM4U2R1UHhKbk41UTIKbHFpaUpiTjNhWVY2cUwwT1ROQ0h0bG9wcnhqdGlEV3lqK0syNFE
 1Nkh5T0phVTBFMGJwUDNncmQrWmN4VGVIVwo2ZDZER3ZKMDNNWitIS0owQXlhQkxPRWxFd2JWb1
 pjaUM3ZjAwS2F4Tm8yYmt6eVU4WTVEU3orWjBVV0VESytICkcwdEhkZ0NmZHRpVTdXM05tMnVLc
 m1rKzFMWDlvZFUyZDlBOU5iZnk5dkZ3MEdma3N4MEsxSzBKCj1vKzdnCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
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

Make sure we grab a reference on the subsystem when a VF is realized.
Otherwise, the subsytem will be unrealized automatically when the VFs
are unregistered and unreffed.

This fixes a latent bug but was not exposed until commit 08f632848008
("pcie: Release references of virtual functions"). This was then fixed
(or rather, hidden) by commit c613ad25125b ("pcie_sriov: Do not manually
unrealize"), but that was then reverted (due to other issues) in commit
b0fdaee5d1ed, exposing the bug yet again.

Cc: qemu-stable@nongnu.org
Fixes: 08f632848008 ("pcie: Release references of virtual functions")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 61c114c66d1565696430589aeb27d7c4a5d2220a..ec754195669598082dd573ff1237dbbfb9b8aff5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8841,6 +8841,13 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
          */
         n->params.serial = g_strdup(pn->params.serial);
         n->subsys = pn->subsys;
+
+        /*
+         * Assigning this link (strong link) causes an `object_unref` later in
+         * `object_release_link_property`. Increment the refcount to balance
+         * this out.
+         */
+        object_ref(OBJECT(pn->subsys));
     }
 
     if (!nvme_check_params(n, errp)) {

-- 
2.45.2


