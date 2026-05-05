Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A45CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOZF-0006Qn-Gs; Tue, 05 May 2026 18:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZC-0006Ph-Sn
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZB-0006Ab-FS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645KMq303187611
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5a9a6kWz7AaL1uWn7ELkEIPMK/peDJVgH4gBGXaMfws=; b=hlkM8Rvv029N3910
 88DTwOU+Ym02X7du1bykU4LdC8Er8hQ08MeekcqbSSYDDNBBDosmtTq93qRz9w35
 XNXi23clO8xQ4WduKiNN6/lpQwouQ1Ih5Of5gfT0dWZR1lUj9b3rVRwZ9cTTy63E
 rUEQW1a9Bo+W02Dmagp7oPeHmVyp1endtrv/gTRH7DsxzKc4xvCDXUYZLHlgAN2m
 ZqxzeAIPZQggs7kEDuR48JfpeWmoPuqKhPtygNogYIRdnkp4tF4eZBk29bMtv9Bu
 K1/Cv+H/SHQeNy1kPFlmvi97PRkGWWZ2N1edDXMW9LLnsuj8hdbVunXylTnk0vQS
 vff2Rg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkbm5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:48:36 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12dfe9c058eso1486229c88.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021315; x=1778626115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5a9a6kWz7AaL1uWn7ELkEIPMK/peDJVgH4gBGXaMfws=;
 b=C6Ft0613LM/XuSn+bdCsPbm5KlKLja+MlpP7xts0mf+inLemSKu2DPkMV2vlHppqrq
 FGr2JA877HQpt1fN35IplX92NpFUQzssp2MRCLfstA9kMUgSAVyT5FJ78cZtYivu+q7D
 bmpD0rfedSMlEB7hko1QN4cI8GpGPOi0A7RK/JmiKFmixFOxreyJmk9m18TDHcMfZV1e
 fEYFJ+34CsM30Q9RDKv72+AAu5HOzBN5pZQiWy37jnXnYocFm/0fIJYPcDiRFF70ohME
 PbDErX8GNnvUFwl/2LeLJDMWnxWUmK4/xRGW5PgToCv2yqmMine7RR1QTFm5uAaep0OF
 u5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021315; x=1778626115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5a9a6kWz7AaL1uWn7ELkEIPMK/peDJVgH4gBGXaMfws=;
 b=JpZvbOsv9lu5JzXQ/ykQgK2D9LBZSBUOGs01LeiN54YRwCOHrGL09RsYo2ULE/iLdO
 hVk4XG+9T4PDptEZbL0XUG9bc7DefRDZ/8ugEmqCalE05eFcy+bxDLGnL4ljkPMurw3S
 K5PPd3fBocX6HHL3O1ZJrrPp0CcZqok5TokGp3JfS5UqL/zf1gCpYzzHz0YYq3wivJ8a
 UkFNNmyvNOL5SAaDbL4XW6wServHEwDKU6SIKQZpfiiildiWHJNMxCgrVQubiU6E/IjV
 SKYRwvM2p+rPmdflSPPbWAbqlu4feGjr+v/951sUW8b95ueeYs2mA7rTiniJ4XNlr6kS
 iOpw==
X-Gm-Message-State: AOJu0Ywq751bO75MazOHh0JQHqIkCDn551jHB5GYuy7Awv/nNJaZS14O
 o1V3bZ9KsWrTI7/y3sNRPAL38RJFMlJrPWnCjwN9L/cjq68DXGomVWJ1TOMkqtJvFrjH7vjrHQ3
 vilM9eE4hNaGQrYJzvmCMBgkJddzZOl5klOllVZ79tdhwZYwXxLP3DJaIn24MWuGrTXh2
X-Gm-Gg: AeBDiesGUGKkbY0Fsm5VW60o7Jw/hfDbVOpFsZTIOZuKWgEnv6JGwQWXjRiDg6DCx+9
 JSCmnsmgPmChy9E9FuRwUw2/WCUFehSVYpK4owwW9ykjqNVPHfJY+astHkiH6GeS1Tm6cWuO5ML
 zIXhl90j1lPvPDEF9t/bwl/X7VKCOJb0b3e9CSIIPEO0B4ZbZR5m/NIGCRk0ODK8HE3pwmSqfnN
 hIU4PQewdDXddxUmmXfL5OAvbwpNxYvfU2tzvjZjWvfVF7b0xKILmYpe2kpFqgyC9/RrNUobBmq
 dkFuYwSARJOo66GYjQsV1oPBKgj4ug+5LRX4j0xQc2E9Z4gxGD47fqEfHGJiNb4KpKbzPfDNEyN
 w7gjUFnktNImIDx1tRZcWe3AxyykMyROlF58j7tsinpOrf6c/KOMTsX9+OFrfX7VbZramHmzneO
 Oy7ehKNHS8tqTxOyp79tXvS/t9qh4=
X-Received: by 2002:a05:7022:1e10:b0:12b:ec67:3523 with SMTP id
 a92af1059eb24-1317d89653emr667911c88.9.1778021315049; 
 Tue, 05 May 2026 15:48:35 -0700 (PDT)
X-Received: by 2002:a05:7022:1e10:b0:12b:ec67:3523 with SMTP id
 a92af1059eb24-1317d89653emr667896c88.9.1778021314527; 
 Tue, 05 May 2026 15:48:34 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d4cf2fdsm898953eec.8.2026.05.05.15.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:48:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 6/6] target-info: replace target_info() in system-mode
Date: Tue,  5 May 2026 15:48:26 -0700
Message-ID: <20260505224826.2698753-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX/ZKCMSvPEfQK
 QtkcRYAVMZMQqsYt2bLC6y4Sk+C/1/rlBic9UBSql5Ze/WgPQEE1jEJRaZLcdczEEI4CWmimGO/
 +b4r9CQ9JGu46SBRmySj7VJGgFYF3hPZaBaK1ZKXhE9NLGAblkAvLlQ2Cy7CIaoxKqa4Lbvcuqr
 yaqsaK0pQacCWSYOJCkTN4Vtw4kaZXaXwGWnEIJdpUzg39Q+WfBzEigSLXn8YtLfHdqEOtEJNYv
 UVdWCsoqW1kC3fvy7Rv1vEWLfXKVXEvfDW2sKzUpTWiWRa3u2RRd6JLVYTD33uAjSJCT5wzfBPz
 Mwb5nzsMs5qkOijP3H3qzYWZ/KEE749BkB5CN2Nz1Hb3njdvrEEsNMoCz/hoow5l1mRN4A17Cug
 YvMu1GVtUCuZNCmludwt1jrZEtZBm1D0FBMgMRh6yKnAWs7YYhfzSdK5CsWdtZu6cPoUGK2sQik
 oryJsw2vbIJQpJFUXMw==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa73c4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Ar47GhOyGom1hrc3c0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: V0uj-BP7aW6EeXxNpmq6Kwch2NpPGdlt
X-Proofpoint-ORIG-GUID: V0uj-BP7aW6EeXxNpmq6Kwch2NpPGdlt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050222
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


