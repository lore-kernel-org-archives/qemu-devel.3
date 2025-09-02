Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06DFCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzo-0006ng-0Q; Mon, 01 Sep 2025 23:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzc-0006f1-9j
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzV-0004QA-7U
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6es030596
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V/gmiIQui9QHU5OS0CRbUDLL6LwYzW+BkNFupQXyH1s=; b=e+ngS1QSFMAKS8fA
 6dP9qoNKQgbXtbZJMam/WFJjwjODEFj2vq3XnWv9j+kwJwOf20cET/87UsbADEWj
 cYdAwAkv7YvagKEoNr1/eXekh2gQ4UMFm8b+97o2xZNwpF+eLNB6TjqufaBHXK7/
 7T7Zv9IFKm2ZxYHWFKLJFVaWUWp4NbUNZEJmVx+/DgqaBEVsUFU+wymS2AaYR2tD
 JGyIvzQSVkhXc2Du7zFnjhuPPqOIwMDf4aHze4uUCzcS7Wl2pX5VewgLrwiI+IGD
 noiHTRKhrQVuD8S+ZmUjofnSHyH+N+IEdfpGPTJx2yBs2wNUfzsmQJUwg6F7VrYP
 nW8lhw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pbwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32811874948so2345571a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784845; x=1757389645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/gmiIQui9QHU5OS0CRbUDLL6LwYzW+BkNFupQXyH1s=;
 b=VO9A7TjD8NYby4jFdSO2NXix6qHHtdUzAXV4zA19nKwUTDXESlZyD7rkaJvK9BhG20
 frWqNiiI1XW0OUxwFqLtPe2jSVeXMxr0JuOEvW7t2tRSoJNJDdZiWAc7910Qd0Gf+NU6
 4dRlVAdn9fP0hE6kRn4cHRkG4yZF95NAauS/H+q6yKlat736YyWQBQu3NXiwTtxB4TE5
 8uxFzVtfPFbNa2QcJBG24ykEK+ZQI229ZRada0zE6JDS1rD4pVIEQ/CBl4WRdUEOOdJS
 0N+q7G6y+tGFH5wMkJCazLfNANsXFXhr/Czd1W7Gpat9Rn4AOgZeR4wCycMtM1r025fC
 Srjw==
X-Gm-Message-State: AOJu0YzId3nzCoOLgvUPsV/bDLH+IEmN5NO9AGX4dl2WR9wk4Ugk+3ca
 0kHD0LnBp564aH0BAKBsbrLg7NKydRWTxZj9wgH4zmn/r1NcH2S2NmUzbQUyCxGXzAx+Y2bqkWo
 OKa8M5oxGBEajQKyo2Y04Z7aNsGokjJ+5fweZIlp/mF+zsu3EkoAJa9K8tyvt69yfFwmr
X-Gm-Gg: ASbGncuW47s2ouSkilTSbjmI48Q9Cclxj2Qs0WBz8eA+AHUZTFiAnJjetHxGhcXCa0m
 w0jea+il6BbQv/mUMb06wIqowCRZwGZVrA282paM2p52zITdVu/12FjZtzRzKam17u1cuq56YpU
 oNaRxUYX4ucGpOYZRjvABny+8/LtdnWgs14tjTAboG3vj4BIVXU3RqqANIVOiQR/8ymNMjaUOYP
 jyNJu7mlGqOZ0G2h4MKKM41ufFC5jLW6ylPkjn1lNC9j2RrPkMuH/IVq9NSJ1Plx2nJC1pPh/JB
 15tPeiSGk216OyMRK8URXCLyrf/Flyc9vS6KE7EYaJScJ7f0NOWGNIpFO9BGvTsMyc3nLxWLIyK
 zfyKUblEVSGAk
X-Received: by 2002:a17:90b:4fcb:b0:327:e0cf:d7b4 with SMTP id
 98e67ed59e1d1-328156cc9aamr13370167a91.26.1756784844394; 
 Mon, 01 Sep 2025 20:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV7/VejOWgAP5NgUa7dtkRvAAq2TW1yz5XfyMRFEV2R0Z2nBaNBE3hfjmY068IV7LfsmNOSg==
X-Received: by 2002:a17:90b:4fcb:b0:327:e0cf:d7b4 with SMTP id
 98e67ed59e1d1-328156cc9aamr13370131a91.26.1756784843746; 
 Mon, 01 Sep 2025 20:47:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 01/40] docs: Add hexagon sysemu docs
Date: Mon,  1 Sep 2025 20:46:36 -0700
Message-Id: <20250902034715.1947718-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1zJkQKtbSbU_tAbcINi4-FA5SxqGKlKw
X-Proofpoint-GUID: 1zJkQKtbSbU_tAbcINi4-FA5SxqGKlKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX09y3cIu8uDYm
 uslUIvaiWG612KwwFc5ilXQ3AVFSam2ZflJHU3joUuCRcUfq15cSGiUwxYUojAAB/vWYKzh8X5r
 VSQLN9vVRZQab4GtBjDsZlz3HK2ChsQwB+kARgjT2hjDjEeaKMO6YqK2R06k03wbkbGMNGkyeqr
 /48nvgxBpsTpLmHSTXvOAmsQAswEG9kIkGHqXSugmVgUBn6s1U5nBYvf/AfBZUQRJEtVjGOyRLZ
 oEtMi18rsmVWfxEgnvHuf8YBFbgFRuWYo2TSCaDAcuXOQDD568XkRfkVOVihxbMkZ2BmmUEssfV
 9meukpBbjRy+11+LgVL9Y7FiSn/vG68cI0L6ColvoKu3r9tMS6yAIPr0Gte8wElmWhyj5dxUI0C
 9Vt6r0u6
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b668ce cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=D0m2eUgJkcDgvUq9oecA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
index 8f074e4371..bf7695658a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -237,6 +237,9 @@ F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
 F: docker/dockerfiles/debian-hexagon-cross.docker
 F: gdb-xml/hexagon*.xml
+F: docs/system/target-hexagon.rst
+F: docs/system/hexagon/cdsp.rst
+F: docs/devel/hexagon-sys.rst
 T: git https://github.com/quic/qemu.git hex-next
 
 Hexagon idef-parser
diff --git a/docs/devel/hexagon-sys.rst b/docs/devel/hexagon-sys.rst
new file mode 100644
index 0000000000..92ebc32dce
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
index 7a0678cbdd..0471db8064 100644
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
index 0000000000..237529273c
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
index 0000000000..5f7084a6a0
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
index 38e2418801..515e249326 100644
--- a/docs/system/targets.rst
+++ b/docs/system/targets.rst
@@ -30,3 +30,4 @@ Contents:
    target-sparc64
    target-i386
    target-xtensa
+   target-hexagon
-- 
2.34.1


