Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B384606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R39xx0n4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gIi2dfz5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTD3-0005Q5-FP; Wed, 04 Nov 2026 00:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCt-0005KP-VZ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1xOTCq-0002ES-CM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 00:06:42 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A40RIUo3460027
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 05:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=a0vBc4PLM8J
 tpS9+9S5hjW80mO0/TB0W4hbgh1tAwX0=; b=R39xx0n4QkJCwrCHYuOEeS2XIiZ
 HwltcuZlxJ82qMUUIWFmq2olm1WWTwMv216SA79PNDfvfDK5JHeYP4rpwd+2M8pG
 qW/yKN0xyxwRt1kCpUU1htx1182cGvhRyfyM/l3pey2bNILpQoCvv5hU5UoSNnhs
 uMWAO4nl+vjf8ct78a76WoSaCSJY1uZ2RwHnn70IO23L6x67ygSM8o62nN/3PvBX
 Zdfjh36JnO5RjIYF2k1C00+SqAIiXL9NpzWugnyidlone4Zxgq/peqV/bmZtQIJQ
 oTJO5DsFGO2kWx05Eh31cq4XNlNcsDgNUEpOoRZDI3aL98yhPF+DQ9DYOHQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bubpc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 05:06:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36c98e5ad40so49512eec.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 21:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793768788; x=1794373588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0vBc4PLM8JtpS9+9S5hjW80mO0/TB0W4hbgh1tAwX0=;
 b=gIi2dfz5z/216iVQQRR7oJIRycvh+GxGHRM0ZHsKfYTpvdpl/puLvhZLm2LN5A+LCx
 z3aKtxE71q8/zNZakxncqwZ3ssy1P8HwYB1VhR05ewBuFzPGyfpps2cP67VTqg1PyTq9
 qbdih8zkSizazUHGolbXbIof363UbLMSjSZzjt0SD9aMp8dD2RGdDfkwgkSdP0/NbpGo
 oJu+etG0pgUhiXCMFLvCwsAbo9JD6heTqgJF1zt5PmUm+YEe3cZAXaT+Tcke1EWVXomE
 84S7jP0Qn+fH5paTImUi5onAo0o9tcV5yXD/ZFKJHEsCvvCnBijmrP389GgrdBp5qdn4
 zTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793768788; x=1794373588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0vBc4PLM8JtpS9+9S5hjW80mO0/TB0W4hbgh1tAwX0=;
 b=XDhUi69VsM7lqtlqsHPmcwVl7ZaQbnX6x0nwF1rNS9iIdgrI0gQO9J025JQrAqwAjg
 bcIacmb1v2ogC1jLz5lkKou3OUmo3UsKFH5fCBiYBuSqGG0tvlpmnyO1+IhM6EWDhUvI
 e3+5ANhswCOjSVXSGcM2QMVvc4ORyJI/B1S1/lubDD63VciNOzZKFb6J7x3y3HsoQrov
 G9OG0fkHYRm46zWmXcQFmvfr7yanREBXGvGVpGM8bmiGQ6rwaVtYnzwRdj/SjA4dBCGl
 +B8NXzW02oO6zTyux1zexfucxiLZs6UtvuojkU0lFaUNwdTksa1aNjUYOLGV9FpOqv5a
 g3Ww==
X-Gm-Message-State: APuU4Z97teRYOqk7caqd/i3FnJ19SFVybZNKT6y7riM8e0AkuO1Z9yji
 aPAENt7ygaogQO5KLMhydkdqHqx7HjGi7rg9NAYuKn6dvUdlCK796d1UkFRcb9L+6kfxbgxHsTq
 G30TutQEO9UuJP07OHMyl7CSN+YX9no8V6b21UmX4DLshYbENjiEMyZrf7qbjB6deDg==
X-Gm-Gg: AYBFou2TuZItCguXhOGuqm+hEroO4d54393jd5L4IrVUfcuKow/yjlJSL8evR5SAwZO
 e9jSD5iUidWq38LNbB1N65zlIpXEJJQuGmgvQsNxh4QrvxGahrMS59jMFjtAosrrzE3NlroCk0S
 VCVOjaMFuuEzv/x4zVoSKNfWtLlbMnQdsS2FrL6q5VempjkKRLqVWUlP6BD8vxJKAmTIDfZ3oYd
 iInLNDBskDvF+Pl9SxiSvYlAgjkp5UcGocFkziNUVKygk2jcp4Aq2iJHqzqNM7PZb1jkVQt5bEQ
 cmc7s35VtURoeFFYMtuypxhXcWAMXAQS7uGjfbBuau4ds3FJv2GRAEyWt0hgdJwE5eL6uChobWv
 Ik/kqv3d5OOAEAEO2BMHYxk70aVu24mHrHxsjDvGQysKyT+RMgxDORVaGS0sDvPRX/vjp5q/pyG
 z1MmYb4rvN1lNeSdM1Kfvx7IZcx77ijBklVPaNjLwtdzM4MXJDYMuJBzIrHmZOsB5sG+WLhrbOl
 egHNkT+
X-Received: by 2002:a05:7300:d082:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a4236a643mr29518563eec.2.1793768787885; 
 Tue, 03 Nov 2026 21:06:27 -0800 (PST)
X-Received: by 2002:a05:7300:d082:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a4236a643mr29518526eec.2.1793768787247; 
 Tue, 03 Nov 2026 21:06:27 -0800 (PST)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca390df28sm3925036eec.18.2026.11.03.21.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 21:06:26 -0800 (PST)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v14 08/10] docs/system/riscv: document initial virt RPMI
 support
Date: Wed,  4 Nov 2026 10:33:21 +0530
Message-ID: <20261104050324.733555-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20261104050324.733555-1-subrahmanya.lingappa@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX5GEkVA4b9OOK
 5l1MDVc+vZRuxg75pUGc1rkgP05wPQrh95ucr+f6C5Ooq00JUdZsBuw2eAHE3pirezXFTXeruY4
 MOACIusb0plhsqg62VpH4Nar3FJv6Ls=
X-Authority-Analysis: v=2.4 cv=AKV9GsJK c=1 sm=1 tr=0 ts=6aeabd54 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=bNRx8rSjxjkR0t5bZ0UA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: gXfNjbtIUM4eFYzllHYKTS2heJ2X6sar
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAyMCBTYWx0ZWRfX4XtZlAgYD+51
 mjTtV5Q+WN+o1Ys0dDPBHyGIUJGW0qMSgpN0+ezxcR9eLbrHVljcCa7P+drFXdT6kHK4uU2u+vO
 TPo2bf9V3jNMRNPLA5lYb67T2GEOYunWerDbAFAIY24C2bQ3NKX+T3sv1zIoBcWLlt7vW84byLC
 GBOOyVYAPt5WMh7q3JarTzuyiqM1qUzCnoe/+5DNFWjSjWqZFC+oFu6ZNBVq5bHU9kvjlAooHaQ
 ZpqTrMz3qPYU6QKeq0M/ooprKcfJTRJWu8coq3clbU/Oyf97nER7oTkBF55Qm+ynzbxBi8pxL/n
 T+QORyn2oyLzSpL66XCSElnxABYvuNOtaTd33biG4bEn5f3tZ2YtSWa3+SZulVbCkpvDWiUh+yN
 sTQCaPlJQ2L4psyR5ci3ZhtAlo441Ym2YJHbRXav8tnemBrRBhUxqxijGhriSnzPvwi9Rf1lhGs
 Q0ATVhcniR/cQT78u1w==
X-Proofpoint-GUID: gXfNjbtIUM4eFYzllHYKTS2heJ2X6sar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040020
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
	autolearn=ham autolearn_force=no version=4.0.1
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
 

