Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C72CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc99-00019d-Ix; Thu, 14 May 2026 15:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8v-00018v-Ss
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8t-000279-5M
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpeN03512945
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i5YFlPNCc1XUOJGaQwvs42+bgehGmjMv50mlyGfpIps=; b=Jvo8p3fc4cMMNs24
 bcsFF0bP4FdSPgYiN73vGxjIBaKx+QihXzD4EcKBe7EKjoK30AdQaNRenefACcF2
 gD9xYDkm8qZSz8Ih1zj7MFRbDQ5VZJyw5ycrHRe18QVx0C36tKd2aYXIf4pDwIik
 AqE0S+LUxem1OnFO23VpKcnZEAy8NgWEO0QCGBTUPt6LkJFBh3xbHt34+FKgrisH
 882R9w5csJV5R3vNYrKXpLWoljC5Oo1ni19sKT4FdOTnvI2NU1KeOWlwv0DJ3bXa
 3q/S2DQ/1kpEQ/XXBFN+KSQ+y36f7pytGbT9JmhLPrnJFAa42bx+rf5h9651NCb1
 Tev+mw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1v869x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f525565b33so9886574eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788485; x=1779393285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5YFlPNCc1XUOJGaQwvs42+bgehGmjMv50mlyGfpIps=;
 b=RTrL9TEc7PSSEVJ7wUeWyk2HoefqhL5zMuVHK4dhUzMswRDXVN4dpxrqpHvtIelAFo
 T0aki1tjb7g4zHTmLifzj8mw5RNZyzoyarejiL+WbL8YyHjMHYOYKONHS1g/qnPqifck
 Bfsu8UjQId7iTDnh69ZUj5yDKsTVkfhNLhP9ljtSsXF65KqpBcTNfGb20iq21XEougo6
 fa1acuMc1A1+GpuP8BZoZkwH8Y97tYiscWoQBKvKv+6iIiZrTyimbbvb81xwo4/qr4jh
 wDflTUkM9n2DZ0Kh3tjyH8olbCKnTPik3Rz4JkK4gSnMnPhCqa9yN4AXqmkqqL7zU4UH
 LHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788485; x=1779393285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5YFlPNCc1XUOJGaQwvs42+bgehGmjMv50mlyGfpIps=;
 b=ZNtnPy9xBR6zLwqb8uEp31F+Co7wWRPKyshITC7U5eOKOrf7bzoWO3vyF1dag85eV7
 qXwUZmEFC7GzzfosiH6gFJ7fxI2F6hDAsYCOaHfdjHfKHAu19TkGCdLytO5m8FI9q1dw
 2TQruJgf0I2S0IzElk/T3JIWBqP8lspxJPx6XIjJnMzp/NfqbHZNcLQZPMkmDcJX8rCm
 heV21eodsqU/JrzgPymbqCWckUm+TffA+hctyHRt6q9IVjxweVY6Cnvf4Ygj2fcrC7va
 EjY8HonsH8+ecCn/vAqog98OcK43wWUp7fD9aQKx1Y5ZwcpNnjIgAmhHH7AEEam7gTuY
 fJjA==
X-Gm-Message-State: AOJu0YyDd9Qs1IC3lNFL31HhMrzeR85SikfYLaOfBsl+iGHKyZD4fvA+
 YUZE8f8/xZDAwq1DfEGhRqxCT3Cm5E5V7+mB7AjZXr5PjqaMHv0Y5PZoj0SKimduitB9uSsAG4K
 R5OtnX9iWBkSSMDEP2eOP6Mde4ZyEMOGljzoWpQPKxJzPSRKxEcdkstxbXvw8qUyzVC3D
X-Gm-Gg: Acq92OEnEMiDMMRE2VVs65R1oUNNJAjXmUApxLlwCwC+vaY6TwlvbSI2HSZPVDdYN+A
 R4VS8URSSufVKaml1hMbIYo6RK6707ajQAqjJg6n+d/eP9M9yRrXPisB4nw6kVqqerUhQT/0QMO
 pze4sZxG2c9UqUjIlgBxhIqd+o6iYTZEfI9E4CBgd4H2cr47ggyQvJrF/J81SwexbmpjauJ55L6
 zglC8xYydN+FQmVFq8notjQjzkSSpstNqplCccIMwyCTCKuLk2NMgwH9Qeql6SUxdthNPKtvljl
 XO07eyCQdLDXEQhtZo+DzwKXaQLjp/s9KndSEx3KG+emP/YX0Rl9/LFEo+cu35fk8Xjn2ai1TA0
 AjwVRroRmi5s7khXuSh8vCRN6Ez5+GZO0ocqdyCMrYdNdBb0zPj4c6jV3JKmuvpaFig4jvvEzRH
 3HABNSQQ==
X-Received: by 2002:a05:7300:570e:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-303986969cfmr521048eec.35.1778788485114; 
 Thu, 14 May 2026 12:54:45 -0700 (PDT)
X-Received: by 2002:a05:7300:570e:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-303986969cfmr521027eec.35.1778788484583; 
 Thu, 14 May 2026 12:54:44 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcc5asm4180636eec.22.2026.05.14.12.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:54:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 5/5] target-info: replace target_info() in system-mode
Date: Thu, 14 May 2026 12:54:27 -0700
Message-ID: <20260514195427.1706609-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX4ZWGtbBLLZg7
 fanE5DqI5r03njnDO6bI4TTYcD9kHwmirFBUAvBhD9U5eBtBNwgGtMuGFAVNuJInusgzvukV87F
 k00gK5gBZguXgtSgdoP1ZEZ60zmvncL0F0D8wTSHnDZtg4ceuryCk8UTYBnt/0JEG8KKKDbDCx9
 1liNK6oOLn8oJhPkjObHaQGIIMDC4SV/9Hes1DBvG+vNVZxJq5aC31FGxtZEVfqOs7RWjb6kymk
 DBA8C9l1NoRhLMPSY7bwJov793em4WAzqJMNYMYYAmooPVdOAS8bw5aBsGzmsiXGumxa7r4W+1y
 YEt39fMCeoXIzlyNyJVg3YeJtriwjbZmlc5fPRsvUnuMhP5pTYh+En6bDIsjCROd0AMlX4VDAoE
 yMqsUAasDcej9kBEt0tgaceZQJKfnF2GYB89HeBtjshC4Sm1ygyVp+DEFhjXoPGvxkBwbFrpdYy
 5+B81SMzU5HWgM8OlyA==
X-Proofpoint-GUID: R_C15NCbToesW5J1UOFmVaXCtEBIDWcI
X-Proofpoint-ORIG-GUID: R_C15NCbToesW5J1UOFmVaXCtEBIDWcI
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a062886 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=MSIEXOgWn6CInn48Bo0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260514172303.1484273-6-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 5 -----
 target-info-qom.c               | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 32c323a7ef9..b7024c9faef 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -38,11 +38,6 @@ const TargetInfo *target_info(void)     \
 #include "qom/object.h"
 
 #define target_info_init(ti_var)                                            \
-const TargetInfo *target_info(void)                                         \
-{                                                                           \
-    return &ti_var;                                                         \
-}                                                                           \
-                                                                            \
 static const TypeInfo target_info_qom_target_type_info = {                  \
     .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
     .parent = TYPE_TARGET_INFO,                                             \
diff --git a/target-info-qom.c b/target-info-qom.c
index 9947fcc9922..b48714cc77f 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -49,6 +49,11 @@ DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
 
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


