Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223F6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tNg-0008LV-7Q; Mon, 06 May 2024 04:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s3tNL-0007yZ-88; Mon, 06 May 2024 04:07:10 -0400
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1s3tNJ-000887-5u; Mon, 06 May 2024 04:07:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id A301411400F4;
 Mon,  6 May 2024 04:07:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 06 May 2024 04:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1714982822; x=
 1715069222; bh=ToGsE3re4vDluF3Y7EKO0tvz3XQaP8vS1/m4Y84KrUA=; b=S
 UZIa9eXD8uYqB6J3qu6jJvyPN2h2YPs0XFGdCjRy4bQYv/lNJMSHHWKgMzs/CWPc
 k+OWX4mMposRpphgrTQBsSDAF4gNKBFMIJLuZ9ItJGjgwbUVV+kKJIsBSyk77MAF
 b8CMohFZr6UIl/7mOBIBW8wCsSb4wKylQunsQOr16eq8o/5FnvVooFkAlfpLtqMv
 uV70lPFgQgPwZMGVhSZNogAO+OZczABzHprg6t8dYGsRO7Zjld/nkAEs0pTe4Rx2
 HrweNpZ2E0TqQWGAhABgTYYtz9ymRqfN2U6scZWwmCQSpnqqpNOBCB4OYz0vR3xr
 8JD0xraH70IYGBoFSwn6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1714982822; x=1715069222; bh=ToGsE3re4vDlu
 F3Y7EKO0tvz3XQaP8vS1/m4Y84KrUA=; b=B9NKxEdZ02uT2GX0UHOmDYyI3bFcf
 u3C5FPO4Olhf3idmKkTvG/2fvztDFNtT+dHZf/rvpQESpmO7ajnijhe2/YjpUXhG
 1r5mQpxdnRDMpSA7JCY0CYyvRP6To2t2xpecEMDNWPwGRgjz3cft5Jd3mgSofgjK
 wPb2h2YuxS4rqYqWQlFlTG8P0QsLFs6KsugQ/O/izMi9D6HQ8cznh1enSt4uTvxC
 1O+Ds7rxd4PQ1689bDtVDMDVP1Jot4y1Bn3lHIEvD5rYngQWwqCWWLAys/kdXxp9
 1LxdldLG0dMbbPE+DZKv2gXULe0nQn9bg9g5jkvuOjoZ8/hn0lcl04RUA==
X-ME-Sender: <xms:pY84Zs_q-UemvIjQrgSx4zOSp92ZaI9oci_56CE0t6fsK1m-GBdKuw>
 <xme:pY84ZksQKW9bEWfvVP4F6gjNVjG8sD1NO8dv1k8Sab6_zd9rgeZfRQEH-krAplem9
 1sgSm-Cswi4qelLw8k>
X-ME-Received: <xmr:pY84ZiCqoz9Ok40rOkstI2P2g-rCXish0uwZNRsTkagvyvP2eIraahpGW0DunETkZxf7MHcokHeTT6tfnPxbmDXdBD1UB1VT-a8ZthCrKfGGcAFPkvxR99wkvKvbkKeXpVPG2d0tbdAAuHc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddvjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnheptdehveejiefhgfegiefhfeehueeigfeugfelhfdtffevheffkefhkeegteet
 ffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:po84Zseb6_3vL3fCXslx3y9iLCMRnamPOqIOZ_9kG_gMLIpVJJZbQg>
 <xmx:po84ZhPi_TQvugaAsRDT-cw6n9MPJJo7WZri9A73wp3cvnXJJv1t8w>
 <xmx:po84ZmnwoA10kuNSF08-xXI6oLNkceIurRVJk_u3FoTsrzLSHS9Xag>
 <xmx:po84ZjtE7oYUrk-y9CEXEKpKDTwwWWflBeZjo-jhL0z4G9RB1iUkSw>
 <xmx:po84ZtChg-tjHvVLeT_Y1ZiozR0ZJFRPGrkv_Ia9ErMFPbK7X1mg20EE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:07:00 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 06 May 2024 10:06:54 +0200
Subject: [PATCH] hw/nvme: fix mo field in io mgnt send
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-fix-ioms-mo-v1-1-65c315531850@samsung.com>
X-B4-Tracking: v=1; b=H4sIAJ2POGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMz3bTMCt3M/Nxi3dx8XUtzA0uLZLNkU2NLMyWgjoKiVKA02LTo2Np
 aACkUJ9FdAAAA
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=870; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=AGGihcdJhqjHmbqYeZO/goo4qm0ktgvENouud7aj2fc=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGY4j6RO1/WyVxrcwTngx2lnYSZXwddQahkUy
 Lzxlo0qFl+AUYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmOI+kAAoJEE3hrzFt
 Tw3pTKkH/iY1sN4nSFE0MTo51c7jXXlq7nfYy07+g8E92k5GgLrqXMX+r2FLaTqzouwtG+N4DEl
 Cvpu1/t/EosIPJG01ee67gRhBa2TEpoSBog2LpAW294yMtDG40FIOyG40zj12/rc6qaQ51DHA/1
 LWkFvl+QhMCTtHAcTXEtXBpRQdcLekbMheg6V0xg3QmXu5fHKbqIINCgfaVuDMr0FbD1o11SdKc
 HRBE9JsI5ulHtzZ7Y0s7QUSQ8FKnU7wHbY01Y9f+epq8pjPqnVO+wpHBQIusYd8Sceloe0SX33u
 2lIcjTVDjkZGEIeyMilyKL8vayiOvIQOvgZ0X1K3TVVhagX9mKKj7KfD
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.155; envelope-from=its@irrelevant.dk;
 helo=fhigh4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

The Management Operation field of I/O Management Send is only 8 bits,
not 16.

Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 9e7bbebc8bb0..ede5f281dd7c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4387,7 +4387,7 @@ static uint16_t nvme_io_mgmt_send(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCmd *cmd = &req->cmd;
     uint32_t cdw10 = le32_to_cpu(cmd->cdw10);
-    uint8_t mo = (cdw10 & 0xff);
+    uint8_t mo = cdw10 & 0xf;
 
     switch (mo) {
     case NVME_IOMS_MO_NOP:

---
base-commit: 84b0eb1826f690aa8d51984644318ee6c810f5bf
change-id: 20240506-fix-ioms-mo-97098c6c5396

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


