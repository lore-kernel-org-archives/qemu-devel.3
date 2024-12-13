Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9590CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9RX-0008Sp-PP; Fri, 13 Dec 2024 12:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Y25cZwgKCvIqbYhXlceaiiafY.WigkYgo-XYpYfhihaho.ila@flex--whendrik.bounces.google.com>)
 id 1tM9RV-0008RN-UE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:09 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Y25cZwgKCvIqbYhXlceaiiafY.WigkYgo-XYpYfhihaho.ila@flex--whendrik.bounces.google.com>)
 id 1tM9RQ-0007oO-Hu
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:09 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso11370005e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110819; x=1734715619; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=NGf8wLhXTiQ0lyfdQV4U43peDicsASrnc3eX2nyBszM=;
 b=j/hVN1A1nGlrnfIy+iF0UbqiUln5HXjkITJh7TipRiOoMIsK09RwUzV/QoFHVt3XYI
 0Ph0Lqc5ymIPCbd2a1U3+OBfq3d2qXjNWUQ3rppAADwhHulNOj1iQOvfPXBZuYNj14Xk
 jYyXjqJG3oRcgg+iOSDrYGMkr3QHHQRsPUMGwEmMGGQ6e/kobe18aIV8jVLKDuXhguAQ
 ERp7ZppTqByEtCswoAzU0UTDIlCq5XMPfnFUZqLefIRPV750LR6hyES0ec2cBsQ7kp1B
 SDNnchoGxHtfHVJ3UthrtGU6x+oWueUTfizLIllW60JTcTAyiWS5ihbTNl6ImjSRcHLZ
 hr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110819; x=1734715619;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NGf8wLhXTiQ0lyfdQV4U43peDicsASrnc3eX2nyBszM=;
 b=IgjdRjNdytdIZnXFpeNDS2GkUN+aXGQvdd7ZqvgTGZFccv3WCellLpghud+kdTROd3
 85FI4YKy/bkUJufSW4UWz+WKCGjsZ9k2VtmTN0YHpgXxFt7EA1vKyssDGJO96d9AYaYi
 VWXaw4Rra+N6u6OBUb5UGGB3miwswcB4rzDWG0iLJYKsexTP3KAE0PeVyefHRM9LVaeK
 2mHsyklZ0uw9WgtpWAVGwl0QgUDVvnYNO9F//TjKOIvbhfVnxMDnck6JHGAnN15X5blI
 VtN7dvjisYOKgjbDuTvHvz1w3in9DWsJKJ6fCIS1f1XQFXWOUrdon7aF8xJxazo92cXc
 Wt8g==
X-Gm-Message-State: AOJu0YzgUObEviBUGKqjNopP59N4CV3W4s18Lub4YoPmfvlTMrmWYAdc
 fbfibcKJQFP6wtuS9SGo8OF6yyV/7haj6xZrrYuYZGMYLC7SQDrpKLegszCAlzUV7c1ce0FmXTe
 rxKXo2yPWId1SxqOQ6qDvTq33JnEgE99fo5yhZqdLV2mh7Hyg5yk8u7Ifh5iRav11FW+6RTIXZa
 oik1hvEherZJTcAWQJyRikf0bPomrRYQLHRtnYsT2MSw==
X-Google-Smtp-Source: AGHT+IGpjpi7dRbaMmYXtqxJoLZTqnue9rQ8lCMvq97+ObLJmBo1h/rqANrAbnUnEt/6auhX3b1W1eI+ZUsaFw==
X-Received: from wmhp10.prod.google.com ([2002:a05:600c:418a:b0:434:eba6:52fa])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f07:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4362aa50f6emr31900055e9.17.1734110819437; 
 Fri, 13 Dec 2024 09:26:59 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:39 +0000
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-3-whendrik@google.com>
Subject: [PATCH v5 2/8] i386: Add init and realize functionality for RDT
 device.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3Y25cZwgKCvIqbYhXlceaiiafY.WigkYgo-XYpYfhihaho.ila@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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
index b2203197e3..920e9c5dbe 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -19,6 +19,7 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "qom/object.h"
+#include "target/i386/cpu.h"
=20
 /* Max counts for allocation masks or CBMs. In other words, the size of
  * respective MSRs.
@@ -83,8 +84,36 @@ static void rdt_init(Object *obj)
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
@@ -94,6 +123,7 @@ static void rdt_class_init(ObjectClass *klass, void *dat=
a)
     dc->hotpluggable =3D false;
     dc->desc =3D "RDT";
     dc->user_creatable =3D true;
+    dc->realize =3D rdt_realize;
=20
     device_class_set_props(dc, rdt_properties);
 }
--=20
2.47.1.613.gc27f4b7a9f-goog


