Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UwQWSCyS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H0LcIV5s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo8N-0007jY-PO; Fri, 30 Oct 2026 11:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8A-0007Yw-11
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo85-00078n-UZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:02:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERjhd3207537
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y6iUJBzjLMb142rUcRxI2nGbYdvciJWZ6b2O6Rm7Fi4=; b=UwQWSCyS86tFsjec
 VNbNtpezWC6D6bHlYKERcqLn82EchVpCAd36OeW3RrqpI/plancAU8WCab4D/J8J
 avfTAe2TaVlQWVCWjWWixgzzo04rh3PBvBaH7ZxzPh0/46Fv6NkXnd3CCeaJPjii
 oAw2zFgM8qrMBKK9lLqpdpymnxvweHdWne2yv2wb6A6hh4q7xvaWJN8QKRuyxxus
 yTmjKNSg0gHmGF0xWpT0E0XQYGYip+GU33Cs99HM+J00UCF8Tw2tTojA7hjIR63R
 ZwoO0cOxpMoVShf7JYDwqdxievRQuJ0oWPIcqouNmpHbXXw/BIENpgd9a/AW9Nkl
 rGFI6g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkmh0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:02:52 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988bea8fed6so618401241.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372572; x=1793977372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y6iUJBzjLMb142rUcRxI2nGbYdvciJWZ6b2O6Rm7Fi4=;
 b=H0LcIV5sj/Z6KGueEjUFHjVlAew5rBG0q/U6cAzu8LHNMFk3PuALvzfzkTeTe60TXN
 CIdbbt8/KyzrTkvoIdMkiM7iSh5fx3YQZz7gX1LhkVQqkFkx39eLdIoPcprvh8gfoO/x
 A1eH6QITB3qY9oduS7ewceAfSxoXxLWdV040407ashlaIjZGONLpMsdphKY0uAzw6nAt
 w5IEXLswXeKtMsfQ6cqWuEzVhUT/IyZi8a683wcIywr325c5AY5Qr7hQfrJE8Vhj/R42
 U5OcgcaYppUfpGU9lgbZlVfFymB1ZAgNlNSVqzKfttCKm5gATNfOXhZKSXJAJjVq3a2f
 bqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372572; x=1793977372;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y6iUJBzjLMb142rUcRxI2nGbYdvciJWZ6b2O6Rm7Fi4=;
 b=tYpi13ahQmydG2r2Vo0gE2HLioMZYHH4pth07Fi/TSWVUUG2DA340U6BfFXD6q5HGN
 ZyRnN2e6d2MuEKsWsNQIZJR8ejpzaSIiWuEJHs8Cf1jd3+kMKPPDLlZr6KccpcLyXgBO
 CW0ZjmhoqQLFQ0hSMXYBTKHufo0YpfQffqa/0w3Jl3O9UJBBEAbO2rZxPssI/ar188Y+
 r/SpNa04wi4p2HQhErhPYkqYfDEeOWKc+G8CeQxovfII1RLTzvloQTHBJg41n0NmAEzR
 EelK7E8lVysxo0uuft548P3j+kjS6OB0BM2a/RUfqPu8AdpVl7SgJR9v5ZMQ3ku1Zgjn
 GJBw==
X-Gm-Message-State: AFq9FYIy6hRHbrdE3b3AIuKN1c5gENQGbNq4nL5oVIi388ePsV1MDssZ
 rwFouPiI5D8hhmIYC8+VaStb1St0O9EPY5wq66gevNDX9ODLIAzPcO3ASMh7+/bNVb/eu2vdxxY
 7pZlMtBg7P/2zndaoK8zkxf6dODCIZWL3RyoD1qZiPtvAFyIDIL36Q4q91jTUfEfWTT5Y
X-Gm-Gg: AYBFou1iN+9H69PuvZrEdO6be9Zfjcm9E1Y8aVV/DtU+d2bdeCB9FsURca7Lz9Kz0CH
 jDiATUZ0f1k9XWy/mp4mZlmQx7QkoqO1om8dgglONrXCRg8U6h+hnHtd8uA6Bz5L1Az63gUraaE
 2tAc7C6hpYqV/JPzRQx6EMFhR7d++ON+AkeFbqV0eawvwvhl9Py2Z6gT5HbvlUwETxX/4+gFlCS
 4BDVwXdca10yarzlSuQXHfCamnTitZ3sMa7QqMNK908JDkD33N9T42Ac7SqXYlD2FmttSh9Knq0
 vFh6eX+DFcSJKQGsX4sOGS7UuyTvJ1isjdDOtIjMrTupMp+zOBB6czMkNkp7Ep00kzAlMci2KmL
 Lm2ShJqbMzIQRLf1GboOe7gsuo/Is3SDCaWJTFETZN61VN2CUKexlCdSyWBZGtEjuqnn7jlfCx3
 g7vFxQQ2HS9Wb/JaEsEn8UrYq+A4HA0A==
X-Received: by 2002:a05:6102:fa0:b0:7cb:70ed:ff90 with SMTP id
 ada2fe7eead31-7d072725679mr1323794137.26.1793372571439; 
 Fri, 30 Oct 2026 08:02:51 -0700 (PDT)
X-Received: by 2002:a05:6102:fa0:b0:7cb:70ed:ff90 with SMTP id
 ada2fe7eead31-7d072725679mr1323662137.26.1793372570272; 
 Fri, 30 Oct 2026 08:02:50 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf368bff7sm67360455e9.2.2026.10.30.08.02.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:02:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/31] tests/tcg/mips: Group DSP dot tests
Date: Fri, 30 Oct 2026 16:01:35 +0100
Message-ID: <20261030150202.61556-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4b19c cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ss58A6hLZCuk7yZQP4AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: u6UNB-anSIaWM5KlRc7V5FIE6jrmjlLk
X-Proofpoint-GUID: u6UNB-anSIaWM5KlRc7V5FIE6jrmjlLk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX6GV/DODpNGb9
 hMi+YZZ4kQXBHiPslJ6qhF7T8m56tQoYgwBBYGynpQgqDvDXXoGMeU7Cobw3RCJvXihuTGWhZhm
 pqLed5YfW1d2mHZ/71W8W0+7PewPXyTarqRUy1Lg7EzAeldycULzr+D2OJTCH4y4ht/nFJAlwdZ
 Cb9HrmyWFQ82qo5ns78yJg6+AvPZgmcXC6bqHr3ppHiQ8UCJxHCtyvxaDOpranK8HAXk2H+OI2L
 VIL9lkvHK18q6DsTTM1I/bJYWzZ32Nf6gBpZCMyt93lx2e8GoN6BdU+1YuIs/Ifz7a97uLtQSXy
 XJYlN8INkgFp2QoQ87wDI5lnpH2reggkTzZTYldFF1nXFLwuakexVaDMfGPkUIHgve032SZImLy
 F7gbxTHZb4oibylk1r/i0R61srelzXzcm4BnD/FsQoWbOBxP2nkjUcHk/xhToR6wq7Z8vw2QF/v
 BHUl+xWugU/D/LcoUMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX0Ldh1TA7m6ud
 VmQcAD1xU+cplu56Pd+RM4PWFbmChN3MbxMoxmC7u1Vi3ImNiiPl4Slxi6MPl+lpLWmto9cik+Q
 VLxBrYRGo9Q34ZTBd4F8GrSG/CxmKOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 28 per-opcode dot tests as a single executable,
test_dsp_dot.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_dot.c              | 153 +++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_madd.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_maddu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_msub.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_msubu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_mult.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_multu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c |   1 -
 tests/tcg/mipsel/meson.build                 |  29 +---
 30 files changed, 154 insertions(+), 56 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_dot.c

diff --git a/tests/tcg/mipsel/test_dsp_dot.c b/tests/tcg/mipsel/test_dsp_dot.c
new file mode 100644
index 000000000000..4086bcd39741
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_dot.c
@@ -0,0 +1,153 @@
+/*
+ * MIPS DSP ASE tests: Dot Product and Multiply-Accumulate instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_dpaq_s_w_ph
+#include "test_dsp_r1_dpaq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpaq_sa_l_w
+#include "test_dsp_r1_dpaq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbl
+#include "test_dsp_r1_dpau_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbr
+#include "test_dsp_r1_dpau_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_s_w_ph
+#include "test_dsp_r1_dpsq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_sa_l_w
+#include "test_dsp_r1_dpsq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbl
+#include "test_dsp_r1_dpsu_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbr
+#include "test_dsp_r1_dpsu_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phl
+#include "test_dsp_r1_maq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phr
+#include "test_dsp_r1_maq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phl
+#include "test_dsp_r1_maq_sa_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phr
+#include "test_dsp_r1_maq_sa_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_madd
+#include "test_dsp_r1_madd.c"
+#undef main
+
+#define main test_dsp_r1_maddu
+#include "test_dsp_r1_maddu.c"
+#undef main
+
+#define main test_dsp_r1_msub
+#include "test_dsp_r1_msub.c"
+#undef main
+
+#define main test_dsp_r1_msubu
+#include "test_dsp_r1_msubu.c"
+#undef main
+
+#define main test_dsp_r1_mult
+#include "test_dsp_r1_mult.c"
+#undef main
+
+#define main test_dsp_r1_multu
+#include "test_dsp_r1_multu.c"
+#undef main
+
+#define main test_dsp_r2_dpa_w_ph
+#include "test_dsp_r2_dpa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_s_w_ph
+#include "test_dsp_r2_dpaqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_sa_w_ph
+#include "test_dsp_r2_dpaqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpax_w_ph
+#include "test_dsp_r2_dpax_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dps_w_ph
+#include "test_dsp_r2_dps_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_s_w_ph
+#include "test_dsp_r2_dpsqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_sa_w_ph
+#include "test_dsp_r2_dpsqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsx_w_ph
+#include "test_dsp_r2_dpsx_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsa_w_ph
+#include "test_dsp_r2_mulsa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsaq_s_w_ph
+#include "test_dsp_r2_mulsaq_s_w_ph.c"
+#undef main
+
+int main(void)
+{
+    RUN_TEST(test_dsp_r1_dpaq_s_w_ph);
+    RUN_TEST(test_dsp_r1_dpaq_sa_l_w);
+    RUN_TEST(test_dsp_r1_dpau_h_qbl);
+    RUN_TEST(test_dsp_r1_dpau_h_qbr);
+    RUN_TEST(test_dsp_r1_dpsq_s_w_ph);
+    RUN_TEST(test_dsp_r1_dpsq_sa_l_w);
+    RUN_TEST(test_dsp_r1_dpsu_h_qbl);
+    RUN_TEST(test_dsp_r1_dpsu_h_qbr);
+    RUN_TEST(test_dsp_r1_maq_s_w_phl);
+    RUN_TEST(test_dsp_r1_maq_s_w_phr);
+    RUN_TEST(test_dsp_r1_maq_sa_w_phl);
+    RUN_TEST(test_dsp_r1_maq_sa_w_phr);
+    RUN_TEST(test_dsp_r1_madd);
+    RUN_TEST(test_dsp_r1_maddu);
+    RUN_TEST(test_dsp_r1_msub);
+    RUN_TEST(test_dsp_r1_msubu);
+    RUN_TEST(test_dsp_r1_mult);
+    RUN_TEST(test_dsp_r1_multu);
+    RUN_TEST(test_dsp_r2_dpa_w_ph);
+    RUN_TEST(test_dsp_r2_dpaqx_s_w_ph);
+    RUN_TEST(test_dsp_r2_dpaqx_sa_w_ph);
+    RUN_TEST(test_dsp_r2_dpax_w_ph);
+    RUN_TEST(test_dsp_r2_dps_w_ph);
+    RUN_TEST(test_dsp_r2_dpsqx_s_w_ph);
+    RUN_TEST(test_dsp_r2_dpsqx_sa_w_ph);
+    RUN_TEST(test_dsp_r2_dpsx_w_ph);
+    RUN_TEST(test_dsp_r2_mulsa_w_ph);
+    RUN_TEST(test_dsp_r2_mulsaq_s_w_ph);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
index a6425b6edc84..3818ba7c2a48 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
index cbf900713f33..56a3c2f6e1d1 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
index 6017b5e73ab2..b90a9e9e72cc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
index e4abb2e2af03..7828182f3151 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
index 74058fe7ecd0..14698262d589 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
index eda3b14e2be2..900f3f90bcb8 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
index 94e2bf625499..6958bbeb753b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
index a1e66356310d..f127d1662714 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_madd.c b/tests/tcg/mipsel/test_dsp_r1_madd.c
index af4bfcfe9df3..f724fd9a27c0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_madd.c
+++ b/tests/tcg/mipsel/test_dsp_r1_madd.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maddu.c b/tests/tcg/mipsel/test_dsp_r1_maddu.c
index af4bfcfe9df3..f724fd9a27c0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maddu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maddu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
index 0f7c070155a8..aa29fd5e3821 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
index 942722a530c2..42833686936c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
index d83dce6f3272..9dda4ebdbbe9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
index d2331118abb8..1b34664280dc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_msub.c b/tests/tcg/mipsel/test_dsp_r1_msub.c
index 5779e6f47ac7..74146284ffe2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msub.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msub.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_msubu.c b/tests/tcg/mipsel/test_dsp_r1_msubu.c
index e0f9b5a77ae3..2eb728af64b4 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msubu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msubu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mult.c b/tests/tcg/mipsel/test_dsp_r1_mult.c
index 15e6fde92c0e..c0509396de72 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mult.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mult.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_multu.c b/tests/tcg/mipsel/test_dsp_r1_multu.c
index 85d36c1b621a..1c8a7f1e01e7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_multu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_multu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
index fae49f10eb95..68eae5a08346 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
index ce8783024685..06b1a0a0d7e8 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
index d551d64ae293..6dd106d74cae 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
index 514797cfd1b4..a812c8a7f854 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
index f51f9b9d13d7..a656d219d89f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
index e40543fd8292..960f2bbbdf36 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
index 7da278eacc0e..68f20348c2c9 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
index bb49a4031d34..d85b504b402e 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
index a6940939ca50..842233b2785b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
index 06c91a43e7ea..c0f8e51ad389 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 1c2851f56369..c26f5fba06b7 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -8,31 +8,14 @@ tests_dsp = [
   'test_dsp_arith.c',
   'test_dsp_cmp.c',
   'test_dsp_ctrl.c',
+  'test_dsp_dot.c',
   'test_dsp_r1_bitrev.c',
-  'test_dsp_r1_dpaq_s_w_ph.c',
-  'test_dsp_r1_dpaq_sa_l_w.c',
-  'test_dsp_r1_dpau_h_qbl.c',
-  'test_dsp_r1_dpau_h_qbr.c',
-  'test_dsp_r1_dpsq_s_w_ph.c',
-  'test_dsp_r1_dpsq_sa_l_w.c',
-  'test_dsp_r1_dpsu_h_qbl.c',
-  'test_dsp_r1_dpsu_h_qbr.c',
   'test_dsp_r1_insv.c',
-  'test_dsp_r1_madd.c',
-  'test_dsp_r1_maddu.c',
-  'test_dsp_r1_maq_s_w_phl.c',
-  'test_dsp_r1_maq_s_w_phr.c',
-  'test_dsp_r1_maq_sa_w_phl.c',
-  'test_dsp_r1_maq_sa_w_phr.c',
-  'test_dsp_r1_msub.c',
-  'test_dsp_r1_msubu.c',
   'test_dsp_r1_muleq_s_w_phl.c',
   'test_dsp_r1_muleq_s_w_phr.c',
   'test_dsp_r1_muleu_s_ph_qbl.c',
   'test_dsp_r1_muleu_s_ph_qbr.c',
   'test_dsp_r1_mulq_rs_ph.c',
-  'test_dsp_r1_mult.c',
-  'test_dsp_r1_multu.c',
   'test_dsp_r1_packrl_ph.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
@@ -70,21 +53,11 @@ tests_dsp = [
   'test_dsp_r1_shrlv_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_dpa_w_ph.c',
-  'test_dsp_r2_dpaqx_s_w_ph.c',
-  'test_dsp_r2_dpaqx_sa_w_ph.c',
-  'test_dsp_r2_dpax_w_ph.c',
-  'test_dsp_r2_dps_w_ph.c',
-  'test_dsp_r2_dpsqx_s_w_ph.c',
-  'test_dsp_r2_dpsqx_sa_w_ph.c',
-  'test_dsp_r2_dpsx_w_ph.c',
   'test_dsp_r2_mul_ph.c',
   'test_dsp_r2_mul_s_ph.c',
   'test_dsp_r2_mulq_rs_w.c',
   'test_dsp_r2_mulq_s_ph.c',
   'test_dsp_r2_mulq_s_w.c',
-  'test_dsp_r2_mulsa_w_ph.c',
-  'test_dsp_r2_mulsaq_s_w_ph.c',
   'test_dsp_r2_precr_qb_ph.c',
   'test_dsp_r2_precr_sra_ph_w.c',
   'test_dsp_r2_precr_sra_r_ph_w.c',
-- 
2.55.0


