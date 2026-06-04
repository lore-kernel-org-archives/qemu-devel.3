Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD63BCD6E68
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4lV-0005YS-Ux; Thu, 04 Jun 2026 05:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4lP-0005WF-4S
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV4lM-0003lV-OV
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:53:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6546c7U43241141
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 09:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kdUL16Bl9Es
 rcnZahIysFeQV2Fl79lBtFPC2hJwXPYY=; b=GqT2+SEu8949aFQCgzzahdn/WsB
 ehWGYGk3Tq6Usvhgb4WERRjEF2Aoe3s8GVNKPPtjnkzf516AxTYC67unPar8Ujmr
 9Zm14Igj3iERXnr8vcZU5f2Oz3z69uDY3bcIhqBWLRyWd5lG7DJf5KbnQcDaG/oC
 VKpPFxkxQAyMIXD9NDoscspCmguQHjZCr/hqlIC1ISUYDnLIxmE9qVkC0FLOYYP5
 bRAOu7cQ4hPpuH6pvO+LBApUPAhhqEfGnWFC7U0DwK/ADlvyU1HGu1Kua8+omkFi
 hRzmMG7IuExWBYKTAbl+z5sitsca0Ae06dzr0QCGEjkwUAICa5WB9E2WEuw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd0a9u9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 09:53:17 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-660d7828a5bso914267d50.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780566797; x=1781171597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdUL16Bl9EsrcnZahIysFeQV2Fl79lBtFPC2hJwXPYY=;
 b=jIXTzwwyzSpjkSwak2f4Wfjn6aKBh+8/b/mqjPwWjUT3U+/kEGiginjwnFyQJvWufB
 MQoSE2/buu6hAO9YWyS/n5ZVnOQ7DjghZfkz6HFphf9m96oxmVd8G6mIBj1OD4EwI4Hu
 qgHqU2yJ51vGP8Fc6LhYq3v7WBIH9+DHMDs/xhSraWIjAlJfMk1mxos7K48ncsOotNai
 XnTOEdYpitgDbTM2Sy8M9kiP/JXXJnxkCIIDeB6zAyArXJ6p7zahN2bS9fyKI9t4G+Hu
 bySEfeh3fWH13vaH0Yiy5Qhdb+1xL1h3gI35q7pGoc12nhLPDQnvCdhUj1p3ZohAgf4r
 77QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780566797; x=1781171597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kdUL16Bl9EsrcnZahIysFeQV2Fl79lBtFPC2hJwXPYY=;
 b=ocSZr6nCiBE2v+yLaHkqERaAb8LeNoZ1E6ISeyyMP/6w6wTYVF7Tc3Q29CYYigB9vq
 myT5s5lL0FXN6zgK4T9sD3ezJkuH+xH26HmWZ20x1qZ4BKRQKATYC70bRjH+SMzS8tvE
 Ep6uvYew/LmKOWzjRXZZXLvkWQaM0okrqYXifRMiZp8uUyrnT5qcpQ7cg4cyj26Ju6K7
 DDKdz0zQQh0MLZLbH8dxtHZX34jpbwwVIA2XlgShjSDZvmEGTru0i0f81pagQZ/3eLe+
 74PGNhsXY42rS0s6Keeu/q9ckS/cEHpZ6Rh1tKgySWNa6PNfvEkJA6fA3/6j4HEM3mDz
 eExg==
X-Gm-Message-State: AOJu0YwSu2DjfJOBxCwF73izcIUkhS1y9wvbDjlzG05oS8xlUw7C0m7J
 CKsQ1VsvuavAPnleh6vBcRBY+lPCgj1pGXZbcK/R3puw0ugda3fg1H6rYMNJwCH4Sqv81ZrF99d
 ApGmaZBBJEAX3wH9HmX2o24MWpnvYdWFCSg7FmJxhoaMFS8e4sPPcD05OQVQbFDZQgA==
X-Gm-Gg: Acq92OHWwWFlD7va8vJhG/KsUAEIvpDzwE/RSpshhG+sh6dMQegmXWVSARlk37FBoUj
 NuCXNLrDuIh42/E3qFBtuatPhUY0bGC3N6lWtakcgEnhvLOvon8GWHwHxTVvZquFJvdYKQhDVw1
 iloQoBCt99qkGrNKPfdVq/Ey9lFJKrCi3WX4fMM2DPBMY7oeP9i8uKu/EkTmyibdj5GZZropV7t
 bfXk/ET03hEf8y3Ub+am6ZK6xaSJF7TRZo6zgG6kIZHPkPB2nDX46NKWw1IhjwtunZUIkYY67Ft
 D6MjwJBpGkRm02+LYI6lNJy8/fQXW0IwLDFQU8siAiFEw6L+ANWl5faa2We5Jspjw0m9n9NtPxu
 GaybKPj/Jq9AubBZ2sdQf5my5uFRaalJt8Zk7SfpoD66E6mH36lo2FMjzyhh+tFg8NU+j+Q==
X-Received: by 2002:a05:690e:1286:b0:660:7bcb:7aae with SMTP id
 956f58d0204a3-660f125eaf7mr2342241d50.44.1780566797298; 
 Thu, 04 Jun 2026 02:53:17 -0700 (PDT)
X-Received: by 2002:a05:690e:1286:b0:660:7bcb:7aae with SMTP id
 956f58d0204a3-660f125eaf7mr2342223d50.44.1780566796885; 
 Thu, 04 Jun 2026 02:53:16 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d64ba680sm3522830d50.21.2026.06.04.02.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:53:16 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v7 5/5] docs: add riscv-server-ref.rst
Date: Thu,  4 Jun 2026 06:52:44 -0300
Message-ID: <20260604095244.3313259-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ey3NvM2M5mVWlYypAXUNN3IrzgxoAMww
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a214b0d cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=6mToRrmzC69ltaW8jJwA:9 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-ORIG-GUID: ey3NvM2M5mVWlYypAXUNN3IrzgxoAMww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NSBTYWx0ZWRfX4cIEiiPnb04i
 yxko4eVTuZTwp+nM1rvUq012GN+OgJ08TbLJygCY9QQkN+0aJny4or+ry1eHkCR+mQG1O32Qg0A
 7js/ZfQ/6BQPWtFo1rGwyK6M/F5RLd0ObA1oPk6kmndrGrIhecDvCpYrF+lj5+upJM5KxKLS77d
 p01opJDet71RJ5ZxFiB70K8XUJf4fKihQ8EelS+XHl8SloIFr4PWojYnR35OX+4VIen6PDkTcLH
 MoBU4kMryhdqaxg8395LmVBZx3IoXq1siYtrCHS12Rj29m9rOon/MgK+GgSGP7YKctLst8lv8j3
 mV4GFoYpj4jjZG8T5S5ZKk++Wm8Rn71mESYmnJiBxn/LCQBrAhvva7iyRghV6aN14fJUJu6kply
 qVVhCZvVBtY/rAMlRaz1q/+uDj03lEQOZw1pnZTNIPW5VM5kAbERJZfxSa2exDt6Pt/QNSxJwTd
 8VJ8qdZKFr8IxaxeyBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040095
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 docs/system/riscv/riscv-server-ref.rst | 52 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst           |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
new file mode 100644
index 0000000000..379b7ef76e
--- /dev/null
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -0,0 +1,52 @@
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
+Here's an usage example with a recent (June 2026) ``Image`` and ``rootfs.ext2``
+files from buildroot:
+
+.. code-block:: bash
+
+ qemu-system-riscv64 -M riscv-server-ref \
+     -kernel ./buildroot/Image -append "rw rootwait root=/dev/vda" \
+     -drive file=./buildroot/rootfs.ext2,format=raw,id=hd0,if=virtio \
+     -nographic
+
+The images QEMU is using for selftests of the riscv-server-ref machine can
+be found below:
+
+https://github.com/danielhb/qemu-machine-boot/tree/master/riscv/images/virt64/buildroot
+
+
+.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index afd86ca2ba..b2aeb39a8e 100644
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


