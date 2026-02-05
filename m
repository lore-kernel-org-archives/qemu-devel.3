Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C07ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vn-00079U-2w; Thu, 05 Feb 2026 14:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Ve-0006zE-TD
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:27 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vb-0003BO-GJ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:26 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43622089851so922338f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321562; x=1770926362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbMkUUvH+NcjHWVg6Bu6jsxDREeMbXx3rIs90lyP6Y4=;
 b=PNLfoQMdXD8q2jiwlOX+6m7mXRMFiSHHzBUng+b6fBsFPptoFpE/a4AYJQGh1A8h5A
 DUAz7bgLY1ftpsdtoWgMNRzezl4cZUgGY8/ZqQDbwwZ9oXweApNd5ttC2k2X8I6WSXsC
 EKTGpS3KmUtYlC2LnUojezgj37A89DiKN6PcB1dUPVwVGOMCDE8Mt7YgnGB8CnFSdB5i
 enceppkZdNYUo53cMV+8bQueNgEVMtQvZ7f1/aDtjIh6qkef4L8/WAXTfsGe1Tg2VB2y
 B9Y09ksDcgRgHK6BeRgMHb1OxT2OriEGNgmTDFbS4Jrsyai3zTpWaDXPBw6NWvyPbE0V
 RxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321562; x=1770926362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MbMkUUvH+NcjHWVg6Bu6jsxDREeMbXx3rIs90lyP6Y4=;
 b=qasf8MZjMSZJ9kIFArAZSsvOrqCwxvCoIy6Dd4PP9I88+/9xyp5VB16qVFu+4Dl9rf
 kMnLpcz4Jx9IOMb6i8Yt4HptHNIWZPOf9DMXFtZ7kO7ioWApnGG8dahh+FN3g97y9lTx
 n21R53dpZniukB4pxNH6duutZtvEcLHuf3bFjXWVFmILFVJBlafWuhDJOGcF9ExWdtGb
 pSzqQBTVq2axZDSSHp+iQ/idWTjZZOeULjrBxzR3GewqwvM553fssr0QripR+fJvSXh4
 DoNdGqagsazCmkxGXcCwYY45O7zrN0ElS0n+fY/Azs7NuTTiR7BcRwvT9Ectd6WJL6Nf
 FAcg==
X-Gm-Message-State: AOJu0YxOsUQ8SkyB6FRgzuNovVZLOhpftLeD2yjPZdg2tVtDNiuM4RhC
 Nbvh/ZP+cbDMXHiCkOd9oOipxrXd5qwFMmIHOc73Sp91aOnkuVUMkumUM1mKqdfRd6U=
X-Gm-Gg: AZuq6aJH+r5PS8ivQDIvfWBUJcFIH54+Wws/VmKaaUf9Vuy1QtgYuSJJPiYOLvnpmSt
 IbYKb/S748r8BQugY/IWflq+uzciy71jqLMvGEZDKioqrnGr0Ktv0xdSVZ+YXaqFL5RmwjDH037
 WxNuQSN9G+YduYRo5S45OOQkxYrUyfXY/AAEWYWzCB1CInCYrI3EwL6hYdPUytPODtXi/KXLRc8
 Wn0PyMsIFcB6OyElLr7Al/zTxxc1oyNuPBUY9gB/oVsx/UttUlkkEFVzv2kERYH6cfwZJh07cyM
 rldsnlVmZxeAndAUDPDXsrO7zxRh6Wvfg4VKwx87qoxevzOgv73nFslh5EA4JIt7Y5IopBPaH2q
 bBrCYgzhsQR5zOpOcnWeMnsfNDS+4Yz6xPYknX0u2/Ok2qpIQNXAJkLaoOnV8UGYRalsMkyJu4X
 0n9mE/wxxoWhtQW4TcFQA=
X-Received: by 2002:a05:6000:2c05:b0:435:95c9:6891 with SMTP id
 ffacd0b85a97d-4362938aee7mr762694f8f.42.1770321561485; 
 Thu, 05 Feb 2026 11:59:21 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:20 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 25/29] hw/core: Add FDT support to Remote Port memory master
Date: Thu,  5 Feb 2026 20:58:20 +0100
Message-ID: <20260205195824.2610192-26-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement the FDTGenericMMap interface for the Remote Port
Memory Master.

This enables the device to dynamically parse memory ranges
defined in the Device Tree ('reg' property) and register
them as system bus MMIO regions.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-master.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
index 4a6c43423d..854b35e99f 100644
--- a/hw/core/remote-port-memory-master.c
+++ b/hw/core/remote-port-memory-master.c
@@ -22,6 +22,8 @@
 #include "hw/core/remote-port.h"
 #include "hw/core/remote-port-memory-master.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 #ifndef REMOTE_PORT_ERR_DEBUG
 #define REMOTE_PORT_DEBUG_LEVEL 0
 #else
@@ -277,6 +279,35 @@ static void rp_memory_master_init(Object *obj)
                              OBJ_PROP_LINK_STRONG);
 }
 
+static bool rp_parse_reg(FDTGenericMMap *obj, FDTGenericRegPropInfo reg,
+                         Error **errp)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(obj);
+    FDTGenericMMapClass *parent_fmc =
+        FDT_GENERIC_MMAP_CLASS(REMOTE_PORT_MEMORY_MASTER_PARENT_CLASS);
+    int i;
+
+    /* Initialize rp_ops from template.  */
+    s->rp_ops = g_malloc(sizeof *s->rp_ops);
+    memcpy(s->rp_ops, &rp_ops_template, sizeof *s->rp_ops);
+    s->rp_ops->valid.max_access_size = s->max_access_size;
+    s->rp_ops->impl.max_access_size = s->max_access_size;
+
+    s->mmaps = g_new0(typeof(*s->mmaps), reg.n);
+    for (i = 0; i < reg.n; ++i) {
+        char *name = g_strdup_printf("rp-%d", i);
+
+        s->mmaps[i].offset = reg.a[i];
+        memory_region_init_io(&s->mmaps[i].iomem, OBJECT(obj), s->rp_ops,
+                              &s->mmaps[i], name, reg.s[i]);
+        sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmaps[i].iomem);
+        s->mmaps[i].parent = s;
+        g_free(name);
+    }
+
+    return parent_fmc ? parent_fmc->parse_reg(obj, reg, errp) : false;
+}
+
 static Property rp_properties[] = {
     DEFINE_PROP_UINT32("map-num", RemotePortMemoryMaster, map_num, 0),
     DEFINE_PROP_UINT64("map-offset", RemotePortMemoryMaster, map_offset, 0),
@@ -289,9 +320,11 @@ static Property rp_properties[] = {
 
 static void rp_memory_master_class_init(ObjectClass *oc, const void *data)
 {
+    FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
     device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
     dc->realize = rp_memory_master_realize;
+    fmc->parse_reg = rp_parse_reg;
 }
 
 static const TypeInfo rp_info = {
@@ -301,6 +334,7 @@ static const TypeInfo rp_info = {
     .instance_init = rp_memory_master_init,
     .class_init    = rp_memory_master_class_init,
     .interfaces    = (InterfaceInfo[]) {
+        { TYPE_FDT_GENERIC_MMAP },
         { TYPE_REMOTE_PORT_DEVICE },
         { },
     },
-- 
2.43.0


