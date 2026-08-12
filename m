Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA47C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2zU-0008C6-Dh; Wed, 12 Aug 2026 03:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2zS-0008BG-90
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:03:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2zQ-00015B-J1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:03:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62BIn2646686
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vNILrqZOki4
 ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=; b=MHEFydadkc2YxCsk0OivPGW+k7N
 febsxu5yePto+utOZiZ8WPQ44TGSJLyZD9ZqgqVgdx338wrvbKrKMs0swycKpqXP
 7yTOAoxrpN7Uas809dXD9w6x6NzpdUUHqLA25jJ2QZ0cg0etknmXvp90qcEfr3Go
 7uK2+tFoDrvkBYYCB2ju+eHzTa+cE8BTGyzUOK1E6LMFryknPOdptUxlUmOl/h0Z
 ii2OSN5oRB+pia2gx3rfPBDjsWrmRwL7FmS54f2kKJRy1myRsX/DAnpqdKl0+E1n
 v2qbHmBBB6JoD15bsX0vvUBkl++8aPQIrmU6k8sise42H1rncufAw2n7+Qg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049km0v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-384d033f7f5so176415a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786518172; x=1787122972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=D+dqhdycnT7TxuwImeKf6PA3UGA7QvVuJ+m3gGPHxOAHz0X2N8TOpTl+vJYFtPDOHw
 KzgdjSKM9DmaYxHTn1IF31G3h5ZlyHNYojwyVHR3FyyQgpR65w/bsfV5m8V0Hm1Zcn3i
 xKdGHLAOjblw4A7QNivWkviU/Xf9maGnqSNdmaDj0FsBtnuAddRmFT2VRt6uSzBQjolF
 mmXuZi/4c5ik5PQheXRNnTeRiq25jnpExZiT8lE51px7YVmSvA+Uut78QUPUETEFoxOS
 uUpyipwvlik3DGqflGTlArKHO9nXf6BHhVfXozf3ehdTjwtkoa82yPvWIWIw+RP8r5yo
 V+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518172; x=1787122972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=LDkTtx4oiST6IVNl1pclv0ndymW9sAB79jUeUnFZS4j8fv/xDM1p2QroMnQmoOicK2
 SFkiCMXFmvd3283rrtpYr+5g2fmEYu7krNHr7FrPoW7hWZ0d9NvUW9Jk5CPtUvkvXSbK
 fXGupq/Me7yw7pOVDE/rsNe+q4PXh2AjTqCO1vy3SFWr3s0cqEGIhVEceKjC0Wf5gH8V
 C6dWVBO4T1lfDDpkU4G2SQad1CrxIvteKYubbO7R+u3b9D4+q9i620bKWFQnqkvD16YO
 /+L0peUKYaKz9VhBfoZBy+phlPMVyfxw7BTbyPIYf9UtKq63YutD2kR25710sNMT0yMO
 siVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rps4CpEDOSlb2xg+1pu8WOu8nMcWI6CiQsCwkTH88bejVZxjnRpdSf7TgyR8Smnest+onEBzUA4aBmY@nongnu.org
X-Gm-Message-State: AOJu0Yxer1lZF0Xs7zODwTTT3ewt7eNiyvCYXxVoNWV2DhhwXrESMlsR
 vs2IsI9cbt4bge1XM+cwMTc9k28damv0Lx7OM5TDBLIb3LQsaWN9HDkvqTHIZMUkIgmzuIbI/kt
 EUdPS7pMN8MWce2vLMPRDKslrUce0pfRATzC5d/2qFsR5LYqm3kYRmS5x/HNnfNvoSw==
X-Gm-Gg: AR+sD12AfzwO0Jy+wjsCs2Sk94ppfxQVQ6a2G3dQTwbmPDYUb1Y2Q0jR3ODaVrpZ071
 w4jV+/c2LYb4oF9PDrx521xgRwi+MJj2IAJV21oD00EewohgPLfA3qAE3hh2HFk3qPGNVdykcXC
 sCbuPc1Oa+xDYVDY39CjrBCmoiXIe0Uzr1kRoBbS/L88yW7s+FeKKPE6hw+fgmiyPswP9KPXheo
 3VTvGTXmjFIOv5o8SlL0XOpNbyw0ARbkvkEqGnIHPZJEfJfqgkMo34eQkYLjcr96qGWnQoAvfUz
 eUJXEEdo+Bal+neh/1psKrce9bItIePWRq5GTgoy+p9yVl/0jez6TnDyYP65sukcXBuZ+zPRyta
 xyIaVKhPUZbLKOkFKdsLiNEtHfy2LybDjDEQw3gFugcCbiM58ur4uXwqCtf3QsxGuPLQ19crzOl
 nX/um1dTGF63ll4GUDxtkUqyqE4tkGRr0=
X-Received: by 2002:a17:90b:580f:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-3930121d20bmr2144239a91.1.1786518172181; 
 Wed, 12 Aug 2026 00:02:52 -0700 (PDT)
X-Received: by 2002:a17:90b:580f:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-3930121d20bmr2144190a91.1.1786518171675; 
 Wed, 12 Aug 2026 00:02:51 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf3c08163sm6796627eec.7.2026.08.12.00.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 00:02:51 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v6 08/10] docs/system/riscv: document initial virt RPMI support
Date: Wed, 12 Aug 2026 12:31:30 +0530
Message-ID: <20260812070133.3059679-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cejzJuKpEQM72-8D7uYRZAPJlrobvOj9
X-Authority-Analysis: v=2.4 cv=IO4yzAvG c=1 sm=1 tr=0 ts=6a7c1a9c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=rl5im9kqc5Lf4LNbBjHf:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfXySaskyTJVvcq
 BBaEY4OhWB4MoBCZ73zoQhw85Jl3+Au2AvVQUFaZkbNWv5ZtXvr+X2knAQLxCcz7wiPMLEdW6pd
 bpKu6kZk2hEdtIE5L1leLRFI94EKiD3to9wLn0V5S9HT2kpJxEf+4NIK3/+9hVPfxxDuELWi0q2
 tHWCYN17BMCZ3ZPdC2OxwZvdkaGFPCJj0Tyy04/Lr1/vlGp0n2PO6Bys4gcm76WgVvKF7zn7Cxc
 0NORkuTrlMxNe3mv965afBdW8itEZGd1uNBlIOjAR1KFCCw//+EuEh0upDoLecssMtYQ0bjdAUL
 Lq6buvWs5HsUfsjiC5EvRMGpTDBXndaDauGHdczW3Xnxz+NKZcIwx7Ne0Rv33LSbx3TFEbFl8Na
 5Y+dxrbFkBc1gc6qO8ELkvvINTsUEWLqpwf/lTvBvYWXR++7FEZwZau4ILJUnjaAvPTxoF9fcph
 UeOCe83/hDd/YE1AsLw==
X-Proofpoint-GUID: cejzJuKpEQM72-8D7uYRZAPJlrobvOj9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX5D9xF620dTSL
 x45HAr58wBezD80IV22NK+4aSBL9KSpUsWwmr5ozuwYc/pnriYdoJnvdI+Mtm7n3vHikIMESeyy
 qM5/ClOy8/99KCRGVAkght9LM+tKabE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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


