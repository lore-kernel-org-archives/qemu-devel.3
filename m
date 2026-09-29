Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635D4CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKF-0000Kv-Ss; Tue, 29 Sep 2026 17:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKE-0000K8-Jw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfKD-0003sC-0b
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THfeIP3300964
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KJdtj+F70769Hr/E743TrP8DH7k1SmFSubHsAMOt0Pg=; b=dcR0tjVnCNnJHIIJ
 9/gZKJDsYA8cc8BhAH4/sWd4J6OklxjUS6uTWp5SXAYdPOrl7Vtx7nRqy6HaJNMM
 2JNL39omga3P3W9oLo3MLkm9gaaekBrVRAPhivdWWqPPn/JUDK98BkjMw6A5lrlX
 6OkGwAtzyMp7DC9Nkg5vSU+4Lbro1a6+96Mw+gbdjaXnj2q8UJp0Jch4z3RFPvoN
 ZcBI+wpkJclBfK2nYxObtsK5tsp50bpDUKgBESqpkE7Y3BEE8wPELA+HJFCcrKhE
 +RFoL518Aw54t13xOTfFjC3pvpQ59C3MNQQfOnn48IaQTssngohrgfV4tcovQ6hG
 hZFDMA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx27p1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso2806730eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717119; x=1791321919; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KJdtj+F70769Hr/E743TrP8DH7k1SmFSubHsAMOt0Pg=;
 b=HhRC/No31oi7dTxVNGOZEZRnEP++uKY9z4TOgBPlVW+ovkjgNxWcCYGPd8nP8pdFVQ
 sybvK4qB0hB0uld8HubzPQmDDEUlzYGyTHpL3c1gjZTZCS8acK5EIQnUsRy6lPkXwiye
 eYFx5WBV2ZMzD5R2lYoUnXrvxe2ooLDbPc6LBIFs0guCT9DPQhK27jweHHdlvCzv7aR8
 W3nbcmjyEQaMO1H1Rteq/zJzafh79HAg+wW8VSNJvqsjYevbGYmtx80bgBwbBHjCK0OX
 zAv7zSmWSf/zJU1xiJLJtuEUS27D4Pvxxhzn66R6bDR0uFbEJWBKu1ju93eEH7zNLhR1
 Al1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717119; x=1791321919;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KJdtj+F70769Hr/E743TrP8DH7k1SmFSubHsAMOt0Pg=;
 b=opNtrGU4i9iLNVoifxFOxhmZeGeAldtxrIVGjcP7mb2b0uOep9FX982I+4mib+/lBg
 +q+xqUMbEK1ibNaq3kY0PK2b51fyTG/IJrduZ8YlatzdekAdVT4JiZc1+RmUa3ajQ4a3
 PatrpQqrmTUATR6cH/Wuw0DUIwrzyfX+DEpWchKO3s+eOHRzDbY8806MTi23kqC0ddnK
 0q3iuRlNfWOloA4lzKCAX9RRlcHHVpjHzbHUuOwyZz1kmHvLfviYwVo6sbjiVkWhxMzu
 3n0hwhJQxNQyYBBg2AwIdLGtWTBvo27G6c55U04WcwIqtdl8yO2T6pkbR7WMy6hfgweE
 i4FA==
X-Gm-Message-State: AFq9FYKJzeb0fo3mlLqfgA8B49EOSwqUi+r2j/FlwvNs6c578txr8i89
 HYgR6EAlGdZm8af6lRvu0oSEYpuzFfcLtqaHejPdgp0QA9KHUYy3EHOFkITRjUtfpmE0dDDpRq9
 5bXbageVLkeTUV+45pAMhtNlDAUEY0/qk7ITSYZRKuUcsLWK2+RZQVAh32n1eQNl4vA==
X-Gm-Gg: AYBFou2loiusFlhq6HLTf5JYqiOJ4wTh67zoXp3O9OehNm0oId8v8B3kxY7tBkZ75Fk
 9WKYMY+mVa7xU/rOjp9F0efwooUk/AsESDPsVqoDfIOqZwkz1UubM10uYvwOWPpiyh6x99+Lold
 q12MDEHZH6GSDsmed3QWVUJaDpUe68IaHvER/I6gWFXr/srE+2z4Cm+/ABh0VeMs5KZ/iiMLXD7
 Zd6b25LIDlvvjFHUeuHELQgyooGrkNaBDKMOKUm0RB87ir/fRndKKzq/n2mQN+UQ9nmuWhX06ki
 C74tNmOnUehY1nSYdYvBod7NG335vTjTHmu9T5ysdAm4vwPE4ROBgc5iS2XxBdozjrFJ2SbfhLr
 B2qNBJX4MwrUeS3D2zJDKErmdahjt8GskNHfe8XQ4mheDAX7vvOoQuPbL1HMx
X-Received: by 2002:a05:7300:6d15:b0:33b:f5b7:f494 with SMTP id
 5a478bee46e88-34c63bfdc53mr901627eec.13.1790717118610; 
 Tue, 29 Sep 2026 14:25:18 -0700 (PDT)
X-Received: by 2002:a05:7300:6d15:b0:33b:f5b7:f494 with SMTP id
 5a478bee46e88-34c63bfdc53mr901569eec.13.1790717117729; 
 Tue, 29 Sep 2026 14:25:17 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 13/24] tests/tcg/mips/include/wrappers_mips64r6.h: use
 proper types for parameters
Date: Tue, 29 Sep 2026 21:24:28 +0000
Message-ID: <20260929212439.110454-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfXxsHEDn69XhHn
 yq6ztqJUNO5zBJtVCRD1NO6hPAKDiJ+9OlHa8VYSfNdmYuvbzEGnkokY8LQX2O0BT+DwkiFRyZt
 3nGA1Ybt820EoPT09UFq52YzfKHkgN+42G5kEk/KH1d8ruH/f1lcLIjKr00l+IHz9CCkMrFBvSl
 Of97iTdOO4wSfz1879ZeHlsSUU5JuKj27VUr2GBqTMJkHDwdgZpkm1milJXbr0th0ECGAuENv21
 uN781Qt3yrZkRL4YJsOiQOjRxsHpNGDfTP+RJfx/FYH1KNn3HvGrkaT/tdtrpEcu734ml4lXnC7
 jgacMXhBcisgoYr+Jc/0wyqyXC3bb+D8VOi0uXPy3ujb1TwEonabzwWuvCIidQBI8ExlvOEg8I3
 AprekTISkYiePMQKnahQsMEP6elggZ28gO6KW0J4rE6rylzuTJYJhZa4FvIPiVcu2GlkLtxiCil
 GVHRYFa+Pg6145ewqfg==
X-Proofpoint-ORIG-GUID: ch2Lq8a5vuy1wA_AeU1LvOECDKXKfbaq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX4S1gTHNZYSDA
 sVx+8cIWcWySgsySE8cB0CtbLyrmEsfnork29GlVWR+iGFf1MbXX7eUB94YP2TP1Ml0NaGAM+/6
 4ohZahPNKlRAH7YHgVUZRfRctQ6WN+E=
X-Proofpoint-GUID: ch2Lq8a5vuy1wA_AeU1LvOECDKXKfbaq
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abc2cbf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=sMAugHrQ9hJZHays4hUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


