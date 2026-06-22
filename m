Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A774ECDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNJ-0000PE-Gg; Mon, 22 Jun 2026 15:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNI-0000Ow-GU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNF-0001kh-Hg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFXKe31571253
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=syl834R6TVN
 kopHzNxnL1qVcUpWq0e1+uvxqHbeNVEI=; b=m1YWPzxJwYyGpnOtketg8VDavyg
 kqtFkodOowFfGaVTlYu09tyaXCgsvi3jB012iwoY8CF2drEDaPivyh8wJ383frP8
 O5CLj0wSSXf8eK1wK+hnX3y7g2OX+Whn5ol8iOhZQ7k1xXqsg7rlXFN8f1mKmbnE
 XoeS4Z9mjoUeYOwV1GoasUZ0Y/5Pe1lxLIc6n8QZzuB8L2nntMHxl7wFZtd5pM2d
 mBZX8cFbVptC1UjRFEhlgvqhESN0U4D2FmNIc3aRyyU7D4EaoGnVvkeAQtTOIDeK
 x7l4q2YCRf6hCkX5mzH7dd2lWEvNCkACe3dmDdZEyKNoNhpNiAW88PCQLlA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3eb9x3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:00 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-72b09f14b5fso2123245137.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156720; x=1782761520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syl834R6TVNkopHzNxnL1qVcUpWq0e1+uvxqHbeNVEI=;
 b=IIKRpiIku4WVMAnCH/eOZX36O8zS6UGnnqcD7dcIbEET7YTwLwNOHCqb69+gq9xEKq
 jhHdQBMK4jgC2e0JrFVklpbzozkK2M5aJDd/7nUl16KlxS+spuMQ5LB4KR1gPLIhQ1iQ
 qaNUvSn03cJSs9U9XE+Jo0fxRIiRXmWM1Ph2bzqGK4s4eRNV9STYeJEV2GD3FOL4dAo/
 q+vXCji6p4/zVGvG/df5CMDmoSNSDyvt/mysyhkrvvR+GQ2NnZwyQluGZ2Ew843R52Ke
 qIhL/2NwhBoLpbL1UuOuZOqA1b/PJ4BOYbJ0Gn5ZSOZyXYXGAUDtEMaNmx5z84dAiPM9
 G7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156720; x=1782761520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=syl834R6TVNkopHzNxnL1qVcUpWq0e1+uvxqHbeNVEI=;
 b=nduDG59fMY9T8w353Otp4UlC8G5pqSqEUSjnm1zhevpWJP8CBhPwLwcgc7NGhvZ/0/
 pmo+KGt5huU1jpZqUPr23okN9kvhKE3Ozlch8QowUw5rxgQD51j75k96AUiOXKweWgXz
 lyXmLUyaD6NBJyp2wz4lH2at9Oo106tfw4UA4dHjR0QxFsEW3V2T8QofePhSqnotjTie
 apkkiDHtvzkUdhogzZrIhg8+vKpIZeIomEAkBdMjvY+ioUfoBcH+w4AtFgn5YWRiVI34
 6JQcQ1TwuHxfD8+CO4A3owDynyL7Wjghmq6DzYkPUvmgt5khgJO9Lwt9EXiyx/y+K7n/
 3FKQ==
X-Gm-Message-State: AOJu0Yw3ON36akNZ33aBfqQ7x6iYIDKZTz3sxFvaGKPf1CkYeidbtjT6
 UsSB6TcKIundaptbXdOl5BXSoCprRuhXN5fxljzwdIbqqFvnWFX5wdlpexiGO3NHr04oBttFYS7
 9DJxyhSppdMeSuabzjRVUgz55I3DHEBKaZzQCtUbBd1Q99A9TCzC+TdFtG3bMJGM5Xw==
X-Gm-Gg: AfdE7cn6bm6oQGohzP71M6og/6I/OnCbTFRTvFPhU5HUEMtPpMJzyRG/kPtJARqJ7h3
 9mcU9JU1Ab7SCcZK5CGw9S6i+CAVFUhCEh1SJtCGx9ZqNA4jPzQtatvDpdLDJt6A7r2tS+hmUAU
 FXh53s8Rgv8dp1+EafE4S4QrHkq0DDdtpgAWH+bSMZx4BNKvUJ8s7p3qCAfLwrID5KEcLvVlUXP
 jnVn8fyYy6A0Srsq9iiTavEv0Ppzrh4xrVMCMX53RfzY6BNzdb4UtS9I1J2S4ztNk+2kUCZsyvJ
 58uzzgIehjHz6upjDo3A7gG7iMis+E1Jah9+C4Jnl9F0herxxBhPObGhrb3jnwLL2BNP9Bz1v3L
 /CT5Kfq73j40mQlw24FMMlnoYCqgH6tzXT85xvgz4it8yaQ==
X-Received: by 2002:a05:6102:5121:b0:634:92c:bdd0 with SMTP id
 ada2fe7eead31-72a1ceec338mr8523175137.6.1782156719467; 
 Mon, 22 Jun 2026 12:31:59 -0700 (PDT)
X-Received: by 2002:a05:6102:5121:b0:634:92c:bdd0 with SMTP id
 ada2fe7eead31-72a1ceec338mr8523057137.6.1782156718748; 
 Mon, 22 Jun 2026 12:31:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:31:58 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/24] target/riscv: move TCG only files to tcg subdir
Date: Mon, 22 Jun 2026 16:31:18 -0300
Message-ID: <20260622193141.1449724-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXw+u6FqrVS3dP
 H/8Q/QnxVlCcTn/nyJ0EGHTVa1MiS2KtkZWR/6Pva71gRIhORf6a2VI/p7lVadVr/ZBCpbRwpHS
 sSyE4ZR7wFOy2tmcZV4NurqcG8o1byQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXw/ULh8jxc3sA
 RFKLQPbd6Vagx/cSU0e7r9YGTReAvGCbJVynineMMDJWRGVSFI1y8bu2ebqA9RHvxkY2fwb5PDc
 wkFPUSV8eVv0FW+qGmEK23b1ghSDwpKJVw7gEO/4kRKDBzzPZFV87v7wGML4yDA1ubm3Rq0EdH+
 dRkel0cRp6+tY8HhiOjjvgDt6lPFx8Ipg1rr26pW1+avC8NtA0VgKVthz9BVyhciutWRNAM2+9v
 PEllohab+rCzzteR484ETEX2qseOy+pR0x4MqbFRWy/PB1UPut8uq8oF5VVQoL5KTCM1WGH2aqT
 H90QAZULj/Um/gRYAgD80ek3YpmSMlyaze/KpM3xvALqtW0Gq+9UpQzpEo9gI3q3yRPFHogM+gy
 r21vDx3meLtDoOnrcZKm60Khs1cA1eBxupAINWxQx2zrDLktkS1YRfMtUFVFn7Va6yjDl8YBIex
 hAq/sA7tMnZ1kxSl5qA==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a398db0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dWVhGV5Cy5NFuyiy0EoA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: N3uIrU-QFbp5qnp9_xSNyIgr2NLrqap6
X-Proofpoint-ORIG-GUID: N3uIrU-QFbp5qnp9_xSNyIgr2NLrqap6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We have *way* too much TCG-only code hanging around in target/riscv,
where ideally we would have things that are shared between accelerators.

We'll follow the example of other targets like i386 and loongarch and
move everything to the tcg subir.  This will not only cleanup target/riscv
but it will also expose what is common code but it's buried inside a TCG
helper.

We're leaving some stuff behind because these require a little more
case to not end up breaking KVM.  We'll take care of them next.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/meson.build                      | 16 ----------
 target/riscv/{ => tcg}/bitmanip_helper.c      |  0
 target/riscv/{ => tcg}/cpu_helper.c           |  0
 target/riscv/{ => tcg}/crypto_helper.c        |  0
 target/riscv/{ => tcg}/csr.c                  |  0
 target/riscv/{ => tcg}/debug.c                |  0
 target/riscv/{ => tcg}/fpu_helper.c           |  0
 .../insn_trans/trans_privileged.c.inc         |  0
 .../{ => tcg}/insn_trans/trans_rva.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvb.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvbf16.c.inc   |  0
 .../{ => tcg}/insn_trans/trans_rvd.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvf.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvh.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvi.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvk.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvm.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvv.c.inc      |  0
 .../{ => tcg}/insn_trans/trans_rvvk.c.inc     |  0
 .../{ => tcg}/insn_trans/trans_rvzabha.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzacas.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzalasr.c.inc |  0
 .../{ => tcg}/insn_trans/trans_rvzawrs.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzce.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzcmop.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_rvzfa.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzfh.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_rvzicbo.c.inc  |  0
 .../insn_trans/trans_rvzicfiss.c.inc          |  0
 .../{ => tcg}/insn_trans/trans_rvzicond.c.inc |  0
 .../{ => tcg}/insn_trans/trans_rvzimop.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_svinval.c.inc  |  0
 .../{ => tcg}/insn_trans/trans_xlrbr.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_xmips.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_xthead.c.inc   |  0
 .../insn_trans/trans_xventanacondops.c.inc    |  0
 .../{ => tcg}/insn_trans/trans_zilsd.c.inc    |  0
 target/riscv/{ => tcg}/m128_helper.c          |  0
 target/riscv/tcg/meson.build                  | 30 +++++++++++++++++--
 target/riscv/{ => tcg}/mips_csr.c             |  0
 target/riscv/{ => tcg}/op_helper.c            |  0
 target/riscv/{ => tcg}/pmu.c                  |  0
 target/riscv/{ => tcg}/th_csr.c               |  0
 target/riscv/{ => tcg}/translate.c            |  0
 target/riscv/{ => tcg}/vcrypto_helper.c       |  0
 target/riscv/{ => tcg}/vector_helper.c        |  0
 target/riscv/{ => tcg}/vector_internals.c     |  0
 target/riscv/{ => tcg}/vector_internals.h     |  0
 target/riscv/{ => tcg}/zce_helper.c           |  0
 49 files changed, 28 insertions(+), 18 deletions(-)
 rename target/riscv/{ => tcg}/bitmanip_helper.c (100%)
 rename target/riscv/{ => tcg}/cpu_helper.c (100%)
 rename target/riscv/{ => tcg}/crypto_helper.c (100%)
 rename target/riscv/{ => tcg}/csr.c (100%)
 rename target/riscv/{ => tcg}/debug.c (100%)
 rename target/riscv/{ => tcg}/fpu_helper.c (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_privileged.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rva.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvb.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvbf16.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvd.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvf.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvi.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvm.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvv.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvvk.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzabha.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzacas.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzalasr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzawrs.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzce.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzcmop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfa.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzfh.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicbo.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicfiss.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzicond.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_rvzimop.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_svinval.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xlrbr.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xmips.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xthead.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_xventanacondops.c.inc (100%)
 rename target/riscv/{ => tcg}/insn_trans/trans_zilsd.c.inc (100%)
 rename target/riscv/{ => tcg}/m128_helper.c (100%)
 rename target/riscv/{ => tcg}/mips_csr.c (100%)
 rename target/riscv/{ => tcg}/op_helper.c (100%)
 rename target/riscv/{ => tcg}/pmu.c (100%)
 rename target/riscv/{ => tcg}/th_csr.c (100%)
 rename target/riscv/{ => tcg}/translate.c (100%)
 rename target/riscv/{ => tcg}/vcrypto_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_helper.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.c (100%)
 rename target/riscv/{ => tcg}/vector_internals.h (100%)
 rename target/riscv/{ => tcg}/zce_helper.c (100%)

diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 79f36abd63..61874ed0af 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -16,31 +16,15 @@ riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 
 riscv_ss.add(files(
   'cpu.c',
-  'cpu_helper.c',
-  'csr.c',
-  'fpu_helper.c',
   'gdbstub.c',
-  'op_helper.c',
-  'vector_helper.c',
-  'vector_internals.c',
-  'bitmanip_helper.c',
-  'translate.c',
-  'm128_helper.c',
-  'crypto_helper.c',
-  'zce_helper.c',
-  'vcrypto_helper.c'
 ))
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
   'pmp.c',
-  'debug.c',
   'monitor.c',
   'machine.c',
-  'mips_csr.c',
-  'pmu.c',
-  'th_csr.c',
   'time_helper.c',
   'riscv-qmp-cmds.c',
 ))
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/tcg/bitmanip_helper.c
similarity index 100%
rename from target/riscv/bitmanip_helper.c
rename to target/riscv/tcg/bitmanip_helper.c
diff --git a/target/riscv/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
similarity index 100%
rename from target/riscv/cpu_helper.c
rename to target/riscv/tcg/cpu_helper.c
diff --git a/target/riscv/crypto_helper.c b/target/riscv/tcg/crypto_helper.c
similarity index 100%
rename from target/riscv/crypto_helper.c
rename to target/riscv/tcg/crypto_helper.c
diff --git a/target/riscv/csr.c b/target/riscv/tcg/csr.c
similarity index 100%
rename from target/riscv/csr.c
rename to target/riscv/tcg/csr.c
diff --git a/target/riscv/debug.c b/target/riscv/tcg/debug.c
similarity index 100%
rename from target/riscv/debug.c
rename to target/riscv/tcg/debug.c
diff --git a/target/riscv/fpu_helper.c b/target/riscv/tcg/fpu_helper.c
similarity index 100%
rename from target/riscv/fpu_helper.c
rename to target/riscv/tcg/fpu_helper.c
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_privileged.c.inc
rename to target/riscv/tcg/insn_trans/trans_privileged.c.inc
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/tcg/insn_trans/trans_rva.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rva.c.inc
rename to target/riscv/tcg/insn_trans/trans_rva.c.inc
diff --git a/target/riscv/insn_trans/trans_rvb.c.inc b/target/riscv/tcg/insn_trans/trans_rvb.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvb.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvb.c.inc
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvbf16.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvbf16.c.inc
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/tcg/insn_trans/trans_rvd.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvd.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvd.c.inc
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/tcg/insn_trans/trans_rvf.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvf.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvf.c.inc
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/tcg/insn_trans/trans_rvh.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvh.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvh.c.inc
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvi.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvi.c.inc
diff --git a/target/riscv/insn_trans/trans_rvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvk.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvk.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvk.c.inc
diff --git a/target/riscv/insn_trans/trans_rvm.c.inc b/target/riscv/tcg/insn_trans/trans_rvm.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvm.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvm.c.inc
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvv.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvv.c.inc
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/tcg/insn_trans/trans_rvvk.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvvk.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvvk.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzabha.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzabha.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzacas.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzalasr.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzalasr.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzawrs.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzawrs.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzce.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzce.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzcmop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzcmop.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzcmop.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzfa.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzfa.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzfh.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicbo.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicbo.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicfiss.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzicond.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzicond.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzicond.c.inc
diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_rvzimop.c.inc
rename to target/riscv/tcg/insn_trans/trans_rvzimop.c.inc
diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/tcg/insn_trans/trans_svinval.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_svinval.c.inc
rename to target/riscv/tcg/insn_trans/trans_svinval.c.inc
diff --git a/target/riscv/insn_trans/trans_xlrbr.c.inc b/target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xlrbr.c.inc
rename to target/riscv/tcg/insn_trans/trans_xlrbr.c.inc
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/tcg/insn_trans/trans_xmips.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xmips.c.inc
rename to target/riscv/tcg/insn_trans/trans_xmips.c.inc
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/tcg/insn_trans/trans_xthead.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xthead.c.inc
rename to target/riscv/tcg/insn_trans/trans_xthead.c.inc
diff --git a/target/riscv/insn_trans/trans_xventanacondops.c.inc b/target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_xventanacondops.c.inc
rename to target/riscv/tcg/insn_trans/trans_xventanacondops.c.inc
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/tcg/insn_trans/trans_zilsd.c.inc
similarity index 100%
rename from target/riscv/insn_trans/trans_zilsd.c.inc
rename to target/riscv/tcg/insn_trans/trans_zilsd.c.inc
diff --git a/target/riscv/m128_helper.c b/target/riscv/tcg/m128_helper.c
similarity index 100%
rename from target/riscv/m128_helper.c
rename to target/riscv/tcg/m128_helper.c
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 061df3d74a..5684fcf985 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -1,2 +1,28 @@
-riscv_ss.add(when: 'CONFIG_TCG', if_true: files(
-  'tcg-cpu.c'))
+if 'CONFIG_TCG' not in config_all_accel
+  subdir_done()
+endif
+
+riscv_ss.add(files(
+  'bitmanip_helper.c',
+ 'cpu_helper.c',
+  'csr.c',
+  'crypto_helper.c',
+  'fpu_helper.c',
+  'm128_helper.c',
+  'op_helper.c',
+  'translate.c',
+  'tcg-cpu.c',
+  'vcrypto_helper.c',
+  'vector_helper.c',
+  'vector_internals.c',
+  'zce_helper.c'))
+
+
+riscv_system_ss.add(files(
+  'debug.c',
+  'mips_csr.c',
+  'pmu.c',
+  'th_csr.c',
+))
+
+
diff --git a/target/riscv/mips_csr.c b/target/riscv/tcg/mips_csr.c
similarity index 100%
rename from target/riscv/mips_csr.c
rename to target/riscv/tcg/mips_csr.c
diff --git a/target/riscv/op_helper.c b/target/riscv/tcg/op_helper.c
similarity index 100%
rename from target/riscv/op_helper.c
rename to target/riscv/tcg/op_helper.c
diff --git a/target/riscv/pmu.c b/target/riscv/tcg/pmu.c
similarity index 100%
rename from target/riscv/pmu.c
rename to target/riscv/tcg/pmu.c
diff --git a/target/riscv/th_csr.c b/target/riscv/tcg/th_csr.c
similarity index 100%
rename from target/riscv/th_csr.c
rename to target/riscv/tcg/th_csr.c
diff --git a/target/riscv/translate.c b/target/riscv/tcg/translate.c
similarity index 100%
rename from target/riscv/translate.c
rename to target/riscv/tcg/translate.c
diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/tcg/vcrypto_helper.c
similarity index 100%
rename from target/riscv/vcrypto_helper.c
rename to target/riscv/tcg/vcrypto_helper.c
diff --git a/target/riscv/vector_helper.c b/target/riscv/tcg/vector_helper.c
similarity index 100%
rename from target/riscv/vector_helper.c
rename to target/riscv/tcg/vector_helper.c
diff --git a/target/riscv/vector_internals.c b/target/riscv/tcg/vector_internals.c
similarity index 100%
rename from target/riscv/vector_internals.c
rename to target/riscv/tcg/vector_internals.c
diff --git a/target/riscv/vector_internals.h b/target/riscv/tcg/vector_internals.h
similarity index 100%
rename from target/riscv/vector_internals.h
rename to target/riscv/tcg/vector_internals.h
diff --git a/target/riscv/zce_helper.c b/target/riscv/tcg/zce_helper.c
similarity index 100%
rename from target/riscv/zce_helper.c
rename to target/riscv/tcg/zce_helper.c
-- 
2.43.0


