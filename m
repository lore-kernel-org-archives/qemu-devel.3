Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C1EF417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbui-0000rw-5Q; Mon, 09 Mar 2026 10:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuM-0000p5-Mn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuK-0005D9-7r
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:48:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629A6dMd2195107
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MuGnrP8EVjacDVNLhKUuNxaOEQoX7mtfG/xT9bAttGw=; b=QMySoU81wPtOTTjg
 sZbFVyM12fAw7W8VpIPJqe+CKQKc87IIQLLShM7Tn398WlxwLHv40qT9wVhjISC7
 PkHIC79eS5ejYdMsxeRD60KKh2rqhia0wk9u4947+IXnQ+Qlfs8zH7hRIeeGK4iE
 1Cn4EWtbfnpHCgMkay8baMBTaR2x7IeVzwgQK8Q52/6N1godcMRNEvQG+4FeZP9k
 4+QsEvI7hIVZRave83Jryw0HHKCxb0u9Nj+lky8KMJgAZ6vWpVm/h5+WZIZw5WbX
 x4LrLgfdVfwfzo8WA40hKm8tZHydCIorm/AnyNrhW73XoqeDAkw8aBVOy0BkPwrd
 ZmCuTw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u8vjf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2be21146933so10001655eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067709; x=1773672509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuGnrP8EVjacDVNLhKUuNxaOEQoX7mtfG/xT9bAttGw=;
 b=K1Hti3/DD0Y4qVusSpEFjuYZxY2v0wg6aJRecZ5lsFSS//+iSQZ67meU4y2jOzacCw
 6q0ad+onRf8inGM8z036GKRbHAAwnOGojS5l0UcawEeTICsy6y5rcL0l0MnShz+5Igd0
 0aGWhV75/g3ZuANLvddnwNcDXWPJzLa76r8ecIEeQ5x+twhlgtmk/vNkXtuoHeIrFjFZ
 7BaGUD90eD+EztrC0JsaA0XM1cqzdnDbMttVIFCHw3KJVw6gUSNmVWN1d1qVWskIFiUi
 R9jU17RMdaD7H0YrJNVkWPDDcZl+k0mBf/bt8sVtCx4B2QiWBooydK6/vt0RTEgjKRPw
 doNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067709; x=1773672509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MuGnrP8EVjacDVNLhKUuNxaOEQoX7mtfG/xT9bAttGw=;
 b=boTYPgLiAek9KyiNBoF36+MGZjRP8YAYedS+QYjgG+BeULAdWrbueN0Tf6tPtQYh7Q
 I7Y6n+QKI9p/d+gwgch6LQqK3x6c/vVZCP2xnL8zrqqS16d53B7asJtb9ZKno2THAy9v
 VOuVMyAiZF85IF3cFnkiSBU57BHOIuwHoArPuQcv6Cg/DHk6yfrvXKxXtQvDZMiqyWxu
 807+Sf5dgwGkf5tbjxTmzJ2BPh/+BCwwPJL1u4xGHdK/rabVltLh+MSS34LH3g9AcZk+
 Ah0QO/6+/Kcs04bc9mkTb4pSLAo5cz0i5uhyMKW5aV3Fm+dcvxY4kafsUdTv5A5d0TLl
 kdDQ==
X-Gm-Message-State: AOJu0YwdDkYOfbrVZ9oind3ve7q/ZgWodysKzW9vULKq0Durnkce+rcN
 zxNWkCK+XpCwmen+AkiNAjtG8SgD+jmQgEyaGN3pFuTbILW4+bo/g7oLJ6MvJtrzFNGx7qPeRnZ
 vM224IlM76hqUPr8ODYT1+JBn4cumS73zobdcvmO9T8bF5QFe+Y06gJlSmDJzbhODZQ==
X-Gm-Gg: ATEYQzzk9cc/+9yB5QAdycvhUVh2UnDiWz0/agHz6VAuhHZ4ZmnCHJNSRlCbrW1oSkk
 P5SgPyW9ZP10CB1FwaymCzClISQdjoiZqGcDNv/gbQErQSK7f3DOXEVLgdNdDxj//gEAGDMUH0A
 Gv/V+3tzDVktZZ62gEfbpl1bzrKPyAOSuQM6eVzMnpQh1/62N7wEhBK9fHUg6MAuYWayye/CQJh
 B6oj2hXHc+rDxR5VfCjwac7PLkpI+E1uc6QLmj1Gvn6ch7JR2ldCVhUeeWRoAkddxvbyEAE1qWC
 II53j2fVcZJ7Kt94IjgWj5tgLd3B8F3XdE3HFA74U2ESfWARXYy0vHNUtahFgICetMC5U7G4yli
 CntQQSUle11PAauULLUuMBxwSWPj9a8dGLXHTafJMye4hoq43w3csBtzE8YAiM8fpcx1+ig==
X-Received: by 2002:a05:7301:1010:b0:2be:1f58:32a6 with SMTP id
 5a478bee46e88-2be4e08fbeamr4063786eec.33.1773067709089; 
 Mon, 09 Mar 2026 07:48:29 -0700 (PDT)
X-Received: by 2002:a05:7301:1010:b0:2be:1f58:32a6 with SMTP id
 5a478bee46e88-2be4e08fbeamr4063751eec.33.1773067708261; 
 Mon, 09 Mar 2026 07:48:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 01/35] docs: Add hexagon sysemu docs
Date: Mon,  9 Mar 2026 07:47:48 -0700
Message-Id: <20260309144822.877695-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xo_lXyQumV-FPV4zsuRojEdRLyhtID2G
X-Proofpoint-ORIG-GUID: Xo_lXyQumV-FPV4zsuRojEdRLyhtID2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfXwiXCnpCK0RmP
 vFZhjbg/ysIid5xJYJay36562WXaU+BRFmdjJUnaeN7479zHcQ3e/u3+ATZAP14C0bN61n9LUW0
 RHCaIhRGxIORmDJp7phsugkaTVL/wfHvYCrROIbfwF/6VG+pjsCJqpE4theVODcYjA8IAdV9mi/
 3EL2NtVAq0wj+3ksazSlXlDwb2YxrlybFWUnszaYGyMdFzSHC5fe8AX2vfp0jsuLEj7Fgf5JtN6
 Yjyl2k2hCM7SCzkF39Z0xFPN2pl+0whMhENplyLYgnCATSyq4uF6ynXF7iHLvnr/MfVfQq19IMG
 ZtIWp7W1UBxgP0YwGQpNLmsGS1400uHCFxQrYNexyIOrfxjyjk/LpKjigdnCcrYizOHOBdq3wSQ
 u6qZWw05wGReXLvJjkJFrkrpUsBB1Pz2WhEJDWFmemAOUDextzlJw2MBMWHfh/DLltQiCVBqpr5
 5N0aXID/iucCopsCZAg==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aeddbe cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=fXLLft-zuLPsu7fQao0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 MAINTAINERS                    |   3 +
 docs/devel/hexagon-sys.rst     | 112 +++++++++++++++++++++++++++++++++
 docs/devel/index-internals.rst |   1 +
 docs/system/hexagon/cdsp.rst   |  12 ++++
 docs/system/target-hexagon.rst | 102 ++++++++++++++++++++++++++++++
 docs/system/targets.rst        |   1 +
 6 files changed, 231 insertions(+)
 create mode 100644 docs/devel/hexagon-sys.rst
 create mode 100644 docs/system/hexagon/cdsp.rst
 create mode 100644 docs/system/target-hexagon.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6698e5ff69c..21f409a0f2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -253,6 +253,9 @@ F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
 F: docker/dockerfiles/debian-hexagon-cross.docker
 F: gdb-xml/hexagon*.xml
+F: docs/system/target-hexagon.rst
+F: docs/system/hexagon/
+F: docs/devel/hexagon-sys.rst
 T: git https://github.com/quic/qemu.git hex-next
 
 Hexagon idef-parser
diff --git a/docs/devel/hexagon-sys.rst b/docs/devel/hexagon-sys.rst
new file mode 100644
index 00000000000..92ebc32dce8
--- /dev/null
+++ b/docs/devel/hexagon-sys.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _Hexagon-System-arch:
+
+Hexagon System Architecture
+===========================
+
+The hexagon architecture has some unique elements which are described here.
+
+Interrupts
+----------
+When interrupts arrive at a Hexagon DSP core, they are priority-steered to
+be handled by an eligible hardware thread with the lowest priority.
+
+Memory
+------
+Each hardware thread has an ``SSR.ASID`` field that contains its Address
+Space Identifier.  This value is catenated with a 32-bit virtual address -
+the MMU can then resolve this extended virtual address to a physical address.
+
+TLBs
+----
+The format of a TLB entry is shown below.
+
+.. note::
+    The Small Core DSPs have a different TLB format which is not yet
+    supported.
+
+.. admonition:: Diagram
+
+ .. code:: text
+
+             6                   5                   4               3
+       3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2
+      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+      |v|g|x|A|A|             |                                       |
+      |a|l|P|1|0|     ASID    |             Virtual Page              |
+      |l|b| | | |             |                                       |
+      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+
+         3                   2                   1                   0
+       1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+      | | | | |       |                                             | |
+      |x|w|r|u|Cacheab|               Physical Page                 |S|
+      | | | | |       |                                             | |
+      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+
+
+* ASID: the address-space identifier
+* A1, A0: the behavior of these cache line attributes are not modeled by QEMU.
+* xP: the extra-physical bit is the most significant physical address bit.
+* S: the S bit and the LSBs of the physical page indicate the page size
+* val: this is the 'valid' bit, when set it indicates that page matching
+  should consider this entry.
+
+.. list-table:: Page sizes
+   :widths: 25 25 50
+   :header-rows: 1
+
+   * - S-bit
+     - Phys page LSBs
+     - Page size
+   * - 1
+     - N/A
+     - 4kb
+   * - 0
+     - 0b1
+     - 16kb
+   * - 0
+     - 0b10
+     - 64kb
+   * - 0
+     - 0b100
+     - 256kb
+   * - 0
+     - 0b1000
+     - 1MB
+   * - 0
+     - 0b10000
+     - 4MB
+   * - 0
+     - 0b100000
+     - 16MB
+
+* glb: if the global bit is set, the ASID is not considered when matching
+  TLBs.
+* Cacheab: the cacheability attributes of TLBs are not modeled, these bits
+  are ignored.
+* RWX: read-, write-, execute-, enable bits.  Indicates if user programs
+  are permitted to read/write/execute the given page.
+* U: indicates if user programs can access this page.
+
+Scheduler
+---------
+The Hexagon system architecture has a feature to assist the guest OS
+task scheduler.  The guest OS can enable this feature by setting
+``SCHEDCFG.EN``.  The ``BESTWAIT`` register is programmed by the guest OS
+to indicate the priority of the highest priority task waiting to run on a
+hardware thread.  The reschedule interrupt is triggered when any hardware
+thread's priority in ``STID.PRIO`` is worse than the ``BESTWAIT``.  When
+it is triggered, the ``BESTWAIT.PRIO`` value is reset to 0x1ff.
+
+HVX Coprocessor
+---------------
+The Supervisor Status Register field ``SSR.XA`` binds a DSP hardware thread
+to one of the eight possible HVX contexts.  The guest OS is responsible for
+managing this resource.
+
+.. seealso::
+
+    ``target/hexagon/README`` in the QEMU source tree for more info about Hexagon.
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 7a0678cbdd3..0471db80645 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -14,6 +14,7 @@ Details about QEMU's various subsystems including how to add features to them.
    block-coroutine-wrapper
    clocks
    ebpf_rss
+   hexagon-sys
    migration/index
    multi-process
    reset
diff --git a/docs/system/hexagon/cdsp.rst b/docs/system/hexagon/cdsp.rst
new file mode 100644
index 00000000000..237529273cb
--- /dev/null
+++ b/docs/system/hexagon/cdsp.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Compute DSP
+===========
+
+A Hexagon CDSP is designed as a computation offload device for an SoC.  The
+``V66G_1024`` machine contains:
+
+* L2VIC interrupt controller
+* QTimer timer device
+
+This machine will support any Hexagon CPU, but will default to ``v66``.
diff --git a/docs/system/target-hexagon.rst b/docs/system/target-hexagon.rst
new file mode 100644
index 00000000000..5f7084a6a08
--- /dev/null
+++ b/docs/system/target-hexagon.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. _Hexagon-System-emulator:
+
+Hexagon System emulator
+-----------------------
+
+Use the ``qemu-system-hexagon`` executable to simulate a 32-bit Hexagon
+machine.
+
+Hexagon Machines
+================
+
+Hexagon DSPs are suited to various functions and generally appear in a
+"DSP subsystem" of a larger system-on-chip (SoC).
+
+Hexagon DSPs are often included in a subsystem that looks like the diagram
+below.  Instructions are loaded into DDR before the DSP is brought out of
+reset and the first instructions are fetched from DDR via the EVB/reset vector.
+
+In a real system, a TBU/SMMU would normally arbitrate AXI accesses but
+we don't have a need to model that for QEMU.
+
+Hexagon DSP cores use simultaneous multithreading (SMT) with as many as 8
+hardware threads.
+
+.. admonition:: Diagram
+
+ .. code:: text
+
+              AHB (local) bus                     AXI (global) bus
+                    │                                 │
+                    │                                 │
+       ┌─────────┐  │       ┌─────────────────┐       │
+       │ L2VIC   ├──┤       │                 │       │
+       │         ├──┼───────►                 ├───────┤
+       └─────▲───┘  │       │   Hexagon DSP   │       │
+             │      │       │                 │       │        ┌─────┐
+             │      │       │    N threads    │       │        │ DDR │
+             │      ├───────┤                 │       │        │     │
+        ┌────┴──┐   │       │                 │       ├────────┤     │
+        │QTimer ├───┤       │                 │       │        │     │
+        │       │   │       │                 │       │        │     │
+        └───────┘   │       │   ┌─────────┐   │       │        │     │
+                    │       │  ┌─────────┐│   │       │        │     │
+        ┌───────┐   │       │  │  HVX xM ││   │       │        │     │
+        │QDSP6SS├───┤       │  │         │┘   │       │        │     │
+        └───────┘   │       │  └─────────┘    │       │        └─────┘
+                    │       │                 │       │
+        ┌───────┐   │       └─────────────────┘       │
+        │  CSR  ├───┤
+        └───────┘   │   ┌──────┐   ┌───────────┐
+                    │   │ TCM  │   │   VTCM    │
+                        │      │   │           │
+                        └──────┘   │           │
+                                   │           │
+                                   │           │
+                                   │           │
+                                   └───────────┘
+
+Components
+----------
+Other than l2vic and HVX, the components below are not implemented in QEMU.
+
+* L2VIC: the L2 vectored interrupt controller.  Supports 1024 input
+  interrupts, edge- or level-triggered.  The core ISA has system registers
+  ``VID``, ``VID1`` which read through to the L2VIC device.
+* QTimer: ARMSSE-based programmable timer device. Its interrupts are
+  wired to the L2VIC.  System registers ``TIMER``, ``UTIMER`` read
+  through to the QTimer device.
+* QDSP6SS: DSP subsystem features, accessible to the entire SoC, including
+  DSP NMI, watchdog, reset, etc.
+* CSR: Configuration/Status Registers.
+* TCM: DSP-exclusive tightly-coupled memory.  This memory can be used for
+  DSPs when isolated from DDR and in some bootstrapping modes.
+* VTCM: DSP-exclusive vector tightly-coupled memory.  This memory is accessed
+  by some HVX instructions.
+* HVX: the vector coprocessor supports 64 and 128-byte vector registers.
+  64-byte mode is not implemented in QEMU.
+
+
+Bootstrapping
+-------------
+Hexagon systems do not generally have access to a block device.  So, for
+QEMU the typical use case involves loading a binary or ELF file into memory
+and executing from the indicated start address::
+
+    $ qemu-system-hexagon -kernel ./prog -append 'arg1 arg2'
+
+Semihosting
+-----------
+Hexagon supports a semihosting interface similar to other architectures'.
+The ``trap0`` instruction can activate these semihosting calls so that the
+guest software can access the host console and filesystem.  Semihosting
+is not yet implemented in QEMU hexagon.
+
+
+Hexagon Features
+================
+.. toctree::
+   hexagon/cdsp
+
diff --git a/docs/system/targets.rst b/docs/system/targets.rst
index 5b12858b216..5ebdd0f7fea 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -30,3 +30,4 @@ Contents:
    target-sparc64
    target-i386
    target-xtensa
+   target-hexagon
-- 
2.34.1


