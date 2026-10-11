Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A1CA9ECF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFyFU-0002xS-Cs; Sun, 11 Oct 2026 14:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFL-0002wH-Lo
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFJ-0008S5-96
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69BIMERZ3874855
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :sender:subject:to; s=qcppdkim1; bh=TWLdTDhS4JmE3pn6SzqwIOCVIgBL
 tj3sk0QeOp6wC2Y=; b=eTBkGfzAYNnzYSYqQFMpA4SR1skG5vhVzEBqZ3uzvgy8
 vpwtTicJClshU4ZEo45Mu8XXA5Lex0R8DkF41V4wB1yRpJHlUUyBvTsP9SeAyg/C
 eOU52jTpYyzrqQOs1q1BMl6O8WMDvv0+3frzDAEAVAUmWd5ckFWRXa7wVmb359I8
 3itisDS2VZSRNn8ydC9jwf82Is9xlFCH3HpAV5iSikIzNVpHVF0h/2XI16ee+lJc
 ZZWuc81YMr0b3c6kKFGj2hE9HgobESdqpWF6z4AI7Qws91dEAQcq7u4LioutUbFP
 M09JZ2qd7xmvyMrgc9zlhFICZBv+l/LhsOEGW4RSfg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cpgkng1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35ac5255f1dso309138eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791743161; x=1792347961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TWLdTDhS4JmE3pn6SzqwIOCVIgBLtj3sk0QeOp6wC2Y=;
 b=a9spGxUMG0u38f6cCc5/MsAMBni0wjOM+D7pf6WmtN8T2q3/Nbq1khhKxjoXZG8HYZ
 TvGGXVZh2lYfn4XDxMp+9XoEM1hBeDAmgKoFRfLrC0WKnnA3rJzYv7ehA6RHHdzpLEFO
 A7qZUs3Q1eTkWk3IRM86P33BwmKaBeoL96dIF3lP+zDF4UTnZX2T9M1Bs4hGapO9qUxL
 XOT/Uqu7pxDI2jIFr7em7WzcZXQXOAojCwV/dOpagoEI85reYd3xHofdVyobFGW1fy1I
 LRTpM3opV+HFwCN2oXQSR+kBkcmTVvzMnVP7Ze7sEyQgGv0Hnl3DKJOjJl9b+nohu6f+
 Pnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791743161; x=1792347961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TWLdTDhS4JmE3pn6SzqwIOCVIgBLtj3sk0QeOp6wC2Y=;
 b=pezbqqu/V+JU5AQ2FpcKaQMt06hA7ZVEbNuMpc+iJuuLxHfa8mZFQBDStlwGJGEAsf
 RRo3Enhnoh7uVFjne/5AwhMQxoBoCnhVcXm1oD1REREqrCCC/uX7N9R7MtwWiB7a+JXT
 aBXMVHtffdJTYthKPLA4MjTg77Be5fDkuXDnObZPK2Rpz0VdQCh3joJGh+4M9UFXOiFh
 1aoGkr58NMhNHQTkLnSfFIOg5pr8qr3BvvNAH8GIwhKG6t3z8ez0PaN6ocvAc1QXeOcf
 kJNXqQ9SVglJSmYmY+KU52F+SpVTJg87FB2PHICpzXTw9c6AhdbTRO6IxM90k2VnduOz
 jxuw==
X-Gm-Message-State: AFq9FYJNCdr3yYSguG9qrYfAzhlw+w8zD7hn3JoRHqeyfhht30eyV27q
 nqX2bQ3H3UjH5l3yYzj4SAPHG4UwHYd+8Vw/q5cvaA2m6yFFD2boy5qtsVoSCyYr99uXq+OnEub
 Ku4jDWuwW6BL+qN5sYlXGKHlK0E0x1UmSQ6kPRiUmdhE67/Ij9ju+nqIp3pDpYhsSXw==
X-Gm-Gg: AYBFou3O2pibH0HQwPj04/xRJzd3290RpcpB8fowTxyTMLmtH8z898Vp3Rai+qa8ugd
 rxJLnVQ8obPmlAhtmV7vGQsp2uxkmKzaFCF/cynkZZymOsvJbyjjCXe7IffnOaj6KodAoyicsUD
 hqsPFSNYXbPXL6TArxZTUEWFDAeleije/mt/dpm9qOafPTMgSCH+2vZXL2fz1NU9VjBWgklYJXa
 0Catu9FLJk5DB2E12UGA2AoUfIimO46FPUdrKHQ/KLK21XaGWwcLxRAg/iTqRzPT3N11r5zt9Qa
 BrKI0kWA8CpEq/wZsBvYXpoXOb5PTN5Pwfam6kMRGdAZ38t6LarLGWviM8Q91TIdrf9U2xtZzPB
 hQE1/MXQcHx19bkk1Zxvsb22ZJvJGFy83to7RHcrNKQwtMpbQ3ssx838=
X-Received: by 2002:a05:7022:422:b0:168:3243:c911 with SMTP id
 a92af1059eb24-16a60ced242mr15662089c88.37.1791743161018; 
 Sun, 11 Oct 2026 11:26:01 -0700 (PDT)
X-Received: by 2002:a05:7022:422:b0:168:3243:c911 with SMTP id
 a92af1059eb24-16a60ced242mr15662034c88.37.1791743160377; 
 Sun, 11 Oct 2026 11:26:00 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm22505284c88.22.2026.10.11.11.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:26:00 -0700 (PDT)
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
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
 Drew Fustini <fustini@kernel.org>, Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH 0/4] RISC-V: ACPI: Add PPTT support
Date: Sun, 11 Oct 2026 23:55:48 +0530
Message-ID: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX1BKP6hFrNPSi
 SnJw+7tTTi1M6quufjrhLuG59c6l6fY7I/YT1WPOke8qyXH4P7gOVTohZ6xlZ2R/uP/OSo0qU4T
 5Tsk6K32Lu4ZBnNkBPMwNUZn3r+3g1A=
X-Authority-Analysis: v=2.4 cv=StoFe/O0 c=1 sm=1 tr=0 ts=6acbd4ba cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=Lpe6bjFTOsfE0dEvvBYA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: JR0zIm4WPsbF5pAktbCeU9xMJEpHWSQR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX59f+rmRw4Ggp
 Z4GLGXXsGDTuHsPrESM/7Joerp6p86HmeyfdzWfj4SL+wIC9zvZjJqagOZVLU5M8hw3/OCxjnGq
 uhukr8WwKQsa6VbO7k1G/iNWOHADqisrygpbk6/pO2orM6syXYEJsuqbB+zfmdjZH89M5FDxpDb
 RdM1CiPekUNPjgrMxw0sy1zg0yf9EZOurMribcxpBpznLbeTf/DkL0N1V/ilQUrSHkbUSYictoY
 VbGNuHVM8GgDAuSmI+33WtJJWGaxdZ4S6soWRMDECLKRqt7rtdC/Grxpt+Wf+GAmsUHlaqyWhXJ
 kbDciht2MpqYAyrSb14pG0gd690LmJjAAy4SGAwJVORVO2F00E9naD/kVJe4ZJO3qymBbJcSwlW
 x2tWttJ/ku92tIJ2nyoAlHIvMriDNG+3Ki1nw7H7OZ1uBfPWphAgfdSPSEJYy4rNIwK0BanxThL
 dRoSXYY0YmbspEkWiiQ==
X-Proofpoint-GUID: JR0zIm4WPsbF5pAktbCeU9xMJEpHWSQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Sunil V L <sunilvl@oss.qualcomm.com>
From:  Sunil V L via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sunil V L <sunilvl@oss.qualcomm.com>

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
virt.c itself so that a future series can add support for DT as well.

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

Sunil V L (4):
  tests/qtest/bios-tables-test: Allow PPTT for RISC-V
  hw/riscv/virt: Add ACPI PPTT table
  tests/qtest/bios-tables-test: Update riscv64 virt PPTT golden
    reference
  MAINTAINERS: Update Sunil's email id

 MAINTAINERS                       |   2 +-
 hw/riscv/virt-acpi-build.c        |   7 ++++
 hw/riscv/virt.c                   |  54 ++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h           |   4 +++
 tests/data/acpi/riscv64/virt/PPTT | Bin 0 -> 96 bytes
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 tests/data/acpi/riscv64/virt/PPTT

-- 
2.43.0


