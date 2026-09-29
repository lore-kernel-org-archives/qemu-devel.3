Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368D9CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSQ-0003Az-Sj; Tue, 29 Sep 2026 03:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSK-00039o-R3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSJ-0005r8-0s
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Tgtj861246
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=49r4XCTzTyt
 rtS5Kbq5zteoe0S7yPOuku/8qP7W3Tws=; b=A8yCwVSKYA3/mrenxOwn2Z8oDSc
 i6jq0Z7bFD3NbsdRQ23tU6L4xbHf7OoxJDQqBeC931q0iwEehdEIyYr4cokKRBOS
 HDkwReXkd/5TAeaQhNXiANRzc0K2KI1N1yK1MBBzrPDwjXbEuR8TQaXsRbCKa0Nv
 ekWeRBPwe1Yxm1BxcR4epGJOrbkw/9lyeuokj2xR7XTivFWvMngiFKxJpOZNKd6Y
 fPM4UZJH/oOmp0f2mAW0ih51UoRmlA3HqaKn0gaVygXZDqVjq0SnZXbJ7yJ4BxJ/
 ckJcL55kShc6jja6HojZvsEQGawRWFMvZhfjb78oWH0mI6Xsm8jAceD571A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmua9gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso503035eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667649; x=1791272449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=49r4XCTzTytrtS5Kbq5zteoe0S7yPOuku/8qP7W3Tws=;
 b=gSlmYVF6EuBGK+QruZoxtNP3DqrQntRQaL2ePhqSzvu3LKSi+dIZYOAjP3mUzzdztF
 cCAlPZLWcL36IMnjTn4mfQbZdo9BD+j8QzROta9xMFsiRrKhOzDjG3MPF1j2d1cCp8hK
 BUKCezrKzEyi0PKEfk9Z5OU2E1eRy9vkss0nE9Nsxtbzgpcs9Z3XXdDDpsGQBnb2q4pc
 GKJld66gZIWBqCk2HOFfYTrHzgzoLDXqDHvYaUDcLbc2+swQkIWUzK8fsHodEz+EVks2
 kv1/4ZPCE436VQAnTMUM2w2IVFeN0/N69qtOehWOD9y3hmH7RSxh0QSeL5FQuISnxxHl
 YTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667649; x=1791272449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=49r4XCTzTytrtS5Kbq5zteoe0S7yPOuku/8qP7W3Tws=;
 b=mCeDSUVB1XgWj+Rq0+BDAtyj9QKTxsRJVK0qOnsy12XRrO89mfNP+ZX0Bzux8ZuZb4
 DHRxKUSwE0M8CIuFR1Y4RnSIDRVGOyfyi7fxmyBDMaeNRn2IE/Fd1r7ajNwFDJ3Yy4Rk
 nr4rsKkSTyfr6RORzOhiVXkJ0v8ZQ2IcPv2/+5orATMGSPZ5ple1Ic0pEDNxIR5sYw9+
 C53UlNZ6zJMDuDnCPjHjmYIXhfhCtaMoAEZSNmcD2QKXydJdwQ1Zbynnzq0mnHLXwl3/
 Nq6AijyK7O46zSuC7sXwCTQGGBQb3fQbAIjQC29CGXPk4IICU8OmrrsfVFwTHLV0SVK9
 utcQ==
X-Gm-Message-State: AFq9FYJjJUpmRTcEq0iyTMchW2KjTb3Xc04lPFeNjpN+0zrEX3mqcQVu
 lUHfM+RQIYg4vSn3YiH0kedE+X5vPrIHEd2Kr5I0HI2ZKjH0smcJRgL8RbZ+S7XduLYezezgPmD
 f9hGXd6PXw5LLyybbYohMer0fyDpSGaYxEohVpaI7FO3Y7R3iX++KL/QDuU34KycTDw==
X-Gm-Gg: AYBFou3DO5flEZic8ETyHhrUegOTHGxCYHG8pU6EqITO2We5IpFLjLcDhETRbjxeaEu
 YHPkn+1n+/wDXT0XKdoARE1Vdmfqfb49zP7Sq4IV7DzL9w68EiJzkswGKOCLWKVTHUkfc204evc
 D56bpHZnXnRTsGi/bgwCf893/J8HxSBYBbKjNLWm+ka0QqWEbSBGPN5g06nPtVPmmS/R4W37WQJ
 VFbjWXm7n02jHMkNPjojSQI/SqiTHZHgdxFRcTrtXFdfSGb4eeWCyVqiGoEc74yQ3+wp+yzXQCV
 JJdnxYTEWtVdTjyHgBmJIIAoM8QudVxQvoVcSalZKfD0CPLFpr5SXOSEJwj1sT1+EYPlse7NslJ
 TmSad3n3zNc7t3WEYmiAgOD7feles2XECgzW7sR3HktaA+iSsAvGJbgoYDQ==
X-Received: by 2002:a05:7301:1f15:b0:341:fa74:9ab with SMTP id
 5a478bee46e88-34272853cb7mr18026559eec.31.1790667648885; 
 Tue, 29 Sep 2026 00:40:48 -0700 (PDT)
X-Received: by 2002:a05:7301:1f15:b0:341:fa74:9ab with SMTP id
 5a478bee46e88-34272853cb7mr18026521eec.31.1790667648310; 
 Tue, 29 Sep 2026 00:40:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 13/19] tests/tcg/mips/include/wrappers_mips64r6.h: use
 proper types for parameters
Date: Tue, 29 Sep 2026 07:40:01 +0000
Message-ID: <20260929074007.118970-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX8l+h2alBd5c4
 Y3j4GDUMI8X9dMgI/MKxu9GAfTw4ijgz2+6sen9g01ZuPwI0n2Yhk5lgnQTbWgypNKGCW2J1XlV
 z0jn24zWqQT/DLknUsSTsOZSCnd9lAUJb20XlJxJEbHgYxWrNdOWTu48S1LBNQBGow2TNt/4T1Y
 /+e7dzPb9eaHzuYpOtFbckdsj5rQ4kIjvZOtqZ50GBydrLP6Bfnl60Ud2ldH5sBM45VFm4f2IMn
 hufZIIXFX5w+mqjRaH+z94U+LSHpHzuL74LhnjcH8rr4E3x/e1MThwscpkVX11quVlmftwzevHr
 7Qq84VTgijM4SFf9hXcgdWqZ6sPShSBlteapcKzfC9db7IzeSJouNCqh3NUKUoLKvpztehLTpWA
 QoBJxLZjqiWO501D9A8UMiENiBJzA3idPSE/YB5MXw2kqDVHTtdkss14IqNZeDBteIR1qriJ+JC
 twSfIltTH92GHHGg08Q==
X-Proofpoint-GUID: 1Gip0UOtwuJCMyw1_HevRrEXTCIbBvoU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX9vTx6gaW95sw
 qtoKWagNFOrJDKWmjrMQ3eus8bjP8BzUg9T0cv6dRJTAB8ltlqwsbJldw6K3s7LZbR52f8woJeJ
 qDXuSxtN89oxofMKBilV309wH6Crho0=
X-Proofpoint-ORIG-GUID: 1Gip0UOtwuJCMyw1_HevRrEXTCIbBvoU
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb6b81 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=P3XslAPexR1e0_z4TE4A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290030
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/include/wrappers_mips64r6.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
index f078f534f05..615582968d3 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -26,8 +26,8 @@
 #include <string.h>
 
 #define DO_MIPS64R6__RD__RS(suffix, mnemonic)                          \
-static inline void do_mips64r6_##suffix(const void *input,             \
-                                        void *output)                  \
+static inline void do_mips64r6_##suffix(const uint64_t *input,         \
+                                        uint64_t *output)              \
 {                                                                      \
    __asm__ volatile (                                                  \
       "ld $t1, 0(%0)\n\t"                                              \
@@ -48,9 +48,9 @@ DO_MIPS64R6__RD__RS(BITSWAP, bitswap)
 DO_MIPS64R6__RD__RS(DBITSWAP, dbitswap)
 
 #define DO_MIPS64R6__RD__RS_RT(suffix, mnemonic)                       \
-static inline void do_mips64r6_##suffix(const void *input1,            \
-                                        const void *input2,            \
-                                        void *output)                  \
+static inline void do_mips64r6_##suffix(const uint64_t *input1,        \
+                                        const uint64_t *input2,        \
+                                        uint64_t *output)              \
 {                                                                      \
    __asm__ volatile (                                                  \
       "ld $t1, 0(%0)\n\t"                                              \
@@ -86,9 +86,9 @@ DO_MIPS64R6__RD__RS_RT(XOR, xor)
 
 
 #define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
-static inline void do_mips64r6_##suffix(const void *input1,            \
-                                        const void *input2,            \
-                                        void *output)                  \
+static inline void do_mips64r6_##suffix(const uint64_t *input1,        \
+                                        const uint64_t *input2,        \
+                                        uint64_t *output)              \
 {                                                                      \
     if (strncmp(#mnemonic, "crc32", 5) == 0)                           \
         __asm__ volatile (                                             \
-- 
2.43.0


