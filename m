Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7772CD37AC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLVyq-0000ft-5X; Fri, 08 May 2026 20:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyP-0000Ti-8m
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyN-0005yH-HE
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648GUAY5145934
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uUvbFm9GvC7wGL+IB/qHUcJ5ur8KbOvk71g6ve35TUc=; b=gVt6JriDb+hR6q0l
 Lu1au81NEJ8Ys/U7R2mJNyoFOMiOXLBPp3Iw3LrQXgwYtHwcrY5ItqucbKNW41CD
 IK5venFUdboBn+alKwOH5rwKN9zClWXOGqi96E+MugDNf5NPFGF8HpOFlRqQ5g93
 5cXbbiXqkEHfefkt0Oy3YMPeDuBeMiCQSSlUT7/wKaDh7pguUtcqt6PbCpuh9EpS
 YFBADp9R4nXrNiagVlHf4nE1Tz9tJN0QbIDl0HeHER1XcG25QrT4Bel1JFETDYBI
 zCFgrbPNx6jM1yHCvGyexVs75dOAiEDiLZBV+KefGJtwuubogZ9/L37NpFoh5ix8
 uxLvHg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1kdc1bww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:55:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so395973eec.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288113; x=1778892913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUvbFm9GvC7wGL+IB/qHUcJ5ur8KbOvk71g6ve35TUc=;
 b=V4TNI8+17SLBQn/DxDo8DEEteb9FItl3xKCS5nnhBV0zIoWloQ2LFajoJmspNl5GEn
 PyGTlkww5pPm1APq4wysCVBsAfQgdVy2D14/u9v+5CbaO/gxvK0lYWt63AmqBvXna4pw
 rGZBvdZmYXCg04M5VuXmfs887dRv1VmLXESDIWCF6pTZj83es40bUlQg1xxy4R0aDjLE
 z4Su+tMlEswt9VUEYO0bjEDgo9zYOzTICbMlYFkJZ2tFr3FmGKOKbmJKkwd7B8ivE+8n
 WBtgrW68BcC8D/2HWYXnbeyzgn4rcd4DRKHA2hlLSRkxgzAyKZTwtwvCxol8gcgGd+eh
 RaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288113; x=1778892913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUvbFm9GvC7wGL+IB/qHUcJ5ur8KbOvk71g6ve35TUc=;
 b=d8vUfALFrCHOZSrE2qkDu5Jxz7UcBXk3PGTBqBMeG8UYaI+vBf9DPYBK8Yuzh0SjlR
 sOHPJ3VlnEqj1+IvSIgmwdEB4+B6tLPzhAiyQboQ5V+7FAJtVvjatUnaiKp8bSOsWmni
 PfQsrprjrSHLtv0K5LAYDNTW9WbyNYU4I2K+otKDxUoNAkywgpKlMHBMFk3c1f7/Ixap
 cyMKmNWofa355Vs2Z6W2epRL4CRs6zBK+ryQFTUmhaYjsx3S2HQa+Tq4YSC1Uxdl6M9M
 umtA6kUstlyt7zttQCeTPVlw+oARj4TKmUYz5nW1SoLCWjh5AKDnJoUcNGaqJgr31BPX
 4y1A==
X-Gm-Message-State: AOJu0YzEewDjIX02RNFjyn/fiRdKpLT5MCVOvTlYXie48DtPAnmaDHEE
 5tI8LQJ8hZrFN215rkVsk+SWfabUukvihVzvK+2sagTFALOCAPBDf+c31T99TWTA2jWwoeGW/20
 Bs4HafSG8nYZSlLLm1SwTjWEccmbq3PjtJUb6mvzCZm3cm7Q6yeuNJqpx0hFUnAPW/8Nu
X-Gm-Gg: Acq92OEKMb0SGrEC7pyROANEwaor/ySlv6HnO9yzcMAKuI63DCRgy0zDiLfX+h+WthM
 ibrD/SJNpn5c74QV5rVTxkYIOxxtHZLkK4N6Dcezy2FnD0+jptdK5F4STsXS5Sv4/6FBivOge39
 fBkcC0/W7TX/4h9qLcyml7CdfaYjzjQU2s5goDt3yVhpxi2Z0ch/vgRW7PgrDKBXo/KTNoacEiO
 4r96/pn7J1eHTi1W2V1vSXr7W0QjG4iEXwQLwaIhx19Dj5A685s/LZr6NsQ5hiJXAM0pT3coP5P
 PNYh4IOSde5khdzIse/6ilukAHDFrMPS3fsUSXQwQtNY3fLy7+38wNEU6rtOzB9NJDJg7IOYOrU
 ptjZ/pLnzeD6vVNP/0JOIs0CkFkbpvFNANOPLPSseul/Jat7vGPoleiYDNyPfk7sWsMMy2eC/K3
 kYDZaq2Q==
X-Received: by 2002:a05:7300:6ca8:b0:2f5:3641:f110 with SMTP id
 5a478bee46e88-2f54d790853mr7809665eec.31.1778288112967; 
 Fri, 08 May 2026 17:55:12 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca8:b0:2f5:3641:f110 with SMTP id
 5a478bee46e88-2f54d790853mr7809648eec.31.1778288112350; 
 Fri, 08 May 2026 17:55:12 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm5352610eec.23.2026.05.08.17.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:55:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 5/6] target-info: replace target_info() in system-mode
Date: Fri,  8 May 2026 17:54:52 -0700
Message-ID: <20260509005453.3984184-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNiBTYWx0ZWRfXxUiuIQMOfzZY
 Dvjr0WzsROMRWY4Oc2vorfK/02ihm9bVGMsKtog2wYirqvAW5e8cTJic4TFa47t4fvGwavK6Ph4
 6RLrp4XH5VAGt9j4ahaIdCF90wfzx1NwVhbt+Cdo6Mnz+N6Ttk9IX6uzazFxNJkPcxV1cSYaSK0
 NVGRqpyd7PyiuXN0v2hb92NKAH/h1nz5+3iiISEN+lqzfK79nGSY6sdQu4gSQV1tmu1ON6pDjOW
 n5j63t8/3Q1X3TlAr1vuv4r/w9ylF8CXFgwXHNPOOijgvLPawTE6MrOy6x+/wOnweKHj1fPDoFg
 tKolHFR0BYdBESQG6t+tT9OGuVE4hrPlMF6R6mPWmDJbCBCUkM5it9yUe+4ihDG7h7IH41uhWDw
 9DeHDQmEtyHkgcrZAzl2XGLtG4TpoBhMhCBZmQICsXkIOyy62Uiu69zSp/ng4/2wAs/eypIIy6S
 lynSWEEOaBasoMp2tAg==
X-Authority-Analysis: v=2.4 cv=RZOgzVtv c=1 sm=1 tr=0 ts=69fe85f1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Ar47GhOyGom1hrc3c0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: p7_ZGNT8gSUhjcVS-45NC1-N7ejSrtMD
X-Proofpoint-ORIG-GUID: p7_ZGNT8gSUhjcVS-45NC1-N7ejSrtMD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090006
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

We now can use TargetInfo information available from QOM, and remove
duplicated target_info() symbol.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 5 -----
 target-info-qom.c               | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 3f4eda19083..176fd975a16 100644
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


