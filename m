Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84740C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0Jz-00011T-Up; Thu, 20 Aug 2026 06:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0Jy-0000y0-9K
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:48:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0Jw-0005oB-Qu
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:48:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KA2mTS2932707
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TsQDiH4jP/BTknyf1jAmKlwcJa8tXb5Af5H6J9x0c9Y=; b=BPmXjKLx/UCRwHXQ
 TbBCwD10w4zszS6+IdPOfhDEwFuqDgl3JXVwJfw8/SaTzt9/KqPy3HQD5O0n6iov
 LNs+7ksFGo7Lez9SntM4/P7f8iLty4ph80N2MvhfLilpQfOyVLM4K6UffQwiWmGe
 kDJGJ3J4WCec2k2RrjSK+z3sByg/OBlqFHbyiyfvXUv+3G67lR92opzIH5TcPWkw
 DWKJEmKoPJ11wBWQ+5SEJJPKkRZ91ZLOrMmEsSRWEVODOr2dEnqWVNbMtynNtG0A
 BSwx3Fzwro6FNfPTgIBx1oIWDCcvRGV+CkxCvX4A0EL0L/pu13iOoC5gqPY9DdlE
 NEL9+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0g5xg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:48:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ec3146553so396666485a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787222897; x=1787827697; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TsQDiH4jP/BTknyf1jAmKlwcJa8tXb5Af5H6J9x0c9Y=;
 b=DIkoCSwONE3qfL6k/5bBZg6j6jobPQUs5bYpNdqGzUGs6TW8vctjxT3UxxROagpIne
 u7up6fi0mchvv+dpnwWNyg83H9Pv0Tg6Cdwo4Dx88vpd7DmnISooPA/gfhDofWZnart5
 FrEGHHlGSpIpnmV0KHud9+EDdlHEiu7SujmfF/I9/GKxHzhoKG17ihQ+Nr7YwKjlYPGR
 5AybPTQVVddL2kq0wH0MD2RoA5bwMrEb6kmKM3VsXp6CXXe5wPLNlV+nPcyKONHgkWiz
 XvSyS93RDpc2OwKQUwYmv2pOQBTGCDF2nMzdcdEpvyC0cRwKJiMzODv/9o0pLDgao3Mq
 AgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222897; x=1787827697;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TsQDiH4jP/BTknyf1jAmKlwcJa8tXb5Af5H6J9x0c9Y=;
 b=mEFbtHwB7+tOzXO6/Lit9HGfnzt3aM8xBl3c6h8jyA/vN/XrHFSAhkWE7I/F89m7xD
 7FTlEuRZXFyJ/fpT1FKwlZLVHwBv0P67YQ7VL/L2zLD73LMdTTWLmY8+KW5wtMbbg1/s
 dwwki56l74fQJkfONP23mCOZD4P5bhxbyB1LUOnQNWuC0nvWx7Xr015ou+jLmq0yPNoC
 +rXG/VJjK4bD4UhYdOC5Il/JTPB8JB2mK9RyoUJ9nvyGMl7t1nPEo3QOVrSYzGWq8n/Y
 DyoaOTOyCgDkBQMHc+4GMaS6jlJVFzyMbduAKWuNorGYpWOxXE40Sx3JKPfgcz/jl4S6
 6H/A==
X-Gm-Message-State: AOJu0Yw82vo66y3B+s/RVC2EQjhOL3lYiAAxqYN1CpoPP6JDB0DqaXl1
 e2h4X4aDDzBiDbnRbSfhhMi6q3Cz3K/vQfeqbjDi7v5iUaq7zxIp+wFERhBHzhUYz9m4+TMEqnV
 aKz5BzUB4hfiAFmw3fWcjCCilLVaJvmtcfKYLll0rdElSVD3YXHRb9PBqxxoKOZQXPHbt
X-Gm-Gg: AR+sD12HZWknDJ1yZNLstev2ye8E1dpZubXykKTMBii/es2HNkgANHRQJMzKVSdJsni
 tzc5pAnHoy8Zvc6dNuTOcQjSggV0kWxJn6al4Bwmt16qr5clUp4yT4g6JoJ3Bf/i4z3X9d80i6E
 Q+e+z/wkWqT7j35TdI2TbXpsedjsqisj0Kk2gANLrlnkAglT70uFZ2F+A7dcK5h+4qne53gyWoy
 bvJfPBy90QZMrKvGQ0NXPoTo09roOZKmZHSpoAuNGbUClwPMZabRVWPuWt25n2V1s4HSqwfVUpH
 cpPA8dxlM9AX0KKgwHKn6LFWAYkXCUmMK1we4TXt5um93CVmr5Ek3Jesn1iSX42gNmB3vX/VZpJ
 ddvhUzfaB6YzbD0AKtCiP5iTeg2Bljdw2tolb4stX1Q==
X-Received: by 2002:a05:620a:2711:b0:92e:fe10:3339 with SMTP id
 af79cd13be357-9371e65ce0cmr1110108085a.47.1787222897174; 
 Thu, 20 Aug 2026 03:48:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2711:b0:92e:fe10:3339 with SMTP id
 af79cd13be357-9371e65ce0cmr1110101085a.47.1787222896497; 
 Thu, 20 Aug 2026 03:48:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c3775sm10508694f8f.26.2026.08.20.03.48.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 03:48:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH 06/13] target/riscv: Constify @iprio argument in
 riscv_cpu_pending_to_irq()
Date: Thu, 20 Aug 2026 12:47:22 +0200
Message-ID: <20260820104730.25462-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820104730.25462-1-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MzMOejwMkpvxvF4Ezbc93Kogxo9vn0JX
X-Proofpoint-ORIG-GUID: MzMOejwMkpvxvF4Ezbc93Kogxo9vn0JX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX3FHiL0zSYmV5
 tEEDRDmWm1+OPuo/ZaTt/jdaAcPT3GBss3D4wJ1PbJbSQWtDV453sPcf4/lDwMeDQUBC89/cZKw
 vsUB0SqS2kILqNtvt3NFPlAzTonly++Pue3r13a8kK/+Dc+YB2U+/XGZtd8CVW/mMnOouDLGmy/
 eFqZSP2ImOCDz+CalrNZgTD0fSbV77k9RkeHWzOKAf29atR4E9ctOX9CCJEB6WlLkVhmxBKU+kW
 u/xL8n8Eq6FXrywic+UzTVbl/hdilDXGARLj28dECsnjzl5+ka6lLZFOc4tL3LPf7iyNryiQ5AF
 o79sEMechYej0WtePEEUNMYMJc+Kk6RUENiibgCGr047ZJ58c4ius2bj7dq7ydPWB7cbGmA7MYL
 to91vKWuyXVBF/iN6U3+kv6fJGX5M/0zlPFbKz1IcGi8GHMjVDbm79c1EumSInxEkRiCjCr7B13
 BSKFMzeCbb9mMEFb4vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfXxKNX7XtALPsJ
 qHjx0D6oOC1c3whalSPKA6LCoeiDtzvgqJaYDte6PkZEdH8XW90Nj4PW5VWOZlKeS+30nfzAy+t
 kerfqfgDh9FoUuM1CsyqZSWaDmu0x34=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a86db71 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=PcSzqKlYNDujwJGkniUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

@iprio[] is an array only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 376cff656fa..bb4c8563554 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -642,7 +642,7 @@ int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio);
+                             uint64_t pending, const uint8_t *iprio);
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e73ff53159c..68f5a620402 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -866,7 +866,7 @@ uint8_t riscv_cpu_default_priority(int irq)
 
 int riscv_cpu_pending_to_irq(CPURISCVState *env,
                              int extirq, unsigned int extirq_def_prio,
-                             uint64_t pending, uint8_t *iprio)
+                             uint64_t pending, const uint8_t *iprio)
 {
     int irq, best_irq = RISCV_EXCP_NONE;
     unsigned int prio, best_prio = UINT_MAX;
-- 
2.53.0


