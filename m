Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2756DD4920A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCymt-0005MP-Ni; Mon, 18 Nov 2024 05:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCyml-0005KK-Bj; Mon, 18 Nov 2024 05:15:11 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCymi-0008Iz-VP; Mon, 18 Nov 2024 05:15:11 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 0F00011400E9;
 Mon, 18 Nov 2024 05:15:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 05:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1731924904; x=
 1732011304; bh=QCcCScG8xrwxU1vMkhV8Jl2p0cgNLnyS7IHhI1EgjOA=; b=q
 9xAJmJNn3FZUSSQI2OOaQpNraPWGGZLQXvWn/VxYkAjNsKEzosqoanDe9QZeMXfL
 GvQSHY6mgkSN6af2SwapGFXlvZBmzpTYyOg3GLHTyNwZtGTmFGj9oEcdjMK5CKfK
 mBi1ZVDPVcyXyRoEmRQwVUJeSfB+e1xoEfkCsK72a0J8LcPMhSsONq0XJ2U1RQVq
 caTXux5ikueV38MOJefOmULip2v8JbJDMLZjp4q5C8L923xGhrNselRyxgRqxhMn
 G9/zjLMJidOEGJjop9tRtvaLklgu9Sd28jDK71Lf3YgHKw1YBGFdEA6h0wWNX1cQ
 t0jh+dyCAGe9mYZtRhdxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1731924904; x=1732011304; bh=QCcCScG8xrwxU1vMkhV8Jl2p0cgN
 LnyS7IHhI1EgjOA=; b=F7HO+x/KeqchJ2l51WQwfPqE6GRpxW8mT9ODA9U/sHpI
 cxHqAsNNhDmulQAPvTzusS84PVfc2GdJIor5qtsJnmOro7/DSaAj5RVlpUpuGDR0
 vo/SaYjkqqJIB+UO39wFB3/fr3DwfQbuHxYB+jyHYEgBIphEpcckP8dgZCsVcWqM
 tFgy+W78bhLfvG3f4LJ0rNg+NLj4Rtsf865RaWRI+ohBOer15WIpNwCGbChOu45W
 RJ56ZkeEvAJoSy44IDJXpCh8S6UO4VUOlAnnKI60lWf3IV8jIukoHztHLAmtvjX7
 ZDD7sArwxLKAmYWL71dAV0PWa2NjxKWsAcTQeZLreA==
X-ME-Sender: <xms:pxM7Z4BY6FmRx0RU4f0M2B0X740VNmo6dUGYyK-ccHU1hXR49ABwzA>
 <xme:pxM7Z6jKZuXKXcN4VHAYOECK4YFkTXRVN2c6E_Mjv5ZHQEWz9FBCbuh_LAF-9PJzd
 PfJWK7FECiD2DeOh_g>
X-ME-Received: <xmr:pxM7Z7mRF4G1Yons1Lb9x1njya6KYDSJInv4tObz7PIvVUM76t9wwW5drcPID6rGIB3cPgSpUpSMVkNOL02_Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfh
 rhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
 eqnecuggftrfgrthhtvghrnhepvdffhfehfeefuefgheehudelleeijeeuudfftdduvedt
 gfehhfdtfffgveekueefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohep
 jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghroh
 drihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthho
 pehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuh
 dqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghr
 nhgvlhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorh
 hgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:pxM7Z-ytZC0Tigz7_KR93NdMXCAjeWZrxOtrpIGEimPhiood9VF55g>
 <xmx:pxM7Z9TZ8wF957tBn6qrKFlgxbCehyUmC9nwEovH7q-Y12c7cN-kyA>
 <xmx:pxM7Z5bT3hLYV6yMcG6MnffjFwvxs_9vRY4yE1wHo1Y-m3scwj6lAg>
 <xmx:pxM7Z2Rs3s-EVnKg_38VTc1sHvTwHYCDKz5BfLMXz_76ngNBAirMTQ>
 <xmx:qBM7Z-ROONM9oh0vQOur5ZcoTeYTHOnrnn1kPCVWUrYzWeKc0DPgPXuo>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 05:15:02 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH for-9.2 0/4] fixes for hw/nvme
Date: Mon, 18 Nov 2024 11:14:16 +0100
Message-Id: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgTO2cC/x2LMQqAMBAEvyJXe2JiCvUrYiG60StMJAERgn/3c
 LphdgtlJEGmsSqUcEuWGFRMXdF6LGEHy6ZOtrXOKBzuE+zlQWbTdr2Hc3D9Qnq4Ev6g+4l8TDw
 0lub3/QDe1XSuZQAAAA==
X-Change-ID: 20241111-nvme-fixes-1038fe44e48a
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=647; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=MD4MSANoF3QQq0OaQB4n5++JHTwlMKarWBGjw0fzgqM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2M3RTZSZi92NEtmK2hUcGJlc2M0eEpSanBtCnVLNm8vKy9HelJtOTZWY1I0
 RCt5dklrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbk94T2t
 BQW9KRUUzaHJ6RnRUdzNwdEs4SC8zVktuTlFKOFJWUjZDSEtRU0RaZnl1SXJ2czRRSnppZ3V1bg
 plSFBvZ3p3VlB1WXhiUENYUC96c1JTMUpWV1FncnZ0RHMvZndIVmdpanNDWUNRU0NUK3NVVS8rU
 k1xc2g3M0FsCmZWMGt5WU1uMzNJZCt6cHZwTmxpL2dsUzl6Z2VzUDlXUnhaY3owdlhPM1VLUTM2
 dWdyQVJMNXhKeHlTaDRVNXQKTUhqeU5CRVQvdVVEKzF0WU92Y2FjZUZ6VEtyay83Rk14YVRpUFB
 neWpZVFlTOGFWKzlINzhoQW9lUVhzZ29CUwpaaFhIMDZuTFAzVS8xK2NPVVFQNkx6T3k0L3pYUD
 N2a09xTVhDdmZHZDRFb0xKZGRPemlRekJmalQvb3N3S2hLCnVaY04wSlljVDFqdjNHSVZFZ3V6N
 W5GcEI0a1NsZXgxTlFHM1oyREVKNlZjNFpwZDRmWVNWS3dTCj10N3VvCi0tLS0tRU5EIFBHUCBN
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

A set of misc fixes related to SR-IOV compliance and MSI-X.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (4):
      hw/nvme: fix msix_uninit with exclusive bar
      hw/nvme: fix use/unuse of msix vectors
      hw/nvme: SR-IOV VFs must hardwire pci interrupt pin register to zero
      hw/nvme: take a reference on the subsystem on vf realization

 hw/nvme/ctrl.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)
---
base-commit: abb1565d3d863cf210f18f70c4a42b0f39b8ccdb
change-id: 20241111-nvme-fixes-1038fe44e48a

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


