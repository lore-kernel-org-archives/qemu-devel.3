Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04623CD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA5-0002px-TH; Thu, 30 Apr 2026 16:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYA1-0002nc-QR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9z-0000vT-Rr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UIVwxM2481136
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hZes4Iz/n2z3PSgBJPJ4zqNyNDt9ZVsJJimlYuxnvug=; b=BchcbsPfMpZP+Sid
 99c7B6PMRTOpAaOuQdOpqomphl6C9qbR2BHw1seiKjKhoVHYvKHYTZwH4DpkA/kg
 xd4oNBpSSuRPYxNHkHDscl/Nou1/1uSPSFO6+1hZkYWpdT0Fn5rUVbw37nUP/s76
 OwynRmCPK1AEAin9l0C+CAB1nxQHwiKCRv/XAu9igJAH+rVonBU2IDNlDSjgBmi1
 D36/Tsrn7aDUcXqqhhHuop9VxEbTr/Z/spf942VKh8HffW+SfZeldCPdNj7TnRaq
 /B4YhXuZ+3bnrUk8ZCQQSBULwNKefv/yb4zjk8qa0CMoq/E+kGktj9IUHdzzP3tK
 BMZe4Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7x6j2y0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so2083318eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581537; x=1778186337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZes4Iz/n2z3PSgBJPJ4zqNyNDt9ZVsJJimlYuxnvug=;
 b=Zn2KlbCpHnpMhYZRXmQ15VdOySAH8RjjR3tPNw00n6ByIyQo0HmyosHdNm5IgRPMhq
 C5uGijdX8IEOOVnUMXnjSUzO4m+gsLNBEGFcmBh6rZUFh13H2DgHBLzMEwRkWI2AGKO6
 SSwH25QQ4wUIo8Xf4HL3iDfynrCjR9AtsxR7Nl0XbxIakBoKjN4+QNX4nXsPZAdM1uyU
 ez7wP1sYaNg1oO9H+m6AGrvFYR79RV6BzfEzNWswiT5u5FssmNZ56aERoKF1mGQlGdtu
 /2oPuwJ3btcuz9HVaNlOHvn0u/IBuFPjjE6F4nvXJl66E7nfQg6SXdDgqErdwtq6Q6g4
 Kf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581537; x=1778186337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hZes4Iz/n2z3PSgBJPJ4zqNyNDt9ZVsJJimlYuxnvug=;
 b=DkQ6id4AfPVHvdH4kM78lzSfs9JZMZ/UnXtywrXcGecfYVTdBtJrSAB8ahEpg+zfb3
 0eYke/j72d/eOrzFSvwlylsfDL5MaCQMIh8flrD3Pc/fYbkj2Ei6Il0pAGvDTn7y5bhA
 tQZ498b1LIJH7vQ/KLCXvwWWirblW3H40g/qctRXlbUiKXY+9UpabId/4szZEhfrQZI4
 VB1eOCDoN2UgDLe7e5MeK/K1Sl221GQZ2e/fgAKSlpAMz3p0HKiZlFr+ekjk72twJryl
 8A4/1FjZzYJal/tH4FAHW7WwRavwe4lBu1YSesYE8EY2o0bJCLDDkKkQR/oq5mtoWKZj
 lslQ==
X-Gm-Message-State: AOJu0YxEMUYHqB/qFCG/QS6p7jkqsbxBFc1FV4iBewOJTILkOosTkebf
 Iudfx7G2INPW5GZqOrJLmH/Z+Qm8v4V9RVTQT4eabdep7vwdcUq1I2K0Zx7VgXmeHSbsyCdjcnb
 j4lqrurqgcVA4sKxUKb4B9GWXYa3Fa1WCJMO/XrZZtkC06gLc6AJMRxcs0kBDTmNPxub1
X-Gm-Gg: AeBDievfgF8Ol3walHH2U2o+u8s3BkYqF7Lo3WmJGOlhrsdyGnrh5ZfJD4GB7GoxpOX
 KOo2LmgrrkvRw1XuwwLbZrP1VLBRe0qV2sJfNu8Pb+5WbxgTyUnlsK4ze7piNM2H7kLNTzEe+XR
 UJ7wE8eba3xId0Ej5TxqDFdlf8gvqjn4Y0oCQl09Y4IcMX735JdZ2kbN5Megb2sB/q86PEtrbV/
 WQxQDxwcq4Ouef2TvLP15aOn9qmaB0ugZ29Z+lV9IYzhroksVw83AqZp7xp6jMsSbEtfSDQbnBm
 tMboT8SBWSshbqAAkAoHwNQ8ngoZXzCK7w4bWJfFonNIyhHL/HbXtFNbQZIH7+BNcb3QHXHlOkl
 lyK9IW1S9Pj9tZQc85y6gqzCnvnNVXw/aCMkdSEArwB10KCWR2sfWn6RYqb5Iw7OKW6sk7Sscn0
 a8Ck7kP5+Hho6nxljb
X-Received: by 2002:a05:7300:7c10:b0:2dd:6937:79d6 with SMTP id
 5a478bee46e88-2ed3bef2dfcmr2469460eec.7.1777581537320; 
 Thu, 30 Apr 2026 13:38:57 -0700 (PDT)
X-Received: by 2002:a05:7300:7c10:b0:2dd:6937:79d6 with SMTP id
 5a478bee46e88-2ed3bef2dfcmr2469434eec.7.1777581536815; 
 Thu, 30 Apr 2026 13:38:56 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 8/8] target-info: replace target_info() in system-mode
Date: Thu, 30 Apr 2026 13:38:42 -0700
Message-ID: <20260430203842.29156-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8w7WoVRMN0pp-ij5Ee9V_kDBPcWF9HYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfXwywCYK21FPlt
 wlKv5frJcNq94EC5DSDH4LxSIxW8VMEJ4nlE8zSEQH7y8DiYlkZyG/IZiWXJg5NzoHMAwlTGtgR
 QlUhT/Kp4iPJ2+pXnIeqqgeqMYdgSz4PnTfe+u5I3Ev7Dsx3i8wZfuOs+LuvjWQFL18OPmlQvw6
 bzRMbN3cCvdeKH2yjRgmAMO3Uk7WHm8uXJfYGpgWHRS+WSEELI8WTpAVgbE8o0kXohm6jgFMDgX
 UacZ4D3MH+wSFllAM9ECtszduQqcwG8XSWffG1uzTqs2Sf1tTY47eA73h44G5OURd6YDRbZ6zxK
 r8rl+xnhX3jrvP1asqJ2XYJ26ktVqgMYwf1kanBluC7XyFm+Qo1KFyCsbInFGcA+XOPFi74ghZS
 Ws838XujHksNduhlUWIIjEv/oxC8A3fFtlPGUv4ujD+XnCmTzgcbrvpQMugWF0YHJTiR1qZ1m7g
 ezXJvKOHhnHibscTXaw==
X-Authority-Analysis: v=2.4 cv=XoTK/1F9 c=1 sm=1 tr=0 ts=69f3bde2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Ar47GhOyGom1hrc3c0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 8w7WoVRMN0pp-ij5Ee9V_kDBPcWF9HYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300213
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
index 7e6f5d90ec4..9f91fc64d1f 100644
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


