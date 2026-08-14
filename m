Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E776C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 04:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wujvr-00008c-Kn; Fri, 14 Aug 2026 00:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvq-00007v-8V
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:54:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wujvo-0005N1-Il
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 00:54:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QUNF669225
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vNILrqZOki4
 ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=; b=B1cEmVUD/mQpjE/RxIkyYXgehSC
 z5md/wREdml2qmnLS2upsz7QfH0qipufTWHQdtecbBKQhdp7gashTTElsqkAHPNm
 +PWaCh32uAHZNgqlrXmc1G47rOmvw3yFoBe/0eSiQFR6KeEoQNrJRTnw1l2xGrCb
 WQmyddJfNkGZXSTEavacWPugSG3QYe2/oTum6GvxfbVdaNF/ivBRQGwrTTDLmZIs
 p9Yk9jYQVxv1Py22auIUlIeTePTwA+psr3orgUendmf77XDL2WxZ2HhOz7e8JXSh
 pGCrI7WZuBdSAvyHD+XgoTobL5ONwBedOB/CYRPLRJjHa+ebhbPLFWe6oHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1utqmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 04:54:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ceb3d20b7cso1300655ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786683240; x=1787288040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=ImH9Q6iwThoG0ry50d/zTnMnUwYnJ3rm/lEpEqWvZZIOznCx2T+aZMiuwW9Pw6c1qu
 NuxB5W9fzeKVIL8YlVHc+JvyB5vJmP0Ow3xjifir60wNsHH65TmtbBK+7k/5gqyH6PXc
 XVhRHG3atQi9yx6h72wfUuFjVSEODdXEsTL6qG//dCkBy5nyXRHGsRfdLPYCr6qyLfdv
 cWAYXWv0nZWPpaQuKKCXy95WAZnZZ1+kmWaw4+9UC3FudF5q57+TJ8nw0GJwz3wSX7cp
 NMoCksTPVlM7a1Hvyyb9cXpbQSdi28Fqenr5j56mNU2yb3HLru31NZwrRi0jzAXSUcxw
 e/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786683240; x=1787288040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNILrqZOki4ga/4fJZJkmvVhO0/4YSMRXaOl2EAjZlM=;
 b=Ps+tDLfH0zXUf+tQP8qknbrNWlPckHX9IaFJFD2vDz2i+DdqBRIVopKbVSMRO5Hls9
 4T0rBpT4KHCFEZwTap2rezRY7cdv5ztA6r6JCLIwasQBikT73Gs1VGBrazL4Tr4qDWMB
 E3UaIdDNTQ9lQrzycC4djcAB2rMCh6VgltHtClvZGxJSWnF+KtlUjZP92A74D+E+X2N+
 Xh8hJnMdC29Ik0IAjNc3XX51IL/gurIKLiTmtx5iYb4Vl/y5P3b8VT35LkMmn4+fu9xI
 4Ny/FKiOXRjIgkNVyPhltS0Mf0P96T8e3277LvKqkOukZa6X8TJ9T0CzC43EOtC4cFKM
 afYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCrnqWYy79lMF2lQ8VWT+1+e+U0FDDi7L9aEaASJv35NgQE5kzxzfUNLvb7xkB/57AVwyrDMCkqKTH@nongnu.org
X-Gm-Message-State: AOJu0Yz9kBerPjgwFBKFwO6Yh4zx8V7RLFOzx8EYAhsL9GO0u7UNOChl
 2UbkF1l6++61+b5bdgz6VeuWM6rHw9EO3vjUU1RQlZAf194xL/+Qkj1Fpz1gTDSZ9JOGZJ8pHvc
 kdoXdiapenATItR92/plYm/RrWp8oTdbB0oZh+AUMdYhjGFx6cjX1VTFOlw==
X-Gm-Gg: AR+sD13LQP8U1GrhE6eqKcylSz0jZyksrA8sZ7Fa4+Rcs9zlrTdGfIqOjN6dBZu6vNJ
 wxKyS2gmvAEFH/bECLsnAViUlBtReDQQ2nHHc7eys2ysp+5dnbR54HKAh3fVQYJ7C9mdIYSRxf1
 mdKrqu2cENeDnrbjfpkt2TPVsLEmp9TShanRcjaSVdJcuGlYYk1iSvXgm2DriD8wT/r4ohk2X0D
 v2caPz97+o63hC2rVAJheEpBAxx6cHeStQ7A4Wd4P3o53SOJxiioVZEhTnpQYyslpiKq28U8ufE
 1EWOUi5GId81QFmYUVHCqZ56l9V+dfYDMQEy+UaXfi/rKs+GeHiD6Q+Ne2b3UYnzMuEJMeNYp1J
 MeiQ4oVrkXy+pom+JD1r/8f5mDcu2w4rq/ARAskDESznpeYhh2kORKETMqkWI43QNkXaKxvPe6Y
 q7LKxlynjoM/LI6z9W5wRfzrac0qBtrU4=
X-Received: by 2002:a17:903:1b2b:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d3b0739429mr25659345ad.0.1786683240587; 
 Thu, 13 Aug 2026 21:54:00 -0700 (PDT)
X-Received: by 2002:a17:903:1b2b:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2d3b0739429mr25659115ad.0.1786683240100; 
 Thu, 13 Aug 2026 21:54:00 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f15063cd8sm10625665eec.9.2026.08.13.21.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 21:53:59 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v8 08/10] docs/system/riscv: document initial virt RPMI support
Date: Fri, 14 Aug 2026 10:23:12 +0530
Message-ID: <20260814045315.3416169-9-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0VSqKrGp5uYqCim1wXy-j6Kk-MyCbujR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX5nEoxyuf8qCr
 kzNzKDJ9OXEm15g9UtdxhHsTKAWR3qlsIbri9WwRd2eWEFAJWuP8ZWokCA45RrgS6mdchhfVLj5
 6LiUvrdAaS+OXD2X4nvyqUTzkvhugzgYvRBSi1G+bOaps/lmuBxkPb/F69EF/YQ92GkaSV8oPBM
 Vn8T0MrvsNZXv7fUKxpgQVOLY4XReiJrGTGs42odVMR0c7dIUShuveMBmg6HhXkbA4HvmQzCCFu
 YDYW9eG4M2NibH0bdNrD+YjZXR5qWBgdCC5+t0C7cczFLS7nYDZY/pP+L583xi8sg71Ju4PqkFl
 y1Zd0q+mqVQ2rprnyoYVpLmDsphN/1joTl6qta5ORMVgosxFxBNFvGknJvvskN8Dycxpz/zkTUC
 pbDbJxJIQuiLowDD76CZETcZjhtPhQVvbU+BMqvOWvEV/iRcFpeRePEl+LSP5rHS7XVugGEL4e6
 0c3CZxMH6CqM4B+A6aQ==
X-Proofpoint-ORIG-GUID: 0VSqKrGp5uYqCim1wXy-j6Kk-MyCbujR
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7e9f69 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzNiBTYWx0ZWRfX8fgSSE1PzCMn
 GezD9COpX0j07o6Yyw/3fuXjfaGQsG0UfEZHKkaGw/eJ6xWuR6kKNLYT3J9MWSPGNdS3QTVPkTV
 tsUV9ihiupxi/0umM0lvo+8YcU6un5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140036
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


