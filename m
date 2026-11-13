Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13621606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bz/13gwG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K7JWyKon
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmCb-00033z-Di; Fri, 13 Nov 2026 03:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCV-0002pR-Uc
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:59 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xRmCT-0000FS-Sa
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 02:59:59 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD56wmD3556936
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NtmrcfkoEnF
 gORxvLVobnBrxdwX1pUc2LacJatwTyNw=; b=bz/13gwGnLG4kHP0jmwIoFVEVA1
 Sc6oFvWwJphCgZBO7zymsmM6jpnEIH1lOprKS570rrynUwhiKMbcFY1i5cMrvbZv
 vfqaEebl1xiOQN1Ek/uxG23jYEavnDLJny73zavXYK7vQcMr9bva3SELh61eel2m
 B541T6vYnWpDyVqCJMiki37MtK2VSo/jK+XIwiSmXv9GpEWt+TIuf0aw7Ms/EqNL
 Im8ha7VY/+Dsn3mK3cJX5jCgguEDXfI34zQP2LUPI+AgbL2n+Wm6GlNbqT390WPX
 GDibjmQlDz23vwRqajNh5D9Hq6m/s9ZYPtjvKWAJbP3+nmcQfWfZyj2IqcQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdj7ek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 07:59:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f7142accfso9464eec.3
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 23:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794556796; x=1795161596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NtmrcfkoEnFgORxvLVobnBrxdwX1pUc2LacJatwTyNw=;
 b=K7JWyKonb9bzwOcpBf2nhSOJCCib+qlJHluR3AGY54+JSP40sGUZEzm6T1tKwnKgfz
 E1MTq1VyZaoMxgnxgXqjyOYFY9uMsZiPVzU6pdUwOUQoXeDM1ROxacT4Fj08zKjAS0Pr
 WBErBewZn9KCRShLC+Mft+Id335axnxf6B6K725WCf+Eij/LCFiNx/iDMAu8suHeppOp
 qmds0Hq/QLl+tjCqVC1EfGXh7hxj+Fz4EhUQR3S0QyrpKbH9CNsXpTisVx306wCLaQte
 +Y1XTOk2DocJ7nHNhlDJ5fadiP+NMbDh8F0AsjI6k1r17eTq2eI7IpqMWYp+uMfGKmn2
 Fwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556796; x=1795161596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NtmrcfkoEnFgORxvLVobnBrxdwX1pUc2LacJatwTyNw=;
 b=s+hSmAbANYboSUPMpw6eADmC/3+TzuTbYXefaUogXGofsii2VWClGDWhyBP0ARR4fh
 U/AkpKFhAo3g5QKPowxZXfXToYF3zH/8IuuvG1A4YDsDJ9fk4wDwFP2S00IsSw3IbBJW
 0sewNQkMhyexfOFKR4EsITmjduyZen+ET8o5WO5DC7j5efPP6xoFIQ8cjEUm2ocGa5+g
 kHpsXIx7iElKH0dtxkHo1FK6jH3WwKrG9cpYX7n7N/IhPhiGa1u25e6VIVZ2BXD+z45T
 IImCDlxFCRn+bD/Qetf3h0LpJl1VmcOMeylhbI5NbL47MyavHLvyIrcv5VlD/bQpdL2F
 qFmA==
X-Gm-Message-State: APuU4Z9SNV+zlEC6A/jd6yeqizycEy5NkotERHAFSOW4wMLUJIPWejtA
 42882d4RwAvoIYbNcItmhnbGn8rHXO+C+OJQZ5KUVM0GOP3OL51xkURHwVSWua0Hx6dHcZjL/B8
 NKM19CtVjyo9e0XkXZLRd8yb5ip8KhArWwWI47/YZ+nePv7baeB7hNjub9KYc13dK3g==
X-Gm-Gg: AYBFou2mfVG0ke0yqtqbPYHtoSeafmL8N75AGQvu7VC1VuWpnY/fnhQo1sVwGysjADq
 CaGWDZb0puHZCVVAzfW/UdWRwfaPOP6GR0HhWRuEnBhM34FNK/4Uxn8N5PC3Gx01NMF9aoM1xxw
 4e/Y/YfbVXpo2WXplsKk+XuHgXfp5sF5qhv+ON5qjDmpoj0y3xM+D2U42Dcgpq/pDM34j1W+M5b
 LUAZGZqKD1ergduXf4PKDBS1o/rWXPT0wiarpLGSQRofuiDjWQjmQd9pD4N/bdrWjid3It7gk5Y
 WRJqGv9CYeCoToafO4l3Xn1/ltCrUGpSsub9CLJ719w5kBdh57GuRhAEkFFTJh/VSvXq8Y1yBSx
 Vw+UghwAPaI11BMTJG0qFiad4aji6S5cMatTksWfYgmK6EjFkQREMF3tfuq8qA/lzwXVm8UOXp3
 HHj896POdMdhCG7LrCXzMCUf3C1BPaX3zTun9c/c1LEze/cMtnmjXEIdvr6IpyFdvZmC4AqrXNi
 hSS/ag=
X-Received: by 2002:a05:7300:6da8:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-379659c6815mr3069714eec.2.1794556795413; 
 Thu, 12 Nov 2026 23:59:55 -0800 (PST)
X-Received: by 2002:a05:7300:6da8:b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-379659c6815mr3069655eec.2.1794556794766; 
 Thu, 12 Nov 2026 23:59:54 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378c2fesm5213376eec.1.2026.11.12.23.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:59:54 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v16 08/10] docs/system/riscv: document initial virt RPMI
 support
Date: Fri, 13 Nov 2026 13:29:03 +0530
Message-ID: <20261113075906.715870-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261113075906.715870-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX3U7DYjhJc7yz
 VglJJexw/D1jWhad2qn8Gl7RuL1f5K0t94/8oL0nkWCjdMUoZ9B+YlZVOtbKIgA6g/1WjlM6A14
 sm2wnysrkOtmwI3WvdxPVTz9yz2q9CE=
X-Proofpoint-ORIG-GUID: tthHE_pUniv6_tkCfytdV150sSKR0jkD
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af6c37c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=qErgiAeUNlDKfKC9Rl0A:9
 a=PxkB5W3o20Ba91AHUih5:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfXxOgqz37qZyfN
 h2fqopXfEkrA+XTFDocj3N2hnyMo3i7scnJB1wu7LKdPjqlsTZZVahWine31eCz+BuhWK4DMbfB
 EziFVCdt6BBs2avtc06+ySBSTcGV8g68TdrZtvPMWQuQZNMlBTBBArD2MqBLryGvZUblQkN7tV2
 821g/MUZiQ8Fms/iyGEL03lUM4CAWAna8juRETWDSmjuiHpN/qDUIqFFiTUp9COk9QVCFZFt5+7
 OI+W1y8E9NlNlenTlyy+DV8caL3khNiQ1KpJA85AKQjY/GwJcuoNPMBZ1llvY6Na0bNXihkPidF
 V/39uGzlIXSpXi3JqBBWQxXTcPe/pn8o/BQ+Pa7lGdMYavb+1yB55gNXj4YeyKm9QRgmgeKQFdE
 XtACrUeqlWJewxKj5IPj6G4N72qpebGk1/4s0iScLECfs42w7XacA/7qpnS4J98YC0fIpz7yjEX
 KHRvt5TdQq5v517TLSw==
X-Proofpoint-GUID: tthHE_pUniv6_tkCfytdV150sSKR0jkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031
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

Give a pinned OpenSBI source build and the thorough guest-test command.
Kernel and rootfs use pinned downloadable assets unless overridden.
Firmware still needs explicit provisioning; distinguish skipped tests
from a completed guest validation run.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 docs/system/riscv/virt.rst | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 3c87246891..5b48ca0ccb 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -149,6 +149,105 @@ The following machine-specific options are supported:
 
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
+The functional RPMI test requires an OpenSBI ``fw_jump.bin`` built with the
+RPMI mailbox, HSM, reset and suspend drivers. For example, the following
+upstream OpenSBI revision provides them:
+
+.. code-block:: bash
+
+  $ git clone https://github.com/riscv-software-src/opensbi.git
+  $ git -C opensbi checkout 2aed4ec24f5d85312e528d2a40d7009800d55aeb
+  $ make -C opensbi PLATFORM=generic CROSS_COMPILE=riscv64-linux-gnu-
+  $ QEMU_TEST_RPMI_OPENSBI="$PWD/opensbi/build/platform/generic/firmware/fw_jump.bin" \
+      meson test -C build --suite qemu:func-riscv64-thorough \
+      qemu:func-riscv64-rpmi_virt
+
+Kernel and rootfs images use pinned downloadable TuxRun assets. Set
+``QEMU_TEST_RPMI_KERNEL`` and ``QEMU_TEST_RPMI_ROOTFS`` to override them.
+Firmware is not downloaded automatically; without
+``QEMU_TEST_RPMI_OPENSBI`` the six guest tests skip. A validation run must
+provide firmware and check that all six tests pass, not merely that Meson
+exits successfully.
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
 

