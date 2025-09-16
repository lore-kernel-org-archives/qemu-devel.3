Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520D3CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5H-0003Y9-Kf; Tue, 16 Sep 2025 14:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4i-00038g-PR
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4c-0001cg-IN
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3d44d734cabso3517680f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045997; x=1758650797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/e4QFB40Kd5xVAD2ukP5PCzshfLjtIczMIicFl3oFOU=;
 b=PICNvghxoyqK9pUzmAdjyIu/YDyUQxbz2mBr7ffjquT1eioEk+ahXnxG1sPqKkVchL
 gLrQiP7k3GUuZwxq6w2P6Ik+JbO37OUjTiqXhg9rW7q8Vw5p9nVsjI+sN1PPFnv11I27
 oJPbsrzgMdVO7mbvmWCndL+GwFbqLkXCTHubTBlNFLN9W6DwXr5w7pqpPuIOuqqfSyaj
 r38HeCrh0DuQHeBDmD90R7ua0GivIp3r2C47F89qNqC1mDZemd1dv1HRVhhx1uq0sgGl
 jx5Nlotn6ec9uCq6cF/hmapYEPKdscRTWAObakZRmGdck+qIIMOKxugEx6/pzAkLheuE
 8ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045997; x=1758650797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/e4QFB40Kd5xVAD2ukP5PCzshfLjtIczMIicFl3oFOU=;
 b=iBcBJK4rfw5X0tb7d+qnuYdycQcDoYh4Osp8RQd/13WhGsR70VYa7GQz/XslSi/vIf
 VLjn8Nv8wX4ysJHCjtwN6w6rmrRX5lAPiL4oAWYG/Waus2M4NW6ps9O+PFhAQX0IMffJ
 lf5DZT/i/e9ig+/Kyiy99bVONKLUI1HSAjJFN/YTLf4fbYyfx59PJImU9+y3BNkbk9bN
 9nBc5hbEcJ/BaVjmm9euyQFLTvvSE/SR5akVfopeDnDkto87ayIH5jIL6o4F0MuYQxcR
 fRd76qInHZQtEWIwmSV1t4lQLlspNqlfVCdN521+b47gbbcYgGsH8x0HY81aDvsFZlxZ
 40Ew==
X-Gm-Message-State: AOJu0YzD+XEXthEji0al0F8kh2wNigoMtXaxRuDRvPtF7WClH/nClO6q
 EFxP6qgIdRy4Hf2wqxro2hhy6JnSkzNh3T5np05NQ4632zdG3+dV3atlvqHuND9WQrp6ewQQKdH
 pvZb0
X-Gm-Gg: ASbGnctiasRT/jJZ5YixwojaA2H7hgqvb/IFKx4a4McWvwLUvUcmOsshdfO58YHEf/K
 yHNumRJNKYq/ZRRX11YpJBVr13dQab3q2yqMQdSPMeXGIxHVePMPdW3FMvrP6QqZRkj+Fko6gs1
 b7ZWvr5paP5+0t8LGtaHfOy2l0SokzFgEPOEeo5+djAhwhqv0RvxCSTfCEC67iBWLxT8TYx+cLO
 c5kBiT5uX3t9/r5TBW31vu0IuCVmCXLxfhNcGeke+TdAPOqrWF9no8H70k5mBSD+0tR6FdeM0AL
 g69YRcpz+Y4WyOj4cWg5X0a7giU5i+7zRtRnZsFmlZz6N9Z5HkUHh8w0W5J/pQFmtSYlPzzGVTX
 5tZGCzRSjqxR0yEs3YQyXu4h91FlC
X-Google-Smtp-Source: AGHT+IHwX706fKouHMa3Qv6J9gvPGyae9Oz61rgIIeyY2z84Apis3lb6BYM+A+PzS3AyuaYdk0dtlA==
X-Received: by 2002:a05:6000:230c:b0:3dc:1473:18bc with SMTP id
 ffacd0b85a97d-3e765530b01mr16650233f8f.0.1758045997000; 
 Tue, 16 Sep 2025 11:06:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/36] arm/kvm: report registers we failed to set
Date: Tue, 16 Sep 2025 19:05:55 +0100
Message-ID: <20250916180611.1481266-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

If we fail migration because of a mismatch of some registers between
source and destination, the error message is not very informative:

qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
qemu-system-aarch64: Failed to put registers after init: Invalid argument

At least try to give the user a hint which registers had a problem,
even if they cannot really do anything about it right now.

Sample output:

Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)

We could be even more helpful once we support writable ID registers,
at which point the user might actually be able to configure something
that is migratable.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250911154159.158046-1-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 66723448554..c1ec6654ca6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -900,6 +900,58 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
     return ok;
 }
 
+/* pretty-print a KVM register */
+#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
+    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
+               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
+
+static gchar *kvm_print_sve_register_name(uint64_t regidx)
+{
+    uint16_t sve_reg = regidx & 0x000000000000ffff;
+
+    if (regidx == KVM_REG_ARM64_SVE_VLS) {
+        return g_strdup_printf("SVE VLS");
+    }
+    /* zreg, preg, ffr */
+    switch (sve_reg & 0xfc00) {
+    case 0:
+        return g_strdup_printf("SVE zreg n:%d slice:%d",
+                               (sve_reg & 0x03e0) >> 5, sve_reg & 0x001f);
+    case 0x04:
+        return g_strdup_printf("SVE preg n:%d slice:%d",
+                               (sve_reg & 0x01e0) >> 5, sve_reg & 0x001f);
+    case 0x06:
+        return g_strdup_printf("SVE ffr slice:%d", sve_reg & 0x001f);
+    default:
+        return g_strdup_printf("SVE ???");
+    }
+}
+
+static gchar *kvm_print_register_name(uint64_t regidx)
+{
+        switch ((regidx & KVM_REG_ARM_COPROC_MASK)) {
+        case KVM_REG_ARM_CORE:
+            return g_strdup_printf("core reg %"PRIx64, regidx);
+        case KVM_REG_ARM_DEMUX:
+            return g_strdup_printf("demuxed reg %"PRIx64, regidx);
+        case KVM_REG_ARM64_SYSREG:
+            return g_strdup_printf("op0:%d op1:%d crn:%d crm:%d op2:%d",
+                                   CP_REG_ARM64_SYSREG_OP(regidx, OP0),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, OP1),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, CRN),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, CRM),
+                                   CP_REG_ARM64_SYSREG_OP(regidx, OP2));
+        case KVM_REG_ARM_FW:
+            return g_strdup_printf("fw reg %d", (int)(regidx & 0xffff));
+        case KVM_REG_ARM64_SVE:
+            return kvm_print_sve_register_name(regidx);
+        case KVM_REG_ARM_FW_FEAT_BMAP:
+            return g_strdup_printf("fw feat reg %d", (int)(regidx & 0xffff));
+        default:
+            return g_strdup_printf("%"PRIx64, regidx);
+        }
+}
+
 bool write_list_to_kvmstate(ARMCPU *cpu, int level)
 {
     CPUState *cs = CPU(cpu);
@@ -927,11 +979,45 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
             g_assert_not_reached();
         }
         if (ret) {
+            gchar *reg_str = kvm_print_register_name(regidx);
+
             /* We might fail for "unknown register" and also for
              * "you tried to set a register which is constant with
              * a different value from what it actually contains".
              */
             ok = false;
+            switch (ret) {
+            case -ENOENT:
+                error_report("Could not set register %s: unknown to KVM",
+                             reg_str);
+                break;
+            case -EINVAL:
+                if ((regidx & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32) {
+                    if (!kvm_get_one_reg(cs, regidx, &v32)) {
+                        error_report("Could not set register %s to %x (is %x)",
+                                     reg_str, (uint32_t)cpu->cpreg_values[i],
+                                     v32);
+                    } else {
+                        error_report("Could not set register %s to %x",
+                                     reg_str, (uint32_t)cpu->cpreg_values[i]);
+                    }
+                } else /* U64 */ {
+                    uint64_t v64;
+
+                    if (!kvm_get_one_reg(cs, regidx, &v64)) {
+                        error_report("Could not set register %s to %"PRIx64" (is %"PRIx64")",
+                                     reg_str, cpu->cpreg_values[i], v64);
+                    } else {
+                        error_report("Could not set register %s to %"PRIx64,
+                                     reg_str, cpu->cpreg_values[i]);
+                    }
+                }
+                break;
+            default:
+                error_report("Could not set register %s: %s",
+                             reg_str, strerror(-ret));
+            }
+            g_free(reg_str);
         }
     }
     return ok;
-- 
2.43.0


