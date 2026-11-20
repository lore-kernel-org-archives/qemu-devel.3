Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C93606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUtA/0dX;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VdUf0+rF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUO3g-0000rO-2C; Fri, 20 Nov 2026 07:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3d-0000qI-Ru
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUO3c-0004lj-2c
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795178975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yB6UGk0PQtx1HyzaQH1q7NaL5PpeGBbOIWIpyS3oM/0=;
 b=gUtA/0dXQ32AdFUCcZ40t+pXTrwfeYMPqZrtuiGqn4MUI6vI2xMHriX0RzgLxqddIL7GzI
 RGgedJRzXQCqUARmNt2PNTheOm3TjZeSiueHHLBzN8lMmjhbozEW+XM2edSl/BLJNh13Vs
 KAvV8tXOwqQR48rMWsBuc+SJtx9fPq8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-nayAnhBCO8-bo_xsSN8Iqw-1; Fri, 20 Nov 2026 12:49:33 +0000
X-MC-Unique: nayAnhBCO8-bo_xsSN8Iqw-1
X-Mimecast-MFC-AGG-ID: nayAnhBCO8-bo_xsSN8Iqw_1795178973
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5363fa3d3e4so16925211cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795178973; x=1795783773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yB6UGk0PQtx1HyzaQH1q7NaL5PpeGBbOIWIpyS3oM/0=;
 b=VdUf0+rF2rFJvKjuWCnYtnexIF74Xgmqx42wfIDN093AdvmqiTottiSnssOL2t18Nm
 RZudX3HM6ei6cjOuV3qt+mNn47CjP3kkGZiMeh2C8YF4TiEePyXcXkwf3BOmG0aY2tP4
 dijZ1HtFS9tMp6N6D79Baw/NPkTAkfK3KTKbNcXQgrUJ32l0nLZPOwkOcARfZOA2x04h
 r16kk32wr8Xtaw+vfZme+wlWgL4qqrgWQWEXgntxjBRIFUjCvnOjS9u0iWugRtOEZXMs
 tePGMw9fum9CLuY4CgCgziq7vCIME+A+RerZIidX/ee0DSZepVzYF6PJLBO2X4/LJ993
 a/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795178973; x=1795783773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yB6UGk0PQtx1HyzaQH1q7NaL5PpeGBbOIWIpyS3oM/0=;
 b=sTs1/WKbwxeaq8YPv5qxlNpItUDoP4pza+e72x5zh/xjUVye9rWBnZIvOi0InVdZCK
 kIUlkoqSDBnlOe1g1dFcqdgNKq+fN4/t68t+DtPsoEo23JSdjhKtWsnVreLYGwOTcagz
 ctjsH71sMR2NPCMDGbEm7NWCvLvA1K4V0GU9GXA3N6M44a9+tlEgKApppIDnzXG8cbh3
 XZ++hmsUitgCf6TeBpYzsqaq4exl1CAtm5L3PHrJHs9SHFI0eGlnaTS2sVTqjmWsAS/g
 RSwZk2jFyzYaoIu7q0Z0LhVwZ3q+gstEYzt39GfApDOQyv+fSnM2EK2Bwub+8s0rrRMS
 FEAg==
X-Gm-Message-State: APuU4Z9cPrObt++gWE+NSHrTB+T5Lzcdk3Cix/sTUS32z3s3uxDHUlu6
 Xtpgi2WkdUUZuth9MqExL8zq5ZE16pJTiJHxJdgOfZygRNysi0roe0PjGCd7NXKohZITsWBIR63
 Yd0dAnrX2VJpD74rUhyo3pKv+z8TtfBgrL+hdbQ1vxeZSDfa8RF5AWpLgTzEHr8HLUzor9gVNR4
 sY6TxRtIta/wtPbNzesGLLs2IM2JEdXCQr/AQiag==
X-Gm-Gg: AYBFou1KhC98LVbTTguVQCEmNRG1k17Yu3FESe6wcKKHU1i8/iq0BqYLqrExIv5FPEN
 Kxc4IU4euaLZdq5zIC2Dizn29Zx/iHoOEK5PcANhT6CbflFUUyHjK9vWG9FfKAWBQgYVdgboe4o
 UizY5JoAd7dAqOotvfTv6xUsn1dPI13s2kR2T74OsuM3J9yJ3c7dNuj0DbdC4MZtfDTtzmokY5m
 l60s/IdEvAfxZqNSiMj4zK3hUNxETNdWtbsZqBCEzUts1u+PPCc6+ylDV1rCxwFuOBjs6wsYdK1
 HkYWxFsvoVplzVDdjrs7q4L5+WtSfKjDlDOnIK0qhHUezExPzamnnexUS27PDoeV1K2Q2r0zbKB
 qdBURCV0GNUu+WVVU/4PDC1IUFAV+EV6iPOgWdA8AD2q/
X-Received: by 2002:a05:622a:c18:b0:536:780e:8f48 with SMTP id
 d75a77b69052e-55d76a5d56cmr47527521cf.30.1795178972708; 
 Fri, 20 Nov 2026 04:49:32 -0800 (PST)
X-Received: by 2002:a05:622a:c18:b0:536:780e:8f48 with SMTP id
 d75a77b69052e-55d76a5d56cmr47527281cf.30.1795178972205; 
 Fri, 20 Nov 2026 04:49:32 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d78807b5fsm21591291cf.6.2026.11.20.04.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:49:31 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH for-12.0 4/6] arm/machine: Move all VMSTATE_VALIDATE() usages
 into post_load
Date: Fri, 20 Nov 2026 07:49:21 -0500
Message-ID: <20261120124923.1656220-5-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120124923.1656220-1-peterx@redhat.com>
References: <20261120124923.1656220-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To pave way removing VMSTATE_VALIDATE(), move all four such uses into a
post_load hook instead.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 target/arm/machine.c | 45 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index c3aef3f330..ec6daf1ab9 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -11,6 +11,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
+#include "qapi/error.h"
 
 static bool vfp_needed(void *opaque)
 {
@@ -421,14 +422,24 @@ static bool m_csselr_needed(void *opaque)
     return !arm_v7m_csselr_razwi(cpu);
 }
 
+static bool csselr_post_load(void *opaque, int version_id, Error **errp)
+{
+    if (!csselr_vmstate_validate(opaque, version_id)) {
+        error_setg(errp, "CSSELR is invalid");
+        return false;
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_m_csselr = {
     .name = "cpu/m/csselr",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_csselr_needed,
+    .post_load_errp = csselr_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.v7m.csselr, ARMCPU, M_REG_NUM_BANKS),
-        VMSTATE_VALIDATE("CSSELR is valid", csselr_vmstate_validate),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -596,11 +607,22 @@ static bool pmsav7_rgnr_vmstate_validate(void *opaque, int version_id)
     return cpu->env.pmsav7.rnr[M_REG_NS] < cpu->pmsav7_dregion;
 }
 
+static bool pmsav7_rgnr_post_load(void *opaque, int version_id, Error **errp)
+{
+    if (!pmsav7_rgnr_vmstate_validate(opaque, version_id)) {
+        error_setg(errp, "rgnr is invalid");
+        return false;
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_pmsav7 = {
     .name = "cpu/pmsav7",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = pmsav7_needed,
+    .post_load_errp = pmsav7_rgnr_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_VARRAY_UINT32(env.pmsav7.drbar, ARMCPU, pmsav7_dregion, 0,
                               vmstate_info_uint32, uint32_t),
@@ -608,7 +630,6 @@ static const VMStateDescription vmstate_pmsav7 = {
                               vmstate_info_uint32, uint32_t),
         VMSTATE_VARRAY_UINT32(env.pmsav7.dracr, ARMCPU, pmsav7_dregion, 0,
                               vmstate_info_uint32, uint32_t),
-        VMSTATE_VALIDATE("rgnr is valid", pmsav7_rgnr_vmstate_validate),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -711,11 +732,27 @@ static bool m_security_needed(void *opaque)
     return arm_feature(env, ARM_FEATURE_M_SECURITY);
 }
 
+static bool m_security_post_load(void *opaque, int version_id, Error **errp)
+{
+    if (!s_rnr_vmstate_validate(opaque, version_id)) {
+        error_setg(errp, "secure MPU_RNR is invalid");
+        return false;
+    }
+
+    if (!sau_rnr_vmstate_validate(opaque, version_id)) {
+        error_setg(errp, "SAU_RNR is invalid");
+        return false;
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_m_security = {
     .name = "cpu/m-security",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = m_security_needed,
+    .post_load_errp = m_security_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.v7m.secure, ARMCPU),
         VMSTATE_UINT32(env.v7m.other_ss_msp, ARMCPU),
@@ -732,7 +769,6 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_VARRAY_UINT32(env.pmsav8.rlar[M_REG_S], ARMCPU, pmsav7_dregion,
                               0, vmstate_info_uint32, uint32_t),
         VMSTATE_UINT32(env.pmsav7.rnr[M_REG_S], ARMCPU),
-        VMSTATE_VALIDATE("secure MPU_RNR is valid", s_rnr_vmstate_validate),
         VMSTATE_UINT32(env.v7m.mpu_ctrl[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.ccr[M_REG_S], ARMCPU),
         VMSTATE_UINT32(env.v7m.mmfar[M_REG_S], ARMCPU),
@@ -744,7 +780,6 @@ static const VMStateDescription vmstate_m_security = {
         VMSTATE_VARRAY_UINT32(env.sau.rlar, ARMCPU, sau_sregion, 0,
                               vmstate_info_uint32, uint32_t),
         VMSTATE_UINT32(env.sau.rnr, ARMCPU),
-        VMSTATE_VALIDATE("SAU_RNR is valid", sau_rnr_vmstate_validate),
         VMSTATE_UINT32(env.sau.ctrl, ARMCPU),
         VMSTATE_UINT32(env.v7m.scr[M_REG_S], ARMCPU),
         /* AIRCR is not secure-only, but our implementation is R/O if the
@@ -1405,7 +1440,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_m,
         &vmstate_thumb2ee,
         /* pmsav7_rnr must come before pmsav7 so that we have the
-         * region number before we test it in the VMSTATE_VALIDATE
+         * region number before we test it in the post_load_errp()
          * in vmstate_pmsav7.
          */
         &vmstate_pmsav7_rnr,
-- 
2.56.0


