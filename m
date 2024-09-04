Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421D1CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 12:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpPA-0003Gr-5v; Wed, 04 Sep 2024 08:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1slpO1-00072a-GW
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1slpNv-0005u5-82
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:45:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484A1cLV011452;
 Wed, 4 Sep 2024 12:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qVrHAAZhAPofVC3tmGINcL
 f5xrDC/y1K6U/HaJUDLTM=; b=VJhPSAzNMtujllttYf1YOebN72cHFhQREgNdfV
 /4WVqx8UWhZYOv3MNNVEeXlqYNXx6Ej2HjETVM1OokRfbbUem+hafWbQPpu07Gma
 N9W9hqEG/EWO6sLujrMKJnL3dpA2eLO/LGfsGHp1Dngx0BOZXspIHWF18Xv8ahuv
 Keg811FsYwqX1NmPWseJda09iLoJO9gjkB+kTjwJtjK7ICD14hXQ4qP2EjP7l0jk
 DPwZhDcjgsRRwWxQ7tP5Rbt7KLR6bddZ5w5dOWk+np7WgRZ0iX+UdRw4MRRk8Ibp
 Z+INvuHnG2axQWYGL+hU9VPzLb6zhNyruOd0hJGA9ba0VDZw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt672ucr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2024 12:45:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484CjDOi019195
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 4 Sep 2024 12:45:13 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 05:45:13 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <sidneym@quicinc.com>, <bcain@quicinc.com>, <quic_mliebel@quicinc.com>,
 <mburton@qti.qualcomm.com>, <alex.bennee@linaro.org>,
 <peter.maydell@linaro.org>, <quic_acaggian@quicinc.com>,
 <quic_ggregory@quicinc.com>, <quic_jaehyoo@quicinc.com>,
 <quic_jiles@quicinc.com>, <quic_llindhol@quicinc.com>,
 <quic_mkurapat@quicinc.com>, <quic_rcran@quicinc.com>,
 <steplong@quicinc.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PATCH] target/hexagon: relicense GPL files to BSD-3
Date: Wed, 4 Sep 2024 09:45:00 -0300
Message-ID: <65ff7613c1501821ec3b7a04eb7265bc735dcb4a.1725453875.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: -pUgrwrW3X9NCeN0ulyViG6clv6T-B_d
X-Proofpoint-GUID: -pUgrwrW3X9NCeN0ulyViG6clv6T-B_d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040096
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Our internal contribution guidelines for QEMU were to use the BSD 3
clause license but we used GPLv2+ in error. So relicense the GPLv2+
Hexagon files to the compatible BSD 3-Clause, also updating the verbose
license boilerplate with the cleaner SPDX identifier.

To keep it simple, this patch only touches Hexagon files that have been
contributed exclusive from Quic Inc employees (ignoring both files
directly changed by other contributors as well as files with patches
that have Helped-by and Co-authored-by trailers from others).

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/cpu_bits.h                    | 15 ++-------------
 target/hexagon/helper.h                      | 15 ++-------------
 target/hexagon/mmvec/mmvec.h                 | 15 ++-------------
 tests/tcg/hexagon/hex_test.h                 | 15 ++-------------
 tests/tcg/hexagon/hvx_histogram_input.h      | 15 ++-------------
 tests/tcg/hexagon/hvx_misc.h                 | 15 ++-------------
 disas/hexagon.c                              | 15 ++-------------
 target/hexagon/arch.c                        | 15 ++-------------
 target/hexagon/gen_semantics.c               | 15 ++-------------
 target/hexagon/iclass.c                      | 15 ++-------------
 target/hexagon/printinsn.c                   | 15 ++-------------
 tests/tcg/hexagon/atomics.c                  | 15 ++-------------
 tests/tcg/hexagon/brev.c                     | 15 ++-------------
 tests/tcg/hexagon/circ.c                     | 15 ++-------------
 tests/tcg/hexagon/dual_stores.c              | 15 ++-------------
 tests/tcg/hexagon/hex_sigsegv.c              | 15 ++-------------
 tests/tcg/hexagon/hvx_histogram.c            | 15 ++-------------
 tests/tcg/hexagon/load_align.c               | 15 ++-------------
 tests/tcg/hexagon/load_unpack.c              | 15 ++-------------
 tests/tcg/hexagon/mem_noshuf.c               | 15 ++-------------
 tests/tcg/hexagon/mem_noshuf_exception.c     | 15 ++-------------
 tests/tcg/hexagon/misc.c                     | 15 ++-------------
 tests/tcg/hexagon/multi_result.c             | 15 ++-------------
 tests/tcg/hexagon/overflow.c                 | 15 ++-------------
 tests/tcg/hexagon/read_write_overlap.c       | 15 ++-------------
 tests/tcg/hexagon/reg_mut.c                  | 15 ++-------------
 tests/tcg/hexagon/scatter_gather.c           | 15 ++-------------
 tests/tcg/hexagon/signal_context.c           | 15 ++-------------
 tests/tcg/hexagon/usr.c                      | 13 +------------
 tests/tcg/hexagon/v68_hvx.c                  | 15 ++-------------
 tests/tcg/hexagon/v68_scalar.c               | 15 ++-------------
 tests/tcg/hexagon/v69_hvx.c                  | 15 ++-------------
 tests/tcg/hexagon/v73_scalar.c               | 15 ++-------------
 tests/tcg/hexagon/v6mpy_ref.c.inc            | 15 ++-------------
 gdb-xml/hexagon-hvx.xml                      |  5 ++---
 target/hexagon/imported/branch.idef          | 15 ++-------------
 target/hexagon/imported/compare.idef         | 15 ++-------------
 target/hexagon/imported/encode.def           | 15 ++-------------
 target/hexagon/imported/encode_pp.def        | 15 ++-------------
 target/hexagon/imported/encode_subinsn.def   | 15 ++-------------
 target/hexagon/imported/float.idef           | 15 ++-------------
 target/hexagon/imported/iclass.def           | 15 ++-------------
 target/hexagon/imported/ldst.idef            | 15 ++-------------
 target/hexagon/imported/mmvec/encode_ext.def | 15 ++-------------
 target/hexagon/imported/mmvec/macros.def     | 15 ++-------------
 target/hexagon/imported/mpy.idef             | 15 ++-------------
 target/hexagon/imported/shift.idef           | 15 ++-------------
 target/hexagon/imported/subinsns.idef        | 15 ++-------------
 target/hexagon/imported/system.idef          | 15 ++-------------
 tests/tcg/hexagon/hvx_histogram_row.S        | 15 ++-------------
 50 files changed, 99 insertions(+), 639 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 4279281a71..31321ea92b 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #ifndef HEXAGON_CPU_BITS_H
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index fa0ebaf7c8..73a7b93b76 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include "internal.h"
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
index 52d470709c..9d92883f1a 100644
--- a/target/hexagon/mmvec/mmvec.h
+++ b/target/hexagon/mmvec/mmvec.h
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #ifndef HEXAGON_MMVEC_H
diff --git a/tests/tcg/hexagon/hex_test.h b/tests/tcg/hexagon/hex_test.h
index cfed06a58b..75c4128cc8 100644
--- a/tests/tcg/hexagon/hex_test.h
+++ b/tests/tcg/hexagon/hex_test.h
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2022-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 
diff --git a/tests/tcg/hexagon/hvx_histogram_input.h b/tests/tcg/hexagon/hvx_histogram_input.h
index 2f9109255e..77aa100dca 100644
--- a/tests/tcg/hexagon/hvx_histogram_input.h
+++ b/tests/tcg/hexagon/hvx_histogram_input.h
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
     { 0x26, 0x32, 0x2e, 0x2e, 0x2d, 0x2c, 0x2d, 0x2d,
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
index 2e868340fd..1701f75810 100644
--- a/tests/tcg/hexagon/hvx_misc.h
+++ b/tests/tcg/hexagon/hvx_misc.h
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2021-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #ifndef HVX_MISC_H
diff --git a/disas/hexagon.c b/disas/hexagon.c
index c1a4ffc5f6..833c6d5a4b 100644
--- a/disas/hexagon.c
+++ b/disas/hexagon.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
index d053d68487..a972e1d6c3 100644
--- a/target/hexagon/arch.c
+++ b/target/hexagon/arch.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include "qemu/osdep.h"
diff --git a/target/hexagon/gen_semantics.c b/target/hexagon/gen_semantics.c
index 4a2bdd70e9..b3a534c939 100644
--- a/target/hexagon/gen_semantics.c
+++ b/target/hexagon/gen_semantics.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/iclass.c b/target/hexagon/iclass.c
index c3f8523b27..b803982edf 100644
--- a/target/hexagon/iclass.c
+++ b/target/hexagon/iclass.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include "qemu/osdep.h"
diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index 4865cdd133..4046abddec 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include "qemu/osdep.h"
diff --git a/tests/tcg/hexagon/atomics.c b/tests/tcg/hexagon/atomics.c
index 1c2169b28b..d261a0706c 100644
--- a/tests/tcg/hexagon/atomics.c
+++ b/tests/tcg/hexagon/atomics.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdlib.h>
diff --git a/tests/tcg/hexagon/brev.c b/tests/tcg/hexagon/brev.c
index 6c7b134084..17f03877d1 100644
--- a/tests/tcg/hexagon/brev.c
+++ b/tests/tcg/hexagon/brev.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/circ.c b/tests/tcg/hexagon/circ.c
index ab949ebef1..e9ce17c59f 100644
--- a/tests/tcg/hexagon/circ.c
+++ b/tests/tcg/hexagon/circ.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2022 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/dual_stores.c b/tests/tcg/hexagon/dual_stores.c
index 775458e0fc..feb386c393 100644
--- a/tests/tcg/hexagon/dual_stores.c
+++ b/tests/tcg/hexagon/dual_stores.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/hex_sigsegv.c b/tests/tcg/hexagon/hex_sigsegv.c
index f43e0308f9..19dfaea9b8 100644
--- a/tests/tcg/hexagon/hex_sigsegv.c
+++ b/tests/tcg/hexagon/hex_sigsegv.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2021-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/hvx_histogram.c b/tests/tcg/hexagon/hvx_histogram.c
index 43377a9abb..90bd29c29b 100644
--- a/tests/tcg/hexagon/hvx_histogram.c
+++ b/tests/tcg/hexagon/hvx_histogram.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/load_align.c b/tests/tcg/hexagon/load_align.c
index f5948fd539..5c8b41c43f 100644
--- a/tests/tcg/hexagon/load_align.c
+++ b/tests/tcg/hexagon/load_align.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/load_unpack.c b/tests/tcg/hexagon/load_unpack.c
index c30f4d80aa..28eedec66b 100644
--- a/tests/tcg/hexagon/load_unpack.c
+++ b/tests/tcg/hexagon/load_unpack.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/mem_noshuf.c b/tests/tcg/hexagon/mem_noshuf.c
index 6263d5ef8e..d8e3616277 100644
--- a/tests/tcg/hexagon/mem_noshuf.c
+++ b/tests/tcg/hexagon/mem_noshuf.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/mem_noshuf_exception.c b/tests/tcg/hexagon/mem_noshuf_exception.c
index 61108a99be..747a3c4a65 100644
--- a/tests/tcg/hexagon/mem_noshuf_exception.c
+++ b/tests/tcg/hexagon/mem_noshuf_exception.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2022-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/misc.c b/tests/tcg/hexagon/misc.c
index ca22bb79f7..7b54f845dd 100644
--- a/tests/tcg/hexagon/misc.c
+++ b/tests/tcg/hexagon/misc.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/multi_result.c b/tests/tcg/hexagon/multi_result.c
index 38ee369e76..445f182d6d 100644
--- a/tests/tcg/hexagon/multi_result.c
+++ b/tests/tcg/hexagon/multi_result.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/overflow.c b/tests/tcg/hexagon/overflow.c
index 7b5b9ebdde..67efd61ed4 100644
--- a/tests/tcg/hexagon/overflow.c
+++ b/tests/tcg/hexagon/overflow.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2021-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdlib.h>
diff --git a/tests/tcg/hexagon/read_write_overlap.c b/tests/tcg/hexagon/read_write_overlap.c
index 95c54ccd63..acfb84f54a 100644
--- a/tests/tcg/hexagon/read_write_overlap.c
+++ b/tests/tcg/hexagon/read_write_overlap.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2023-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/reg_mut.c b/tests/tcg/hexagon/reg_mut.c
index c5a39e5510..53812cb3bb 100644
--- a/tests/tcg/hexagon/reg_mut.c
+++ b/tests/tcg/hexagon/reg_mut.c
@@ -1,19 +1,8 @@
 
 /*
- *  Copyright(c) 2022-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/scatter_gather.c b/tests/tcg/hexagon/scatter_gather.c
index bf8b5e0317..dcb60bfb49 100644
--- a/tests/tcg/hexagon/scatter_gather.c
+++ b/tests/tcg/hexagon/scatter_gather.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/signal_context.c b/tests/tcg/hexagon/signal_context.c
index 7202fa64b6..a1bcbeabd0 100644
--- a/tests/tcg/hexagon/signal_context.c
+++ b/tests/tcg/hexagon/signal_context.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2022 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/usr.c b/tests/tcg/hexagon/usr.c
index f0b23d312b..f93f29e6c3 100644
--- a/tests/tcg/hexagon/usr.c
+++ b/tests/tcg/hexagon/usr.c
@@ -1,18 +1,7 @@
 /*
  *  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/v68_hvx.c b/tests/tcg/hexagon/v68_hvx.c
index 02718722a3..351fd25984 100644
--- a/tests/tcg/hexagon/v68_hvx.c
+++ b/tests/tcg/hexagon/v68_hvx.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2022-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2022-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/v68_scalar.c b/tests/tcg/hexagon/v68_scalar.c
index 7a8adb1130..1703ba5bf8 100644
--- a/tests/tcg/hexagon/v68_scalar.c
+++ b/tests/tcg/hexagon/v68_scalar.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2023-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/v69_hvx.c b/tests/tcg/hexagon/v69_hvx.c
index a0d567d142..017a04d5ff 100644
--- a/tests/tcg/hexagon/v69_hvx.c
+++ b/tests/tcg/hexagon/v69_hvx.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2023-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/v73_scalar.c b/tests/tcg/hexagon/v73_scalar.c
index fee67fc531..ac7464e579 100644
--- a/tests/tcg/hexagon/v73_scalar.c
+++ b/tests/tcg/hexagon/v73_scalar.c
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2023-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #include <stdio.h>
diff --git a/tests/tcg/hexagon/v6mpy_ref.c.inc b/tests/tcg/hexagon/v6mpy_ref.c.inc
index 8258cddcb1..ef4ed83116 100644
--- a/tests/tcg/hexagon/v6mpy_ref.c.inc
+++ b/tests/tcg/hexagon/v6mpy_ref.c.inc
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2021-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 { 0xffffee11, 0xfffffcca, 0xffffc1b3, 0xffffd0cc,
diff --git a/gdb-xml/hexagon-hvx.xml b/gdb-xml/hexagon-hvx.xml
index 5f2e220733..59ba31b2c8 100644
--- a/gdb-xml/hexagon-hvx.xml
+++ b/gdb-xml/hexagon-hvx.xml
@@ -1,9 +1,8 @@
 <?xml version="1.0"?>
 <!--
-  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+  Copyright(c) 2023-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 
-  This work is licensed under the terms of the GNU GPL, version 2 or
-  (at your option) any later version. See the COPYING file in the
+  SPDX-License-Identifier: BSD-3-Clause
   top-level directory.
 
   Note: this file is intended to be use with LLDB, so it contains fields
diff --git a/target/hexagon/imported/branch.idef b/target/hexagon/imported/branch.idef
index 93e2e375a5..18f33d48af 100644
--- a/target/hexagon/imported/branch.idef
+++ b/target/hexagon/imported/branch.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 
diff --git a/target/hexagon/imported/compare.idef b/target/hexagon/imported/compare.idef
index abd016ffb5..c5bfbf8e6f 100644
--- a/target/hexagon/imported/compare.idef
+++ b/target/hexagon/imported/compare.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/encode.def b/target/hexagon/imported/encode.def
index e40e7fbffb..63d725be72 100644
--- a/target/hexagon/imported/encode.def
+++ b/target/hexagon/imported/encode.def
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/encode_pp.def b/target/hexagon/imported/encode_pp.def
index 0cd30a5e85..e4662472a3 100644
--- a/target/hexagon/imported/encode_pp.def
+++ b/target/hexagon/imported/encode_pp.def
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/encode_subinsn.def b/target/hexagon/imported/encode_subinsn.def
index 742fb50efb..1f48c00d30 100644
--- a/target/hexagon/imported/encode_subinsn.def
+++ b/target/hexagon/imported/encode_subinsn.def
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 
diff --git a/target/hexagon/imported/float.idef b/target/hexagon/imported/float.idef
index 3e75bc4604..4dfd35c0ed 100644
--- a/target/hexagon/imported/float.idef
+++ b/target/hexagon/imported/float.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/iclass.def b/target/hexagon/imported/iclass.def
index fb57968c6c..89a2784470 100644
--- a/target/hexagon/imported/iclass.def
+++ b/target/hexagon/imported/iclass.def
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /* DEF_*(TYPE,SLOTS,UNITS) */
diff --git a/target/hexagon/imported/ldst.idef b/target/hexagon/imported/ldst.idef
index 53198176a9..582e9606ee 100644
--- a/target/hexagon/imported/ldst.idef
+++ b/target/hexagon/imported/ldst.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index 402438f566..e604ca94fd 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 #define CONCAT(A,B) A##B
diff --git a/target/hexagon/imported/mmvec/macros.def b/target/hexagon/imported/mmvec/macros.def
index 7e5438a998..c25f4a422f 100755
--- a/target/hexagon/imported/mmvec/macros.def
+++ b/target/hexagon/imported/mmvec/macros.def
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 DEF_MACRO(fDUMPQ,
diff --git a/target/hexagon/imported/mpy.idef b/target/hexagon/imported/mpy.idef
index 8744f6596c..8ecd90ec19 100644
--- a/target/hexagon/imported/mpy.idef
+++ b/target/hexagon/imported/mpy.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/shift.idef b/target/hexagon/imported/shift.idef
index b32c4e04d1..bf79382cd0 100644
--- a/target/hexagon/imported/shift.idef
+++ b/target/hexagon/imported/shift.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/subinsns.idef b/target/hexagon/imported/subinsns.idef
index be0ae8779d..d9e56d5b24 100644
--- a/target/hexagon/imported/subinsns.idef
+++ b/target/hexagon/imported/subinsns.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2022 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/target/hexagon/imported/system.idef b/target/hexagon/imported/system.idef
index 7c6568e75e..0740f5a74c 100644
--- a/target/hexagon/imported/system.idef
+++ b/target/hexagon/imported/system.idef
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 /*
diff --git a/tests/tcg/hexagon/hvx_histogram_row.S b/tests/tcg/hexagon/hvx_histogram_row.S
index 5e42c33145..75c58289b4 100644
--- a/tests/tcg/hexagon/hvx_histogram_row.S
+++ b/tests/tcg/hexagon/hvx_histogram_row.S
@@ -1,18 +1,7 @@
 /*
- *  Copyright(c) 2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *  SPDX-License-Identifier: BSD-3-Clause
  */
 
 
-- 
2.37.2


