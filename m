Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88DBC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YR-0001Gu-Tl; Fri, 28 Aug 2026 19:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YA-0000cX-1L
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y8-0005lz-52
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTWfU145605
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LpXMs4Y1UTs
 e6ZM8IlAlfVIcSYQepW7d5n/cp6sjuT4=; b=dM2GrpSnZr9AOaeDYcf+qiw7CPx
 4sNHR5XjvKzEeZwRTP9toflsp9A7sZl+M9mStvYuu+Y2Aa+0TYpvzKf2KUnjl6I2
 CFwJSVHhen1hSete/RlvJpzLSFGcBmzrbCu3G7W3VWaevr0oysKJMa7HK7ugJmyZ
 fy7fMAGQxz/KqlAkozBM0ZIGQf31Sb0UGlK4R9N4XflF09yXjvWTR9YKwPu30vQV
 CRo8KSG/+rEhozwDrbT6Hx8lolzkl+APjI82lLxXndJhv/FAN1CTwNKXL4N49Yo4
 DYG9JtNEuZqQBC9Qi/ealRxfqbM32p4PiWWBGwKqoZbqkz+mRJWBJ/hOOdQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2s3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc18ced1a5aso3215280a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957980; x=1788562780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LpXMs4Y1UTse6ZM8IlAlfVIcSYQepW7d5n/cp6sjuT4=;
 b=KuUBoGGg5GyOmRQCA7qm9wcp80SSBMBbclja50j9zQQaAts7res5pIx4ylvpSJtLnt
 A6bPPvwB9sVCfvfAMkjioNk7lfrc80kVyRB3pTSm1z5ieO+8iZLKV6n+i71nIMGVJcWL
 nPqn4J+7AaeBYHGzpS5LuFitx6r/XacUHBYzLSJnFYOVBnj5En7kCsK5SGAo/7aUQR76
 6kT//cSCzKjMTuonwQYINRvuX6wG0IkABuAPyvg3tDqXTE1F0nntkdVQ9DGwCwHYatL8
 uPZMCw0VGDVVhoA+KmamwYPrQ17k2vq1g8YH0yQAztKGzq5pXTQ/gJtXZy8gvFiwr+sr
 Lufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957980; x=1788562780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LpXMs4Y1UTse6ZM8IlAlfVIcSYQepW7d5n/cp6sjuT4=;
 b=YDaSxDuVIwJeLFHUv8iRfaMlycWvRtlYKsGLK4JDE8xbWXgeJY4MHSlflKd1eUkQGv
 vf2FinvUpxEEJYv7zy2/K4ycrxZOoVvV3kP60pr6UL4ttFpr5XDmzTU5RYPToI7WDqhH
 EuklnPSQ6XMHXBbDrh3N+540D5gm7cfUgwN1EqJoqVgM6cgmL1igEh8ouAufozzRSzhQ
 M+sPLq47ps4A99thYbzpgw4BhMbhlPNeQqXNOB/+5/pLquxFGusBP6l6IUDBwY5+23Dc
 NMNqkpcXKNJkTcuIYHVWQkLv2gv4gs9wsQ50lMsw2NQLzH51rb0kzIUTV2VdUJRv4O1a
 LY3A==
X-Gm-Message-State: AFuF++mrACifLVg55PzKFwD5MAneP9eftTLzwYpuuyG0cQj64COZHZip
 253R1RjxWFV+wd85DcZNVf85K6D17Azviv1XWdwneFfAx/x4VfrDS2KqQCDJkj7O5YTwUkWerfu
 qcH8JM09KipeV+7EUcmQcxkPy0ArlkYbKSP1JQwVHPRMPNzu7BGmCpSLsB6zdLufTQA==
X-Gm-Gg: AR+sD10vfNccy/X8X2ypzq0DPvvTuwU7bb/bkjpvJIjH3ipXOmicMmI82KbYtevzWp7
 XAISjp3Yyh8HXVOrLT1EBbLrZ6JKQ5cNCCPlJy7sYc1edw39m6lcXbzrQiOODnNyBevrcAUhMXP
 S7D4ug96UtziXraz3zFOcpv8C8dTR6ERkzEt7BQjDFYR0dflEndN+5IY7OQXw3G9Ev16kXOM2C3
 oqJsIvnqoplhb3DMQh3gjZNMA/22QMqmLikVfizvSWIwdkPjHEPAgFT0WZzCp406jvDIGC2S4ry
 eO8FAQojXweO56CDOiskiWiHkWKJeiZmlJPXWkT0bcun0hUH9pLyNcdkJJsAp27trp+mf3tFN1f
 cXZlyzJ4/hNObAZTrmmE+EYvq6MsCJ9B69m7AsgAIv96sy3J5wjrLIW/T0Ac=
X-Received: by 2002:a05:6a21:3482:b0:3c3:bbe6:95c7 with SMTP id
 adf61e73a8af0-3d267f817cfmr22407261637.17.1787957980020; 
 Fri, 28 Aug 2026 15:59:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:3482:b0:3c3:bbe6:95c7 with SMTP id
 adf61e73a8af0-3d267f817cfmr22407216637.17.1787957979690; 
 Fri, 28 Aug 2026 15:59:39 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 25/47] target-info: add target_config_nitro
Date: Fri, 28 Aug 2026 22:58:39 +0000
Message-ID: <20260828225901.367438-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uky0oNDYMr7SMQv10qcMKT6ngNDZOjer
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX1PpP6myDpRQf
 PN6BoidI+e3V9Cf+3PjsqCcYesqfYwX633zuwCXMDYZQ1h+OvD9+r1ep9itQB4CNcfDTjo8HWGr
 9O26KCBVqkmGncPYRY/DTe1EMomwuMzrd9h0tY36gvq+N8ns1wiKlx1xiO8FhWHd3T5YL7pfEIt
 OhvJEZEeg8dVfB216Ik43sEyRc3ma6zAcGgO39cARvYk9YKDg2akz/FC+zsy8sElTB956b3pSpZ
 tF646K4+CkiCYrtsUZ/G/usV1iheVJjGSwEroCVmMkmBZW2FZFOPIINxkw4dNhYtYyz8GiZWMl9
 9PskDcfuhhEK0dVFCXrSP3N3Ktge7nZYHdGzIzT6e9h3Q6hK2wgIAuWb4pyIWEoJcr+Hj53sieY
 6c+7jTe2cBx/E++Rn+xkDsazxIU68vNSVsP1soFeOmVQTABPLip8/5tCakJpQhdqPsMe7HFpdEh
 BF2ygbUH41rdX8R4DOQ==
X-Proofpoint-ORIG-GUID: uky0oNDYMr7SMQv10qcMKT6ngNDZOjer
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXzwTWCKHivCYL
 Ei7wYnlWOgf7DBYC2E74D/kXU9xAcuniSh5l3+QeoxtcIODCay26KNtgjN8kJD1+0tvpMWlkDnA
 CCr6P3BUUhym1kfHUyyfEfEsp6hNNv8=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9212dc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=WWn8s1WKSOYfKZCqbf8A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info.h      | 7 +++++++
 target-info-def.c               | 3 +++
 target-info.c                   | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index dbd7a5a2071..4f6c898c707 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -33,6 +33,8 @@ typedef struct TargetInfo {
 
     /* CONFIG_MULTIPROCESS */
     bool config_multiprocess;
+    /* CONFIG_NITRO */
+    bool config_nitro;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 579c43332fb..d775c94d1e3 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -49,6 +49,13 @@ bool target_big_endian(void);
  */
 bool target_config_multiprocess(void);
 
+/**
+ * target_config_nitro:
+ *
+ * Returns true if target defines CONFIG_NITRO.
+ */
+bool target_config_nitro(void);
+
 /**
  * target_base_arm:
  *
diff --git a/target-info-def.c b/target-info-def.c
index 9d51371f766..96fd1f8c73d 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -46,6 +46,9 @@ static const TargetInfo target_info_stub = {
 #ifdef CONFIG_MULTIPROCESS
     .config_multiprocess = true,
 #endif
+#ifdef CONFIG_NITRO
+    .config_nitro = true,
+#endif
 };
 
 target_info_init(target_info_stub)
diff --git a/target-info.c b/target-info.c
index 5db2a6049ac..67127da16fe 100644
--- a/target-info.c
+++ b/target-info.c
@@ -47,6 +47,11 @@ bool target_config_multiprocess(void)
     return target_info()->config_multiprocess;
 }
 
+bool target_config_nitro(void)
+{
+    return target_info()->config_nitro;
+}
+
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-- 
2.43.0


