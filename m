Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654B7CD5BAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAZq-0008PZ-3Q; Thu, 05 Sep 2024 07:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3iJTZZggKClUJ41A0E573BB381.zB9D19H-01I18ABA3AH.BE3@flex--whendrik.bounces.google.com>)
 id 1smAZk-0008HU-21
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:22:56 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3iJTZZggKClUJ41A0E573BB381.zB9D19H-01I18ABA3AH.BE3@flex--whendrik.bounces.google.com>)
 id 1smAZh-0002xh-RD
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:22:55 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-428ea5b1479so5057795e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725535369; x=1726140169; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=adQIItV2Bd4wpCPsRoA7kna0L5g0qP2kQ/G7mcrHEY8=;
 b=oaNLpMa0dd4cUyh+1mQbdLhi/p5zPWtNX/TpMwqBklQbHEuSdj4gwvpUB5PiNIqnTe
 DVk5ak7wc+MixDoBB/oa5VGY78RTDT67JIqctCCdz917ZA4U8fUdpfO4woK6uzv1sjXQ
 Je8a2aXUjy1IQiCZpFVBjAJyqrjmJ/PC1HPaiwOG/ZWWr/xxAxsEC6F546YP6m7T57bz
 yf6V8cifBFgJd1XZmCgX3vtWT6QDA9+rgc6bzOlIAAdC+obHVpu6s2Ovg4rn8PKbKPON
 gtnpQSlTVsedUzUjFqJxOhriTyJPHw7/46nk8FOn9N/239Z+g8kc1QQmT5SuDVbmRMCP
 F+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725535369; x=1726140169;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=adQIItV2Bd4wpCPsRoA7kna0L5g0qP2kQ/G7mcrHEY8=;
 b=i/bKNSCa9nVLlTIgVE7hLkvVwj20ookTnb0UwsJ5NOMcW8Mv93wVRZuC2wHI+KlYSO
 V9gT1uLsAoKng2MKP6rCO2Pop1ILDKCtphLgiRU+pydXX0iACAaroPAxJwNc/4mo6HRt
 va/DDTztxEHOtuy127ThizzhkuI0S/GVAXMfQerWCQdH1cd9Jb4i6HcXGjtPKie611t6
 bTgqOkTaZDRZeb/VY3DS7BWlTqX4PTBu31RYCYHH2jBmP6mcqgGa1Ps0bWItLW2fgu5C
 ilDocdcl+kHc9I6vAKwGSrCKhS+NOfcVh185iB7egvc8L408We9yVnCKtJ8/aMfOqLG6
 FsIw==
X-Gm-Message-State: AOJu0YyZBy7JbMX3J992oTGVNBWEuUjCPRQkeUA8j1A4KHqAApjey50+
 2IsGm1eIU42Vf0Ssv+WvJT33/ahYSkP5KY/sqpanROUgjGKNBJxd1U4jxy4pr88Ugh8MpNibBQq
 gq1hUBsVgG3nPxAYyCVNeEPE/Ni1y0m+W/ucVNM2vVIXVTV3kRL1hGp5q2LL0TigP7nOQR2DV8u
 Yz5YrFTSZJ+rFSuegZR//fjpuONkXo8/iz34Ib5jmTfg==
X-Google-Smtp-Source: AGHT+IEaDUZLVXxp1TJ0G0UGU5ZqHYGZNTMxVFURQxuTNATCDysB9TInrmx8xEad+QB8vg9S34gFODTW+JRPeQ==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:130:7cd9:ac11:98f1]) (user=whendrik job=sendgmr) by
 2002:a05:600c:997:b0:42a:b897:826f with SMTP id
 5b1f17b1804b1-42bbb436477mr506185e9.5.1725535368898; 
 Thu, 05 Sep 2024 04:22:48 -0700 (PDT)
Date: Thu,  5 Sep 2024 11:22:31 +0000
In-Reply-To: <20240905112237.3586972-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240905112237.3586972-1-whendrik@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905112237.3586972-3-whendrik@google.com>
Subject: [PATCH v2 2/8] i386: Add init and realize functionality for RDT
 device.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3iJTZZggKClUJ41A0E573BB381.zB9D19H-01I18ABA3AH.BE3@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
index 934f7fbf75..c395ab91a9 100644
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
 #define RDT_MAX_L3_MASK_COUNT      128
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
2.46.0.469.g59c65b2a67-goog


