Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8697BC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoHM-0004eO-Ov; Thu, 13 Jun 2024 13:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHL-0004df-ES
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:27 -0400
Received: from fhigh7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHJ-0007J2-Q8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 5631A11401D6;
 Thu, 13 Jun 2024 13:30:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 13 Jun 2024 13:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718299825;
 x=1718386225; bh=dAn6RhZVBQ411UgnvLVvJtB4CrT4+mRlgv05oQIOfNw=; b=
 FyTzrtxLN6H8iNyN85boyM1JcsxEpzxbQw8GwtXT2p2wJJEj8CLhjaFL3F0hyquc
 wi7yN9OVEvzYTvUpwqTXzTyjV9yKFYf4lxfWIud38Kcxo5Qf/WGvxYdJ/cF/MXGw
 2qstueL9y8cEX6NRUJjr04lwdwB9Fhy+oDvPRzc0dFr5lOgGeFpfSBwbtodTK+S5
 DbCnXOfSHz3tpyH6wfynHO/BkhyFuY0JZzITx6MxIyWMLbyPVfQ+Tg886lUm6JSP
 FsMAs1beB1pR/z6ovTA4qj8XZiuwUfoOzr5fIhIxdOiHKAOaMHi26I8xtqUkrmnR
 khBYTMUkfvu6J97MrYC5MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718299825; x=
 1718386225; bh=dAn6RhZVBQ411UgnvLVvJtB4CrT4+mRlgv05oQIOfNw=; b=G
 MCGZjPVOhR/36xPUW4nlLi0RCJEtm/x1x7vUfZ2bmeQF1H5w2ik941HmAibl0gRo
 yMKQWZpPBYJq+Tbmb1gixW+B0bYFqSBs133tcDp1ct8KeKBjcRM9JkHSWWJMZL7c
 yE1NrTSCRLoeWB9M9TcARaZB2Pn8plKZbEu+OqMbKKy2zNwU2TESOuugFEvd3iVL
 zCcXILMnEhCfMmXP2qmsOpn4Iv696KPp33d7j9wvKAH/susGvYTGwlWJV9/t8OTD
 QAvkWcZ2a0gi2CoZqMcwxchxv1/PqaR+59H5xvPbHiPuCnJTwsFokRWGV7XfjO4f
 ekXk+BdvN8ncVe1IVSYyg==
X-ME-Sender: <xms:sSxrZrCorMHitQrX2CnEjMJz0Rp3UU_Sl4GqjIdYLL6H6zcb2D8ELA>
 <xme:sSxrZhgPSABPNWCyzNEEd91bbKnGQEsqEvdMqjjM_g6Bz_BtxrHCFuvNH-ZmnHbLt
 F8rHgcCpdCV2XzyemY>
X-ME-Received: <xmr:sSxrZmlVvo22zrRvC4gHOGfCgfXxu4qnK23I87PEDm7Xuu1fhmdB1Zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:sSxrZtwfdmpY7G1vAg76Lguc3LqL72KC5uHRApALMtRpuAbtRemQxA>
 <xmx:sSxrZgT9_tcrgnf1hPqTuk5LNHdX2Im6OfC1alW3hLvbjRVUlpWN_g>
 <xmx:sSxrZgbveUcvRk9a2KrDTw2hTACmRx2bWi7FcRmyOiI5uSqn8jrgjw>
 <xmx:sSxrZhS7z_spRbzTk9lPywmUQnKkA4to356Jw397r1wkxuB69QI5zg>
 <xmx:sSxrZkbPIed5TKUfPsrxjE086vn14BepMC7i55sjG0cq5lmuA_cx8V-O>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 13:30:23 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 13 Jun 2024 18:30:17 +0100
Subject: [PATCH 3/3] hw/i386/microvm: Wire up S3 and S4 sleep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-loongarch64-sleep-v1-3-d2ef0aaa543a@flygoat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
To: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Sergio Lopez <slp@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=9KDYfgTpJCYj+JrfLXnzk6WDZ9WRBqry0iqBAZw11Ms=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRsnVV377SYNxgqmzY33PkVl75r5vfcbT5bNlds/xLh7
 /Ta1sG2o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACbSvInhn3p50SOt2b1T/i86
 PFVapvP2wU439pLvAWJuK3VWvcoM/8Pwm/3+xmnv43n6fiwV8NKWl5y7o+m444Gtz6MXRnh2bP6
 3gwcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=103.168.172.158;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Wire up S3 and S4 sleep by setting relevant slp-typs bits for
GED and generate _S3 and _S4 methods in acpi table.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/i386/acpi-microvm.c | 18 ++++++++++++++++++
 hw/i386/microvm.c      |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 279da6b4aa2f..7564de2b343b 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -129,6 +129,24 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
     aml_append(dsdt, sb_scope);
 
     /* ACPI 5.0: Table 7-209 System State Package */
+    scope = aml_scope("\\");
+    pkg = aml_package(4);
+    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S3));
+    aml_append(pkg, aml_int(0)); /* ignored */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(scope, aml_name_decl("_S3", pkg));
+    aml_append(dsdt, scope);
+
+    scope = aml_scope("\\");
+    pkg = aml_package(4);
+    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S4));
+    aml_append(pkg, aml_int(0)); /* ignored */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(scope, aml_name_decl("_S4", pkg));
+    aml_append(dsdt, scope);
+
     scope = aml_scope("\\");
     pkg = aml_package(4);
     aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index fec63cacfa88..b9fb2d28e570 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -206,6 +206,9 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     if (x86_machine_is_acpi_enabled(x86ms)) {
         DeviceState *dev = qdev_new(TYPE_ACPI_GED);
         qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
+        qdev_prop_set_uint32(dev, "slp-typs", (1 << ACPI_GED_SLP_TYP_S3) |
+                             (1 << ACPI_GED_SLP_TYP_S4) |
+                             (1 << ACPI_GED_SLP_TYP_S5));
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
         /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */

-- 
2.43.0


