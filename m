Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2700EC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 00:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mJG-0003yE-KT; Sun, 05 May 2024 20:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mIz-0003sL-Ne
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:34:10 -0400
Received: from wfout5-smtp.messagingengine.com ([64.147.123.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1s3mIu-0000Qu-Cx
 for qemu-devel@nongnu.org; Sun, 05 May 2024 20:34:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id CA52B1C0015F;
 Sun,  5 May 2024 20:34:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 05 May 2024 20:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1714955640; x=1715042040; bh=Qs8kJgBcfw
 yVOBoQxWcf1KBTRIcqfqizvEFlALXjf5I=; b=OGX8DgO8lNe7otID6bNrAnu9YY
 KjGEIZo/Ne7N+S4xYFfXvsa4W2P3LvNayRzh2sg7+5XueAYDyB5ZzKHSdEOGNpLO
 EJH8nIXcq0o/XGW9/QD6LfQRsc36Nu7p72z1/x5e1ANkSRlS+5+qICb2tM/lElpZ
 0zLT83dd9YxNCGVa8aPCiDgdcUv3xhQ6478yiwUUvMloHIZ7EyGN8O+LMlTngoYh
 mv1+SXLB8yWB9NQ+0wDskBUxc9m8fLbD/dzcii8Wgibcob1y3Bmtht8zj0mIwr21
 xxxG2cbKkL2fI65Bao2ROJ4d1KrObiI5akm1iM2FD7fuPKNX/tPS+XV3hn3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714955640; x=
 1715042040; bh=Qs8kJgBcfwyVOBoQxWcf1KBTRIcqfqizvEFlALXjf5I=; b=Z
 nxaS/Ij6kfcXycAu1vAl/Q0d++lt1aUh2niCpqU7QVANb6PjJx67MsB7+ficiqkE
 bbX3p0MOtwDygs3nHnhdUT2XdhO4x6/uFZ0c2ExD1JX8eHYdTa/33FwXnjpDFK11
 onHN1cMStJ9VdeMuDPTWVJW4iPM1Csd2fu2qfKpaQrbCJe7jLTA2ufuQ29jeuwg/
 FyD+2JS4fE3Q3ZhahBOJFQRRiHPRRziVnw9PYM+wMWU39JdxqErU4PlnAxIVCVRv
 y/BkSdab3Jg/Ml5RTl0vpzPeNdS0yehtvVVitSo/2BG0fv4jIiDs0llow8jovAuz
 NNOUG5p42I2kV8RkcithQ==
X-ME-Sender: <xms:dyU4ZjDZIinHH1_higeCrLB99UJHlcRB0NdbdoKtwgIau3h-TPe5gQ>
 <xme:dyU4Zpi1LfPQF67CdXSW8hMaUAPx_8GxcDDqJmEiOnwW-_NRy2Y5ABZx7hxet6Pdq
 3z-VkBU35J_6g>
X-ME-Received: <xmr:dyU4Zuk5Hcu_YoRRfyZU1iEtBGRuj5cyauISpJM2aWhWhX1WbbUYOlBTm-XZMm5lX2a3uJ4u-XDYiHxZRmLbSIMxLj-6c9ecPCrlagKAGdhYCZ5uPeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghr
 vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
 hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefg
 ueduhefgvdefheehudejheefudevueeghfekhfehleegveduteeuiedugffgffenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgv
 khesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:eCU4ZlxqKHPKIjWiwJiG9fqpoWLp5QL4t2xPc81FDn7nsFg4mX3Big>
 <xmx:eCU4ZoS112h0PQEaEr87XWs51M_2YfNs0dVbf0i66Scnc0DuEYCceA>
 <xmx:eCU4ZoZ9g7_iPAEiSGZTZCu8kkGcVIUm3qTt0T3zHFLlD34wnYiN3w>
 <xmx:eCU4ZpRn6AvV4io_V7hcRo8UN4AVC-TzEJu8S8nuyuuPSCV4iTeHHQ>
 <xmx:eCU4ZtKM3j44LbYJps7jLc0H9V6UoimAubG5li6GYHOf-3cMst5N3Uyj>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 20:33:58 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v3 2/3] Update Xen's features.h header
Date: Mon,  6 May 2024 02:33:21 +0200
Message-ID: <e167b362448dc3abc677f3b925a58c55d6158da7.1714955598.git-series.marmarek@invisiblethingslab.com>
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
 RCVD_IN_DNSWL_LOW=-0.7, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

