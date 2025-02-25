Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C54C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 00:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmj0X-0004pj-KI; Mon, 24 Feb 2025 19:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizp-0004YF-50
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:25 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tmizn-0003S2-CI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:40:24 -0500
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0EDC5254016F;
 Mon, 24 Feb 2025 19:40:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 24 Feb 2025 19:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740444021;
 x=1740530421; bh=Q1Tr4VLCU/aCVt0TUBVkqUl7v2+5x9K5iupl27zw8OA=; b=
 O66y8PtY0UvsiVEGpVO24R/o4y0O21xFUo1H9o6Vac2sThB3iJQl1PNXuCz47638
 BJv2H0LFi4YaNJ4Y7+gZ7zLSjnKCetBhruY/UZAHmLSk9HrIOcymkTHbp23ra047
 NpHcHtCvzsyQ/Im9WQgsqreT2V5a7cLWmtiawOwinWUFoxcF0QYBYD7x/Y4m530r
 D17qp0NwL95b9YqPzmFgdpsJzVznDXcA2+3TXW9LWs27hQt5XywMAZVMfdqAVbq5
 Mimd9Iu3PFflqFqW3O2N8nQiNdvnSrcQ937IF8gEjhTCv0TOqyPvHYgDqSMnaRHP
 e8eGBcPmc6vm2o1OiR+1cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740444021; x=
 1740530421; bh=Q1Tr4VLCU/aCVt0TUBVkqUl7v2+5x9K5iupl27zw8OA=; b=z
 g0qgxvPaffPFP5IbPAbR01F4z2Dneaup+4eY6zF0lCHS+MqRFhKO7qaBazYZlS2F
 5hUy1lWdUUCgAMtZvb5/MbokpWppcJXsVr/z9S/qscVzv39AO7He1sISlkscctnO
 MhLIpSKP2M8Wgjxq8j22yhCdYrfvT2eewMy3F1FXythnW041S7+pCKtqCzg1sYQ/
 0E2Dbc+ewM/MHvfPO69C9cqtj6RCBJndj3B7boSn9/bTJsQ9O6WPRskV9rMJ3dy8
 APTCCWprf+xlw9p33EUDqNXgyBWaYgL6JSesDmyi6cieJIyZt+isNi4htpmVCSnw
 zW8lW7Mb94qFnL8XR4YiQ==
X-ME-Sender: <xms:dRG9Z-mjpOZtfR_ws-bXywJ7ihQuYWtwV4EM6waEb4_kwB0oEiJ6SA>
 <xme:dRG9Z108H5CVUStuYGyNnifcmDiC9Djd-2A7P-NZ9x17HLO9sDH8mhcRs0PZ2KEU2
 wj6lVreG3zOhSwn0pI>
X-ME-Received: <xmr:dRG9Z8qZpLDaEuor8_xyaKJliyFNMtaDqyETcu_6dijc5muNDC7LkOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
 jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
 keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedune
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohepghgr
 ohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:dRG9ZyljXE-26DBVEmp8yF3xm5NxGOXc3slxplUFwxTyNnRlf3ooPw>
 <xmx:dRG9Z83SfP9a0zixuTdI_j0lLkq14up5bFDagIZhv2m_wpIFbjo1Hg>
 <xmx:dRG9Z5uLbInRCHTyXQEbYBjJj5AcObdHbvb_Uva5GocrR6eeH_3OKg>
 <xmx:dRG9Z4VEJphwDoxKW9pOCNGZtzWEM-ZcapWGLNTJq0ESE1OnsoPtnA>
 <xmx:dRG9Z5ypwnm9IpKHp4dcJhGsLWN0PZxZbjI74IfQ39n15PR75JUoCRQb>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 19:40:21 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 25 Feb 2025 00:40:17 +0000
Subject: [PATCH v2 4/9] target/loongarch: Perform sign extension for IOCSR
 reads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-la32-fixes1-v2-4-8ec68ada3dd5@flygoat.com>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
In-Reply-To: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

As per LoongArch Reference Manual - Volume 1: Basic Architecture,
4.2.2. IOCSR Access Instructions:

The reading value is described as "writes it to the general register rd
after symbolic expansion." which means it should be sign extended.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/loongarch/tcg/iocsr_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index b6916f53d20ca133f0000e773685cb94240bafe2..db30de2523fff01bcc8923eb12c7fca7bedca7bf 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -17,20 +17,20 @@
 
 uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldub(env->address_space_iocsr, r_addr,
-                              GET_MEMTXATTRS(env), NULL);
+    return (int8_t)address_space_ldub(env->address_space_iocsr, r_addr,
+                                      GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_lduw(env->address_space_iocsr, r_addr,
-                              GET_MEMTXATTRS(env), NULL);
+    return (int16_t)address_space_lduw(env->address_space_iocsr, r_addr,
+                                       GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldl(env->address_space_iocsr, r_addr,
-                             GET_MEMTXATTRS(env), NULL);
+    return (int32_t)address_space_ldl(env->address_space_iocsr, r_addr,
+                                      GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)

-- 
2.43.0


