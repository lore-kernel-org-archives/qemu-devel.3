Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1945DD3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0J-0006C7-FR; Tue, 29 Oct 2024 11:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o07-0005l7-A0
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o02-0000QH-C5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyYC6UOZKU94Wwrtdw6/pO2lxILLRipgiNrFy5tbKJc=;
 b=G8brQK35haXtwiTQP0Z7/i+EgZuyyTyZothYVibloH8cw5BibcvciSTbZXvHMNUMPQMUr2
 DVNIyBWOlD6j4UnsVkP48TO8x7jD9J0/mwaoqVuwr6SnlT7McnhK7N3wEqi6CvliqYswfV
 mWu0ymLRJvDUAi0wPnkX8Ln785YA+yk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-I-oK3qVbMfWbbVFm0155jw-1; Tue, 29 Oct 2024 11:19:10 -0400
X-MC-Unique: I-oK3qVbMfWbbVFm0155jw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so2909481f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215149; x=1730819949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zyYC6UOZKU94Wwrtdw6/pO2lxILLRipgiNrFy5tbKJc=;
 b=O6yUl76vKQjx0iy5d6g4sDyl/zH2K8YLvmfQFSAiBo5jEuYMEA1eBRZNl0Z1npYBJ8
 XpafE/Mit4ugB4G7zc/0DaeHiAp8dhWFSusQ+KUh+BHAMKdR+d0UeC9kJ5SZBFRCHEV8
 4euOPgbM09GOhSEfBiZHtPGsCa095VmMEVxQnPD+2CVjxv4dq73Gz0u1aWaWMcYoCsRr
 35PuJ+MgMUSMk+0G1z1eBpCe2Ws0qLQ+Kao5uDztRZPayBheyH8kaJiZygkgy/NPCSVX
 m+c6ZXgBmKQ28T+1J4VgJ2h8JzNnRzVOmcLctRI36xymnhPGnZ9+kJnyhvZ7bLR5pr/V
 GuVQ==
X-Gm-Message-State: AOJu0YwJFelmqMNuvnrdGHI3Or0trmqrTHnqYhU8x8GZ+1OwbeQwD94Q
 RmadiqgElcDNAZGwJt+WqSX6r/607/x43j8x/kBe00rnpqfGPfE9u0oqvotzMuduJBrNVIRe11T
 A3xsWQ1r+w/l+YE6iZifvlykI3gdKJ7OHosOD5yUu2Tv7xtT3ISNF1kH34bZqnI6ZFjIFGOpcWa
 2o/5SWR3gCYqp3ugEpQUnQ1HcKPG8d4HfZlbJGzlk=
X-Received: by 2002:adf:ec89:0:b0:37d:3541:5643 with SMTP id
 ffacd0b85a97d-380612220ddmr8379152f8f.51.1730215148886; 
 Tue, 29 Oct 2024 08:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx2e7lV0kDVzVNOfkYZy74/XL+KH81n3/UeY0OMvCkCbttgiyJCL/PAWeqnxBDlQ5N/qwN/Q==
X-Received: by 2002:adf:ec89:0:b0:37d:3541:5643 with SMTP id
 ffacd0b85a97d-380612220ddmr8379138f8f.51.1730215148431; 
 Tue, 29 Oct 2024 08:19:08 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b4000dsm12970876f8f.45.2024.10.29.08.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:19:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com,
	zhao1.liu@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 3/8] target/i386: return bool from x86_cpu_filter_features
Date: Tue, 29 Oct 2024 16:18:53 +0100
Message-ID: <20241029151858.550269-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 target/i386/cpu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ee4d988caf..c2f6045ec1c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5840,7 +5840,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
     }
 }
 
-static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
+static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -7558,7 +7558,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
  *
  * Returns: 0 if all flags are supported by the host, non-zero otherwise.
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


