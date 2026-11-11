Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFD606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aZVsClSg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fTtok0dT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR1Sp-0000aA-Nz; Wed, 11 Nov 2026 01:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1Se-0000Q8-Lb
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xR1Sb-0000nh-L2
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:05:31 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KQKR3959060
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=a0vBc4PLM8J
 tpS9+9S5hjW80mO0/TB0W4hbgh1tAwX0=; b=aZVsClSgf1E68zlNW9uZyxe3yLR
 H0CC7BOvj5pbnEHk189tqoFtG+bE3q3nBjX9Af3TDconVT5jqFCUTp0ebipjJl7W
 QA3zkO0/40aGcq1LAgWXUlH7534GA6JfzkfRociFsrQsFjvMxeslrG1msX2vgG5u
 1AhFTlW+QeVVKlz3sjKtZotCsqmiXP8EfX5BFV47/1mpxXsO6zb8S+uaxPLcSeyW
 XjYSpmsWETWUSmp8C5acgJaX4OLg2nkK1vMG4xESkjqfZ7sx19Db2SbM4GDozzuU
 IaxF/DzinVbiqfCDDqBktxJL1ymNQpB8lw/+Odt5ZjQzfnPYbnBEXU+dLEA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b323t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:05:17 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d2ca26a454so12067137.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794377117; x=1794981917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0vBc4PLM8JtpS9+9S5hjW80mO0/TB0W4hbgh1tAwX0=;
 b=fTtok0dTVr7WQZWbgHyd97flCl0hK3vwV7l2SjFqGy0Jcvxinb72lBOnvm+MIr9XF8
 b14O0H9iwesq7ni9UuDElNPQjf1gEuQzalRdtcA5XEKQjKdUJVJeiP1UtD5nxELdEEPN
 cj4M+E2Pts4/UgJ68QvNPXxE/xD/n95uFMJHXMM0gVfcIDbRe2lh+cEhh/GH/cx2zAcp
 Bd+tqNiw/tqZBJ7m2yQcqHvRnnbb/kmmfTfDVJ/WToxpFaZ22MFVyGrNdvbpLQKV2/PU
 JCWVFtuRmbSzgJ8qH6u7RS2mctN0mgh6CB/J/E8QRkC8lqfHgIpDyMXYqbInD+OfL1Si
 NePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794377117; x=1794981917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0vBc4PLM8JtpS9+9S5hjW80mO0/TB0W4hbgh1tAwX0=;
 b=ipgFq5qIm6ny6EQlzJGDevd86WlZM9LXy0riDkLYkDq4pj7YTkLVycJ+/JoboxxPDp
 OedG/tXKPmVQLHB0CQRGxjS20CJz18N+r19ZJF87oqq6dMKpHOdejmLYTFDI5uno2Fhy
 5/I95XPur0qqL0Gp7TH6Jwn17hxkPBcqRkc9G8cvDGmghSE2vouRF2k0dFIyoMF88UAi
 uBT2P9QLycXmwzdMZ5t2yhDmg1gbRqms7O2wlivVHvVz/inb9L7g7DpdasejcXWRMiYm
 qgi/JNXokO6kFZqSWApYoRHxBQbHOqKCG7du4vkbc2Gt2XeINupnHUHlnrMCgGsa+ShB
 p/vA==
X-Gm-Message-State: APuU4Z+vwAXNJv3QcQGr0jqPfapna0ePCn1qgMSpupZLeNHsBvoPYQXV
 xZjFyuMqyRFmc9VPXYAI6FX97XyGvyPKZSKURyynvDa6wjy1FdGTorK21XZNJ2D7mOqt6MuyBMl
 eLwqEJkJxP1stw2RKZ6UM13ymBnSyplBx6oz+l3HolznBm8uAvkK3/EfDCjsyOa8r1A==
X-Gm-Gg: AYBFou2ukILJCM/6MmLG1/cYEggFRHy3Bf3bvOQZXX4PqP1hpcmSwrDbG7cvntujetb
 CN3758ItgcKaNMOS0J06VAlQPW9QjspVkyW3s67JA0xjkE0et8a/YEoNI6G4a1Djy0A7MVZ27u9
 tLaVqoq/LAb8oqQFCGJIHlMdX7BFiIUi/BDgAVQoKn2wQNSpb7xQdJlPn8bJ8lLlTmVe2IcZZ/w
 h82N02HnyvWm0DgN9oabRdtxYu01mwsIw7QxxUPxSgjegwqhj2C8bdt7O3iOC7KYZ+LRydNZ11r
 oh2c//HegyE8rmN7veAfFt91tGxD4lrSiEgeMdtgrPwwGSfE+81c87N57EeDkumWi3HxuBOY7cp
 oPep9mHjjeUMUtU/SAfV2xrfWCL4XBwrrC7LO3Yvpgbook1li93mn4/W5nYV9ESKjUPFdywjQmi
 VBvLCF+4MVApKck2DOrXRG9FhHxN2PwNVB5z9/6Jlhgo2Q3G4b5IpGVWCRPpex7GmeAc2YCnakZ
 lfR5PM=
X-Received: by 2002:a05:6102:1a02:10b0:7c3:99a3:314e with SMTP id
 ada2fe7eead31-7d4ed9d385fmr448134137.0.1794377116799; 
 Tue, 10 Nov 2026 22:05:16 -0800 (PST)
X-Received: by 2002:a05:6102:1a02:10b0:7c3:99a3:314e with SMTP id
 ada2fe7eead31-7d4ed9d385fmr447780137.0.1794377104270; 
 Tue, 10 Nov 2026 22:05:04 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b2ff3bsm15067990c88.11.2026.11.10.22.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:05:03 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v15 08/10] docs/system/riscv: document initial virt RPMI
 support
Date: Wed, 11 Nov 2026 11:34:00 +0530
Message-ID: <20261111060403.3777501-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261111060403.3777501-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af4059d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=bNRx8rSjxjkR0t5bZ0UA:9
 a=crWF4MFLhNY0qMRaF8an:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX0FIe3Qeqc+Aj
 j8sRW1M3Lcc6Vjz5rtyQITaBMHy9IQEM/45QqIKu2tFS3qjv1phz6HzK/e0TDHrQXgXSgm44qT4
 Jz+mcrOKzwuIoi2V2U99MKfqiJbqt6su8n68yGUAp5U0iipzHbCwDuox1BWMvNAKY1UHA5yUIQ6
 BuNKEj4QUPS68kk7F2mx3+Af/ddbOFqdXvH6Ct38JowYLD0Ay6MHl4b/km+n7NEC7mVYHlYOGmJ
 5I++rP46x3bR6Q+af3yjWNaGtpR5IMX3CpJHzH3oygX6hyxqh6m2OyZLTyFH78+Xcvk/VRwQEn+
 xPVwoMMVUAqWSuzwW5Me6Rhv2kIs9Pk56hpmRV+3BUL1usM0HxctlINGU+x7THDyRJnRFdNfpiM
 btznODmq6JbraVq4p7fNQlidYO/6kW5Y+730YgHrHUD1Vc3pg4L0ZTZeKQr1PngFVxPPLboIQnS
 zOTNsRb0eQiCXDWM8sQ==
X-Proofpoint-GUID: MNAZw9h5ekclqBa7hACg6_VLQ3HDDcZz
X-Proofpoint-ORIG-GUID: MNAZw9h5ekclqBa7hACg6_VLQ3HDDcZz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNCBTYWx0ZWRfX1FLkomN87nh1
 irz4mtHSQvJt9NKlUDr/FBpm6093OEA7Jci9F3Nz0SURNGwpar/PUD2ZogGp/i9AubgyPwNW/Nm
 04idepqqAxyWwYDMNg22mztKfdOAa5E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110024
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the opt-in virt RPMI transport and the initial HSM, system
reset, and system suspend service groups.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/system/riscv/virt.rst | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 3c87246891..7835913e16 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -149,6 +149,85 @@ The following machine-specific options are supported:
 
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
+RPMI qtest coverage
+-------------------
+
+QEMU includes qtest coverage for the RPMI transport and the initial service
+groups in ``tests/qtest/riscv-rpmi-test.c``. To run the qtest from a build
+configured with librpmi support and the ``riscv64-softmmu`` target:
+
+.. code-block:: bash
+
+  $ meson test -C build qemu:qtest-riscv64/riscv-rpmi-test
+
+The qtest covers Base service discovery, System Reset, HSM, System Suspend,
+negative transport cases, reset behavior, and migration blocking while RPMI
+VMState support is being designed.
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
+``riscv,rpmi-shmem-mbox`` shared-memory mailbox node plus sibling service nodes
+with ``riscv,rpmi-*`` compatible strings. Each service node references the
+mailbox with an ``mboxes`` property containing the RPMI service-group ID.
+
 Running Linux kernel
 --------------------
 

