Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC01C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7G9z-0002es-Nn; Thu, 17 Sep 2026 13:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9x-0002aL-3B
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x7G9u-0001cz-PE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 13:44:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5eM62413176
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5eqYTfBKOir
 TS9eXS4TiUYrdpCM/GvUswkHwyrvqV4k=; b=B9KJMARl6igARaBlYVLdMoXhr6W
 2mNKzYmiH4GAuOc+yDx2usJh2EhTb2+yn7LxBOkWRzPpekSWhE8gWNqUHZMVAjk/
 zULZOcXZpASL14jdDocVdsuTUn9Q25BzEGx6MWr6CfJ21qCWUMLd3lR4TYm/qg90
 9HYttGlghRnSXiUx88DYJSGbG6XIATO7zU0leXVNBRd6K1nVe9Ry2vu+knIibJ5A
 JiRPUSw2lP49vlp/6+1sEGzknMATJmoEtQ0WvT7tsI8/1K745dmanqyBSTf+Atnt
 2R18tYgnKn8ainZAuq6CQtixBBRXbHkJBjPUid8w4UtmFWdCmM6a0HjwShw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grgu5hckr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:44:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9104ba8bf51so30214986d6.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789667066; x=1790271866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5eqYTfBKOirTS9eXS4TiUYrdpCM/GvUswkHwyrvqV4k=;
 b=b9hzT0GMvtjL1PQSD8uWRCTdf90l94GvjUptL4SzQtL990uUuo4vwzH4dq1G2+8y9X
 iY76CSAFJST+oy9Oo0cWg4F1RlonDGDpC8eMFpCw5PU7f6tiosJKUOzWztFzxDmhLDzR
 Js1jf9LtOwFhXQoSiH4CxKruy3Gxe9bifr+PGNbJZQCloBe48dyGsyQUu/KoLYEYgevS
 1wR2hy6kBQvqI02HVIvWly2KpL7H/i+vCgJxPATIqoTa//nD4lDi31sODmzE3CPQi+ma
 qW8LHRFaleaFP7it+UepX56IYBH+Kah7Os2YNMpopN3dbO5yWjgHIyvs5EXLzRjntmpH
 YHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789667066; x=1790271866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5eqYTfBKOirTS9eXS4TiUYrdpCM/GvUswkHwyrvqV4k=;
 b=ixyLQVYARFInisMPHe/gQ9O3ZxsoNbuV7ngRI03HottUfIDrlzT67XFw5J990+WnOl
 pNFZvXEKxTfLhglnAq0M2BRT1v0iPK+Qv+FYuwwDfvaweVr2SXTjyMMco02GIuTWKQjH
 zmGtsKb3Z/ydoPxQL7q/eOkJ37bqOi0zYE4QLncSoRtGoX6v3njKGbZe+U14MyUEW2X4
 55AiI4te1qOOsjU+4F5TRY3UI7yRGdfiZvhtkUpJ1wt6qdIO13bNCEY/KbY6A+0SaYNt
 jUVONTfNlVF5rtpVCbEDPHANxcL3nxtf8i/D15YjcAbf+R8y+YHxV7QomzE2J5V4W3tc
 HBbg==
X-Gm-Message-State: AFuF++nFVaXKfGav+QPzyRh4oGBmGVYO4aVp9VAd6MtkfgzHgQ0exFeX
 JCPm5sUeMjR05HGHRQH7NBrJbw9+JUB+OMKL8eKsuDMh6nnE6XPO7XgRhb3OxYnc4ukTxYkSi+Q
 foUYI9e+5bORq5afBVwRtco1RyT7DL83oV1wIO+smgjjBT2mCzxQoKIaJ1Vixawu3yw==
X-Gm-Gg: AYBFou03LbzK915bWsTxSF5QMYdAV7LHqkhDuO3dZ2rQpRyPAHKEocHZuI0kuEeOfpO
 7EWB2BZjzx7HXAtUECzXYQcdmLbqUluL8Q/17uaWv+binYT088mmL2CXgE7xOeM1kCyDLZildxF
 u2QWQ96iBPkZpgAh+DA661dDkoXAThoaWWQD3X3RQQ0kTYVMA1z/twZIOqYbTA1OaKxlWWVI6WF
 OYxZfQaUSkE2nmYZa1GEfbDMCwxhNed6OZzkNzT3bC69tjyk0lTPTB+I/xvb0hSURn1qFHdq4u2
 WF3VjHeD/7+D+EAm0U8mx5YMjJoGbfVMa4PU38KlnDIVKLlyHyJFbw8MyxepAz4gb3T4Jt4FYZK
 7ipLIQDKV81/NbpB+EMPUuSipSW3mYZAWloXONa8=
X-Received: by 2002:a05:6214:1249:b0:912:517b:847 with SMTP id
 6a1803df08f44-912517b0b18mr27603326d6.43.1789667066045; 
 Thu, 17 Sep 2026 10:44:26 -0700 (PDT)
X-Received: by 2002:a05:6214:1249:b0:912:517b:847 with SMTP id
 6a1803df08f44-912517b0b18mr27602696d6.43.1789667065497; 
 Thu, 17 Sep 2026 10:44:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252c56d73sm3118136d6.13.2026.09.17.10.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:44:24 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v12 5/5] docs: add riscv-server-ref.rst
Date: Thu, 17 Sep 2026 14:44:04 -0300
Message-ID: <20260917174405.3471736-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
References: <20260917174405.3471736-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfX6fpsV1bWjYiX
 mm6BI+NWCPC10HwtGdQDckFEquftwdtjaSjdgI0kP7PEDPpo19YJimFMXWQFP0CP2PzQivBUmna
 zgo8Eb3hY+n7KLB7Z59cvfHDXpRJ99g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MyBTYWx0ZWRfX/tckxxNeUKUV
 VAbT+629mEhIwn6fWXfWz4+BKv6zqLyb83eKvi1bk0o3USNrvlJdBPhVlUuHTCevFz9VW87v1pz
 teXBZl6oz5cuLB+iEv6nSjJoFM4lFD1tBpllc4qm0/MmCb6k+MIpX46xdjn+Dk3IAmBdkyjIpV3
 wN7Ce8axrxOcoWPXABalsXCFFpJz4ofxRu2crNjUVuJ/h7Rl8rdrp3JDR5LTERrv4RwPA5CErsB
 5z1ckUL+zXxiDNBLK9Dg4YlDGeIbPjc2MuGIJ644lDs19agPvXS+P0dDsfMJaSBtOiMFflODEIz
 AddEsl2a9oHXChR38bzbul8Y0L9rklD0nLtTqvB/xciP8fxtOOcDSZC0Aiq05MxA/rc1BZ3kJP7
 pGgIq98t9YUfSRtPXfGhR2+G+TtEkHDtJRPeClrZGf3HWQpzf5K2g6qlJAX8TYYxvuu4Epa0BN0
 aNgM/PIpc9MPhYBi/qw==
X-Proofpoint-GUID: oGQOvsDNw-7on7F4mlZLx7JRvcreMxH6
X-Authority-Analysis: v=2.4 cv=GvbXaU1C c=1 sm=1 tr=0 ts=6aac26fd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8
 a=vlmih187C6Ts2ntwv5oA:9 a=pJ04lnu7RYOZP9TFuWaZ:22 a=F9tHCgz3TLBaZgltkx5D:22
 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: oGQOvsDNw-7on7F4mlZLx7JRvcreMxH6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170253
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 docs/system/riscv/riscv-server-ref.rst | 64 ++++++++++++++++++++++++++
 docs/system/target-riscv.rst           |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 docs/system/riscv/riscv-server-ref.rst

diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
new file mode 100644
index 0000000000..5b23122f19
--- /dev/null
+++ b/docs/system/riscv/riscv-server-ref.rst
@@ -0,0 +1,64 @@
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
+`spec`_ is version 1.0 at the introduction of this board.  For each new
+supported spec version a new versioned board will be added, keeping
+"riscv-server-ref" as an alias for the newest version supported.  E.g.
+for spec version 2.0:
+
+* riscv-server-ref-1.0 - board that complies with spec version 1.0
+* riscv-server-ref-2.0 - board that complies with spec version 2.0
+* riscv-server-ref - alias for riscv-server-ref-2.0
+
+The main features included in the riscv-server-ref board are:
+
+* IOMMU platform device (riscv-iommu-sys)
+* AIA
+* No AHCI (can be added via command line)
+* No NIC (can be added via command line)
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
+     -device nvme,drive=hd0,serial=ddaaddaa \
+     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
+     -tpmdev emulator,id=tpm0,chardev=chrtpm \
+     -device tpm-tis-device,tpmdev=tpm0 \
+     -nographic
+
+
+.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
+.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 2639866a3e..74e23fa64c 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -70,6 +70,7 @@ undocumented; you can get a complete list by running
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/mips
+   riscv/riscv-server-ref
    riscv/shakti-c
    riscv/sifive_u
    riscv/tt_atlantis
-- 
2.43.0


