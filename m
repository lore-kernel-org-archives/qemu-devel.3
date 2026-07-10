Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8C9C4450A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEf-0006Vg-8U; Fri, 10 Jul 2026 08:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41V-0002Oy-MY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41U-0007rH-1J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n3V73661712
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xfihhQahT18
 tqw16GN07qOdNHK6O56x78Dza3ykZ+F8=; b=Dpwn2P44Uo774Wpu4GHXkr5ieWD
 DG3i7SqKtf5NKUl0+j3Kex7hOiYo21WKUL4TPwvZ+PyStJJIbSfUfDtXSVAvkbj4
 nnGpEeVGcVJmAR/AmdEx4epfeH/61LZa2CbbWpRtNc2B1gFtk9rVH3X0/iA6gG0h
 lrEMOE3MOx67XITli3mgZNce7rqEGT5lg+hrkUA88BUzCgxD2JKjQlYLLqJFf0Gh
 Tu+832K48ZlLKB7uf6wcYKnDrkL2ugR/F+kfecAMcO/OcNAVVAY+NVB+Rj3mwe7A
 ODiqqwUgrYkXUnbuj3GWwdFSy/IP8wIIPiw0C3VWsC+EdeVNfGNUqc1QIKQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24trhv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce756aa72eso2997045ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783662218; x=1784267018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xfihhQahT18tqw16GN07qOdNHK6O56x78Dza3ykZ+F8=;
 b=OFcwey6EaOCv3sae5y4roli7y2bCNPCbeQYpsYeWepRr63+9WvTtAbW7bX5ygcrVQB
 ZcBkjhYRq43qdcIoWUNdtbfjuHFQBXjKtXwCe3aBln+mrGC3lRjJTW/rowIPK56VecT+
 zXHppUzO4otNLO3FT74w8Q5hM7ZNgA3GhhfDfF0JDk9rZ2Lk9HwUuWfZy+jq6ZPdrOSf
 jwak7MT7LDx1HC9bZhM2OxKvmTylxUR5W2akm/HpmxYS7mynCnP5rxXpa7XD/gowZvKC
 G1Db7YI/yyLxmTsBrOOtjBZOA53rG4yxcf7ysvsqMl9rtLqzcB2YD2kHPIgYAtpm/RIn
 RH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662218; x=1784267018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xfihhQahT18tqw16GN07qOdNHK6O56x78Dza3ykZ+F8=;
 b=KS2gekigxTcPoc2ssc8xO55B32cCKh8l/CeSpikR28wZLhsdEBqixl/Sf15icYBdvo
 AI6YiYqJUI6zzAF6korm/YtaMIzYZCeN+C7RX1MYkc6OkZlwz34U71pSjyK/ZgLe45vJ
 h+TM8AqxM9j40Lz0ooBOK7SN5rsYSxRz4CqVgp7fEcTcCcbXpaJVKjSnx+53JP/ggzfc
 fRI3vyx5faYxRf7LcUnUije6ND+BsfWUMvP3btTWo5GsWV43+zn1FFl653NliyxudahF
 g5NUDC2GDJ/88ENyY8wn7igUVi7EoD/xfDUOfzPIUqRIupnCjGUH2PHB73bkqms2YRxS
 wVsA==
X-Gm-Message-State: AOJu0YzKJTyBp+WrKFc4hS2P0dRl4txyyNYHkJ182lcdPlGtAsSsx/ok
 0GaYz9n5HmItXSaefpTRKailSD5g4Z73936aKIwIKbhwsKSbLpOCvCyNsio7zK4sSuG+FlNwkaP
 5sSdBjCd+4+rmh/EzrtsxaSfLiMNthbs3E97PHUvB12r5OYDLVIklNlisMDN9NGguPw==
X-Gm-Gg: AfdE7cm1yV2RRXuDfPjDeTm7E3YTE6gZtjF1630lbtiKVwKZi/ijv6pz3wzBYnURMj0
 S3jCTWxjIO8RE/ZpLHi+pxkWYxDQOEeVGpGeG3Vf0kkIGrB2Ot56DmC0VV03EVz/0MGf9DRbes6
 7QxMf0vbY64YY2LKoJMRfJSz/A+4aYWdr+QY5Y1P6Nw3S2Bnaa5VbZzEPpbzp6mLh802xMVNnTr
 I8a+X8g2dEPuUQ2iGPSb9N83iFzHvm1sRgpvAEpvFXqS21vM7Sg6V0qULB3G2zkKJ8hZcXc9RY3
 M2Vto6+PTCelGs4CLr2Km4qvYJoSFeQ1pIsApu/kphQ93Q5EcxhZuwJiTZq66Gb8wQhBWmzSd0w
 fljNPXZGt2po+op4uZogkdk1v8cU/JKhUgrM82tsBQjkWwwDDv97JCGy0A9CPn8SptceR1isSOe
 WgIexPFes+OQIi7EcEfy1xlUoF9Pi5tUjqYuW5Yh3X9Q==
X-Received: by 2002:a17:902:d50e:b0:2cc:df15:91e2 with SMTP id
 d9443c01a7336-2ccff2e48eamr59417075ad.7.1783662218025; 
 Thu, 09 Jul 2026 22:43:38 -0700 (PDT)
X-Received: by 2002:a17:902:d50e:b0:2cc:df15:91e2 with SMTP id
 d9443c01a7336-2ccff2e48eamr59416795ad.7.1783662217240; 
 Thu, 09 Jul 2026 22:43:37 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm39112785c88.11.2026.07.09.22.43.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:43:36 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/10] docs/system/riscv: document initial virt RPMI support
Date: Fri, 10 Jul 2026 11:13:16 +0530
Message-ID: <10f13dfad6528556a3bb4aa077aca8c38e34bc24.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: brZgmet8YpLXKIibQQi0Lv2lpCVx-J6G
X-Proofpoint-ORIG-GUID: brZgmet8YpLXKIibQQi0Lv2lpCVx-J6G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX//7JbKWtsIJC
 3rZ7uQehNHnRAEhvAluizYFMLJGM23bdlBeWL4ZhMSkz/MaOKnaDk0MXfCB5toSM0gL31By01y5
 ewM7S60cCjnz/O2r5EFUoTGdRNFPGBc=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50868b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=V1jnuoLLAAAA:20
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=RyhCfiGMEKD-kOZgqhYA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX2Xpwg+iMm2Az
 huKE2hUU242VSItBdkOPttFs8dFBLG4kokt63eXuNawX+VJMLrKUYjfmd+cJv1yjxbyQ+Qwz7KW
 PWCsPmuu3yFukC70N01GWc2bopEa3BO4v1BLy66MwIXewjeOT4SkzIQV00aY1FLoOkEaGLAYyoy
 XYhN+2YyBp0V6roXlhh5njq07Wj9zg6WU+wf32jRD72QkztX4ulgUqtVnolV958sKKiIvqt4Tjq
 eSeZUF9qrYL2p7vpMSqZDptlDw+JhEp6qoioLHpzYmHD6XSnO7shNiLZ+jyF+ZM55Fc8jOQeK9q
 UnxotJKQentcU97UXP228XBgIgvKI8mKdr7QtTuqEkkRsFmY9HCv9JgJt8Kpl9f21l00JIhH0x4
 GKdzxFkC6pu4/8SS9YE6j7HFHNG21dmve79bdmpgKQktlZYgj5ui/zYqNGwWeMb+BBtcfoK//E/
 InEBVxmu6LWcyjGsNWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100052
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
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Document the opt-in virt RPMI transport and the initial HSM, system
reset, and system suspend service groups.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
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


