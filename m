Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01948C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVw5j-0001tw-K9; Mon, 22 Jul 2024 12:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5c-0001m1-09; Mon, 22 Jul 2024 12:40:44 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5Z-0005v6-Np; Mon, 22 Jul 2024 12:40:43 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 319CC13803C2;
 Mon, 22 Jul 2024 12:40:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 22 Jul 2024 12:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1721666438; x=
 1721752838; bh=xcR1yAOVdLASgJlPJFEgnT1h7JNGWxb2U6Tq0lR+J10=; b=q
 atwTkvYaqo4KvdJm9Wld5xulOaSI1PxBb6N29wL1+OEHiyEOMN7QDr1lNflmJ/HU
 sFqvJ1R7mp44H5ioK4hb+/ee+9totsn+rYyY/asaJaPSsDXx8TlN3FLh2/oPoexs
 QahiyiS39qvpKDkNdpnyi5FB2AOfBSS/IxZGhlUeK+7PpkofG+MSR1n5Kyu/uCV0
 CHT7T9gOMtP9E3dEXU0Pv9WZftUwfYtjeEwmCU6KV318DfnlYGd0n1i/EzKiXLz4
 XJjb1Mv6mGEc1RRB5AtjzPmyDM21zLrZwtRzLRqDPpWPkGlE8biv3muPJF4/749i
 HNUk+iFNAESh4D4u91zlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721666438; x=
 1721752838; bh=xcR1yAOVdLASgJlPJFEgnT1h7JNGWxb2U6Tq0lR+J10=; b=J
 kEUGcTreGp9qmzLpfA+bheEqHX8ICgrGegI1j27BKr+BbGdKMu/UP+k2IwpDv8Wm
 IuOK/qH6TU0S9HCIzG+6P3FYvhdkCQVRvwDGTBUvSid02wfMbmLm132VYizY0Ati
 q1lb3xRUzGpMxvK7ir1UnyqcP/TwTFxH2Icoj2B3B6INIxSfxaOtXO5qf/0CbJht
 F2B3QtyTPZjD+KHhuiQv2T3hwgwCy8YB20dDs/sIMAdUu2aqptJdVFdIQktWcR9X
 F0Z4xCiDTaPivbI2MZIMbAERrz82ZW03i1dQFGcaQOvxLVmaw/Kckc+NAoNHr4jE
 3X7Q9P2bBnOiH+/YbfmyA==
X-ME-Sender: <xms:hYueZtNHIbsy1UksymLbMIqM60cft3r_UJpjuAiddPVOquNH2mcZuQ>
 <xme:hYueZv9CLQwwRxeKga6EJr95pz1PEfv1wHh01p4ltBppQRt8wQt1ywUaMCHHWtuiN
 7hhlK9rvPiF3Hh93g8>
X-ME-Received: <xmr:hYueZsT46rUQ4Dh8ypfExNuy5OkzvLhMdD9phfVNjyfIZRzDdjDcOTIEwlb7PfIw7vVmeaggDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgddutdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hYueZptvHyJPi6booMmNCD6x3KsVx5dCHwI9F_rcaj2AqrNVs39log>
 <xmx:houeZleLz05iokXbvJFQF9YRJWby4Km8tPHZGd_0IE4wSUYBUiXM7Q>
 <xmx:houeZl0aqWweHEBiCtSUi3vRTZAD2cYKMwbxz9uOiPPcq6XxJIgVcw>
 <xmx:houeZh9ZCZhuS8d9Ipfz5txZ7uZlevnYjJ8K6Hw_G97pAGsYAlAZMw>
 <xmx:houeZg3WyJqYbPXe3XmeLWiDFQ3J926wzR1Vg0zBQLT7c5-IbrQRNQl->
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 12:40:35 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Zheyu Ma <zheyuma97@gmail.com>, qemu-stable@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 1/4] hw/nvme: fix memory leak in nvme_dsm
Date: Mon, 22 Jul 2024 18:40:28 +0200
Message-ID: <20240722164026.61128-7-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722164026.61128-6-its@irrelevant.dk>
References: <20240722164026.61128-6-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=k.jensen@samsung.com;
 h=from:subject; bh=VvCHL/jXjJB40xqUePuYD3s+RJVRAW1gGbIcWezBdXg=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaei3s+b5byopuO9jTCOWW2RAss+KEEViH1g
 ga6pM7c3b1gsokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmnot7AAoJEE3hrzFt
 Tw3pxB8H/jV2O25OAaMv9sIiwpbKDD+hc+DCNKlIAYRKqPWwygDx36Ii9qOP9EXWBWUz11awlYk
 FQlHc99PLvCIE5LhVBtBkjIyeYKRr5OWapE467GPRrGJwxfttjg4g1dEn+mviUeApPh95Zr6As5
 TbIrRtKM8fqJ5QmhT2yQycF7tQBDqDHRkSetxPGhdzndfoTQb6fzfyGh8cxbWPqvFLIBvIF8+xs
 ZM7dybuZlSjdiN20cbO5FWDhZIIr7rHZNISrCk9PlT7Dh9AR8yRuqV/7pQ2vtzGjhKNkjtV4chs
 ny61KZMteQlFLwb+a6UwwOUr49Fm2r7e4QgWZioDtlU0/KxMF+7UT6ry
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout4-smtp.messagingengine.com
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

From: Zheyu Ma <zheyuma97@gmail.com>

The allocated memory to hold LBA ranges leaks in the nvme_dsm function. This
happens because the allocated memory for iocb->range is not freed in all
error handling paths.

Fix this by adding a free to ensure that the allocated memory is properly freed.

ASAN log:
==3075137==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 480 byte(s) in 6 object(s) allocated from:
    #0 0x55f1f8a0eddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7f531e0f6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x55f1faf1f091 in blk_aio_get block/block-backend.c:2583:12
    #3 0x55f1f945c74b in nvme_dsm hw/nvme/ctrl.c:2609:30
    #4 0x55f1f945831b in nvme_io_cmd hw/nvme/ctrl.c:4470:16
    #5 0x55f1f94561b7 in nvme_process_sq hw/nvme/ctrl.c:7039:29

Cc: qemu-stable@nongnu.org
Fixes: d7d1474fd85d ("hw/nvme: reimplement dsm to allow cancellation")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5b1b0cabcfc3..f7b4e4627dd2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2591,6 +2591,7 @@ next:
 done:
     iocb->aiocb = NULL;
     iocb->common.cb(iocb->common.opaque, iocb->ret);
+    g_free(iocb->range);
     qemu_aio_unref(iocb);
 }
 
-- 
2.45.2


