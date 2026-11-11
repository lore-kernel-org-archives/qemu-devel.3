Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D8606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTLrdvD7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fqZtbDrG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR8XP-0002kd-9r; Wed, 11 Nov 2026 08:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR8XG-0002h3-Ce
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:38:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR8XD-00040t-0O
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 08:38:45 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCYudF2356419
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 13:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Z0ikpwZsKqoW2kRg0BMFc5icn+Z9FE20ZZE
 3z2QxyPM=; b=XTLrdvD77c118SbZuoSEIBtWQHgDvzPkLqiJseIsFdSFMx6P4Vb
 I7pSwOwyz4sswgy3Pzc19D4bpNB7GsvxbMmA8gGPpVyEFfybZvpGw9qXviraNSC4
 ghaOMiCM6BE84kO6TUN1HG7aNx7CoKtcFp/1M6/YCBn4Fb/615gaohYojXh0ZAUB
 69x6M2wgTmuehsSAhfSY8CdlVfC5OTjKsL9DZdWu5HmXgVUVvIoEV0U9k6qjqj0O
 8TkysAeWcCB6VLYg0CsHBWMdm6w5d1NbVrEOvbjSlKcl2bxmKim2bc4Ad6GfGZ5h
 2wYgulU5aIeZFamkBF9UgAj+4pBZ9l05rKg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdj1fx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 13:38:41 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91f0938c499so12927186d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 05:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794404320; x=1795009120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z0ikpwZsKqoW2kRg0BMFc5icn+Z9FE20ZZE3z2QxyPM=;
 b=fqZtbDrG0Ga8YDZqSccj1A9wu6mtNjXRy5JQVYHPqP9PURtkuL7Ox0o7BuKeTqShRo
 Bx1w1Hg8BiGRGwG0cyb5wT5ToVlCosZXE5hSD9o+x6npnENL5RKou6vKuH73O6BHsby5
 c960hbikeU/YdRfLuI4PqjGD6NG7UYH9dOl1mNz5h9oFcYwdEdcBcrgO7KgoABuVeujF
 TK6DcUoL2BJ8Lggt3D1ft3QtTD9/B9y9Tu9MZlUbF2hycX+eYNahhu69YjtSWPXMJ3ee
 xoGaB4d2RAprsBxjS8qiOb69tW74YndHRtfr9BvC2us3s79UgsMLxfu4wie3+ZXHmeIx
 dHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404320; x=1795009120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z0ikpwZsKqoW2kRg0BMFc5icn+Z9FE20ZZE3z2QxyPM=;
 b=KwAV/CStSgmjKsDSlAVLQ9+KVd6nEIfBDSq2ZyhysWXUowRZhiuYOzX/gprsxLsZxN
 yqC0tI/kJQhQsu0jAY1REWGz4E0XsZaQLmxv6ihLtpUqxOT6vEW30qT3IWD8BuDysr4m
 dSKApudxhhUL34FCSALTeO2H+BpOwGJqf3HHuJmgmKymQVhAJienpROqQ1vtw73oiHzC
 wAhgtMi2FOsKrWVwr+mfRG4xRKeH0YmTt/EOSr3E7F9EfXHuUw1id+DEEBIGK8Nf18MU
 rPxf/8NEE7kMgu/R3ovh5ugZWLJ9YBdfhkqIN5koDI3p4SIMJ2I5Un6JQz8zEk94AQO5
 6YCQ==
X-Gm-Message-State: APuU4Z/PmLqxr/mJ4EBXx905omfZd99rQDoOGqevlzOqg6MAQJTDmPx5
 p1PAdQCZjRPvjsmNS9zRwExxdDnnuww+tIawaxl1Ka/fWGy4JweksPCDYMD7UpaXFPbKa3rBO2F
 OFxRWL0PUfB0QWJcXpHPJ73gckDYaAc1GNdO0r5ap6/zG7ckfN5V/03F1IlFBhe4ylA==
X-Gm-Gg: AYBFou0MW1vfViYBCpP/XKbEsxRnc2vRog5urEMIuhw2I8IClS3oBqOG4fTDKOk4Bbk
 WQU+aZfrO2aH0QfJpo1lxxk3d00fSuXKODBRxtgDiQX1uUZ+S0Ovi/WMsn+J8Nhgh9dhJJYwvh/
 WIJLFh0WvecpcQ3gTRlriSKx7qCT1ORj1HwT8vQyG6harIvPTRyT/17DVo5Iv+VDdrOSodNMH98
 wTO3T0CLX2d1KsOEIkyN9jOFc53zbN04mtv9iYfD2WUrrQkFdEIbwz+loUtINq3J+5MzR35jp0u
 dheBOudQHhLobW/Qi4a9KJzHgLakxIfzxGJq3GtIV2J6GGfYC/CPfmJ6D0zy5RB8GP20XDkDRBA
 3rL0yooufYj+EIkFnG54invKmG8hCfV0UfMf6Oimyv1NQs4tN8SYPAC+ueu5xXDTMMuShNbx8vc
 Lyz5p9rb3hFrR1SecCMuwbSVfNjQICCJOzm2OGIhOwwb94
X-Received: by 2002:a05:6214:4a05:b0:91b:5d39:e13b with SMTP id
 6a1803df08f44-91f04212a11mr41658256d6.48.1794404320033; 
 Wed, 11 Nov 2026 05:38:40 -0800 (PST)
X-Received: by 2002:a05:6214:4a05:b0:91b:5d39:e13b with SMTP id
 6a1803df08f44-91f04212a11mr41657736d6.48.1794404319356; 
 Wed, 11 Nov 2026 05:38:39 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04b01c8sm47374976d6.10.2026.11.11.05.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:38:38 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv/tcg/csr: filter bits when r/w HVIP(H)
Date: Wed, 11 Nov 2026 10:38:33 -0300
Message-ID: <20261111133833.258917-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af46fe1 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=CAa-Uoc_l-2XtQuzupkA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: AvFVMo9PDJ_dlwz_yf7iGAJGKmfwTebM
X-Proofpoint-GUID: AvFVMo9PDJ_dlwz_yf7iGAJGKmfwTebM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NCBTYWx0ZWRfX2N/19Da+4wyV
 4xbnrYA/j2begVfxMBLaFqWYJBYP3oqai14DKT9ScWU+sYrTHNmEl8IYbcxgzWCYGBxXpaVN4tr
 gEHwSfkmuX44wxZseBJv1eiBQvWasULGZL6aGKlr3n2bN4lgTs5H1UqLeGEYEpeQNWbEMGLoYBw
 diGQ8a9hz+zy9b+sDaxqSok60s/IFqRrvP1W2/4clwJQ44IzuC2LGILM1kMWrR4Na+h4IFdKtrb
 z/bUeBLYlbcZEOE4SFikzzDooyMZ1aArjdnV5Ml4sY2jloY7sQ8NBqLovlfmjakauQcMaClKPdc
 0LnYjGshe+Z3o7PVAz8k6TpI6RreXVHcFW1OAA5tGYHKSwQE1I+YEeK3ZBFfzTHRmLIOy7WHCao
 mS8dp3ivNdSJEtLRvIstydoMCp6WJGfh2sf9IIF25Dnu0BpR4MxYgZAkQsoi8ObuvllQN4F/R41
 dgrHM6AQ/T8bknEB2Uw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NCBTYWx0ZWRfX/qOjv4O5kf/2
 s2yHhs1P8i+BTtrg8F6u2nkuN3He3PaPt7o2tE7GvKApPxR9MDmUVMajGrbBGqk2XxQGB/YDne4
 c6YfzYU7UCeHh2c23y9KI9xWt+dgl/4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110054
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rmw_hvip64() is not filtering out the bits from mip/sip, hosted in the
'alias_mask' variable, when dealing with HVIP.  The bug is rather
straightforward.  Given:

uint64_t alias_mask = (env->hideleg | ~env->hvien) | VS_MODE_INTERRUPTS;

when env->hvien is 0, alias_mask will be a full 1s mask.  This mask is
then used to retrieve the mip bits (via rmw_mip64) and then later when
filtering ret_mip.  The end result is that HVIP ends up providing read
access to bits it can't write.  The spec says:

"Bits of hvip that are not writable are read-only zeros."

So we're in a direct and trivial spec violation.

As a side rant: I am less than pleased with how rmw_hvip64() is turning
out.  It's doing way too much with way too many CSRs (hvip, vsip, sip
...) and a bitmask salad to go along with it.  Every time an issue
appears we have to patch up a specific piece of it, usually related to
one of its CSRs, and hope we're not breaking anything else.  The
alternative is a full refactor of all the CSRs callbacks involved to
decouple the logic, which isn't the greatest time either. We should
definitely avoid this kind of design in the future.

Fixes: 40336d5b1d4c  ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3133
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/csr.c               |  8 ++++++
 tests/tcg/riscv64/system/meson.build |  9 ++++++
 tests/tcg/riscv64/test-hvip-read.S   | 41 ++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-hvip-read.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..9b67f2d764 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -5078,6 +5078,14 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
     uint64_t wr_mask_hvip;
     uint64_t wr_mask_mip;
 
+    /*
+     * alias_mask, aka the bits that comes from sip/mip, should be capped
+     * to just VS_MODE_INTERRUPTS when reading/writing HVIP.
+     */
+    if (csrno == CSR_HVIP || csrno == CSR_HVIPH) {
+        alias_mask = VS_MODE_INTERRUPTS;
+    }
+
     /*
      * Both alias and non-alias mask remain same for vsip except:
      *  1- For VS* bits if they are zero in hideleg.
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..db494f70c6 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,15 @@ tests += {
   }
 }
 
+tests += {
+  'test-hvip-read.S': {
+    'exe_name': 'test-hvip-read',
+    'cflags': cflags + ['-march=rv64gcv'],
+    'qemu_args': ['-cpu', 'max,smpmpmt=false,pmu-mask=0xfffffff8,smdbltrp=true,ssdbltrp=true', qemu_args],
+  }
+}
+
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-hvip-read.S b/tests/tcg/riscv64/test-hvip-read.S
new file mode 100644
index 0000000000..e1cf6c774b
--- /dev/null
+++ b/tests/tcg/riscv64/test-hvip-read.S
@@ -0,0 +1,41 @@
+/*
+ * Test if a HVIP read is returning 0 for all bits it can't
+ * write.  Based on Gitlab 3313 testcase.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+	.option norvc
+	.text
+
+	.global _start
+
+_start:
+	li    t0, 2
+	csrs  mip, t0
+	csrr  t1, hvip
+	bnez  t1, _fail
+
+	li    a0, 0
+	j     _exit
+
+_fail:
+	li    a0, 1
+
+/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
+_exit:
+	la	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
-- 
2.43.0


