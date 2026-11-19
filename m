Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F91606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f6JJ6QFL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RLcLbtR2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAUn-0007hD-N1; Thu, 19 Nov 2026 17:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAUl-0007gO-Dd
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:20:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAUj-0005I4-Ud
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:20:43 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Sql095109
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yYpdDSE406LOIcCrkrJ+YT
 +j7TkkUbxJjMJj6VJnTzM=; b=f6JJ6QFLX/sA68SEGEu8HnkbEkbFm3iyNVi3wk
 S/KJw/hsXO/iVL5467o8YyCEF/01vOZRPofbKxBVne0HAxojHdE57WMr6tEDiUyV
 f4J95yRTPqr+zvsLJTFCxIDUm2SKOyETQ8HLGa1690WhpuC4vjvAwBkAWCBIBbAW
 qMP9mHqWtiHC8bYfWhKiF07gBrsHwP5Hamd5dPAtUSiaVQxRWxzG7ZkplpiGEC7V
 r9yPLakzX6BZBnzzmrUdkKN4QTtfbF+3cEjL3f6yXwy78kNTOL2RHrGnNNZ6Yr3e
 UffughXAr7Y8mSkTeYITAnUIiiKpUGMOZa/4akLPv+OxIrfA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1bhpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:20:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9211d51dcefso6994866d6.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795126840; x=1795731640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yYpdDSE406LOIcCrkrJ+YT+j7TkkUbxJjMJj6VJnTzM=;
 b=RLcLbtR2lltEjVsKQW8VGVF4KoC9CVREpykbcTLQErZNsxPwgYNkwGuOdtpM81zLbu
 JLkJ2nGkdEHp1M7xafE+A1GBFVwJviPMmTSLjuhfQ/Gaf00Q17NrtU29k1YIMSDL/quB
 xozyAJY8rjwk5syfHKr2WqNn/ukYACu93MB6M/cGDPASafk1dPgFRW46U5eJ5ELSDpJy
 GnTB98ZUvhFV7Df7U/GCN2voDedkjKgqwC9Mk97vnmVRV5cx+sYtyeofg9Ze8nIsEj7N
 9U8bDlyMkshTg3Q52YmSrvU7dtv7g+6FORqQlEbKJMjWSnt5Il/1B+tMGPVFlO+1qVLi
 xRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126840; x=1795731640;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yYpdDSE406LOIcCrkrJ+YT+j7TkkUbxJjMJj6VJnTzM=;
 b=TT05PdcT3mYrAg+tqMhNDICGH7RBhQCeIA+BqtGJng2n6+UsHX9VylrC5QUWrEFwJf
 1AZ9XpuFEqojIDEJ6c5oXwe0NB3t0IB9LXaUduqE20iqo4UMErToRQ6AQlWUGKzPOvrg
 oIM/Te+Ns4Px0q2eQFWKSetim02AKwD/3K0I+MnKWg/LQX6mvO9RQCTqC6ztfGDyrhjr
 f1FsAOW5Hm2aSUBdOYIqz9zbB6y0Trv66miHoqvbspuie3y+cFWdR5iwHRLR6Yuyaz0N
 bN+MCQpzHpsZBzryClDoyk81DXOGH1TCRH/AJyWkKnLzXEYLMmBKCmSaMUcO7EijLp2s
 36oQ==
X-Gm-Message-State: APuU4Z+FqBxbjbGY2FWLyu1frWNLw8GD9If5tpI8T53r/MEn6ZjUGH/E
 DhW2e6tEdrW38BtKGxJqE0lvUoPWDyotLQ3HgE7RiqHdVaGmS2so/Q8WHtrIH9ivUxXmb1q+EMK
 JaDh/tOfCJqBcK/QevuMojRTk+nT80A3DdxsZG07L+aosc+Uh7YcTkQOjaf+P0b5NVkrH
X-Gm-Gg: AYBFou1nBc76vU3DBL5VEwImwhp7Mv0Ubilwa/vvrea7GxD18hkoKo3UYjdWlQRdlzO
 DDDPnWRKwS0XJfcMiUilG3y8KXPxvrn08sXKNklSS3Ps7P7c6Ood+MNGxfsAhGDAXW4vJ8joQ/W
 hLxAhQHgXbtymDr0FyNjcO3DfbJ8A0wrPL8yAr8saBG4Eo8WgJd/G3klZiEm7oCfGnc1TmrXO6p
 5g9SZfPkot+SAK/oRShHxF38hBW9Hnb4itcxkO9Zb77AlCu51ZUyv59tjn04WhDwxBN6oaGkLg2
 OEbCNzzJ8G8bHWmZYsU4L5iml5esIr5JtpqwEgfI89cWSQQPEd34ogDtBdhPpxP8KR2DRKuekSn
 +G1LZBjHt3EK/8/D36RT1ta/jsd2rGgBwz+zXpvROWu2HwKmAzqa0Dj4oPkEgaTUuVxKyObrYGq
 O/hBpeAPcSME5jhQ==
X-Received: by 2002:a05:620a:28d5:b0:949:6ece:8aed with SMTP id
 af79cd13be357-949ba9aa388mr181915185a.36.1795126839569; 
 Thu, 19 Nov 2026 14:20:39 -0800 (PST)
X-Received: by 2002:a05:620a:28d5:b0:949:6ece:8aed with SMTP id
 af79cd13be357-949ba9aa388mr181912285a.36.1795126839084; 
 Thu, 19 Nov 2026 14:20:39 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm67696945e9.1.2026.11.19.14.20.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:20:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/riscv: Keep cycle overflow deadlines in virtual
 nanoseconds
Date: Thu, 19 Nov 2026 23:20:36 +0100
Message-ID: <20261119222036.71913-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6aff7638 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=3w1Ni4F6IrOKQU0vGgsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: cHTUMvryydrlRv9eIv8SdDoNQQCq5Msn
X-Proofpoint-GUID: cHTUMvryydrlRv9eIv8SdDoNQQCq5Msn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX1da4RWE/Utl/
 gOMVoMJB/cXSpodWId+MZYwKPPR4f2N89G6e7PpenOqbs3OzWOWV4Iaja2GCSoZbqMBBWc8e5EU
 MZOb1+4RGldTye5jkRspKZIVk+0L4wRHTImgj/ivEnSSEL3P43MvPPbZDRHWBpgxDtNE26cEPWH
 uj0gZDFbG/X7+DHrC+aHkAe4TQEal1C0QufM/PGjt/oOXNFXdxYDaBqUm87STvn0fVSQE1kQQg8
 GmalSOcrH/+Puox3N7txMMm6D+ea/jaDJGgVyr3TJqU6ZMueO40pUm8dXpvbP+EgG8ic9cpjHWw
 Wrj3uImAA1TUBl3+CXUNgbkdj9aWyBTvPtdxvyaH01C99uNvrGk2RlLdTppaqtnjxBkcNKyTMQ7
 0JhE9do5P1TPBXrEnEKG7NwlGHcCHPk5KJpQ1uIf7Gg5ad7qobi4K5BAHbXLg2OxVCDb5JDwZc9
 G0wuwrCxjblRerOpHng==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX26nKFt75/d+p
 wRyeQ4uCHU+Jkm5uHLi+CNDW+1e4lUlvKhboWVKBbxkoRvN+f4sX23RugALJ+ucn/63MqZDmfS5
 G4p4aNAFwIVY8l4iAZYf5WgpJp2A2SY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190089
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The cycle counter uses icount_get(), which already returns virtual
time in nanoseconds. The PMU overflow helper applies icount_to_ns()
to both cycle and instruction counters, so cycle overflow timers
are delayed by the icount shift.

Pass the counter context to the helper and scale only instruction
counts.

Fixes: b2d7a7c7e4e30 ("target/riscv: Implement privilege mode filtering for cycle/instret")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/tcg/pmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index 0165faf06b86..cd4de9cde0ab 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -281,12 +281,15 @@ static gboolean pmu_remove_event_map(gpointer key, gpointer value,
     return (GPOINTER_TO_UINT(value) == GPOINTER_TO_UINT(udata)) ? true : false;
 }
 
-static int64_t pmu_icount_ticks_to_ns(int64_t value)
+static int64_t pmu_icount_ticks_to_ns(CPURISCVState *env, uint32_t ctr_idx,
+                                      int64_t value)
 {
     int64_t ret = 0;
 
     if (icount_enabled()) {
-        ret = icount_to_ns(value);
+        /* The cycle counter counts ns of virtual time, see icount_get() */
+        ret = riscv_pmu_ctr_monitor_instructions(env, ctr_idx) ?
+              icount_to_ns(value) : value;
     } else {
         ret = (NANOSECONDS_PER_SECOND / RISCV_TIMEBASE_FREQ) * value;
     }
@@ -456,8 +459,9 @@ int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
 
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
-        overflow_ns = pmu_icount_ticks_to_ns((int64_t)overflow_delta);
-        overflow_left = pmu_icount_ticks_to_ns(overflow_left) ;
+        overflow_ns = pmu_icount_ticks_to_ns(env, ctr_idx,
+                                             (int64_t)overflow_delta);
+        overflow_left = pmu_icount_ticks_to_ns(env, ctr_idx, overflow_left);
     } else {
         return -1;
     }
-- 
2.55.0


