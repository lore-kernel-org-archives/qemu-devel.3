Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DB8C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEf-0001Ns-Kb; Thu, 03 Sep 2026 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEZ-0001Jw-FN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEW-00048M-Oz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so1909395ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464182; x=1789068982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZnODmfi9jlHeHZOeJx2IurnBfxwM7mGEa2KAs0ZmXME=;
 b=HzvFmfN/BHxkDgOsnE/Xl5iQZYcQDTxu15Hq6pnLgR6anZZEgN9313BDAY2WyZ3sLr
 B6H4OLhtah0KsCWXw0vXSaSD4X/D+FzI+61dhj1DvRiBViSx1f6604Nxjkd7VmxdcJAM
 uvvMk9uCyVutFLkSOKYGpQ21VtGVFdgI717zcjyTvU7xWzNgeNc8PhBQS9pCT/xPY3oW
 ec+dioL9YOjZLXHpEqyQA3tAcP95b0KJuJCFSRVbntaqC3FEx+n0HH4ouL9UmE50v/8T
 SVdhBoG/8skB3B4bB5FxPQ4eQytWdk7ZNNt9zRFvIeARfM+xWZTQ10a9+EX6/nx7WAlh
 LSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464182; x=1789068982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZnODmfi9jlHeHZOeJx2IurnBfxwM7mGEa2KAs0ZmXME=;
 b=oTu92KIKYafPF8L7vUvDGEcd0+EYpIAyzlArwcXUFDmNXEN38oT2Bu5Mvha0D91NtW
 HRG0n9vbvE/A52o6jBTIirfy8y+Th0MyxIcUcnYepAP99iWNTx56bt3hKUSu+8T+WPYE
 Patntdh+h4kvR1+3hMmvGV3muKnpSpV5jVkM7NjMakVWkEqQ+vFGOTfxIaViVKvUtFSM
 ROAiSOQTG1/a6Ou85kZ+syqPATcTb8xF+7nvmG3ck6Ugwzw2zw5r2e9eoXgRKxweDnOR
 LRWAfPO4L5vtz9Vi5/qgH21AeDPV0e0ayFPHhLy6mvGe64/cyl9G5lUkZEIRY6hSYMrh
 fAdA==
X-Gm-Message-State: AFuF++myszPf7/i20C2Fv3be+uedCjJyUMRBkuUh4Ba7d+WmcYaMMHcQ
 oZUSuyZoZ1wydOxY1dqXY+5Ql4jRCMIuhhPp1380D8xRcfXY1pb5W0AN0of714WiWC8=
X-Gm-Gg: AYBFou2kaVW8xCEZ8YNpDsfOlioWHuCW9LPpExcWmZ/htkrjVwM9hEoKoNUeJRCfq4z
 5oVek3QF8ijxy9OhpsYCeFSyWMDtrvq6bhaub4p7C1ui8eylY5gKrxD6I4ocznbWiCHeRgCj+4q
 8WZRokrnZQnny3vTFjdXNScdbEcgckQuKEa1gNPBxh3kYJuyzYmwow6Qoog/XcfGu/3wsGme8/T
 h1FaqytdkiK2lnrg/vTkxSxbQGXmS4VhY7tEfC5iLCDpBB9vtNoQlwmryK2NxBcLywR7LqbI0yr
 7oGdXNvSIQYWc0N3Qvv1k+x3vb875OtZ+uuSNoyN/uWatKa6DypQjZwGO3NET05vdZ+mh8ptWNl
 ItwT8jPAKFfSlMt3XiE2eCeuLMgKv6nH3JeIPsHNoZ0NmvLJmGHH+Urzd+CPjbtZAE6d0hfEsXZ
 1yHYjnLtAgOTjyksVfswVKKCjQQKOSapnotIKgKIyUzbF1ExHzkhOTccmE/9Z6MDobGRMynLb7b
 1at77qY08el0cg=
X-Received: by 2002:a17:90b:2542:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-39b26101402mr1172680a91.5.1788464182044; 
 Thu, 03 Sep 2026 12:36:22 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:21 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 05/24] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Thu,  3 Sep 2026 13:35:52 -0600
Message-ID: <20260903193611.1058589-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x629.google.com
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

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 401a6f669cbb..33c3763aebfa 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2169,7 +2169,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2272,6 +2272,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2354,7 +2367,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2457,6 +2470,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.43.0


