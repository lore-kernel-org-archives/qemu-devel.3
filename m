Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1070C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEd-0006Vf-4y; Fri, 10 Jul 2026 08:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lR-0000OC-62
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi3lO-0004BO-HO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:27:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mbbW3838073
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Reyq+Bfk7gr
 9bLQ5GSqP4nU1exjoe62siU0U9X/2MjE=; b=NylzNL0S/HTOjdjfURU+fGJuqb0
 8BBYLYAx6hn+bsq3QTbvajCiW4C+fPff6WvDYlc/Ynz+shZZrFB8LubFyLltr4mb
 QteRiTIcR/dfamkkTG9NcuZb4dWhcyA2WAnxZEjlPg0/SPUp5GMiGjy75xUNv8ps
 HNIYZ6WuX9vKE08BT2XR8CDi+0a7hYl6/g3worQqyfHG0pPbZ92MfEwzqJ4d38S1
 VQZXQ7wo8DCP5U6tx+cSmWpc8zqRg4vdxD/qtFbC3UH5eCnaOC5JyifMdDiulqAv
 0A0w97fpv2kGwAPu5Jq17aI5jziAcVeNGpgfP+gYqMvQ7Agmud5LCGkpkSA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe8wac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:27:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-382befb9555so161275a91.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783661220; x=1784266020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Reyq+Bfk7gr9bLQ5GSqP4nU1exjoe62siU0U9X/2MjE=;
 b=HcUWlxTvOBNl+BziiYEjPq5rk3JowqvLQ4w9KU+0ybjCuMfn2BLm4aKDgYAqjpHEVC
 9R/hcY4k2giimxqmoo8jTvowh1y5n+a+eBL2DpimKZE7JCae6hPGBaw8MpuzjjMKTXii
 zJasmCh701xk9BIDdERzCN7WgPhej+IqwDDhmLBkkLPSNX0XzvkZehqXORDOgSgypMat
 l14gejhH7ezs03GLL5x6BPy/mTo7oeR0ECzdAjpFIaJw0aUti+ln+eHcRsPz4S99s1tv
 HJVGFK/9GQlJEbF9qlBAjT0rsqXhY2LEP/Pq2SbK+mVZBUJVi4TVHLmV6Sckr2ySuU24
 sTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783661220; x=1784266020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Reyq+Bfk7gr9bLQ5GSqP4nU1exjoe62siU0U9X/2MjE=;
 b=fZIIIQWlL9qFVStiCo11UooxXxQZlZT77/q817s3i+werD7EhxkKWQzdKFCQE8h4IE
 UriZK1xvA5afJZMKcD8T1Y7Fowvzx9190sXTFsnNAZIP7tZh6w8IPOoLZylY6etJzhdy
 aJCyLkALR6rWhJpXGrM2At3s5qRO3BdGytEGrJ/96aM0fkMsdzyW7G9Lyf5BnyhbpJMf
 xELWhGG11OWbNd2yJS7ZO2yFtabTjm9P309WUxNqN+VMjmWIKBrnoiJK1pIOVSNxYi6k
 4mpNP/AuyX1/RWTncpuZLuiYb5kxmxt7obXvZpPWSRYz+iQl9GDHDjh1+pv/mjFqJU8s
 XscA==
X-Gm-Message-State: AOJu0YxmSgaE9ZHrMOQ2TKcByOzX5ng5iOEmTDa1bfAPrpUjdmcj80Kq
 saMwLpnWg/909ZQZALhGZuT3WM7y08Ik2XpIseJTvEiPfd9yO5O1QlA0yIhd7rwiVmEkkx0kMmH
 Dwp+D6dHj1TogkPi80CMzKPSb7sT/eLRjNxJjc/MnCDWth7E8fPFSvFcXtRRAfuT4Vg==
X-Gm-Gg: AfdE7cnwr8Uwv+yYatRxh7kTI2+mL//M1udUHsIesmA4xTvvdzl1O3ZxzaBKEWmAtDb
 sRvFQf1s6UfmuiUNHKG/Kr3ti/c0zvwNNxDiKgwFYctPOjCzuZ4OaAKgkUFod4lAioeiz2IwPxb
 amU87t3A8+zu8/0/kbbtCnpZD+mTUyfvR4PC2ID9rMl4LF6Q9lbmYmYFbQetOknhuqaWayP2Eqm
 OggTJSt8Vclh29G1MknQ2gVlWH7YLKN8Twm0uaELvZmanJIfyntIffeKftGT+ifUJUyUDne0Nl2
 ZQsyEvys1EhwjmIPtPaVKZZWae8yjiDOn4vRXatYmsGIj6VgmjVgc9PgKkdOZ/Iyl4/wJvNAxWa
 Pax9X7IQOb6aQ1MtQekcsR4c+/dRcbm7GTAhNjpNXSzSyY7dInRKKkVdG18e0uuqcrPwApvf8S0
 sR0jA1G8LL+RIe3Oov/AJ308sAvuKPoAVSMX1WD4OGPA==
X-Received: by 2002:a17:90b:4d12:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38a2160e57emr6423841a91.6.1783661220326; 
 Thu, 09 Jul 2026 22:27:00 -0700 (PDT)
X-Received: by 2002:a17:90b:4d12:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38a2160e57emr6423817a91.6.1783661219730; 
 Thu, 09 Jul 2026 22:26:59 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm62476707c88.14.2026.07.09.22.26.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:26:59 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/10] docs/system/riscv: document initial virt RPMI support
Date: Fri, 10 Jul 2026 10:56:40 +0530
Message-ID: <10f13dfad6528556a3bb4aa077aca8c38e34bc24.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5082a5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX0qk3kBf3t7Bz
 ho2aVUSrmZBN5NLzbUdlYfi/hERI0jEY+dU2VusGNoLy+zsnYS7NHoM2v+LeL7Wt+dRLPzrPMk/
 +DxusujH8WRgp6SyIHCfhUXMAnf35IsV5zJ9wYdwPSyUhSwGVvyA9OqgTkmdw97QyybXxdU3t2X
 ZPohyBWSjYAzGigoszNaRs/eoFf8Kl9AR0r5wBIxOk4u+HBpV5h5bdas1+vKvh74dJ0mlyTizmO
 OqInm2onSJBwNu7TZRlUGfMsudozo8GJRlHq9X7M6HAt4Q4Z+WYqc7icONQeHwReiuwMYdHzv3k
 fyLGzzm4DFbHpiV+PZFS2R8sjQZMtW4go8DoHHRqfvd/J3Xsm26mV7Ivo9hHXskLufeyiBOtYw2
 lNnqpgY8W9FIrwuAT+x8Fkrw3h9F7YcXD2iqvQGEcmO1OZhKd5ne6TLrZOAQEvM6g2leEgFVMQU
 94AscevCFSmT13wQ0Fw==
X-Proofpoint-ORIG-GUID: lKnOc_esYAkQpCl2MyrWY9XCodyJWfEM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA0OCBTYWx0ZWRfX3pkzbtitc9Te
 AN3TqqvgNyIKrVEj5SON83DlObcQk23FlMyos2vAWyxhePpDdjBku06sJcq7Nebh0nQqWGtdoTi
 54g/O87EQzNCTZn/eS6zFyq4VFGNkPA=
X-Proofpoint-GUID: lKnOc_esYAkQpCl2MyrWY9XCodyJWfEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100048
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
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:33 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>

Document the opt-in virt RPMI transport and the initial HSM, system
reset, and system suspend service groups.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@qti.qualcomm.com>
---
 docs/system/riscv/virt.rst | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 60850970ce..8e88f780e1 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -146,6 +146,56 @@ The following machine-specific options are supported:
 
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
+  The build dependency is provided by `librpmi`_. Install librpmi so that
+  ``pkg-config`` can find ``librpmi.pc``, then configure QEMU with
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


