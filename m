Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963CDFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIrx-0005c4-2S; Thu, 30 Apr 2026 00:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIrw-0005bq-9g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:19:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIru-0001MK-Oi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:19:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TNvTVF3733909
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5a9a6kWz7AaL1uWn7ELkEIPMK/peDJVgH4gBGXaMfws=; b=YFN0ArWp84iqA27H
 YqXQFifR16EA5nrufD+xykhR60lSRt80IfsjWIrt1MJ3saljfwsvIahjbJheNjeb
 /IgtnOf5z5HHxLzFt1Y7AiIQmPJ6bRs8QBZlhE4x2T5xUVePyYO9a5UQmH1SOBDN
 iY6cV/zVTsdR/xyS2yHNLUHQiGxmnvG+cgsK+NFzv/t5MgAG4mv5FGQlkiXxcAWl
 Inz1/B2FZBqXVIdG0mNZicdDIV6nWEpsd8bopLW4Uhw+ooGoLCM7HJ8wQLGNWbqL
 RKCbBZSYFWUtJU7WB09IS3QXdVVZnLcc7UDOw14imbBfNM2mJ+uSjKTNbWFBH3nG
 TFC2kg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3x8p5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:40 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c8ccc7593so773851c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521399; x=1778126199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5a9a6kWz7AaL1uWn7ELkEIPMK/peDJVgH4gBGXaMfws=;
 b=btQPKe9ldMgHZo0MMIICNo9gbnWaF1KuT5zaj6JvjOm1CvEc5CYc8NYn3W4OBarx0a
 ciUobwxHq2LNy+MkbDMUwnKD9AfW86SSbccXFf05uvpPGBoboBsrxxCR9pWHvA/GJjo+
 FevNgrUqVF78nLRhRr5JaI5hBDy+eQN42cEwhjGFfcnr63Gn0BHrE62sT9m5iy5Y3V/J
 XXMKRFZ6UEQNFu+emsxDTH4TguIpkS9+/aUIDv63xGWGjQcq/C1XMlOS37ZRuRwz8s8u
 tOayhY0S0BJXMqh5c6isb+18LaezXDZASEdwYuK5deRB5wIOTMhfr6L2a9P2LxWjtkIZ
 36zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521399; x=1778126199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5a9a6kWz7AaL1uWn7ELkEIPMK/peDJVgH4gBGXaMfws=;
 b=lKyWk+/oQmh6EBQg8z+nJsYoWrk9r3M0S1+7Gs0rTm/ToTzcx+qTwTZ9crrbmXQUe6
 Yd6w5k2RIMhv1oFqUkQq64IldPx0mIC5FGg8odCLB/CayLnU29ESWbSNWcbBWz6cF5zI
 Xv92KCrJ/v0RVs1Ww7OxbOLFhJsnqMC4U964UEsePDh+KY/eeyi34UUNeYpdmjUrbvMw
 6p/FRGZJNdq3q4BbYs77CyktZQy9M919SSdKLixt8J35SVXXDAA5yEfDZrNJ3OgU9jev
 bRYudyawQra9TxMB0Wc3ozkLRl/X0W2w7piPaz/DMSpvJB9aYYho10GZvgkwpS+ve2gx
 Dd9A==
X-Gm-Message-State: AOJu0YzAuWkkUGzief7qpET2CZoUXsOZnuqDpW2d1cRk4/i0W8jr74DX
 jstkA30xHZc37qAnfd6yJZZfuATmT/YDLZlAQOHpg8wZ3o8EtsHG+8OaBCQwICwLW4a11t7OQfl
 70MNDBCC1VQId1xit+U1bu97cVPaPdU6I0WXYPCdAdFpqKv7KCmYYctTl9ehGtJwKIbCt
X-Gm-Gg: AeBDiesxt08VbFODnX+oHO3o2wPuupsDPoisfM3diAgHXjq2xnCUeoUmK2lCVgNfjw5
 CV5Jr1f9RY0sCQqNjk0cCGd7N0pw6+GMDoNFT5a+sPJ3VW0IegiFRT6BMjOOawLZb2GuZ6jJ42y
 z5a9mvdHG3AoT1k81aANkFSJCLVCDE2y+qflrMkj0Dec5+rQhLZVL5Vhs/32vrwR0nw/idq0XOH
 kFTks8yPqThsSIM3jkhZSg5QCjRcj0TC0zifeXHHed62hkRP8A5ychNdq93KShey3A1PJSA0ugb
 T1JEZxJVvKw4wrYqbUlOCVS6tKp9UrJ8eQBVbDhoIErMtoAcAWKuZZaXDTIobY9aF4ZgoMIZiS1
 j2x/vh7OVxSCw1DuxCwQHNhWyYL2f005NpwK/lkS2Af4gUmdSjkThy5qjAOwkZC9TNH79zZ9pw0
 DFb8V8ppilxhfLytxw
X-Received: by 2002:a05:7022:213:b0:12d:d27f:d817 with SMTP id
 a92af1059eb24-12deac77ba3mr615800c88.19.1777521399250; 
 Wed, 29 Apr 2026 20:56:39 -0700 (PDT)
X-Received: by 2002:a05:7022:213:b0:12d:d27f:d817 with SMTP id
 a92af1059eb24-12deac77ba3mr615790c88.19.1777521398726; 
 Wed, 29 Apr 2026 20:56:38 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 7/7] target-info: replace target_info() in system-mode
Date: Wed, 29 Apr 2026 20:56:26 -0700
Message-ID: <20260430035626.3511676-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfX8qAXX4eiE+iv
 qdikZPyBZRNQ2UU+kXWJudQ373TsMJ176qIflOvra+RXSe8HDUhD+ZsZBpxtqlL6OasGCpDyXMa
 bSx+v2DhizQrTBpIdZV+UIhfnOlR1JB3zGlgMAWSrLpXsIym3rg/nPyg5ZyED+cOYXAUyPT6xgv
 L8iulz5DVTHzGigF8dpi/QFL8oXs6kZWjh5lJcSyoX8rCKIC6dBIYh3NSdaU0UGwSwGFN718qXs
 KOwHkTCWKRZGWpuotFP+JQvqT3n6BByqpoDfx+gWxV+I/Y7xP93XsWjVW76aQnVnHnK3oJrl61W
 d9uWKZ+K9HI3PMB1CfFpIILnqL+rh8GjXuQo9awn0Pk5IbrdvoyE3WjiF4q/5vp32OY9aRwFyog
 Cu/Ty5iaNmNs1w/8J0ghOXAXhZUOcsFVjm1XKYS6SFZjcL3iUb6tdGZmMSflQiYm89rgRV2zIaY
 nCpucLMZjHUstHLmPwQ==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=69f2d2f8 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Ar47GhOyGom1hrc3c0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: fuqpb1rjZzl6tHc5IbFMnkIc0ECCEIhi
X-Proofpoint-ORIG-GUID: fuqpb1rjZzl6tHc5IbFMnkIc0ECCEIhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300036
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

We now can use TargetInfo information available from QOM, and remove
duplicated target_info() symbol.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 5 -----
 target-info-qom.c               | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 859451c672e..a9efd8a1e40 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -50,11 +50,6 @@ typedef struct TargetInfoQomTargetClass {
 OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
 
 #define target_info_init(ti_var)                                            \
-const TargetInfo *target_info(void)                                         \
-{                                                                           \
-    return &ti_var;                                                         \
-}                                                                           \
-                                                                            \
 static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
 {                                                                           \
     TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
diff --git a/target-info-qom.c b/target-info-qom.c
index 9d1f50ffcab..cc470b3b4d6 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -39,6 +39,11 @@ DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
 
 static const TargetInfo *target_info_ptr;
 
+const TargetInfo *target_info(void)
+{
+    return target_info_ptr;
+}
+
 void target_info_qom_set_target(void)
 {
     g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-- 
2.43.0


