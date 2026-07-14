Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY2L-00036w-4E; Tue, 14 Jul 2026 03:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY2K-00036G-FU
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY2I-0003el-NR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SdVd3887433
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=U6y6SilO1AV
 1Q+WR8PyeRQ5YjxreSiS9tob5zKwbsaM=; b=haVMKRcDZvGTVOC/YsCOIN9/tE6
 JyYgaW7wyL9TAaOsPnU4JJQ06O0D31baVN+bo8aWXPpS5H6Z1YKMXEcWmeZvTJO9
 HPVsgDVYLJInVfgfAJhPKhvWz1mNxpTpArVW6CudlNFNETd+6RM6FQ8QvQKQJHjd
 0ATH4dHOyA5AmvDhio8/0acvpdMLX1ISzoqK7KieyHoNGzB9OqyIR1fTJgg5H9nL
 ncmv9lDwGNzRSdmAcoFA375TeF8EYcYM7XW+22L6NBRgQrpsZG6lqrI0kkVOIERM
 oV8SFtRYO9t4tcAnCMpgs5wyPXTl6oZ62tO4UNCIrScrBRS2E0CyTMJMl5w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdbr4983r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-380f3670853so1309309a91.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784015907; x=1784620707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U6y6SilO1AV1Q+WR8PyeRQ5YjxreSiS9tob5zKwbsaM=;
 b=ihV44B1kYadGEiVruWXRdvgp1I78aWPz88yS1lVQ35JT6dtUjAP6ilZwYkB3DztJtz
 9NhrTdWhOFKQVYD9Yh+W7gZm5iDJQBlMH3ruLyLzsm6HAP9gMjYqZPh3SXk0yUrx9yEj
 la8hPvjoUJuhfOhvCZEps154BpFa+Z9loCGWC7DGz2yd6X3Az/6pIFzUBAqWoY7e5Ffs
 muTFT45NYG/j9fUD985AzG8JsC0Ba0WSHZEGWNhtiJacVR8TR7wIBL3KkM/xRjgy11Il
 vRV2El1NcUJViAh5w1KgjpTkRgW6rG7jHYp8PAu+J6jLYsYC5kmjqO+OCLv5O/p3kJHa
 cO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015907; x=1784620707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U6y6SilO1AV1Q+WR8PyeRQ5YjxreSiS9tob5zKwbsaM=;
 b=DSj/9SVO/iPRl3YXVzYckCMpmD2eA4RMQCKb3CZ1eBBWij/GkPKk8CVPpN5dRKIBBF
 vghCWla0FtXHbKcZxHp8Nv0rhnPUrwzkCSRYqzvPX5yZBKAtsFuDyN3k7Rucr9xbq2K6
 pMs1z+0o6dnv8M8zDLmXV5jScin4WyEfQM2+8xFAkC+ru1/IWBQafgi54IlDp8kAxpRy
 H5htvAhqvkSornLTTVXcrIOrOBSRLciqxCNpuh3NYHtb7XLHYj+qXDYd+2nImmyAbwLf
 OmdH2Xu8dwFG8L425R+qpG1Ag8BTcQPy44ORmb6CjaLawxSgVu6ReNa7G2DeJoe6BRgJ
 HsHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RquJ7Qcy7Q8UwlzAqFXzTi20TwRUhJXNtjM9+nIRGBouh0nA9xnmsh5eL1IJFMekBKsX0SBVO0BLiYM@nongnu.org
X-Gm-Message-State: AOJu0YwRNfzgR2b3Nwn+SAEukG5lmMOm2qAkcTGMLgXL+hh7zwMhzEPL
 nDhXHpor4DI1hRV/Lb6IVgIUYnFwBfQ09yXdjPSHcEr1Axn8huF0oeq4upVToQO5RE2jsUUadHv
 +WunG8g8Xor8hRrjzAPhZjHCDQAP9dnJm/zoAqoL4CXfeq4Z83JD5C3hnkR1i4pVpjA==
X-Gm-Gg: AfdE7cn+ywBjJvCYpYI1xfewz/Fo7nC0b8p6pTvpwBQi+jk/SvT4/6B/qfeMtnNBK6N
 OviulbGM2exEwYhmaRS1mwvtkAojAYCX/0cvFWwwqsr05+FJyf1Wkl0O5rNS0Tsr4BK9GQ+Rz4C
 nhIgMcZZqoabzAQUFKCOlEtnhaEMdKGA3mEoKavKSHxiJOHQQCSikYHh0LfjlUET+fXMC2902+U
 XzPkdxj57zGVXsBmymHX9w9FxJC8yilnUXIL0ggHCCCvIyc3R3QvORBwAWJMB22xHUUVIFCQQgq
 nfytGCjUYtXvz5vMdkXFggp8hxmVpvtzZy9yoxgQTSk96of08+h4pSID+MhIANE5GvdSBYzJs3U
 9D+cHI+RNcZLpecimi30nwfote0iR8F3MIS4qZiTECgi1q0kwEhNWXpmnHVaOiLo03s6MtvtU0L
 gadBaNaX75RxbVcxSyT+9Ab+49vR5KqOwpM+jNYZBF4g==
X-Received: by 2002:a17:90b:3d87:b0:381:fa5:5217 with SMTP id
 98e67ed59e1d1-38dc7848a6amr10094126a91.7.1784015906750; 
 Tue, 14 Jul 2026 00:58:26 -0700 (PDT)
X-Received: by 2002:a17:90b:3d87:b0:381:fa5:5217 with SMTP id
 98e67ed59e1d1-38dc7848a6amr10094106a91.7.1784015906177; 
 Tue, 14 Jul 2026 00:58:26 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm55606355eec.8.2026.07.14.00.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:58:25 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v3 08/10] docs/system/riscv: document initial virt RPMI support
Date: Tue, 14 Jul 2026 13:26:57 +0530
Message-ID: <20260714075659.2258023-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 50EwWwV-EMXyhuo2Y9Yx7ETXqGO6g1d8
X-Proofpoint-ORIG-GUID: 50EwWwV-EMXyhuo2Y9Yx7ETXqGO6g1d8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX3zstgYWXXQTu
 rTLnFlGk9/+/luUOcFZBL3ZigyrgY49aYm3bJR8VSUf1t+BafuDAXzZLGOhuj8M0O7QC4S6w76B
 9NS6daNhIEQ+mGpPfI+7HvX36RWJx1QDdjdqHtIjfwgaltYW4xZOfw63bVLa+trshe8250jtQCx
 1xl7DOSH7DBIMF8tTJgrInfWvri3O/v4CehFjHZbr9MCjVafGndnR1X2FnFUiMLEKFO/Uvxk6ds
 xz+Z865hHKgGTAcljwHd+H1TVlqPynB9UQ2MAvqotYmBJ3OZZvfHtFePLmLXq8FixXRFLjrgqxM
 rhvy7KiHFOeRC62Fkf00v4VpeyPlX7J10RoVwfBYR52IuBjbpqaGqmS+CHz6EI4CL7yNuN9oBOs
 byq9bbmqPk+uFmI6qla8jDXw8oUc3FYwWOIf85cDb3WHqyzPFARfybwTiZtURww+Q4mcqKAuYLf
 wuDhXfiASeNoY/10hGg==
X-Authority-Analysis: v=2.4 cv=F5hnsKhN c=1 sm=1 tr=0 ts=6a55ec23 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX34ND8uvgF++d
 cNmdAN79JJQcwcOhWdrhlI5S2IdHSCpjOW95f0z1AkF0BTuJyeJM5o64V+NX9Dw4M00KfavMKcZ
 Sj2ohLBlCrc8Hzwa4M9TWQUk1zd8AtQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140082
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


