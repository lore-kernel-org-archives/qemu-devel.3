Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E1606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kz69ImYQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dlUH0vax
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj54-0005MD-9j; Thu, 26 Nov 2026 18:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3u-0003UR-Fc
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj3r-0001Ld-HC
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:39:34 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQK03Ng1715668
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qj7MJJu/ul1fwdHBgKBE67XMkmj67eYZHGt59rGlEe4=; b=Kz69ImYQUuNAAlCO
 EVdzWkXyvDIr/W9JJpvi0wuOE0mPsXLkWnAPscjnT8e5Josj9CgTP3JagOGG8vMH
 UGAlJk+FihlJnu5lCEpnvt3hGiht7sMryuMwLQwLIDrk6srEdr5nxHqPDcNEs6Ru
 DSRLECCjZMgcKvgA5T5r1hItBub0ZxI5gp1nswRLeLXZqXgyOtOvrz1wGMKPGtYg
 +6fBRbJxFsxU3JkVQtera8LT6Ux+HsdioSUY7sJjxhUeAxSKT2Yym2eiFUtfNLZ3
 AGnpIbuMA+kt7csxjf35MjqFWvMxBaJPD5EQcAIEUNy8oaun93UNJsvC+WdIHQ7J
 ElfSuw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2uaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:39:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9211d51dd37so152644996d6.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736359; x=1796341159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qj7MJJu/ul1fwdHBgKBE67XMkmj67eYZHGt59rGlEe4=;
 b=dlUH0vaxKjQ1IhKOiNgZ8hKSlA0xNXOTJuI9yaQQyZ5UuAawZyOpTsKcQAOtk3Cu0D
 z5owzMy8iurCxd2aIIMGy080UH1YptLwXSnAGNeHBQp+imetv2n/7SeL0nn7yXZ0dOhI
 qACMRJy0rkHC0ullRBSTu+Um29iiP0WBL/5fNE4GQ8Q2+PHwevS3AWIp2wdFKXJ0Q6gS
 3sgIdgYLANkEiQ2Asr5JoodR0sDrhE2zP1TrRBdf/gW0pDuwE+PFKRvAJHQgrEbxXiTW
 T2GJ1n6nHW+Hc5xCrNbJ7xpafUjrjaubv5DjHqHXaOgnPiC6TbDqvKniFjl7cGExNyMS
 BieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736359; x=1796341159;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qj7MJJu/ul1fwdHBgKBE67XMkmj67eYZHGt59rGlEe4=;
 b=jv2T1D/8dCvwCCpd1XGS/8Z9adXgq81eGW3B/iEHFFw2d4ojXSkE0J0sgAweWXrZoV
 8itBDTMs8YEqOPIdMuCWaKZ/5re+VK6lF/qxj/GdqLh5UvS+rZKfd1B6JOKaQIbwexrD
 fs2TXkMtHaxXMtAAI5Uqprn+630LLFI8U48Sk7wGuiqBaonIepgTDkVftKGb/h5KUgc9
 9Il1j0GEsRFoZ3erGZ/wA5TxsU6VYuikt+93NQ9aXuXWTvLLNur5Tx+22DgtyaqIvFMO
 1i0RbtFeXX++cwwpFSfhFizwElahFmaQ68yditC/fyAwq15c7Zgfdvp2J1A29jVhBSnj
 XF2w==
X-Gm-Message-State: APuU4Z9ZCLdXeo3EVIxRAOLydhJTNaqYiLdGyEcRroYTpNyYsgChjowo
 9/rxf+s4hDV3UN1Jh+UDcPkE7xmLsn5b4nqx3TF7oF8k4z/AMUw3i8wm0HnVRepTx4C4Oy9yIa2
 Yyt/5oycs5ZVd5L2YuHVYr5oq4skyfjqPFRRF6fOaD3pz9WDy8ohanfDsFiK9lr2UJQ==
X-Gm-Gg: AZFdTZc/xBYHB9FCLY+4icorKMEcJYh8HohOE+Wrj7KQSHV1+qk0K8m90PISDmU9IZk
 swBcKc12CV9GT4UhhT3CywUdGIWPCQm6UMyVjgXoQLNMsh3PKwZrUonRzA34w/kkfsISJPlb51x
 NSm7G6r+3r7g3hZzd4HK/GhNA3LlHA2QuD19f4UrRIB8IIw219dnvyuikDOo5kaSv29g4TU+itH
 0qackQTZ0vc6psialgOz42FXyK5yUEcs1JCR6QO5yrTwSFQ2d2PGjHwUk+OEMVEKJRTQuz6NlWC
 BwQzzJqJVnoVDy926hB1mLVxxb3KLbPcd3mi8BsbAvwuc2CJ9oI+h379iB8RitCqVfKa2yB33sD
 VFG1/EK+2br5LW7E05bgw5z45o1u4TfqeNN7QxYNBUqxGCmskIjLwWBaDQjRPoQCkYZQFXfsoVI
 j3OtkZ6mViIpzsXA==
X-Received: by 2002:a05:620a:6496:b0:93f:5519:5e87 with SMTP id
 af79cd13be357-949ba8483edmr3531244885a.4.1795736359010; 
 Thu, 26 Nov 2026 15:39:19 -0800 (PST)
X-Received: by 2002:a05:620a:6496:b0:93f:5519:5e87 with SMTP id
 af79cd13be357-949ba8483edmr3531242885a.4.1795736358486; 
 Thu, 26 Nov 2026 15:39:18 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab9cf005f2sm35990857f8f.45.2026.11.26.15.39.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:39:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 24/24] accel/tcg: Update TranslationBlock::cs_base description
Date: Fri, 27 Nov 2026 00:36:02 +0100
Message-ID: <20261126233604.67722-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08c327 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=hPUV5sZZM_X0ifaUgZ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX7ZWuh7tGTKal
 F/LTItY/hcT5jBShLTcf/bR3pzDppOCk1Ap4J3E/MaTrSIncmXqt4H8gYgGlVHEl7jHNNRj/8UG
 3QY79NKkC/y9l6L6Ekoa6Sold0gbFkag49U4BdgVXPWf6YoSX0/c8SWM9Tao+vGJ+h4lJl1tFKS
 fcy5IA2aos+MKJr4CbBs1nfF2DFFGJoj/qY2gvmfFQwXCbgamGMGu8KuwoH3r9uJj5tPRi9ECys
 xWcSOtnsVUBHfSrZB4ndHpkwuFszUqcQF2X+BtLDaH4RymHuc4Y3RjjCQdpe7zYx7UFpTs1LhDp
 uxEl319VunOhApE/RnG6dzifLHo/xATFoC6xz9N4SuB4aiDSOKsZ9z9iU7lQf75VqGvWCNuc4mT
 jY/a00gJFjDWmF0Xm6hX+Eq+sBs8yQ9efJkD/gH/s8Z2uscPqHAdcJqW5nAGmlsZ3W44sL7yOJm
 CSRAZvDZunKtn4yoxag==
X-Proofpoint-GUID: jQ3_lgE3b7k2P4F6FAKZJS9Txn9zJsEQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX5VyVovvPIOVF
 CVMmDf6WpBSuNHE1MZ9jUmocKEr8a+/jlPjPgK4gVqVBW3pYVN45DjiTBw9DT7Rw0TNbKlIcdnp
 Kc1nhvVunsxPp16IDhKT59ExcEBlMvM=
X-Proofpoint-ORIG-GUID: jQ3_lgE3b7k2P4F6FAKZJS9Txn9zJsEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe the current TranslationBlock::cs_base users.

Commits that introduced target use of cs_base:
  arm:        a378206a205a target/arm: Move mode specific TB flags to tb->cs_base
  hppa:       c301f34e798e target/hppa: Implement IASQ
              ebd0e151149a target/hppa: Include priv level in user-only iaoq
  microblaze: d7ecb757d199 target/microblaze: Ensure imm constant is always available
  riscv:      55b490b58fbf target/riscv: Record misa_ext in TCGTBCPUState.cs_base
              1c88ab9e77bd target/riscv: Use the tb->cs_base as the extend tb flags
  s390x:      303c681a8f50 target/s390x: Implement EXECUTE via new TranslationBlock
  sh4:        4bfa602bc222 target/sh4: Handle user-space atomics
  sparc:      b453b70bd8e6 sparc fixes (first commit matching cs_base = env->npc)
  xtensa:     5d630cef4f91 target/xtensa: rework zero overhead loops implementation

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/translation-block.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 491de24d71b9..8fca1bd92267 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -60,12 +60,19 @@ struct TranslationBlock {
     vaddr pc;
 
     /*
-     * Target-specific data associated with the TranslationBlock, e.g.:
-     * x86: the original user, the Code Segment virtual base,
-     * arm: an extension of tb->flags,
+     * cs_base: target-specific data associated with the TranslationBlock,
+     * as returned by cpu_get_tb_cpu_state() and part of the lookup key.
+     *
+     * Targets using it:
+     * x86: the Code Segment virtual base (0 in 64-bit mode),
+     * arm: an extension of tb->flags (CPUARMTBFlags::flags2),
+     * hppa: the CS_BASE_DIFF* bits and the IAOQ_B page offset,
+     * microblaze: the IMM prefix value,
+     * riscv: misa_ext (lookup key only, not read by the translator),
      * s390x: instruction data for EXECUTE,
+     * sh4: r0 (gUSA region end) when in a gUSA sequence (user-only),
      * sparc: the next pc of the instruction queue (for delay slots),
-     * riscv: misa_ext.
+     * xtensa: zero-overhead loop end distance and loop begin offset.
      */
     uint64_t cs_base;
 
-- 
2.55.0


