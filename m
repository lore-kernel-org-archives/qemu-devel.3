Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82879C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1rMw-0002Yl-F6; Tue, 30 Apr 2024 13:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s1rMv-0002YD-6U
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:34:17 -0400
Received: from wfout6-smtp.messagingengine.com ([64.147.123.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s1rMt-0007x2-IL
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:34:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id CD6471C0014B;
 Tue, 30 Apr 2024 13:34:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 30 Apr 2024 13:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1714498453; x=1714584853; bh=Qs8kJgBcfw
 yVOBoQxWcf1KBTRIcqfqizvEFlALXjf5I=; b=Tx91T/7M5pyjm1ZLOqRo/WBhz/
 WOyep28ohOqlogY8JT1Ju2Eax1bEUT/OUDTV6leXE8D2rVb4z36q8LnTCR5wyth3
 sj/6mfL7doX8+ddMC5JbSz29m8mWTtRQEpD3DGxSMnEgDkC3u6yPcOz32Kw2FWrx
 cnlZ9oCEGVDtlUJ2qEifigdNjmeO8vsVJ9t1wTAXJ3ZkLN7TOP6RRIAAkQrJWUWB
 fyDWl8X8+/AJj9USHZffUktTQ1YyIG0+/inCRn+pJEyACivmMIIP0kebtYjXBN+x
 re6AYGRgzQvNJUr+NmBQa4sTolMJzlj5tCGkfhdQsS9ogHckGvis/75NGxCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714498453; x=
 1714584853; bh=Qs8kJgBcfwyVOBoQxWcf1KBTRIcqfqizvEFlALXjf5I=; b=Q
 kZMVqAMSDBz6UWOLheED3emtMNTFXIcBCufzKgTVtnb1gIKSkGkpKsMLsluVLgAK
 WKG+WMJ5vKGXiyXz21R8h4U04j7tf3HsnZkhtHOnK7OpMLFm/xtlJ86UuCXAn9Dm
 FAx68BR50OadJm3OPuBYujXyhNSpV/FTDhGOWQG+Tz2eROM62Ov3t6e6HZpIjkO3
 z47vgJ6q0Rk2XrGr4xpfqWFlU92nLcLc3zm3ydBy9myOAlm2fePZTY4tPd8sTzl9
 ggC8iahXP6rp4Ehc/tXZaBzczY/C1Nge2XyyUc7Ap9a8GX/cH4PI2EaBx/txi5JA
 fMiKS0TbFffkMQzVi+gbg==
X-ME-Sender: <xms:lSsxZufwQd_xOIe0hJNfrDtyljz7dOugVUqnXApB1Z5kwB0Oo3zJvQ>
 <xme:lSsxZoM4bfwY8HF4j3dKEUDUXdAzgp2nRB3_RJqPMN7r0hrKqnlUkbaEQSPWHwAbs
 DOdKtYhsW04_Q>
X-ME-Received: <xmr:lSsxZvgZa0U0DVGMmOobydQJCjltkJDXxcjeyp4ikUlArtKWGXizc4Oamm3Bewit-hRHCLle>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgudduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgr
 rhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghkse
 hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhep
 gfeuudehgfdvfeehhedujeehfeduveeugefhkefhheelgeevudetueeiudfggfffnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghr
 vghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:lSsxZr9Kcg1hK15kbmicl32mi5K7a4azjLfIXuRhy6hvw3_UhfVq2A>
 <xmx:lSsxZqsxKS8onaQQg2I2TYRa7H6CBW9YxYnbxyBJMayU_p_fJk1ELg>
 <xmx:lSsxZiFktKsH7EX66ruzKThMjKGyRUAUgmsAwFmSCeWDbJia07QMDg>
 <xmx:lSsxZpPZzYyX-zvGbEsR-hymJNprUfLHvD90U2Gzqe4E6z9aXnHUqg>
 <xmx:lSsxZsXv-oqlURToAHcUq0XMFoYcpNgY5UBVsfOImIjkDti4ICEEXi2o>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 13:34:12 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v2 2/3] Update Xen's features.h header
Date: Tue, 30 Apr 2024 19:33:10 +0200
Message-ID: <bd499d1c412502afad60bff73a088b94a4ba43da.1714498385.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.ea761e8c87cc41550b01d6fbc1cd1116af55e288.1714498385.git-series.marmarek@invisiblethingslab.com>
References: <cover.ea761e8c87cc41550b01d6fbc1cd1116af55e288.1714498385.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=64.147.123.149;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=wfout6-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Update it to get XENFEAT_dm_msix_all_writes for the next patch.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 include/hw/xen/interface/features.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/hw/xen/interface/features.h b/include/hw/xen/interface/features.h
index d2a9175..8801930 100644
--- a/include/hw/xen/interface/features.h
+++ b/include/hw/xen/interface/features.h
@@ -111,6 +111,23 @@
 #define XENFEAT_not_direct_mapped         16
 #define XENFEAT_direct_mapped             17
 
+/*
+ * Signal whether the domain is able to use the following hypercalls:
+ *
+ * VCPUOP_register_runstate_phys_area
+ * VCPUOP_register_vcpu_time_phys_area
+ */
+#define XENFEAT_runstate_phys_area        18
+#define XENFEAT_vcpu_time_phys_area       19
+
+/*
+ * If set, Xen will passthrough all MSI-X vector ctrl writes to device model,
+ * not only those unmasking an entry. This allows device model to properly keep
+ * track of the MSI-X table without having to read it from the device behind
+ * Xen's backs. This information is relevant only for device models.
+ */
+#define XENFEAT_dm_msix_all_writes        20
+
 #define XENFEAT_NR_SUBMAPS 1
 
 #endif /* __XEN_PUBLIC_FEATURES_H__ */
-- 
git-series 0.9.1

