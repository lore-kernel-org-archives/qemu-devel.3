Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e1PR4yiU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JdxBqT93
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUEs-00048m-6k; Thu, 29 Oct 2026 13:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUCI-0000W3-2E
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUCF-0003yi-TX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDXxR3234241
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R4SRNdFp3/px7rq4HIzeJDQWOLCruZSNQf7A3K+4PNY=; b=e1PR4yiU4fRHWOo9
 RkAYkDfNARNGLaFC9jZb+NtTfNtQM/FTRP/FwnrbkzAHc6OuXliIeQ9bZbC7kOFS
 wT5eYxF0gcJK76dvW0C5Q0JCATBN3yTa+XNQ7fM2cIMCSvQoh/EordwZGtQERGGV
 LLkUgQGwa39XKU2cPj2t0ris36sA5zjJwG5zaeAouWzqgJv099XKdJUHOrQL/CSm
 A83qJO+ikrfw3wRRluw+bATvXAeDeRP9VDGGXAwTIlPajJGZgbfECwdWev5cRAmq
 4ujm3KUWjOts73bff2zM2xpAkKbAuLfBLRUHJ22y2D0H61P/K1+9SKTMnN8ElzBd
 xcwPgQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b28n5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:45:50 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eac6157868so972971e0c.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295949; x=1793900749; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R4SRNdFp3/px7rq4HIzeJDQWOLCruZSNQf7A3K+4PNY=;
 b=JdxBqT93MqYRJNn5MhJ3Kf/9V729mXxqy+dq79WMUkjSgMHzEuLl39MyOugjOVu3ak
 IF0nQw0dmbAMdZMrwNVOyRk/ezgxLhz4Q85vIFq1kQWFOfeaOLByKsBnfP1PLyiZL3rJ
 OlZNfvQ+7Ifzw9vC06m6wcKeKITjPyObtM32oECn2E9gmH21yDy8LOExWI9G3+lD6xPa
 hU6M7cv6NY3WURrAsCytF9Plo3RoKsXm8nLPGD1pbLTJK9FbBEX5tnZEDmpkoz0Q4Kpq
 iKvO4c2MYNcyrjTy1C1Udc+Rjsv88JWsczMEtWkVtehvVz/Ezp9+X2QLyfqmCHo3z/O7
 65lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295949; x=1793900749;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R4SRNdFp3/px7rq4HIzeJDQWOLCruZSNQf7A3K+4PNY=;
 b=tS2KUrDHtKlKkp+Y2HDy0rb4BRF2dqZu71Ba05HQ7zPADlHCb8v8S9UMRzfgNiUvcG
 mQWhSn7cj0y2uwDJxPbGjHgseOjlXDk0fOSO1rF6tDRJzz8DniCul4UR0wsSCVPDSj9T
 MaTrtSHw7yf9qarPVrjxXoll3uoUFE5imNJM+lNi31q860rQX7r+PK49p2y89CxAWYqL
 38h/k7lBiDEbZ3U6vqm2GsNzp7HBObDJsPRV1s17M05RBRSt5IIyT4pLHRpSU1hhTTsx
 tbejy40rpQS4WurzlYSqP8WjXjvxCLiJ+pMo96ePLH0xYglalF83vsCkrkSVE7pXkrWb
 nHVg==
X-Gm-Message-State: AFq9FYJwzKQGe+bnJyD/XSQY0I9t4FTKeolPnDHt9MBssqgi7kA71zkX
 qFZ2HBRJ43QWXOVRhT9J3gQZ3vN9pw+lquqO8tihTTsj41b+jz7tg0L09icvI2gqhXYVc2BUfPF
 B6pMdBA2jbYSB6PHlBJPQDsWVJw2tyCt2c+3TEcm3FiRPnd1VXs0LPOIM/eVuad+aC/Hz
X-Gm-Gg: AYBFou39X5EX6DSwRyrTWxKULKxnUH9nIzqOJ+V1ZI/i+aO/RQB498omp7f3psgofGu
 z7CNOKOwUj86c5ztrAla3CORd6FSiNSA7AooKT92OLRpUlQLpyvLHoa6XnhWQ9PuMHOe8OpCobS
 wOUGZROjb7Nu1GvlLRD2RTvtUqzyyANccbo+w5bxm/7UEHuZSA78ykJLjH8jfkFizXvObhh8G+H
 6S8YGFVidH16bmRmV3Lz2a4aPqwPKLHEA66WypfmGQSZUYpMVQuqnL5YD72+X1w5MarIW1+vXTN
 qemsH/jGRMGsw/pUo3JAEN527foybd0ya4dLNaSaRMe/kb8hxI3dIhavFTlihS5+38jakoFB1jI
 oJ8uDLhI4Vj4oQJMqypT1IlZgiFFkpNpqR4nq4JutC245GloysAdAZTpZzqkPvX9Z2y3OJGnRMI
 /810UZJcW4GQ4PY7u5bIIWCL7xNO2/bA==
X-Received: by 2002:a05:6102:5244:b0:7c8:78bd:fd7a with SMTP id
 ada2fe7eead31-7d054298427mr1015274137.25.1793295949088; 
 Thu, 29 Oct 2026 10:45:49 -0700 (PDT)
X-Received: by 2002:a05:6102:5244:b0:7c8:78bd:fd7a with SMTP id
 ada2fe7eead31-7d054298427mr1015262137.25.1793295948530; 
 Thu, 29 Oct 2026 10:45:48 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df1e537sm534968f8f.8.2026.10.29.10.45.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:45:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 10/12] tests/tcg/mipsel: Test MIPS32R6 LSA
Date: Thu, 29 Oct 2026 18:44:31 +0100
Message-ID: <20261029174434.27985-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX6nxRIvlCNthZ
 ObXCHJp3RlMAmE0MF7a/qKDCfV7H4U07IUwD0b4Y1norj/a1nXR8yoUwrpDX1JfnLyLwYK2KcaB
 X2GIBSEW2QYnHewj1i5Nw2TqCJL1sn4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX+2Zdj/HUVEBA
 qM5rfymJb086iIOOJJYhZMHD+7DX6UyYkBSae7as7ECqvLZlBBYZJahgyD/4cP0GOLAM1yPvwJT
 xhUCcHpDEJJqOSKowYgvDlHWamO+p1HhHfChO61xIhH7ySqVsvuGG9HZeq1zbjsMxnn8tzMvCfy
 W6OvLeQjP5S+dhMdkZc/CCpBb2n2Zxete5N96zVj957t0+OJce1acshT95fw3GNIhftft/qQXJp
 qAjSdTZE4eqDnqzCbLvCx9NjOWckYxI7O9pQrC/HjArPKyP9eGPK5q48SfX+W962KZ8DFxj4/mY
 sJBew3a7mTjLGXgwqapWmRIPYO5SLxiL2FzAlcGMniNQfkvhCfaGo9mc4goPgN9a87R2SCDupXY
 2lJYPNNMvurv2bDeedj1JA8kQSzueReVQnUXNVLwMnl7fUPgu5qWewe3KB4Br2y/T48jjX19fSX
 3kvNYzwnl9abn8CSf5w==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae3864e cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=veIKPg1plPCbqLeGzsIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: AgSArHjkxxfciMNSYNhCsoi71mDbR0PV
X-Proofpoint-ORIG-GUID: AgSArHjkxxfciMNSYNhCsoi71mDbR0PV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Test LSA opcode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips32r6.h | 22 ++++++++++++++++++++++
 tests/tcg/mipsel/test_mips32r6_shift.c     | 12 +++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/mips/include/wrappers_mips32r6.h b/tests/tcg/mips/include/wrappers_mips32r6.h
index cbff8450b656..63b4496b3188 100644
--- a/tests/tcg/mips/include/wrappers_mips32r6.h
+++ b/tests/tcg/mips/include/wrappers_mips32r6.h
@@ -48,6 +48,28 @@ DO_MIPS32R6__RD__RS_RT(SLLV, sllv)
 DO_MIPS32R6__RD__RS_RT(SRLV, srlv)
 DO_MIPS32R6__RD__RS_RT(SRAV, srav)
 
+/* LSA rd, rs, rt, sa: rd = (rs << sa) + rt, with sa in 1..4. */
+#define DO_MIPS32R6__LSA(suffix, sa)                                   \
+static inline void do_mips32r6_##suffix(const uint32_t *input1,        \
+                                        const uint32_t *input2,        \
+                                        uint32_t *output)              \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "lw $t1, 0(%0)\n\t"                                              \
+      "lw $t2, 0(%1)\n\t"                                              \
+      "lsa $t0, $t1, $t2, " #sa "\n\t"                                 \
+      "sw $t0, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "t2", "memory"                                     \
+   );                                                                  \
+}
+
+DO_MIPS32R6__LSA(LSA1, 1)
+DO_MIPS32R6__LSA(LSA2, 2)
+DO_MIPS32R6__LSA(LSA3, 3)
+DO_MIPS32R6__LSA(LSA4, 4)
+
 DO_MIPS32R6__RD__RS_RT(MUL, mul)
 DO_MIPS32R6__RD__RS_RT(MUH, muh)
 DO_MIPS32R6__RD__RS_RT(MULU, mulu)
diff --git a/tests/tcg/mipsel/test_mips32r6_shift.c b/tests/tcg/mipsel/test_mips32r6_shift.c
index c4389b5d232a..7b419ef05f28 100644
--- a/tests/tcg/mipsel/test_mips32r6_shift.c
+++ b/tests/tcg/mipsel/test_mips32r6_shift.c
@@ -21,6 +21,12 @@ static uint32_t ref_srav(uint32_t a, uint32_t b)
     return (uint32_t)((int32_t)a >> (b & 31));
 }
 
+/* LSA: shift rs left by 1..4, then add rt. */
+static uint32_t ref_lsa1(uint32_t a, uint32_t b) { return (a << 1) + b; }
+static uint32_t ref_lsa2(uint32_t a, uint32_t b) { return (a << 2) + b; }
+static uint32_t ref_lsa3(uint32_t a, uint32_t b) { return (a << 3) + b; }
+static uint32_t ref_lsa4(uint32_t a, uint32_t b) { return (a << 4) + b; }
+
 static int check_one(const char *name, binary_op_32 op, ref_op_32 ref,
                      uint32_t a, uint32_t b)
 {
@@ -65,10 +71,14 @@ int main(void)
 {
     int ret = 0;
 
-    printf("TAP version 14\n1..3\n");
+    printf("TAP version 14\n1..7\n");
     ret |= run("SLLV", do_mips32r6_SLLV, ref_sllv);
     ret |= run("SRLV", do_mips32r6_SRLV, ref_srlv);
     ret |= run("SRAV", do_mips32r6_SRAV, ref_srav);
+    ret |= run("LSA1", do_mips32r6_LSA1, ref_lsa1);
+    ret |= run("LSA2", do_mips32r6_LSA2, ref_lsa2);
+    ret |= run("LSA3", do_mips32r6_LSA3, ref_lsa3);
+    ret |= run("LSA4", do_mips32r6_LSA4, ref_lsa4);
 
     return ret ? 1 : 0;
 }
-- 
2.55.0


