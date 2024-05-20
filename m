Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34BCC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 21:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ADV-0003h1-09; Mon, 20 May 2024 17:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s9ADS-0003gc-OF
 for qemu-devel@nongnu.org; Mon, 20 May 2024 17:06:42 -0400
Received: from wfhigh5-smtp.messagingengine.com ([64.147.123.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s9ADQ-00007c-Ku
 for qemu-devel@nongnu.org; Mon, 20 May 2024 17:06:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 700DB1800106;
 Mon, 20 May 2024 17:06:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 20 May 2024 17:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1716239195; x=1716325595; bh=Wn
 AzQjeD504PSAQUf7CWcjuk7JQIQSSdwTE/Y0daCSQ=; b=KCxn3O3EWNCf/BQraV
 v86zge28vfw6gG6aOuGts1k3GnpsD1/G/v7h6MjosdyGJ8VQqa0HUcFfdHEDlMFD
 SASH5jaL0cBHMrwEsoY5DZqTIr2gtN0l0l03Ju4i/XS1qXuqJFlQXCeJKEaiGkE7
 SeBw0WXBgHguxeFDe6uwV6KAMhuLfkq7+SlbSqF37MRdNzkvP9UVdP5duBwE8rdJ
 douJzzgRSwuAjgoPT0XVQHFE+yZctJJN4I1bRUh1EqL9xtu/3p+T1xkq8nIokNu+
 cvWKZTfSar1sukXi6fIIUvKj55e1NXZ7x5Sxa3neXx1VeTmRr5KACxXYAkPgXEMx
 YYug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1716239195; x=1716325595; bh=WnAzQjeD504PS
 AQUf7CWcjuk7JQIQSSdwTE/Y0daCSQ=; b=IiWMvqyArzkW0eOqtnp+YXt0xpamB
 Fv9qBz4KvfUVm7VhFt2J2PlwBG3f/49FMth4m1suECvAj3Mfsy8f1TBBVxbpK+bP
 7+nYIXkQ4ZRn16Rn9gm45oOxG6iChslUnQ2p91jtDRktPhX1TbhEDKW3cg6d0GA3
 JX61O1rSz5jugtu6F1DM7l7uCzCHyb4l34P6yDu9km/q+ly7hySauMIOTMqoEULY
 m7imzrAAarnAHMvvTyR3cZteTARs2/KXsvEUeNrOxI0ye+C82wiql6h0t25cWHMb
 ugi6wrppRO3I98gd5hG2n2eDRpL6fCthCIe/VWFL+f3gsEutB2mW0OOcQ==
X-ME-Sender: <xms:WrtLZruhzNF7__nCwx_s8_Zg_8HdlHpGxjGivDpTyaEAaHmRKLUFQw>
 <xme:WrtLZsf6yLefaD2M777H8Ev5B5TcML0GTrkDW5ojPR-9qG1P-EvBC0pgtaW-cPD8S
 VAo1aTbbrmyLQ6Jrv4>
X-ME-Received: <xmr:WrtLZuzotYpTC1YczeCg_3S27NDOlrpPODG0jv77a-P7dQYBY7lCpZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeitddgudefvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeffteeugeektdfgjeevuedvgffhgedtvdfghedugefhgeehteeu
 udehudevjeethfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:WrtLZqOgKyVPNB_tmoAJlbEiKMzoRqESWs_iqn1BOzibT5bBkykH7w>
 <xmx:WrtLZr-bbbI4NyRV4CgtqY0-PoynhCL_M67TvvKpJMant0LP9Bg6Dw>
 <xmx:WrtLZqWGkylssBeoULaZef60vEADQ5LmF6J-jCAr0m1_-tDZoRir4Q>
 <xmx:WrtLZscjguegGpoIfNiNZXYYNmPDuNOSkIJLs3qd40beJaQrBLy46A>
 <xmx:W7tLZuY7JtPJmxDHeJTMjqWDvYQoaNiGYvnJTy9Fce29RqYOdSQeGZxl>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 May 2024 17:06:34 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 20 May 2024 22:06:31 +0100
Subject: [PATCH] hw/loongarch/virt: Fix FDT memory node address width
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-loongarch-fdt-memnode-v1-1-5ea9be93911e@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAFa7S2YC/x3MQQqDMBBG4avIrB2IsQrtVYqLmPwmA5qUREQQ7
 27o8lu8d1FBFhT6NBdlHFIkxYqubcgGEz1YXDVppV9q0IrXlKI32QZe3M4btpgcGP1oVWfwnkd
 QbX8Zi5z/73e67wfM9grhZwAAAA==
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=L5wvhDdFghCDm+MdJUnaIsEL83jj3tYABGlXcsjNJPo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTv3VHb48psjkXXKZmGHXl3fLXTtguKdW8P+rznfSP8b
 KXJsW9WHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCR42mMDFsfhpzftvjIySCR
 veohjG4JyXbJ4Vbbjxmf510ycf7aTfYMf2UfJdXq/z4geGnPhsce51PZ+R5KHPyjZXLc2OmiaF9
 bDRcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh5-smtp.messagingengine.com
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

Higher bits for memory nodes were omitted at qemu_fdt_setprop_cells.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
This should be stable backported, otherwise DT boot is totally broken.
---
 hw/loongarch/virt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index f0640d2d8035..f97626bacf65 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -463,7 +463,8 @@ static void fdt_add_memory_node(MachineState *ms,
     char *nodename = g_strdup_printf("/memory@%" PRIx64, base);
 
     qemu_fdt_add_subnode(ms->fdt, nodename);
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, 0, size);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", base >> 32, base,
+                           size >> 32, size);
     qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
 
     if (ms->numa_state && ms->numa_state->num_nodes) {

---
base-commit: 85ef20f1673feaa083f4acab8cf054df77b0dbed
change-id: 20240520-loongarch-fdt-memnode-e36c01ae9b6e

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


