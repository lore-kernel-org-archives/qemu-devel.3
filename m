Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B81CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 22:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHTlU-0002E5-KV; Thu, 15 Oct 2026 18:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aksheynew.tanejanew@gmail.com>)
 id 1xHOqv-0007CN-Bj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:02:51 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aksheynew.tanejanew@gmail.com>)
 id 1xHOqs-0003wu-6V
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:02:49 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cd623dfe420so1842379a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792083764; x=1792688564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dNWHiGApJYClZFP7L84aXNGH1QcEQcjuRJ/iMB90xVg=;
 b=Vms+eIbhpBt71zKScTJa+r0ht5ajstXlNMRBH89dFaSeczEkbsKz+vjcD8LXjfwsg+
 alh75vqLCjIPJ5pERZKmEGc+T82SynsinejUfT3tPy9Fqr3fqwnl9l1at5+vi6lB7EvU
 YfBcut+W0BIychSR2wpg99B6bL5r3EC657zzGU7pU6GEvO+cWxisEkbz7mwVsPlJb5aI
 MPEEOC68M8+lUpn74gkJMXyoPjMyAs4NcJeWa+eaXy7rR2+gdLrjNEpINpSZhXD6Gj4u
 /IiF7JSFJcWrlEy8FpniamWnbBfUDwO37O3NiCoYhIfMu02jxR36pGQrEZbkOPBXAdax
 HllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792083764; x=1792688564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dNWHiGApJYClZFP7L84aXNGH1QcEQcjuRJ/iMB90xVg=;
 b=0urUxI9bobTqPm19A6k7KJmugLXOE/f3K1ACNr8IKY4NIujJkSkjhsD/zjlxujnAOS
 C6CfCe0Q8/UGM36g8lRGuSG7QJuQrg8wGR2TfE3hhWk/s+nUvelzO+z00RUdiQkwttJb
 0PSmyR9M73ofXGp3NnwUJ+x+cSq42cEgqI87uyezL4XEkhV3FEeuc2FntenItMor5vMH
 +QHqv7303KV4vLJPuv9gJptIXx6k2OT+lcjlF0Lj+b2S/2T3t6jQCEhhKFW+efdcZdz1
 n9cTrgG+D9HHN1/d3i9mAYBx9xYkpAj51bZefBSGMJTcO+GzJt1rCZw7N0DBoNQ+E1rB
 Tzxg==
X-Gm-Message-State: AFq9FYIkaoX4c6I/IIwul/0EcsuoDuv0M2Cf78owUp2ZNeqgznfmSVC7
 gUoy6W80UFDLGq7HwU3OOppjlAtzrZrDHKQQrNP/1o+A8CPK56/qDEPaticliQ==
X-Gm-Gg: AYBFou26I59LieZ+wPZaMQqcyNiBQZckVqmZsr65Inend7j/8PSU1hoKwoQDWFhEeAX
 RRXYXbs1NfvpOaNSuxP+ylDZYQtuCN27c+HPuHf2WOeQx0KQ0CX/7fon8KA2C3u33cVl7mnXpm7
 O4nS2YCFt9eBX/yuxr4xTB7QCuZ5wQyw3Ej6DGx2c7JJDXsA+eSyd1Ery3gvWGwpPF31eSDY7N0
 mqSd8Fphnv31uMpdH+VvTcEiBmp78s+o7iLBSZsujFPRIdh0olMlgwF33vxQPgh4pN7y/UAzz6r
 LVXUBN2VAoVxfvaqgsrJeRKe5GCVAkDMLzcmdogB12F4iMetg1OA9dZ017cXy/fD6HSz/hO93LI
 dk+CgDN1akxowS7KG+B6mJAeChF4yUJS4vcCrm2ZvlBwiZe07psLappwfppwWcI1rsCxeU5Faeq
 BUPjfFa+Vh98J2mbSMvfBS+mvMKLwGZsKzTae4vwwz5TEq0rozaqqjw4yyFBCJUbHyaTDmbRnH0
 DudlyGv+6UIwiVUMT9/8GMBT06qwUtv247TYlZFSNK6vOG3yhjA+4HOrjxhAr8eDZUyq2X7/uyo
 7HVShgWH1VkW08Bh/bpJ4Q==
X-Received: by 2002:a17:90b:4b05:b0:3aa:ff19:42b8 with SMTP id
 98e67ed59e1d1-3ab3a9aaab6mr18997841a91.27.1792083764510; 
 Thu, 15 Oct 2026 10:02:44 -0700 (PDT)
Received: from STA-DBBJ1B4 (c-73-254-235-207.hsd1.wa.comcast.net.
 [73.254.235.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm5893712a91.9.2026.10.15.10.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 10:02:44 -0700 (PDT)
From: Akshey Taneja <aksheynew.tanejanew@gmail.com>
To: qemu-devel@nongnu.org
Cc: Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PATCH 1/2] whpx: i386: do not require ProcessorFeaturesBanks on
 legacy Windows
Date: Thu, 15 Oct 2026 10:02:15 -0700
Message-ID: <20261015170216.6895-2-aksheynew.tanejanew@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261015170216.6895-1-aksheynew.tanejanew@gmail.com>
References: <20261015170216.6895-1-aksheynew.tanejanew@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=aksheynew.tanejanew@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Oct 2026 18:17:31 -0400
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

WHvCapabilityCodeProcessorFeaturesBanks and the matching partition=0D
property are only implemented from Windows Server 2022 (build 20348),=0D
the same cutoff already handled for the perfmon capability in commit=0D
68438cb3cb ("whpx: i386: workaround for Windows 10 support").=0D
=0D
On Windows 10 the capability query returns WHV_E_UNKNOWN_CAPABILITY=0D
(0x80370300) and whpx_accel_init() aborts with -ENOSPC, reported to the=0D
user as the misleading "failed to initialize whpx: No space left on=0D
device". This regressed Windows 10 hosts in 8b87283ce4 ("whpx: i386:=0D
enable all supported host features").=0D
=0D
Fall back to the original single-bank WHvCapabilityCodeProcessorFeatures=0D
on legacy hosts and skip the corresponding SetPartitionProperty, which=0D
restores the pre-8b87283ce4 behaviour there.=0D
=0D
Reported-on: Windows 10 Enterprise LTSC 17763, Intel i7-6700=0D
Signed-off-by: Akshey Taneja <aksheynew.tanejanew@gmail.com>=0D
---=0D
 target/i386/whpx/whpx-all.c | 61 +++++++++++++++++++++++++++----------=0D
 1 file changed, 45 insertions(+), 16 deletions(-)=0D
=0D
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c=0D
index 113f79afb9..9a9fc7d974 100644=0D
--- a/target/i386/whpx/whpx-all.c=0D
+++ b/target/i386/whpx/whpx-all.c=0D
@@ -3193,13 +3193,35 @@ int whpx_accel_init(AccelState *as, MachineState *m=
s)=0D
     memset(&processor_features, 0, sizeof(WHV_PROCESSOR_FEATURES_BANKS));=
=0D
     processor_features.BanksCount =3D 2;=0D
 =0D
-    hr =3D whp_dispatch.WHvGetCapability(=0D
-        WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,=0D
-        sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);=0D
-    if (FAILED(hr)) {=0D
-        error_report("WHPX: Failed to get processor features, hr=3D%08lx",=
 hr);=0D
-        ret =3D -ENOSPC;=0D
-        goto error;=0D
+    if (whpx_is_legacy_os()) {=0D
+        /*=0D
+         * WHvCapabilityCodeProcessorFeaturesBanks, like the perfmon capab=
ility=0D
+         * probed above, is only implemented from Windows Server 2022 (bui=
ld=0D
+         * 20348) onwards. Fall back to the original single-bank capabilit=
y,=0D
+         * which Windows 10 does implement, and treat failure as non-fatal=
:=0D
+         * the banked feature set is an optimisation, not a requirement.=0D
+         */=0D
+        WHV_PROCESSOR_FEATURES legacy_features =3D {0};=0D
+=0D
+        processor_features.BanksCount =3D 1;=0D
+        hr =3D whp_dispatch.WHvGetCapability(=0D
+            WHvCapabilityCodeProcessorFeatures, &legacy_features,=0D
+            sizeof(legacy_features), &whpx_cap_size);=0D
+        if (FAILED(hr)) {=0D
+            warn_report("WHPX: Failed to get legacy processor features, "=
=0D
+                        "hr=3D%08lx", hr);=0D
+        } else {=0D
+            processor_features.Bank0 =3D legacy_features;=0D
+        }=0D
+    } else {=0D
+        hr =3D whp_dispatch.WHvGetCapability(=0D
+            WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,=
=0D
+            sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);=0D
+        if (FAILED(hr)) {=0D
+            error_report("WHPX: Failed to get processor features, hr=3D%08=
lx", hr);=0D
+            ret =3D -ENOSPC;=0D
+            goto error;=0D
+        }=0D
     }=0D
 =0D
     whpx_rdtsc_cap =3D processor_features.Bank0.RdtscpSupport;=0D
@@ -3246,15 +3268,22 @@ int whpx_accel_init(AccelState *as, MachineState *m=
s)=0D
         }=0D
     }=0D
 =0D
-    hr =3D whp_dispatch.WHvSetPartitionProperty(=0D
-            whpx->partition,=0D
-            WHvPartitionPropertyCodeProcessorFeaturesBanks,=0D
-            &processor_features,=0D
-            sizeof(WHV_PROCESSOR_FEATURES_BANKS));=0D
-    if (FAILED(hr)) {=0D
-        error_report("WHPX: Failed to set processor features, hr=3D%08lx",=
 hr);=0D
-        ret =3D -EINVAL;=0D
-        goto error;=0D
+    /*=0D
+     * The matching partition property is also Windows Server 2022 and lat=
er.=0D
+     * Legacy hosts simply keep the features the hypervisor gave them, whi=
ch=0D
+     * is how WHPX behaved before the banked feature set was introduced.=0D
+     */=0D
+    if (!whpx_is_legacy_os()) {=0D
+        hr =3D whp_dispatch.WHvSetPartitionProperty(=0D
+                whpx->partition,=0D
+                WHvPartitionPropertyCodeProcessorFeaturesBanks,=0D
+                &processor_features,=0D
+                sizeof(WHV_PROCESSOR_FEATURES_BANKS));=0D
+        if (FAILED(hr)) {=0D
+            error_report("WHPX: Failed to set processor features, hr=3D%08=
lx", hr);=0D
+            ret =3D -EINVAL;=0D
+            goto error;=0D
+        }=0D
     }=0D
 =0D
 =0D
-- =0D
2.50.1.windows.1=0D

