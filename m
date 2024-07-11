Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AE2C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyAR-0007tX-A3; Thu, 11 Jul 2024 14:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyAF-0007Qv-Oj; Thu, 11 Jul 2024 14:05:08 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyAD-00049P-Ur; Thu, 11 Jul 2024 14:05:07 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id 062D313882AA;
 Thu, 11 Jul 2024 14:05:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 11 Jul 2024 14:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720721105; x=
 1720807505; bh=16XE17NJxZw2A8g+Vm9cyATPlkBsPC8Nj8Sy6oWvyTM=; b=C
 /I3b3XQOzsPrh+pdssubRMr5R+b37lbbXYSfc8xff4qsSNhFCFUDczxZjv1IYASG
 EulvEoUd1g2IXTRC/adhvUpu5Er/+3iD9tzMs0ZkzV8wGnu+lfOjNZhv3dzgfR8W
 6Y3dXU4XAmoO+ynLVrqtyrmRW53p/rMFN1M7CmyFDilt8lyzySbPzl+uOJC+5/UV
 lzlnuYP/G5XofI8Sfpms4TuIBzEJ7tJobsu/KwWYlHbrJnI6HTXdK/JUOhugfdQl
 IpG9GZBJN2jRN/cgIeVATD3kcAjwfe9oVzvRlbQJjZt3tnNIqQ0Dzj2DW2p2Yz9d
 oA/tM+GAm6qtspax9B2tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720721105; x=
 1720807505; bh=16XE17NJxZw2A8g+Vm9cyATPlkBsPC8Nj8Sy6oWvyTM=; b=a
 US9kXSbpjRO8pTBW0xtdE9yBUvjr05A7k5I5DnkEIfgrhRKUtUIchMb9HsMpt4u+
 TjFCOyVzHrEahiClfQ2k0jetlBcVV/qZfkeFveZYGTqSbX82bIAECSmREHv6Fp/w
 zfYNkxnKQ1b6wohKy6HUXFe+V3Fypj4O4l5Dog3rFf49XtyiWSQkIwE0k8K9q4SD
 ABuSYN+l5xccCiINn2U8E7/KHO/TpO+tPGrpT9CJASfNIqFO6lP5WMeFriXQiH2z
 /0D936HOpxB+i60JMmX3xQx6NHjRkAjYD6kb2zJqta2KkVDlq+BDZHO7mfgGBvD0
 SPlmyKchGATCZoPB2SOGQ==
X-ME-Sender: <xms:zx6QZkkRI3NCYh5h0e5CXKBdPCP13hP1gzfJ0U00hniQlImHybs-ng>
 <xme:zx6QZj0OuAzhhLtt_3xOmWhiHN7RILkQXuC2dkT48GA6HMYkiBGSqORQczzzKW2Ck
 RbktMHHxUB6imI8x-8>
X-ME-Received: <xmr:zx6QZio2xcTDXJ3SR3cGx8sZAbKLw86Wa8IeApvPbkf6arPu6TTNkJlA-zVjKzMtdsmadpdYyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:zx6QZgk4PZaXGjiwzGZTlp4XS6Gl0glXa2q6ofy19NxNwrTG2844QA>
 <xmx:zx6QZi22-KrPDDuct82NqPWS9z7rNOf2mhCgh7iCpPIt8R-lLr-cbQ>
 <xmx:zx6QZnub9LeDTy78myYR7WcYKpvsO6lPaMja1pIDN-RW5BdcMvdC7A>
 <xmx:zx6QZuVG2IhcK7e2aO7aPZNrTxTGjRnn794M_bj3JSHBWvfbEGJdwg>
 <xmx:0B6QZl1nyEga6Xdy8WkMDrBgEJqC7gzK2J1VCWUqNvk2hwp9XXscLR8P>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:05:01 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 7/7] hw/nvme: Expand VI/VQ resource to uint32
Date: Thu, 11 Jul 2024 20:04:44 +0200
Message-ID: <20240711180436.8532-16-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
References: <20240711180436.8532-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=k.jensen@samsung.com;
 h=from:subject; bh=z5OhNC9T5HEBL6r91CS4qYLYhcYx5tXrG/ktqbgiBT4=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaQHrV7oG7Ny2PuLmk2KP8hxwaafPovrJyX1
 qacs58WP4XIj4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmkB61AAoJEE3hrzFt
 Tw3pgJQH/1DBJAF9KZjsIC6LI04Pfxzoi8SQvuFKSJTXxVU12YuskXaqs/Ak185h8QDwILFqYTx
 CgZUyXT90ei+Qly8utp46VrOuNZjZlmF8gGRZCp4ps2xiqmUKBvg2TVMXGO079qdq7DkvkjN53O
 dJLbSYl922QiIINd5bGMhmDwTtdK5+iw4vr7W+KMZpGTm3O2KSC3i1EZQYGTiuO+RJ2oKIvToNT
 C8Zxu/pwd/9mn88jUunCPNxy3K0C0AEskPX0hcFmVO1zas7X/ZqdZ8MQaRSy2XqyMnzy62MXHmS
 XyQTNuUg2RcOAA1Baa0vf98Bo9GcWUJ3bxV7e9BkHISRA8BWvorR8aJv
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
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

From: Minwoo Im <minwoo.im@samsung.com>

VI and VQ resources cover queue resources in each VFs in SR-IOV.
Current maximum I/O queue pair size is 0xffff, we can expand them to
cover the full number of I/O queue pairs.

This patch also fixed Identify Secondary Controller List overflow due to
expand of number of secondary controllers.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 ++++----
 hw/nvme/nvme.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 1e50b57707ba..5b1b0cabcfc3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8484,10 +8484,10 @@ static Property nvme_props[] = {
                        params.sriov_vq_flexible, 0),
     DEFINE_PROP_UINT16("sriov_vi_flexible", NvmeCtrl,
                        params.sriov_vi_flexible, 0),
-    DEFINE_PROP_UINT8("sriov_max_vi_per_vf", NvmeCtrl,
-                      params.sriov_max_vi_per_vf, 0),
-    DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
-                      params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_UINT32("sriov_max_vi_per_vf", NvmeCtrl,
+                       params.sriov_max_vi_per_vf, 0),
+    DEFINE_PROP_UINT32("sriov_max_vq_per_vf", NvmeCtrl,
+                       params.sriov_max_vq_per_vf, 0),
     DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
                      false),
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 180df26ccea0..781985754d0d 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -535,8 +535,8 @@ typedef struct NvmeParams {
     uint16_t  sriov_max_vfs;
     uint16_t sriov_vq_flexible;
     uint16_t sriov_vi_flexible;
-    uint8_t  sriov_max_vq_per_vf;
-    uint8_t  sriov_max_vi_per_vf;
+    uint32_t  sriov_max_vq_per_vf;
+    uint32_t  sriov_max_vi_per_vf;
     bool     msix_exclusive_bar;
 } NvmeParams;
 
-- 
2.44.0


