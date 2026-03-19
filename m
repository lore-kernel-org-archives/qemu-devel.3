Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A35109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mkm-0000qD-BW; Thu, 19 Mar 2026 19:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkl-0000p8-Hg
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mkj-0007eU-Td
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:11 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b04e6a989eso9795905ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962768; x=1774567568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70Wuh9XuVwVOLKM0dnCbYpUQR78lBLRnJv9Jda1E+Q0=;
 b=WCdGpf25hQYbH3qMgWE/tXGMaNsWz/AKm4FM1DGYlj3sZHJiPSLYfHR8jIPpYkoi+X
 hKdxFVzwrb6zlnTG+9Fef/zPudJi8WBilp16Lfe/6p8suBfM4qa9l4yMr2UhOwcZECV4
 HxaLdfXzQ55UkYw4t975bzGqvRkVimPbeldC9zAzp+JyHxGuD+gzj/+7vEwyPz8S+J9q
 QK+OQrMqo4ROMutACtD2sRjeKoLPVVPNYoOhbplbyU803bNdElwVotRPR95JtFkiSbWx
 2fhf7yYIgbPEptdNJECSeVTC+Jm/bP/HL9r7a08/hg407AVFBuAv7Xds6KzCzlF0+FOK
 bPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962768; x=1774567568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=70Wuh9XuVwVOLKM0dnCbYpUQR78lBLRnJv9Jda1E+Q0=;
 b=hjgy1cXMXPzeyD1PjAdivi/oyTmjuZrm7z8MV50EgS/M0EU9Fw2d9HeHYTHNaKC/nf
 9YLuW902RmgxYEHpxw46FPzLrFSV27KpkLHFlIUjQ9zazou+HUcNqWkz1VYx9TjjoPCd
 5zBljyrImje+ZpnVLdwLF5g3izN8EkoKbAjz2uqh4WFeZcpH+gP+2SfXXZKHquT5fKfQ
 uzxMt4CpZrhu1AibwgPBva6S6vJiJuK75OJP1NqueMXUJCya3WnL7DhrXnnjtkDxMRIR
 kRl/eW+z+F/Jz0pYop69R6F0SDBIGRslIJ7cT8HTTu4jHmeOf5sUkCIzy62jArVf34yA
 1T5g==
X-Gm-Message-State: AOJu0YwYMTwbZGLr2dRzUha5QLbca6RIua1ttIyWOCfcVj1WCOCx+5Z5
 x9AUFwXGpenXqZjXBIsptu3TkufZDJNoCxgIuCmbU1G4zJ5kmyXu75BtTzT7gw==
X-Gm-Gg: ATEYQzyaeelkSNqQxmY3Tb89sgnC1YR8/Ic4lsL9tMfZP11qxN21KDwLejIM9sfAEa6
 8QXvMnSkdfIAR0IupkFRgI70Nuv5M8qCoND3DJ/OyHJFyrnw64Nvn7Cp9rx5MGSOChRnvV2Du1i
 BQVduxSxwHQkELa8gbOqO6AOmJQRZziB0JIV5lOTrNx4UFk/qaQx+egSrH9KiJe/VXvANfH/TGf
 K+9wZ6hLUScwJlus+SGdCtNmYeGJBM1M3b8YvcDMOPK0Okeyl8MTFnHeMTiz7fNf1Ri3ZWUMqx6
 6ikTFhQC+9hBCEC2eDaUODnEWL2g9PvNr55uGVx9XWL+1Z78ChPZVFRKulWxMDiukfrmVi2JzI+
 gvZv4QZCr+IFb7RSujU2r5ttTiCyWqxeLyjeZHS5XW8RGkBTkOEDef3vogz13z6yQZVaJDYmHlO
 RrHs0eHMJD5edINy2kf2fp6AiYVr1AjyZdUxi5m3cejliok/TxlIYC
X-Received: by 2002:a17:903:1c2:b0:2b0:60db:7927 with SMTP id
 d9443c01a7336-2b08278ba9dmr8696405ad.28.1773962767885; 
 Thu, 19 Mar 2026 16:26:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:26:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/17] hw/riscv/riscv-iommu: Free instance_init allocations in
 instance_finalize
Date: Fri, 20 Mar 2026 09:25:14 +1000
Message-ID: <20260319232522.1867400-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The riscv-iommu device makes various allocations in its
instance_init method. These will leak when QMP inits an
object of this type to introspect it, as can be seen if you
run 'make check' with the address sanitizer enabled:

Direct leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x5d8415b6ed9d in calloc (/home/pm215/qemu/build/san/qemu-system-riscv32+0x1832d9d) (BuildId: fedcc313e48ba803d63837329c37fd609dd50849)
    #1 0x75c0502f1771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5d8416d09391 in riscv_iommu_instance_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu.c:2463:18
    #3 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #4 0x5d8417104ee9 in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
    #5 0x5d8417104ee9 in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
    #6 0x5d8417104db1 in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
    #7 0x5d8417106506 in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
    #8 0x5d8416d16a12 in riscv_iommu_sys_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu-sys.c:199:5
    #9 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #10 0x5d841710661f in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
    #11 0x5d841755d956 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11

(and other similar backtraces).

Fix these by freeing the resources we allocate in instance_init in
instance_finalize.  In some cases we were freeing these in unrealize,
and in some cases not at all.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260307125222.3656140-1-peter.maydell@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 98345b1280..225394ea83 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2479,6 +2479,18 @@ static void riscv_iommu_instance_init(Object *obj)
     QLIST_INIT(&s->spaces);
 }
 
+static void riscv_iommu_instance_finalize(Object *obj)
+{
+    RISCVIOMMUState *s = RISCV_IOMMU(obj);
+
+    g_free(s->regs_rw);
+    g_free(s->regs_ro);
+    g_free(s->regs_wc);
+
+    g_hash_table_unref(s->ctx_cache);
+    g_hash_table_unref(s->iot_cache);
+}
+
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
@@ -2597,9 +2609,6 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
-    g_hash_table_unref(s->iot_cache);
-    g_hash_table_unref(s->ctx_cache);
-
     if (s->cap & RISCV_IOMMU_CAP_HPM) {
         g_hash_table_unref(s->hpm_event_ctr_map);
         timer_free(s->hpm_timer);
@@ -2675,6 +2684,7 @@ static const TypeInfo riscv_iommu_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(RISCVIOMMUState),
     .instance_init = riscv_iommu_instance_init,
+    .instance_finalize = riscv_iommu_instance_finalize,
     .class_init = riscv_iommu_class_init,
 };
 
-- 
2.53.0


