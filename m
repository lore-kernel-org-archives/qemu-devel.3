Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390C0CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 23:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waMSt-00005h-S1; Thu, 18 Jun 2026 19:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMSs-00005Z-JA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:48:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1waMSq-0000jG-O7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 19:48:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ILt1Ds2521423
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=btT9jzBYc31
 z9LBTtcVQuaTxbbrFJH7KpothfEkpQws=; b=l7Y2O4ZLviQu95CqZ5hHYWuy+WU
 xvWMYAoA6GLB3M26kzssV8i5FFnix65RPJXO5bB5XA+jDgmamu70+4XsWwo0WdUb
 /xNX+Ub4s2T/YAc5Y1gVtuGMAvoVxz1DzZmrZLNY+ZnWO156sxiXFxui9+Qayq+I
 2diuvIltr8Q+WBNLIaaZQsBdem1DtmDC1LIcVn2I+fFg3dBm/qzGwelbKtbSqRCw
 pu5aHlyYF6lVymlDRAR+PYSz5LlEgqQiQl2chvh0yikLffdggRo2i1uZzxxnPcmN
 HQQCvD4C4f0w33meQJ+eJv7tT8T/6eAomuhTMuY/a8CQspl5kV5m8u5Mj4Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm269tp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 23:48:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcbb34e57so2455520eec.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781826482; x=1782431282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btT9jzBYc31z9LBTtcVQuaTxbbrFJH7KpothfEkpQws=;
 b=MbFhHowbi33BidBd1port8NUqjuA+O8yThJumOAtbWHXh6MJeFG96qDNstTYU0bBmC
 fOWBumYCu6w/YO+/mrqSDCGj/6ZuwGNS1hoH+OAt4ajQ3WpAa3Wyw+vO64+gPhkMipw2
 GnNd3rJqjAZDLaguVjIr/IYAMrUi4im8nqjfO4PUNCUJ67OBBUnuq0w2E9/nv7hAEe/v
 Qn30a45Sxbg6gkNaZkLE0er3N4r0mLKKlhGqyn8X9EwUWY+d92lPRgD4SnmChMUt6bgz
 GVALTGfd8/dA13IMxmett6LibWx1igiO8ZVJggoBKZs+b5SBmGCJG1ZVl+VVwZWqnDq4
 E0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781826482; x=1782431282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=btT9jzBYc31z9LBTtcVQuaTxbbrFJH7KpothfEkpQws=;
 b=FPZsbNR2dgBP2DNA75FxwnfmoFucJShIDsKKkIGKttHUPxA8wPOSSnrUq/7zSoyczo
 SaWX5i9haQ8ndMoZBU6sZDVg9H9CQ/y2BAVko5CXQd0q7mI63flMy6VLm4XBNuk+Otrb
 sTF7XSCsbUjY+Nm3GCq/hOJkt9ca83bISUm5ymiHa1Quu0Zx+OfWI0uPEcmaD33unuX6
 TLV/32/VPT3mIh+/GLUoR3wq3ihLzSfYpdpHvR37nEh3UCeoDJtm1hg+MN9GTCc2NIwW
 0aY3S1WHjBlzQE6DeSNVJ/8Y49uqRXNlGsFGdNxbwfaqBGpSRzE6V1vVlHLWtYdJw6Du
 g7iA==
X-Gm-Message-State: AOJu0YzyWLVX55ZnVepsu+dOdKAsOHm9c/47V1/EwR1EC0EY6iEPRvrq
 V8zDPKyHlfUn24MGc+UGvv1i5U74gz9DXJu1HdKHwRZ0m32UVxbkbajPyP8jkrnbBsayjhr4fZA
 HfSxOtioK206mAVIy/UAhjBPwumF9SAK9j7/Eq1MfkZiMGSS0ECcDTPpTaF5afT+MJw==
X-Gm-Gg: AfdE7cnSj2AeIXEiSfj9RgvB37wSv9ftsJlSUIFz/KFD1E51/1sc9vuItwLHUl/ZDvS
 GBZ5MBmkz+aLs7KojqFWB9ZPV7liOhw8c8JCSn0t/WNl11GOzx114rF4AHnJHxY8GKpLmbaOXjS
 Dzwt6aDyJ9SdIq1kfI+BfkFcwpM4vOZwPZW7fSYcdTaFQoGubrhnSkhCITOW6TFrdAlfYLI3Jso
 z4BI9g7tAABAGfdJNFI+guyosTZnRdd7IrUJkXjyu4jvBzDrbF7qGwttBw4ckbhvW5osq/33VUO
 NBoewriZQNw0jAd/tMH3w04CmrS5ozV6ln3ciI63o8/PHuvnaj/yZ3ayLBH4LqW39RIOKXIp7ed
 o/kkll8tbf9CF0pgax2SlXZkPwk+WBSKa5AF3XRWSTqs7/avQz2eLLwasfkZiqVlHXvhxjhGkOI
 ivL6DERA==
X-Received: by 2002:a05:7300:f10a:b0:30b:fc05:a18c with SMTP id
 5a478bee46e88-30c071d1c6dmr850888eec.24.1781826481670; 
 Thu, 18 Jun 2026 16:48:01 -0700 (PDT)
X-Received: by 2002:a05:7300:f10a:b0:30b:fc05:a18c with SMTP id
 5a478bee46e88-30c071d1c6dmr850875eec.24.1781826481142; 
 Thu, 18 Jun 2026 16:48:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06c307fdsm829917eec.18.2026.06.18.16.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 16:48:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] plugins: use int64_t for the syscall filter return value
Date: Thu, 18 Jun 2026 16:47:49 -0700
Message-ID: <20260618234749.1659878-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618234749.1659878-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260618234749.1659878-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfX+omT2uTIj+Gz
 T/UCgObSo406nPHmiUPP9c0P3CSNEzJj2HkiPc0dRknQD8dRXgS6BgEmTuoDfi+c47XXmr1ZIMA
 f0VRwwVP5/TErLcY1pYsTinUzzxSwYI=
X-Proofpoint-ORIG-GUID: 7CMO_IN9ExVddMF_B4r_aDp0qEDwKbzz
X-Authority-Analysis: v=2.4 cv=dL2WXuZb c=1 sm=1 tr=0 ts=6a3483b2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=D_0KSDsig3WiY-C2LT0A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 7CMO_IN9ExVddMF_B4r_aDp0qEDwKbzz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIxNiBTYWx0ZWRfX0knAAZU83LSt
 TBqwcrUEgfiSBK0vZYQkMrvBGfa4F0OM4fEZA+AtqqWrpaNgXd7EN5e7vpU2UQtDH3m+mGlIvKB
 7YEo35DvvOgkFkuxWQtSShdCtXP2Bg6u7lv5qxkEXl/7oh7DZBLT5TOMkL/YgrPij7mA5g8sHZq
 nQlWVknw+Y38nXjEQ1T9L/E/wui4cEoe+GYNb2tG27ooxwo+sSpZ6mqJpThn7HvzbCIYlDFunsN
 ZoMXH0PfOcdzJmoYj1noleKgKolHIfVcvRlzXs7LSApvmCQIlEbEvTfIL2KcjY1vdWqBUzAaqmk
 +26reeKTpi141qXVNr995nmBYSa0gNGgILibW28yp4xQo4kg4ynVh8wWIUV7I345TfOgMnEdJ1O
 FqTvEC6kKrouQ5EkixK4KKLHBZSN1opBj2g7BLYs3BAMQfoXuj4u1w1rzDkEZ3H9cIRahmp5fhO
 WHyY2RdtqsS5LQd5eYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180216
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

The syscall return value passed back through the syscall filter
callback is semantically signed: negative values encode errno codes.
Declaring the sysret pointer as uint64_t * is therefore misleading and
forces callers to launder the value through an unsigned temporary.

Change the sysret pointer to int64_t * across the public plugin API
typedef (qemu_plugin_vcpu_syscall_filter_cb_t), the internal
qemu_plugin_vcpu_syscall_filter() prototypes and stub, its
implementation in plugins/core.c, the linux-user caller, and the
in-tree example plugins.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260618082426.790315-2-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 2 +-
 include/qemu/plugin.h         | 4 ++--
 linux-user/syscall.c          | 2 +-
 plugins/core.c                | 2 +-
 tests/tcg/plugins/setpc.c     | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index d8d4b373842..3e913cd89ce 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -871,7 +871,7 @@ typedef bool
                                         int64_t num, uint64_t a1, uint64_t a2,
                                         uint64_t a3, uint64_t a4, uint64_t a5,
                                         uint64_t a6, uint64_t a7, uint64_t a8,
-                                        uint64_t *sysret,
+                                        int64_t *sysret,
                                         void *userdata);
 
 /**
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9356ee836ac..9c2ec8ceaeb 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -172,7 +172,7 @@ bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret);
+                                uint64_t a8, int64_t *sysret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
@@ -288,7 +288,7 @@ static inline bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret)
+                                uint64_t a8, int64_t *sysret)
 {
     return false;
 }
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fbe357b7e0f..d257fb9ca90 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14619,7 +14619,7 @@ static bool send_through_syscall_filters(CPUState *cpu, int num,
                                          abi_long arg7, abi_long arg8,
                                          abi_long *sysret)
 {
-    uint64_t sysret64 = 0;
+    int64_t sysret64 = 0;
     bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, arg2,
                                                     arg3, arg4, arg5, arg6,
                                                     arg7, arg8, &sysret64);
diff --git a/plugins/core.c b/plugins/core.c
index 4b55aacd2d7..1113bfe5673 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -573,7 +573,7 @@ bool
 qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
                                 uint64_t a2, uint64_t a3, uint64_t a4,
                                 uint64_t a5, uint64_t a6, uint64_t a7,
-                                uint64_t a8, uint64_t *sysret)
+                                uint64_t a8, int64_t *sysret)
 {
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
index 7c78f182f01..76b2efc61b2 100644
--- a/tests/tcg/plugins/setpc.c
+++ b/tests/tcg/plugins/setpc.c
@@ -27,7 +27,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret, void *userdata)
+                                int64_t *sysret, void *userdata)
 {
     if (num == MAGIC_SYSCALL) {
         if (a1 == SETPC) {
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index a28d1087840..debec9f09b5 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -176,7 +176,7 @@ static bool vcpu_syscall_filter(unsigned int vcpu_index,
                                 int64_t num, uint64_t a1, uint64_t a2,
                                 uint64_t a3, uint64_t a4, uint64_t a5,
                                 uint64_t a6, uint64_t a7, uint64_t a8,
-                                uint64_t *sysret, void *userdata)
+                                int64_t *sysret, void *userdata)
 {
     /* Special syscall to test the filter functionality. */
     if (num == 4096 && a1 == 0x66CCFF) {
-- 
2.47.3


