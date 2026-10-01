Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFF9CA5FDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxm-00084P-An; Thu, 01 Oct 2026 13:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxc-00080y-PW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxa-0001l0-Tw
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsc9W2686701
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RabJMfkrpTtJzTT9guCg6yM6udqwG7tCMiQTm+kL86o=; b=i1i19o5FxWgXUzNT
 xPcwJTNVpnTByTPnFEMRPBpI+V27mhGdOx3DxtiWGve7TMZs013TRQd6DMDNgrsO
 u/4P8pBHA0vgWNLpyXKeUH2pKTT7ZxvoaoAD8v+yTpQCyB+UHKJe5mglRyKtndO2
 7e19/wu+fJuKPcC5GEAXX2XghXH5t7MsMZPQ7NT4Q3yw5nXIxJtdSkI4atp6TbcL
 buOnRswzVDlCkTeHxCb9Cjh44k0dXtaDcytV64QEYjWpM/ZUvysaToAzMakxmPC2
 4UKIM0gVO2b8zqJxuoUcUuztx2S904z9ji3By3/blxbQoAX/Ubnyltol68s1557j
 4jW3jA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1t9a8nsu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-142f4306744so8715738c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877155; x=1791481955; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RabJMfkrpTtJzTT9guCg6yM6udqwG7tCMiQTm+kL86o=;
 b=Pfu8h0GZwZTzpbA6tzviAsR4P5qWkB6gf/xLbLwNfSMUINzFQJ8Rd6BaljeeQINms0
 6tUmIWoDPJ+/nGCW/nQ09vcqKKHRu3E+SC1JG2ycOIy64hYYHsvArVWU7LR23hRvCp3q
 n21MdejnmHIYTDSB6iB7csj8TPg1JmslEuXVJ7YiiSwHLd1rrgByHWr9zi3sT5EKA3A0
 sYjgiwIE27U55Gw77NVWm6nV0hM/LHLIwQaWUTthdVNTRkLPc/eCZP9eyVMVjrrwiFdu
 I7k4skbn3+cKqmINANggM2DdueUZF+Xw2FK2KK0QOCMqYndZZdJZUfJQLSZXTK/cYn0w
 nUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877155; x=1791481955;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RabJMfkrpTtJzTT9guCg6yM6udqwG7tCMiQTm+kL86o=;
 b=TSwGCXbm/gIOjOI8bbVBve49yIkwGKeExb7neSFhuTodnhsclXMDT+2Dvy+KxbVBU8
 /7IJrhzOWz6FD2CjrmCWELsiuUdGIF1qdZ/SHj4NdyJgCT1tR9hjvlHcCKHd7AEoZPvA
 Et1YQg4ugaoYWJTnOkl9tyeWLKr4uGBmaj/R+dRFr8QDDKwPzZ8XrTcgNF5doksyRERF
 eWo63B8hV1BWBmXy8vzmJX5WuiA+BI7qEfeFAmB98VWvMBaS6mdoKoQa5leKGEvsa2h6
 sNh6vUe5HepOqIZvi5BKRErmU1e8C92xab6yoyOIV7d07IbYx7e8xG2f49TTaAtcX1/3
 fkEQ==
X-Gm-Message-State: AFuF++kk0XBAE14LV6x3wbmoiO1/5QDxArNp487Psyoj0OsGB/WwtTyd
 iwBZbPGP0WVu2G6CraRQ0+3WV0ZLMte7ONqjIQ/Cbu3Ii8pIp9ErejBROT/mDhG2/Va9tjRKhj8
 X9vUH/gueG+8khIdNwEZoMaWwkZVa6PKRmsTtpqFMIMOZqPFIUC4rEfpNLL8gUKQ0wg==
X-Gm-Gg: AYBFou2wutbtYVdLZaNWklNOJsZQzhg5/txGXBRGp2E6R2pFZriabIBdaRkmwOlbDUK
 VZzC3A3MxY2P2msbhM39wlB2FvN2a5yf/QyHxCi0B5swI4MI81G5y6fKLvAIzSPf+zEtkysHgHv
 BRcAvzUjTB1+PEBiRxAAMzkkvlMlpmHWE2PA+GDicQO4YwMBf/A3MQYy3gpxErtiPYDTnWpSpUN
 CDU23WCBCzF44ZqqjTZZY2NBxqJYGQt3b8e+b9GytoSlrZ34SkUDl/t2kaw6FeGG4e2ZgCyWYFj
 AlRRdYrSIOnat1mp5klc07Ik9N8vcjYb4jy/4OmbKgZqlfcpREzghB5lzMU9VMSmtlHAlUav+2y
 ldHvAKunBQYKmP/55Oa9z9P9EvRxQy+j6cxUev8bzNvGhMFj/UVJmLwOKGasM
X-Received: by 2002:a05:7022:fa9:b0:14d:baf5:c40f with SMTP id
 a92af1059eb24-14dbaf5c55emr5697499c88.14.1790877154515; 
 Thu, 01 Oct 2026 10:52:34 -0700 (PDT)
X-Received: by 2002:a05:7022:fa9:b0:14d:baf5:c40f with SMTP id
 a92af1059eb24-14dbaf5c55emr5697435c88.14.1790877153636; 
 Thu, 01 Oct 2026 10:52:33 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 13/27] tests/tcg/mips/include/wrappers_mips64r6.h: use proper
 types for parameters
Date: Thu,  1 Oct 2026 17:51:49 +0000
Message-ID: <20261001175203.8673-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX7a6QNxaVDIRp
 ztsgWvK7DnhpR+6CFplGDjI3zrqL6BLm8zaczCp+V0wTwlwA/VZxaX0mR1+QZxjQDGwS5f1Y2h1
 CuU6sC54Z/KQZKokUNDIh/7wPJK3sZA=
X-Authority-Analysis: v=2.4 cv=N++8hG9B c=1 sm=1 tr=0 ts=6abe9de3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sMAugHrQ9hJZHays4hUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: pkonh_QpU8IAMX_jImrrpRvkq4n_Tc54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfXw7mac3uxWZBR
 g0o0rBP0VUJus1jnxUPO+mHvs7jm4AxAfbIFNre7TxAi9YrWDXSmKZv5q3eToU+4dtFEymzUaIi
 Y0jV9hXGey06ZJd5GrJxsOtmqMhPkdG+H6/SsDBEXMSYDYuO+seyVLZat41Nakn1oaJeZEEJEK4
 JduKWutDsSnMduXh5RDrBVLaoJptxJbjVBuLDaotHklaDgedNz26nwQvutHennbTyNrIyqoHNtu
 HbZxYX2/2PwZ82pK/hVFQCYwklkmRpZBnDaIye5jiUduyAdIc0ayv0nIP4DQGkTZTMKGmGoGHk5
 DkN5rZO1AGoGhN63vBlbZ0P/DFq3Wzxx1dgKLh5GX21zjO+lYg/MLzTWifmIF7jOLL2q4f0WseM
 29ayb0r3lKm7l4SOeRcHDU9LkT9yrzStveb9h05JODl3pA3IJc2cDWREqhYqSkb7Ns08XaKn1Jg
 CcXf/w19spuuStzTf5w==
X-Proofpoint-GUID: pkonh_QpU8IAMX_jImrrpRvkq4n_Tc54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-14-pierrick.bouvier@oss.qualcomm.com
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


