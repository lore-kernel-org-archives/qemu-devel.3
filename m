Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcxh-00063B-2f; Thu, 14 May 2026 16:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxZ-00060l-BL
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:47:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxX-0000tM-Nm
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:47:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpffm3200389
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8Ma8FLyJv2g
 fFihjhwuE3uS0L+mHITodNY35IDXdFKc=; b=MMz5sB2/EK/h2aBVr7cd/6pBxdD
 ce5lEsqo9lzMn9b67oT1pjFn+CS0cOBUAwVwgNTEEdtN/aux5M56kkrm8KXkDICu
 J20NdWUNPhMZyCvxWjNQKC48c0GOxpSaEzuw+qSdKirweE41fAwlnbjUEoDxgRKv
 7YkdUB2pMZU+a/3GR0bORZjmYKsxOxI2Awji/e6+CaqQuhpV1Lr1afDKKNNPL7U1
 EZvETH3t01C/T15JxS2q3dohQe8EyvQ4pgSmanutLOkoX9LsodfIb0X/sMAw9vIM
 T2b2DnC5GO5loQWtuGEeT5i5w9uFmcst8EGgXfhxvKYl62H/X5E4G+G8LCg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qrbjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:47:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90d2d8dc97bso698816385a.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778791625; x=1779396425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ma8FLyJv2gfFihjhwuE3uS0L+mHITodNY35IDXdFKc=;
 b=b2i45LgQmJKWdkyJaJ7BorW5dKTmYS/MWRrG4drKT86obb1WawwOeH0pqbB5vy5C7o
 R/b2BKEoCvodAsQwqbIhXQRZtiYFodqe+7X1QV/mZ+Idj/cpPYhth1pwmTa8ovPEFDTz
 0Y9BARlZGom3bQNSrvFHKNOmn00HdN9srdBIdcqAmhpfWcTBGoSUCOndOHzGNEiK8ir1
 ok1HUaWXGm2Ut+RU4r032gS1LLyTn173/lv66180+qP9lfsWu+Hjk1q2FrePKKki87RA
 8qRNpggz/BYUJThh0DBQQGxj+pkgnDA60VmgMwnkik3TeBuWKLNWcihNIdFbP9WCr7jF
 QAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778791625; x=1779396425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Ma8FLyJv2gfFihjhwuE3uS0L+mHITodNY35IDXdFKc=;
 b=bB+3rtvNwO6o5qLI0GpG98tqLNIKgbZzodANUk1JRroSS5Yb2oscB1P1toh474fqkE
 MJ2roa3MHJaVY53QkiTyqJGSTDMUAYiJA/JSM8tdw5j8eFcegBMwKKRIH1W/EDfpnKfC
 /o5EyHQR7VZ7ohtvR+Rx0TMkWBlCkd7vQczqtRzMKAKoaPkD5TSJYkifPGnwfV69+70T
 4ZS0LcijuBIo0Q4Lmsox4rWT/bsevxR61xuHRot7JjxNXtM1cBwpY1N2JXGVu6GVT9cv
 c1+HLmdoULv9ge7KTSlYqkrNc7PmMMNGydMOdh4tyqxO7o085wGxoCVznAO5lhOY/Kro
 qF8g==
X-Gm-Message-State: AOJu0Ywa+glzsd3Mi1/L2R2CDnhs6oZV7kDyN6mJe9P3/QOMmGzA/UFS
 Oy9VmHCvDfi6nma4UTXXSBfKwe32YLIukyrKGDx/bas2bowF8ZNVe5PTlzebwpBYDU4JYgc1bFr
 Dbx7hCVhTdt8+Y+olEqmlRnwWDvc2nSreolexgibwQAyh0gkIKuGzm1wzRRUxVcdnMg==
X-Gm-Gg: Acq92OHUEoGcSHd9IywHbn694/62gg3M9Y4RZetK1AU6TYAe/Ogeu1kRMkn1GaAeEWt
 9actcgzkFdQWdmv+a+ieZY8V15QKg/KKjLw8Ry4k4eXvO8nbyZK36xi4ML7jq/Cci6DiTecLrPq
 SDmxa79Uzbag8v5WIFrVkswG/pSq1fFatm/6QFkrNvauujVyv+APEbSkKoTV+E9WPiofgqrbe+G
 JPOClD2rcLOdyv8n48U2EeuoOlcvq2ZdP3zyZ3r2/ohQxHxLUhPrENtCMN8Z9Z03xgHScx/4nr2
 k/aaqBNGUb8jJuwd1CvRtce1TqqPhHhBQhh+9uW3TIm40gzdqtG3lbTBnuyUm2cSMr2ZGauoKYX
 CZL8HkHdtHWoFe0UvGD7RGL4kmumoEKdWaamN8tXV4LVpbh6Bvqf84r2WtXM7
X-Received: by 2002:a05:620a:4042:b0:8ee:30e:cb97 with SMTP id
 af79cd13be357-911cd75d3dbmr222745585a.21.1778791625061; 
 Thu, 14 May 2026 13:47:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:8ee:30e:cb97 with SMTP id
 af79cd13be357-911cd75d3dbmr222738285a.21.1778791624529; 
 Thu, 14 May 2026 13:47:04 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bad2dd8esm343022885a.19.2026.05.14.13.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 13:47:04 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v6 4/4] docs: add riscv-server-ref.rst
Date: Thu, 14 May 2026 17:46:40 -0300
Message-ID: <20260514204640.2540054-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbkkiCE8 c=1 sm=1 tr=0 ts=6a0634ca cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=bmbEedN3N7VIJUCuTIwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: oeehHReIhU9iV-7Q2_46IywZ0jmYQhZJ
X-Proofpoint-ORIG-GUID: oeehHReIhU9iV-7Q2_46IywZ0jmYQhZJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIwNiBTYWx0ZWRfX3XLKImp/ljPx
 NhcQii8U6wK7e5VgcBcDn/ioMAICuhStOUay5Kp2z9YqpQQjfdhC1yDWkzSqLm0mJP51zCMAzrN
 7aHFIydO0TPnuxXe3oLpSwUblFEpGjLpQ+7nn7ZDuleAUapUT1c2wlM1//rghvUcPYY/sLmOphf
 BKvPYZAJQoddKuYWu1hyf2ofRNxZOV5G9pJwD4woRXx45K2SDj09FRHLNTDk4RQGhVjAiUrCGfx
 Hf6hunIlWhWsFzHanvBuFVA23l8la4IFJVE0ZxFTl7L/xA+cPlA5Yu9CGf9Ql9fKTzPJHtE5XZC
 R9gmkveen81npxUCCATz16Dq32z7yJb+jdIl/xEBa2RzSFvt/IEy8PUQu2wQFNoe90er6fd2ZdO
 Io9mwJEOHeH+x/4fd69ozdOjlksPREOo3GAcPuweGgtc0tvd0sZvqO3pDmzLv7Y8XxwTrkAsvXS
 7CqbLUqZsROPYyxCsSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140206
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Add documentation for the new riscv-server-ref board.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/system/riscv/riscv-server-ref.rst | 37 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst           |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
new file mode 100644
index 0000000000..7803133b77
--- /dev/null
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+RISC-V Server Platform Reference board (``riscv-server-ref``)
+=============================================================
+
+The RISC-V Server Platform specification `spec`_ defines a standardized
+set of hardware and software capabilities that portable system software,
+such as OS and hypervisors, can rely on being present in a RISC-V server
+platform.  This machine aims to emulate this specification, providing
+an environment for firmware/OS development and testing.
+
+`spec`_ is version 1.0 at the introduction of this board.  New spec versions
+might trigger a revision of the emulation itself, which will strive to always
+match the latest version available.  In case the emulation changes aren't
+backwards compatible we'll introduce a versioning scheme, probably via
+a machine property, to allow older SW to run with older spec versions.
+
+The main features included in the riscv-server-ref board are:
+
+* IOMMU platform device (riscv-iommu-sys)
+* AIA
+* PCIe AHCI
+* PCIe NIC
+* No virtio mmio bus
+* No fw_cfg device
+* No ACPI table
+* Minimal device tree nodes
+
+There are multiple ways of using this reference board, some of them being:
+
+* BIOS: u-boot-spl.bin; SD-CARD: <disk_containing_FIT>; NVME: <distro_disk>
+* BIOS: fw_dynamic.bin; KERNEL: u-boot.bin; NVME: <distro_disk>
+* BIOS: fw_dynamic.bin; KERNEL: EDK2.fd; NVME: <distro_disk>
+* BIOS: fw_dynamic.bin; KERNEL: <linux_image>; INITRD: <busybox_initrd>
+
+
+.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..3f7690331b 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -73,6 +73,7 @@ undocumented; you can get a complete list by running
    riscv/sifive_u
    riscv/virt
    riscv/xiangshan-kunminghu
+   riscv/riscv-server-ref
 
 RISC-V CPU firmware
 -------------------
-- 
2.43.0


