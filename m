Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62D8E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Rd-0008VT-Ok; Fri, 13 Dec 2024 12:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bm5cZwgKCv01mjsiwnplttlqj.htrvjrz-ij0jqstslsz.twl@flex--whendrik.bounces.google.com>)
 id 1tM9Ra-0008U5-IN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:14 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bm5cZwgKCv01mjsiwnplttlqj.htrvjrz-ij0jqstslsz.twl@flex--whendrik.bounces.google.com>)
 id 1tM9RY-0007s5-Ka
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:14 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-434fe2b605eso11611945e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110831; x=1734715631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYv+pg+UZazKGCKy29BkEC26GYqoLpWfMbrkqDY73z8=;
 b=WgvxMIWp0xLa5CQibV4Jn2aG7ii1ixPxLqPQckV9L1HrRcjo2lopGPd02VHGeOdW8m
 fv0+4zl0y3j1FznCQNV4CfeOlFbhoYma4oyhRMtyFT6eT+Nbfj6m87t0a/RUEfEgFZMQ
 eqDN4sy0NpjALwQ9bEer01xblo/g3++cZapeczz1AIOJUfKNvs9IPnubhVvv+o6bUryp
 U6aBQ7y6/bdyK1EbJpb15H1HqCDCREik64Fw25OepCAjXg95Q2N3yiqYj7iHSb36VQB/
 ZooGLGolRkVOh0Ne5rjh+4gWTVC6rJNTdmA5fKO+kNxJSGNxJKGFnLuqqwykAu4ZBstX
 yaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110831; x=1734715631;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZYv+pg+UZazKGCKy29BkEC26GYqoLpWfMbrkqDY73z8=;
 b=MYr/hnDaRou4TNsZzyQ0Ubix3E37wmi1pmlcXQgKGERkGowEA0ouPZFKQpr88PZ6DA
 DdXXSew0iUiM4e4O6vSVfn+LU3YCvYRLKkRZPIZ7njSLMAMtImQWYLeG1kphwCWTRWq8
 N1HIYgUJt1YNaO0WUG5HDxqJ/D1QxMSEXFG9Kx+nT9iNONdyXqSg1RRtESQWW1oVgo4u
 dybORSqbw9l6KewUp6ijVfidIfdXXdW7yTsjBN/97Vl2ASh0F/S2WMJhKcRwkJ4+nLRU
 gd/pHTmv9doohDGFQGF3V+QmhtLaHWDEr92USXIK4kXF97QZU8xb6CwFpNZBN/HLp8bx
 CBrg==
X-Gm-Message-State: AOJu0YzOuRfWFQEYwwZ6VNyObHCR6UoHofEVcKr6IYrwgy09k1ojljT0
 DYO2UvUNBQ/dewXRX0PV98lRUoj5/w9v1yrNNTQURSbjrqrgknfQCJybOujty5A0OpxBRZTi+gj
 QR38GGWmxMFeHeDZBOMApFuRYOh2yDB3CfdSm2MGwFy21KbqQlve/6iFdxQkzwsclJZEjRu8S47
 yIm6813mW1gn6pBYrEaCCVvw91WxItsjHkRFxQCG17dg==
X-Google-Smtp-Source: AGHT+IFy5d157S59NX6/IVic3hAaUU1ydX7QiydKmzSAfk5UGHdRLcDdjm3M8VRzNTQoXC72FxRr0dUevUNaEA==
X-Received: from wmbdx22.prod.google.com ([2002:a05:600c:63d6:b0:436:3ea:c491])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:cc9:b0:434:f739:7ce3 with SMTP id
 5b1f17b1804b1-4362aa2881bmr28110425e9.8.1734110830711; 
 Fri, 13 Dec 2024 09:27:10 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:45 +0000
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-9-whendrik@google.com>
Subject: [PATCH v5 8/8] i386/cpu: Adjust level for RDT on full_cpuid_auto_level
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3bm5cZwgKCv01mjsiwnplttlqj.htrvjrz-ij0jqstslsz.twl@flex--whendrik.bounces.google.com;
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

Make sure that RDT monitoring and allocation features are included in
in full_cpuid_auto_level.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 target/i386/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f7904870ed..4f1493043e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -880,6 +880,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendo=
r1,
 #else
 #define TCG_7_0_ECX_RDPID 0
 #endif
+
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES | \
@@ -7672,6 +7673,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **err=
p)
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_F_0_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_RDT_10_0_EBX);
=20
         /* Intel Processor Trace requires CPUID[0x14] */
         if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
--=20
2.47.1.613.gc27f4b7a9f-goog


