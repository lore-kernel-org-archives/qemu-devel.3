Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037BACA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnrM-0008Mu-6j; Mon, 05 Oct 2026 14:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqo-0007iS-Jq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqm-0005oc-Pb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLbob3043961
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vtADa/pleuvlAdmYpbKsdetmQYEMVrn4MmxIh5KZtss=; b=hO7rrrmvqmZgzmRm
 wAFG7YrhCamng+B6/nXb7Tmpuw28eODvKor712KGh0pAKlbLF7fsEpRaXXiA4qo4
 FsE0duYq5LhACJeRmiAEjfAjvxeyS0C7es9XYxhShp9K1ug3wbq6CB4DEPkEOqoy
 Dkf35hReJ+6M9u9pvB1eqn/nm4OHxkDcNq04w+wu+cYh1Kww/oX73S3pA83IZdA+
 bX2y5R21Tp+1xa9t+8UXZ3Ii1/t4URpZh9QVgznVoH5Esb4VsHaKoQIEIE9UvJct
 M7Ctfp4Etos1F9whHaflJhdVyNS5vIOdhtU1DYrNGzH+0QGZsCR7K132Ysc+x0my
 2Axgzg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvsxcm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1384427c3efso2866660c88.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226537; x=1791831337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vtADa/pleuvlAdmYpbKsdetmQYEMVrn4MmxIh5KZtss=;
 b=f8JzwsmFbspWIDQVKCrxeFeySD+DNr3+VwJfKaI8Z7oX68ltr1ZlOpbEdLuu6Pnw6e
 t+F0FoUT1q4gV2upyi7Ih4KUse+g7vhDzkghkM2vq3dDdq7bmTu+Y4MkjxtR2OuTcxHD
 +DspKwV790lMTtKe5lh/HLn8QG/uxgHbHthHU8QhQ5jJKodLx/vA6xHoSX7IOC32Fhig
 7TkfDYMkUWbWmiDtfZh1GllEpM+uyuCXOOjCf2NWcjKwg1dK2p1js58fO++ZsV3Iabbs
 K8GrQqtyZQ1Yfeu/kN7GLsPtMmnyh277NQXwFMo41dP7DOrccQVq3AZBWqwhqLRbcEEI
 lvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226537; x=1791831337;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vtADa/pleuvlAdmYpbKsdetmQYEMVrn4MmxIh5KZtss=;
 b=zRWG+3HmMnELyqPZCEhrJL5u2zDml6HURurjiTpeznxvwX8W1ZBHZ/Q0JAmPOg1w37
 1VeR2eZTUBVlM3UGAwQzadopVc3hgVMgNcpqlR3ZG+Jr/4VtnfItP3UoAodm2tu0KZrs
 +1NugawLllvC0itDC/c9n8IH12NAE1T+sN8JQGvmvKWK02CXZUiVwb5p2DjAe1uwDpe0
 BL1M6iFwH9wwZuBNgOFHXx3jaUhXmZmW9ZR2MBdfz6oDRVW+henaWpANUHrVGp3eVD51
 gPTVS0+gMtCHYQCdkSmZsXSM+10l4KnNP3wjsp6DbVaKBPuOX/n88FdyrlyZIdnowxNE
 thkg==
X-Gm-Message-State: AFuF++n324JxdV9tNG1uP2WaWfIf4vP4WLPSOr3t4YLyNWbjOtI2tujL
 0808HoZ/4/Uey0Ntozh3EagH5O1JgoGmKlCSpJrywdUPb4oE1L9kp5XPW2/A00J+F00s/7Zf/b+
 fwRkac0PYP8gFlXYbK0sKs6hoiTSyQLYgrw4zc/rEdPnf/dBsG6vQUpbcWHT2Wy/UWw==
X-Gm-Gg: AYBFou2W6d5UHB8BgxknrceTmdXIJwjQiYLVUBVAnZ2JaxmoPo5bta+xdsg7Amt/3j3
 JI7GVFaMqhijLqCQhk2kL8+1oS2dTGo2s0qC03nCCrKphVQVgCayouS9ke37IiQDglISpuQuFhC
 pQ8Fgv8yzqeDFagwegi0iDCJK0hBQaIxVjjoaAtSYhN9L4V3vJVNrTtjaVWdYL5OtNmkKP3gMos
 wc7ziAZPmnM7cb2jIgZGIEyvANdH5RQxYUkyDXZXz6tySEpeyb/G6g3uIOdgLC+XlRxRgIIRGWF
 pbDVawuFsI85PjVIsPo3s+yHJykUPIsZTYu3fHamxZyQmumD++P43fGiHaSMDK5OPn43MSFdn2J
 G3WSj6dhaulJRxDf3TtkBF0XskatsimzwG4Iczs1S7/VSmc4oSrUxtD48kfct
X-Received: by 2002:a05:7022:f90c:b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-14f5b9fd40fmr15029212c88.11.1791226536558; 
 Mon, 05 Oct 2026 11:55:36 -0700 (PDT)
X-Received: by 2002:a05:7022:f90c:b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-14f5b9fd40fmr15029169c88.11.1791226535982; 
 Mon, 05 Oct 2026 11:55:35 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 18/22] target-info: add target_or1k
Date: Mon,  5 Oct 2026 11:54:54 -0700
Message-ID: <20261005185458.405929-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3f2a9 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=zEqewLYq2q9j3nlqUmgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: fQq4XIOsUprHV57dIQx4diqo7TOABMZx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX6RyYUdTfYYHa
 9Gz4FNF94iUXLgHuMuUcDvDEYh/AhUiW7WvcYIuLGUyCYIwtFIDCxD/KQ6E0Se6u8IIU7qpD609
 P//lsrbNLU7W9Uho8ix5CupwyAzgruWYqctFLrbMCc1U1paxlRDjRNT+KHuPHhh0oZiPpNMZQlH
 HGC4xII7ZaSwJOrgW93Ctrwb7MDEbWJ5knQ76n/uBxhbKR667WaHJhz4MrKzChYuwKJeOPZHO7y
 1LN5NmuCyRq3+KNpN9xFqnqWyxx0RJaGtpXsxDT+bowMbQeGM6CxZxIzMwzU3n9ci1lG/WhJY8U
 p01m6uw2wKJTtiUVchhahjgdp8CJWy2RUQA+7XmYf0FqJYrpYZv4V8Yjqkq3Iq0ADRfW/gBcCWY
 ARXg38KtPfD8TDHHWML26qQCi3+MNctfTItQ4do86JvPBtsBUFexJoO1ERdmgnWsPDUjy4BOi91
 SfgXmWR3v+eJ2mTrCvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX4svCVva06raQ
 7raZ739y4BWsNuJaDuBAzU1oLVRVWteuWgyfM2GUktQaxf3Qf57t58UmcuCjCUqa64hpuXC14/2
 HIJunxTmjG9xlj0f7WzjRWl255cW6wc=
X-Proofpoint-ORIG-GUID: fQq4XIOsUprHV57dIQx4diqo7TOABMZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050074
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-19-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index c7b3fda3b22..adda363ac39 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -70,6 +70,13 @@ bool target_aarch64(void);
  */
 bool target_m68k(void);
 
+/**
+ * target_or1k:
+ *
+ * Returns whether the target architecture is OpenRISC 1000.
+ */
+bool target_or1k(void);
+
 /**
  * target_base_ppc:
  *
diff --git a/target-info.c b/target-info.c
index f3d98998ebb..ab43c9f802c 100644
--- a/target-info.c
+++ b/target-info.c
@@ -68,6 +68,11 @@ bool target_m68k(void)
     return target_arch() == SYS_EMU_TARGET_M68K;
 }
 
+bool target_or1k(void)
+{
+    return target_arch() == SYS_EMU_TARGET_OR1K;
+}
+
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-- 
2.47.3


