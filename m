Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AFAC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgvA-0006dn-Us; Fri, 03 Jul 2026 12:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgv9-0006V3-0k
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgv7-00084u-02
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIo3n498273
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sCNdzsLH3Q0jMX4rCMKs72ytygkMCsUMvV9SlnS9aVI=; b=K9NQM+T9W9wO2sTq
 JvFsWfjFIVzTIqH4GGB4mhJytkKDZFJgi0m/cJKzv1hbCiiFcngOkH2j4jaaRslA
 TXLLPCNdTpb4YtLJ/QYnU3uot2Ih6aZKS9V6ImAqkUhbBLb6Laxdt4xhJQPA8U1m
 ZRAqA3DwAsz7bO4FImjR7sxwnVZRWQxvtIw3dEaCpcegmFOf5QemxHvPYVjbYx3D
 hxrSMrxrjYw3Tze88fKSkzlqzlY2sT4teZw3lxc3LSR6s8INc20uPvI/MuzW6fIB
 RvSdrynrqHhucgGeXoCwxYPTIemlJ36WJDNLYT/q3/XMQ7VS4yTLzdTOuBEN28bA
 SGPG2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjwvf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e52306621so54293985a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096755; x=1783701555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCNdzsLH3Q0jMX4rCMKs72ytygkMCsUMvV9SlnS9aVI=;
 b=DzUVRcf4j6xyBOYEhZS3vu7EG6W3uR9cpf27Nl9NV2Zbq3dh31CbARXaX846qjKndj
 FkusOFSY5G04Xny8Vi6ifbI3xMduRY9CvMw1XR0wK58AabwlwH/h3Jclpb3+m+MLqV58
 q9szCm2kD7Py28Ybrn0kjHEo4Qg/1mFmlL9d6bWbo+VztrrUg0vGQZ/L4/+NadW0YjX3
 /BQ0J6d4t84V5090dxT6MBiIRr0tMuIycRsTG2uD/pOhJGSbiRGv3AotRFSkMgrVOPiv
 XrL3l1DR0kbC1F2+ii6Xph6d2PrnMUCCKG2JD+fZ7aG2TFRd9nmaH8iAFKSe27tDfkDE
 XzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096755; x=1783701555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sCNdzsLH3Q0jMX4rCMKs72ytygkMCsUMvV9SlnS9aVI=;
 b=PxOqEk6ZxBm0lFmLdKbYmvFEwmSBfmWOi9jyQtBCO7g0nXVpQ/WIG1QfoD2bpTyDQm
 HppZ3A+BSRoRsfGCOtbAj01qLwxMXqYQCaF9aO0qxLVYL/j+6UOFU+ciqRz9uLNVObza
 rmjiUVvp6WZhu0asgZh2N8IAl07SlRXZbnNYmYslY0tcG1oyL1hRXyr6DfvGGxwBx6Fb
 GfvdMn+ghPvvRWFW0WhnsyB67xnF70D1MK9vhFOTUz2GaSSBZkvIOV/71p8/+1PvNVrN
 fX8qs5SIsy81ilUXsXsg5Hlj+/a79gD0xld92s6RFZawBI/aHiHWHfz3Q4Vrs8c+bmXe
 O4Ww==
X-Gm-Message-State: AOJu0YwFcVXyHxY8lHHIxq79YcmQKmrU2DD9cCGKxBO10TfhKenXlTKi
 LCDyrfsAF0U7i48r+lvSiDUOvFAQX9Xj2epVrHNYQ4PjQJsixmmIC1sD1QXl0wlTrmk2RgTP9EC
 ScszORX67xNAbbGLByj7aBTOybY0+XtYUYtTB/wZCAO1ZpULeioao3TevUeAAgL7QGg==
X-Gm-Gg: AfdE7ckGsAlfPbcIZFH+YuK/QmjUl/+lGE0QGvXC3LOE7nB1PH3pn64W8nAkFvTCZYZ
 yuNBZpqS+JTjma6eT71rpKnuINeFut3fnrI1BkR+0AzpAagDpOjhA07BHblinyB+Hf9TNRh98Pf
 hTYipGCtYgHsLzvDcYxCAjsP95hYU7x0FEJ7LhcGGMzghZYgzeyHPWzeJeaQjaEE3l2ezZP1MvR
 iZVKyNQQBsgdfeP1KjO8KkC2A4ztE7WCb+M6jjafQvgbenQy7Kpp+P8401BhyFzUdfCJE7js5Bd
 7Y2RXNyTWdRJetzkhIzLYv8iUxCSpfHUnNMNN9ukkJ6maInItY3GzZh8HZCG+p4xrnl80RFiJXz
 y07F1fmCeVrVLa455HiIcuUvD0gklvUIc2P96CNiNJRD0A5qEMYpeOACwLTqUkkt1tDEH
X-Received: by 2002:a05:620a:7006:b0:927:59bf:46ca with SMTP id
 af79cd13be357-92e9a491863mr28185085a.40.1783096755071; 
 Fri, 03 Jul 2026 09:39:15 -0700 (PDT)
X-Received: by 2002:a05:620a:7006:b0:927:59bf:46ca with SMTP id
 af79cd13be357-92e9a491863mr28179485a.40.1783096754458; 
 Fri, 03 Jul 2026 09:39:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdb62d3sm71133865e9.8.2026.07.03.09.39.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/33] accel/kvm: Simplify kvm_init() w.r.t.
 TARGET_KVM_HAVE_GUEST_DEBUG
Date: Fri,  3 Jul 2026 18:37:33 +0200
Message-ID: <20260703163757.55500-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CaEGlZH84Jobk5mepOSeWYKdEGVzx2cA
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e5b3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CaEGlZH84Jobk5mepOSeWYKdEGVzx2cA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXz+c7KUke/USn
 y8DHWDaQWr/n4bSoxYELfcK6jKSRv+GZkNdTPfh+GkI1SC5NRvMqfhrqm4t5N0+lhLJ9D/HQ1yC
 rhhuoyKIGDYRb8ELqP1VT+lJdVfA/OYQ0AL1E0G8+vuLIZ4Ab9TADXRu0nYHjqTtRR68q8s02Dv
 O2L1MpjUQGceVRSp+PfSQVA236K6i6WI3mzfjwFVDzMX+yAXfoFlPn6IgBWtJk30RAzDIoxyyfr
 MCzeRo0u6upKqjFS68YpCHq6GZcu0krgBrZ+rZP8F2bcNYwHIuT9Wd7LCHtUI32pApyAY2eRnRw
 rcaCU4hsrEJTmXPHyMEUYrPiU6jc8HqDFyCHyG9yrzMnwcs29AqcSow8F56oj/+AIdF2KUhVzdA
 FeTwYCesVJwLljRlqqv/zcaeLACkPoVcov2MpjXnp906fi3dVFmkAPMrdVaSyJvy2/sPegEVZCo
 Rsstg33ggWo2FAohi/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXx/CNB+eUzUtf
 ref/E29ov4fS2ChUp8N5WzyXYPldeokMKBAHsbL4J0TNeEIiRro6JwYOcWEpe9Ppnnx0wwGeup7
 K221rqGw8MZlsYrECCymHu/98L87A+s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Simplify #ifdef'ry using TARGET_KVM_HAVE_GUEST_DEBUG in kvm_init().
No need to zero-initialize kvm_sstep_flags again.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/kvm/kvm-all.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5d55cb45cf7..304467704ee 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3040,21 +3040,18 @@ static int kvm_init(AccelState *as, MachineState *ms)
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     kvm_has_guest_debug =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
-#endif
 
-    kvm_sstep_flags = 0;
     if (kvm_has_guest_debug) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
-#if defined TARGET_KVM_HAVE_GUEST_DEBUG
         int guest_debug_flags =
             kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
 
         if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
             kvm_sstep_flags |= SSTEP_NOIRQ;
         }
-#endif
     }
+#endif
 
     kvm_state = s;
 
-- 
2.53.0


