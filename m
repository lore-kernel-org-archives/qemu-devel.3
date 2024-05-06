Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92426C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 00:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mJE-0003x6-G7; Sun, 05 May 2024 20:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mIw-0003s1-UC
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:34:07 -0400
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mIr-0000QE-0y
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:34:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id EC2831C00152;
 Sun,  5 May 2024 20:33:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 05 May 2024 20:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1714955637; x=1715042037; bh=GzIxndmltz
 Yd7Z3Vh6Vc99wk3Tg6uvlrTPvLOMRcggc=; b=UBOUVlq0sZA/UHdiYCg5UBV7Oh
 pRBfXnQE40nTRmActFjoSYgbVXWW2VyBr3sDxVs9Um+ZNyyD38haq7ScfHfKZEFX
 kaz8y6dT/WBBvmY+xlqdpzrGVgbTLemTOowGHiu0aG1/BSufOc5Eg1a8SM5g1djr
 j+sjstYgu7sV38FIpgHLh79bFR6kemcOCgdIiHphD121Og805Y129zgpunXXalmP
 Y/QlDpezaGWvyQzMsvNnaF2ESGa6Hz/XPobVJ0jHNQ+mp6wqVWq5RI+pyFVGkT6M
 Kf09aujSJ4aN8dPSSd3M53hDw3TY8KMtXpbJG2OdLdkAxvbdhgZ6wWFOxytA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714955637; x=
 1715042037; bh=GzIxndmltzYd7Z3Vh6Vc99wk3Tg6uvlrTPvLOMRcggc=; b=K
 ShN7G5D9D5QrxGKzG9cNmuI1x47tnvZMIFY/c/i3hoD2Jc4x4knuD6EkhM7W03LZ
 RHyt3Xugy+36+ZjYtHuxO+989zv0vUwZRi3AP7jzRqmUpVy1n4uApM0gLJZUuxt3
 Kb0Viz7NRJr5O4MRk+jSx/Y0D/VDIj55b45uRVcbeC5IuwpLSWYbk1XKiVpk70km
 wpcIfjAZRDHNuy0XioI4rIW9KOqN/vNd+2wAhCZZO+UdtUCE2K1w6daosDAM/8rx
 w/NBlBmESZO7xNDiJkxj+0Xc+1MdoTaDca2thA6+t1NfjWnm7gZkrURi7dkd93ZJ
 HZ+/K/X0hHIlsQGFNRG4g==
X-ME-Sender: <xms:dSU4ZviwT1LkRKirUO9NbStaFbILtt6mj0LKFcRMtRtdlKO3mXGuQQ>
 <xme:dSU4ZsBFgyESZyYH9Z9Ve_uR-tPAH7sWv5x_J2ZY-WYwxuYVl5lPYc2E9UsPuAsLT
 1_puPJjJAUqLA>
X-ME-Received: <xmr:dSU4ZvGK7_mo87Vc-yheInRDfounq8U8PMLsbOBDH_iERF8jiripxpp123ZQGCEzolt6i-LPiEqq_5Pit6GLRX4kFp5Q4PEy4LbAPE9AEQ9UhNnkv0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghr
 vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
 hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefg
 ueduhefgvdefheehudejheefudevueeghfekhfehleegveduteeuiedugffgffenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgv
 khesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:dSU4ZsQa4vqnY-k7Ra-9DijZl8rWi5rOIwRjUW8xeYA-cATrKo3nGw>
 <xmx:dSU4ZsxBRddJIqg-y0CFRpzvdLiRZTia3mRLNbrnglxVJy24o3Hczg>
 <xmx:dSU4Zi7okPLiBl1sYhesIsSJD533OUNae4rTo6uklqg6OoTnE3r0zw>
 <xmx:dSU4ZhzBUdk4xxe3ME6haUCTMQFXESHLHeW4_buhxDL7A8sn-LIgPQ>
 <xmx:dSU4ZrrQfW9tKVP04a53QyayFTZM2zIthOp_70gFQdsovibaJO-1Y5n->
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 20:33:55 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v3 1/3] hw/xen/xen_pt: Save back data only for declared
 registers
Date: Mon,  6 May 2024 02:33:20 +0200
Message-ID: <aa391652c33c8a4a64db8f27ad50ccb65600b293.1714955598.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
References: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.148;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfout5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Call pci_default_write_config() only after resolving any handlers from
XenPTRegInfo structures, and only with a value updated with those
handlers. This is important for two reasons:
1. XenPTRegInfo has ro_mask which needs to be enforced - Xen-specific
   hooks do that on their own (especially xen_pt_*_reg_write()).
2. Not setting value early allows hooks to see the old value too.

If it would be only about the first point, setting PCIDevice.wmask would
probably be sufficient, but given the second point, change those
writes.

Relevant handlers already save data back to the emulated registers
space, call the pci_default_write_config() only for its side effects.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
v3:
 - use emulated register value for pci_default_write_config() call, not
   the one for writting back to the hardware
 - greatly simplify the patch by calling pci_default_write_config() on
   the whole value
v2:
 - rewrite commit message, previous one was very misleading
 - fix loop saving register values
 - fix int overflow when calculating write mask
---
 hw/xen/xen_pt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 3635d1b..5f12d3c 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -311,7 +311,6 @@ static void xen_pt_pci_write_config(PCIDevice *d, uint32_t addr,
     }
 
     memory_region_transaction_begin();
-    pci_default_write_config(d, addr, val, len);
 
     /* adjust the read and write value to appropriate CFC-CFF window */
     read_val <<= (addr & 3) << 3;
@@ -397,6 +396,12 @@ static void xen_pt_pci_write_config(PCIDevice *d, uint32_t addr,
     /* need to shift back before passing them to xen_host_pci_set_block. */
     val >>= (addr & 3) << 3;
 
+    /* Call default handler for its side effects only, with value already
+     * written by specific handlers. */
+    pci_default_write_config(d, addr,
+                             pci_default_read_config(d, addr, len),
+                             len);
+
     memory_region_transaction_commit();
 
 out:
-- 
git-series 0.9.1

