Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C59AD767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZOF-0006qz-Ib; Thu, 31 Oct 2024 13:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMv-0002kf-JT
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMt-0007To-T1
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLDRCgzV/hbpnEy1hMupWwfJh0+fV1vkcGE/wzAoXCg=;
 b=Hno9BTB+ebv0qnJvmCvID+XxW77pEXI0wdZeY14TOqFgEnDSb+YIj8gMuxsNS84d1loSpH
 HiTXWEQpmtdfzWxXjQnMOj0sT+zBwEI9agYQgrM2c7vdvz/KkmOAqRRte3jpWyxw7npWVa
 h5mSIXar9zTFwDC/zvjBucid4i4c9Wc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-2lwygWP3MJK5s-FqHjIYNA-1; Thu, 31 Oct 2024 13:53:57 -0400
X-MC-Unique: 2lwygWP3MJK5s-FqHjIYNA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so8795595e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397235; x=1731002035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLDRCgzV/hbpnEy1hMupWwfJh0+fV1vkcGE/wzAoXCg=;
 b=H8nrfCturdyIlyRnTU42eEP1OKl6+860kbgsWXj4gxDLTjiezExwrSKVzJxEteEq1G
 LhjK9HyhF2pHjkLUicWkKbL8rWOVliTu2Tv8BadsjQ8ETT0DzFzVyS8gHlr3m1f26UL5
 mUpmmX8LxJXBLCblTQQ/J3nurwpoR1mw/Aj1PEJVymFpQ5TV3gfRz6hH9gY7IlnLGkmz
 Jz2wOMbMLjPMhhR35HQWCtiCbcNCX/ZUlzHUEpbu83tuYQ3G1N5/690QksW55e9U3uNQ
 QqNzjBMqrxOONCqt1DFbOu9oh0Nqxrm353z/+WNZZjP1OorAym3Op7xRGR6zyZfD5lEf
 cRmg==
X-Gm-Message-State: AOJu0YwuOiyNekqirgvITmImKsm+tb3hBWUYADKmoREIYNzEG9hPyRfg
 gAJsVgB52guPLAiTdkioDVOMRyN5YxdoHwa9we2TFaKiIm1QXhkjHU2TAJWKT3zo6IIhx/LMC5Z
 WjnX0Tany4bd8QVPAbzyfxkwwuGK3ifYOLPxEkF9g3p2D+A7n0iVm3teWIh0htlvAMDG0OjsKe4
 rrDowTThVS/fVDVQXy60RwdjOMNjDgFB5JWVP3PgM=
X-Received: by 2002:a05:600c:45cb:b0:431:52da:9d67 with SMTP id
 5b1f17b1804b1-4327b6f992cmr38436145e9.3.1730397235043; 
 Thu, 31 Oct 2024 10:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDVdqpMG2j6M88pIf8Rgy5Gdahq/K6DPG0Rnzpm/GmT1h77QjegBgKCXiYP7JeWBnipX400g==
X-Received: by 2002:a05:600c:45cb:b0:431:52da:9d67 with SMTP id
 5b1f17b1804b1-4327b6f992cmr38435905e9.3.1730397234561; 
 Thu, 31 Oct 2024 10:53:54 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9207d4sm63137455e9.20.2024.10.31.10.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Tao Su <tao1.su@linux.intel.com>
Subject: [PULL 44/49] target/i386: return bool from x86_cpu_filter_features
Date: Thu, 31 Oct 2024 18:52:08 +0100
Message-ID: <20241031175214.214455-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare for filtering non-boolean features such as AVX10 version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241031085233.425388-4-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ee4d988caf..92fefdaa423 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5840,7 +5840,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
     }
 }
 
-static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
+static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -7556,9 +7556,9 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
  * Finishes initialization of CPUID data, filters CPU feature
  * words based on host availability of each feature.
  *
- * Returns: 0 if all flags are supported by the host, non-zero otherwise.
+ * Returns: true if any flag is not supported by the host, false otherwise.
  */
-static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
+static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
@@ -7610,6 +7610,8 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
             mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
+
+    return x86_cpu_have_filtered_features(cpu);
 }
 
 static void x86_cpu_hyperv_realize(X86CPU *cpu)
@@ -7707,14 +7709,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
-
-    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
-        error_setg(&local_err,
-                   accel_uses_host_cpuid() ?
+    if (x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid)) {
+        if (cpu->enforce_cpuid) {
+            error_setg(&local_err,
+                       accel_uses_host_cpuid() ?
                        "Host doesn't support requested features" :
                        "TCG doesn't support requested features");
-        goto out;
+            goto out;
+        }
     }
 
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-- 
2.47.0


