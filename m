Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD58CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrtq-0001l3-2T; Tue, 12 May 2026 14:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrse-0001Gr-DH
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsY-00018c-G8
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CC4UcD3321004
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5wRLcL+1F4h0dL4+JRcTU/5s16XDZUkCPQcIUEl4wW4=; b=LgmoBQS0tDv5o3Bl
 J3T+2Boun17Kd8ZULrFi+CvKjaRDkCBZqG+d79dwSSkjlMVmSmtRvwlYbkkV79D0
 tTTZyRqnDNIlN6YD0RSAP1KlqrrkDW+E9IVoj/l74ctNZJZRML+iJVMrO9Pr4XQp
 /DhcpQFCw4BBM+jsRCE5fMR5isAxjxL5cLvdRFJ6joJ22C/1hEP/7dW/7safB3qO
 MkF+2A020vvAKW+wJ0zHbywePNUX2A3kfVE7OnPGcJZYnlKhNIHETFt2AItcXPkN
 ae0eNiuBYNe67IBxVeUnEdNbg45s7Sz9AP0tnnByGYcmbBh0aP30xif7s2IlL4Ls
 gaf+oQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1sgh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1334825de51so775886c88.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778610648; x=1779215448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wRLcL+1F4h0dL4+JRcTU/5s16XDZUkCPQcIUEl4wW4=;
 b=jvJVkvovfllNaA3cG6RreOFGn3noi2et7z/gId8ejpuU+HgHxfJQ9Juec97JGqfDKz
 atyiWAE8on6oHr8laT1Mx4laNurP2XLkCHogLTgdWG/gEN0Q+vy+fwOcrTidyN0lgooH
 w2IhTAzMNfkI5AbO7zccQQU72tF+cdDIVMkhZSH03fq2d+VhQn6toilDY2mRsRo+sSsQ
 hn+7xvXBp1H60JJPFdxK4dplU8vLrvqTmTBoioAEcdG9grZmsIL0CfwGyZ8Fo0jrgc9M
 76sj/DoTrWIUbnjIXiiEx7X7KbqwbJVbZkK7XpcYKNxYuDd5A4ABo++xMg3NS8Ex9rI+
 rDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610648; x=1779215448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5wRLcL+1F4h0dL4+JRcTU/5s16XDZUkCPQcIUEl4wW4=;
 b=F/12AqddbJW6RS0T+QA9S3R+Uri2Inwj6C45qykQiENYMrPqwu4sOWpoywbAcRYy6F
 snvN/oPHxDqvNTQC0BeC59VlvhLDfF00v/6/sh8qgOH1B32I2pAO774bJy22pg7O4DgH
 fVbwd98FsmK29Y3M/RrzCit6xpo9VKuWD5IGxW4jKIdfJvt1Mgx0HBxxyxx9QGnIG6gZ
 IEs65Be9Rzumzy9rNttfQcnl8AfFIgn2ZQw+2JjZQiawb+K+WkIRtskshfEySbUKnu12
 spxyRJqAv/Zgf4vTTC+8seRC6MZOBKxPzwfDQfxmxG9EyhCvFPCyVy2YcKL4DMsCwIw7
 NIqA==
X-Gm-Message-State: AOJu0YyLTxSf6AbIasI4rW0vv4UTX0QUk0fpOTgviQXyZDYBHGk9CB5T
 /RxEMoIfrl3q4xVvPJSp1fAUhnMACeWxdKC9nXZBfraoi8L5ENC/b6JZ1Pn58JzUPUGSmBi+HUX
 tY30WGBflIn1xRIJ9tCZd6HzwIBXL1aR8yhFkFUKl8h84GbvVG3qQSX5QQT445zJMRiWc
X-Gm-Gg: Acq92OEZagVvtfTsw2ErEVurS4EOkyp4t+BZIvOr99oA7JegFo0jpkX+i7SQbklgWlm
 CHdqp1Jz84rBRcsZUOdUiD6Z4oJKM/SBWxPCX2zk8YPfeiB0KVxvRnloXYcZ76QK3Tkos4QbH6G
 NsWJ2Zx/h9A8qVhVOW52KRFDFsGsm+Zb5uYqdWSQ5xrsnBAPv2S+06oAEcUgaoFdZx7S2kv4lQ3
 /+UYuQno7bXb3ou/D6fDTp4iq9Wi2lWg1D8xk0njFfvw1+fP3JbhKUjDY+hy6FVWuSV9J73gn9w
 pVqzm3avGBPiKmdF3oWZgUtMKvzcbGrZfxh3ZqlI5sIA/MNZ2BfOAdSkqoIfcF0+Old/3W5cjYP
 5cuBEUT8v9PKEvBxNOGYDIJrcy1D7oOoICMhsxNLKkibOuyGWqP4ABc5HEoPaffxi7KlpQs+IK+
 f5QRDp/g==
X-Received: by 2002:a05:7022:38b:b0:119:e56c:18b1 with SMTP id
 a92af1059eb24-134369a02ecmr56561c88.25.1778610647778; 
 Tue, 12 May 2026 11:30:47 -0700 (PDT)
X-Received: by 2002:a05:7022:38b:b0:119:e56c:18b1 with SMTP id
 a92af1059eb24-134369a02ecmr56543c88.25.1778610647207; 
 Tue, 12 May 2026 11:30:47 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm25221376c88.11.2026.05.12.11.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:30:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 5/5] target-info: replace target_info() in system-mode
Date: Tue, 12 May 2026 11:30:30 -0700
Message-ID: <20260512183030.1431103-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IWBZr6U50p8bJRSt_yjLmBcZmVMAnCPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5MiBTYWx0ZWRfX4vfCbMUGuNi3
 5qtUjssWk44GaN/tLwZXLRf+G5CLGKi3lKJBCv8+2DEZAtfHscbiJhCBLrIb9rr8bXeXBs67RBd
 6q9IA+mBcXwaqwXRnNNpFyOQC6QnwlABxnrtGi/XcA8giHPC0Ur11xjL1lXHtFYophu53FPdCxI
 Y/Rq4pJ6f9UhMUrrUq47+5S8NL9Ds3ncGe1hw94xXi9mlvkW1Wlw1B88uyNsMK+MoVPfKz6nZs/
 bG3vFDYP+Mzos2XQJvi2+Qq+YnCJaz179FtOOvwQMznuGjBkvMYG+Fp/2mSQC0SAALRyFYXjgIx
 bGGTjbC2M0C+2QZ3xO4TDhiWfaIoJs0VfuH2CF967d0X+HNBKBG4bslfCkqG9kHyJIgYlSO84lc
 EPTyRIQ6qsA79k3/GNvfYs+p0i8OuwwxwcBWmHbHRRHitX5sRRkKD14TqAc0djY1c5noOzNQl7Q
 Z/VTRFPemX9zaFUb9wg==
X-Proofpoint-ORIG-GUID: IWBZr6U50p8bJRSt_yjLmBcZmVMAnCPP
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a0371d8 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120192
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-6-pierrick.bouvier@oss.qualcomm.com
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


