Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2918606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dqS984zB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z4QKeA8M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIunE-0001dS-FG; Mon, 19 Oct 2026 17:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun9-0001bc-Tg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIun8-0005gR-5c
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:21:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKGau3628205
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aJMbdppz9E9
 ELlkt6Mdr5CwCnKqkVxkgmepyUugCPN8=; b=dqS984zBfISmvGQoFDOp4SyoV/O
 yEJZIOj8LWSMf7380OkLGCFx5UYsZ3ehH1llT9IXpCJ42eiYpQsAUWuju6g2I5vV
 E+jlGxGsWapySS6AgtI7GSTRl1aLfI9CTgDu8rP0qwVRZsNANOV+Mzv5gZso9+e6
 KeGI58JtCAutTHFeSdSR72MJGgYbbbK+K5IJeDrg9CWZAUU6I0ZEucW9QliTXOnc
 04no4PB9+ZOuekCnzlfFzNJzyKgzJzhhN9EM462onJmKQb89v4P0vjsQFULJ0V5K
 pEcZ1hsGgU3p2fUpRC/olhBlU4Vl6P8QSUDMefo/4NvwL7NJP1Q4KNLe6DQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gptu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:21:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd5ca3840c5so2882567a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792444868; x=1793049668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJMbdppz9E9ELlkt6Mdr5CwCnKqkVxkgmepyUugCPN8=;
 b=Z4QKeA8MtirjHyCM7XPPLeiBT9jvv3LNCB71tSwjSrw1GwFrM+xg0OP+nppUFp0YxI
 glPEKF4Bi/jNKyzRXcjE7V+ehpf7zpAsLyGDqteRqXnvhIGQGTDTIlv6oqf+xDb/yzUR
 sa+Fpfi5xIR4Moh2s+WYrsoWMLJo/8FvogWD91Jn9Ts9AtY2+B0TujcERTkmZkUhKVeu
 R8JSV4eAtu1y1ej+zJrLfkt5rEr+Iuk9BaFKLwj6TrDe1hfM1UDiyNTJq6xn6vAdMIjm
 kqsX22qTjhGpvgCxiWmKz9ICUHmCV7FDcwUprZwJjgmrczpwdPBFPAhvGv7MZ2zXiVmq
 PiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444868; x=1793049668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aJMbdppz9E9ELlkt6Mdr5CwCnKqkVxkgmepyUugCPN8=;
 b=rVp9UQ6+2sfBqriscgJXNRHtiNSejaA5lYw7eHOCjg5XU/ye2QxQmbM4zmDTTxklNY
 hEgi3Csgt2pi26X754/b6Mh5poUQ8iHox/7hLpNswUj28vwl0BTYW7gioXaaB3wjJFvw
 KbhV52Fpffq59Wx99Q2We4eEu+yp6PdUvOs/kyEykvNCcrWJpG4ZKyzG4tj1lXUUbdS1
 OehZr9ci9uyfLRIAUhhYz8WvhzjQwX+VHTzhFz3rpi7Ya0aAvVGBhCCIwho+htFhsG9c
 myuIdNrvVNk3aeznmX1PxYltgFGtu5V1LmsGZgXjWFq4ohMRkiAzL0d4iWQIGH/iM3q/
 l2Rg==
X-Gm-Message-State: AFq9FYKi6QAG3FiMJvfW4OvUdynyfr80ZRB5feB40tvuP7r7bXCJAU2Z
 OcQhUNfIsniRTidz68fUzdxjsRtmcH5cQudyLPrYl2/LmYkw0FD8taJbG0XUSVbG/ZB3j7Vg4NS
 yACh19Z7Db6AvnYSGCbk+Lt23FsOjcBF8HhDMMwr4BkrPBlHPFKdSImR5dkmAA1ym8w==
X-Gm-Gg: AYBFou2gfmietWkJVqWP4gVm8PTX4RiLNBkFnfWjlK7tv7PuflqtrxtOnKs1KpCxl0E
 vym10RfrmRlw9aU8Zx+DO2AbxGnJfWja0MCDMJgCyg/TY/mqsoNXEVWBy4sp4kRlxHvaBLIt3xB
 XjSOpn5cnk76JhZ1taivfWZC6uXmxmaXBaYb0W+MGpp8EG3yaTEkA0mPd2TgIvVI/rSZyW3AlJD
 Hty1IPDdX37OZ0QL1y1zsgbOtEn4GHEcsfzSlNTT/YGhqs68ZUqy9Cq2SaHnYy23oppG/rsPuru
 lPHXy8MM2aBAnMTo7lft9hEqsbgvOxtYNK1PX30T5uNHkVb42/bHz+aU+LDbC1LDZycaSiZW8LK
 FdSKsPnebcb3O2WWK8sm7KupVNt4STIHl/ogAwtS60IsuhxX0Zmt0+1tuqxgxOOU=
X-Received: by 2002:a17:90a:e7ca:b0:3ac:929d:ba5c with SMTP id
 98e67ed59e1d1-3acef55cd8dmr8860092a91.45.1792444868310; 
 Mon, 19 Oct 2026 14:21:08 -0700 (PDT)
X-Received: by 2002:a17:90a:e7ca:b0:3ac:929d:ba5c with SMTP id
 98e67ed59e1d1-3acef55cd8dmr8860083a91.45.1792444867954; 
 Mon, 19 Oct 2026 14:21:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60ec4457sm863243a91.6.2026.10.19.14.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:21:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 07/26] target/m68k: define and call helpers using HELPER macro
Date: Mon, 19 Oct 2026 21:20:26 +0000
Message-ID: <20261019212046.149572-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX1xdkiwRnUml1
 pjrPD25Yt9XkM3/56faiuogNmpYiKanLNWd9FTMuLmVsGyKeBr51e1smquW58VENLo29TENdqBf
 jV7SIHr3+kGYMJNvMGE1ubWwUHVK5HO+hQB01xxC9i3i1rL8oM5RXiGDOoAEdbJJZy22/BGHG5+
 xrv1h/4fh2dDfT/VyKZOmvUrabm4ByRpWXwTkcI0dqkOQyeq/BKEks/ycCrlz9svcEgcuhsoteQ
 BD/IPLTYpCvcUSZsMgnBofdykjeE34QyYgjpsp9jbVYe5JTrCq0i1Q+pZeYLuXUFZPlSs4OkeU9
 ZldI3i1jS3hmktBN5mR+SlBqFHwUnluI0vS6ZuOrI/+7dbHnZdIZMcukMZNk7USXPtLJBs9VtLq
 zltHfW2lsfkp2wYOZ37ntMRnyLmJmZEepKqkzuPuK5xLtOIquw+BJIwcmwqHHSmnZSoq3GEd8hf
 ZnJLqoKFt2dxfw6UKHg==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad689c5 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VZheFmm8EoinJ6di3KEA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5tEH0UpOuusB
 vyLha/vS0ZOSxE0NTP7AZdLe39z7oMAuocUEii/hOJny8qNegYwjTtuZpvmvjNR8BDR9dauN+TI
 jMc3J+Hect/U/JekO8jH64CorPlEySQ=
X-Proofpoint-ORIG-GUID: 9FPNpbDxUoDybmHT4QkiRcyh4E8ZkXq-
X-Proofpoint-GUID: 9FPNpbDxUoDybmHT4QkiRcyh4E8ZkXq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

In a upcoming commit, we'll prefix all helpers and helper_info with target
prefix, to disambiguate symbols between targets. As a first step, we need to
make sure all usages are using the existing HELPER macro.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/m68k/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a689814..12dac20db9e 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -1077,7 +1077,7 @@ uint64_t HELPER(bfffo_mem)(CPUM68KState *env, uint32_t addr,
     uint64_t data = bf_load(env, d.addr, d.blen, ra);
     uint64_t mask = -1ull << (64 - d.len) >> d.bofs;
     uint64_t n = (data & mask) << d.bofs;
-    uint32_t ffo = helper_bfffo_reg(n >> 32, ofs, d.len);
+    uint32_t ffo = HELPER(bfffo_reg)(n >> 32, ofs, d.len);
 
     /*
      * Return FFO in the low word and N in the high word.
-- 
2.43.0


