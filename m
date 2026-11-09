Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C58606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VyDu+neb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXuC-0005RK-Nk; Mon, 09 Nov 2026 17:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtc-0005Bi-V1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:27 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXtb-0003pT-2e
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:24 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8a070781f63so603097b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263481; x=1794868281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R6shKTPJO2OMKOtP1Scv42yaR7N4lg4logstoB5OC0Q=;
 b=VyDu+nebvUkeEvJ32eUloUeWTIEOTPGQbH2EyMfNQmSbniB64qjZL0wNwlU3g4u2S/
 0Mm5zG/hmSNhfJh4A9PNzAqtzLIuwzAlOIXqhmSdUT38Ps8Kf3BJgfYcyBslXCmDxT5H
 fa7ceZ9VNj+cVEW+aLn23elNRgMY6iDN4Al7As8qroBHRpGND7+OLxcIWY0EnwHtmEw2
 KMGnPO873bsfsHr5/dXcycReATxU9InIyRNMcbO6BMgM04EJ6ZxD+kyY4xDN75GJSjJ5
 5LwfFUbDkfdqXgvJ8SyYGTgVBZ73td+kLk1KCum7t7DD4KYZUjrAdcisgQMrJrFxs0nr
 Hunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263481; x=1794868281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R6shKTPJO2OMKOtP1Scv42yaR7N4lg4logstoB5OC0Q=;
 b=bPiwetKDtDlGckDNfv01nydASbPwdzQwl6ESz1NlBe0agAmpaMJep2FsmrIjdOn9ZW
 2z8Xy+e+AY1tL4ct2mZ2OLmiGIpIupOgoDxnvt58OyfKrGTVTtFzsXaA2NhFSk3kgfCY
 Wr7QoHzjvCtbL3SpfZij31nN/su9DaYKj2jFcK+Et4aubZT5AnXBrH2q0z/c+udmJD8w
 zPe6SqjI7DFXIre61vAlGpoDPPKnIAqcz5Hh3vaND30peZOkn5p2uW9q9XOIxTn+URKe
 kNpp+mzzQA5Oji1e6QTqF+vhjB3gU0HAtSI282dQjscGaS6G5TBOHMbhWMQbzeiFpWVG
 uWxA==
X-Gm-Message-State: APuU4Z+PUx1kyejRqPULuBhQMVH48aypVHJCMu1/DkPPhc5yjrfyzCIH
 Vie5v6hPQAXolPMP1i0yX/JfaZg17twkQ62I0qQEjhgEB47SaaQmlsjblp5pkhTfOTY=
X-Gm-Gg: AYBFou0ppHS/AIszUBKbg8TThPbo9UYFFHW7OZDC1CESzoFjPVRGO0n8kxtldQKCUPt
 T2WydklTmj48WVtaow4ALllPaB1xnQCs25Ed1vtch+rJ/UA/OSeGmFuO/UcORQd/Jgm9s5c9+EO
 tB1YVay7DFGgR7zm/pGzavWiGc5WW0bFE79Vh5yVL+7GX7KvojPoPyoT1EsaAyiei5CcT7UPDaM
 j4k5Z3US5bL6Qlmi7cWLs13OW7TNwwfhFF9e7fH8nv6WhpmASfPfICFEW1N4E4d1VqtiweqMeIi
 ONTIZaHSv4mQLgUq0SQnluwNVVNGddxRSX4yDHseNcNmWwD3aZcMGqvoGHVQvuxObfFz6jJqr/9
 yy6cocbzqzksNe2Av8+J7BEbE8ubFs7Z31el0RuX/a5pkWNPjV/nJuI25I231Pv4d4GMkXb63W2
 zWnKFLPxVvTaV3Or45EhnjHN3BN3JCw1RCxa1b2WYeDseSMwvkeDLv7Pm1tE0ljdtm8x+4vIeFr
 b9Hyl5/74bWixlJtq8U9lGBp36twXeYvw0BFQVn7B2laOLCh8AnmaeyGa4jqqVDSnFhRRglgAs9
 470NqRzo0reFenJiPlXSzJxn8m6xmz8QjRjcpLZJb1fu8I+d79IhSQ==
X-Received: by 2002:a05:6a21:62c4:b0:3e2:86b6:9bf4 with SMTP id
 adf61e73a8af0-3f18ebb3200mr480367637.14.1794263481319; 
 Mon, 09 Nov 2026 14:31:21 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:20 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 04/23] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Mon,  9 Nov 2026 16:30:51 -0600
Message-ID: <20261109223110.1619504-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x435.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 04dd85ee2776..5f40b665cb7d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2257,7 +2257,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2360,6 +2360,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
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
@@ -2442,7 +2455,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2545,6 +2558,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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
2.53.0


