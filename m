Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC211C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRy9z-0006fs-Eg; Thu, 11 Jul 2024 14:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRy9x-0006bW-Hi; Thu, 11 Jul 2024 14:04:49 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRy9v-0003t4-N3; Thu, 11 Jul 2024 14:04:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B69ED1140395;
 Thu, 11 Jul 2024 14:04:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Thu, 11 Jul 2024 14:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720721085; x=
 1720807485; bh=patIyWlEXlTOaWV0nBfaOYUpTnvgQDVzdrKKr7JCxG8=; b=H
 4yQgNbL34vG+ySlW0NEJuI4XLp1o6GHhaKKizV4LXwaBKHiPS93/sYIqJEChyIKx
 D/miV0BMbq7nYe/1du1J1GyJvSS25Srd4ioYtmGIYJZoMxGSvNVnXTaUCFpi81n2
 +YnrEA5VCLM6DixRH9K/6ngdMzRP5sbwMGqliG67P5FJZqTty16EpNHv4+srrDEi
 EObkDoX7QFGDWkaiWveO0Si6TBW8TJ1K0vzUyE2sehgssTNitMZ60H5VHqvDZnZQ
 kaDicD3loPktcei3F7WVLjOVS/EOgITEellm0ix2ASBcHPuV+eHVWY1rB2/2Gv5b
 eSDZ43s5BDqP77lEK/4pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720721085; x=
 1720807485; bh=patIyWlEXlTOaWV0nBfaOYUpTnvgQDVzdrKKr7JCxG8=; b=m
 2sfdUvsdq7Nj7cs5QpE+N68qaD3vzktVC9K4DRnxiFONUhS8To1LXXjyIgupXaII
 VvG/sWVtPqLXsS6vaNsOzn5VMbdhPbRRgcxoc31Z5XrSmt4NqaYhzaYK+MEOML1i
 KdmK4Rsvzxf+nq3lk7npn5aL7CuG9B+N3e+JwB6J3eyyhHpIfVpMxourRjCylTwd
 C1RixqqmYMr4DnPx/hc6S+YNVrAGt9cW9suNcuwWwaYPTkw9Lp1m09jOUljQEbI/
 r+i19UJdghsoI3d0K2+pHva2xK78TGMRd1d5eV0NeMAuWhJqfwOB9V1q9iZHYDG4
 0bybp2f9Bn7OSY8StUJMQ==
X-ME-Sender: <xms:vB6QZiKZvJI-mWyfwHu6QpqfkbqVmjFMnK2kOvJQKo3DXMsGgNyVNg>
 <xme:vB6QZqLbL9vB8HSaP_PYJesA8RXFCnhmZYdAxlBkfih7rV2juSRSb-qy-v23WSbrt
 u1TWj9TE4xmZNyhRqc>
X-ME-Received: <xmr:vB6QZitobD_JTKKnD3qMozdInsJwe3xu_-m-3g9OQq_kvkWjN84UD3-8vrg2pfL8JLkQJX0EKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:vB6QZnZoRv0F4cgaSask03P__SOTTnlMQGrNoLfn8IYUw0i3bs9yHQ>
 <xmx:vB6QZpZC4PXhk6ZcsNkiD2UFHZqNlht6gdAm72dCRb8a8FQAoyz8Rw>
 <xmx:vB6QZjC6fSP4raZ3TAZtdErTzcNBAuFY61meXne8MWgSbB4R19dvNg>
 <xmx:vB6QZvb3rMhhiycvexgbRv6KHuq4VzSaALCortuCPLMH51mVdwXocg>
 <xmx:vR6QZvzLQLFuYAw707LjIr6p05iJKXqOaj-0YAEB9YxfzfaTrY6R16mU>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:04:42 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Berg <jhnberg@amazon.com>, John Berg <jhnberg@amazon.co.uk>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 1/7] hw/nvme: Add support for setting the MQES for the NVMe
 emulation
Date: Thu, 11 Jul 2024 20:04:38 +0200
Message-ID: <20240711180436.8532-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
References: <20240711180436.8532-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; i=k.jensen@samsung.com;
 h=from:subject; bh=gQ/L+AStstwGmhQT28OfJbT+GPJlgZz8VyHUWxR47Hw=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaQHrTOkoI+mD0j/4T6mQ4bel5XgDaZYBOOJ
 czkV1C63pHTf4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmkB60AAoJEE3hrzFt
 Tw3pKeAH+wd+WBLH39yfdSZ5pRBCqh4dfhSxabKKvKwu0t07oLdQLtlxB1kII2xKZ05fyoiQgyV
 lyfpQ7H4NNcY+wzhG0knoKseCiYZ3rPCvGsu3BHH6/ytDap93LxpmCy41cY0q9aOgB+lAcTqjX2
 /RGSMJvmfrxK+Nl5YAgH76mbQI1KrGToskawu95woD6hU/rCnGmgLDBvOEkPmyTN6alWVo04c7X
 AkYwxqbX8d6Sye4SLhmIGqJWgmDp4rqJDgjabSl5aYDhgu95SlteIaPCkQhjoh3jKMQFSMrWc5O
 TAR7D4OAww0G/HfRELuOJ5gZwNrrugAK8qjuduU2z5mGHNMC3AD5iaC1
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Berg <jhnberg@amazon.com>

The MQES field in the CAP register describes the Maximum Queue Entries
Supported for the IO queues of an NVMe controller. Adding a +1 to the
value in this field results in the total queue size. A full queue is
when a queue of size N contains N - 1 entries, and the minimum queue
size is 2. Thus the lowest MQES value is 1.

This patch adds the new mqes property to the NVMe emulation which allows
a user to specify the maximum queue size by setting this property. This
is useful as it enables testing of NVMe controller where the MQES is
relatively small. The smallest NVMe queue size supported in NVMe is 2
submission and completion entries, which means that the smallest legal
mqes value is 1.

The following example shows how the mqes can be set for a the NVMe
emulation:

-drive id=nvme0,if=none,file=nvme.img,format=raw
-device nvme,drive=nvme0,serial=foo,mqes=1

If the mqes property is not provided then the default mqes will still be
0x7ff (the queue size is 2048 entries).

Signed-off-by: John Berg <jhnberg@amazon.co.uk>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 +++++++-
 hw/nvme/nvme.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 066389e391b6..fa7ec0e79490 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7805,6 +7805,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         return false;
     }
 
+    if (params->mqes < 1) {
+        error_setg(errp, "mqes property cannot be less than 1");
+        return false;
+    }
+
     if (n->pmr.dev) {
         if (params->msix_exclusive_bar) {
             error_setg(errp, "not enough BARs available to enable PMR");
@@ -8289,7 +8294,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->ctratt = cpu_to_le32(ctratt);
 
-    NVME_CAP_SET_MQES(cap, 0x7ff);
+    NVME_CAP_SET_MQES(cap, n->params.mqes);
     NVME_CAP_SET_CQR(cap, 1);
     NVME_CAP_SET_TO(cap, 0xf);
     NVME_CAP_SET_CSS(cap, NVME_CAP_CSS_NVM);
@@ -8459,6 +8464,7 @@ static Property nvme_props[] = {
                       params.sriov_max_vq_per_vf, 0),
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
+    DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5fd..2e7d31c0ae6d 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -521,6 +521,7 @@ typedef struct NvmeParams {
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
+    uint16_t mqes;
     uint32_t cmb_size_mb;
     uint8_t  aerl;
     uint32_t aer_max_queued;
-- 
2.44.0


