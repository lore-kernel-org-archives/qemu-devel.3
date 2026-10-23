Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BeA612WU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SVXdKqgq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHxJ-00028u-Fc; Fri, 23 Oct 2026 12:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxE-0001x1-NF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxD-0002Ut-0Y
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6Bx02215798
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /DzPOd/H5c/Ybsy5o/5Eq1KiAxTkSsTARgtitZYLfcc=; b=BeA612WUYURJqY3Y
 H80EJzHNXmrrd1JKg3RlPiW4z7W68O5Rhv+ctvWKWFYGKXmd8jC51/WKJrpn0MND
 tAyfFTbWepsH4q80vsQgVwqZ9yOq2fDit3iJURDXG3IuNeYHo/tu4VHC3nAlTeSF
 ADBFkO8YbQHslPlP/qUBkoDi27eYiWn2pRFPT362ehU+nbYSHNVhYFRnFMEvbI7h
 stSE2SkFTx/tGFx9mSI7weI9PF+J177GTI4Sr17YwAVg8THbWo12nQUwQ6+0S2vM
 tmRqbltZZjupnGyLgfctcwaXYHaRtU/gurtGIcXzciv0lQMiJf38bk1/BF81O+79
 VEVjWw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc81d2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ecdc701a2so142874785a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772233; x=1793377033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/DzPOd/H5c/Ybsy5o/5Eq1KiAxTkSsTARgtitZYLfcc=;
 b=SVXdKqgq6fTB1txysw+B6cCGrCmk/jJrynG+ZYNvLaIrAn2E4iDvjhH8dXrC4Bk8nW
 pzKvfQlzTmEwAkmQd9xp/bB/JN8cd5Je86KGFnwZMtnFy0UxPZiOuicPu/V6f/F1vNLD
 scVM78zRYjO/BQyOmZPTKd651F+qNCWQR5/yjmB+T3jnQxP+EdIlynWGS5HAdNzXg0fv
 Z2nXnYVuxohgUq0tzJGpW3KozTC4MJ3Mg/dXdZoOLyp6hnjSo2ZYctfS7UY9mX0nULJK
 j99U5lYEB8+R4kbmLo5HLhWs4Qge6OVmgK6XGiFvtZ9NvdnEnKBWQaiV863s5rvegqTi
 Pjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772233; x=1793377033;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/DzPOd/H5c/Ybsy5o/5Eq1KiAxTkSsTARgtitZYLfcc=;
 b=UTm070sfu7KCgeNhnJ5aNoeif2rAuhovTbkV6X3ngzkI8yjH4nvcf0MgT7UUanGTg9
 TVCr0jj5/ZnIUow63ITdamjTuigzZ48gOk67PXjAuFOKGfhbnFgMdHJMVQASs5Ccwjkc
 CWkOLGz62rA7AEc1Bxu0ccO0iL1mbQ4H4vUHphxq1jtH78lkcAcNCgWfFjBb3zUmvAza
 Ug/OuU48rl61ypznhpAG2pgqAPULPDFLe6xVkj4V2kK+WMc/rNipXbZsqElXvXfR+7A6
 u5WefPsXgrwYmkZD1Y6IemK6SLoU+qf4Oe3rWnWChvANuZ3pon29gpl7a6uldgDWqWi0
 kalg==
X-Gm-Message-State: AFq9FYINl6z4NGiyqg1CKb+ftmtpJVnGDrjKjQWgHHsKUJ8jG0hde5D4
 4ZLukJuTgKIUise6z3+bICLHqtr9GW8gycteHgGAUB0HvZ/pd4fDjFv4nHwejawhWNAKkrxm84+
 m9wOm4InxNtDTAz3g24YeGF9z5uEpm1jHh34EHBhXSzIN50scjgoXbjyDMkOo1rm274My
X-Gm-Gg: AYBFou1gA7TUieFUshdsqxc6TdV7xWTh8w00WfdS9nEzSihv88uS2e7RpNijwAIK2YG
 NPBEBffQkA3GYgc8A7Rj6zxFIQmuPE14IqUuMyWM2AO2a+nKmiu6z76dSlPjiEdAbPrkmi5gpCe
 hDfCIV3wiY+MpH5BbKVhOSJMmgioBpAXTlpvTdP2ja5gkk71hKSDTSGercN2tLg7F2H97CcfDu1
 bYVKiDk/GIITk8GEjjTudUmY9mv1n+y4F0To32ISUFrgA30rxnj4G5GpotNy/CPdQCX5HWjyPQ+
 80X6O4jNtZJiJLQohNcf1igrTmDpVevL71sVzup05DiCX/3A5rQ2sTlnf1EcF/wePtiumppK7lG
 p1krlBwQIbUNA7cMfK2JbXaADNvjzcD1XqAo/D3JE
X-Received: by 2002:a05:620a:3703:b0:93f:232f:658c with SMTP id
 af79cd13be357-93f6f9ed47fmr488648485a.71.1792772233153; 
 Fri, 23 Oct 2026 09:17:13 -0700 (PDT)
X-Received: by 2002:a05:620a:3703:b0:93f:232f:658c with SMTP id
 af79cd13be357-93f6f9ed47fmr488643685a.71.1792772232600; 
 Fri, 23 Oct 2026 09:17:12 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a30763dd2fsm7376765e9.1.2026.10.23.09.17.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/83] target/i386: Replace magic value by proper EXCP0E_PAGE
 definition
Date: Fri, 23 Oct 2026 18:12:38 +0200
Message-ID: <20261023161332.60153-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX44mgnYx/FGD5
 UileL1n3PquaWCjVu4JA+TJ4Vl4dAAnhQI8kvjVKiwmBYULR+f9AXwfin1pAoqt6K5aYrENZlz4
 gsFfn/8CahuvwULUnJCWtTq9LfkQ8jenIX2ejGHAJaPTrtDd6G6QaPKGTD19O/LnNOu1H2kIPcv
 mQtiFGh9TxrfJgpdaky6AJQkXtBZeamdgEfoZ3tgBCMdfRHSTZI3FXWmWrk6E6E6Y0OoNGa+drU
 sAN8iAcjDre6E9xknBgT8Fu+Js3hqmZfPQSXKiVGyOrJ/LnmIkKgZK+Va3kYZfzAq4oOZQUMZ7v
 N2Of4wo5CiH9DTaWafIGkqTgjjbTZbeUngBWivj8WEE8auVLqtoLywWZxR8WzXQPpOMt5XCNSZ1
 zPCysCOecIZAxoAFWVu60T9QiTu9ZeNdNr3NnvHHb6S5zmmYGUehmgixwTECpAU+kIvFtfg70p2
 1WQWYhHQahm+G2CzNcg==
X-Proofpoint-GUID: DG3QFEEfD2VXyAhl3FB0lSUyUbld6-4-
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb8889 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: DG3QFEEfD2VXyAhl3FB0lSUyUbld6-4-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX6gU5Oyw7qFva
 FR8zK2NyGoQCWE5k5Yj51UsXi0095/0ej8g00Cu7diCAAMZjVhCQixGkZHNpusl//KvwIxTrbzv
 eowYDenqPlGt2qizMBhnOWthgfKeJ6Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No functional change: EXCP0E_PAGE is the 0x0e page-fault vector.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-12-philmd@oss.qualcomm.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index cad19f9ca6b..c89d97e022b 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1215,7 +1215,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                      env->segs[R_CS].selector, env->eip,
                      (int)env->segs[R_CS].base + env->eip,
                      env->segs[R_SS].selector, env->regs[R_ESP]);
-            if (intno == 0x0e) {
+            if (intno == EXCP0E_PAGE) {
                 qemu_log(" CR2=" TARGET_FMT_lx, env->cr[2]);
             } else {
                 qemu_log(" env->regs[R_EAX]=" TARGET_FMT_lx, env->regs[R_EAX]);
-- 
2.55.0


