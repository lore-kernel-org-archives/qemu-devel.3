Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6E2C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s40Jv-0007kt-Ds; Mon, 06 May 2024 11:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Js-0007iw-K8
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:32:00 -0400
Received: from wfout7-smtp.messagingengine.com ([64.147.123.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s40Jq-0003U6-OH
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:32:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id D55991C000B5;
 Mon,  6 May 2024 11:31:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 06 May 2024 11:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715009516;
 x=1715095916; bh=XeJ4KkGylBz/yVz6BnceGDPMbIFcGGvB/K45B0IEGpU=; b=
 ZCe8ny8SPvGTOR3p1DZIB7NvnA5hBcs2UKhg/wbBPQiNa5xGqBZdHNVLk4vxV2ke
 vLoYOKTZU9WnjXrRrtYOAPbOrXIe7ASf500QAkoKYYQ7VW9t6e6JE4RnQdrG4PSp
 routCbp9XdZk2G8CCQOw8VLyHbPawKiNK+vQAnyTur52nkpqMTODwQlLAGhz88yP
 3XACa+R4yD+C9cKsiyHaA/1/WoR0DcvbAsIcbeXp5EMU5cz/bSE4eSQu/cj7p4jX
 IhFDkvqdo07KZr4+Gz+t6flGwGxrfCujdeRhsI+vd1veJVgxRPH1V+ZtIAVnDvxB
 McdUP6RYd8IH/h9j99alYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715009516; x=
 1715095916; bh=XeJ4KkGylBz/yVz6BnceGDPMbIFcGGvB/K45B0IEGpU=; b=P
 6hk3NXr9gAvabRzdFwwb15PFstbmTS3wwGL3dfOqyRYZLBgWDLet6uCCPyPAmPWa
 cD5YnlFmUyLYJ6U+HBtoeQeaFOlUsoaPKJIuH3UahVh9f4MKFi2jmt3LDogx051S
 PuWIr6ZXmj4NiCUUv8wNdWctGvYmmuOGiNUhRR4hHfQ2bmH61gUz+AuVTx0dC0oQ
 6yYYsWtLBV/xZFBrZVopRAQKaG2SS3mkiqfiAgsmcZ6scyukVxGSvASkp7hNB7or
 tSc7Tp4OFPIUBn+7ng/NkOffHXNcyQuwg6RnwJRHonop5mS6KxPC1Hfme0WhvttV
 1QOvbtutrGpCJC8kvZ72g==
X-ME-Sender: <xms:7Pc4ZkwhEqXE9ws3YcKZAevAxZ2ua-t23vIMD33qJVnLQcIp5BNDkQ>
 <xme:7Pc4ZoSRqHTar5v-rZpHOzhTX1kNDr88_vQoIQDLmiyMRRBzGNDWDiJJT7bJXdOWd
 4-sFXLXXzeCP5jNLyg>
X-ME-Received: <xmr:7Pc4ZmXlkrPEGwB_I5DXhUv8Y4aMLnWIZDy5LFScxE60XA-aLnGNFxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgledtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:7Pc4ZijWo8M08AyOV-FzmGGmxP5bqpzsZxJ_8_TuPv6bZUYywJC7og>
 <xmx:7Pc4ZmDjTdh3QWXeB1IhGgmutvRXZZo_t_l5pac0V1-RBOeyb0odnQ>
 <xmx:7Pc4ZjKs2HA8vFHVqJHV_Iz1H1d3pyFKjowlh5hIrf7iA1UbCd3ebQ>
 <xmx:7Pc4ZtDOq0NNIHbcb4jcPyMpqOFxtmw4Mi5oup47RvZbLUmCUZwBAA>
 <xmx:7Pc4ZhOmw_USobVFnT9kVU9ZPCXEr8vCKgmXysBS1vjh_fOVnkIPuGzl>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 11:31:55 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 06 May 2024 16:31:39 +0100
Subject: [PATCH 5/5] hw/mips/boston: Implement multi core support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mips-smp-v1-5-3cc234786910@flygoat.com>
References: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
In-Reply-To: <20240506-mips-smp-v1-0-3cc234786910@flygoat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=agVUDK5z50Yx3y9FJ7dmchE1btUX/7dn7FnPDCPKZdk=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSL74932Ov0zJsbZhlZfK82qc7fOjJkcyPHkS86fcG8u
 14uOHuso5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYSUs7IsM1m1rL8Kdnrwm0j
 urhjkv2cezff5zFSUyv/NmnF3A3rTjH80zUpFq3wsvK/79e70STjbpiDBkMs/51iEfa8oH3BCq3
 8AA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout7-smtp.messagingengine.com
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

Implement multiple physical core support by passing topology
to CPS subsystem and generate cpu-map fdt node to decribe
new topology.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/boston.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1b44fb354c..4ed7d366fe 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -542,7 +542,10 @@ static const void *create_fdt(BostonState *s,
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
 
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
+        char *map_path;
+
         name = g_strdup_printf("/cpus/cpu@%d", cpu);
         qemu_fdt_add_subnode(fdt, name);
         qemu_fdt_setprop_string(fdt, name, "compatible", "img,mips");
@@ -550,6 +553,27 @@ static const void *create_fdt(BostonState *s,
         qemu_fdt_setprop_cell(fdt, name, "reg", cpu);
         qemu_fdt_setprop_string(fdt, name, "device_type", "cpu");
         qemu_fdt_setprop_cells(fdt, name, "clocks", clk_ph, FDT_BOSTON_CLK_CPU);
+        qemu_fdt_setprop_cell(fdt, name, "phandle", qemu_fdt_alloc_phandle(fdt));
+
+        if (ms->smp.threads > 1) {
+            map_path = g_strdup_printf(
+                "/cpus/cpu-map/socket%d/cluster%d/core%d/thread%d",
+                cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads),
+                (cpu / (ms->smp.cores * ms->smp.threads)) % ms->smp.clusters,
+                (cpu / ms->smp.threads) % ms->smp.cores,
+                cpu % ms->smp.threads);
+        } else {
+            map_path = g_strdup_printf(
+                "/cpus/cpu-map/socket%d/cluster%d/core%d",
+                cpu / (ms->smp.clusters * ms->smp.cores),
+                (cpu / ms->smp.cores) % ms->smp.clusters,
+                cpu % ms->smp.cores);
+        }
+
+        qemu_fdt_add_path(fdt, map_path);
+        qemu_fdt_setprop_phandle(fdt, map_path, "cpu", name);
+
+        g_free(map_path);
         g_free(name);
     }
 
@@ -591,6 +615,15 @@ static const void *create_fdt(BostonState *s,
     g_free(name);
     g_free(gic_name);
 
+    /* CM node */
+    name = g_strdup_printf("/soc/cm@%" HWADDR_PRIx, memmap[BOSTON_CM].base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "mti,mips-cm");
+    qemu_fdt_setprop_cells(fdt, name, "reg", memmap[BOSTON_CM].base,
+                            memmap[BOSTON_CM].size);
+    g_free(name);
+
+
     /* CDMM node */
     name = g_strdup_printf("/soc/cdmm@%" HWADDR_PRIx, memmap[BOSTON_CDMM].base);
     qemu_fdt_add_subnode(fdt, name);
@@ -703,7 +736,9 @@ static void boston_mach_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type,
                             &error_fatal);
-    object_property_set_uint(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
+    object_property_set_uint(OBJECT(&s->cps), "num-pcore", machine->smp.cores,
+                            &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-vp", machine->smp.threads,
                             &error_fatal);
     qdev_connect_clock_in(DEVICE(&s->cps), "clk-in",
                           qdev_get_clock_out(dev, "cpu-refclk"));

-- 
2.34.1


