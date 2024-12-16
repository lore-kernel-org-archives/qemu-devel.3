Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0B8E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAcJ-0006sZ-02; Mon, 16 Dec 2024 07:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbq-0006Xs-BW; Mon, 16 Dec 2024 07:54:02 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tNAbo-0004qd-EP; Mon, 16 Dec 2024 07:54:02 -0500
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 9B9AF114009C;
 Mon, 16 Dec 2024 07:53:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 16 Dec 2024 07:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1734353638; x=1734440038; bh=r9epBbkm1wQQ7uw9a461rxWc+dB0unZN
 n4KULiKW6Oo=; b=krxxo4rw/kunvkrsTO6MYsZr1zJkBYRMHb6HaKrrgfe9YcbB
 AxADMKNtUaW7Pu5AdcNzEKvi+wR+Zn/kMTUoXwtoHBEHgiyyeSkcY6wNvuyP5fEC
 8Ukiedv16OqE89tPA28y3nGZODPEZvC8okWu8HVnXBW1hibrBibKwNc+jDmcJyyS
 BYzk0tHPpcmsLd90Dr+sIGLsbYrJXRy+CbF7MKQCZ/HgrXGDAvZ1nNaH/S2d/nxr
 XelaqYXiUxqO6VXf04VnNW8JZAUaOjh+2mvDb6r8tcDr53a2Ci47LlxP5BLmy2uT
 CAOIRxw31QTiX2ULmzlVu2jvUUEYJIvXTte6Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734353638; x=
 1734440038; bh=r9epBbkm1wQQ7uw9a461rxWc+dB0unZNn4KULiKW6Oo=; b=y
 21wl1aoU58CmIfgtzWyQf153JIEh78pVFzSGxRFsj5idTuGfQIkZ6UKyb5XSbaWT
 ckITWCf5pRXFAtQc6RUqGuQ8DA8x3KyiJi3t/+lptJktlOzjuDhxLij39qMRbiZO
 iB9Qq/d5OjT5HpoU5uIePbcXsgmzJnPtQTarN6jiOaC4MjbKfUeNj5tG+sgWgQSd
 0GK+fvyqOvWeljQrH923rLzhHAaspAyUXMqu/Xa+Dso3c6luI0ruysmhJi92Up01
 O8wqEk0m0vrhLfrA9FvgwkU6x4oEvCLiOd93yI9m3szU9KwJ4Jgh8p81ndzeMjWz
 Hi8SYv5QWE51kRr94j5Mg==
X-ME-Sender: <xms:5iJgZ8tqdf2oMEiPF0pzSjL2Flc7UICCCHiltg5HZSJ5rHoVSTIZNw>
 <xme:5iJgZ5f2Ci6iRQgDgunDKW55S9rufKWd-KiMgudezopasETGhVC1EJj7_eFIb2bRv
 -FY8WR56edv-nBNsGs>
X-ME-Received: <xmr:5iJgZ3wAy7CvkJMaMdfjcJ0TGzOBAo8D2uaUC-MUCJHs24QSvtJ5jznX44lIndYxwp0kVEij99nxzKShezf48mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdegiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdp
 rhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtoh
 hm
X-ME-Proxy: <xmx:5iJgZ_MIEujjwsgmPqpm43_d9kYGChsiSDqvUXxY9M6yrK3NfYXxoA>
 <xmx:5iJgZ8_l_zm2yjkeFmrAMmbZB66GZxXcSqleeWwElYblePzCRRhP6g>
 <xmx:5iJgZ3VvJ3iUhn0auri1RyWQs8A5NlMJTWkBQhroJ2wBUPkVqwUnSQ>
 <xmx:5iJgZ1ckZz8UBmmdtFfRD-mS3L5Fxfr3l5gldbgOEuJSjEOegOL2Yg>
 <xmx:5iJgZ8wYD3Wh5z8kj0BEhHGJ6D3YC55WNiIGRNTd2Nc6zgVzT0kftPpo>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 07:53:57 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 16 Dec 2024 13:53:05 +0100
Subject: [PATCH 4/9] nvme: fix iocs status code values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-nvme-queue-v1-4-4e42212b92f7@samsung.com>
References: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
In-Reply-To: <20241216-nvme-queue-v1-0-4e42212b92f7@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=hVGGanRiCXCVL65SS7momc62QHYk6VKSLoOWiILVNxk=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2RnSXRtYXVMUWQ2ZG1ITS9mVXRqYXprSmZTCk15aktkTzdOV1ZCVEpxaGt1
 Y2hZZ1lrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbllDTFp
 BQW9KRUUzaHJ6RnRUdzNwbUFvSC8zRitPTENaU3EwREU0dTYwcmRianpxYy9sR1RoRnRlQlNMZA
 p2YkhxYVVTRjJ5TFlyT1J0S0tIOE9Lc01zT1krSDlQTUo2Sm84Wm43TG93c2J1VUNaWGhXZEhHd
 0lFaWI1THhHCmFMZWRVeEdLejBmWjluOXE0dGtmNG1veVJmUlFycnhoT0ZndjdtNUFDNk1SRGp3
 WEhNdjJFdGo0aUxuc0tMZW0KUk5FVy9qY1MvWmRlN2JMMkRtdkNZTnkrVEhySXBsL0dBMXE5Zkd
 mUGlhMXFOUktGaDQrMFJFOEdJMGhtQTBrKwoxWTRaQXd5SHg4Wm1SMWlGb1dnTStESlc4YWVJQm
 x1WXFGV3I2b01Wa3FQVldUNWo5RFZTTENHVjZ0Rm5ZbTFSCllIKzlQU3ZSb3NoTkNRNGJrbHlZV
 jhaR2p1NHh1RDUzYUpXano3c3BKVU1GTlVONGpaaDFxNmRRCj13MEgwCi0tLS0tRU5EIFBHUCBN
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

From: Klaus Jensen <k.jensen@samsung.com>

The status codes related to I/O Command Sets are in the wrong group.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 4 ++--
 include/block/nvme.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d544789f92ffe6b758ce35cecfc025d87efb9b7e..120a1ca1076c8110d8550a5e75082c6ed4f23e16 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5623,7 +5623,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req, bool active)
         return nvme_c2h(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs), req);
     }
 
-    return NVME_INVALID_CMD_SET | NVME_DNR;
+    return NVME_INVALID_IOCS | NVME_DNR;
 }
 
 static uint16_t nvme_identify_ctrl_list(NvmeCtrl *n, NvmeRequest *req,
@@ -6589,7 +6589,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     case NVME_COMMAND_SET_PROFILE:
         if (dw11 & 0x1ff) {
             trace_pci_nvme_err_invalid_iocsci(dw11 & 0x1ff);
-            return NVME_CMD_SET_CMB_REJECTED | NVME_DNR;
+            return NVME_IOCS_COMBINATION_REJECTED | NVME_DNR;
         }
         break;
     case NVME_FDP_MODE:
diff --git a/include/block/nvme.h b/include/block/nvme.h
index a68a07455d0330b8f7cc283da0a5eadbcc140dab..145a0b65933a699504d6d89222f7979a06f615df 100644
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
2.45.2


