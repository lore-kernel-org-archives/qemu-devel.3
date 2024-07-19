Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E03C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrVU-0004Os-Dg; Fri, 19 Jul 2024 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dZSaZggKCkQ2nktjxoqmuumrk.iuswks0-jk1krtutmt0.uxm@flex--whendrik.bounces.google.com>)
 id 1sUqUN-0002iX-Pl
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:47 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dZSaZggKCkQ2nktjxoqmuumrk.iuswks0-jk1krtutmt0.uxm@flex--whendrik.bounces.google.com>)
 id 1sUqUL-0004KA-2i
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:29:47 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-65026e6285eso52748867b3.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721406582; x=1722011382; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Bdpi4qxy6nysCNztiZCnDOGwe5xEskZ2zzdtlW790js=;
 b=LLkZWVk+c7ytZvqZCYabBg+94rJjMkX148YperyM/DEZHT7gL/7Q3GQAX+9ty17hud
 jXPyI2LlZ/RT3xp7tPDq4sLnNtSJu1JqKI4SH13tdOKf2tpP9f3FTbpWMfXO8lBJh2Gu
 ygYyokFRvYwr4l3SzCulGgWdO5gjI0Vb79ogXHEwj4UZUO5NoEne8G71KlkHXDvH4kOz
 ut8Cf/jwm6PYP0hYf/JCRcPPdF6wsVCTE50fDwZhw//kRGq9M291NNrxkVq4r/v0b1Jm
 /0QMzmBWeKll9KNsaQaDS2fculF96HQuUHDqYmoKqd1dSTBJ2EvgPTbjeJmlJduUQbfE
 R4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721406582; x=1722011382;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Bdpi4qxy6nysCNztiZCnDOGwe5xEskZ2zzdtlW790js=;
 b=LBq3w1QqZWmybmWZo5VOppSTeAy3LIpXbd12CJ9F3Uc5JeHO82M9r9XaoovXuXas2k
 BIu5q/mbWJXpZPsWhRrMO4z9APDIkHA22CA+OhcvSZ7CvzShYqZsIiQgJPHH33WqEtSU
 h5F97/l1K71ZqHVozUKeaIYb2EDpykyMTVOk8gfz6G3SLnV0IwtQXzrANb46bVNVVTnt
 oFR3KuSSyb3XSPIiJwpK9H6P/Z/UJteDgnAUukNbLjovvDxbdVmLBn3pa4D9iM4Xwz6n
 EPiQBbIQHasp84qQGtsmomzDh8aTEbEsqgVITInwfnJfQENl/Tm5r51pPRbQQ2IA/D3n
 ypmQ==
X-Gm-Message-State: AOJu0Yy67VNIVTLbVlH+ivZ5TWQhIcG52uvDjzl4Ne+/L0TL8LfibKQo
 +etoD4ZmUxKcS9mpGFDwxdFZ2J3/LcpbMhNhA44spBtQ+bht7n37XMYBdxRlnX4EgF34wjeWTMl
 WlV2YOm1hwuBlcLNlUouD3phoPIEGjNGEXCJSM+ZVaKCfhAaYD9Bkyk2h30UF0L7zoL16HxAXDE
 Dpnxx/oJ5KE2t5nWLVbKF5jDhKypJqiijU5yR8WxXZGQ==
X-Google-Smtp-Source: AGHT+IGlcqf1STBCidAxMhwY1dOsbDWfoyQvprUg3OY3RwcRe+1LH6DCYrpj54q6mEz8aj/21Q1guY4CW0M2jw==
X-Received: from whendrik-specialist-workstation.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:967]) (user=whendrik job=sendgmr) by
 2002:a05:6902:1003:b0:e03:a22c:df5 with SMTP id
 3f1490d57ef6-e087042cc79mr867276.7.1721406581811; 
 Fri, 19 Jul 2024 09:29:41 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:29:23 +0000
In-Reply-To: <20240719162929.1197154-1-whendrik@google.com>
Mime-Version: 1.0
References: <20240719162929.1197154-1-whendrik@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719162929.1197154-4-whendrik@google.com>
Subject: [PATCH v1 3/9] Add init and realize funciontality for RDT device.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3dZSaZggKCkQ2nktjxoqmuumrk.iuswks0-jk1krtutmt0.uxm@flex--whendrik.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jul 2024 13:34:48 -0400
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
 hw/i386/rdt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
index cf246ab835..259dafc963 100644
--- a/hw/i386/rdt.c
+++ b/hw/i386/rdt.c
@@ -62,10 +62,38 @@ static void rdt_init(Object *obj)
=20
 static void rdt_realize(DeviceState *dev, Error **errp)
 {
+    CPUState *cs =3D first_cpu;
+
+    RDTState *rdtDev =3D RDT(dev);
+    rdtDev->rdtInstances =3D g_array_new(false, true, sizeof(RDTStateInsta=
nce));
+    g_array_set_size(rdtDev->rdtInstances, cs->nr_cores);
+    CPU_FOREACH(cs) {
+        RDTStateInstance *rdt =3D &g_array_index(rdtDev->rdtInstances, RDT=
StateInstance, cs->cpu_index);
+
+        X86CPU *cpu =3D X86_CPU(cs);
+        rdt->rdtstate =3D rdtDev;
+        cpu->rdt =3D rdt;
+
+        rdt->monitors =3D g_array_new(false, true, sizeof(RDTMonitor));
+        rdt->rdtstate->allocations =3D g_array_new(false, true, sizeof(RDT=
Allocation));
+
+        g_array_set_size(rdt->monitors, rdtDev->rmids);
+        g_array_set_size(rdt->rdtstate->allocations, rdtDev->rmids);
+    }
 }
=20
 static void rdt_finalize(Object *obj)
 {
+    CPUState *cs;
+    RDTState *rdt =3D RDT(obj);
+
+    CPU_FOREACH(cs) {
+        RDTStateInstance *rdtInstance =3D &g_array_index(rdt->rdtInstances=
, RDTStateInstance, cs->cpu_index);
+        g_array_free(rdtInstance->monitors, true);
+        g_array_free(rdtInstance->rdtstate->allocations, true);
+    }
+
+    g_array_free(rdt->rdtInstances, true);
 }
=20
 static void rdt_class_init(ObjectClass *klass, void *data)
--=20
2.45.2.1089.g2a221341d9-goog


