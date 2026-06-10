Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A79CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQhY-0007aC-29; Wed, 10 Jun 2026 17:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQh4-0007DI-F6
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:42:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgu-0003DF-0M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:42:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYUvs2569505
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZQSLigVw1Ag
 xmF2O8n6Lu9dqbN//eSwXfGSVsl6CqLs=; b=N6/mMn20LrcdWRlr+vsE/KVgeTv
 dl+vm4xD2/i6dnceHu3cJj91vNKbUCo0zHexGN6iABK35bSO3+6pqF8lC+Ta48KO
 a+2lOdvsTiv9zzpKKchSshxp3vVNn2GlMF0+Zxoexl8UTf+QG7cPKaBmkyqMMYpi
 g5xC4UTrrb+5UJS8ZEfb5Y75is/3cigUKFFYdh1K9jCCraQbzz5Qa5O2xSw51HUE
 gKY5gTotCB9guyps25wZQpPVO7O2mKc44QX7iDoKqlSJeVhq/qjt3f/IIGJC1ipj
 b5H6pjvUShzwvp2An5kBn6GH+HRSLC3lQmV4xAlrxGQZCDEnrrUCtXeLTHg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u0eps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:42:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517615db531so190047451cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781127737; x=1781732537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQSLigVw1AgxmF2O8n6Lu9dqbN//eSwXfGSVsl6CqLs=;
 b=Cz+vTZrAAl32ujouKxzE0mh8U6Cbj4jfCIapNYMPuc+adxG/BV0uq/2/2/3A+tUzXX
 qEICZlY/RBq2njmyTz6DjmL2kUt8r5HhnN4RfG/4I1Z+iZrnLVR9UacMQagOgupIbCRF
 6lqYfumtXt8EuVI5yv855C98ahOy18K4jWPHkrM4c80xXPhhRZYbtxqKrHFzRC14lnhg
 ppof/O5iIln6QxM9r3Hvxwm4XMnvSO+pS1pzKxy9tpNurenu7zCxseKXeUdcpMmraolT
 BafM16tVgR/wpjUZYBqUH6efDwdl8DNcSmun1M9fpPXGk+ABbz+e1sddQqe4ORhSrgFW
 ucbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127737; x=1781732537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZQSLigVw1AgxmF2O8n6Lu9dqbN//eSwXfGSVsl6CqLs=;
 b=PcPizFE7QZR5LbqF0q8BwsBhQwPX8PFmGu+vNtvbH7KzGu32Vl2MqvbLg0/FiIW+Tm
 FRUA5RiCa1Y625xy9AuY6SXkXMlEECsvl5VQMMPwfr8YVlZVN2IM4bOMJVcgMmt69kJu
 g0CcDFTZr3srDWkqGAzo5xlfytIctd+71WKigauTuFXxY2TjqPgxzd/NjIjv+ZZv5Dqv
 ct0glF9c534mognUTFpCul4TqDcKEGZWkfB8JcehszbIbFrldKZRYfxShjQAVTiZdDsx
 JAnMGGI9n7LGhwsNDnfCl0tXMXDtQxw/Ap7Aqb25NA1gM+K9MvWA0lzKwTDEzqX26EUB
 4e3A==
X-Gm-Message-State: AOJu0YziiSOFzoNSuL+ABM7Gd7LfXMQj12F1Q3kIec8WHYJSAcEnD5yy
 YFWStWoUWfiM5+I77ifmVeOFyP/UfvhP6o2SB+/TvHp3ncvPOP2c+Aq+5XK5Ye0sFRQbdSekFG8
 9VeP61ScLbfjuNllOfpn3bkS62fyhTkOQcdqAMdFrq4TCOcOByPDtEkZFkF6B45XohA==
X-Gm-Gg: Acq92OEg3g/k+DoYkqeSx4MqzVzb005rKCFmi/EJpBL3p/IuiEUdX+OL+oADLGHrZv1
 1l26vvvTrQcRL17SrJvTLLc75Z+GfKPZdwmAWa2JLYleZ53pURXPovrozk0mCrANzgiZ//TMk8y
 HWfTwWYFdAi7I15VXLpplTWPJod6d8cK7MlrWx5dmQDF8xeZKRqpfH2ZtzIKjSCYoX4h/JnBIix
 WuG+Wq6dOD0nmisOtELlWEADJyeSTuQQoY97QCdaJLX6WfLsX8ywfLHPF7fnMl/P8TcO0SKSw3i
 y8fdP7n0iM73Vb295VZCqZD+QAyCjfZ8wdsMm7yF0O1Xbw2co9pGHJRXOjIwFu26jRdjJF1elTr
 q7NeslajvRrxo1Yd+A6KYHgqipcJk1zGWd+pL4OVlRKqUQjX1RvvqCaeR9hea2bUQvjVkhw==
X-Received: by 2002:a05:622a:1a92:b0:517:6b57:8164 with SMTP id
 d75a77b69052e-517ee3d5dcamr394151cf.55.1781127736945; 
 Wed, 10 Jun 2026 14:42:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:517:6b57:8164 with SMTP id
 d75a77b69052e-517ee3d5dcamr393731cf.55.1781127736553; 
 Wed, 10 Jun 2026 14:42:16 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d777996csm20766280e0c.7.2026.06.10.14.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:42:15 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 7/7] docs: add riscv-server-ref.rst
Date: Wed, 10 Jun 2026 18:41:33 -0300
Message-ID: <20260610214133.1882563-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 06uw2f3_1tWVjUXz0EWwdyL-v0Q9UFgt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfX4xnhW+Ok3g6l
 bt9neInoUTbUFcm3n0ySUoypvABN4fs7Yh7bnrJVMa7JZKPqDzyY8aQnBssJ7aFC4hJXgQSrYEy
 V+8lW6OfbecvLZZvCiLu6m6d0/z8cLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfX859tlneaHJ7c
 REQsjraf1FZXq/kPa0B2VEmzSzIV+uaZJExOeiKPsjqdNd3MIdq0xQQQkdNuySIWqFpPgI6ywym
 JvLMu3L520v2oAxlZG5sGJPz4HezBBWVd+tEK2vt2u/aWHn76bBLplMkpwIwM2tl5y9KKPqudjm
 q3412LZrC3EWMVE3wl8rspuGdacPjrobGrduake86+K4e32N8CR+up1Kqno+9GH6q+w6k2Ni9vX
 Ca9k0hVqaJR58hf7ZYrOXJqDQtNcFTG1RrmZMmzPI4apNqUAwz9WxM+5t4SV9PuXl5B6T/0xoiv
 LploaE/J01bMZ9+VvhlafN1Wu1uOACgPA3Zo/ABdWjuQBj+n2OiZn6PRUNKstcbE9eDA3eL6moa
 XT1E6vp8I2mZ6W1DEx1t3vg0D2c3BqyyR21mdzvUFYNVU0Yn/Eg+Gp+7xacuNwtawfl28C7u+mV
 lpnS567H05h7hbqufbw==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a29da3a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8 a=vlmih187C6Ts2ntwv5oA:9
 a=dawVfQjAaf238kedN5IG:22 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-ORIG-GUID: 06uw2f3_1tWVjUXz0EWwdyL-v0Q9UFgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
 docs/system/riscv/riscv-server-ref.rst | 62 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst           |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
new file mode 100644
index 0000000000..0573b4e07c
--- /dev/null
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -0,0 +1,62 @@
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
+There are multiple ways of using this reference board.  The spec compliant way
+is using an EDK2 image and a TPM device.  The board was tested with the TPM
+device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
+to use this device can be found in `tpm`_.
+
+To use this board coupled with the tpm-tis device, first start the ``swtpm``
+process in a shell (the ``log`` parameter is optional):
+
+.. code-block:: bash
+
+    $ mkdir /tmp/mytpm1
+    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
+            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
+            --tpm2 \
+            --log level=20
+
+And then start QEMU with:
+
+.. code-block:: bash
+
+ qemu-system-riscv64 -M riscv-server-ref \
+     -bios fw_dynamic.bin \
+     -kernel EDK2.fd \
+     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
+     -device ahci,id=ahci \
+     -device ide-hd,drive=hd0,bus=ahci.0 \
+     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+     -tpmdev emulator,id=tpm0,chardev=chrtpm \
+     -device tpm-tis-device,tpmdev=tpm0 \
+     -nographic
+
+
+.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
+.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
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


