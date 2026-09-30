Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D442ECA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdf-0007SF-Fk; Tue, 29 Sep 2026 22:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdd-0007RE-QT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdc-00034n-D1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U1Bgbh1967204
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PCxYqVRUWUy
 CVLvQiVa7RfJXeJPKr7hoE6N3zTksw/8=; b=n3P/7lXEr1KnwiPVWy2fYAdFeFp
 49zw1sd74YNsNwhdpMhtWNUKt9K4THBcUKqLxdTN7P20zKniSOplb6dpA6SGPTO7
 S/mi7heZavz6b48f2NS5SIVW6P3kT5QSKakjQzVYARczT2k5IBbbTVOWd3+aRtMW
 m1dEdT2gx1YL99cY4nZbodzCar2CGMHbq6m0IiFq2zk1PxPtm8kiRIeADrYqLseR
 RvgHiym4V9A83H6YqesaGQSw9OLjsUrUam2nOh35iJoeikuljYnXTu7woPMEO8/K
 8FNuP+3kl6OR9TrzIKcP9zOY4LB1LaVL7crImTzJPAMnpaXdyRbAn5Vu1Gg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2r526-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso3606769eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733698; x=1791338498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCxYqVRUWUyCVLvQiVa7RfJXeJPKr7hoE6N3zTksw/8=;
 b=ck9SFi2Ad+NPrrm/1zu9di0rv5vJNTJG0jPODCF0W+75kziJy+aNy/N57ifZqz2M5o
 XB9UzVH+BjuDQRsWILHVopmlxAhsnn+yKXm4uxLJ40gC6bMW8mouPY/aZ7Vmc+qgcGV5
 sDzx/nAKB/7niV4VvuoYgDDWUN/ff1VWgZCjb34alafYBjjGwhbtdhEDdoa3A2qfYsbM
 8rWLdbGLCX/kIwza7s+FdUCRA1fbI2bAmr6TPkWItHkU4sXVlv/EBUmLIsXPy7haEJe9
 RuN7/4uDLF2d5Ti4bBziHjVsS6TG4XQAzDPyVpT9w44q0Niwu/HNTAH6TKB/1QNGlo8p
 h5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733698; x=1791338498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PCxYqVRUWUyCVLvQiVa7RfJXeJPKr7hoE6N3zTksw/8=;
 b=LUYzVh5lK0mkddvZjnLkpDGFfycvAq4VUTj5S1IxWwuGjB7HparfVFhCVtn3cI2yMd
 3vwlsf6HpQ5XvOLemrv49M/QPCqIUFqw/mU+7jk6PDCExyWtcOXsUeLxityW45sTS+py
 dOn2SRxbU9H+52EQxlG0sk8Azu2qpk4CjBwuPqjXP8ApBrvY3Z/+gyCh9cK0KtY8EZg1
 cgnw3PBkPCibj2KntzzQ8VDliMrLfypU3PgwYsGHIS+11P5lbvSg5fO6Wj4N8qIM+vIS
 74y/JZ4CRQgOw6XahJJAT1d5rpfiuCNr3VrY9M1PTyFlZ3XHKweYrljKlnBVH6RKTQRo
 dWcg==
X-Gm-Message-State: AFq9FYL+8ELM+mFjK/krLOMEtydqgiZ9utBhxiOXFDIKlWHILg/l8Cl+
 yWUVDQVGQDC8XtJx/lbdlAYFL+XI7zKxNyXvF/ZhCKZcK0oyR+SmlaB7ZWy3whoSTWlh5rTkugS
 cnz8PiVpZ+PGIj568umufK2F7WjD+sV18uK9chANysFa2akB165KkXtW4h6eZNyL9WQ==
X-Gm-Gg: AYBFou1NTt5mEDjBFolnfsOWXRXpz6PUjej5n59ZlF541q6I5/E9imLBFrIjPsTBBaM
 9mCKYGgW6HLZr/kICzktzE6vd0JjSutVyN6SzLWw5DcM53b+IA5UE1vHbx2zUvYQw/mIOaOLERb
 b66BaHkgQbszu8Ilia4VoYzTacuOWROOD5zGq4yDsObY9OkaB70GPlb6T0824H+iD5PhUQcTOyn
 yKbIHtaEn4AXgyeemkyJ1eFn6JXZDl2m52Ax3IgTRuHfNNMbdipwzLpSTa5irx5YfmagL8oHpe2
 6oaKq2nvte6ZgM2LCaVs24k7Pd9OcAx5X2e1/biAgXwPnbFjAEoyeQ/EpJPVvcBoxhlO4wejRPZ
 5dxYknrIhXMmyEjrAcEq54SZhyS9khyAFTiLOC/xKhNmO0krNfrOIXYDzmsZu
X-Received: by 2002:a05:7300:d202:b0:340:c464:1a2f with SMTP id
 5a478bee46e88-34cdfe5bd05mr65460eec.16.1790733698298; 
 Tue, 29 Sep 2026 19:01:38 -0700 (PDT)
X-Received: by 2002:a05:7300:d202:b0:340:c464:1a2f with SMTP id
 5a478bee46e88-34cdfe5bd05mr65433eec.16.1790733697708; 
 Tue, 29 Sep 2026 19:01:37 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 05/21] target-info: add target_m68k
Date: Wed, 30 Sep 2026 02:00:52 +0000
Message-ID: <20260930020108.217892-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qzADwldUDvr3Un34oN9kXoy7JtS8Jcj0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX7FyLC8SjWa8d
 75+2H2CnCEKia8kVtI/GOBdS9Ve3Zb59dpbcqwp5+Ejfkio9dRKcITgrY0FO+hEZQMOTR2TpOwB
 xhisdLxiUC3hFOa7Zbif0bDFvSBQKUNm8MVEnICo41X8e6aOJiHHD3mR2SSNztZcXgfKnMDxfDf
 hPvyPj18Z6fyqoyYSVEYf5LDeQ0J2GLczjioN1huas3pfc2GOeaC9fPvcC8jPQ+tl/ff9NfYpMx
 gKbz1UdibG6tWH2PayltHIFqY5Tsjn6fIChpZdeQLwlTBs6uu1wPnT8P/XK9Bv7npYiUcrb7et9
 Y98cmREUTEbOdsnCbuQ2PX0fH4LdAyXLSC92FuzyHoQK6FaFUw75X2+A1d4wf7fnPuIbDXQwlvU
 LpWTcj2/ouPQ4VwH5Rx+PX5brcc21GWMCZPDZUUQ0Pf1jG62R4blVbjBO6uAYZTQonqRBXu6YOC
 Z/wjILhzTMBofU63IxA==
X-Proofpoint-GUID: qzADwldUDvr3Un34oN9kXoy7JtS8Jcj0
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abc6d83 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=upjuZsUD9oIM7hwv7PIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX0mc5A02fjew2
 rKVQV7itIKnFAVJO3l6Pk92+l7MGlWZlzl7/90XQ96+YragYhqcE97vrfMWZI78kREXoCnoq6kO
 FIyIsyRjOxKjKyZyEkeOhBAz0NwsAuo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
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
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index b23e5bc5865..c7b3fda3b22 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -63,6 +63,13 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_m68k:
+ *
+ * Returns whether the target architecture is M68K.
+ */
+bool target_m68k(void);
+
 /**
  * target_base_ppc:
  *
diff --git a/target-info.c b/target-info.c
index 012b384036d..f3d98998ebb 100644
--- a/target-info.c
+++ b/target-info.c
@@ -63,6 +63,11 @@ bool target_aarch64(void)
     return target_arch() == SYS_EMU_TARGET_AARCH64;
 }
 
+bool target_m68k(void)
+{
+    return target_arch() == SYS_EMU_TARGET_M68K;
+}
+
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-- 
2.43.0


