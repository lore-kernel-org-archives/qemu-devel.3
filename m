Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DABF606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SFcfqdWN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bzVinN91
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRc4C-0003UK-AL; Thu, 12 Nov 2026 16:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRc4B-0003Sp-0B
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:10:43 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRc48-000090-QD
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:10:42 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACJZlTA1840830
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 21:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ZLYQ5NxiO2Z+UUQ4lmXwNpEmHqDgCosPqwV
 /YZfowCg=; b=SFcfqdWNBQcwvRBdEar/4vCPcAX1JH59LSXPlJrymn+HBWyoqGJ
 NvMb31WPJoahD2r1HGRRLQTAonPms0TtZyesHKBsY5d3as+87jpWBO1Je4ByMae/
 aX68f9Lt5wVpE6JatjV2T5HY3+2sF0KqUnqm4CS5QL9sTt9cbwfqARiAkMDD2HVd
 wkPzVpCTbkoKjAGjHj1pQwaAhC9z1w1ryMHEhQ9yZpCjfM+RowueuY+wrFuMuZk6
 J98m+2ZLPIGGMu9puXbywI13fBRP+QhXbzirMgPuYITq/l3JjPFYPLW2cibNhmum
 6yfNp2dKLJqp8qNZWMPW7Uu/vm3UmUJNTcA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4th26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 21:10:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso42260785a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794517835; x=1795122635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZLYQ5NxiO2Z+UUQ4lmXwNpEmHqDgCosPqwV/YZfowCg=;
 b=bzVinN911vEKHMvV8GjGGcmXgSy9hygfr9tQ68oiOSWxQOSxTnShayaml7RCl6yXXw
 HTyMvL0Y9KV2YefcvodCU3ZXbBoLhoRqmR2nWi3hku60WOM0DjDT4baw1FywVI0NAOr7
 FNdOSesU9o2PkG6CZjzeG/PNz0/hC37/sh2P06N+2yMxbdwvloJriDbwUStPPXJ8i5T0
 uTtk8H/lQxJnV1gZXpgpqBuYc1rdUor4fqfQGxOoEygpKqI7xUr7JkpaoX3+9wZx0fa/
 eKpi5Dh06PEJs1S1E0KpsPwUuE6bdFZ+AWkfKaGcUBvdO2aFsSZ2vsi+aO/3O819mG5t
 jpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794517835; x=1795122635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZLYQ5NxiO2Z+UUQ4lmXwNpEmHqDgCosPqwV/YZfowCg=;
 b=qc34as+V+Lw71ac+HjlfrUop42FYz0gs5D5zMha5Qpy3TbHQ1c+fqxI53RKc/Jxm8D
 hQj7UVw7ZSWpK02dhiThsVvd4APyGilAb6N/lr+BoIcCNgaRSODKXC5KBdIARJBGoAUs
 WJeefa4/tDZQilSVI1dRt84nZqqUfhcuVE/dmlHmWSRF60C01BUQANP4yGb8S8J74W29
 ZLzAY/g6BqxWZW62qNO0K1nk5VFX4YQhi2kvoowRm5PX6hb0UGpFNWYMv5o2bP7s08ac
 YA5n76APpJB3H5qIl8/4kJtUKwO4C0KClkvig5IiaQUDR/tPY3e07JPR+BfRCgtcXQ6V
 9tHQ==
X-Gm-Message-State: APuU4Z+ckH2OE0OOiG91jSC5CKk4Ys7r092OY5a8S3C5re0yEa83sgOf
 7TN+eHb/yXidD/cP1Kw1BMrS5V0HTFycPRVRKmbErTJx4mVnhQrgRw2dhP316K7FfQecafNohFz
 wofXI2jffKUFZ2LP02W0gAi3zNtmrjarCkIqgCwQkbpwER31/PkPQyAoEUSP/4ME+wg==
X-Gm-Gg: AYBFou209qliDS78JBosUnA+CneJy+tZYKjtJKHbOz7B6NQvcc/ch7W/9SyDN8wygEd
 hGtDZl7Mfg2Zbytv/3Iy1S4PRVHZngaJQWcSyh7Ix54in816iDR8IhpABZfSTf7VeepUqyaM8KH
 m3Bs24+S5l8HAPi1YLRcK7tZ+TQbkzN6SIHzQKnWatHxS5cJZl7gKVejnqrsrJxbOj+i5KupLqo
 SBlXsS+BOmZ125FnNiot90XTSa+VXB2OYzK6EaULya3ohHEoUO985TgHHQL28gYojveg/jxub+W
 0XLOoTXd4h0cxzw8ounUqzSooBTjo5zTzbKWXG7JTjaz5KuxuBUjk2tWs8faO0O9nDuUJIEjDh7
 ms7pY8RvZTdR54M/Tueg9V6RRZ+TCMG03q8/WjbFREkMsMAGcELupxHphPOnYSqxRyjr88Z1nWI
 iWytIqiNb6rKuaAzmjX2SWtfuucxsABIbY9NrwF/QkMSkW
X-Received: by 2002:a05:620a:17a2:b0:93c:c7c6:90b5 with SMTP id
 af79cd13be357-9494ba4b603mr107762785a.9.1794517835347; 
 Thu, 12 Nov 2026 13:10:35 -0800 (PST)
X-Received: by 2002:a05:620a:17a2:b0:93c:c7c6:90b5 with SMTP id
 af79cd13be357-9494ba4b603mr107757585a.9.1794517834792; 
 Thu, 12 Nov 2026 13:10:34 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8d8298sm26998585a.38.2026.11.12.13.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:10:33 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: do not clear mstatush after mstatus write
 [GL4488]
Date: Thu, 12 Nov 2026 18:10:29 -0300
Message-ID: <20261112211029.562640-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UnxT5UdfuE8KNYjZagsF-YDrBd1aPGWx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA4NCBTYWx0ZWRfX21xIn8vw4AI3
 y3BPYG9TvRTtK5bb6VFpmcIufyaVrw/4pER0ELQWde56rHFupH4UDqWC+ztkHmHFK/ctmc6TwsO
 hUz6TEOWBCCndytnZuXnPR3wxFPDTTU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA4NCBTYWx0ZWRfX7SbVgtOdn60E
 exjVIBgxb3kViVUysFkORaLD9x6+JB8CIZtYeGc2NUSCDLxALTYAXSJcw7cCRyqChuoBtRA+FgO
 2bF23vOPrMEzScBFy3k7xfIuWhYOulBiQqm0aALDB01PluUM9I8vFuwK3VvKvZKFdJwHO5MTKx7
 0n6OeRuwnhTfKzUTADJV7/ZtdBE5K7HyULQYSyC1oA+hOwiZUMmbg6qF7EVj6lb7XBn3pbYFS6e
 gRRT7oFAy7p4NIye0FIkBUq1DlU4idbOciPSfFq9gqTqAUAA5sLQLQkGPQgE/nTaDDOMJGLFktS
 grplRFfuSEe3yt1jQuMe2tl0yl1T45P+IybGFuxDjvyXJbaTrrA8BA3l0qWH2UMFJoVJJTgCXaC
 AzP2h1g6HqFnUk2LRJ4Dzn5BWf5d9IkAP7KjxKu2L9F24KjZiySgefpKiqwCSEgZ3kBmrCqHEuV
 AwXI8/Kkbj9weg4AviA==
X-Proofpoint-ORIG-GUID: UnxT5UdfuE8KNYjZagsF-YDrBd1aPGWx
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af62b4d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=ifGG3HfVTgaK5DfkZOgA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


