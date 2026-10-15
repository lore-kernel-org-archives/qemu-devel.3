Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34037CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHFJQ-0003me-8a; Thu, 15 Oct 2026 02:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJO-0003m8-4T
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJM-0007jh-FN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3wed91889570
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=f1sTy+kSh45LyG93o2ZkLR2eDpL1z0lgD9c
 BUFAQBRs=; b=lY70ICCVCY/0lh7an6RltqpduPieexZB3AcHE6gSICoFMqUgZJG
 PWkGKjNQSuVo8I9Gt3FImKNWOcamTWPSkX0Nx/1EYW+itd6YLh7ngQOCR+n/fXpr
 ar6lV2CMNiH4mQRaOxhrO0qbgJqX1lNVwDlMGG66Q7SBXr0kfouq424jKacFJb2C
 hDrOELjTPHkcPPXyLytfd6WhLegMaW4l26stCWvl1JV6ZKCLbOG/nT9fNGlmjCv6
 Brb5/k8miHS8t5z1+3SEUEyQMcrH4RqaNEYOC2pbJJNQ//Dx1BI3Kk4GXpcYeJBG
 HML0OCVnG8Fdx2Yz5IRDGmAJqDT1vBGHyTA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda0khd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:28 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1665200f4c2so6929931c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792047088; x=1792651888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f1sTy+kSh45LyG93o2ZkLR2eDpL1z0lgD9cBUFAQBRs=;
 b=HPBWWk0sNTS4irEYrUzE1LwqyioLRgFCyY9FDzzhtD8u2RLTeR/IVQ2v+Q+xUxPEtK
 VGBLKnlZtZXChsgp6YE2QC/clqMXuBHFMdRwbqpfB3mmEmmHpMNJoMZGyftuRunzjaZ1
 SpI9LlH1a07WP5MoTRdzDpzPN1r1DYwPMDhvhh6urfMDthSx5u+Ow1v5ECY+8vThG5TZ
 vFayLwsX+BrqFWi6H7LJ7oZGAjfdOlC4sdIvVlUzPMyGrNqv5C/CFnCtgRPXZ+gHbXPE
 sH4squDquzbWGQcZornq1AcKOtCLU4+sI/OyTNj7AG2SmJUvowPTZelQbgoQuNUdVsnS
 CBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792047088; x=1792651888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1sTy+kSh45LyG93o2ZkLR2eDpL1z0lgD9cBUFAQBRs=;
 b=MebuzdT4duh6KgibjXrHpgzz/2R/N8BpDE7hFQerHTMN9j9UkTGqpSD8xRfATowH62
 ML8+6Qo1nLh2NegJ0i+JAgb3EqNmJFv2E8Noh6wyqjId6TJyFv01OT+Dp1a+c+zl7Ch2
 J35sOwuf9wk1BZluVnbY3PVzwE8NGN3ox9Scz+BsK+1+FM+pPa7RSOB93hjzISX8d7g1
 e076O+Dx1UMpwZdIpohiEFW9fELD+4QJnCQCmYpEW2XkySJQigNhI70GZFFUKSNeVsfX
 cnOo9Mhg+2LPLkHbHip0XVapIVVJBP8lzL0kkS+DS0rU/cO7FmSl18jXVmvbDE7P9Taz
 5Xpw==
X-Gm-Message-State: AFq9FYJaXwirLkhUwkQp8bi0Xd92IosQ4b5Zq53CScEfMGqssCW5Qz4z
 fOJg1tjAzMfnNJDSyHKF0gW7p90IjmRyn2xhjAi8N/KWCLTaBNHpatOso+DBou8XknOmbwrXKEB
 tAhCNgLIlDovu9YgooKyel5kIHUTNmemLQH2697zY84evjcczhjS8z+whykRrAfSJEQ==
X-Gm-Gg: AYBFou33EvO9UsYsBoIgv+pcdf0+ch0LiJUw/pVAbx0OdV5l+v6suc8orjJAETDIErS
 OfpkpJ7knAOFeVJ/PFnGWrQqLg/3OJ6K/xCVIYZkl/6Sogh8C/tGzJF2I+HBKul6GNMF9y3oKQV
 JRXWPhqjHZRCT/kSjTlx/8X0ytxNCjHPdWrH9rOb82LPqq8nt9QHvW9Q9GHPD8xi8ehoxyekH3E
 ixHgbUwlKb5f5QLuvj1jxnFBgIdN1fQKuZkY0r9mK3PBt53g5AdMhfY9axQgmH1Ot5GeyNG1kv2
 D/i0ior1927Hd3Pqdjt6aPa+uYJAYFzNtHoj53wdkN7wOKrjVIKJLQcLMllbgjkZZ9YpANPHzg2
 j5c+XUrEDx9sWpxgL/PAZsAFgALXZljJx/GpeA+fLnzIYm/zRZ0M2LC8g0WLpHvNLo0C+JBrMkc
 QwBF+NLuw3JKk=
X-Received: by 2002:a05:701b:2086:20b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-16a5adfc081mr25454367c88.15.1792047087704; 
 Wed, 14 Oct 2026 23:51:27 -0700 (PDT)
X-Received: by 2002:a05:701b:2086:20b0:149:1b5b:1f25 with SMTP id
 a92af1059eb24-16a5adfc081mr25454344c88.15.1792047087169; 
 Wed, 14 Oct 2026 23:51:27 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm67451789c88.16.2026.10.14.23.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 23:51:26 -0700 (PDT)
From: Sunil V L <sunilvl@oss.qualcomm.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>, Prajwal N <prajwal.n@oss.qualcomm.com>,
 Shankar C <shankar.c@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
Date: Thu, 15 Oct 2026 12:19:53 +0530
Message-ID: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfXxgmLIWvSYbv8
 gxVQ/2E/3vWC/eM5AQ7UcVQ+lR8Pt7vHdDg0DFt9l9OeZUY0aDR9G9QXMhdAh6l3WHvMFuTxk2k
 8vYjP3RS+pF+zBoL9OCNiFXOOjeAbsM=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad077f0 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=mDV3o1hIAAAA:8
 a=Lpe6bjFTOsfE0dEvvBYA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: TLsaUi85zcJsyPfIMpqQIPE0O7lWTPwO
X-Proofpoint-ORIG-GUID: TLsaUi85zcJsyPfIMpqQIPE0O7lWTPwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX1vhinf6ydb11
 HQxQjzhsti868Im09wvcuX510zYHiF0qvJ2af4be7qklhp2QkNpDVeSfCozQguenNIwmJV4B/KA
 5yQLTxpi5V/OFrIizGuTIrqU07CZHTokYmqNfYlLPNCuOcmpEH+Hrj10+xWPsIcpPmE6ZQF/jiE
 N/3cKBsb7Us9M+m7BTPB32ZOkURDPZn6Pn39NJjBxzt+i+Yfjbk1aKjPnPfbVlgp++9RWsubcQH
 l4F2rkNVT9rd1f3D+yKdf3SFYNSHMXgDwbXtaGD0QC1d8S+BoaM5CgF+oAVfs9ixCzH/MZUVHOS
 GfQB/UrqcxBhaCsgWgYfR+8p/p/EyHoVz0rUeixcP5ByHzfCqt/XYHbmvt2VMMiTJt8Q0YKzRza
 GH/PB4dAmB0TwE4HS3KKtJ8Yja6UN00xJ7dmeS962knEPCIbg9TWwROzjcka+sE9r6h/A2DISQN
 OGYq0K9uC6sjnGPP5Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunilvl@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

This series adds ACPI Processor Properties Topology Table (PPTT) support to
the RISC-V virt machine. PPTT allows the guest to discover the processor and
cache topology exposed by the machine, which is useful for making better
scheduling and cache-management decisions.

The implementation describes the RISC-V virt cache hierarchy with separate
L1 instruction and data caches, followed by unified L2 and L3 caches. It also
enables the corresponding cache and cluster properties in the machine SMP
description and wires the generated PPTT into the existing ACPI table
build.

Unlike ARM, RISC-V doesn't have a way to discover the Cache
topology from registers. Hence, I am hardcoding default values for the
cache topology structures. These cache topology structures are added in
virt.c itself so that a future series can add support for DT as well. In
future, it can be enhanced to support vendor cpu/soc specific cache
information to override this default hardcoded cache details.

The series also updates the bios-tables-test data and removes the temporary
PPTT entry from the allowed-diff list. The generated table is 96 bytes and
describes the package, cluster, and processor hierarchy for the virt machine.

This work follows the discussion and earlier work shared here:
https://lists.gnu.org/archive/html/qemu-riscv/2024-01/msg00928.html

I have retained the contribution from Sia Jee Heng and added his
Signed-off-by tag to the relevant patch.

To enable cache structures in the PPTT, one should use similar to below
command line option.

-M virt,smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core,smp-cache.2.cache=l2,smp-cache.2.topology=cluster,smp-cache.3.cache=l3,smp-cache.3.topology=socket

lscpu -C in linux can be used to display these cache structures.

Changes from v1:
	1) Replaced loop with memcpy
	2) Made virt_caches static in virt.c
	3) Added Daniel's RB tags

Sunil V L (4):

Sunil V L (4):
  tests/qtest/bios-tables-test: Allow PPTT for RISC-V
  hw/riscv/virt: Add ACPI PPTT table
  tests/qtest/bios-tables-test: Update riscv64 virt PPTT golden
    reference
  MAINTAINERS: Update Sunil's email id

 MAINTAINERS                       |   2 +-
 hw/riscv/virt-acpi-build.c        |   7 ++++
 hw/riscv/virt.c                   |  51 ++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h           |   4 +++
 tests/data/acpi/riscv64/virt/PPTT | Bin 0 -> 96 bytes
 5 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tests/data/acpi/riscv64/virt/PPTT

-- 
2.43.0


