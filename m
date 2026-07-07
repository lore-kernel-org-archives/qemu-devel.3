Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF6BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAKs-0004Ri-1D; Tue, 07 Jul 2026 14:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKk-0004JM-51
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKi-0006JQ-NF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667GuujS230687
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cZZNnJO6/aPAjx1V3kaMewkQbgKmd8vt2MG1+tk3BuY=; b=kG+sMft9dbOUGTuY
 BoSqZez1HLFlABy7d5RDpnDDIOl1SzUEli/ZAgLvfa78/C0vf+mX1OBujKy769mw
 5vLYFuTiQFoys/fM2EsdIavL5RIBWIBI4bcQZjrMpteROO3bGDT0Ic3iFbhnO547
 umZTzK4T5wF3UFtqHthPSSNnfjVgdR5RUyQ4u0AvkzWZ/71Ha9G8/+bx86sCCVBv
 zSqmC+dkVPesWBNj/L5TtOf9A0dbxkeTqe0BZGMR5U685zueN2VkiSv8QhyO6b3a
 z/QJ7DM+CWJvozyN1b+qSsaN0gpqzKQeG2bm3aZO3SyfKNW4Biyh48hnzRKw1Byd
 NXW3lg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5rch8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:15:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1ada6c43so66364751cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448146; x=1784052946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZZNnJO6/aPAjx1V3kaMewkQbgKmd8vt2MG1+tk3BuY=;
 b=Y1kov+UJ5/eCAtkBRrpD3tCbe0ggRS555ixfZotzp11rD4uZRUhE9XDpxT9sOuoi8A
 G+dGIRcl7Ew1YOmDttZ3P4cCSxBncZCfmbZ11QUsz8jFjIPPC/2IYROXKzPVlWpx22eQ
 Eq4MFMMzsG3842VVUqdbkgIPHQyu+G0/7+qpRzaKPSxq4GUk7X3Bqg/bcOPuUafnkS3h
 l4ZAG2mOzmwZlxoBp5jao2MfG2O3gr/1XuWqEYI4clNH8eL1dhwEfccESKCGeuChlyNq
 Mp+gBLsId+Qemor7utS0oXauZ+UT8Q+6QDn00J6zvGZDQu2fYJ4VsRuptirUPKR1t0ih
 W1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448146; x=1784052946;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cZZNnJO6/aPAjx1V3kaMewkQbgKmd8vt2MG1+tk3BuY=;
 b=p+MtPbFCh3uM/T3eA5GGgo6EJ9cm0GwFycjvwd1LlIu42SgJm9mte6TwrPsu7hMptU
 ZwiDviXDGABb1y+4mY34OFtJZIab5tLLnn8vSE9LtDNCOP0td6+JRlBRjYV1A6j9ubai
 A+WirDcWjHaGrlosfRIM+7WTSR+CI6fyBUVVnxWS0B6ZAvJ8WOjT7N1QfIMO1YsvGGLh
 kzovkz2wfhjmjvOK9xo4dQbRnWaiBkNMmc/Q4+q3AwhssMQpVEEqNDmdWl7QLjRO2bYU
 NU0PglHBitFuC/UZdUVkwkyyUeFnBg2Ryf98h6OckWThnIqYUidgASe65FsO8NEaPjrJ
 frYg==
X-Gm-Message-State: AOJu0YxA8Sj3DnG6wTI+BI+LQ93gnD4thWW801oOAg0/ALrjQscStpw8
 iyKsrfa72KwzeClO8CU6Gnz3Yx8WoHDbK3LBKeEL342tfo7eYDS3y0UTayGrIBKMsdD3VnK7mDZ
 KBskUiJ8W6FS+BFtsytA+IzDxyrfw2+fSyJIDAvvHN+hrd/wM+gDuT2aTSFJ+6XSI/A==
X-Gm-Gg: AfdE7ckPw2wflJ+rNc4PRF7FCIMMHX7VIwD/qnbIk+mzU4rstRpRnji1kduJwLxA5io
 W9OTJzjMAlPh4xIiwHEiJNuOFlNhL6ItARvKzAFJfPVxBDBTn23Ml+VO2YndvdTFtxpE1m7wHOd
 LbsaUZj5+pDrtTcbHQkHTUmM8wEqYtRDCV4hanRZ/PeKNoHIG21RVH2G7YSlbeYJ3lqgRdBgUdD
 6l2+k2dRDU2PtiBB/6rE2AWP0wNeUOJlX22eMgUdFCv35Q4UZM8mnx3FoJINjj92GiWdv8I39g4
 C5LJNmFFLKDxUOSwFC4/F784j6LcFZ6joQs0WMaTXaGHfKevMBK75o1vlYbemBIcqCcpfWtROsd
 X+LqW59TU29nTAc0+bFe1XZ/8YKiSkyLSR5/JeHTShEIUUBr3N/seINEIs90/RiPeIi+M
X-Received: by 2002:a05:622a:15d0:b0:51c:63d:fc10 with SMTP id
 d75a77b69052e-51c747d055dmr71086121cf.25.1783448145623; 
 Tue, 07 Jul 2026 11:15:45 -0700 (PDT)
X-Received: by 2002:a05:622a:15d0:b0:51c:63d:fc10 with SMTP id
 d75a77b69052e-51c747d055dmr71085651cf.25.1783448145120; 
 Tue, 07 Jul 2026 11:15:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f50418sm66769535e9.11.2026.07.07.11.15.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:15:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/23] target/mips: add Octeon COP2 crypto helper plumbing
Date: Tue,  7 Jul 2026 20:15:07 +0200
Message-ID: <20260707181529.60191-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: acQLsvist3eBAnTff--mMkTt1XD7U6_m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfXxm+Y+pj6kr6+
 B+Kr8UQo1bSYdvzRfK65by9Et8tNPfuSu8OYmfI5O/FVuN8w292fElT7fMAC6EKNRUNi/yZ0Zka
 ESWJPVXCRO0S+E3J/Qe69dc4fKghqEY=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4d4252 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uD-nPplgcWYPQsZCk3QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: acQLsvist3eBAnTff--mMkTt1XD7U6_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX4nfp++wZFlOF
 dd0VLD58mGjC7IAa3MoXhnt3AeqCgu/3bp+1Ep2wqg45IyFlTHyLusgjbL8EU6Y4OscPJeNr+Ql
 kU3v+Ee04NtrkDphdi4Nt19sPPcCSqThzU7K4oJTfiEckvT0zRe8V8NzVwCUgTZREu93FffHcyc
 7kXkLkz98vztsav7DnZ5DSc6cvpASw35XqOmpKAAZBM6BtGOrUSPfeX6IkgILs2BFzf9/vSioPa
 mHg4Q3i3ZInOdghQX1H/HV7rxgLDZII7d+k4zbw0ynqqM3zl8sgnxK8UUW7O3kDnBYOvDeT7wMd
 4B4EINlY2/GSaugc1rVcNxtIjtTn0/k/kzOAaVo+Qwbf/Ef30iuLkDwJHU+Elazotg+eLJY+RTb
 as2RXO/oXqExywSahQZ6TaUx8M4GoNa/x23EYwaGP4HLNCCw4tQneofNTsM5/MpWgHMDFRNOzee
 8QeooP7MF/ATv48rIOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the Octeon COP2 crypto helper source file and build it with the MIPS
TCG target. This provides the common compilation unit for the COP2 engine
helpers.

The instruction dispatch itself remains fully decoded by decodetree, and
operation selectors call per-operation helpers rather than a common
selector-dispatch helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-2-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/octeon_crypto.c | 16 ++++++++++++++++
 target/mips/tcg/meson.build     |  1 +
 2 files changed, 17 insertions(+)
 create mode 100644 target/mips/tcg/octeon_crypto.c

diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
new file mode 100644
index 00000000000..df5b0449aeb
--- /dev/null
+++ b/target/mips/tcg/octeon_crypto.c
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * MIPS Octeon crypto emulation helpers.
+ *
+ * Copyright (c) 2026 James Hilliard
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internal.h"
+#include "exec/helper-proto.h"
+#include "crypto/aes.h"
+#include "crypto/sm4.h"
+#include "qemu/bitops.h"
+#include "qemu/host-utils.h"
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index fff9cd6c7f5..4ee359874ac 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -18,6 +18,7 @@ mips_ss.add(files(
   'lmmi_helper.c',
   'msa_helper.c',
   'msa_translate.c',
+  'octeon_crypto.c',
   'op_helper.c',
   'rel6_translate.c',
   'translate.c',
-- 
2.53.0


