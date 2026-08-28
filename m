Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2CEC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Y6-0000Vr-Di; Fri, 28 Aug 2026 18:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y2-0000U6-VH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y1-0005mP-DP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTSqw015055
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wls98yMWpMi
 a7sv8dZIcd0gN2kib0AC6hRDwMkJ0sHg=; b=b+Ivc85xCbIeP604Ksx0UE0FAnI
 a6LuGOU9ScS/d5j8q9dkP0fT1wMjhJ8tBdJurSa4Lo/onowmsBd+Yg4wXSYjuAHW
 jWbw02/H4C8V8bWlWCB/NIw1XoooRbpczuCu8PukzILe9ESYhIVZ0coYkbPH7uRE
 4eHkHFQUkf2qdC/kWHqBQty4MUzxgXMz6mB1lzFmM1r8b9Oet6L2qgPzyUA45umx
 tc9ASos/xal7CRJfTgEhTriH4KrJwhtWe6Fo91CtMc2NmaKq1Z7E3vc5eqKXqY0d
 F35k/Z7Iifr5jBbjOdkimNNDOaSt6+WOKe46rTl7HWKKPsEtepxp8I8Pvwg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgvfgf4k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso26393185ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957983; x=1788562783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wls98yMWpMia7sv8dZIcd0gN2kib0AC6hRDwMkJ0sHg=;
 b=aUhOneNZb13XLHFmXeEC9MXZPwWA9xuWLPI4ID/XzhEdzqbmIomldtTqJQYnUSD6Yj
 OTUoRGheCEy4jewiSvGPAX14k0Xw+6JHB7hxfbk5FvA1fCngS9vjXLQRNsWY33+SMUID
 V5FDut9nfdS5z2LCUUvyPWWjE3eTVxsCZo2lEeqCwXpC8Ilk2tQt6ZG0HoGvQM/Na7gQ
 NxhK1RPxjiEcV/tegdEaY0v2E3AUwRx5FnjA5vNm3JigZq1GEKRljNuD3E08Lx8C80rb
 pu4f56RpQZoalMr2I8K3tEX5aY1QehJdhCXWfNlV6PAf9RwSNTRtcHA7a8I5sqFnC45c
 jgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957983; x=1788562783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wls98yMWpMia7sv8dZIcd0gN2kib0AC6hRDwMkJ0sHg=;
 b=FT+wCMEPEB0wupZXsKMB9q8p9KubJ8o7csKqDp7tuMqbxSONpz3wzwUiCHWaCeDrhE
 4zLAbrrLlMOFLGzYwcF851IvNLVpeSKAW3halFHJH+IlRpsR4zYj5gdi479C1Wi5SSoo
 Yjo0StEFS85o0pD9pqzpii8ZC1VpoQ/+m6/W7nmV322DrL4E2otn8lJftWyWeijrLpy+
 f7mQzbKmJRcol9ScsV1XRMIGNH2RbuUqdrXyB87yN1meaU3DcpcGNXmDQBwVKEvyZkEd
 9/0VsKglHoU9u+mM62qrsO/mrnNjzMSDlSsEtlr0eZQ7EXE7kbsExozU3gSebqhBrWmj
 hQNg==
X-Gm-Message-State: AFuF++mUg3IXzyHffY3UHlt/xz5xCNfzauYO7uMpYzc2WQEqxY1nGDrp
 cZiyq9vOIgqtjlYI1GXAOt3Nnn+Vjf5FQveGvCOobaFPrYXEq8G7OJRy19UpYwbvHqqP9pZz+WP
 2TN5Tx75JHYCMuyxGFFsJoWEJDr++5/llVAmJJ/6TVJSxyvniMY3xJ3ilEaP3A9SY/A==
X-Gm-Gg: AYBFou0NCCoUJrbun7Q5jS8atK+IkKO2Wt7tROVSkFi/QsB26ySXXekMeUheYS2bkjn
 vS4pAwLoD1XpwRp7vkXqnT6OZLU/VrnEzvV9K94vNvt2DX34oCIfS/iw75VY8SRT63eqonWp4+5
 aeqkJWzumMWs2ZRFYPdYkgtwpq1WPbmRImnVoF9DGy2tL0Y1LIz1lXwJN3AQu/xu7C5Uv+6kr2U
 YfiKvthjCQdYk1SQp38c9PHgQ5nlJVpJ0Lnz0wYeZZgpdvrWeCFMa3UxhM+8a5IhJopqx3tJWFc
 JOn1EYCQQ/+gauXivDLkgcnFjAzxxLK3dlAFmLzylqoEZ/W9w/GjeMYIC2MJKwrVQccS7IgdxOb
 Vjafs+3i5dXbKFigW7Ui5zfCSl4lNu03juZsbvXHOEwVWQHrYxkY+YWqxXb0=
X-Received: by 2002:a17:90b:2e4b:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-396d0d7b9bdmr18476299a91.6.1787957983553; 
 Fri, 28 Aug 2026 15:59:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2e4b:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-396d0d7b9bdmr18476270a91.6.1787957983170; 
 Fri, 28 Aug 2026 15:59:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 28/47] target-info: add target_config_dpcd
Date: Fri, 28 Aug 2026 22:58:42 +0000
Message-ID: <20260828225901.367438-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX71/7M+QM3AsD
 D4CEP26LpKZz/O+2T0tg0wYm4kOPxtjU4pF8SMCDbzW/8JaY1B4LaK4Sac7rHvqX3s/SBDTQ6zC
 hVdMwWnh2+IusNI54Awl+rObNPVrJUQfHNFouQFGpOUzBH8doU/29RmI9bj5zo/WdS7Zj+qsRKr
 n0/XIcw7EN5hkCAeh5QIjZp9vg7fzwWhKFndaBc/Z6zfNWpJzpT0OUeJlDq9Ej5a4PrStwb9stt
 rc85jCcsyqJ7TdhCN63Wh8wrSah1FttmO27NHMCfI6XOhpL3Nb032jqbSLMjUnTLiTsJOlfLN25
 2tbzi0Nn1GD5WIFnO1LZSSg90/VrQC1MyO60IFLdJLywxcHXphMpJaV5zZ84go7KUQWtFYQv9YK
 KNR5oCFvY4ivt/pWwyh9L+LAb0if5VTqso3mr1wSjwo08K6H/vG0x3FdeOMt2UZxKeQm7xHTf5b
 jCXQK0gvtjPCyeXMRFQ==
X-Proofpoint-ORIG-GUID: loXfy4j0rP6R8Z3hVVBcuibqJcuTYrEW
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=6a9212e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Ar1EeLoZb0Qve_BY5QEA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzvC8vY0CcnQE
 5EOqdFigrRVZJvNwHXL5Tp1UgY4YiZpIHr/2mk8RBmbEQcpWV2vxs/wCuBs0S24qv0d3gddXjnX
 xBTlteiHD4La52b3ukHkjOeRVOPT8nY=
X-Proofpoint-GUID: loXfy4j0rP6R8Z3hVVBcuibqJcuTYrEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
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
index 4f6c898c707..045799a771a 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -31,6 +31,8 @@ typedef struct TargetInfo {
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
     bool page_bits_vary;
 
+    /* CONFIG_DPCD */
+    bool config_dpcd;
     /* CONFIG_MULTIPROCESS */
     bool config_multiprocess;
     /* CONFIG_NITRO */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index d775c94d1e3..a60751a4ef6 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -42,6 +42,13 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_config_dpcd:
+ *
+ * Returns true if target defines CONFIG_DPCD.
+ */
+bool target_config_dpcd(void);
+
 /**
  * target_config_multiprocess:
  *
diff --git a/target-info-def.c b/target-info-def.c
index 96fd1f8c73d..543278eb949 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -43,6 +43,9 @@ static const TargetInfo target_info_stub = {
     .page_bits_vary = false,
     .page_bits_init = TARGET_PAGE_BITS,
 #endif
+#ifdef CONFIG_DPCD
+    .config_dpcd = true,
+#endif
 #ifdef CONFIG_MULTIPROCESS
     .config_multiprocess = true,
 #endif
diff --git a/target-info.c b/target-info.c
index 67127da16fe..8e9f1823dc0 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,6 +42,11 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_config_dpcd(void)
+{
+    return target_info()->config_dpcd;
+}
+
 bool target_config_multiprocess(void)
 {
     return target_info()->config_multiprocess;
-- 
2.43.0


