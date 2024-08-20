Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63203C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 18:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgToa-0007ov-GQ; Tue, 20 Aug 2024 14:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sgToY-0007oQ-Tz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 14:42:42 -0400
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sgToX-0003T1-3o
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 14:42:42 -0400
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal
 [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id B3500114EA9D;
 Tue, 20 Aug 2024 14:42:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 20 Aug 2024 14:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1724179357; x=1724265757; bh=gs
 8BALBeDHGgfJ4K2G0dvJYV2tKaeJvz92mj0hs27Qc=; b=RM7xMcS5ohP7u3dAE1
 FTMhYj47m5/YeyHSAYHvnpDJ7xtU8lsWv/Al1DawuYpHkq6Ak9Se9Bwuqq0cctP3
 SGUtDV963RqGk1nEXpIz81d9M5hilSqgEHUzhwoCIl9BYdBOXfzkW6neMVMgzZ6f
 oLk2hO0EGSvajLJET8eEQPngQFrYlH76kjoMRYBPbZw5w2iAYkIIgkA2ICkiMbuc
 HIezBn5aWLwqC6PgCPP+dwLTuKd/kgV3UL4BK3TeO0LRRQQLDp09wyzW2gqlzWvP
 YGrv7B14m/5VceJ38L5EmLLjnGHp5kId62Hv1vCKOYZSU/FNXDcgMRmQHQbD2Cyx
 U06w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1724179357; x=1724265757; bh=gs8BALBeDHGgf
 J4K2G0dvJYV2tKaeJvz92mj0hs27Qc=; b=r7i/kOYPw59tBsrgpSVbUmx+3AeI3
 lCTN01Xt8La3OQIJvZpZ6u6hmlNfQsLZmUodX308HPiwRHspQOuasuWxu3DcHPFB
 PXvavP3LxessQdR+AqKxUNsPCEE4eNvGc9d3jYXUhivMvmtHtyHysSldE6svnxoD
 hWzzORATd4EVgY9THrqHcwtX8qnFr0ttwF07GjzChHBoIuzGgpzIHqCWFc/NOr/Q
 AMOLd/XQV3+JfidDFcEl2beMUFCV9DUpIWlaEAqYiNc+SNauthuGwQ1QeASivYE1
 hauz8Aldg2dHJnBrdrqhmqvgWAV/N/JM+mQlx8c1qGK4jLd5E1LGF7dwQ==
X-ME-Sender: <xms:nOPEZrnevx_8pR_TIWc8nllphLSddbeaiS8bsNugaCJgZdF5JqqQ1w>
 <xme:nOPEZu0mTu8lwcSkXuc13EzDtSnbuBCd3pB5f0vTzK4HSep8nYojFT1JLTS-Fhn_Y
 IQjmYZ_3dvPJxps7Pc>
X-ME-Received: <xmr:nOPEZhrZG3u4Q13oyKySTRgZxG7igc7vPZpu_ppYio7ktrIuRzeCiRoMFpYJXVJ0PWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedguddviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeen
 ucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihgh
 horghtrdgtohhmqeenucggtffrrghtthgvrhhnpeffteeugeektdfgjeevuedvgffhgedt
 vdfghedugefhgeehteeuudehudevjeethfenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgt
 ohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
 hqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepjhhirgiguhhn
 rdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopehgrghoshhonhhgsehloh
 honhhgshhonhdrtghnpdhrtghpthhtohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgt
 nh
X-ME-Proxy: <xmx:nOPEZjk4xGSSXXXy-r4yUBpIYXJE9Hq0bPsfUsxQzxm9eJ7Xn1HUUA>
 <xmx:nOPEZp3q3rCIkVon4qIHlLBzKf8Y8ykwmRPEFwBZZS6zQ0gG18_ENQ>
 <xmx:nOPEZiuPVYU2kCRUphiv9X_F_x8iwgEcuT88U6yWK-0RJxVIzHSLkA>
 <xmx:nOPEZtUoUFwri2vANBh1Nvdy81aLyhNpFJvt49HRhFqA_vUSjtrlBw>
 <xmx:nePEZkQdbDZkjH6h3xVPHYzFMreYaweYpSUNxfDnkSNv94Z06EuLSinM>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 14:42:35 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 20 Aug 2024 19:42:33 +0100
Subject: [PATCH for-9.1] hw/loongarch: Fix length for lowram in ACPI SRAT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-fix-numa-range-v1-1-c5d6b889996f@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAJjjxGYC/x2MQQqAMAwEvyI5G0mrh+pXxINoqjlYJUURSv9u8
 Tjs7CSIrMIRhiqB8iNRzlDA1BUs+xw2RlkLgyXbkbOEXl4M9zGj/qs3nlqybFq3QjldysX4gyP
 4U7FvDEw5fxj+wIVpAAAA
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=DVSx+QjX9JZ5kGyd1+nSpGiO2tMFbQCOfmypGGgGvzs=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrQjj2cr+Pred7h58el/XrOk2Mwnp2X2Fp3PPFTBPu/Do
 WMzG8/3dJSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBE1vgz/FOa+UTKf47gDs6P
 6wKO6xfcFJR1/XzAozHpnfg5Yf5URzZGhhVfz+d3HyhfctDd37T2yEFjBl8hDrcOXaEcZVuHnjN
 PGAE=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The size of lowram should be "gap" instead of the whole node.

This is failing kernel's sanity check:

[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x16fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x170000000-0x26fffffff]
[    0.000000] Warning: node 0 [mem 0x00000000-0xffffffff] overlaps with itself [mem 0x80000000-0x16fffffff]

Fixes: fc100011f38d ("hw/loongarch: Refine acpi srat table for numa memory")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/loongarch/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 72bfc35ae6c2..2638f8743463 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -218,7 +218,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
          *   highram: [VIRT_HIGHMEM_BASE, +(len - gap))
          */
         if (len >= gap) {
-            build_srat_memory(table_data, base, len, i, MEM_AFFINITY_ENABLED);
+            build_srat_memory(table_data, base, gap, i, MEM_AFFINITY_ENABLED);
             len -= gap;
             base = VIRT_HIGHMEM_BASE;
             gap = machine->ram_size - VIRT_LOWMEM_SIZE;

---
base-commit: 075fd020afe3150a0e6c4b049705b358b597b65a
change-id: 20240820-fix-numa-range-f1f0302e138d

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


