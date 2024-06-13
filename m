Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F04C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoHL-0004dY-NS; Thu, 13 Jun 2024 13:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHJ-0004cC-Km
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:25 -0400
Received: from fhigh7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sHoHH-0007HN-UC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:30:25 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 51E5111401DE;
 Thu, 13 Jun 2024 13:30:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Thu, 13 Jun 2024 13:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1718299823;
 x=1718386223; bh=eJFYh3g5LXsFX6s95/TGJ8b79IiBsljmwa9yyqrsIss=; b=
 X6rbJm0MnkFOJC8ltm3x9AT4tclSKBEOR4fJZ5hBe4LphMMoMig2/ajzfDtuDuwY
 AuteCMpCGkVcal3l79cFPp7f9AA15Kcl6/8vIZvLDPbdpJqwWaZ3+a9dHXKb7nzs
 jTMg1ovZHmm5xCx01uBfXSP27PAz0ggNWBcKDQ3gRKmHuIoRj+8/gqIjbJUoURKs
 S1//DWqW03rC74rCFbA+iFQUOuGVsXsikfnO2NvV9mGZBY0JV4n+i9lC0qgSu3KX
 U07Tfl6/ddb5m8jTQTP5zg19kkR/hdotaTlfLKfSSR8e9jZ0CsOHtWZjq59pNhlu
 m9d+aVcTzb6jZW886wjbcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718299823; x=
 1718386223; bh=eJFYh3g5LXsFX6s95/TGJ8b79IiBsljmwa9yyqrsIss=; b=Z
 0YyQDGFf0Rkn0UoceplKD33SDiedDiwGf/Al1zmppc2uyOqUYU+4oEKcUV6aZcZe
 8YRXrdcfNcAw6W1n7iB+44OYOvxATzlq8KHb0mxl2dtq36yzTwJMQ/JmsrPmxPjy
 1HCV+X3vhZBHb9WQpQ60Ww5DFL+NC8i2KK8XILthIq/u88ODygXyvp350wnHPwC3
 z6+5vhcexSt9RGaTuFcrY4RYEiQD0/7IsDWjimljWvd2nDqxBNhCNzjczYTxsS+A
 ZbBlZ8/krOAr3U3JN+mjsn3r+BHiwUymEQUGKQ7exM7BLgWH0uTi9hoDGi9TMxBL
 sBRLd6nrdM1HQIoK3WNWw==
X-ME-Sender: <xms:ryxrZqfJzYMmnYLgmm5-g01Wft_fEIQIpxpsZNxHJYWbol5dj_oVQQ>
 <xme:ryxrZkMCtQHOVFV6Dq2upwj18phcVr0BcXDJA1XbHjZB0iDcviAg7A4G14nlPe4K9
 Aux2Hr3xtqlmbbl3FE>
X-ME-Received: <xmr:ryxrZriAPoEStcnXj853ScpMcQgV71SP-6AXykMi7rKKBU6WeWybfag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgudduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:ryxrZn-Kxa2gzDT6yhAI9jpPhMSi5AD8JBBMsmpQQKw3kN-O7b9YLg>
 <xmx:ryxrZmvW4YJMT_KbGl8PpnEtP8mKHDSPcP5kq2TNW1eaTqy6xnkVBg>
 <xmx:ryxrZuEJV5b_HMq1jpOwG3EDKTK2O28xlKqDqv8FJcC2-6vMvrwxZA>
 <xmx:ryxrZlPs-OG-a2AyFTL4P9RLeVP6loQ3j3zZ6PX58r9vfrrw25HAlw>
 <xmx:ryxrZuFWt_I4QjCiGRhEjR83t7hUhLQeWXzmDGKDGshmgsJ8ejeLuMM4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 13:30:21 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 13 Jun 2024 18:30:16 +0100
Subject: [PATCH 2/3] hw/loongarch/virt: Wire up S3 and S4 sleep
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-loongarch64-sleep-v1-2-d2ef0aaa543a@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=BXyEMcPmd5AgUUDVaen/Z+sU7QeqymhAaoVVivRctUo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRsnVXJSi92fl+2b/6r2XeuNt1MVNokntR/kH1m484pV
 mLB7EtPdZSyMIhxMciKKbKECCj1bWi8uOD6g6w/MHNYmUCGMHBxCsBEmP0Z/oc25UR9KVv17Ef/
 nOVNKvWfXzFpNVW8PBZVeP/426mP3LYzMmyveuL8VeJfg0RrqVC7LoPS6qWP/iSub668t32NieX
 KlXwA
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
 hw/loongarch/acpi-build.c | 18 ++++++++++++++++++
 hw/loongarch/virt.c       |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index af45ce526d6e..2cb1696b579b 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -416,6 +416,24 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     acpi_dsdt_add_tpm(dsdt, lvms);
 #endif
     /* System State Package */
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
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 66cef201abe0..a4b55f00a32b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -615,6 +615,9 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic,
     }
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
+    qdev_prop_set_uint32(dev, "slp-typs", (1 << ACPI_GED_SLP_TYP_S3) |
+                         (1 << ACPI_GED_SLP_TYP_S4) |
+                         (1 << ACPI_GED_SLP_TYP_S5));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* ged event */

-- 
2.43.0


