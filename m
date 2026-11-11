Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EEC606A880
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kgMpF82d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IzukRYkY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8T4-0007Ao-MN; Wed, 11 Nov 2026 08:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xR8T2-0007AT-IR
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:34:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <himanshu.chauhan@oss.qualcomm.com>)
 id 1xR8T0-0003VZ-S5
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:34:24 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABDIBct1343309
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 13:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=xb1iim9H9XWZ4MIb7b7pRrjmG7CN6f5Q8Ji
 AT0/4hqc=; b=kgMpF82dW1ByvzM3Wy3o5mdBEct6CZY459LLFv7uuImrdtAG7g1
 eB86QpOhPmNd+HUwQFfC0knErBXMtLrHGeEIfd1enzipIGQLujb90CJ6GWt+Dgv2
 t0f44uFcguon+T08Hb+2MpNSvafb5Pbpi0unrrbm/qnQlkIyf3bLpp7No/expJrn
 WYEq9siqngnYp0qEU5Rlzw7SsEg64bT+tco687rAzY7SZbwPj0GY5yoo2CdswNni
 7CvVt3hNKmg/JnkVwuHkZEeoIg9tjWCkcy11rYbc8PP2wDotSw1CujIngOLEsua3
 N/Ez9D8JweEe7TywabUxo2cFyHOVh92sU9Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvs4m02d3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 13:34:21 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so4172993eec.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794404060; x=1795008860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xb1iim9H9XWZ4MIb7b7pRrjmG7CN6f5Q8JiAT0/4hqc=;
 b=IzukRYkYQMIXiT9gek9hfUhKpM0OOPtDWf7Pq2JV3HwaOlA04HYtOVjjoEnXMDjnyy
 f/JqJcl9wKgRzQlXtiRRVgWCPYINtZEeyryGfxf5rbye3Kp9rhyrbxVV0Vc+ke3W8S+L
 +2g2S5vEOt03SK93uW2cO+lt3XIu1dPQvGcIsu67mXcLaEV7+8UrnV/mXOOfcc8swlFD
 lNqj0vb5sfWcvptValMReNWe3KwgzvXJbvcSfsCvo9uKW54ondhjxUWC8V8yxnM5oVX9
 QsvE7krzB2GC2BZMx38BVFWktzqu6cY7VCgOar62LAYEe4sgF5lEC1Fqul83Gl23zxKv
 3aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404060; x=1795008860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xb1iim9H9XWZ4MIb7b7pRrjmG7CN6f5Q8JiAT0/4hqc=;
 b=IucIm8xST+bXVdsJY4lejlmzwhJZFmNvJDvHFpH9GM5Lvm4GtOzhgf5n+VAzHZXjfU
 WqaNvWvtZtRnFDXUPre8EfPoscqw1AjvR1oBRVeOpWEAzqginU1sSF/XyZnfIN9sYgDe
 Qa0Gve2f8aIVjGS1DAjKNm+cuZmVWAoQPVfAA6Xg+QBuJD/nu9TZ+I4D/BUtgyCiFnik
 RTEqfFGMZZ+umi8E99jP2Pv5AG+/ElocmR+iB3K7kkjUuXkTKrZrjtx1fXB4I4Qe0ru6
 vXF8+sU0SC3dkoWlVpJStzEs0+Fyr073ZuWzpds6u75hdEifNHs7A/zNMJMG09Tbdi0V
 prUQ==
X-Gm-Message-State: APuU4Z9qjKaFl9qj9CJF4kUS939dLaFdRRccCmp3oqV/nhji+060FF8Y
 /4RMwa5VRKRUHfo18Of3+7HsumH9s7is91l61FIce5NbC64HIKAoJEX6KCqXXriWH4/xOMHBnQq
 NuyPjgabE5btHx1K7vLaLA3m5uESvzkCg3KlwgfD3qb+IeaJEnBeSPWSitfse0r6PWg==
X-Gm-Gg: AYBFou2Bq6mZ/2ogygP2hEthwGyx9Bt+eUStM8kpQ1ru4B1ick+FW8MeoTZ2AEs8/YA
 nqjno0FUoyvvV7XGJxrbEiNIxl2Kl/99yXvJ34LQgVIvYwYRK4gyb6T9Zj/mBHZvir8XjwKg2Ya
 jEinezUv2NzvybjoSdGNVfMQAwthhRBHOjgonAZJO3Enuhrr6/EVioR5ej7NZ14aca9vYe6LViE
 XJ58BNlKQt8E7uBRN8Lhdn2uoL7M4D5SwVfMxxKIkmWfsWYGZekwwTNZl49CBzH93y/j4SKJKNT
 qhEl+TaGlJHWudKO6Q8fUcCSZeU30JM8lcAxXyh/e0C8ylw5tthAdaDSL6l66kCY6OwVK7VE1E+
 qmAF/iVQlGGKJEunyJ7vDvs6paROYTysFdckwLvO5XhoorGNFwj7rhnPDiNtKDYqCQxE702JOdp
 aJcIMCEkrmRotyRkSxl+L1wDpIWFaovl2h1EZgaUcksHfsOXD/Tj3dAqKSO+Oqe9FjE6IBrmto
X-Received: by 2002:a05:7301:dd8f:b0:370:d6e4:e8aa with SMTP id
 5a478bee46e88-37687214732mr2999419eec.41.1794404059684; 
 Wed, 11 Nov 2026 05:34:19 -0800 (PST)
X-Received: by 2002:a05:7301:dd8f:b0:370:d6e4:e8aa with SMTP id
 5a478bee46e88-37687214732mr2999397eec.41.1794404059038; 
 Wed, 11 Nov 2026 05:34:19 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520cfdfc6sm18350810eec.17.2026.11.11.05.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:34:18 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v2 0/1] target/riscv: Fix icount trigger exception PC
Date: Wed, 11 Nov 2026 19:04:10 +0530
Message-ID: <20261111133411.1922854-1-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P4XyoyICSpG_hoX_XMRCCevFlUUcnZhk
X-Authority-Analysis: v=2.4 cv=OYANnRTY c=1 sm=1 tr=0 ts=6af46edd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EwCL19PAiXdwFe56MGIA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: P4XyoyICSpG_hoX_XMRCCevFlUUcnZhk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfXzRhv9ymlfgSa
 GtB6n45n8dUdXu7qMWXZR3o2cviQeXNlwfYh+qVZ4iIopF2NDrzy1xtgOhl1RGieVmJn7zKRkYX
 hyZmoymq6KXoG4V6V7f5f0qDKX/546dcZ2D0/f7HG8IsSInaJ+bCw3jKJCxLhT1LB14S6a3201G
 0KmUzE3pNAfOwfQa5YdTW7nyBKJJDPLezNndzMyGYWW2K3PD2gjI20F2dkn2FkGNWiBiZ2AkK08
 pMZT06itn4Eb7vV0vqDH3QaiKdGssIcWKFe1gcHVZXyptmcyGRfRH1GzWLR88h1ttV7HcmAdJzN
 D1+l9EvXc79BFIr3mOZKM7keVrMKkLZUTsis6upkS2dnyhmMhaQ5lGQQSR/pBfCaGM5t/2tkgmG
 tzvl2qsp5eJtdhjxbzbucci+WBQ7vxA15ms/DI/VyryxczlpuhXiFGxf22d1KsRMQi2RWAYlGMa
 4YAmSkmZ6ZKaLprRXKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX0tW5bmQz3/Wk
 WLaK4idbxKfgfIwW7QECk18fw9c/3vx+IrmlRQ8CjjFioiSVFqS3bVKbSGRo1Kh3Tu464ym+Eyc
 p09e4x8/fzM05I9MdPPgLdzO2AynFU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=himanshu.chauhan@oss.qualcomm.com;
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes in v2:
 - Added fixes tag
 - Always load itrigger_enabled flag in migration load
 - Reload itrigger_enabled flag after tdata3 write
 - Refresh stale itrigger_enabled after mcontext writes

Changes in v1:
Per the Sdtrig specification, on a breakpoint exception with icount, the
xepc must contain the virtual address of the next instruction that must
be executed to preserve the program flow. So for a one-instruction
trigger must fire only after the counted instruction retires. The xepc
must contains the architectural successor PC which for a taken branch
should be the branch target and the fallthrough otherwise.

QEMU previously disabled the translated-block trigger flag when icount was
enabled and relied on timer and privilege-change callbacks to update the
count, so the trigger could fire outside instruction retirement before the
guest PC advanced, causing Linux to observe the old PC and re-enter the same
breakpoint while single-stepping with icount.

Fix this by
  - publishing the icount trigger flag in translated blocks even with
    icount enabled
  - making the helper decrement the trigger count after the
    instruction has committed its successor PC and raise the trigger
    action only then
  - privilege-change callbacks refresh cached enabled state because itriggers
    tied to privilege mode.

Also make trigger data CSR availability depend on an implemented trigger slot
rather than the currently selected trigger type, so software can disable a
trigger with type zero and still write the rest of the slot state before
selecting another supported type.

itrigger timers are completely removed as they are not required now.

Himanshu Chauhan (1):
  target/riscv: Fix icount trigger exception PC

 target/riscv/cpu.h            |   5 +-
 target/riscv/machine.c        |   5 +-
 target/riscv/tcg/cpu_helper.c |  10 +-
 target/riscv/tcg/csr.c        |   3 +
 target/riscv/tcg/debug.c      | 170 ++++++++++------------------------
 target/riscv/tcg/tcg-cpu.c    |   7 +-
 6 files changed, 64 insertions(+), 136 deletions(-)

-- 
2.43.0


