Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7609E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI2F-0002yG-GW; Thu, 05 Dec 2024 15:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YAZSZwgKCvUtebkaofhdlldib.Zljnbjr-absbiklkdkr.lod@flex--whendrik.bounces.google.com>)
 id 1tJI1i-0002rH-VA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:42 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YAZSZwgKCvUtebkaofhdlldib.Zljnbjr-absbiklkdkr.lod@flex--whendrik.bounces.google.com>)
 id 1tJI1f-0001dS-KP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:42 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434a29a93cdso11018155e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428832; x=1734033632; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=WdDRNCpvhyFf5ymMFmEKsE00vimCuFTsFl7VJrJoo7A=;
 b=JY8Q5wuM2BvYvMpZ5nnHllRpDjOTC8SldftmkljBkUPENm18XE7bxMeGYVgCaUEh3I
 XsRun27WaQSG2AwTxMjYYhvTCS+aBxuC8hH8n8wiGw2KandCMxI3yz49PvSQkuUZujHn
 VyxT7AbxZ5w5N5cM5qQ9ZfQEg2qf5gQ0Sca4SPEFCSlPaaM1t//Z2AeOwjpHTErzuhqQ
 oirQ+gx6QRTsOU+CjXaBm/6XBNQwElhIRTDqomqNtx/ElHXN6Ey+6WQMJ/HafCb4tWRQ
 wK0fdQNd3dit3Sd/q0cEAtLK89SLb1sgJM3k91zndqQ1qGv+kzPgx5wlO7goPV359xiP
 WyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428832; x=1734033632;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WdDRNCpvhyFf5ymMFmEKsE00vimCuFTsFl7VJrJoo7A=;
 b=M30wJhQfYSE+0e9aremuIq6oMldLFcil0CTJQgKLLBHgBhmwb+aHcNvoeH7TT/atE2
 Yu8ph0824zIR2HQJmT2sLrNheSG+5Q/O3U8xkkfQaBlNnzfRzr4kMlSlyo8a8doPI9YU
 51thIU6o2gPAYGCS44eDtKMk220OR9X3eYRBsLudHmLHOJ71SVwtepoF9tQPWFSy9HBQ
 Dh6yCcBbUpa6QmnQ9pMR82XB2Q0CNMmuv7om2Rq0lhI2bRBltmM8z6V4h72tH2IhVIpJ
 PSFmHcxDrRD6thBs/1pV38eLWGOaJdyBIvvfUsY7uOomlF6dg1XyB3vRQsbkXjiilnfX
 uHQQ==
X-Gm-Message-State: AOJu0YyU8+yQgyQNcpp9K8QoAeNUfJKPntDBueKIq+68/MB/ADfo3xKD
 RePI44TbQHalumScvxnhf44dCeCil3/1uHJ2flwP4EplJY31kBdIGHvRJLThYEUW7H4a0Fei3EI
 CPebFSTNLONuz0gkoaq+uQ1X8QkP1y2q1LDrStMbGebIxEGVyz90FdFSW0YxIEHsVtPZUrh4gj2
 5x/ugfPnE1ovd9RsSuZTcfCsQgaOPhHhQuPNESIk3Sow==
X-Google-Smtp-Source: AGHT+IHG7XNoJTIFl6Dp6p5xr39MiMesFUfdc+FZPX2nYgS2ioWLM/vcC4jLEr7WqEWWrLNZGsTSNgWn2F8q6Q==
X-Received: from wmbhi5.prod.google.com ([2002:a05:600c:5345:b0:434:a735:35ac])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:19cb:b0:434:a5b3:8fee with SMTP id
 5b1f17b1804b1-434dded66aamr4371655e9.26.1733428832237; 
 Thu, 05 Dec 2024 12:00:32 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:19 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-3-whendrik@google.com>
Subject: [PATCH v4 2/8] i386: Add init and realize functionality for RDT
 device.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3YAZSZwgKCvUtebkaofhdlldib.Zljnbjr-absbiklkdkr.lod@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
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
2.47.0.338.g60cca15819-goog


