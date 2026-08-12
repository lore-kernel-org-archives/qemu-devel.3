Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6115C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6J7-0008Vc-Db; Wed, 12 Aug 2026 06:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6J5-0008Ui-JL
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6J3-0003Ze-H4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C9g3qN3778081
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vNILrqZOki4
 ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=; b=hLLccko/pIvdi/MdvdLxsP6AJze
 9gT4VhQHsg/xML1/qGUJA5zBmFOpzOcRUA5TfNKhpdoy+WH4L/ndcT4PC3bNghHt
 mpkG52qysei5e4WVwt9RdAcIp+qw47AWtFIQj5faauR9dMBFW5AVUbyqP5Kvc9oI
 bwC5qv2Pnffj8kNDO7f1HV/KJfFrwtjyVzGek+GLfN7UTUVzTf1VcI/+7Ycld42J
 V62jBpSYaMMD/3UfzEE8ygNhTG/S+ZS9AN7swaoRe6JaPgG7yzz0Ptqg26RWHmsL
 kQVexZ7W5VoEbF20VOHjBFpWSesZja+KzGLlbzYqCw7X4yzAqu0RyyriL/w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0nucgc1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d0563db6bcso3698745ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786530931; x=1787135731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=SbImUCrWCiJPts68kVYLyMEuYM23KvC84IIjl4Bv9oshkd4G4Kdyd8/ukZtaIYdEQz
 DTbOa2E3KGIO6RDDvU4e9q3kjwufV6+Mh8Tlz5UkPLitGWrAa+gKe+Z/rUJBoWSKdZrS
 lys4ORJryvYSsfBQO1Yqjwo3E9mcQORXq7wXKzGmYKtPQOy4Unt8f+o5GY45GHpjchHt
 t4T1/CTM5b9cQOuzkaJVZ3kPkbdTQpFsU8VTPcO+kIKcnmferChLgLqTnxGB7EwzASPq
 PNxNjU/s26bxsPy5lL8asEzz280q8jdFBF2yzljAJC6v+Hvt5TjnUf5860GNTt8KbYMD
 Lzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530931; x=1787135731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=q9av0Vv+hbr+sW+QjJKRlqRShGtG+Cf2UwkNqZ3/rea7JiFpvT+7IsFLYtJDbncF4Z
 Ld/MIrPVnwk0Gup3jvzbu+DHRVTYG7iqY2i0DJBMuEjOAAs4Ow+p2I68+cd7sRxqZaAt
 i4Q90QNw0K1OVnC8f2rNxmix2CLK1cWjjnwvxdg9bXbMorTGOvnwt/B3J67tbdLsTGhe
 YMTewszLBLmmYFR89RTIVS8ncNwimUjBjrxanF+y4WlQOcf9HmXbQHUhzFIXCDjbyw8Q
 Cm0DL4cMLBl6VEAU6TtjQm074fs456Y963SL0mSQ7Zll4GMM8pwd8UcO9X4fKrzFNT5F
 wVZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2htEElNHewQTJHeThfcpcWuVsIoP9GrZCGEum2cHhA3WRhKLueT1mXexIs+3oBsBiphfa8qJxdu6o@nongnu.org
X-Gm-Message-State: AOJu0YxQpHTt3OhvlQPJTiSieXF3Up0h4scmsvN8P88j9KjW8LlcRdAZ
 KKC0oC4p4cSOpcsNGOKA0b30b0hbjrW5uQUdU9lxaBR+ahhCBVJXZ9WL6We+jPaigrHw4bo6iOm
 SftPuFxvfNyIgGDd/aNRLjWOEmIf1Gi3FMpWSt4ec/kmJePZhQOsfsUsddw==
X-Gm-Gg: AR+sD10NzkoF7tahaBiqL7BteepixnAkzO+wUwwMrg29Uc63Zrpr/WbpCLBl6Wr0RRD
 1JiZ2EU5cTplcQ1+KVl8F+bLvD8zk8shpzKyh+ZTsFyEeCZ72DWjB1sQKMBbBzE5teQw4WcgKKA
 JcNHd1wjG4s5IpC3D/Hqyxqn3Fzn/ASaLy5rKBUAm72fKEk0/CM2Ih6R6FnbSrDo4e5cVCUQN00
 d0vse83CEQdvP4KEu1iB4Gh6d816R3Gy+QA+TPaQIQLpe8HzOjoozBXgEAznxAuOl09vLKcq17J
 1QFDbQEGlUdqmO/CYzPS42G3EiIfLT5Xys6BEP6XbuE5h4GHC3HwEGNNeuLiGdg7bmFaQ6EvOjm
 Wxs/qHYrT5IiBwdITjqn1MnJilIhCntv/GuPPnEb1s403uwIJ+rpdQAqk5R02lZY1fQtj3kbqIg
 tTMRgPnM0jNC4YEqGKS+bIjL33LQVKgds=
X-Received: by 2002:a17:903:2f08:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d3456d9a5amr30969025ad.4.1786530931359; 
 Wed, 12 Aug 2026 03:35:31 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2c4:397:dd7a with SMTP id
 d9443c01a7336-2d3456d9a5amr30968705ad.4.1786530930826; 
 Wed, 12 Aug 2026 03:35:30 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31d6aec3947sm6910326eec.17.2026.08.12.03.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:35:30 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v7 08/10] docs/system/riscv: document initial virt RPMI support
Date: Wed, 12 Aug 2026 16:04:42 +0530
Message-ID: <20260812103445.3451960-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Hja7Ik69Ak2y201mzybDIcqGqszskGop
X-Proofpoint-ORIG-GUID: Hja7Ik69Ak2y201mzybDIcqGqszskGop
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX0CwQ2pD8wsfc
 kYxdZ4PlCymWNEvgzzJk3LJD6Kf3n4XnyFh81XJ8B0qDEiEtpYNrnRAUXyegzd96SD2nIYWuvi2
 Rf4IUQyMMANi9hqi2bE45XFFlTObW2DfAk+SOT7JDp7ELPVhgHzbPJmpCb+my7nCxjkQdoMjF7K
 XbFC2GoPmjjbjO2zNyWGCgaD1HKDhAmiSJ5uYVnR9bOqyy5/cvxYpj9WUK6SuYYNOQxzn73X1MX
 bloTEjHfuQghw1A4tkWlJKsyW0boCBW9Et5pd6R6wokFV9j9L6s/k7XmtY9fGrZVhiGLFdkA4EW
 pFnOu0Oi6xmx26Y8epS6AkLA5TiSuzbXHINwk7QkqEy8RZKLSoZFYHVedXDqqolreRFV4uFRP2k
 r9AOsw02Y4HmrSu4JQF4tqJfNhkH/hlBkahXrOhEZ3pQ1MWv//mV+BdyiZ+bvOHwryn1HjY9fHa
 TioOdukE6czUlip3GeQ==
X-Authority-Analysis: v=2.4 cv=VcjH+lp9 c=1 sm=1 tr=0 ts=6a7c4c74 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX1dIPg5iAwqoG
 y2+YejAfpAJLetNV6FkuhM7ln1B8ssvF99s+RnXTC75QdfDLxd3I9b/WOdd87thpIF7jThqRYf0
 pNIDfyVmeDIarRR/zF5I5tT8RZ16ABI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Document the opt-in virt RPMI transport and the initial HSM, system
reset, and system suspend service groups.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/system/riscv/virt.rst | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..31cd945a3b 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -146,6 +146,71 @@ The following machine-specific options are supported:
 
   Enables the riscv-iommu-sys platform device. Defaults to 'off'.
 
+- rpmi=[on|off]
+
+  Enables the RISC-V RPMI shared-memory transport. This option defaults to
+  "off", is TCG-only, and is available only when QEMU is built with librpmi
+  support. This support targets the RISC-V Platform Management Interface
+  (RPMI) Specification v1.0 Ratified (`RPMI v1.0 specification`_). The initial
+  ``virt`` implementation exposes RPMI system reset, system suspend, and HSM
+  service groups. System reset can request shutdown or cold reboot through
+  RPMI. HSM uses the ``virt`` hart IDs and supports hart discovery, status,
+  start, stop, and suspend commands. System suspend uses QEMU's suspend and
+  wakeup path. Migration is currently blocked while RPMI transport and service
+  VMState support is being designed.
+
+  The build dependency is provided by `librpmi`_. QEMU requires librpmi 1.0.0
+  or newer. If the host distribution does not provide a librpmi development
+  package, build and install it from the upstream source tree so that
+  ``pkg-config`` can find ``librpmi.pc``:
+
+  .. code-block:: bash
+
+    $ git clone https://github.com/riscv-software-src/librpmi.git
+    $ cd librpmi
+    $ make
+    $ make install I=/usr/local
+    $ export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
+    $ pkg-config --modversion librpmi
+
+  The librpmi repository can also generate installable ``librpmi-dev`` Debian
+  packages with ``make deb-pkg`` and ``librpmi-devel`` RPM packages with
+  ``make rpm-pkg``. After installing librpmi, configure QEMU with
+  ``--enable-librpmi`` or ``-Dlibrpmi=enabled``.
+
+.. _RPMI v1.0 specification: https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/riscv-rpmi.pdf
+.. _librpmi: https://github.com/riscv-software-src/librpmi
+
+RPMI firmware and guest smoke
+-----------------------------
+
+A firmware-level RPMI smoke test can be run with OpenSBI, a Linux kernel, and a
+RISC-V disk image:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+      -machine virt,rpmi=on \
+      -cpu rv64 -smp 4 -m 4G -nographic \
+      -bios /path/to/fw_jump.bin \
+      -kernel /path/to/Image \
+      -append "root=/dev/vda rw console=ttyS0 earlycon=sbi" \
+      -drive file=/path/to/rootfs.img,format=raw,if=virtio,snapshot=on
+
+The OpenSBI banner should report RPMI-backed HSM and system suspend support.
+After the guest reaches a shell, normal guest reboot/poweroff commands exercise
+the RPMI system reset path.
+
+RPMI device tree policy
+-----------------------
+
+RPMI is currently described through FDT only; no ACPI representation is emitted
+for the RPMI transport or service groups. The ``virt`` machine uses the
+``riscv,rpmi-shmem-mbox`` shared-memory mailbox node plus child service nodes
+with ``riscv,rpmi-*`` compatible strings. These binding names are part of the
+RPMI RFC surface and may be revised if the RISC-V RPMI bindings change during
+review.
+
 Running Linux kernel
 --------------------
 
-- 
2.43.0


