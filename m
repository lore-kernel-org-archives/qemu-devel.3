Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E44606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Py49vLe2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FKboK425
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd0v-0008Tm-Bf; Wed, 18 Nov 2026 05:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd0r-0008Su-TB
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:35:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd0p-0006fO-U7
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:35:37 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI9kReJ1736091
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZLYQ5NxiO2Z
 +UUQ4lmXwNpEmHqDgCosPqwV/YZfowCg=; b=Py49vLe2UeNDFavWTS4PtfqlTR4
 43j75Y/1ssm70+ilfEcX1WHLgJ2dc1pigDC9UM6G9TiXJcrTAx/ymbTXHF8IJkRH
 A44LKF3J2ZefSh68fGOGvNktLu0wePpKqRuwPxnKzT0D0hF7KmVfTBPmljJDifnQ
 XMze9sfrEiUdjJ62RcpkxqAP7yevZyUp+4I+3zqOR9JsP1cSS6zxhEoybRlVtJaF
 feFRQyEft1WPiSbhcWtdPcNkTxlpksciydUvN7HeytWQUB0VLKa1WsyQpVQCp7Tu
 vxyN3/WRHGkUSDYQsb0Df41b7luXWOnoiBBJ5w6D/iwING5GLzNXjtouZuQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvbak5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:35:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-544019b1831so15910001cf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794998133; x=1795602933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZLYQ5NxiO2Z+UUQ4lmXwNpEmHqDgCosPqwV/YZfowCg=;
 b=FKboK425N8vXDem9nJPSX/T8NntR+lr4+vg2n7BzJegfJpfgsWhJqwhId3NZwZiLll
 i/Sjlh4BqtXllAbl4AViokWuCa93JV1ukXi2Emvb9C1oOEHI0hpjv+fFsHkCjcOOxlY9
 aQEvsKHYcoZvXbAupBm25BFAxoX//SpeebTqDW6bY3VftJcxURFmQ7WT4wxi9Ia0cEyv
 eDMFeR/f0wcNEhCVlkrBsGKAfq1fcajg1Yte3DA8Enx/912TDRc9ir7xAXfs+STVxAv6
 41X3J9gbWXMcRovqF+L7DQ6NWOUW/NUxJtXTviOgl2aYnI5asmr8G4QwFsAmuIhh+bKo
 Q4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794998133; x=1795602933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZLYQ5NxiO2Z+UUQ4lmXwNpEmHqDgCosPqwV/YZfowCg=;
 b=aDJuyIixXbPsWu7deHTJIWwrByqXYJBB1Z3p/3AlJDUGEk9Jkl/YHM2PbQhag807wY
 SFGOGjRbnC5OFVL6p3iXnm6LB31PRAb7r1hU6KInMWDcwmJeOpputggctNB2qMuVCXUP
 GjWIRzmA2kwC8r/X8RD/jNW0dnyZjPkoJb9sDlFuHZz6+Sit/ky6j0pb8FGs4TVsEm0E
 xTa9K8BMW+ZT5PixesaUd5QxRloJJuf40DLFFwLsZyBV328OtAS/NGLBjq1dvo6CAw7o
 n97Z7GtaHJs2Pettxx/3jF5uELfMuaEEpqrPmXCZeAiRAAOOtwQzExC767OzV4dUrk3T
 GuKA==
X-Gm-Message-State: APuU4Z/w4ZiB2mqz1vy6LYXtlf4CrcOzocD/7/pEmzlkXVcGJh2wBhGz
 iG/ulANYA37PSe7tsRwc8JRtxXnrXBOAfbDtp1bThnjEF7Jq36GUuM3ArxUKyLzTkCO9JbWgd7+
 Vt92Ha2zafltc4sPOtWcztgZvfAEu+kQx9az15EA1in+PM91GZrZW5mFeeg+NY1Dxkg==
X-Gm-Gg: AYBFou306ccyORtMRBxGEtu8PuQGinNuFaNbsqOB3ARwFG208ppLAxnytqWhG2vTV5R
 IHayFnh9yIyYXVGFGNivUNB2BmLznEqiLUL6Qw21g4oCFWiePRxljhSLh0gRdBkV4zW68sIKD6e
 rEEdoOxB0XbfOSqLwRUpTcH+V9XtWbhmi1w3GQDxG8Ud4KQ76jE4idE2+npH4QfANNrF+I2jA2f
 TaaSbIlIaGnZKcIve7EIkwT+3LhyojQKGx0fI9iXlWpP4MRyAWVmNDMYsaztnUSAkqBg3p8k7Ai
 nDo8PGS9hl1p3ieMKODRM+EJ4KhZ1X22tOOp0L9X62CG5ZrjIPNLz/ljjNP8UZR1rf0hNaEXmPn
 YK1afr2AKUPuO8QFZ881i2NqCAlUJwlT5FUJ9tQ/OiDQ55Rkas350zmaAENORjplnMngMWMGN9s
 j1KwK1tnyIp28=
X-Received: by 2002:ac8:610a:0:b0:535:157b:ea22 with SMTP id
 d75a77b69052e-55d5a5c9d26mr28673031cf.40.1794998133365; 
 Wed, 18 Nov 2026 02:35:33 -0800 (PST)
X-Received: by 2002:ac8:610a:0:b0:535:157b:ea22 with SMTP id
 d75a77b69052e-55d5a5c9d26mr28672651cf.40.1794998132734; 
 Wed, 18 Nov 2026 02:35:32 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d59102ed1sm18927991cf.28.2026.11.18.02.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 02:35:32 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/2] target/riscv: do not clear mstatush after mstatus write
 [GL4488]
Date: Wed, 18 Nov 2026 07:35:24 -0300
Message-ID: <20261118103525.1192249-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118103525.1192249-1-daniel.barboza@oss.qualcomm.com>
References: <20261118103525.1192249-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JBnx2enYTSP9XBJ-stm_9w17VDk3W7Tn
X-Proofpoint-ORIG-GUID: JBnx2enYTSP9XBJ-stm_9w17VDk3W7Tn
X-Authority-Analysis: v=2.4 cv=YfgodARf c=1 sm=1 tr=0 ts=6afd7f76 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=ifGG3HfVTgaK5DfkZOgA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0MSBTYWx0ZWRfXya/VRgDiextG
 NWPyFjf+IscofIOApOP2INAN73kF+FQK0Ix3u7A5agvWapFVWYfn/8ZOjSDJAnBjp19KbQPQHB0
 5rve8g/7XFO20MgiEncjxkD0/EOxWl4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0MSBTYWx0ZWRfX9nfWbPtHaOMu
 8ODnLongCvfUsqYsOhtxYdGgWG3zoUEnjWsPWTDjM2JU1h2bJnAJonuLbmNwBek6G5qIYD//gga
 ZsEfkIGqbxUE0ONcbzRx04f4K55l5OBhVvY7+rG+2fyfcQX//BrqoQZcu2k6OjD1Zd5d4/7F8/r
 iDkQ532jVUsEzDwYvK1lobuZtznhlOhzzanXZ8TCBhd2QtYesjsKk6iNm0sr/Gtm/zdGyW7KmX+
 2RufoLV0J7+9WCkt3WLRsMB1kQZZES6leb6pGJePSX+dXLv4LhLoNDE1XgVkEcgnag+KmCJ7L8o
 TccMQU9H8IhjQ4O+kLMl8DACNw29zhtkv2Htf0hFizz1lXoU2DlWJtlHgbf0wj/n6VG8PHtmbv0
 0IgS5Cm9Nf1dBuWa4hnfJVWymA+1YZH9mxXgKhd5XSiHV1yZCmulMQsq6DgfXykQrcF1orBuGkF
 7zgSjfhfzrRMBxpcxEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For RV32 we have mstatus and mstatush, both 32 bit CSRs, that shares the
same 64 bit container in env->mstatus.  mstatus will read/write the
lower 32 bits of env->mstatus, mstatush will read/write the higher 32
bits of env->mstatus.

We forgot about that in write_mstatus() and, when running in 32 bits,
we're happily setting the write mask with bits that belongs to higher
half of env->mstatus.  The result is that whatever was written there via
mstatush is being cleared.

The solution is to clear the higher half of the mask if we're running 32
bits.

Fixes: 284d697c74ef ("target/riscv: Merge m/vsstatus and m/vsstatush into one uint64_t unit")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4488
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c                  |  9 ++++
 tests/tcg/riscv32/system/meson.build    |  7 +++
 tests/tcg/riscv32/test-mstatush-clear.S | 57 +++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 tests/tcg/riscv32/test-mstatush-clear.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..ab436244cf 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2127,6 +2127,15 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         mask |= (MSTATUS_MPELP | MSTATUS_SPELP);
     }
 
+    /*
+     * For 32 bit accesses we're writing just the lower 32 bits of
+     * the env->mstatus container.  The higher bits are written via
+     * write_mstatush().
+     */
+    if (xl == MXL_RV32) {
+        mask &= MAKE_64BIT_MASK(0, 32);
+    }
+
     mstatus = (mstatus & ~mask) | (val & mask);
 
     env->mstatus = mstatus;
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index 117ae6fbce..c70cc12517 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -22,6 +22,13 @@ tests += {
   },
 }
 
+tests += {
+  'test-mstatush-clear.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max,smdbltrp=on', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
diff --git a/tests/tcg/riscv32/test-mstatush-clear.S b/tests/tcg/riscv32/test-mstatush-clear.S
new file mode 100644
index 0000000000..5053832700
--- /dev/null
+++ b/tests/tcg/riscv32/test-mstatush-clear.S
@@ -0,0 +1,57 @@
+/*
+ * Verify that mstatush is not being cleared after writing mstatus
+ * (Gitlab 4488).
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define MSTATUSH_MDT 0x400
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/* Write mstatush.MDT.  */
+	csrr	s0, mstatush
+	li	t0, MSTATUSH_MDT
+	or	t1, s0, t0
+	csrw	mstatush, t1
+
+	/* Check if mstatush.MDT is indeed written.  */
+	csrr	s0, mstatush
+	and	t1, s0, t0
+	bne	t0, t1, _fail
+
+	/* Read mstatus, write the same stuff back to it.  */
+	csrr	t1, mstatus
+	csrw	mstatus, t1
+
+	/*
+	 * Make sure that we didn't clear mstatush.MDT after
+	 * writing mstatus.
+	 */
+	csrr	s0, mstatush
+	and	t1, s0, t0
+	bne	t0, t1, _fail
+
+	j	_pass
+
+trap:
+	j	_fail
+
+_pass:
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+_fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
-- 
2.43.0


