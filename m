Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5BBC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bi-0002Es-CS; Fri, 28 Aug 2026 19:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bP-0001Kh-79
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bM-0006Cu-CM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTD9i501579
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ulZ0BDaGxuX
 B9oX4K5vkbOWFmnyC0ry6YcHUyCAlRWI=; b=hb+d6AiJe6PKyoFnN/LH8s9KgZx
 oq0VKeT++YfOMvS5OPkyXVBWKW3Qilv5KhgbVatvtm9yBUSkgSs3n9yt8bAY2QeG
 w0a30vKcGP+D3q+7J6x+Md+e8mctig7RaC5MJvJT4ym0zH+osljc+XIL4SsE+mMV
 46fnBJ48t7vhJyt6AC8PTH4rz5xiv1TjYB/7yb64QBrXqjLLr3JcVDE63+BKp4Vh
 41kgvM0OeIBXSLUhlhLAEGZIBbxE1A59UW+wMf28d4RzAm6FpB6xAZE/ukBEMqyU
 zcs1Zcah+VT9Z1Yx0rNaQl3rAfgfnBOzKXx4IGqOwOS3iw8e8FOUyXLytGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgpc0h00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so24128185ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958186; x=1788562986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ulZ0BDaGxuXB9oX4K5vkbOWFmnyC0ry6YcHUyCAlRWI=;
 b=D/0HkB8pLg2JgCpczaKAYS9vMtPXKSaHORwcBU4BkrP6j3gtlPn4yiBnSM6Ucl7Ltu
 sez13gJExFvGvrzjgj4SwSeifMD8np8vjOOeNmPRLgZxwQSU2FfCTnoxap6Q6msTdJn8
 h6T4XWyFC8e0OChNHXW+gxV4frQEn9YOc+ocQ4SHd3oafZeBdcUPyKtu0Yvy//Tfr7lO
 PfX3Y8vX9rEoPkHnfJDGz6jtpH0dxIA5f2R+Zc73nK7DQB2LLI/s7DPV8XzulcgNRxqU
 Hjsy9EQNlLgrSvMVNDUWYuouEuFqZqAnqYPlcPOSDmRLm+jEszYP5/AwoESe+nyPh4Qz
 xN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958186; x=1788562986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ulZ0BDaGxuXB9oX4K5vkbOWFmnyC0ry6YcHUyCAlRWI=;
 b=Y3GCp4fi3raQUZmlr7phTQBF1UQfcD0J5YFtQaVMJlf22ZeNYGOptTh1+1Z93DUkMM
 ynDFEstJVZGB5ceXlw8aTOYxhJwQ7f7sktBEYZl6NUp4A+YLfJ6Es/TWT7BAZJu+6zvK
 sDXJvoFMzeyk4oM5KLrfsTanlPYlqgYY4fbd1SnKe3WwLmNMFHANCCf/8NRCYAIjjpfT
 fINuPEggD9sbvytl/2lDeismyueX5S0lcOteJobm+8GjRjW+VCNcc2RZIIJ4N+28saGL
 kRbzojDX3BdqY5EsyK0lpX9jutsDiY8oPBsu5utzEvgvPSQ0LoSaiwmAcNlAFH57Mih1
 3onQ==
X-Gm-Message-State: AFuF++nqeN91AROaxw9AxW7728EivZQDRF6gz6viPjsvo9YNnZ3aQdQp
 aRtgFZjuxLyW5dV/b3eLPdayULsWMBy9+0ouL+pGYuM9iNFPSISuBum5RNmMHINB3ADq0V+vpZg
 GgPl6KnEkBsyvD2a3C3RxIlyQqT+xjdWpxPBDrEH96vEn8r/aS79Ks6Q3umcpOM1i5Q==
X-Gm-Gg: AYBFou3LH54GIz9wkekNGmc9nBiBtIpxl1eTcD0Gg6sEEMcXfIxM5m9a43jFE/t6ZyV
 FOr3HKkLmJxD9ZQd1me4CA12jIrqmGhi1brWlInp9KKIxaluNNza76C1P1+zNOkFupCG1LDHoVq
 SiKsniw+wYkgZhoMYL8S0sNUjAlr9Cxpzo/v4y3IwjmTg/ROZiy+1v2AIb+NL4cSRqS8vlFzwXG
 OmQ51ZNjIBSTxBS7gMbRkZ7XLNfnyLErAKQBB28c0+fWRvvMVKWcpdo2SrX8PD+fcV2/i80Jx09
 NfCdI6p0Buq3ddaWtu8xqStnaz4oqLXAdi6L1n/W5TIICJiu32VmHe/fHHvgyFpAHXmYtAajZYl
 AGpD37VabEDnx6UQ4P9lU3g4dA7z5GqkjH5Z6yVlXHWATIsiUADRZbVv976w=
X-Received: by 2002:a17:903:124e:b0:2d8:d4ce:7e3b with SMTP id
 d9443c01a7336-2d8d4ce8378mr38887155ad.16.1787958185803; 
 Fri, 28 Aug 2026 16:03:05 -0700 (PDT)
X-Received: by 2002:a17:903:124e:b0:2d8:d4ce:7e3b with SMTP id
 d9443c01a7336-2d8d4ce8378mr38886525ad.16.1787958185352; 
 Fri, 28 Aug 2026 16:03:05 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:03:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 45/47] target-info: add target_config_cxl
Date: Fri, 28 Aug 2026 22:58:59 +0000
Message-ID: <20260828225901.367438-46-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wwaKyYqsGlD8QynFWdxnQEoQ1R23fDHp
X-Proofpoint-GUID: wwaKyYqsGlD8QynFWdxnQEoQ1R23fDHp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9ymO7PaWsBiW
 i05SaOoA0IJn18M43NX6ZY9IY1sCp8BRRc+keuCTlLknMvjzVIK77zmhm0XCOFQw1J1YvinqOLi
 mrxwYbYftTTW4xgR++0VtzDTOQ8aDKY=
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a9213aa cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Ar1EeLoZb0Qve_BY5QEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX29LkgqyeVmdg
 jIIyKxUdkZ6NkrRd5iaCjbN5xM7jdsrJE34WENjMqiy+anG2qiJkGmnh5VcIP/D4liTyQmclhPh
 8xKXNl5MdJRc3kxsD22+2MIewcmIq5jp3rS69iBgHDhFzHoy9caZoXME3XlYZchA+Znr0qcnzAD
 ty/iiN6QGYbEf1lPwNKxb6xJcwFnk0YedV23mtJgsmVgoSXkIZj0pJ7GXYmB+/tv/P7hfk8stoy
 jbDGx6Pv8krpkfmTn5KfqRtELaal0dtVK1fQm6BbhSeZugiKGO1hmBLp8YAYb4Gljuq/j370QkD
 yl/xVuivSqOqFa5hlNxPyvClMsRll9k7njm4RHAK3Wo2kW5S+KOerefjh5GOE1Bh/wQVywtoLAw
 NhuOXsqMHRCq63qPhby8HF2mMg/IyDMKvGIdL7b30VLk+gwRHVU2/SZN+D0dXsmwwfM5pf+t0ho
 r4GyLOdSCMKHj0/whGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info.h      | 7 +++++++
 target-info-def.c               | 3 +++
 target-info.c                   | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 045799a771a..cf3c967e845 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -31,6 +31,8 @@ typedef struct TargetInfo {
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
     bool page_bits_vary;
 
+    /* CONFIG_CXL */
+    bool config_cxl;
     /* CONFIG_DPCD */
     bool config_dpcd;
     /* CONFIG_MULTIPROCESS */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index e6524a8001e..38a419490b0 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -42,6 +42,13 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_config_cxl:
+ *
+ * Returns true if target defines CONFIG_CXL.
+ */
+bool target_config_cxl(void);
+
 /**
  * target_config_dpcd:
  *
diff --git a/target-info-def.c b/target-info-def.c
index 543278eb949..96ed0c7b998 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -43,6 +43,9 @@ static const TargetInfo target_info_stub = {
     .page_bits_vary = false,
     .page_bits_init = TARGET_PAGE_BITS,
 #endif
+#ifdef CONFIG_CXL
+    .config_cxl = true,
+#endif
 #ifdef CONFIG_DPCD
     .config_dpcd = true,
 #endif
diff --git a/target-info.c b/target-info.c
index 1124aa5f780..ba25112dd38 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,6 +42,11 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_config_cxl(void)
+{
+    return target_info()->config_cxl;
+}
+
 bool target_config_dpcd(void)
 {
     return target_info()->config_dpcd;
-- 
2.43.0


