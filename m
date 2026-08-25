Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FF9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzD1-0003XJ-6A; Tue, 25 Aug 2026 18:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCi-000326-5g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:12 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzCg-0001Bu-C7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:11 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3964dfb5a69so506266a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695269; x=1788300069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gzyHU9mpmLRwtQLq0gW2o+D00lhdgYVo2at04MRhk8M=;
 b=XmdwzWU3u7lx+qe2YQG1ucAesrZakFB1ua2ssTnaCBtn93KF8kZeFlLMy34Zq3s6lj
 noNjvrm5mM3sxw8ppLgPXtxMGV3dlylYtIQf1cbUZKOuG7dUgp6m9rs5AXgxFFTTadMc
 4LH9eW3bDNbMRB7HJedehfzpUWnUeyzm+f8E7TQL713nNuubMDh8TW3KoZLq0HcroigA
 ne6xvaZRFKtDvc8fr3qYyMytGrxxrr0RGOlSaf7u6gneg6gSsS8WatMmN2kmsghCAOH6
 KqH+BNDFixzEgencv8kpWj8dIFWh2T8jXrVMJkK7hG7ApCXJ2u8rlzMjvsmG6fubddhx
 Qx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695269; x=1788300069;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gzyHU9mpmLRwtQLq0gW2o+D00lhdgYVo2at04MRhk8M=;
 b=Eh2FasNP1/TsyYgV+QTtSfZG93X0uvUoVcxhxKucGNP7xauXny00EFNvdB+R5THshJ
 m+6Rl6f8Sd5n2P6Wkh+cU9DjJQq8llSMt6N/lAx+fI7aJhPMhEtsS2cERV1P/YsicnEg
 P+6vV9pVJINuxf8+dYOsgmWbsUy4IBiKtm2if7KN6lH5uAi4FNyCEkkeSw0JiH5K7q57
 NZvfP4qKnRXpyK+72gbzLgCIQFGEoN1TVg9lHcv4dk5oTN5y3mCFXRscBuFTT4AfCkFY
 rxKlaYIF5NaJT5TXf4IEH9ue9hGgWkFCYoS2um0LIcPyg5meSpuuZF0NTv73A+Uu8WgI
 zUaQ==
X-Gm-Message-State: AFuF++kZ9uWaWW1b/k28FM5fCl4MSTyY9iX7hOiJm6EDVOn+5mi2SHKv
 li0gRRLriQ/BZcJJHVyublQ6noo8DZCbS8GyX1uOeKkKjeFjJYWZkH5eSzOGv3895TE=
X-Gm-Gg: AR+sD11QWJ3ulSvYpJs7pFm5C5RxfQJYVf3T5itsr4g7XpAInFqb3HN8qDjqAomS+ty
 xWmZOhhAzk9iL0cAkAbkeXSG5vgxDCpAwfhXpjPi3LBiV8rZsXXT1r2aD4TTogNDALw6J720mJK
 y3WeW6IcdHEPsafaSsAIwV/GPpluXu2g3EC2a4q0TbcTlmbbal3WfxsAIX6FPdWdRR/R8XazHyh
 Ui07dX9GQBK26alzbJjIyJ3+1YVJMe00oJoNS3wrrzjp76hf32MPmkgQqGlOlVGdfC92i3mKy9m
 BVWGY71PYzsAdVVAaJUobxMZK0b5l9GD+xv0kxOrEAj8ROffaj0p7NSKImAojDwcqBHemLsKc4g
 enBAzlRGWEGGy8j8U/HxUmoR1Nsz7opXugopIAwXwuhQo+xm7Ch8VGq43OBmat26GNHTPY1GQMN
 dixzymyR96nNQpTTybYsqVMndz4GHURrsPpY2dSF9x+GIHlPtNsK9rPhjSmYBgUR3OaVQfQzZe
X-Received: by 2002:a17:90b:3d81:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-3966ce035e2mr5067715a91.0.1787695268545; 
 Tue, 25 Aug 2026 15:01:08 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:07 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 02/24] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Date: Tue, 25 Aug 2026 16:00:39 -0600
Message-ID: <20260825220101.3443954-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Leave the `ret` variable in the function scope because it will be reused
when adding RME support.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 7d194ea112b1..20b39d10b766 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret = 0;
+    int ret;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -640,13 +640,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             warn_report("Eager Page Split support not available");
         } else if (!(s->kvm_eager_split_size & sizes)) {
             error_report("Eager Page Split requested chunk size not valid");
-            ret = -EINVAL;
+            return -EINVAL;
         } else {
             ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
                                     s->kvm_eager_split_size);
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
@@ -659,7 +660,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return ret;
+    return 0;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0


