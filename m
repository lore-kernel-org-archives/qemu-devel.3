Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4F606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fZgwtvwN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FQo8HsCj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0j5-0001MZ-8r; Thu, 22 Oct 2026 17:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0j2-0001Fs-GF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0j0-0007dd-Jr
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLQ7UK807480
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9DrGnDrxeF6JEWxNXzpy1QRGPv62j3RvN5w0RrumnhQ=; b=fZgwtvwNvfeyAl7i
 jvJpqBI5Hob0DzvBZM2Rk9lx6zGGFZ2m9BI90YglD47N02hEh0FpKAEtUh0z706t
 4HHEDCwa/Ri4lGCH86kDMhFhzqgVcSQIH4Bp94okvvDoRcDnaUQXbzyGC56S7uEt
 /ZTfEtRdXN4MFsUu6fKdKNBjushzKCqwlI+ynFduiSvZm9gV6CzBccHlmaSJMl1J
 GCiqT20/11YMELfZBRJKZsBhwk96FOdThYjtv6FqMRHPU30vQpj+F1hAttrFwikc
 VhoHEUmTgWMO2N/lg/yXCXUq74E6/J7v/NwF8mF+6+UDp24cs4MZGD5cwhtjseO7
 UxcK0w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw17qb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so42539485a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706005; x=1793310805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9DrGnDrxeF6JEWxNXzpy1QRGPv62j3RvN5w0RrumnhQ=;
 b=FQo8HsCjIepJyG1MDcQnZDDHdROJ08YOVNBUWQC96fwaP9k79pJX5PfZKtXPLjIMNm
 yz1moOe+gxKmfS8frvhRmzYw1LvNe3MOYqG7oRRVcy2fooT2jhHnl/E/G1QqApK6jhkw
 SlgOqpkaUKyVcLpUC43gN3aoXZYYJj+wryLr4SX2Kfsr63MEbVLsBTL+RvJohSIilP9O
 IvTeAfor4si5XjTYSchnvnY2qpI6UTGMqTGFmhkF3cGMyRGAunsf+wCM2sMNG2QSIzM0
 QMoHvWABh8GbGDQIglv/RkX0lUwQ5xvx7UT8RzjtbSRgreDELm+/wxm63IWZtpwScfYo
 4FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706005; x=1793310805;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9DrGnDrxeF6JEWxNXzpy1QRGPv62j3RvN5w0RrumnhQ=;
 b=RljE89Kq/l915MuzMS0xnQlok9ou7pCkq3D+MFQxzwalScYj2A9/MIyLasFKrxQCIe
 ypqfxoZVc3pDZgawbVYX17SMpauIjAJp0dqasCJCm59Kns/aZYogghE8xSeP6RkbQS8G
 iVAoXRceKeZmRJYEs8UNs+Kf0G5xzC8HN7GkeTw48ruhGW/JhE8YsFh011OkkCRAfU5G
 V2UeCAUgMNJUo6xKHmYdwa/0uYu80fezPpyTIIxuq2MT1dmRmA4WUD4JRnptinBpFpLW
 0F7cG3MSi4OKLgTpr9x/HGp3tLWWcsAvZwaH/+PYh1BVg5jux5J4GqVlkCQmbYZ1+2cS
 CfKw==
X-Gm-Message-State: AFq9FYLucDTTDZLI7/UucW9Y18mEXenHemZr6E1zVIK7fHeLUuZubip3
 cSFEWgA4Ffqx/joFMts/+BG8oHhpiTO439mlFk4gQ7TK2VfC1/81DJsviD8oeVrdo5B3DCzepL3
 vZjLaBbMXoNHXv08QLht26Op6SJHL3IgCX/S/xMkAT8rNt2Mlv1AKPTkOmpQwGZN7GQ==
X-Gm-Gg: AYBFou0w5MGP/xvdgjDV8D2FxqwtAwdtfuXLgqmNxUbssQYuN44wUDF+4v1Ce1H0/Za
 I8Kg9jvQv6JGYzDEaGDNAoQEsqXHvL2uIretpNcD5htLOCzqlS0thX2R0iBQ/aCH/7MuKQFdyhl
 JU2DVTG6baxZR6E6qE+iCvcfb9FsIrXrpk+XNYTxgOrtD+CTxP4j9zbdiF7S4fUA1DKo0vW8c/Z
 tUDOpJyjCY9jD9MQNFU5HHFomKhURXvCEsyR8jzXv620foC1+VmQRC+X2zIlYztgEem7PG0L64m
 1+iF0suXgNUei0z8iyrNEL9cwVHbx2hMf2tk145M7/gmM77JmXBiiUuXkgsaRkBa4xz+C++Wdd5
 x92nK+em+7Ba4F6RULI3+0PBhj/kczA2hXM5LlbX6
X-Received: by 2002:a05:620a:4727:b0:93f:5a85:cf9 with SMTP id
 af79cd13be357-93f626db890mr626909185a.7.1792706004621; 
 Thu, 22 Oct 2026 14:53:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4727:b0:93f:5a85:cf9 with SMTP id
 af79cd13be357-93f626db890mr626904385a.7.1792706004108; 
 Thu, 22 Oct 2026 14:53:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a210299910sm26519155e9.1.2026.10.22.14.53.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v3 17/33] target/mips: Remove EXCP_LAST,
 use ARRAY_SIZE(excp_names)
Date: Thu, 22 Oct 2026 23:50:57 +0200
Message-ID: <20261022215115.19680-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 54U6nVqkhx6Mdu7smPbheqNHl-r4eHx_
X-Proofpoint-ORIG-GUID: 54U6nVqkhx6Mdu7smPbheqNHl-r4eHx_
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada85d5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=p6m5v2aWr9E3IcuUVYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX01EeNA6aGmvA
 y0bJ7vnxKENRGZ9pBqm6GJe6KwO4eTmplnj3T4/kP9T8zY/Hy5cIaD524oCbGxYob1dhjzz1Jbj
 gFkHqBJ8A++JiE989PaudnYl+uJkz/k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3KJUgdfgwKw7
 wL06RFc2Yu2V01SPRUK8m1tNKfa6ajQi2FtBT+sVL2IFoENPmBYO6qu9xbH/pfLcSsDuqceEfqU
 vTBnK1MWbdSmgFAw/TU71XI/pLg5XrWzWZ9gYlozcDS4kFjw5jvV47kdBbYDTiS0LJF0EdiNFHX
 XRKDJ9vvt2fyRW/Omu299P85ToWHDDMH+Te/3Uo1yQITZWlHnQIN/hk8gUAx/eOiWW9NOz2efO+
 atXW0zJW41xjKYLpECpihgrzoS7mOqc/m5kht6Wg6qHZdvykhen1Bjs1GXBiuFz1ubd/ySiYo5L
 PrawBXTGoVh0HjALrOYwr8ZVQJGECHt58oKCUFEz+w6XGOBO/xa9jdLo0kLpPUPoli7AE5JdTCn
 04aixegAe4pNWV2E3x6WiokQnvFspJfvJoPc63Kh08KL1p+tMeRJj29kKxRWpO3aLPBaKengAcb
 eAXlPoxds9kDgsahGbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

EXCP_LAST was only used to size excp_names[] and to bound-check
mips_exception_name(). Let the table size itself from its
initializers and check the index with ARRAY_SIZE(), so adding an
exception no longer requires updating EXCP_LAST.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/mips/cpu.h           | 2 --
 target/mips/tcg/exception.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 32549791a18..5d8b78a70b8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1347,8 +1347,6 @@ enum {
     EXCP_TLBXI,
     EXCP_TLBRI,
     EXCP_SEMIHOST,
-
-    EXCP_LAST = EXCP_SEMIHOST,
 };
 
 /*
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 630b8b809fa..2f02f9be877 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -88,7 +88,7 @@ void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb)
     env->hflags |= tb->flags & MIPS_HFLAG_BMASK;
 }
 
-static const char * const excp_names[EXCP_LAST + 1] = {
+static const char * const excp_names[] = {
     [EXCP_RESET] = "reset",
     [EXCP_SRESET] = "soft reset",
     [EXCP_DSS] = "debug single step",
@@ -131,7 +131,7 @@ static const char * const excp_names[EXCP_LAST + 1] = {
 
 const char *mips_exception_name(int32_t exception)
 {
-    if (exception < 0 || exception > EXCP_LAST) {
+    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
         return "unknown";
     }
     return excp_names[exception];
-- 
2.55.0


