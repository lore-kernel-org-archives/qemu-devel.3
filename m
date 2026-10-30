Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07834606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OMKiIvri;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HjsXXl9E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqsP-0001MT-9e; Fri, 30 Oct 2026 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqT-0008C8-Le
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:57:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqqR-0008IM-38
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:56:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu57I2414431
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nIdTSnbDPwBoWrYvddDmoPQ/avQDUjcefX+hHH6Ng64=; b=OMKiIvri4sTaWkru
 Qnjl7ClM5KE9jukmoaMBlu4qBayrTvL2VEO/F+axveJUenMJOWH029cHWEJ+WWEk
 LumRge62S5f7NJMcOSf8C1/g34GodUtzgUECgAeeg7SM74bUumzrPI/e98e7hnGa
 jaRROAshol+P+mOd1gS474QyKzgd469kXuiWBjZolmqPx/fOUJwXAUwHAwnu6eb3
 wkp+vj1O/WV21Yi5Z6L8eng3qWwK8ZfV1wlg/NcAqcqvhNvPLK+Qbyn5xIsGST1A
 RyyqyHER0HLiPDF/nPskR0Wln9CDjkdGKiq2kOS0Ufum8nnDJGTriBq5YcBpXcL9
 AfkM7A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmbfe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:56:49 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc06b9ca9eso101538137.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793383008; x=1793987808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIdTSnbDPwBoWrYvddDmoPQ/avQDUjcefX+hHH6Ng64=;
 b=HjsXXl9Enn56vcYzB6ZinoGcc0ZQDmYV1TjTmUOmq7IUVHARpKoWu2lUT89z2VXhGw
 283VGrVIQnHIQblIi5Iu5G/5r8uyWfkhgv5NrKXmztg3uDewzzeU9B1q6C2I5QeTxId0
 WD3bw5qnvJNKk3WZANNEsQT6sujyvOs/o7r09xcynQfX7i0RJetJWkTSAf/U8fbQJnON
 RwZf7Y3vTI5fwZH32UrDpZfsF6rTV0GD+UkZx8fy8mj8Snd8hT8KBIBGNw4MMT/Tlq8P
 dJUhpHtPdJMNMablY8sJgApiEJw56EBxXIHW6PklFALJ6y+r/e6uESUm3HBlLmZho0OV
 2y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793383008; x=1793987808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nIdTSnbDPwBoWrYvddDmoPQ/avQDUjcefX+hHH6Ng64=;
 b=1pGpKLp5Nqvk0tCR8+pdudc1Q1Kdl+XmQ3aUuibhtSgqurK4Rbv/C+tCgzDztTr62m
 0piAZQxfBDAvjuOqeCNxfzL7bYrS2yEiWq4NObA13Jgvxw4zzmPFIG0Y2vsh1e7XcJDi
 f7fVZCciORSjsPsZZ1Jepoqsz7cj5DkXqAGQ4IhWYDjNlqFTqnEbTDUt4O0lx3YZCYP+
 uW3nIRryOB9RJWZWPVBs2KNFCxoyLKZSi3pVYSmMzu50sHyRV6piBKIU/X0L1O7d9M0T
 I2PMP55nvhUzXHNboFN6gE/6Fh5bWEKM8fzVYnlnHsmRKnGOWTcgLh0srx4y+0p6PoNU
 lgxw==
X-Gm-Message-State: AFq9FYLjoLH7+hBJiwpZRGSF9AAIFftMgtjZIJmmSVW5/CJsNAt9cd0N
 ZB9L4MoXguaY19oAeyFp0bHEmNaI+008fEnU+eQ4bg1cPSoiga6OqcFEuV1+Iz2CKolFU29tAA2
 LxJrJkJKxsVNOzWEYOhKqc+/EJO0miNtVVrKR/tFf9rqsaFP98gY8C555V4/KBNtz7XIq
X-Gm-Gg: AYBFou2QAx9mGX6K9z3nkvxUCN7BJvMX/MThED0M7BsdUoPE10Wpxg6ww5Rdz++Psq+
 UzKw6+RyWRVpqm98a7jyCGzu0ki8QKn/kYsjz2hysGmHQ+BFf2nKPVTXd+SxHvDWBZ15xopJ38N
 JYhxl/suFoGIgis8DK6yEe7fh7E2bNAVF1LRDunXzGOeg1FGn+T5aL+fLljfxlflSTpHl5jJEg9
 hO7EMuQ1TcV/AkpPEXRLujX3ZDNbBz/YxG/Oj1tvJq8tMDteJCzIsQR08NXoeu9IFklTWeN3YMQ
 JdTjeqGKNeYXJXO54pTnWx3+IBPbIrnyk0fA0v5bZM+83v0keoWkweHh48BAiKID3pKr1TAD4Dp
 8GaTyCiOT520lii52gMPgu2Qg8u7pcRUe7KKrF3zt4I9weegPcwQRN8IZu6dcQspGbF44FBck0G
 Am9ZRJ6TFlga41FbSc7tl+FcxYFq4YxQ==
X-Received: by 2002:a05:6102:d90:b0:7cc:ccb:ce5a with SMTP id
 ada2fe7eead31-7d07269ca5cmr1456190137.28.1793383008377; 
 Fri, 30 Oct 2026 10:56:48 -0700 (PDT)
X-Received: by 2002:a05:6102:d90:b0:7cc:ccb:ce5a with SMTP id
 ada2fe7eead31-7d07269ca5cmr1456177137.28.1793383007826; 
 Fri, 30 Oct 2026 10:56:47 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a4csm4459597f8f.23.2026.10.30.10.56.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:56:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 20/32] tests/tcg/mips: Group MSA int-add tests
Date: Fri, 30 Oct 2026 18:53:42 +0100
Message-ID: <20261030175357.99684-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXz/qLV/zXLL6Q
 1iMDeX26dLPH0XzN/KUiuMcQ3E4QnTScgu6Rd7G07zw6nQ54zwty28Wek0BnUlpYrqWv7ZBKsO2
 ob/yrlXixCot8DfsVbPo3hS3Iin9NFEkf9/eNVs5cVXpjWshrvziaBlbP6WbWw1aL50ZnHU+ARn
 hiU0jrS7iB9Z4JBafkC4gr8r2HnA98fe1v3IC9BQNoCyIHAcglSn/fZk5WApv0z1NSD6kVkWrsK
 BzLWjlXYMfiuAMr8hz4LZkZfSlwZKB0jxh3K78cbjgiJYBC3Pcn3zjk7QC14E12xiOCXebJxi1n
 hTpheIGXAD035uy4xhCG1HM41ROAAM8uc5XQh3vCNSilhvkaPQHFCUrPi+jvwmsNmQrUTP81i4w
 T6bwQiMAHRTzBbFt9Mh8tREy2Q9q0B4dS/2/vwAxvaL3GXget/QI5SJhSSO27teDhEucbeUaMkc
 iiCDWNHAeaL6dogztLw==
X-Proofpoint-ORIG-GUID: mox7x64O48j5NEn_Wl2DCH6Kx_lYNpJW
X-Proofpoint-GUID: mox7x64O48j5NEn_Wl2DCH6Kx_lYNpJW
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4da61 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=31ySfBESk6nFzokIpWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXx1mbRm0rbrP+
 i0FqzWWe0t4QW8Q+wQyHyUj+pSNWNxkaipOC1Rtl7GI30G8bqyDBqrzvSl6KV5kEaQql3n74iJZ
 R+7xAlfsJXdeWLTLV6zUTZIA8ROvXLQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Build the 26 per-opcode int-add tests as a single executable,
test_msa_int_add.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_add.c | 183 ++++++++++++++++++++++++++++++
 tests/tcg/mips/meson.build        |  27 +----
 2 files changed, 184 insertions(+), 26 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_add.c

diff --git a/tests/tcg/mips/test_msa_int_add.c b/tests/tcg/mips/test_msa_int_add.c
new file mode 100644
index 000000000000..c29663c1bfa7
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_add.c
@@ -0,0 +1,183 @@
+/*
+ * MIPS MSA tests: Int Add instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "../include/tap.h"
+
+#define main test_msa_add_a_b
+#include "user/ase/msa/int-add/test_msa_add_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_d
+#include "user/ase/msa/int-add/test_msa_add_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_h
+#include "user/ase/msa/int-add/test_msa_add_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_add_a_w
+#include "user/ase/msa/int-add/test_msa_add_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_b
+#include "user/ase/msa/int-add/test_msa_adds_a_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_d
+#include "user/ase/msa/int-add/test_msa_adds_a_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_h
+#include "user/ase/msa/int-add/test_msa_adds_a_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_a_w
+#include "user/ase/msa/int-add/test_msa_adds_a_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_b
+#include "user/ase/msa/int-add/test_msa_adds_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_d
+#include "user/ase/msa/int-add/test_msa_adds_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_h
+#include "user/ase/msa/int-add/test_msa_adds_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_s_w
+#include "user/ase/msa/int-add/test_msa_adds_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_b
+#include "user/ase/msa/int-add/test_msa_adds_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_d
+#include "user/ase/msa/int-add/test_msa_adds_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_h
+#include "user/ase/msa/int-add/test_msa_adds_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_adds_u_w
+#include "user/ase/msa/int-add/test_msa_adds_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_b
+#include "user/ase/msa/int-add/test_msa_addv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_d
+#include "user/ase/msa/int-add/test_msa_addv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_h
+#include "user/ase/msa/int-add/test_msa_addv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_addv_w
+#include "user/ase/msa/int-add/test_msa_addv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_d
+#include "user/ase/msa/int-add/test_msa_hadd_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_h
+#include "user/ase/msa/int-add/test_msa_hadd_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_s_w
+#include "user/ase/msa/int-add/test_msa_hadd_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_d
+#include "user/ase/msa/int-add/test_msa_hadd_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_h
+#include "user/ase/msa/int-add/test_msa_hadd_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hadd_u_w
+#include "user/ase/msa/int-add/test_msa_hadd_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "add.a.b", test_msa_add_a_b },
+    { "add.a.d", test_msa_add_a_d },
+    { "add.a.h", test_msa_add_a_h },
+    { "add.a.w", test_msa_add_a_w },
+    { "adds.a.b", test_msa_adds_a_b },
+    { "adds.a.d", test_msa_adds_a_d },
+    { "adds.a.h", test_msa_adds_a_h },
+    { "adds.a.w", test_msa_adds_a_w },
+    { "adds.s.b", test_msa_adds_s_b },
+    { "adds.s.d", test_msa_adds_s_d },
+    { "adds.s.h", test_msa_adds_s_h },
+    { "adds.s.w", test_msa_adds_s_w },
+    { "adds.u.b", test_msa_adds_u_b },
+    { "adds.u.d", test_msa_adds_u_d },
+    { "adds.u.h", test_msa_adds_u_h },
+    { "adds.u.w", test_msa_adds_u_w },
+    { "addv.b", test_msa_addv_b },
+    { "addv.d", test_msa_addv_d },
+    { "addv.h", test_msa_addv_h },
+    { "addv.w", test_msa_addv_w },
+    { "hadd.s.d", test_msa_hadd_s_d },
+    { "hadd.s.h", test_msa_hadd_s_h },
+    { "hadd.s.w", test_msa_hadd_s_w },
+    { "hadd.u.d", test_msa_hadd_u_d },
+    { "hadd.u.h", test_msa_hadd_u_h },
+    { "hadd.u.w", test_msa_hadd_u_w },
+};
+
+int main(void)
+{
+    unsigned i;
+
+    TAP_START();
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        tap_report(!msa_tests[i].fn(), "MSA %s %s",
+                   "Int Add", msa_tests[i].name);
+    }
+
+    return tap_done();
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 5e14bc3197a5..7ef3d6aafa8a 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -7,6 +7,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_bit_set.c',
   '../mips/test_msa_fixed_multiply.c',
   '../mips/test_msa_float_max_min.c',
+  '../mips/test_msa_int_add.c',
 ]
 
 tests += tcg_tests['multiarch-linux-user']['tests']
@@ -94,32 +95,6 @@ tests_mips_msa = [
   '../mips/user/ase/msa/int-divide/test_msa_div_u_w.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_h.c',
   '../mips/user/ase/msa/int-divide/test_msa_div_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_b.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_s_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_addv_h.c',
-  '../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_add_a_d.c',
-  '../mips/user/ase/msa/int-add/test_msa_adds_u_w.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
-- 
2.55.0


