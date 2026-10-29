Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089B606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IdSJGadg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C60bIfT2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTqr-0005VM-Fr; Thu, 29 Oct 2026 13:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTqo-0005Se-SP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTql-00011z-S3
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:23:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDPfd594481
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fRKXX9bqNzAvYeKFTRVs0sM4WOHFAnJxowXWesCDPAM=; b=IdSJGadgh6ZO4Dd+
 W6LZnyxFCFitOoKzFJ8WGeXFrBq/9RS7nT5U04ELIczYd6EwZcW8YrNJegMLdZBt
 RQif+i5lKXA4RlYplRFBcmoOBgOc1k4SEd2L+hX5z+N3NRQndUYKPe4e8q/oaXHl
 5gDgTynEok3w5/tS9VT+wFTUp4aJVt4O36OqP9+pLAZWzPEtBGOhZYjfwHboUfVS
 6LoWEsk02+JGYDJi9iqGRw1PvQEjLK7w5P6gifc+XpcbpYF8s7hB3sCxFdX/7D+o
 jOIibY4V1faiibFFYdGexwJOU+ZMeVZ3tnCLSYykv4BQeQxPviPCRLg2lUVI6Kf1
 434/Ww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3kpf0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:23:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so426423685a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294617; x=1793899417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fRKXX9bqNzAvYeKFTRVs0sM4WOHFAnJxowXWesCDPAM=;
 b=C60bIfT2190w8CsOw892xxYDy/SDKwEneeMq5JHeKlwRDPqkRsOpq+KW6eal/pnyXM
 uHIdbgzx8lRFKXAC1RyNoMB5qblWKTPqvTlKWYJdhZR12eBKtejvw4UUCq2AuVjo9wY1
 fvGzqyMl/zXsULcXE4epmtc0WGTCPyAZhm8q4hN5dmIukJu1KcsaV/+g2pW9tPs4/+qa
 CusHNTGp3p3FjAs+AVR2DgxzIUEjH6GyFfacPq3K+C0YfBxscvEU1eZJHCLVk45UKnlR
 BNw+tuASVjWfJichkwDxXqDMdkx2Huo8AY0a0jXdZ+k84PF/THCJIqHl2kNghQoOvQ7A
 2QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294617; x=1793899417;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fRKXX9bqNzAvYeKFTRVs0sM4WOHFAnJxowXWesCDPAM=;
 b=nFxcv9OyZHI/Bs01rJSKiWVhTuNGPfWhidUCf2SsKLdvjAUkFxgbEZewBeXU9G298z
 Hb2AX3YLz5aSy0kdoPGmPGfj5FUSNfDmqh39PwKhVOeWyUFPTsJn8bsJU48+waDe0pon
 a/N1f6QU0eVWKxybR2go+pLud9YI45IaVEcvXM8yET/fT8BG+U2QjCeJf4NXnbin77hJ
 W0A6j0y6L2DcXlLfv+/tHb9rjd11V0e7Up0qNB7YKNEDzaoa7W7c/5EqWI+/2Iv5wSG4
 vaeyQMiE4g6Q+lUznN5UkYUx3AmLLhJaRdmZgUWgA+ydM7Uvc+Vb+G+77BANMMLsOSKC
 YJkg==
X-Gm-Message-State: AFq9FYIPrYGCAXHElerwwG9c8MLh/AOwQqkesWsveKCpW9vgoDsCB3/h
 G3TE37u8ZRDF0OX2R3QgEZxE0gpmB6mU+r/N/bE0TEkRvcO28/2gB8PUyxOJWa6B6ZSzmYLSj3j
 Cg41ErcShHntmVO706eKipzHMXwHUPD5shMIr5VXxm6jZ7JImGehsmXN6AqcO9wnr/KCh
X-Gm-Gg: AYBFou0fkbPO9LKdMTsOzG8Q2XWx2GNVIkBOvrqrQgDUuDCdHUWZ8rT0n/BzvnGeKwN
 ac101eRSLk/CGSgoK88T6X0wLLG8js1xw6LU+1Gbbua5XMLvKWGQgjKSsaatGLIvnGfiSxEpVQ9
 HTvX0m52g+Wk95oWKRNH4d5f85IV6WEAew2wJRXwC7N8YYWuFRnWAJnE+8gw7ijttwsjdcs1tMi
 ILal/xKIWV9jACU6g94qZ3uNYMmapf3Ms955hZfCZgJPPlRxOymc2HrnMl9SXTqfL8mrvJaQFvU
 UZ61y1ChxwV/zGHBphuoS4mN3rQ7WEy5UQS3QwQ1woxy3CT6EVEElSX4TVAbykVORIZfzDeL8fo
 WFyISRRS8dWCLaVWKAtpRax8X1JZWEYluQqYitbuSlR4lHVit2cwL6g2t93LEqxtSRzKwpZpLq3
 IJHmHtqQbs6RP6VHYd6d9NMiub2puJwg==
X-Received: by 2002:a05:620a:40c2:b0:93e:96cb:3083 with SMTP id
 af79cd13be357-94408c943f9mr930354985a.33.1793294616860; 
 Thu, 29 Oct 2026 10:23:36 -0700 (PDT)
X-Received: by 2002:a05:620a:40c2:b0:93e:96cb:3083 with SMTP id
 af79cd13be357-94408c943f9mr930348285a.33.1793294616155; 
 Thu, 29 Oct 2026 10:23:36 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81b7fe80sm89156675e9.11.2026.10.29.10.23.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:23:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 02/31] tests/tcg/mips: Group DSP arith tests
Date: Thu, 29 Oct 2026 18:22:46 +0100
Message-ID: <20261029172319.25766-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX7A7HPJ2nf3iA
 nbQbxoqipDNsFzBldbwRzFxXn1X06FtLQjx7gZV2AfWKshi670CYS8Sw77yACk70MvzYtaP8yVc
 MQzDF3EHbL6E/CVH4cIjWEaUfksWK7w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX9/OKQKp4CY18
 WBgiugWECyhigYou1LelT2Jf+agWhSexjwczY56FKjnNJj8hjnlYuW546A3ew8hcYndO3jT1BmE
 qa82dUR4qUnHxSOuj5udWLIIDajAk1VHNr7iM5YbHOBINUwHEUtbLQa6wHVc2YK1dts7mEzh597
 3kTv6DdRaQMMLCMLs14lwjZ5Dem3tbg+g+hEG5u8xQb4m/FgOvg3RFnYXvHtH0Ax8xX3iqAFpSw
 kKyHFFteHBbaXM+IbyDGcGBYLvx/YB9uc+18OEx+swuOc+Ps6cBEFUL1/lMUnXqEmqXTwoiou3C
 LLqDbk+2OuRgP9/LEwU5Yik5bcRoNyF+2Uz/8OaEZWDnQ8TlmpMxyy9ppMFpp5vGkt5MaUOHYpl
 w6o4B1EUrEDUMM409vjaamv53PBwNDM3D/zSaZtLxoQASnRm9kpsjqiAGPt30FBsM9e8Qz0U5sV
 mrKtQEhqqPkKn/t31kA==
X-Proofpoint-ORIG-GUID: oy2K8Npr7IYSyzneZBL4lSj18Tbbdk3p
X-Proofpoint-GUID: oy2K8Npr7IYSyzneZBL4lSj18Tbbdk3p
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae3811a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=QcVZmDX5zYVA5dVMsrUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Build the 33 per-opcode arith tests as a single executable,
test_dsp_arith.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_arith.c         | 182 ++++++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_absq_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_addq_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_addsc.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_addwc.c      |   1 -
 tests/tcg/mipsel/test_dsp_r1_modsub.c     |   1 -
 tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_subq_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_addqh_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_subqh_w.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c |   1 -
 tests/tcg/mipsel/meson.build              |  34 +---
 35 files changed, 183 insertions(+), 66 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_arith.c

diff --git a/tests/tcg/mipsel/test_dsp_arith.c b/tests/tcg/mipsel/test_dsp_arith.c
new file mode 100644
index 000000000000..dd01ceea057b
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_arith.c
@@ -0,0 +1,182 @@
+/*
+ * MIPS DSP ASE tests: Add, Subtract and Absolute value instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_absq_s_ph
+#include "test_dsp_r1_absq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_absq_s_w
+#include "test_dsp_r1_absq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_addq_ph
+#include "test_dsp_r1_addq_ph.c"
+#undef main
+
+#define main test_dsp_r1_addq_s_ph
+#include "test_dsp_r1_addq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_addq_s_w
+#include "test_dsp_r1_addq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_addsc
+#include "test_dsp_r1_addsc.c"
+#undef main
+
+#define main test_dsp_r1_addu_qb
+#include "test_dsp_r1_addu_qb.c"
+#undef main
+
+#define main test_dsp_r1_addu_s_qb
+#include "test_dsp_r1_addu_s_qb.c"
+#undef main
+
+#define main test_dsp_r1_addwc
+#include "test_dsp_r1_addwc.c"
+#undef main
+
+#define main test_dsp_r1_modsub
+#include "test_dsp_r1_modsub.c"
+#undef main
+
+#define main test_dsp_r1_raddu_w_qb
+#include "test_dsp_r1_raddu_w_qb.c"
+#undef main
+
+#define main test_dsp_r1_subq_ph
+#include "test_dsp_r1_subq_ph.c"
+#undef main
+
+#define main test_dsp_r1_subq_s_ph
+#include "test_dsp_r1_subq_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_subq_s_w
+#include "test_dsp_r1_subq_s_w.c"
+#undef main
+
+#define main test_dsp_r1_subu_qb
+#include "test_dsp_r1_subu_qb.c"
+#undef main
+
+#define main test_dsp_r1_subu_s_qb
+#include "test_dsp_r1_subu_s_qb.c"
+#undef main
+
+#define main test_dsp_r2_absq_s_qb
+#include "test_dsp_r2_absq_s_qb.c"
+#undef main
+
+#define main test_dsp_r2_addqh_ph
+#include "test_dsp_r2_addqh_ph.c"
+#undef main
+
+#define main test_dsp_r2_addqh_r_ph
+#include "test_dsp_r2_addqh_r_ph.c"
+#undef main
+
+#define main test_dsp_r2_addqh_r_w
+#include "test_dsp_r2_addqh_r_w.c"
+#undef main
+
+#define main test_dsp_r2_addqh_w
+#include "test_dsp_r2_addqh_w.c"
+#undef main
+
+#define main test_dsp_r2_addu_ph
+#include "test_dsp_r2_addu_ph.c"
+#undef main
+
+#define main test_dsp_r2_addu_s_ph
+#include "test_dsp_r2_addu_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_adduh_qb
+#include "test_dsp_r2_adduh_qb.c"
+#undef main
+
+#define main test_dsp_r2_adduh_r_qb
+#include "test_dsp_r2_adduh_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_subqh_ph
+#include "test_dsp_r2_subqh_ph.c"
+#undef main
+
+#define main test_dsp_r2_subqh_r_ph
+#include "test_dsp_r2_subqh_r_ph.c"
+#undef main
+
+#define main test_dsp_r2_subqh_r_w
+#include "test_dsp_r2_subqh_r_w.c"
+#undef main
+
+#define main test_dsp_r2_subqh_w
+#include "test_dsp_r2_subqh_w.c"
+#undef main
+
+#define main test_dsp_r2_subu_ph
+#include "test_dsp_r2_subu_ph.c"
+#undef main
+
+#define main test_dsp_r2_subu_s_ph
+#include "test_dsp_r2_subu_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_subuh_qb
+#include "test_dsp_r2_subuh_qb.c"
+#undef main
+
+#define main test_dsp_r2_subuh_r_qb
+#include "test_dsp_r2_subuh_r_qb.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    RUN_TEST(test_dsp_r1_absq_s_ph);
+    RUN_TEST(test_dsp_r1_absq_s_w);
+    RUN_TEST(test_dsp_r1_addq_ph);
+    RUN_TEST(test_dsp_r1_addq_s_ph);
+    RUN_TEST(test_dsp_r1_addq_s_w);
+    RUN_TEST(test_dsp_r1_addsc);
+    RUN_TEST(test_dsp_r1_addu_qb);
+    RUN_TEST(test_dsp_r1_addu_s_qb);
+    RUN_TEST(test_dsp_r1_addwc);
+    RUN_TEST(test_dsp_r1_modsub);
+    RUN_TEST(test_dsp_r1_raddu_w_qb);
+    RUN_TEST(test_dsp_r1_subq_ph);
+    RUN_TEST(test_dsp_r1_subq_s_ph);
+    RUN_TEST(test_dsp_r1_subq_s_w);
+    RUN_TEST(test_dsp_r1_subu_qb);
+    RUN_TEST(test_dsp_r1_subu_s_qb);
+    RUN_TEST(test_dsp_r2_absq_s_qb);
+    RUN_TEST(test_dsp_r2_addqh_ph);
+    RUN_TEST(test_dsp_r2_addqh_r_ph);
+    RUN_TEST(test_dsp_r2_addqh_r_w);
+    RUN_TEST(test_dsp_r2_addqh_w);
+    RUN_TEST(test_dsp_r2_addu_ph);
+    RUN_TEST(test_dsp_r2_addu_s_ph);
+    RUN_TEST(test_dsp_r2_adduh_qb);
+    RUN_TEST(test_dsp_r2_adduh_r_qb);
+    RUN_TEST(test_dsp_r2_subqh_ph);
+    RUN_TEST(test_dsp_r2_subqh_r_ph);
+    RUN_TEST(test_dsp_r2_subqh_r_w);
+    RUN_TEST(test_dsp_r2_subqh_w);
+    RUN_TEST(test_dsp_r2_subu_ph);
+    RUN_TEST(test_dsp_r2_subu_s_ph);
+    RUN_TEST(test_dsp_r2_subuh_qb);
+    RUN_TEST(test_dsp_r2_subuh_r_qb);
+
+    DSP_TAP_PLAN();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
index aa8411202e20..ba32ddeeb498 100644
--- a/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_absq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 
 int main()
diff --git a/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
index 3f52a48039cd..699f1adf967e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_absq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
index 96a549637b41..4bb955a9565d 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
index 5f865f6cffd5..47b1c19e77d9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
index 1e13acf68fb9..bb3cbf836aa3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 
 int main()
diff --git a/tests/tcg/mipsel/test_dsp_r1_addsc.c b/tests/tcg/mipsel/test_dsp_r1_addsc.c
index ace749f667c4..f348a081e76e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addsc.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addsc.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addu_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
index 23ba2e90d1c9..b9c1cca392c6 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addu_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
index fe7fd3e6aa2d..4c2fcb9aedc9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addu_s_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_addwc.c b/tests/tcg/mipsel/test_dsp_r1_addwc.c
index 8a8d81fab4ca..71f9cf49c9e7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_addwc.c
+++ b/tests/tcg/mipsel/test_dsp_r1_addwc.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_modsub.c b/tests/tcg/mipsel/test_dsp_r1_modsub.c
index c294eebb519d..05278a2323cc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_modsub.c
+++ b/tests/tcg/mipsel/test_dsp_r1_modsub.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
index 77a983c0d20f..d131bd6ca7f3 100644
--- a/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_raddu_w_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
index fdd7b38b647e..19cc84d9fd17 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
index 64c89ebd5114..08742e926dea 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
index 9d456a90f417..9844b250d9d2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subu_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
index 420909615526..2ec61e819f02 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subu_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
index 3d650533d171..2ce247cd7a86 100644
--- a/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_subu_s_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
index af4683f30475..9944cc18f075 100644
--- a/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_absq_s_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
index 921f0eaf33c7..82827f33f6e4 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
index 213ba3725006..064e2bbda707 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
index 75a75c50f32d..867fe0bc7f05 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addqh_w.c b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
index de6926ebbb72..2539e4c178ec 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addqh_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addu_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
index 1d7a25a2a773..a547341c8b58 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addu_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
index 979651bfc9ac..d47faece052e 100644
--- a/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_addu_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
index a1f5d631b52e..108a348456eb 100644
--- a/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_adduh_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
index 81e98c190d2b..892513a4af7c 100644
--- a/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_adduh_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
index dbc096734ceb..64c754777838 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
index 24ef0f1aeb91..717c3931e4df 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
index d460f8630fae..3d20a87b5a94 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subqh_w.c b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
index 42be3deb80a3..9d41911233c2 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subqh_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subu_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
index 0d39a017c79d..702eb141d833 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subu_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
index 8e4da4f3e544..86afcdc0d660 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subu_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
index 92cfc764b8c9..ae9ea3f72a36 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subuh_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
index dac81d47db60..fc90b9cce0e8 100644
--- a/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_subuh_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 77f210a47a70..e7e576ad6c19 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -5,15 +5,7 @@ tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests_dsp = [
   'test_dsp_acc.c',
-  'test_dsp_r1_absq_s_ph.c',
-  'test_dsp_r1_absq_s_w.c',
-  'test_dsp_r1_addq_ph.c',
-  'test_dsp_r1_addq_s_ph.c',
-  'test_dsp_r1_addq_s_w.c',
-  'test_dsp_r1_addsc.c',
-  'test_dsp_r1_addu_qb.c',
-  'test_dsp_r1_addu_s_qb.c',
-  'test_dsp_r1_addwc.c',
+  'test_dsp_arith.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_bposge32.c',
   'test_dsp_r1_cmp_eq_ph.c',
@@ -43,7 +35,6 @@ tests_dsp = [
   'test_dsp_r1_maq_s_w_phr.c',
   'test_dsp_r1_maq_sa_w_phl.c',
   'test_dsp_r1_maq_sa_w_phr.c',
-  'test_dsp_r1_modsub.c',
   'test_dsp_r1_msub.c',
   'test_dsp_r1_msubu.c',
   'test_dsp_r1_muleq_s_w_phl.c',
@@ -70,7 +61,6 @@ tests_dsp = [
   'test_dsp_r1_precrq_qb_ph.c',
   'test_dsp_r1_precrq_rs_ph_w.c',
   'test_dsp_r1_precrqu_s_qb_ph.c',
-  'test_dsp_r1_raddu_w_qb.c',
   'test_dsp_r1_rddsp.c',
   'test_dsp_r1_repl_ph.c',
   'test_dsp_r1_repl_qb.c',
@@ -92,21 +82,7 @@ tests_dsp = [
   'test_dsp_r1_shrav_r_w.c',
   'test_dsp_r1_shrl_qb.c',
   'test_dsp_r1_shrlv_qb.c',
-  'test_dsp_r1_subq_ph.c',
-  'test_dsp_r1_subq_s_ph.c',
-  'test_dsp_r1_subq_s_w.c',
-  'test_dsp_r1_subu_qb.c',
-  'test_dsp_r1_subu_s_qb.c',
   'test_dsp_r1_wrdsp.c',
-  'test_dsp_r2_absq_s_qb.c',
-  'test_dsp_r2_addqh_ph.c',
-  'test_dsp_r2_addqh_r_ph.c',
-  'test_dsp_r2_addqh_r_w.c',
-  'test_dsp_r2_addqh_w.c',
-  'test_dsp_r2_addu_ph.c',
-  'test_dsp_r2_addu_s_ph.c',
-  'test_dsp_r2_adduh_qb.c',
-  'test_dsp_r2_adduh_r_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
   'test_dsp_r2_cmpgdu_eq_qb.c',
@@ -137,14 +113,6 @@ tests_dsp = [
   'test_dsp_r2_shrav_r_qb.c',
   'test_dsp_r2_shrl_ph.c',
   'test_dsp_r2_shrlv_ph.c',
-  'test_dsp_r2_subqh_ph.c',
-  'test_dsp_r2_subqh_r_ph.c',
-  'test_dsp_r2_subqh_r_w.c',
-  'test_dsp_r2_subqh_w.c',
-  'test_dsp_r2_subu_ph.c',
-  'test_dsp_r2_subu_s_ph.c',
-  'test_dsp_r2_subuh_qb.c',
-  'test_dsp_r2_subuh_r_qb.c',
 ]
 
 foreach src: tests_dsp
-- 
2.55.0


