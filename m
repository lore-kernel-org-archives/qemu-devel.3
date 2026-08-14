Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F2AC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wumuq-0006aF-7c; Fri, 14 Aug 2026 04:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wumun-0006Zf-ON
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:05:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wumui-0004N0-Bv
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:05:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E7gJIv4047406
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9aocAErqtcOVa0azkPqHmN
 xwJ2foHbbi/pvrs3OIGu8=; b=kV9iSBU8hjoibewBClpO9Y0jBvMr/5RcSsxlKt
 rH2Fnr0iAsIFAGY0nwy1CQW45uToz+DIOriMRkBApOaxgoU0Re2sF0NiEaDSgffp
 s6jMmW+ypdQ9SbMmGAz/RdgGhr2fto8FXHqeHR9TpjTVa8jv0nJCHF5i2TH1a26+
 iRzLS/VaEUM12U6tmTmf4M5dA0byd76B7inA9PNKKfjX1GLKj2Z44xSwHn+neEyD
 u7PqeTyyGgmup3F+UgEG95KUSSuyjHNbMJxqDntuTtS6fkBU19zBMT9HGkv6Q9GI
 fpmr162wfZpUnLV9+yRr+xRm/vaVaWTt0WxyLg9aB4m3g9+g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy37d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:05:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d30035dso6165901cf.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786694713; x=1787299513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9aocAErqtcOVa0azkPqHmNxwJ2foHbbi/pvrs3OIGu8=;
 b=KfTcbL5gCfdGGXYH27fd5QVIsD/uwKRAb/7IEmdKXcOXUR0/oHrRvuwhvzsZeQYiy9
 JNIsxdDiPySLl+/wiG/caTLxy8432vRwEiIrbCljoXPfgUYXtalSB7tIdjrWCcGdf61C
 xFYwkk2jDnyw+EP9L684boQXGbsK4eC12JeyOZcJO9cFdqtdeIKipEa56gLBFz13gyyt
 bs7guUuQ33EjChIYyTFbdPJXdYsFyg83mkzcrqyW5Ald87l81lyETJVkr5Qkj7LcWvGk
 ecpJkyE1WRCLkORMnQ8XoW8FCz3MFW8WmjAAzJGCuDYBNaURKiF3MKR4MvaGRgrnd9A9
 3YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786694713; x=1787299513;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9aocAErqtcOVa0azkPqHmNxwJ2foHbbi/pvrs3OIGu8=;
 b=jTzuMZB9QRJ6wzBZIUtqagZkBp7pdIpO0dzKd55EF/n69JtzqMyxx6s5ZYZTFGk3I1
 qUP54V5jhWO05OTg7QlCCgmkyylogK3tmrL010CViJkKVVceA+AgW+4v1K70k+oCYrzq
 /mYE8TwLYmQ2269VZ47BAHL6M/RE6cfcG/U7HS0+zeIPH5bkvviKgTrWdsisHJZhO+8f
 EdftlBNK14bX5Igp7MvE0OHKa6RjKQ52sOxAa70o6OBLK0aWMVMldM6Xh8q3OreJZ3n1
 DwYlp6J9pg6zXxnnFo3lFq8+BrLJ6XFfUd558uRZ9mnJyrdaC91pOxxSB4GvCH1YTgeE
 Vb4Q==
X-Gm-Message-State: AOJu0Yzr5rpbve/cvzPLJaANf4yYesEDgApi1lhjOEFvAJ7Bov/IC30E
 vEDNqkW+D7JBMQN1+hcp/dRSFsq2KMWmyOPsgla85QhGGUjW88OYdDIpxZYzZlQ/z1fpysXbkBP
 qGAhsJMLkApFXmeHExO/9sEPfnF9vdKi8UHm3czT2kzPQRibznmtckLOt/Mv6RnCP8A==
X-Gm-Gg: AR+sD12QNKqik3urUNsoNwkmL1q/3z1JgfPBauGKyyifu0mIz+7dC8Bid10AxZWCGer
 t8HfV4yzTc4wXaCIN2VaRTLcrum8+wpnnfr9P9Ba0YsOh9gjTn5Wei1mch8Y+k7gCyc182gNUp+
 CwojJwS2T7t7COw9w9ZO0VstQsnYzPRVcykERM7ypsmzCwILxdppvRarc5dIfkDjPRldaaM5+AF
 TlCANAQTzjNspQMYLNeDVirHsEljRg0YreHhPKx2Fy6iwrvPzun79A/7B+ThBSIySTfaLYm4Dzh
 sBg4hu/78xm+49xf5NoN3bUkqqED3dwPzs5Xs1L/4EFn6dktji6Safr6yZIlf8d9i/EI/79tDxN
 HIAdxe8eawvdKzTjZXKFkPFyA/PtdtCzOHG7ewsqxYg==
X-Received: by 2002:a05:622a:2c1:b0:52d:771a:23c5 with SMTP id
 d75a77b69052e-52d8535ee35mr39009551cf.15.1786694713103; 
 Fri, 14 Aug 2026 01:05:13 -0700 (PDT)
X-Received: by 2002:a05:622a:2c1:b0:52d:771a:23c5 with SMTP id
 d75a77b69052e-52d8535ee35mr39009051cf.15.1786694712623; 
 Fri, 14 Aug 2026 01:05:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d9fasm33143445e9.9.2026.08.14.01.05.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Aug 2026 01:05:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to TCG
Date: Fri, 14 Aug 2026 10:05:07 +0200
Message-ID: <20260814080507.23196-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX/v4DHxlSbYXe
 4+VENkX0X2s6fOKdp+lvrs8ep28DpL6YkMMWJxerttJBcKGp9fwC9DGbMdXQW01jY2rWb9kVMVk
 mfMGxJYgYQYp2j56vU8v1PWeluG+MUoaGMUsvC0KPnaE+zIBJWMofEACrCe0e1Th9yf/4bUnNQ7
 LlEE4IFH2Pgyc7P+yb4LU03dAnUcTFGf2Z9uHbwhEoEsuDceOQv/Sacepkgx07wl8Xus/UqyytC
 net8NTlJWTXx57R35OgmGVubPJA9tTBTvqi//TkIGnk0S0H/YRcpKZcuFVmUdVGIAXNInrBEHyz
 C3ZkPyplAG58dHOTiAaaNCfpvjwdIGiGymXkG7qlf0KSQPbycwvr1K2o7JTs2lCfhZoRULRyfMQ
 Tf1KjgXhbTTdDU4LQyK8ANbGQCh+cr1vcjWRAjvplCZSiLNzKaLzDojT920P+fZhFzNal46zqTT
 GLj6OAcFcS62LEHDPhg==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7ecc39 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=miPjsMsDHGcx11BUPycA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: lyabLNGcr73uIjHZocq8IGJWNDwW-pEu
X-Proofpoint-GUID: lyabLNGcr73uIjHZocq8IGJWNDwW-pEu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX4NTuhRdBJ4Fv
 2frA07ad6OL2Mg2HifWDAnrf6aNeLBteIqEO0pex1Z0vaMi//Q0mGWdLItAJfQ0M6schloqK1uq
 VXt/i03V7Nct6wcJlVGF3ozB7T5RpCU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140061
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

So far TCG plugins can only be used when TCG is available.
Move the arm_do_plugin_vcpu_discon_cb() call within the
'if tcg_enabled' block and wrap the definition with #ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index af45234ad2a..adae2b2b8e5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8915,6 +8915,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
     }
 }
 
+#ifdef CONFIG_TCG
 void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from)
 {
     switch (cs->exception_index) {
@@ -8932,6 +8933,7 @@ void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from)
         qemu_plugin_vcpu_exception_cb(cs, from);
     }
 }
+#endif
 
 static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
 {
@@ -9677,9 +9679,9 @@ void arm_cpu_do_interrupt(CPUState *cs)
 
     if (tcg_enabled()) {
         cpu_set_interrupt(cs, CPU_INTERRUPT_EXITTB);
-    }
 
-    arm_do_plugin_vcpu_discon_cb(cs, last_pc);
+        arm_do_plugin_vcpu_discon_cb(cs, last_pc);
+    }
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.53.0


