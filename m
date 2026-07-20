Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24181C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllmg-0003Hq-EB; Mon, 20 Jul 2026 07:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllme-0003DN-Ks
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:03:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wllmc-0002wU-5P
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:03:40 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvVTC2078381
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vNILrqZOki4
 ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=; b=BAipLbWzDSBHITC6dQvTuT1BQ8U
 2rXcQH0UW+WDOnHan9gKgYnqP9hPXUIJ0WWYXtCHzNiDQ8sFLUvLfUdob1jCjnxb
 6PDOQUQoerRwnDJzWXaJywsaOBQKBbJbL4yxkvoYpYYvd2eawz7hAYKr45/ymSWP
 +2zEhck2zZ6vsTpr3aKR54I1XUxRqSvOpmiKNDdIq4x4Z3ZFm+6vfYlZbJ/o+8mw
 Q2zVL4gs1lgSsVZtnue94hw9MVxWZCsSJLwmnOICb305FDc++8FPZ2O2wOLa+XQk
 or5qhmdSBxywLuyrQ7KCZwXkFfBxeAwb4Y/D56yzqqOoVyNI+yFsa6z0IVw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y0c1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:03:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cae7a8b9easo22904665ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784545403; x=1785150203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=I3aSO4NKeiBEQVVnRbKzfupKmN33Bcj0JUOl8X01ese9+34W7VHjqgr2zZE1QaMvKO
 4Y2Iy36I9mbkxD2xgNmiOkhDc2/q/cjK+TLhViqSDJSOfoEcCobYMlsYX5ONVSWdfBXL
 EBHzLyohscxpDwlHfsdZMV5EZmYL43ejq/6+V27Ip32dCWpx//R/mz2E8URsGr+VjCOs
 G+Qk45eZ95CDDPNaiHgm1jFef1WRP5Zz4tFk9ie/VslUf5r1R/RcZTiqllQEwFr3lBvP
 Y18RY5wd4KUDqMVsby04kJmmhAKOYN9ENzy8kxT45Zb4Ay5bVwSWfdBYm6DWoPqHOHi7
 Yp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784545403; x=1785150203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=JzncWqWHWiIOxaClZRKe3YpjbrVdEhwDDrwK0LJTvNg3O3q1bytAIsXmua5oQZ94IL
 uPLfgawBpCbTc218AY7lsUe6sPkifVCuglLtYhoSYK29ZJrkbXnS3S8BIYvtb0hsqFdi
 b/FD46vd9mUfEugmLH6kjQWn+uScZwbxREKEdltrrNVCTbwGpi3QC5MfWc3GMgt0VOmT
 Q8rUlhB9D0MoZC4vO8BbWp9Xz8bMUKnYin0tT9CzThnreSdBZLncqvxByzjJQwMKOBjn
 gJ+rUyqw5GAUuW9NPb39YpuQ5YCpoUMLreZtkkaVMjN132Lz5DC5Xn2ZQUU7MdD5sbqn
 MOFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnmhpNG1IfDAsSj0qgQNb6xE3UViaFJun44VlHF5FuT0ZjV6GM79fdtTCCIH8lYCoPHKKj9hMcwpBn@nongnu.org
X-Gm-Message-State: AOJu0YyZ8UJwktRyc87VhlmaKMg1p7Lq/swCDamxu4sp47hIpHyqBvIo
 N4+zsiDwxkB1pQUC+/NJ59hO3OVdOS0vx9OLfvsiPvrZ1D6hNo6r+JRrQHNrqouJh0vUezdzS9o
 LIDVb7mxw8X2kRWpEmt7FamxlgrjN93Fb0A9WbD/8ugh2Plh13BcOAAUTdw==
X-Gm-Gg: AR+sD12BpwsCX68uHVre+DiETF5octR/+4T4tMDvAQkAO3CEVXABLAwkDzawQm9p1M9
 4YVbcH/nbI6fPE71tmGphTleOMxTrOqe03VqmoEotKeo/r4bmpHnqio+TuFaM9s697/VMYmRtOg
 86RwEwaRqPUhFt7x1BqROOxIQnFOuIfvsYfAHoBjiENbHdxSYwvYj+AM3cil6E5wAdMh/4JmTQl
 bfIvAOIFK2OcMUL40BV9chANrKTLjG2QKITxbYkbnmFBWm6wqVKTtfHitut2RwfQKwM/JzjwqgE
 V3gMnRf4YX5rF9jRHsCzxzdH4JMReSEjN1LKMAccxsNF2jb7UsYvZaYZnalw8gf6eI0S3hB9pSb
 Ff9cuowqYMXPb9zeI7HeI0cskGGDkBYWW0AmNMxqgcbP/8tz6gRDj1vQRNYzox/ljLzaOL4EXA/
 F7XcaWGk7j/Ha46P7IcUXjSK7jqekO1A8=
X-Received: by 2002:a17:902:ef48:b0:2ce:aea4:5e80 with SMTP id
 d9443c01a7336-2cf7bf7814bmr123575ad.6.1784545402519; 
 Mon, 20 Jul 2026 04:03:22 -0700 (PDT)
X-Received: by 2002:a17:902:ef48:b0:2ce:aea4:5e80 with SMTP id
 d9443c01a7336-2cf7bf7814bmr123175ad.6.1784545401877; 
 Mon, 20 Jul 2026 04:03:21 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20b1f3sm34698566eec.26.2026.07.20.04.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:03:21 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v4 08/10] docs/system/riscv: document initial virt RPMI support
Date: Mon, 20 Jul 2026 16:32:31 +0530
Message-ID: <acdf9355b118fe7ff37abfb7f0b5f2463cd879d6.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1784541996.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMyBTYWx0ZWRfX3G7mPjQSLsNu
 6RwTTOL6Gk9dXXTHoorkZDZe8vp+PfQ7tqQI+/2K7eleuBdj7TmQzLTeFnlEj6R9BHDDYz+yNnL
 V6spqEoX+9zdxOf+yHzw9gPhtXzbnag=
X-Proofpoint-GUID: FCQicldgYI3Hhg6YpUPpIxr2qUVze79q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMyBTYWx0ZWRfX2p8EnCyK6yYX
 ShyeDAcVniCLxcOe08yk7JzItZMMus9rhS5OAJn5MdrP7NqS8hAEL5Eq8GuA3lY5sqrVr8ymGYh
 n0ilKAM/Fqjxm2AJj1fjnXkkf4iDmdVUqliakZfpzF+86F5ELtk3gXGGFuhwz1EbMrdml/ND+9S
 YWv0ZMdTn1v83QJ2973WuUvgWG7WqLk+MIY51uezRc7JOxgMA4/NA9/bkDcqFKKX7aX6WyFtLvT
 ixziPvlRw2qtPoQpGHSP8KPfrQ5pxMBxOc/CZ9KxymZeBoJLYgGXrepkXnCe0kb44KogDMmXUGO
 BCUWStpnIfcTdu/8NBdSnqHaseNSGHI0/evrrSWU5mh/fAbU5U7AjvLuRLQIoco2EditpMaBm0+
 MXVqyVV9G1yCyYD+sYwzxpMTLbVvYeZ1gBax0ULt7eqvHefuCybWaYUP19aJPzrgtPjDNh5rgs3
 65STdwCXQ0A6vto4Q5g==
X-Proofpoint-ORIG-GUID: FCQicldgYI3Hhg6YpUPpIxr2qUVze79q
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5e007c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200123
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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


