Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF31CDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsS2-0000gh-O3; Thu, 25 Jun 2026 18:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS0-0000fY-Nq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsRz-0001JN-28
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PIQpkR1196846
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RY4iMWRY4ffovQ8blMgV9m3JJiZFPwMcesQFQLkR+Ng=; b=L7sJwzvh6raz8gRj
 DhSOoMadraDuCXWQVFYi3q/OmbI8IRMUhD9NeQ8D/uuuojaecsDWF12obWPz39J2
 e857pGYvwI2XV1TWmIrgPogM+IeVKaUvcGf5k+TER+EzPT5ILOz+0cUV/4ZmqlpN
 OYGr1Z4i2LMVwnm7srs0YAJNdHznIfRYT858jvWxWaasqWUg8hHbTAJCcbKPWPf6
 X61+MveIglaebmbtK6mFDUEB5YItU7H8A+EkV7HJOy6Waaii80Mnp+rI0b6+H0H7
 cXxqTahWtPLThejwE6tG9POmf0iDX6c/3nQ2q8y9ICZ9X+C/WOq876fmPc6pYJo5
 V4piFg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f19m3rqp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:33 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139ca26403fso732668c88.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426093; x=1783030893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RY4iMWRY4ffovQ8blMgV9m3JJiZFPwMcesQFQLkR+Ng=;
 b=I8sVd2AnFBTj6OKqtKhnfJv+I31kajD3dq0Tr9IVjgAoiE9ldR+G9C/uo6+PvLS/9i
 tz91pjbRtgPoVvXAnUhuzat6+2B0+EuF96W+hZmpR1eRWqk4HhvsC7W1RtSFRQVueyWk
 mpi4m52dAjhaAf/Nz5ImngHqa42/rBlmQ/KUEzDCVUhZFLgnh1uDp0xNouPfCpJnoumG
 KvFHBU6aPHxjj4SxSATbjfD/cTVdO+rLr3MJOMrmwTCS9v+2Hq0d+Wes2yAI9FpIraIe
 bpmCRYjMiZ1aokN7b4guzvJsTnt2s8DWWzpciPjpF63Hmqp7DJqlkgvpLpobIyjA7QUf
 Di+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426093; x=1783030893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RY4iMWRY4ffovQ8blMgV9m3JJiZFPwMcesQFQLkR+Ng=;
 b=WYdoGUyARX2zQc+qFkK5IbdrbYVAevXZcNqBBQp5vq/nd7dEkvzo19KVyh40lVUVmA
 17XwpnqODtKfnB2rLAEvMQ+5A+t0kPuUuEG86DPJMM0/rM4a3KXKASOQdLorg+OfoVea
 Cpmqz0rIxet70dNxFP1vjJGzEFCsot4oYRQBqtY9nzniJPWpyeNrmvAAmXrjdROHaJ/J
 L/womCKT2Dc9OSh8Hxb3XZ4uDZ8O4M12rZV+QMcAWNTdyi1VuiREwlNX2KxY5f8au9TM
 mFaiTVzbgWe6ZGnpSvMyJ4qiD/Y2xLgdI0kXrsJXiqCQ7y0IMBa0wVx6P5S4JZheIeuA
 dRkA==
X-Gm-Message-State: AOJu0Yzx5c/J/4BrUs9r9JLsJkwzkmk+oT+j/pnpk+1Sesk1jIPyGWCQ
 S/t7mtVPPTR256NEMT09gOtZUlVYpMV63INgktzh+xJiVy7jgiYwEYWVdW4dX2I+Y/9M0NTmm7z
 oCOXKn4io4FUzkeUnaMpQRwoeTOJazokkivzZq764+FgZUhgPDlY/IZ2Gr7sMn8yUFQ==
X-Gm-Gg: AfdE7clnz2dcNqsmHwDVvKvqR/PpKbvcnmJbPeBnfQNKoF0rIX3qx03jbHFJI/T8LbX
 w8CJUlgBnIr2cwHkZ84YINEv/kmDYV7DhRJQb6Xv1Hqaz3azCmTPbQIGxr2WxUbG5GILPtLNrKF
 pYyQkHKWgbsjGchu23bIgZzsdfg7e8utzrVJuOX6HNZgIGB+XZCCOWCNtrRP7aTD0FAus9d1kGZ
 3qcRV57WXoyuFjJGly6cOT2c/gItBFenSCRpeW3MN0Kr+wmdW5ZRQGJrAkgJUP5x3bwnJnn++Ws
 8xft9X0eFzU0Cuv27ouCi9j1GU5ljIlidwL1QcX5OWbksF2iMOw/MJnQiknGpndMV+Q+aSaXqOK
 Lkts1nH7XVY4abPLcaOE+yb1i1I6mkv5AlPyz1V2ULNG8nrMNqS1jyhqocr+rACK9EaIejf2Yfw
 mcYF5Cmw==
X-Received: by 2002:a05:7022:69a0:b0:137:fe07:8a2c with SMTP id
 a92af1059eb24-139dbac2ef7mr4061329c88.22.1782426093086; 
 Thu, 25 Jun 2026 15:21:33 -0700 (PDT)
X-Received: by 2002:a05:7022:69a0:b0:137:fe07:8a2c with SMTP id
 a92af1059eb24-139dbac2ef7mr4061305c88.22.1782426092547; 
 Thu, 25 Jun 2026 15:21:32 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318e7sm11538477c88.3.2026.06.25.15.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:21:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/6] gitlab: use .base_meson_job_template from crossbuild jobs
Date: Thu, 25 Jun 2026 15:21:08 -0700
Message-ID: <20260625222111.1761-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX9LjaTrJ8rJuE
 hqc1ehZ1FfO5Y3cSYdFt+pACbEZHnQYxvmhXV9FSwR0lNejUXVfC2UQGNGSTWvfiSsb4eMz9NHI
 tAdPQVowyHVbJxxBMhjPOPV1pjJhk7o=
X-Proofpoint-GUID: UBPiV-3vzz9snTJwm4j34eXJ1YPO1tYB
X-Proofpoint-ORIG-GUID: UBPiV-3vzz9snTJwm4j34eXJ1YPO1tYB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX0o+sZYNY6jkM
 mHMjyjmifau0e+OS4JGNndNHstUlT+wkMH/K34L/r/XDW/sn0ywKFjKw4jKTEHVjNDzA/EWycl1
 XbaaNV40Mmt2GiFFIB6b0kp3jDqc+2c/hjX19b8/EmOu3YlqGmE/+LQgZwi3vbJXHKx8y9H6Pkx
 +pRiCQk3Nhl2Nep16oGKccuZ7XThcGRAJzMPnaF3DWM6dn9h0KARylj1DlXJfTkknV3cq707o1l
 fsWX20Sw6tVuBV6ZJExQEDVX/QBO+8VC31tsgbl2PN3dWR6j7jZHcb3PCF1Ij7Ad/zrI+ltnA2i
 HP6m/sFwme7iGRFb71k3AKnr9OQUVJqtSdMBaMXvREsEMRnLrltASjcHAI2i8fXzx4RajJBAoLg
 4DO6grOFTnJvSsRme8mnjlsBk6ufGxgzbDAieJO2zQmr77dqGtIaFxBmZ+yRo8ZvODLbHCtil3t
 rc/BONmRwEw9eivhdvw==
X-Authority-Analysis: v=2.4 cv=Vv0Txe2n c=1 sm=1 tr=0 ts=6a3da9ed cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=QQR9eqaitutBty8eekMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This ensures that crossbuild jobs capture the build/meson-logs
content as artifacts to aid in debugging.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260624124657.2725376-4-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/crossbuild-template.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 786c5cdb88f..36bb9a405c0 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -1,5 +1,5 @@
 .cross_system_build_job:
-  extends: .base_job_template
+  extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   cache:
@@ -54,7 +54,7 @@
 # KVM), and set extra options (such disabling other accelerators) via the
 # $EXTRA_CONFIGURE_OPTS variable.
 .cross_accel_build_job:
-  extends: .base_job_template
+  extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 60m
@@ -87,7 +87,7 @@
     - section_end test
 
 .cross_user_build_job:
-  extends: .base_job_template
+  extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   cache:
-- 
2.47.3


