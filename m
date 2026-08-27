Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C1AC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRC-00027e-E7; Thu, 27 Aug 2026 18:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziR8-0001rv-Jk
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziR5-000731-7e
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:06 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLnNk795072
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H90YeMffemjNQbR49Jgw+CQSas6HhRfw4GKAa1N+8NQ=; b=c3IlmEJCOsxB8zc3
 MXQwQ7gCEbyHxyWRNFLi42bOgKxofi2TSFE2kPbImqMljxRK5cFVtaM1Oo3g/dO9
 PLUnGZh3NBxwIwKJZGeOhlAvAPIdyhautpbIbONoXiaBtU2b0PSveacTvFXPUjD7
 P15tGYcJD6Gzqkr9AWf/KyERAC9lyMb+WzBPoH3aI7k3Pj9Ny03qmQUskVJSc02C
 cxZcBoKIqek8oSbmmczP3AYBAM7yfVuJbihRq8qhHpTMGOJp9UOBjAvKjTkUi1mo
 /K9EmKDXgcjvzL5ZJfLQPsyETzLajUZsfz0KSB3filoeoB6ExXGSxC0K3eS4FpOp
 tsZF9w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjnem-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3968dfff779so461484a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869141; x=1788473941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H90YeMffemjNQbR49Jgw+CQSas6HhRfw4GKAa1N+8NQ=;
 b=LZP6VHrQbJ3DCwGVyMQH3M3a26W7mzieCLyxsIxGR6T/6sNQAMjuaebIS+UckUWJM5
 UW5HMpJqmYXVcBVPBsknL2Y0CZo6SpPkUuRs1VFCB1wNJTsw6vC2DZLsTo+/3DNqv1+N
 w1a0Q7T+INaIfSgeWMsVs339a2JXr7hl0r5T/oyv5K8SdP8yg8Q3mtaJTpYpk0cPFO1U
 MwFX6MfU7JTNWcTMQWsQX0wNtqPsXxn3DFkgewyjsH0idFWzJYGphFWkMzTo9acXo2fI
 NVWkJ9fQgKWLwAQpqiRK7pU6hFXaXWebCaHCeSRQCcHBdFSpv9sP2yqQamFqe+jL2gCa
 PD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869141; x=1788473941;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H90YeMffemjNQbR49Jgw+CQSas6HhRfw4GKAa1N+8NQ=;
 b=ET+U6SxVUe4ifMUhegp2Jjf3RvYHDB4IVfFUnZVpOcYGHnteSVzYPnEGsXSudeUsOr
 gwOGoctUYsA70G2nxyvmFV9s+GK1iFXhjXIzMIHidGwRyOrC1EnKwyjFbNOCqori4Ciq
 CrgDij4J9oxvjOKvaqIhp6UAE0HxWBIP+s0uhY9XkV5EIK6mj2wDJM1QVKNGQL3iW+EY
 55AZXOdjHs8ePmogVmir7TusgEGNA8AjEmskALSK083pic1QmYbaaa/moMHSnde0MR+o
 6D5woJS64jKNUbAmqaWlGRcBoOMMr4KUkQMnGlKHTYiqyxIF3k2ySSY6QhswMsgFmmwF
 cfPg==
X-Gm-Message-State: AFuF++kUqwnZ/ChfRuFpovMjM0RnbI9BM2+sbK1qJoumJouxXTFLSyeX
 hDKryxxdrg42U7f6ReMkGqdyqDf4Fm9oQ/tCi/10jt/EMNbB3+uknmzZesmXAjJqgVtdJZIG+L2
 Cb/nCVFVy6Ll5QvPF3Nh42Z3/Nn8jHJ3bGEOQccjKjizJ7oTwWe+qY/HPsHJ4aFupuA==
X-Gm-Gg: AR+sD10B/JoSVc9aG7rggKU7cC01vNQGjKLIFpEw3FGPeQuXibPj2W2LqYHwAMlKmD8
 BPQQfDziTFXziDSGiNN8bBKPizDuQd5apXebRcpifShcd9Y2/eSd5SZHif9KsHmPKLjbMKHG7PE
 tTubcw81ttpnllzoZQqLVjLbTY0G/3QQRMEPQaaqxYaSf5JSL1Y0GeXCyV9dnksUdbI9k5pqZM/
 LeydSuBYmLQyEXO7CDuEeQSdrusVI1V+vvkjfrbcoSOYG+/CtEQb0LP1X1EtoYyL4ZaCB3uajRn
 zIBuEzhyQeO3lO+1kiVEljD9thIswvKFLCdfcHtlEgiR4xiJwula9IoPFSADXHkEKcAjMAdveLK
 2/p7iqH0pH19DAm+D/YRnOeBpElMX8wzcsvd/u9Qp88Ti9DLi9WqTlHscKPU=
X-Received: by 2002:a17:90b:3c47:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-396d0f25facmr2487122a91.8.1787869141171; 
 Thu, 27 Aug 2026 15:19:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3c47:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-396d0f25facmr2487088a91.8.1787869140760; 
 Thu, 27 Aug 2026 15:19:00 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 041/105] tests/tcg/aarch64/system/gpc-test.c: remove unused
 variables
Date: Thu, 27 Aug 2026 22:14:02 +0000
Message-ID: <20260827221506.91574-42-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX6zF3aWuba4hE
 ndG0+ql5cwY6zWGHGcpTqSPbSR0Trj6czFZv4KkizhWp11LdN7yut8a5YnJXllVIRB7vjDYkzvb
 CsRmuaI02S20b08I3EeSCpnrhC8mEq8=
X-Proofpoint-GUID: H4-ivt8ggAZK7wvXwivQ6FOdicgzA09G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXz2e12Jb4IE6Q
 ykhW0/GPuXltQ6ucN2plB0MuobVBOeskk2Z/6N1Eg5sunK25cGL80gMobpfOKD37yLX4HJwUIwm
 I2OZhWYxNJwjE8i1vYANuLgb/kK4e2LqFBNi0sx7BsjhnD5lJ34sHu4WTR4b9sP+3DDSGEkIDqH
 4kHgx7fZ46ReRdLHl/TEDNmWV0eqrtSFQbUnGYK074AvuQ4k0TZ+ggmNJWPwgyOlgZOb7Td+wba
 qMGRRoMZb0G4+wB/EmNse62isl5s0dPvwNAS/7scDL54D788LWzrzFhLOW3HEvpmWWbdBaNZqlP
 /7UBOnu0qeSLfZL9q1a902NAPIfBVfJSd1CaG7FyQVUlAnNS/TdVl8GerZTw/XPKitRadQ8zh9e
 f7sisdcOy5DOQQDX5Z6zdNfh8Q3NY4BQgyECrPBJZnLzCvyJBoRZnepV2EbWqhrCJMfM+mWMwcI
 3iNaHFqUGzjUj11TGmw==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b7d6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=EHQcJYNh60CgIu77JDAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: H4-ivt8ggAZK7wvXwivQ6FOdicgzA09G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/system/gpc-test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
index f26b23efafe..0ce0ffea277 100644
--- a/tests/tcg/aarch64/system/gpc-test.c
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -28,7 +28,6 @@ const uint32_t gpis_per_64_bits = 16;
 
 int main(uint64_t sp)
 {
-    uint64_t out;
     uint64_t pfr0;
     uint64_t gpt_base;
     uint64_t rme_status;
@@ -38,10 +37,6 @@ int main(uint64_t sp)
     uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
     uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
 
-    /* Mask is FNG1, FNG0, and A2 */
-    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
-    const uint64_t in = feature_mask;
-
     get_sys_reg("CurrentEL", currentel_raw);
     currentel = (currentel_raw >> 2) & 0x3;
 
-- 
2.43.0


