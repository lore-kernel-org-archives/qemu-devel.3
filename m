Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83579FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGLwS-00065N-KU; Fri, 24 Apr 2026 15:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwM-00063e-1n
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wGLwI-0004NN-Gb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:11:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OIf1Rf1858797
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RWtTeeX80M7
 UyjtsWtjdLoF0L/y79rbrHQrXJNxvvTc=; b=bsQOzcaPiz2lYFmNKy28XU+Wraz
 0H0O5QAB+FTC1cUlD6QssW12A15/++1dB5qeAGhCAPza6rXzyb+Jj51sCLFKDtVm
 n3nvBvA8s1mzA8jOMnsKaVIkKrA7cYwV+YVLG1z8FBaZ9Aoah1wq841ohneE1rck
 TcgvufSDycA1E8NbsuwYczXAcT+gGXOAZeyM0NoVMphY9ttgvLmR2hcymw/c+UU7
 1CP1NtuFnPi2AFkvXdwwvu0KLdlTfb37FUZdTdn4J/4e1yqBeLSj6rXsPUCAnD5m
 4hNvnY40/d7/iRO/vDJm+iqIvrqZhWiSCT6qv9sPrvoZby5VGojWt1D64Zw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dre0wg30r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 19:11:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d4c2906fdfso856210985a.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777057905; x=1777662705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWtTeeX80M7UyjtsWtjdLoF0L/y79rbrHQrXJNxvvTc=;
 b=TfSXg5mShd/oxEHEjpDaF3kQE8RBB0mfiNh7Eelr52cdPh4CtVpb2s0jGh8++4RNA9
 2I1w7xGGNie04oqJ7hA+JkbFkzbsY/TytrYbtErcPP5KmSmL9LSkGuPudOHwupCD88Yi
 YIfYfetaQlxGV89W8rsaS8GiIIugiQ2rdczmctnCffK9EWGq4m5ArCCqc4IDUIxVX5g4
 14Kz87fN4W4g8MU6JfjVRBCl9CD1m10pu5rAxTX/8kWBVo6wc30tZOycvDCh/x/+Qo6U
 MI7daX9cW5+bHLAxXlSqg3AjGsmQxyT0ols/04gUx7KidFMx9IBQZHYNJc+12dOgYioI
 UxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777057905; x=1777662705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RWtTeeX80M7UyjtsWtjdLoF0L/y79rbrHQrXJNxvvTc=;
 b=RskW6kqAJkTUh78GBIIkg7r+C/vnqBD4LeuolVmCSxwJrw+sj8aKjlSv+sg0ax4bHy
 aLOGx+hb3RshmCDjaX0SDGe9uHOohPXv6zDith9QAJH8uVT/qz6Y1pa2rO4o1f1PT/ox
 Jx4YByEgWm6VQXAHeaC9B7zXllMFoCNe8+otkGuTztk+cp5NAVvdOr14+xuVhRa2fWy+
 4FaXMhfSmPSjLxp1ZKLDkaBbQo8iQ8dsW6AcwxiuLrHj6LMMX436ON2vy8UZROq/YP5A
 RBpQyNavZbG8U1+Y/lum2pX3BIfwW9J6p/ug+y322R+zT1aUIH3V3LHbbrwc0sfDfGwn
 +Jug==
X-Gm-Message-State: AOJu0YxwaZvp6WiEIpAXl/J0xxqyBR4FVvLgTPLS81JXWPzoqokdABnx
 nMi0ksIQbMEVgpzz5FmNnn8K3QlZTXjL3VCqwUzyivjoFUPAKCO36c58D6wEPxuSKauWBEtlgIA
 jhL/yDsr/BtJBLv3arf3p87kmLBwsAvjNEq48ACK/moqhJGvHlKzinR310fziSojeAA==
X-Gm-Gg: AeBDietmTtVLvHYpi/tD+RKOweZhTnbZWDqXpRrROerfCBJKuecWg7TOCsE1bAsls4e
 cRa1Q62UQy0r3U++gNenB8iqpIYJ8vMctwwe+GQ0gZN8br740WZKQhIn5/Fr7VIUi2XhsqKzgVi
 lSCtJrnwLSpJZS8SEKLL1rJNWbrcNcAYw/MPVycvdPeB5VfKGaKZD8QZvDI6mPr9w0iOAQTo8h6
 1I8glnozWW/rPdqAgwnyLNGLPAXmYhinubtCRNSKtK0y2ct6RJ4X4G0uuB8XOmNWvuErzFsKRO4
 hqD4ZhH605r2MWViZBzQ9AqPYailNvnx3f2eAMmrt7HcGjJkex16AeSoZ9D75nlAIfp7XzghG+X
 GDh3WbwqUUXqOJZME4AI51B2DiMKMEH2h4DpM/36Vo6YJdOxkn7+42y4vVdKqdjIP0DWZ9+c=
X-Received: by 2002:a05:620a:4694:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-8f15e900620mr1115358685a.26.1777057904681; 
 Fri, 24 Apr 2026 12:11:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4694:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-8f15e900620mr1115353085a.26.1777057904144; 
 Fri, 24 Apr 2026 12:11:44 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe90afsm2319567085a.3.2026.04.24.12.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 12:11:43 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v5 4/4] docs: add riscv-server-ref.rst
Date: Fri, 24 Apr 2026 16:11:29 -0300
Message-ID: <20260424191129.1494381-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
References: <20260424191129.1494381-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H+frBeYi c=1 sm=1 tr=0 ts=69ebc071 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=bmbEedN3N7VIJUCuTIwA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: SVZBbzIad0d7rST_bXBNrTSMBwFc8WzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4NiBTYWx0ZWRfX3QOE9V+Qm4uC
 Xx7xfAIfQl5AVpDmGtjpIRX9bthSwrfNdMSoRmfldqsQCz8siLzPDFI8Z4gt01xdMcZYz2s71dc
 nLvIcpfRTgoH632jZqc3QtcpwRzDFAQHbtadEMbwe/ZRMN9XkyhLMxlMLAzkGYu8h9IFCY2RsQr
 QOjSuPgVXLDWuLI9pG/SIB8RXMnD0GIjA93oxggyvytCeRd0eXeb5gCmISTHrqnh8BSkoTNscWj
 6ZaL/LtZz31AdzU0Fj4SqdltXO45ktbhnw6ymDKZN/as7OhE6u731UfvcQUih9KBH/vH+kU9/h0
 6D6jVKHscsZ1O47gip7G5jOdgfQuumw7JlkAeKcJ9PIYduU6a/1dAlxObfIaMusaXewNQPTGyEC
 4tGusZVz5o46/cMN9NlXOrrc1fYNuMerphD8QJGc41xvl7yDTkZjEltkLk0w8CQg7nzAQ2sN6XL
 +FEDdDGhJAduHuceRbQ==
X-Proofpoint-GUID: SVZBbzIad0d7rST_bXBNrTSMBwFc8WzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240186
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add documentation for the new riscv-server-ref board.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 docs/system/riscv/riscv-server-ref.rst | 31 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst           |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
new file mode 100644
index 0000000000..acf7110b96
--- /dev/null
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -0,0 +1,31 @@
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


