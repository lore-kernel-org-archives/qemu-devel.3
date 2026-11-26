Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B3606A32C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QP7aqOHH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dHWtemTo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWii0-0008Ca-Ba; Thu, 26 Nov 2026 18:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihx-0008As-K9
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihv-00064S-RD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795735011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pemxv6+p2jbO1Ze6odVJgmKdnHXIU402L1Ae0wQ+2iw=;
 b=QP7aqOHHkLUnxeU0bGfnLRbntNbL1SVZuK//n61XzEa+Z2Kmbl6pRbCw+3aZn56TLTO6xx
 HPoiFy+CEb1ShFLRy9VtgEXd6OQylO9VhiKyM0h5G05FVZw7KhhVPgb7FaeXpNk9adYJnl
 youqVfI/Ay9eOOvafZoQUcCtG3pRWO4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-vM2iziIlPCmTZtxjqaNYQw-1; Thu, 26 Nov 2026 23:16:49 +0000
X-MC-Unique: vM2iziIlPCmTZtxjqaNYQw-1
X-Mimecast-MFC-AGG-ID: vM2iziIlPCmTZtxjqaNYQw_1795735009
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so107504776d6.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795735009; x=1796339809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pemxv6+p2jbO1Ze6odVJgmKdnHXIU402L1Ae0wQ+2iw=;
 b=dHWtemTohXmeKdN7r9pKVZczDbUaaQKqvxlh+c70F+2i8RLsfNqM4uFUt0R/SOErzR
 UfGhd3+HZtYXhuZxPWMjb+wf6TYU8wwgEyTlTsp4mrouf/IFXxHrH2+ISw4l3HR/0cG+
 N35JOHu9H3skILkjt3T4+GKssRSuuY7gII3KyEYMufj41sR6b8QPf9+xAEgDNEgdbh89
 8iQkC7162pIXLSgQTeILPyDFE4tZeJNC6G7pbAnmchYn2wjGHJ2eIfxjqyCCy1mJkzzH
 wdGCP4yOOu236FUyNvb2sjOKkKnDdtYoUqiOQwwOV2tBbLOfpx6QhWp/2GOWDezIaJbv
 H5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735009; x=1796339809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pemxv6+p2jbO1Ze6odVJgmKdnHXIU402L1Ae0wQ+2iw=;
 b=xLOiaHw6z9Gr0b5L19za9WUB5J5l7VnFOJvqLboEpuaTv+UjYuQ0uqGuNk41RL9AiF
 tNbQEQNZfnMqDMK1bHpjt09D6tY9qYqRu+d4BkLJ7fhnN+yosBOfCAidqC2TEbwge6WM
 TzrXcqgmHwyWwY8Q0bG6sbttVUU2AYSX/ddnJQx99Cw36HOzOa5vSvXUePqUDkD2dpJB
 K+8RGfnmOodIQ5MTgZfqfaA4JOK9pYvSw3r+GryMihZ+Z2Zgq7VuvDVSZ3v7GWptcWLz
 vUhE8sJHmPW7md4GOn19Ti/ctAzuWzuWbK9fBdy2WIuz1YPE1kES1QIlgqyLgFiSoU/H
 92AA==
X-Gm-Message-State: APuU4Z/ic7AauuKFmGO/pMke9xYMs1leRjGULJTeIkEZ0xXfjbxQIYqq
 C/Kv51qfIgd0UrO7dY9RMGTOfkorp0LSDMQ6Gpwor1kuyqnr6512T6JvNQcFZfnUU+Wv/4wg4aN
 Xw5qZoIhKnmhAUp6cj5wO5D7kIivNfNxlr6eRIYLgSCa96up3mTuvcaIjZl+M/QziBtHDFp9+cI
 vt38MRXdmvhwaohKn3HY5nlMUN9X40O9lgbpJF5A==
X-Gm-Gg: AZFdTZcSqzO4cheLZ5iNVfGiJJ3tVxYvw1x/qni6ttW6j9IbhlsqVLLzb7LrG7Oeis/
 tASke4ZT1cOQT8NaR5cfQU65+B3iqvzD4knHg/MGUOWG88KZFdYPfPKHYD2TIMyPfGIgmQCfZ1V
 3VV87fthkpXkkZHAeeip5WKHAb+h8wOdGMgGLx2sgizloGjltJOJ18Iot20ferZG0bu7zOoLfgf
 BLJVrB1ZIc1Rqr0I+VttJ9BCro1Ef+7/tTseMRIWc+eOxj41ilZuw8f9oMQoF8BCjOS7Yv3iJNg
 irhxkLAyeZ1HOenMYriTbUkyU3kxNCS5J39WK+jKdcPUmdXBGNXFcAGVuc5aNnx4ZJmB10QHZVT
 xapGn0DxuVCblsW5DeI/eQRIsxyW5C5zzjbdW/QmklLQW
X-Received: by 2002:a05:620a:2417:10b0:949:7bf4:3b47 with SMTP id
 af79cd13be357-949bbb8d5b2mr3048262385a.27.1795735008606; 
 Thu, 26 Nov 2026 15:16:48 -0800 (PST)
X-Received: by 2002:a05:620a:2417:10b0:949:7bf4:3b47 with SMTP id
 af79cd13be357-949bbb8d5b2mr3048257685a.27.1795735007991; 
 Thu, 26 Nov 2026 15:16:47 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3c2abesm1675207385a.26.2026.11.26.15.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH for-12.0 v2 8/9] arm/machine: Move all VMSTATE_VALIDATE()
 usages into post_load
Date: Thu, 26 Nov 2026 18:16:30 -0500
Message-ID: <20261126231631.3392756-9-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126231631.3392756-1-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To pave way removing VMSTATE_VALIDATE(), move all four such uses into a
post_load hook instead.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 target/arm/machine.c | 90 ++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 53 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index e86fa85a9b..b401593496 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -407,14 +407,6 @@ static const VMStateDescription vmstate_m_faultmask_primask = {
  * just non-secure, we transfer both banks here rather than putting
  * the secure banked version in the m-security subsection.
  */
-static bool csselr_vmstate_validate(void *opaque, int version_id)
-{
-    ARMCPU *cpu = opaque;
-
-    return cpu->env.v7m.csselr[M_REG_NS] <= R_V7M_CSSELR_INDEX_MASK
-        && cpu->env.v7m.csselr[M_REG_S] <= R_V7M_CSSELR_INDEX_MASK;
-}
-
 static bool m_csselr_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -429,7 +421,6 @@ static const VMStateDescription vmstate_m_csselr = {
     .needed = m_csselr_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.v7m.csselr, ARMCPU, M_REG_NUM_BANKS),
-        VMSTATE_VALIDATE("CSSELR is valid", csselr_vmstate_validate),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -590,18 +581,6 @@ static bool pmsav7_needed(void *opaque)
            !arm_feature(env, ARM_FEATURE_V8);
 }
 
-static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
-{
-    ARMCPU *cpu = opaque;
-
-    /*
-     * Check MPU_RNR in-bounds. If no MPU, we still migrate this field
-     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
-     */
-    return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
-        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_NS] == 0);
-}
-
 static const VMStateDescription vmstate_pmsav7 = {
     .name = "cpu/pmsav7",
     .version_id = 1,
@@ -614,7 +593,6 @@ static const VMStateDescription vmstate_pmsav7 = {
                               vmstate_info_uint32, uint32_t),
         VMSTATE_VARRAY_UINT32(env.pmsav7.dracr, ARMCPU, pmsav7_dregion, 0,
                               vmstate_info_uint32, uint32_t),
-        VMSTATE_VALIDATE("rgnr is valid", pmsav7_rgnr_vmstate_validate),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -695,31 +673,6 @@ static const VMStateDescription vmstate_pmsav8 = {
     }
 };
 
-static bool s_rnr_vmstate_validate(void *opaque, int version_id)
-{
-    ARMCPU *cpu = opaque;
-
-    /*
-     * Check MPU_RNR in-bounds. If no MPU, we still migrate this field
-     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
-     */
-    return cpu->env.pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
-        (cpu->pmsav7_dregion == 0 && cpu->env.pmsav7.rnr[M_REG_S] == 0);
-}
-
-static bool sau_rnr_vmstate_validate(void *opaque, int version_id)
-{
-    ARMCPU *cpu = opaque;
-
-    /*
-     * Check SAU_RNR in-bounds. If no SAU regions are implemented,
-     * we still migrate this field, but number of regions == 0 and
-     * SAU_RNR is RAZ/WI so also 0
-     */
-    return cpu->env.sau.rnr < cpu->sau_sregion ||
-        (cpu->sau_sregion == 0 && cpu->env.sau.rnr == 0);
-}
-
 static bool m_security_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -749,7 +702,6 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_VARRAY_UINT32(env.pmsav8.rlar[M_REG_S], ARMCPU, pmsav7_dregion,
                               0, vmstate_info_uint32, uint32_t),
         VMSTATE_UINT32(env.pmsav7.rnr[M_REG_S], ARMCPU),
-        VMSTATE_VALIDATE("secure MPU_RNR is valid", s_rnr_vmstate_validate),
         VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.ccr[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.mmfar[M_REG_S], ARMCPU),
@@ -761,7 +713,6 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_VARRAY_UINT32(env.sau.rlar, ARMCPU, sau_sregion, 0,
                               vmstate_info_uint32, uint32_t),
         VMSTATE_UINT32(env.sau.rnr, ARMCPU),
-        VMSTATE_VALIDATE("SAU_RNR is valid", sau_rnr_vmstate_validate),
         VMSTATE_UINT32(env.sau.ctrl, ARMCPU),
         VMSTATE_UINT32(env.v7m.scr[M_REG_S], ARMCPU),
         /* AIRCR is not secure-only, but our implementation is R/O if the
@@ -1177,11 +1128,48 @@ static bool cpu_post_load(void *opaque, int version_id, Error **errp)
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
     bool ignore_s_regs;
+    bool valid;
     int i, v;
 
     trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
                         cpu->cpreg_array_len);
 
+    if (env->v7m.csselr[M_REG_NS] > R_V7M_CSSELR_INDEX_MASK ||
+        env->v7m.csselr[M_REG_S] > R_V7M_CSSELR_INDEX_MASK) {
+        error_setg(errp, "CSSELR is invalid");
+        return false;
+    }
+
+    /*
+     * Check MPU_RNR in-bounds. If no MPU, we still migrate these fields
+     * but number of regions == 0 and MPU_RNR is RAZ/WI so also 0
+     */
+    valid = env->pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion ||
+        (cpu->pmsav7_dregion == 0 && env->pmsav7.rnr[M_REG_NS] == 0);
+    if (!valid) {
+        error_setg(errp, "rgnr is invalid");
+        return false;
+    }
+
+    valid = env->pmsav7.rnr[M_REG_S] < cpu->pmsav7_dregion ||
+        (cpu->pmsav7_dregion == 0 && env->pmsav7.rnr[M_REG_S] == 0);
+    if (!valid) {
+        error_setg(errp, "secure MPU_RNR is invalid");
+        return false;
+    }
+
+    /*
+     * Check SAU_RNR in-bounds. If no SAU regions are implemented,
+     * we still migrate this field, but number of regions == 0 and
+     * SAU_RNR is RAZ/WI so also 0
+     */
+    valid = env->sau.rnr < cpu->sau_sregion ||
+        (cpu->sau_sregion == 0 && env->sau.rnr == 0);
+    if (!valid) {
+        error_setg(errp, "SAU_RNR is invalid");
+        return false;
+    }
+
     /*
      * Handle migration compatibility from old QEMU which didn't
      * send the irq-line-state subsection. A QEMU without it did not
@@ -1426,10 +1414,6 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_vfp,
         &vmstate_m,
         &vmstate_thumb2ee,
-        /* pmsav7_rnr must come before pmsav7 so that we have the
-         * region number before we test it in the VMSTATE_VALIDATE
-         * in vmstate_pmsav7.
-         */
         &vmstate_pmsav7_rnr,
         &vmstate_pmsav7,
         &vmstate_pmsav8,
-- 
2.56.0


