Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EF7E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl41-00009X-NJ; Wed, 04 Dec 2024 03:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bxdQZwgKCiASDAJ9NEGCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--whendrik.bounces.google.com>)
 id 1tIl3z-00008p-Ew
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:51 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bxdQZwgKCiASDAJ9NEGCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--whendrik.bounces.google.com>)
 id 1tIl3x-00010v-Nb
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:50 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-43499c1342aso46239015e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302127; x=1733906927; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=eXFyctxkBvRei3YT2F3Psi/6Kuihl3jqAhbmBpNvGuM=;
 b=TZlE80/nNO5oWSlfgELYc5IL/qzL7x9budUAwZq5L3Ir1UCYJb6V3vfWeKpU8gj96Z
 JGKYXlhaV8MA1V1fvl41/8p3SnvwWvj7zRheyXcuD7JKX+u2KL1ijZTXkWCX/vfcWycF
 HHaj6UIKrR7MIJC6y4/DeOMRQ0enEJG2RI6mu48lKDIOYdIbCJ9S5mSBUAmRUwT0Ra4N
 WBozmKoHGnfyY9NUMo5RuoavbUvuJnVKw+J4T9zkt2bbShDiKuiD5bW81wY6gFptsuaY
 eWkt8ePoHsD9+v33JFUVkfSlJ7Cei1Yw2WcsbdWKIaVoiwuuUL20R4XVqhNjUwKLey/t
 fRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302127; x=1733906927;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eXFyctxkBvRei3YT2F3Psi/6Kuihl3jqAhbmBpNvGuM=;
 b=mZZcDvIqrkD3qyvsrbbKmgDYX1JU6MiQ8sr7vlN9d0jrBDDZL4ymUuAPAVVfJ3AEfR
 aM+41JN2eywI+iI6xRA+nXWByvFXvjgX5+9TbDtq/m+Shjn9QvnmXAM00q05tLQJCWUP
 FAxpXyG77KUIbZ58w0UKz+WhQI+M3Vng7tIgqRn7lo20qY78t1GhGQmb2T/Cgm3/F4fI
 NuhAZmraEfDb8UPyumXVfaGTjnimkQVTGandrZChx48TCzENOhNM0WdsYUFpZd/8sFeP
 uXbFxIWPhhGb6ULbEg0cY3a+YQbfxdsAduOXPrMcpvq10DGehZrFwjZjrakQLieXJkc7
 +Viw==
X-Gm-Message-State: AOJu0Yy1+3gcD7A2Putw1Bu451LVkLwIcdMSQg2gYZ8lFnTQo0PvKLCN
 1GdxPHkcHfa2TTDE7GapX38uNohztZiXgdMADdfqkxupKeGZ63we+PV/vEn3A2w10MdS9BOvUE8
 0nLkLCb7AKzMXRsGMdka+jgZA5YpLfILHW7SSElpjyl/B5BfRo2jMGBHHAW0TY8t2QdJiw1bnI1
 00Pczk5Z+qeaPDaG2ZNrtM9Gmzpg4augXKGSydJPDOTg==
X-Google-Smtp-Source: AGHT+IEeb/qA9CjVD/EtGV5Vv6wdQVNVRuFh1CKbS4Mk09hSGcPizyl7dIPDUDGbepSk2jFZemgSweIeW5KIzg==
X-Received: from wmo26.prod.google.com ([2002:a05:600c:231a:b0:434:a028:7b9a])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba1:b0:434:9dfe:20e6 with SMTP id
 5b1f17b1804b1-434d4102563mr24065855e9.23.1733302127655; 
 Wed, 04 Dec 2024 00:48:47 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:31 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-3-whendrik@google.com>
Subject: [PATCH v3 2/8] i386: Add init and realize funciontality for RDT
 device.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3bxdQZwgKCiASDAJ9NEGCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Add code to initialize all necessary state for the RDT device.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/rdt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index d0afbd04fb..2fb9fb476b 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -19,6 +19,7 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
+#include "target/i386/cpu.h"
=20
 /* Max counts for allocation masks or CBMs. In other words, the size of re=
spective MSRs*/
 #define RDT_MAX_L3_MASK_COUNT      127
@@ -79,8 +80,36 @@ static void rdt_init(Object *obj)
 {
 }
=20
+static void rdt_realize(DeviceState *dev, Error **errp)
+{
+    CPUState *cs =3D first_cpu;
+    RDTState *rdtDev =3D RDT(dev);
+
+    rdtDev->rdtInstances =3D g_malloc(sizeof(RDTStatePerCore) * cs->nr_cor=
es);
+    CPU_FOREACH(cs) {
+        RDTStatePerCore *rdt =3D &rdtDev->rdtInstances[cs->cpu_index];
+        X86CPU *cpu =3D X86_CPU(cs);
+
+        rdt->rdtstate =3D rdtDev;
+        cpu->rdt =3D rdt;
+
+        rdt->monitors =3D g_malloc(sizeof(RDTMonitor) * rdtDev->rmids);
+        rdt->rdtstate->allocations =3D g_malloc(sizeof(RDTAllocation) * rd=
tDev->rmids);
+    }
+}
+
 static void rdt_finalize(Object *obj)
 {
+    CPUState *cs;
+    RDTState *rdt =3D RDT(obj);
+
+    CPU_FOREACH(cs) {
+        RDTStatePerCore *rdtInstance =3D &rdt->rdtInstances[cs->cpu_index]=
;
+        g_free(rdtInstance->monitors);
+        g_free(rdtInstance->rdtstate->allocations);
+    }
+
+    g_free(rdt->rdtInstances);
 }
=20
 static void rdt_class_init(ObjectClass *klass, void *data)
@@ -90,6 +119,7 @@ static void rdt_class_init(ObjectClass *klass, void *dat=
a)
     dc->hotpluggable =3D false;
     dc->desc =3D "RDT";
     dc->user_creatable =3D true;
+    dc->realize =3D rdt_realize;
=20
     device_class_set_props(dc, rdt_properties);
 }
--=20
2.47.0.338.g60cca15819-goog


