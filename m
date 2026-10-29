Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A0606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WeZPmNEF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lv+hHC/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPuM-00063H-VI; Thu, 29 Oct 2026 09:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1xMPu1-0005k0-8t
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:10:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1xMPtt-0005y7-7Z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:10:44 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCePlV669612
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=tEzoqaHozmXixHHqgYx6x1sDLjgILRLHgU0
 BP8UH5+E=; b=WeZPmNEFsdxlZCJlnZHXhAY/dJcsgf2/YrUi0jD+H4jUDKvMO90
 PfQ8qp6//dCLcjFTgZWC5QKMayERxUdDZJBANLkcxCsd46huAsl+5Zi2cXy5E2xR
 jgVpbLYa5eeY5G66CYXU7BMpzWvZtN5ZN7rBlTCLypLzEsaJmnAH0LDGezS+QNhW
 DnQGMH0DlqEvt6uTIvaTbZGMQVwpirsi8fr+p9JWlzR6XMjQiIOuZfFGU/bg5n8w
 RIKtkLBp/jySUhYC0ArEdv3OD3VB3XS4W0ramhvbM5LyezCdxv0wl5xgQ1zMlIhA
 abZ9VNvDCL3qL63B+VKTRjpHX4D462l1igQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpmc3n39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 13:10:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e93e2f72bfso32976535ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793279431; x=1793884231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tEzoqaHozmXixHHqgYx6x1sDLjgILRLHgU0BP8UH5+E=;
 b=Lv+hHC/qgNWecxqQAYO+xreKs5GPu4dAbFK7xKCaDvML8CgWIGENO4e3ysruHm89os
 xDN0iYcNJ5bdR7DVzLn6Kw8qAZeB6KNlqFPaLyZ+gIJ5LL6QA31dlgvuzE1sgkw7qs0V
 PBg/tQg6TwuzB6h7hvBl8B/kNtYMMcc2rglLgQfGhOPTaafhQ/2beQUU+zfI34a7aS8e
 GE9jcXShqwbJzQqOZH0UnVAKqppHxBF7rt1M3KK9GABqwoZxpRMhqj8I1enKS+8I/wjR
 BSDDCS7O/BbhbCkiBE075bt4sDrSwTEpOt1M2T1UKzZ/w1i/fm1NF7RWA/ty0PMESmM3
 HSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793279431; x=1793884231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tEzoqaHozmXixHHqgYx6x1sDLjgILRLHgU0BP8UH5+E=;
 b=kAc2TrwvtRiAybagBh9T2TnlVS2ZHBSF7ueAtMrZquu9n1aC73PyT4KbppgIQjP8nF
 GGcjUNNcecegQekKLFLegE4n4NTD7aAMcRO3vX47D+2qRQxvwiVPQOvBxK11OCoMuvCv
 asW1dMuQ4Db5QHVOZk0Q9whQSHoFzkzQ6gXiAbIIMiFykpTlcElZ/JGv7QDHhzBc7Ihf
 HbetvCCqcxBMSu6ITh1ExcIUlxR/l8EZMFGwjOxz7A3IwYq9+rHps+FMg+CTUhkAAt4D
 V9CopMhgkZ6BrHi9mIoY4t+gCa7zcV/d68JxSLyuote4laS7IsWBED0hBSTh80z6PeG+
 A47A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq04r9Vy/sIvtkhwq+bpDbuMBvAuuhegfaAiJBUiWCp5A53IG9dNFkspfu+RgMq8qPT1pgBODuzsvc@nongnu.org
X-Gm-Message-State: AFq9FYJjt76afpJ+r+iKLDIsedq71pDTNa1qLzIl9pdgWVCJEHyprCwG
 1JAQnqgTxyB9MRLimSd5EqYXsnMDvQSJDoxj9rYLJ9sIFC+3EFr5/4BZMt6vUcRq0dJjMjuSAaA
 1sqJEu8qi9EFffzWfBjAUPZr1iZs7olReHsggipxi2AM7jSi/yLw0OKQQ0g==
X-Gm-Gg: AYBFou31JLKsHpuneGNNS4wze7KSARPbXyMa6vxsQ6wBhi+aP8tWMXm0SnWjDstU4BE
 5LefRZurSMtqYuV8GUxkfFSfQFy8s4ybwIDtbDfZx+BComOTKTZhNxi9Bea7cJVqiytUkMvfRax
 GimVhdzKE/C5OzwXeNIuJoWihc4Jp+eF+nPSJANcYEH+tOWoTaGDCdyciYyG3nFq/4p/eiEuWcE
 3oPrawlzh6Q+bVdISNHjkaDGjXsAzGNlbDnXesqSl7IkeYoeVRo/ENci+4jiqanfsjl6+XVICr4
 bOy/0xkGYHoMhziJ8dVi0bdE9+Kjen8bGG7b/DbTIg+KsHvkj2z2z0yZtuzuYCdIKbsKxp1+MZa
 WOAvp6wTnuhtbixoJOYS73P0Xnu1GNMksczDamKEQWGiHGOX9NFnX+V+aY75P5+IWyWWVRIliV3
 ahTm+cUqrZu1LxWmCZVJvAnipffimGHDZSSB9uPYD0EM27QWe3mzRoVYp1OvYAPFwkzB6a3OwxK
 Ik=
X-Received: by 2002:a17:903:19cb:b0:2d9:216a:cdd3 with SMTP id
 d9443c01a7336-2eb0048889emr52325145ad.18.1793279430587; 
 Thu, 29 Oct 2026 06:10:30 -0700 (PDT)
X-Received: by 2002:a17:903:19cb:b0:2d9:216a:cdd3 with SMTP id
 d9443c01a7336-2eb0048889emr52324825ad.18.1793279430047; 
 Thu, 29 Oct 2026 06:10:30 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2eae6bd60desm34467845ad.29.2026.10.29.06.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:10:29 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH v2 0/2] RISC-V Sspesa: QEMU model support
Date: Thu, 29 Oct 2026 18:40:07 +0530
Message-ID: <20261029131011.3715081-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4nHu2Te c=1 sm=1 tr=0 ts=6ae345c7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=JfrnYn6hAAAA:8 a=VxJIORW4uAIu6BL9gzEA:9 a=GvdueXVYPmCkWapjIL-Q:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: Gb-wyFqtADCalMUcuzyDvEL_EkAU3hyJ
X-Proofpoint-ORIG-GUID: Gb-wyFqtADCalMUcuzyDvEL_EkAU3hyJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MSBTYWx0ZWRfX9dJqb3Faauza
 VBDt9yj5FYO4DsAKA21LHiHbyT/fKGIuzk8sZnsHK1sZZWOVk0ZnzDv0rF2Dp9YQuSd1eigIyNF
 xiHva/22DYV9awv+gVKl1O9H3lHq5qNlEosnGTufuHmF3G+FSiCZnuHZIx0piNSThIQNXCxUlpC
 tq6MN14YtDVH32ytYh6ebwvyRkfnRFUtTszzOa5CVRwrc4BXsz8IFv6Zqdt2SVTDTHUtrpOWVPq
 c5DgIx6aSm7hmrY2w/LAXEAVUDnIQE3p6nV+BGrFg0thQPbgFZbatcsdCANVVy9OcqV5dH3kaa6
 vvFq7psPnGGx8rM+zy9EGLSTvFeMQrUn13S/YqlQLedeBoH9K3rlABgXHBKMNQUzVmXrpY12gOy
 XEFIZXPCWi1N8AO47RHYkzC8+s8G3T2+fz02MOShfhOC9xpxjBgzbYn3w8eSOhOrb3WbuU2UTAA
 99KvgGtZ9urGgSN8MLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MSBTYWx0ZWRfXxDqqnn8lX5ml
 aGJ+TU0uYYCMxhpR+2V2cD82Dy7UbYE7RRmQQQIX6zDGAaGM4QZDh6zYeDCNBJ++k+/FmgP9H+B
 3w8qyyr6P2Fgjb9Sx2pV9Bzlx2WimO0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290051
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This QEMU series adds support for the Sspesa (Precise Event
Sample Attribution) extension.

The first patch adds the 'sspesa' and 'ssplcofi' CPU properties, the ISA
string/DT entry, and the shpmspc/shpmsdata CSRs. It also adds dependency
of Sspesa on Sscofpmf and of Ssplcofi on Sspesa.
The second patch captures the overflowing counter ID, priv mode and pc
for the first counter overflow.

Note:

QEMU does not currently identify any event as supporting precise
attribution. The QEMU setup is intended to validate the end-to-end
Sspesa plumbing only. Similarly, the `pesa=1` raw-event format bit in
Linux is used to simulate an event that supports precise attribution.
Such events are expected to be defined in vendor/platform specific
JSON event files, but this series does not add such an event file
for the 'Virt' machine.

Reproducing the full setup:

Sspesa support requires Linux, QEMU and OpenSBI. The matching v2
branches are:

  Linux:   https://github.com/mdchitale/linux/tree/riscv_sspesa_rfc_v2
  QEMU:    https://github.com/mdchitale/qemu/tree/riscv_sspesa_rfc_v2

OpenSBI must be built with the following fix so that PMU overflow
interrupts work correctly:

  https://lists.infradead.org/pipermail/opensbi/2026-October/010957.html

Build Linux and QEMU from the branches above, and build OpenSBI with
this fix applied. By default QEMU doesn't define a raw event that can be
mapped to programmable counters and hence a special test DTB is required
which includes the raw-event-to-counter mapping.

Build the test DTB:
  - qemu-system-riscv64 -machine virt,dumpdtb=/tmp/virt-sspesa.dtb \
    -cpu rv64,sspesa=true,ssplcofi=true,ssccfg=true,sscofpmf=true
  - dtc -I dtb -O dts -o /tmp/virt-sspesa.dts /tmp/virt-sspesa.dtb
  - Edit `/tmp/virt-sspesa.dts` and add the following property to the
    `/pmu` node:
    riscv,raw-event-to-mhpmcounters = <0x0 0x2 0x0 0xffffffffffff 0x7fff8>;
  - dtc -I dts -O dtb -o /tmp/virt-sspesa-test.dtb /tmp/virt-sspesa.dts

Boot Linux with the test DTB:
  - qemu-system-riscv64 -nographic -machine virt \
    -cpu rv64,sspesa=true,ssplcofi=true,ssccfg=true,sscofpmf=true \
    -bios /path/to/fw_dynamic.bin -kernel /path/to/Image \
    -drive file=/path/to/rootfs.img,id=hd0,format=raw,if=none \
    -device virtio-blk-device,drive=hd0 \
    -append "root=/dev/vda rw console=ttyS0 earlycon=sbi" \
    -dtb /tmp/virt-sspesa-test.dtb

Once Linux boots, use the PESA event modifier with a precise request:

  - perf record -o /tmp/sspesa-perf.data -e 'cpu/event=2,pesa=1/ppp' <workload>
  - perf record -o /tmp/non-sspesa-perf.data -e 'cpu/event=2/' <workload>

Check the resulting data with:

  - perf report -D -i /tmp/sspesa-perf.data \
      | grep 'PERF_RECORD_SAMPLE' | head
  - perf report -D -i /tmp/non-sspesa-perf.data \
      | grep 'PERF_RECORD_SAMPLE' | head

Samples in sspesa-perf.data should have the PERF_RECORD_MISC_EXACT_IP
bit (0x4000) set in the misc field, while samples in non-sspesa-perf.data
should not have that bit set. This verifies plumbing only regardless of
whether QEMU supports precise attribution.

Changes since v1:
  - Record the effective privilege mode in the new shpmsdata.PRIV field:
    https://github.com/riscv/riscv-performance-event-sampling/commit/3eff81a6161ffc7a74a57436132d0c15ab549e74
  - Capture shpmspc at counter overflow, instead of during interrupt delivery.
  - Preserve the first sample as long as LCOFIP remains pending.
  - Update sample CSRs only for delegated counters when menvcfg.CDE=1.
  - Fix extension dependencies i.e. Sspesa implies Sscofpmf and Ssplcofi implies Sspesa.

Mayuresh Chitale (2):
  target/riscv: Add Sspesa extension and sample CSRs
  target/riscv: Capture Sspesa sample PC and counter ID on overflow

 target/riscv/cpu.c                | 24 ++++++++++++++
 target/riscv/cpu.h                |  4 +++
 target/riscv/cpu_bits.h           | 11 +++++++
 target/riscv/cpu_cfg_fields.h.inc |  2 ++
 target/riscv/machine.c            | 20 +++++++++++
 target/riscv/tcg/csr.c            | 55 +++++++++++++++++++++++++++++++
 target/riscv/tcg/pmu.c            | 39 ++++++++++++++++++++++
 7 files changed, 155 insertions(+)

-- 
2.43.0


