Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5179D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXiDCV0q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUrKH0Ac
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVY-0007Qx-PH; Wed, 21 Oct 2026 19:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVW-0007QB-7m
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVS-0004wC-0w
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKf4l42161826
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3WAcJ1420x+ZgmwoeSaHEpfAcwxyM4BlYq2
 /i8OSxPY=; b=GXiDCV0qvaBjpVA8PbEM182J3H9kfUpB/Z6XN4jtMVhBZG1F/Pm
 6QRvTVAXnAaLf/cX3WV/KCuUELxbtZZ/OIEptiFalWYn9DkN4duTnwRbR6cfIQKi
 k+RjpuldRvLSkQObFEZvVQLXYKF0WNCQ8RvUqyLerculWW/y6YUA32Az2dKmNNJJ
 GRVlQ1WP9Xo9zYCpNd7Q4HviwoeORit77ZPjGqi3jrzoNtnfbpP1jCSHSHla+4pp
 Gqov0ShDWpAXFgHXfxlVDd7D88NgpQOcI8SoiKIDd8xsJGPmEzPztnIqCDFHjlhA
 CBVjWmCGdvvTP5XEuTKJgfXzArVEcpV0FPQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3h33e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:13:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53661e036a2so24615851cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624439; x=1793229239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3WAcJ1420x+ZgmwoeSaHEpfAcwxyM4BlYq2/i8OSxPY=;
 b=gUrKH0AcLTXstrwizyUqRmsJ+0ZbU2f4lvvp+Up3jcMyPvjQPNb/J2UQ8SB+Q5PC/W
 cvPkcQQhyuQxrJo0MXfwNhXpxV/dYL26YT+/uzf9MGwSB1VeTh8ADNRYKMTQYJUm03e8
 u9Fejl+JRi0i38SkAmrjUqqYijz2HJd6dNgW/ycf0gaeXv0tV07C8sdfo9p6zSBNAJyy
 J062fvP/dgnn0VdYKzSt4Xuu6TYMh6AOfxFt0T3vb10N8Hl5AKGcuPW5hSvxVBLDBc5S
 ansSTd2fgNgdLuJoTImcnxa+GQ2gwA6CU6tANnAqrdKTEUKsqyvmxL6DZSQkXnkbhTUN
 dyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624439; x=1793229239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3WAcJ1420x+ZgmwoeSaHEpfAcwxyM4BlYq2/i8OSxPY=;
 b=TZPmEcZwWUY02hlBKbzznAxjFOwzILJBmevZPNdoy/1iMVwHSFs0YwdTyMca9+4F7n
 VVcwXCK7k6GwbvdWU7XStr3U0n9Gm8ci720KBfjetAgc4FKSsz9/VBNxpA3amhFbAYrW
 3oAAZ8qg+tJNanLbiFkWfS8dmoq2r/fmUM24iQevjanpRKCxArgfgq9FEYFi4uFqqCUR
 6VeztCN6sLgMpL35JgTkzKsmLmryI7z/A7445M46oR4fLG8WyXL5e691ZdrVYTZWkoDe
 0PKTsKjdVoLOUL47qlDLrvcilI40G4oliVb6HIof797im2mdnEiUnMR9NSdyFR4zssAp
 OkRw==
X-Gm-Message-State: AFq9FYJZCBdCzaobEWlycc87csr1mXwqagcfSCupxHFFX9XMun23x0uh
 3Si5Biwou1BKOd4flbfu3ZpekHTUNyrT2QBAV8/eqtBBI3N9gDFZpyNxp/H3LBiAvu6JVsvtDMy
 Ds43HuwzAobzxqMljbfWMpXbhCtAutYQnhWKNmvLMqaqd03Qq9j/OZOUfU/OEyCcurQ==
X-Gm-Gg: AYBFou2PGpccbHrLo+pdhDQz9uDuatoObvtEjDJxLGHVKNJjsaJXDDXM/PCyhU6ZHxv
 O8LBsWi3b/SxAVM68ek808lSQhwKtJqxHEYrZ2Yea3DOCmaW1E3UoEKoTr0CtPZFxPXl1E1Ob30
 YY1pOJrmvcg8De6mB2nlCHEiu3pOa22uaKjAYVZHMqNmaj7Tccg2naBDMHJghcnibuO/8PYklWA
 fvLgCOZD4kp2E6mXxuNE4Jwbmi7vUkVn8eeT4NeSSe1t83H3x9+Vy7jIsboYVu4FloyfPCUzPLg
 Vqzx0bWMk/9IjwFxVYVJpkH7qTliMvW5HJ7UdaiL/vWfvADIHGENTYx/cfcOV69s4+Wg8hi0S5P
 PaKRPXCyTDYNFe4+rQlI5KyeS1T+aHL5MQkAGiU187uxIq9zhpo//qItdTx2sLgz8iJxlRHWLLw
 ==
X-Received: by 2002:a05:622a:3cb:b0:535:84ec:baaf with SMTP id
 d75a77b69052e-5369b85ed01mr59072791cf.43.1792624439068; 
 Wed, 21 Oct 2026 16:13:59 -0700 (PDT)
X-Received: by 2002:a05:622a:3cb:b0:535:84ec:baaf with SMTP id
 d75a77b69052e-5369b85ed01mr59072341cf.43.1792624438472; 
 Wed, 21 Oct 2026 16:13:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:13:57 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v4 00/18] hw/riscv, target/riscv: initial e-trace support
Date: Wed, 21 Oct 2026 20:13:27 -0300
Message-ID: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad94737 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=JfrnYn6hAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F-xNRSD0FtQiUKPuQsUA:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: Af9AyRLlEBcYFvNNwXMvji1kLkoSrwIQ
X-Proofpoint-GUID: Af9AyRLlEBcYFvNNwXMvji1kLkoSrwIQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX7ug1wPeXIQ4h
 Fd3Luk9b1ru1/jfTCJiYIIu38c2JyMch4u3VflXnPck6zURjKlTPf9chpQF7foiE3vktTdJ3pGi
 Jmz9uoHryFpjwi0/SlddZevDBBai+RgS5clWrSJIRJofyHZdv4Qy9l+4n3DMLgJiziKhSOocu+6
 9ZUnWQjBsmMuEZN8rhcUjfPigRFZDIohF4xgPxTR2hfCAUMXKzYQPGswPdK3PtiDC9H6qV866vi
 9vG3gt6nyilESA41LlizUhRL0W1Oqot/8RfmUIbSMC7SgbSAyDrnfLRcoj+XgjjNCSmD5Ieg0ZV
 81u9ObwrSfFKxpB3jnmBGoVpJI0PPK2mxU1gURLsy6resuFfqS/ccuSA80JZ8ZOeoYAzkT14Wqg
 lJSlEqRR6+vqdDk6ZwBH3edZvTKAwZhVW1VEAbQF7+vmhTqQZ2YlDr2dv26Ccl8PnhktWbm0BGf
 SpVsxBrNWnJa1uCZ2nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXy+5XcA2PZlwr
 HRX4d2VCqRJhZAQOfjLLTq50JS1azE/P5Px+15ThNbJJor5lTC7qisudL5/TEzvJs3pnsFlBpjs
 hRv+GJoGZvIEk2LRYvf4wJCjRxbTwAs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

It's time for a refresher of the hwtrace/e-trace support for RISC-V.  It
has been awhile since v3 and we have Konstantin posting patches to
implement N-trace on top of it.

For this new version a couple of design changes were made, most notably
the FDT functions are now hosted in fdt-common.c and we're using an
EXT_TB_FLAG to enable/disable the trace session instead of using a TCG
global.

A new patch was also added to describe what we're implementing and some
design decisions made w.r.t TCG instrumentation and encoder parameters.

This emulation is being used to support the development of the Linux RISC-V
e-trace driver framework.  Newest version can be found here:

("[PATCH v6 00/14] Linux RISC-V trace framework and drivers")
https://lists.infradead.org/pipermail/linux-riscv/2026-September/100456.html

Patches based on alistair/riscv-to-apply.next.

Changes from v3:
- patch 5:
  - move FDT creation code to fdt-common.c
- patch 7:
  - move trace_helper.c to tcg subdir
  - use "CPU_TRACE_RUNNING" EXT_TB_FLAG and ctx->cpu_trace_running for insn instrumentation
    instead of using a TCG global
- patch 14:
  - use ctx->cpu_trace_running in gen_trace_branch()
- patch 16:
  - use ctx->cpu_trace_running in gen_trace_branch()
- patch 18 (new):
  - add documentation
- v3 link: https://lore.kernel.org/qemu-devel/20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com/

Daniel Henrique Barboza (18):
  hw/riscv: Trace Encoder initial impl
  hw/riscv: Trace RAM Sink initial impl
  hw/riscv/trace-encoder: add trace start/stop logic
  hw/riscv/virt.c: add trace encoders and trace ram sinks
  hw/riscv/virt.c add trace encoder and ramsink fdt nodes
  hw/riscv: add e-trace message helpers
  target/riscv: add initial trace instrumentation
  hw/riscv/trace-encoder: write e-trace packets to RAM sink
  test/qtest: add riscv-trace-test.c
  hw/riscv/rv-trace-messages.c: add encoded trap message
  hw/riscv, target/riscv: send trace trap messages
  target/riscv, hw/riscv: send trace ppccd packets
  hw/riscv/trace: add format2 msg helper
  hw/riscv, target/riscv: send resync updiscon trace packets
  hw/riscv/rv-trace-messages: add format 1 msgs with branch info
  hw/riscv/trace-encoder: send branches info
  hw/riscv/trace: update branch bit in sync messages
  docs/specs: document RISC-V hwtrace (e-trace) support

 docs/specs/index.rst                          |   1 +
 docs/specs/riscv-hwtrace.rst                  |  96 +++
 hw/riscv/Kconfig                              |   5 +
 hw/riscv/fdt-common.c                         |  70 ++
 hw/riscv/meson.build                          |   3 +-
 hw/riscv/rv-trace-messages.c                  | 373 +++++++++++
 hw/riscv/rv-trace-messages.h                  |  40 ++
 hw/riscv/trace-encoder.c                      | 610 ++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  62 ++
 hw/riscv/trace-events                         |   9 +
 hw/riscv/trace-ram-sink.c                     | 263 ++++++++
 hw/riscv/trace-ram-sink.h                     |  83 +++
 hw/riscv/virt.c                               | 128 ++++
 include/hw/riscv/fdt-common.h                 |   4 +
 include/hw/riscv/virt.h                       |   2 +
 target/riscv/cpu.h                            |  12 +
 target/riscv/helper.h                         |   6 +
 target/riscv/tcg/cpu_helper.c                 |  26 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  11 +
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  13 +
 target/riscv/tcg/meson.build                  |   6 +
 target/riscv/tcg/tcg-cpu.c                    |   9 +
 target/riscv/tcg/trace_helper.c               |  62 ++
 target/riscv/tcg/translate.c                  |  16 +
 tests/qtest/meson.build                       |   2 +-
 tests/qtest/riscv-trace-test.c                | 120 ++++
 26 files changed, 2029 insertions(+), 3 deletions(-)
 create mode 100644 docs/specs/riscv-hwtrace.rst
 create mode 100644 hw/riscv/rv-trace-messages.c
 create mode 100644 hw/riscv/rv-trace-messages.h
 create mode 100644 hw/riscv/trace-encoder.c
 create mode 100644 hw/riscv/trace-encoder.h
 create mode 100644 hw/riscv/trace-ram-sink.c
 create mode 100644 hw/riscv/trace-ram-sink.h
 create mode 100644 target/riscv/tcg/trace_helper.c
 create mode 100644 tests/qtest/riscv-trace-test.c

-- 
2.43.0


