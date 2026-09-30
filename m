Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E72BCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByRi-0001i2-IG; Wed, 30 Sep 2026 13:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRZ-0001dE-7H
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRX-0001VE-N4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:50:12 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHexd7241777
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ViNswaydJ0+cMUUJ+NzSqjr4UFKKWviATdqXD8YSc0o=; b=SUIj4S1+SZ9m4t60
 GeIS1LZr8qBUi+x3UthfrgBdI1UMabDxOI7gNRYTYsS4qFfP1xDaPViMw71KX+J8
 6VCkKak4JTRUDQgEGE6qYn6tGZJQ+Bn41+DcIQgG7Z2s0Om5VVSa5h6AnMnWyzHo
 JaQKtLwbwYbfj8CNv5qyjeVQSMV0z7mzfgYUVN9g4ZkDJFt9mgLQEaeoYgiYAZOy
 Hv2Gy/rb7nj2lqPcC6zJeQ5ak78pnzTvkZEkXDhxgLNtIjisdpGOafZZvA396ABW
 pseO88zmmUlTjY68umDodhnfJGrjva5ZNEkexhKiAuvvUnXz+6h+X3rPu6Kj8KaQ
 R16yiQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h10bka2k6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:50:10 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-98331b577e4so4218290241.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790610; x=1791395410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ViNswaydJ0+cMUUJ+NzSqjr4UFKKWviATdqXD8YSc0o=;
 b=FosP0yoSclEav/FaS6u4tAE+hIYqdnsTuFB3NNolncfTr4Lxp7RN+m7M4KgvQYBCog
 5bIcac8xsolxjnvzstyDSlxkKU2fUtOdPIFmzGCxkAymSAwuYOWaB91CY4JejN/tGsUz
 P1leHpd8dx9qdCwgh6g8L6P8LIlxqAaVHxeof8FTs4ZjehzH+nIOxQQgmERNVlCILkwb
 H+ELMCcvJsWfqR/4ahWjBMSxp18/GPcsxMp4BcrCGF0HMg8DfkEjNyPXMV14aQoaxg06
 VP/6lC3lkVRFkEYvB8bC7VkuqR2zBnoos9plIJff96hO1NccPEP0e0N6mEfDBzzdY8ON
 ZRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790610; x=1791395410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ViNswaydJ0+cMUUJ+NzSqjr4UFKKWviATdqXD8YSc0o=;
 b=1jLG4iFLNqTvcQJHdJEeM26HWuIFbPLF67JCMu1u6SZKCVJnlrxSIfjeMzG/HDxU+4
 3tcxBt0VvrEclHDjWAJB1wTa0pzCdvWctCrlnfpZjpXhAWK8+VkJZP3gBNrdOhXflTS+
 HCe4BOsNlR3z7wVdkvncrWksY3Dg0Wp/cYq/7ssjPNB9dd8H+y2WKPSGReLSqOrxqerM
 trRzvV0F4yVML1i4L64QCAF2XZledYE33uaRxYDEK5yZNcxm1X6eXV2rh1l+s9DjKTwl
 qT0DYGlAbkKp/sfYQ2zF2aQqWkACvyX4DtK2d30RochiGa+n4Pf1JOuQMqKtnMvY10OG
 NAjA==
X-Gm-Message-State: AFq9FYKN0LxXVmnk8EUr1j9ObvPFrTxHwJqHlBiCDQhw0TbIT9FXDCVJ
 bg6q1f7xUqmzzuXKZQ1NlbQM9bDDYUMA5xI0W2aeoEZqvol7f13j97zny4BbCoWpRlQhyE7gHXd
 SLQhsRb0X9wSG+RFH212Y236CLbLlslBOnwfo6eWFNXVqYwEUzcwTH7dz1W64BGN6Zg==
X-Gm-Gg: AYBFou2MBhifKQUQ4YpcXOYpbKyatmxozK0O2PFz3lCj9u9cpUJ5yJLQ/SQFldRx9V1
 dEt882Op8kmWBkuM2mJe0o/aR2DQN7mGpCL6OCmue51YsYY6c8e5zJidfjRuQxxXEANaNBbiL8y
 6+U39rZ5GQXPlNsCRzl9mPyRoraw4xRHU8U1l3mkV7ntofswuTMqS8VQYAsFtHSneg28m9KENNa
 iVVzrw1SLlanzP6Tlg2oqjMgt0SkwnnxrLJd+30WjF7xPPlqYuFFm0sc43h+/mN9glUkCflyrRE
 vJfcskbd0R15mAGsoL6G3gfHGINj6BnXSNMN/Cug0a7ky5DoRY4vM07diWbMdOKizwRd9SYMGUH
 voUWZ44dtdUDSOTJYkSgP35qvvUGM2/9wv5SnTzP7
X-Received: by 2002:a05:6102:508f:b0:7a1:f7c3:3a42 with SMTP id
 ada2fe7eead31-7be72da8dfcmr743842137.15.1790790610168; 
 Wed, 30 Sep 2026 10:50:10 -0700 (PDT)
X-Received: by 2002:a05:6102:508f:b0:7a1:f7c3:3a42 with SMTP id
 ada2fe7eead31-7be72da8dfcmr743826137.15.1790790609701; 
 Wed, 30 Sep 2026 10:50:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b06778c3fsm779562f8f.0.2026.09.30.10.50.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:50:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 3/9] target/arm: Split leaving-halt handling from
 arm_cpu_exec_halt()
Date: Wed, 30 Sep 2026 19:49:39 +0200
Message-ID: <20260930174946.82195-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930174946.82195-1-philmd@oss.qualcomm.com>
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hadSS8bEgsEIAScf2RYzkpKIXrn0XVco
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX+jLBvuRfLIax
 alkZPmuLCsN2wtDw2dMZY4uw+rnitdTLVUKmkoRpumfc6p6f2Fy0DRByE125yDuHbbOPw9BP5dY
 m3UoLLVQ3Um0upytLUH+XdrYQoc8hW8ir0I6eihmEp+jjfOq1O4oDkeU4Asd7OmmglI6ANdt8ki
 fiegPRYx1TPt/pDL+mwHJwVyicP/rwzSovt2xdW0wIp1oNvt+Blv3wjDUCoKysNHbyvYRqTO38c
 m9fImdHgMbiBDF116Nod7/DxMY5w0MY30f0LxZ4z+GEdMkQFOitQtMS0oFG9l6/dXtIRt11ZqwB
 UhElXdzlQwAfpUblwkdGniIa0i16sN3K72mZ41LJI8zX9qI87/YiPIdjsoMGjafnbfeNWzXTeag
 5Zt7LmAX89Y/4yfHZav98o4f+mGbcx/1unHgYQmErLjhU+zmBKPBjfMn6HYd96X85/Q2aCrYddB
 otNoPEex0KbcWE+Ef3Q==
X-Authority-Analysis: v=2.4 cv=MZn5KJ/f c=1 sm=1 tr=0 ts=6abd4bd2 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX5M8Q+b7sRB1y
 GSeEHNNdqWQ9OvdlF0DKEgmi4p6thRYYJz2NrC+sJu+kI1XceejM2VOP6R2iFj36Ni8U9YPq9fj
 4ZLYw33e17b5Z/jGhatGZ6uYAloa8Oc=
X-Proofpoint-ORIG-GUID: hadSS8bEgsEIAScf2RYzkpKIXrn0XVco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Move WFxT timer cleanup and halt-reason reset into
arm_cpu_leaving_halt(). Keep arm_cpu_exec_halt()
focused on deciding whether the CPU can leave the
halted state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10ac6c98318..53f9a532a75 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -872,18 +872,24 @@ static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
+static void arm_cpu_leaving_halt(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    /* We're about to come out of WFI/WFE: disable the WFxT timer */
+    if (cpu->wfxt_timer) {
+        timer_del(cpu->wfxt_timer);
+    }
+    /* clear the halt reason */
+    qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
+}
+
 bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
     if (leave_halt) {
-        /* We're about to come out of WFI/WFE: disable the WFxT timer */
-        ARMCPU *cpu = ARM_CPU(cs);
-        if (cpu->wfxt_timer) {
-            timer_del(cpu->wfxt_timer);
-        }
-        /* clear the halt reason */
-        qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
+        arm_cpu_leaving_halt(cs);
     }
     return leave_halt;
 }
-- 
2.55.0


