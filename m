Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E12CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMod9-00089q-Jl; Tue, 12 May 2026 11:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMod6-00086t-Kb
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMod1-0000d2-HF
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:40 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB5MQS591897
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gNGJLVkbTbHWKUYSpa/rYAP/PeuRVSh8gnRsrqDij4A=; b=itvvMUgSDihdp07L
 o/F7RmXpoILgyY4q3qM2BH+AtdIs/oArH9iXc4s1DznMaxLYOtwscXcdngbLJu6V
 Uk2Hoqeg0wmswnFG5oYLJHOSAV70TLomaRuKNueVV+k6cajpbjGpAr3Gs5ci7g1w
 uqdfq8eCjipM3oAt2Z1YKBgzMG/H5FM90rJqpVtmkLCbhKkDsD4oeD6UwDGBxEcg
 pabnsDKDZx8uHY/V8rTgVZyijbmHAlae2VQpVketO04hrV9LMuD5L26vMNAPKDDg
 y9r+v9jOnrjovA+Tfpv+JcIKdyIdj6INnHQ9ceKOPtAnOWD49sk1sUHbV8Dr6PO9
 8MZPPQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319ryg9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee34588671so7942842eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778598153; x=1779202953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNGJLVkbTbHWKUYSpa/rYAP/PeuRVSh8gnRsrqDij4A=;
 b=jNMGBHpMvHiYAzkAlS3H6oSjjgKyR4WzTst7804YKdeWRmeNWxQE5QG8YQLtyhlK/p
 5OC/vQI97eAsixYp/DYA7mX8o1y+RlZikqVjWXiFLFJrxZh23Xu/v2YuW8BA+GauH9td
 TMl1uooSoBucOdHVBAHp6G36MHp0oo6u7UEm+j9qzIfezxXuXISWsHcCOO8DLJX21e6X
 UKbv0l1nJEjePMfkCDQKfRbBDaM0sBKEmwfX87drtfUSMVC1ii6WTBIzSxCESGsWdjfa
 GBR2b2ZfX0I+by08BBiJ2zWgzz/4oF5CQqp+tXxhFxoet2FyryXODDW1CntiIuM0yKyT
 mJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598153; x=1779202953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gNGJLVkbTbHWKUYSpa/rYAP/PeuRVSh8gnRsrqDij4A=;
 b=poIF3znldf+mhPqMJ765RzsyHDnLH3tLbW1A6QK8tKY3Kp+SgkxY89wO6ZiwK0KUb1
 ghEwxHT+x8sTgsGOiJSwAc6CTMNn614qL3xlCrRWqHMptClQli+spjv3C6aV7a1cCTBj
 bEo9pBnv/N32fdC58cNe/eBBniviBSaLmMFGyGuYRpgzH1Rujs0FlEqjclAdJyNhQHHg
 wpnQ5pg1msHL7oMNZzauVDvp6Fa3zZGfgXCViPrRwUhPJBN2W6Br3rSgDz4iOgVlRnlM
 9luJjI2X+Abaee+zx4psF7wNMubhqgGN6MaU82fRb5PxDKE34RRDDhr50f8R/V1XO0q7
 UUXw==
X-Gm-Message-State: AOJu0YwMaVWhOeNxs9ZvruZwf8AMslLacyQ1zCwLjM7PVpUL4f2m4l9h
 pLhz6ilZguEqFvFaIPJO+TsPPo1Uc4Py+HhbR1m6v9T8BVkAc/Q4OpmRuowADSRBdTNZMl/7oHx
 YT2MtuQouTPog+AYgGCoRq72LjKsQb3HGasXgv4MMKvp8LWPyr8If05fWsjAGsSVtXU+d
X-Gm-Gg: Acq92OHEqB51+u0wIe5/Y0RRlasVGPfNtsG4KiI5WsHBJ4P7h5Z1AOepCi8x07GOjae
 Mnr3mFTkrrrCGBHfPqKJtusFjRH5GlYjNRK8myxXMNcMQfESZatlsz2Hlx1J/mS6/4fRJxf/XyD
 x5mR83jOttnZI4PIKRJHaXHdb91/8H1cVyUsFU1JyIU+2wZNxz2aLXXaIBJL1JofU3zw0ldUYRO
 7RV+9DId3KtqtmPOU6OK88TrXLWjsZz2pWhJtlrOl8x1CMlLISuy261RU/f2pimNev3pdjG1KE8
 FLBTwQk1DgsKjLQQiZW5+axxFBGnyKdx1Lz7YxptTAymqNI+pTjCF45rvxOnaqoDGvDHitHDHMN
 lzU8ZGsCN3lwJZmJSdq5mS4rKQYygL4U1K6TlXGlGnzuSq10tZHJE3NqJBQqiGzllLvD7mdchqB
 4MW+jOVA==
X-Received: by 2002:a05:7301:6089:b0:2de:3022:a459 with SMTP id
 5a478bee46e88-2ffd76e8145mr1937852eec.21.1778598145961; 
 Tue, 12 May 2026 08:02:25 -0700 (PDT)
X-Received: by 2002:a05:7301:6089:b0:2de:3022:a459 with SMTP id
 5a478bee46e88-2ffd76e8145mr1937721eec.21.1778598144881; 
 Tue, 12 May 2026 08:02:24 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d429asm18270335eec.12.2026.05.12.08.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:02:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 5/5] target-info: replace target_info() in system-mode
Date: Tue, 12 May 2026 08:02:08 -0700
Message-ID: <20260512150208.1167711-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NyBTYWx0ZWRfX4mVdlVXuLL3l
 V2ZBESLUk8witrIqnengUReNds+2KdWEeLavc/kpS9PW5rqK3F4iMzDhYKYBAjipx33bT3KT0L2
 k/PSmIPhkX7MHxgP6OBy1pFgngUu9wRyVWs2cwke8aP3lUtjxsQuKg5Ks0Y0wQHu9020pU93f+I
 bbVwiXbtps9V6gu6QufZ1SfkajTckkVVoFs9EJaDduB3qGJr24whW6g2XGzDy4yPFqy5yr9EoM9
 Yl1W93cTx0/5EtpWq6Of293YgJxGhtgJaGG3TigX3M3ERaUQWCPYjx1KbMU1jwl8A21bJail7xY
 TSudpKIDMfN3beP2oQzDElnxOaxDDru1AZtTaLt8b+jRrShkXNylHvJxuwyhHVnO+1OlnE26MKe
 wquDcaOirQ39IO40F0XYiQ/YktshzCBIpfcodSwx1PBIoTrExPnCAMMu4xww5IDHoet60vu4dyl
 QFVKGjIlorG95Nq0Jbg==
X-Proofpoint-GUID: qZqzwKq1YNIo4fvRvR2_X9XHWlPtUgaS
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a03410a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Ar47GhOyGom1hrc3c0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: qZqzwKq1YNIo4fvRvR2_X9XHWlPtUgaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120157
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


