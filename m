Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7974BC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEg-0001Ow-Dm; Thu, 03 Sep 2026 15:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEb-0001M9-3A
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:29 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEZ-00049q-IN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:28 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so161132a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464186; x=1789068986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
 b=yBJ4agoBTQbQd7Vkz9bYjxon/c8C/XuTCwT79SjstETTHZio7gy1XgAhovehD6n2GR
 xhfXgNXG7q1Ms3N6ZVf72OfZ/djDmss0ga1S+/Fn+YfxULpQTNTdIZUKfWbXLpOv/lE5
 QGpoAIms1rL/7xqHuam794QJtGVxi7RVUmeF5W+3+6hcff8s6v6OncVbVBzUSt9dfpSo
 fxqPE2helov33XfdNDe6LQZ5M0LGy4m637AXA+iMEHbCPp1LNKWTfXsShsZp494PN0Xf
 7it9IarrF/aFZ8BbbvhPaI1yF7mpxXLc/gGpetkDc+WWb1cSuGFAa+nBOyW5tU+J3Zwq
 glmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464186; x=1789068986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BW+koEYMGeh3Q0Il0QE3jfPQEhQaRsizJA+FKY6y1jw=;
 b=GX5qUO5JQ9TEYSC6K29bvjLOmkfk5NoSn+AS7xwyUpsp9pqrQPdXOBCbbRPgXzK5vF
 D8dcG5p+7r6KSb/X2gpuZuvOtvRitoKkfpX2EfGh/DDhVi0W0Ka2o3M3JEdEMw9EcUk2
 awclBHk2oJTWobAK1rGZh077MYFOHECjT74vVJxdGsre8D813Kzb1uM3ggAVJD7EW+Qu
 6+lIRCjTRNUVzsKZqbgh6eB3jw3a38iQkA2R3WCx+QoPfyhIDJ0gJm5x/o8AvT+xKhxl
 97O9U2fo/mDTyd3mNMMDTEkU0mFlGarqW8Fj+i1RhseoHvLD2416iC576OaWgpQX/WaV
 VOgw==
X-Gm-Message-State: AFuF++mitZ97QhT5cl+G0vACTTXzeH/+hAnYcoCg7WrjRMXMnw5W2EwH
 vLEE2XxAfNVLkkuiGFFk4RxVwl/22cs4SWlpzpjtv7CXejZAnJH5s4FHYaGucw45GTk=
X-Gm-Gg: AYBFou2qrN6JsYRTSSx1bc/xIyQ0vhtsfj3IqJXgohy/eaolr7nEw+kwBpzDHIw3oID
 pPWfd2/RkOnKeZ39HoZOWYws+nXcq+xi60xGX8UTJ/GJ2NE6cURvRjW3MfYMSOvSETP9bAdHP36
 XRQnqn/sOn2Ss9eloqrj/JnC08sKVAZE+aqEDNtAJNwp6C5Qzd0e9vw9Gyu0aTLiHGAxKl811Xb
 dOIPkCFFbYyMD2XEE9zEl0hoR6ujaXcarLIoVVY1ZYylIGXJHzpW1gpy+q11aX1tPoEmjiEuNCA
 886rBOjs+4rVUVWDubBjoZzQDhohHMWW/FaMLH5J9GxkLY9ce2CPXgo5Mp1x9zUcfpOeDV0kyS/
 DIdV10L9HpCCEj3ecketwu9lIdzEe7pZaI+n/eg8/AjsQ489JlI+W1Ws+CWZ3ONGFNP8Y2S7kYr
 NZCRdkFomR/BweC2RSHRRTIDJn0rPJYSUir5LTG2KJMbPhMI6XAbk9gLUBZnpUUmBFpw1ro2H/W
 Hrdhe1EbNVnVmU=
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39b26204e5bmr851072a91.13.1788464185768; 
 Thu, 03 Sep 2026 12:36:25 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:25 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when requested
Date: Thu,  3 Sep 2026 13:35:54 -0600
Message-ID: <20260903193611.1058589-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102a.google.com
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

When a Realm is requested, create a scratch Realm VM by setting bit 8
of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
for the guest PA size.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c6da1fb9f3..d86e66e056b9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
                                       struct kvm_vcpu_init *init)
 {
     int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
+    MachineState *ms = MACHINE(qdev_get_machine());
     int max_vm_pa_size;
+    int vm_type;
 
     kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
     if (kvmfd < 0) {
@@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
     if (max_vm_pa_size < 0) {
         max_vm_pa_size = 0;
     }
+
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
     do {
-        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
+        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
     } while (vmfd == -1 && errno == EINTR);
     if (vmfd < 0) {
         goto err;
-- 
2.43.0


