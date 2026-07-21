Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5F8C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm46n-00033l-J5; Tue, 21 Jul 2026 02:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wm46d-0002gg-Ki
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:37:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wm46b-0004TW-Rd
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:37:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66L4ShGu526992
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 06:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vNILrqZOki4
 ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=; b=SQRau4pAbe0Eb1I8SCtEre18F8L
 4ss/Vez+T1dG5nxAZ+WznR92tZcQS/cw0f1khxC6G2KqGcaNj0Q3J6VZiDrGzZBT
 Xf2+5mf5AlIwlEmVKdPqs4CjRU6ROBSpvCSKkY+oij181o2H5iq+C1H1srhZ7T1t
 KuB419DSablmI1hKUH4e/Fb8A61TA02Ee7A0Xv1vHKWOT/KFUjQCF0dgVsMBGJJi
 PEF9d4ckA22Nm8zNheXebtUul/CEOkk7sgHfcKE+2zf34mH6ZxKN2EqGUd3re0bI
 rnjp0HV1yZDcgDOBN5dJmbpdMxp2O5OKSoCalEgDYuctTpKK0XsXnCFVn7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se0em3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 06:37:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf44f2c49bso13098505ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784615836; x=1785220636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=OnwiNdTgKiVED6NvLb+5iDRgRSuZzhXBWShntA7gnAlzE60qdfvU4eydxB+vvae5gO
 l13H1s2Vd6f+U+uFgSOcUrBooa3co/r8SgfD49MmL3ahCMVD9GLoBfxjbByft8GGrLpj
 tT97zcz6VmCr+u7RaScqYtk7KRtuyP/Bp2fHsEX58oPpsbmtCnMpOgnCSQDAie5LvQPF
 Co9LIvmmaTDFCva+0JTR7P6uQoocKcGWntpheM9ZgmNQP2GiYWwWMKai3sgEkwDEGHlw
 XVBm0aKdHGPB/NIIWup4NbSTPQWtyCoqaKUFl2/JBEnc79uiRJ6fS6zYf9LMHvRYalCZ
 DjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784615836; x=1785220636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=BcIUUAK8B4yzcH8sYUmQTow5rqI46zMvzkcP+CeG1l1EZGPT2BroaiNeuyUcAlDgx/
 v/2Z0Mexen4q7Zqhn3GjD6VcGN96kxwCCYDJMLXWjCpZAuugyM653rCYoc2A6Qt1acQ8
 KiR9mhRqggkD8faS6bdFruohUoN+w+y2Qb2g7NWZOKA62ECrcujPjfeyFtV9S8DJ4/1o
 VqpM8I1r+sHSjEvdfnQ+zKYTQ2abdY8EiNxDz5kOyecaGQUnVtk6UlI0tgMCmSGctPRu
 Vu52eWfJDdkkRKUJU56nXBxJicbwVHiLmfZ4jKALkzZRh95BQVUZ8P4YQY5nedzjj7bJ
 FhIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6dPxEOya2NeEHVaXCSqZ8izqUZ7Y9w6+4fcdAYE+sDQt3zGraLhEGKyD4MpzSU91FQlIbP9B/nJlp@nongnu.org
X-Gm-Message-State: AOJu0YzihO4C/Rdqx3H6GcD9JzTD8ojhmp6R0V1PzMp/1b7CAklZbsO0
 uziB/cXJT3ZHyMIsoKC8X4EMAZFBl+d7zSYo6gn97DHn+1zu+sbF5l2YNZYr8Ym6Klla+yEjuD5
 2Vyu85nfrxL1cBtwVnOdqPrTLZnUvgIqhdag0ZtF/Pv0tJi5SK8SmjPFYb/BOcffepg==
X-Gm-Gg: AfdE7clAwCr79Zsygi/jOZ+WePyYnPGidqIgjyeGxKcHfGvvq/5xzF2sjhtvCSxL88c
 QDyPwRw4GaIURAoBumADuVf4cvB2z4lPpys6mwPpeYfXqFxZGKZwVxALV8iINGm0bCsIeidNLJL
 GcRVtdiZoe3Cq+3b6ykJ4AypJOrPWmK7wwgThYjTy27/oI6y1Jqm1YMOpd+ffY7Xy5DjXFAxC5g
 n5S6IJLSE4Xqg3CvOkua44ZIW+gP2IUO1O0gAP51yzrnFFgjz3r9GL4gx4xWiaOYV+nYWAu69sA
 qxjv7YLbGZQzpw2jFWDeBDgVwKpG3jqFEniR+EOTN170pBglkceeyuANGlvmHf4yCd1Or++JxIb
 ef7GUVwXzzD68Anqh91vIv3GAa89buKQ76CmWmWlMtKWQUgePbFH3t0zlW0aj1PKF8MtzvI5cEE
 I1kLij9C3d1EJgq+4DaRmpCATJL2889vU=
X-Received: by 2002:a17:903:b88:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2cf349ba609mr138979245ad.4.1784615835962; 
 Mon, 20 Jul 2026 23:37:15 -0700 (PDT)
X-Received: by 2002:a17:903:b88:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2cf349ba609mr138979075ad.4.1784615835518; 
 Mon, 20 Jul 2026 23:37:15 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bb8a4sm47161380eec.14.2026.07.20.23.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:37:15 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v5 08/10] docs/system/riscv: document initial virt RPMI support
Date: Tue, 21 Jul 2026 12:06:34 +0530
Message-ID: <3a8f2d3fdff3bbd3760d0a5ae75bcaffbda1c47b.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1784547370.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UzaY3YB2AlWO_e-rh8VhA5oGJ5gF1zDD
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f139c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NyBTYWx0ZWRfX42bnIawHQbTI
 djprgzDFnakFLGQRblcLeVJsm8hU/+N/W6BirC50jqSr9mbtWEnFzp05KAXtav7lWq+VwHAp0IT
 gae8pwJ78eWD2AQzpd2us02SILsVWiU=
X-Proofpoint-GUID: UzaY3YB2AlWO_e-rh8VhA5oGJ5gF1zDD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NyBTYWx0ZWRfX8hSm5A/j/XpZ
 ajEttJdvwL5ShVbqcVKc0MIWUfgp6BtR5ef7o7WGC7EqBAYEJN9izKaleT+qJ4FgcnQZ3kYirTZ
 v6zlcJtNnW3J+yMwPXOElKBj21EIrehoVj7mRe92G9C/fvKJkJAHCjWqrosxTCxvAPYElFZ0aGP
 NqOxgK4T9AwCqIyQeYYd6hV1dyhjUWtlEKvu9Mb8bCL4rGu+ZKwy1FDuJY5DOmDP+0SfRWnaKot
 34dDc07cp5X6aperBPV+2a0KGHjwJ+hWPb69l4Jp3fQm9Hi/U/Euh3NKdub7ojatRqJ61LrKG+g
 Jbe9S/FfCCWxub7Jh2VlJmWpx0wzRBKP4k85emlbRrkOcBO0Deye9CWfXfkhJuq9B3EofFwccVK
 mNIZ2JyNI/hCf1gvbUfr84YlangkeA1///+zAdiunpXhwGY5XlT6Fm+kort3dDETXtWl+QEdGPF
 jJczYRJ3TOceJHgBlDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210067
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


