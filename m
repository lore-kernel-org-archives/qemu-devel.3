Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6F3C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaEL-00089h-E9; Thu, 27 Feb 2025 04:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaE1-0007oH-Up; Thu, 27 Feb 2025 04:30:38 -0500
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tnaE0-0008Hv-8R; Thu, 27 Feb 2025 04:30:37 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 4725F1382F69;
 Thu, 27 Feb 2025 04:30:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 27 Feb 2025 04:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1740648635; x=
 1740735035; bh=piQ0jCwd+gUw5pjvRr3WPHXU0ONE7wn4psJts59xtOw=; b=t
 u9OLu6EoGT6kW3oQCGxMXzIXa3kt5IuMzHYtFqYfs3XeXX/Hfb+mwT+ORTsRIy+a
 kG/brFAgzn0Lnr8ySjffcJLblpVKGK3JrDhjtALUdmNOSRQC2ITvhFA+AEGIoHMf
 BqhVfIV/XmKyR1pTvtliykpzQcvkZ0b2Uq90UdHE+yWI5j9usrMCb84DfkNlETxh
 QnacTjX+oPpm2Ouv5LvDQxPCGIqVDMhJkoz2aUo4/1K/DR3AvZx1IPh+mCpoQTFL
 zzhZJf2O3RpiByyL4rWP0poK7o3xfupXeiljqrYSOgNMbx7vfZF06zaoNkYgExCq
 w1WHjAOxWr6l9CV/RM8AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1740648635; x=1740735035; bh=p
 iQ0jCwd+gUw5pjvRr3WPHXU0ONE7wn4psJts59xtOw=; b=h+ARg9W3C2yBGU4QM
 wXuYVNpKRhxadfYFATc0jFujrhc2PY1qRtO0sypbHHw88sujxYbNjXEwGfF65t+w
 qhgrIDUyNJ/Eab6f92Ax7nwAuA8Yf2IXaLmCMFxnZQcU2tWZc5Uigkntu0jHSEob
 VHI7JFvY1EN+XlHUKCDxzxeiqYX2cDgoY5KnWoGt9OaceUNf11EucqGdQ2EkOgPx
 8jpxOE8MSfx8lFIKhmrEz9UrxB4XRxZ6Ck4a3GJxMrBUd8Bqwh8XlaW6xBoY2ted
 /UydIarFCy4jyY3NG35tS2Sq7pAAwVlbPwF6gm/MlXrWPsig2+mkjS5bjl4CSy1h
 +/a1g==
X-ME-Sender: <xms:uzDAZ1fra9PTyiN9iqmsFf8fA5kcttQFzAUYg_AQNyTBDzc1ydV-vw>
 <xme:uzDAZzN6jagzzZ6SEb5JYc3cerdGd6CA9pafVNfUoXsGeUhmeGgRDQ4VbrDGqiFkE
 yqTKotuy58PUxeHo1A>
X-ME-Received: <xmr:uzDAZ-gxa7jx6Y1xcyr76FpcLs6kIdRK7OUEUqLMSHGCFT7QyLEclSLoSJ5yuMzSYnyXSS-K1R4-ewCdobGTqfP2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehl
 ihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtg
 homhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehk
 sghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvh
 grnhhtrdgukhdprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhr
 tghpthhtohepfhgrmhesvghuphhhohhnrdhnvghtpdhrtghpthhtohepphhhihhlmhguse
 hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:uzDAZ-8bPkvyN6i5QN5y-algER1Eo9aTohepY22ljM3MEkb3Kercdg>
 <xmx:uzDAZxtjIhVczOeVajAPUS2VmhLDtmUQwrDZvbPT1ywuXNOMYh24bw>
 <xmx:uzDAZ9EQeSw_B3D89OXQwt8_X1sW4lIZKoC1vg4k7je2S7SxVUnQOg>
 <xmx:uzDAZ4OA8eUsP_iwpt1P0WY_ZtyvVRvsS7aJgbvEkxHgKPgX-DoTJQ>
 <xmx:uzDAZ6GnWkewpSXnoEmyzQ7-4z3gaHQrBLaeoLej5TBxtxwXCyzW4VTr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:33 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 05/10] nvme: fix iocs status code values
Date: Thu, 27 Feb 2025 10:30:12 +0100
Message-ID: <20250227093018.11262-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227093018.11262-1-its@irrelevant.dk>
References: <20250227093018.11262-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

The status codes related to I/O Command Sets are in the wrong group.

Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 4 ++--
 include/block/nvme.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 1ad76da943a6..2b73f601608f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5681,7 +5681,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
         return nvme_c2h(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs), req);
     }
 
-    return NVME_INVALID_CMD_SET | NVME_DNR;
+    return NVME_INVALID_IOCS | NVME_DNR;
 }
 
 static uint16_t nvme_identify_ctrl_list(NvmeCtrl *n, NvmeRequest *req,
@@ -6647,7 +6647,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     case NVME_COMMAND_SET_PROFILE:
         if (dw11 & 0x1ff) {
             trace_pci_nvme_err_invalid_iocsci(dw11 & 0x1ff);
-            return NVME_CMD_SET_CMB_REJECTED | NVME_DNR;
+            return NVME_IOCS_COMBINATION_REJECTED | NVME_DNR;
         }
         break;
     case NVME_FDP_MODE:
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 63eb74460eac..aecfc9ce66b4 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -906,8 +906,6 @@ enum NvmeStatusCodes {
     NVME_SGL_DESCR_TYPE_INVALID = 0x0011,
     NVME_INVALID_USE_OF_CMB     = 0x0012,
     NVME_INVALID_PRP_OFFSET     = 0x0013,
-    NVME_CMD_SET_CMB_REJECTED   = 0x002b,
-    NVME_INVALID_CMD_SET        = 0x002c,
     NVME_FDP_DISABLED           = 0x0029,
     NVME_INVALID_PHID_LIST      = 0x002a,
     NVME_LBA_RANGE              = 0x0080,
@@ -940,6 +938,8 @@ enum NvmeStatusCodes {
     NVME_INVALID_SEC_CTRL_STATE = 0x0120,
     NVME_INVALID_NUM_RESOURCES  = 0x0121,
     NVME_INVALID_RESOURCE_ID    = 0x0122,
+    NVME_IOCS_COMBINATION_REJECTED = 0x012b,
+    NVME_INVALID_IOCS           = 0x012c,
     NVME_CONFLICTING_ATTRS      = 0x0180,
     NVME_INVALID_PROT_INFO      = 0x0181,
     NVME_WRITE_TO_RO            = 0x0182,
-- 
2.47.2


