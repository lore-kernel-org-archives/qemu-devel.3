Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF11DD6AB17
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q24-0008Gm-P7; Thu, 02 Apr 2026 17:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q23-0008G6-Fh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:55 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q21-00074N-Uq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:55 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b982518b73fso207700166b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167012; x=1775771812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9c0Pnh/0o6ZwLnjL42VohEGpoZWx1Y/0tXtC4CKsYA=;
 b=Dz32pvxwQNO3chVdb0X4trFzEVoauhIIPZPfFHhLvY+p+k+9mOIlXDovWe/vk3qW2z
 Jwlg4CJEnPKq+IQZaAs+YH1lpnnlnUUMy7lxxj6b1Msraad/WB+WFXje+QQKUlSrLFol
 3jZ3vFHlAYD1piqB2DNucFJkdIxUGoNKwQ8ofb9lXQVygVHHzNsBrYWDX1R9VYogo4C4
 Zm+Xu/mY5bd5Cpxi36Q9qyA4hG7iT864BAgWh3oQewQyrEsRgPR4UqY3b4OTNkfGakFA
 zHenkWStIggLu7K4N3F5GqwOcb+bt6EqNzdCC5UH4DyCw817A0/BFyFvsbnAgNWgLzIp
 pX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167012; x=1775771812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S9c0Pnh/0o6ZwLnjL42VohEGpoZWx1Y/0tXtC4CKsYA=;
 b=geewbZUW6Y9AojGJcWFde6uvlfzaAxS5GhkWDLkJ+uflMWeZvoC63+m+5C//SufZhQ
 6qakOh0Iho3NY3vmUgwLaXyfpGoi6AvS2kVWCoVyhSzryjME88BT/IJVmi3/3a5impjb
 nlM2ZRyxefUHyRQy3GijQRqxGRr602rBy3rwx3v5AnKXhL6z3p5770Ct0Gvs5kmVdwD1
 t8d5k49e1tSRxS2zwn56wJ6Km9bG8R5BtMUPQQ30j5XTvVKNyaWIMj/QdGQeEeJEx455
 9Pwdr8bzKakgsSoW8dZ9BXnfUpTRMFoDHYxdZU/uRtbMBnuVsHvZQe0KZvXaEQ9Oe+xP
 uIDQ==
X-Gm-Message-State: AOJu0Yxms37cPclVc1Z+7NB5F3U7HEvmOTKAjBITovB+nPv4cSDYCxdN
 MPOVgEjSa9T2FG5ucGZzNHZlqmji30sl1dwuxaM6m4znG2ot5jVjzMWwW1tCaLtW
X-Gm-Gg: ATEYQzx1VSR1r0t4hzusdFTqzsjX2nYpr6wNpNPIEHs7IhJvRTAdz8ztqiAgpx3uBvv
 G68xNC4LUFxc3h0fuy3v6PPALNMfivI848pysBtGwaHiilgTgnS5ggEe4fm6xRb6AwOfOIzofBe
 qJBgv2ieST/ZeCvHs2w0wJwVCtLv+UR7ouK+pH9cVjBXAXCZa5hk0L7LACRxz0ZZhEClPYc9iiy
 tzOXLVnVDv+5Tf1YB4QPVD85P0S4Mxky4A6TQiYjNykYluY8BNCZ314iVUy4HNJoGTIBPbP3tJK
 1cNXSfoAOeVXKG1rXst/9vFVzvEMMucntsGzhS6m6HQF0HFX/+dwjXg/qSRbOM4dzz+A14YLPQo
 2/sYsdnRSr4yqKdcI2X6EaZTHRvhN8fYk2yRUYppCY14F3LiyN57N5JYvpLj11X83MOoeNLiT/9
 AAGb8VWtYDsEL83XmhGS280ZmBfFssaF+8BHVfBhDAGilGG8kDEjEgPlA5VuGrx5jQaziFLA==
X-Received: by 2002:a17:907:3e8a:b0:b99:7462:3c57 with SMTP id
 a640c23a62f3a-b9c6754ad85mr23744666b.14.1775167011775; 
 Thu, 02 Apr 2026 14:56:51 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:51 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 06/33] hw/core/fdt_generic: add cpu clusters management
Date: Thu,  2 Apr 2026 23:55:51 +0200
Message-ID: <20260402215629.745866-7-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x635.google.com
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

Add support for grouping CPUs into clusters during
FDT machine instantiation.

The clusters are automatically created if CPU parent
is not already an existing cluster.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic.c         | 78 +++++++++++++++++++++++++++++++++++
 include/hw/core/fdt_generic.h | 13 ++++++
 2 files changed, 91 insertions(+)

diff --git a/hw/core/fdt_generic.c b/hw/core/fdt_generic.c
index da60de7a26..ded11cd6c0 100644
--- a/hw/core/fdt_generic.c
+++ b/hw/core/fdt_generic.c
@@ -32,6 +32,7 @@
 #include "migration/vmstate.h"
 #include "qemu/coroutine.h"
 #include "qemu/log.h"
+#include "hw/cpu/cluster.h"
 #include "system/reset.h"
 
 
@@ -158,6 +159,76 @@ void *fdt_init_get_opaque(FDTMachineInfo *fdti, const char *node_path)
     return NULL;
 }
 
+static int get_next_cpu_cluster_id(void)
+{
+    static int i;
+
+    return i++;
+}
+
+void fdt_init_register_user_cpu_cluster(FDTMachineInfo *fdti, Object *cluster)
+{
+    int i = get_next_cpu_cluster_id();
+    DeviceState *dev = DEVICE(cluster);
+    FDTCPUCluster *cl;
+
+    qdev_prop_set_uint32(dev, "cluster-id", i);
+
+    cl = g_new0(FDTCPUCluster, 1);
+    cl->cpu_cluster = cluster;
+    cl->next = fdti->clusters;
+    cl->user = true;
+
+    fdti->clusters = cl;
+
+    qemu_log_mask(LOG_FDT,
+             "%s: Registered user-defined cpu cluster with id %d\n",
+             object_get_canonical_path(cluster), i);
+}
+
+static void *fdt_init_add_cpu_cluster(FDTMachineInfo *fdti, char *compat)
+{
+    FDTCPUCluster *cl = g_malloc0(sizeof(*cl));
+    int i = get_next_cpu_cluster_id();
+    char *name = g_strdup_printf("cluster%d", i);
+    Object *obj;
+
+    obj = object_new(TYPE_CPU_CLUSTER);
+    object_property_add_child(object_get_root(), name, OBJECT(obj));
+    qdev_prop_set_uint32(DEVICE(obj), "cluster-id", i);
+
+    cl->cpu_type = g_strdup(compat);
+    cl->cpu_cluster = obj;
+    cl->next = fdti->clusters;
+
+    fdti->clusters = cl;
+
+    g_free(name);
+
+    return obj;
+}
+
+void *fdt_init_get_cpu_cluster(FDTMachineInfo *fdti, Object *parent,
+                               char *compat)
+{
+    FDTCPUCluster *cl = fdti->clusters;
+
+    if (object_dynamic_cast(parent, TYPE_CPU_CLUSTER)) {
+        /* The direct parent of this CPU is a CPU cluster. Use it. */
+        return parent;
+    }
+
+    while (cl) {
+        if (!cl->user && !strcmp(compat, cl->cpu_type)) {
+            return cl->cpu_cluster;
+        }
+        cl = cl->next;
+    }
+
+    /* No cluster found so create and return a new one */
+    return fdt_init_add_cpu_cluster(fdti, compat);
+}
+
 FDTMachineInfo *fdt_init_new_fdti(void *fdt)
 {
     FDTMachineInfo *fdti = g_malloc0(sizeof(*fdti));
@@ -171,8 +242,15 @@ FDTMachineInfo *fdt_init_new_fdti(void *fdt)
 
 void fdt_init_destroy_fdti(FDTMachineInfo *fdti)
 {
+    FDTCPUCluster *cl = fdti->clusters;
     FDTDevOpaque *dp;
 
+    while (cl) {
+        FDTCPUCluster *tmp = cl;
+        cl = cl->next;
+        g_free(tmp->cpu_type);
+        g_free(tmp);
+    }
     for (dp = fdti->dev_opaques; dp->node_path; dp++) {
         g_free(dp->node_path);
     }
diff --git a/include/hw/core/fdt_generic.h b/include/hw/core/fdt_generic.h
index d204ceda43..05ab07e08c 100644
--- a/include/hw/core/fdt_generic.h
+++ b/include/hw/core/fdt_generic.h
@@ -18,6 +18,13 @@ typedef struct FDTDevOpaque {
     void *opaque;
 } FDTDevOpaque;
 
+typedef struct FDTCPUCluster {
+    char *cpu_type;
+    void *cpu_cluster;
+    void *next;
+    bool user;
+} FDTCPUCluster;
+
 typedef struct FDTMachineInfo {
     /* the fdt blob */
     void *fdt;
@@ -27,6 +34,8 @@ typedef struct FDTMachineInfo {
     FDTDevOpaque *dev_opaques;
     /* recheck coroutine queue */
     CoQueue *cq;
+    /* list of all CPU clusters */
+    FDTCPUCluster *clusters;
 } FDTMachineInfo;
 
 /*
@@ -72,6 +81,10 @@ void fdt_init_set_opaque(FDTMachineInfo *fdti, const char *node_path,
 int fdt_init_has_opaque(FDTMachineInfo *fdti, const char *node_path);
 void *fdt_init_get_opaque(FDTMachineInfo *fdti, const char *node_path);
 
+void *fdt_init_get_cpu_cluster(FDTMachineInfo *fdti, Object *parent,
+                               char *compat);
+void fdt_init_register_user_cpu_cluster(FDTMachineInfo *fdti, Object *cluster);
+
 /* statically register a FDTInitFn as being associate with a compatibility */
 
 #define fdt_register_compatibility_opaque(function, compat, n, opaque) \
-- 
2.43.0


