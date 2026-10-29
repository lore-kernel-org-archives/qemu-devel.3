Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OozNkgKK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NyCJ6wLP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTu3-0000zc-1n; Thu, 29 Oct 2026 13:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTta-00009U-Hy
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTtY-0001Wg-6U
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:26:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDGGv227429
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2/1X2koRdv9BV1bTk7DednRFVPibMyNv4NIY/+LVGJA=; b=OozNkgKKiXlt0KV1
 IYDM22gWlprZOBpRw+/VA3XVSsGJTvvLes0aQU1x7KcbMgWCoZEOoNN3fRlRjlfo
 inxXplQLUELE24WGods6rB3UrgIz5tP6jE/jacNdGox6mZDwYlS1Wj0Y+Cziqllr
 aMg8LNjJgA0BDHgsv5TBhlHGfhS8Uv4MIjLE+ugKTtxvoQd7hIey93Ex4p7KMuDl
 QVEizQSt66ex+mdzU/b+yKAXgqQyCcufoiTenEcfS9tyg1THzsBLm3wB62R3ZuLW
 iNKlwuWr+0YcqF61xM701I+g9masddjFiEreHn++lCFfDzCu1QmMtO6FeGNqIBdb
 jyosOg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fjae3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so421125085a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294790; x=1793899590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/1X2koRdv9BV1bTk7DednRFVPibMyNv4NIY/+LVGJA=;
 b=NyCJ6wLP21Uww8emLD8ctGbVjFHifGHx3hNLMIgJqj8SfK+4AK4DkCuuBEjDDHS/t/
 YBXPhqcYN9RqPAS9bfz3egrsdCySi0wv/nlwjtb49ljRa9+EcBTM+7LcJBksOkUbbprn
 1vvK/u/wSeF+mJgFU3idLNZCrPQCu5hWXuRGFhcZVYZtHMtjnN1YuMjmCIV8WOb5pr74
 4gx9ykJAM8R1gQeZBXBkRLGsWfUe3m/WmEXUmhAT5Oc8EWXdqjDaaQwOtt68+/wrTdA2
 NjYQ875XXuVwW009M7vvhNevcK94ySISrdWWRn1xiflMsCt9rRZmgguThuTUD4qEDu1G
 2OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294790; x=1793899590;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2/1X2koRdv9BV1bTk7DednRFVPibMyNv4NIY/+LVGJA=;
 b=qHO0f2dj6O9rQRfI9WLtCyXB5DLQvETr5lCIZYg9xLiUluUqmjfuc9l79bVexXd1Yj
 LxEIGIBZPxOYbu8ge1uBRxDS7p2EDQCvNIK9EPcrvSoRtRONPxsCV5ia0eVtPWV9Gixw
 2NKgq049SbKF50FQvyQPtd+KsMqG0+5u/Ppng3xntZEubL036U9fcyvTXt4hinLrK+y/
 rJL6JLbAheemSYd06Igg8yYc4z1UDbWzKsM+buZeNCQEXFD2b4KJtu5s7sxfZfBzGqrd
 HRnlZJG2gkyCdpFYtjrGHD3w1toN0Jh5IYMIKAd3/VF1PUSdHer5OCJcvrramRfxxhck
 ksVA==
X-Gm-Message-State: AFq9FYL+qvMrgu7z6VSF3B2t+sJm8PK2cWXc4yQ3bqjQ//R67VsEfLI1
 XekvJcjpABEdHLHgTB0PoAhanMDHdhaqb5y5i283X2eyuiCveOdRpShn6cU1AWZkgDH346+RIOY
 1Up6dGX/ZUGerCDBKYw4Ac1MquH7xSABW4d3XET+7gfHs9xi56GWpo6sjVYcvsg6tyWP/
X-Gm-Gg: AYBFou1wx8DiAbQ/Iv+EYHsPT5A6dfpd/bHzK/5OUOb+nfl3VpWM6dUjdXB8aO50EsJ
 Ip18/EKAEjeA0unV8T2/udcdZcJ4qR7gXk4KT5hEbmLnSMggawffAn8EhTTOOal+/bjZSyu5D3n
 fJ4FZgZHz5KbtjgTWhU8+55xzdHfEws2U6gtjW5mN8SzvWtVKr1gd3YGOxHE5UucgGTwbVzHeW7
 uIce3ZqMXTVE9HjJszOmgI9jMVGaEkg9WHnBgqc2FzhhLg1dEA+GN+tfZeIH/mbqzPMXjRqDIje
 sSYDojwOueULoJloV+e1Xv5tK3BqTDEFnVtNfBomM++Gzj6jhQ0EFyFtVpCBGNR++FpAdlCf6Wt
 AK9al6xH6K9EM7NtrD1Abd+EaTb2TnO2/qPgOA+mj5BtmvwXWpB5jLMZdvPuzEqZy6F0zVzLImV
 h9Bj6rkVWPFhgd8sKFTN5LKzO/R6ZiVg==
X-Received: by 2002:a05:620a:2849:b0:93e:5821:2c5c with SMTP id
 af79cd13be357-94408cf1bf6mr935084185a.60.1793294790276; 
 Thu, 29 Oct 2026 10:26:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2849:b0:93e:5821:2c5c with SMTP id
 af79cd13be357-94408cf1bf6mr935080285a.60.1793294789786; 
 Thu, 29 Oct 2026 10:26:29 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896fesm88608755e9.10.2026.10.29.10.26.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:26:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 26/31] tests/tcg/mips: Group MSA int-subtract tests
Date: Thu, 29 Oct 2026 18:23:10 +0100
Message-ID: <20261029172319.25766-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX/DEa7qjUvAIA
 Rtrg46hVoetocQbgud8pC3x0e34lpJg+HBp9v6gbT67+cpAjSuxKw+EsGN7liwXscnx9Loz4PBI
 kkC4PIy0ZjW7IHxFE0Qr9Dd2nObYDvf5TSW7cOcKMVBTvIgfEHTQWziv62KXTf13+DenCCNoZwN
 +zPriLybutCveS+h4uDkbhAChk6LYg01bKea2OFMaavfmj15bcMIaziXSoAhgoKVOqxoyFSBEs3
 iH2urW2j6gxZapbw3dORES0fWd2Z8UEedhGJ4SjRvVlbTFdBENPh0ozstfNhSTVukM0vgbCKNHQ
 +7/tWTi3CDe4ks4xiShXajhGFtT58LsJfxNijSjBpiyytR4JMajhtOQVnCogCQSymGanh4iKofJ
 s/Nnsrgk0SYwoBfBeByIWskBskHvjQ==
X-Proofpoint-GUID: eH-DQ5RadZPE6xHELhHyBeoE2kWA313-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX6AS9KcKB5iQx
 kpuN8f3JobZXCCboqFN8AUE3qEvJ4vDmP2BLVSA0Azm/sz6tgmxd4I8AyL3dDr79hwaSofCBYiU
 XgmroQTqp9TC2r2gHcir5VqCZAPNnS8=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae381c7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7vHfOIZg1pyXlvWAgzwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: eH-DQ5RadZPE6xHELhHyBeoE2kWA313-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Build the 34 per-opcode int-subtract tests as a single executable,
test_msa_int_subtract.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/test_msa_int_subtract.c | 235 +++++++++++++++++++++++++
 tests/tcg/mips/meson.build             |  34 ----
 tests/tcg/mips64/meson.build           |   1 +
 tests/tcg/mipsel/meson.build           |   1 +
 4 files changed, 237 insertions(+), 34 deletions(-)
 create mode 100644 tests/tcg/mips/test_msa_int_subtract.c

diff --git a/tests/tcg/mips/test_msa_int_subtract.c b/tests/tcg/mips/test_msa_int_subtract.c
new file mode 100644
index 000000000000..6837731cae85
--- /dev/null
+++ b/tests/tcg/mips/test_msa_int_subtract.c
@@ -0,0 +1,235 @@
+/*
+ * MIPS MSA tests: Int Subtract instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define main test_msa_asub_s_b
+#include "user/ase/msa/int-subtract/test_msa_asub_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_d
+#include "user/ase/msa/int-subtract/test_msa_asub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_h
+#include "user/ase/msa/int-subtract/test_msa_asub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_s_w
+#include "user/ase/msa/int-subtract/test_msa_asub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_b
+#include "user/ase/msa/int-subtract/test_msa_asub_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_d
+#include "user/ase/msa/int-subtract/test_msa_asub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_h
+#include "user/ase/msa/int-subtract/test_msa_asub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_asub_u_w
+#include "user/ase/msa/int-subtract/test_msa_asub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_d
+#include "user/ase/msa/int-subtract/test_msa_hsub_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_h
+#include "user/ase/msa/int-subtract/test_msa_hsub_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_s_w
+#include "user/ase/msa/int-subtract/test_msa_hsub_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_d
+#include "user/ase/msa/int-subtract/test_msa_hsub_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_h
+#include "user/ase/msa/int-subtract/test_msa_hsub_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_hsub_u_w
+#include "user/ase/msa/int-subtract/test_msa_hsub_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_b
+#include "user/ase/msa/int-subtract/test_msa_subs_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_d
+#include "user/ase/msa/int-subtract/test_msa_subs_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_h
+#include "user/ase/msa/int-subtract/test_msa_subs_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_s_w
+#include "user/ase/msa/int-subtract/test_msa_subs_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_b
+#include "user/ase/msa/int-subtract/test_msa_subs_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_d
+#include "user/ase/msa/int-subtract/test_msa_subs_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_h
+#include "user/ase/msa/int-subtract/test_msa_subs_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subs_u_w
+#include "user/ase/msa/int-subtract/test_msa_subs_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_b
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_d
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_h
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsus_u_w
+#include "user/ase/msa/int-subtract/test_msa_subsus_u_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_b
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_d
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_h
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subsuu_s_w
+#include "user/ase/msa/int-subtract/test_msa_subsuu_s_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_b
+#include "user/ase/msa/int-subtract/test_msa_subv_b.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_d
+#include "user/ase/msa/int-subtract/test_msa_subv_d.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_h
+#include "user/ase/msa/int-subtract/test_msa_subv_h.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+#define main test_msa_subv_w
+#include "user/ase/msa/int-subtract/test_msa_subv_w.c"
+#undef main
+#undef TEST_COUNT_TOTAL
+
+
+static const struct {
+    const char *name;
+    int32_t (*fn)(void);
+} msa_tests[] = {
+    { "asub.s.b", test_msa_asub_s_b },
+    { "asub.s.d", test_msa_asub_s_d },
+    { "asub.s.h", test_msa_asub_s_h },
+    { "asub.s.w", test_msa_asub_s_w },
+    { "asub.u.b", test_msa_asub_u_b },
+    { "asub.u.d", test_msa_asub_u_d },
+    { "asub.u.h", test_msa_asub_u_h },
+    { "asub.u.w", test_msa_asub_u_w },
+    { "hsub.s.d", test_msa_hsub_s_d },
+    { "hsub.s.h", test_msa_hsub_s_h },
+    { "hsub.s.w", test_msa_hsub_s_w },
+    { "hsub.u.d", test_msa_hsub_u_d },
+    { "hsub.u.h", test_msa_hsub_u_h },
+    { "hsub.u.w", test_msa_hsub_u_w },
+    { "subs.s.b", test_msa_subs_s_b },
+    { "subs.s.d", test_msa_subs_s_d },
+    { "subs.s.h", test_msa_subs_s_h },
+    { "subs.s.w", test_msa_subs_s_w },
+    { "subs.u.b", test_msa_subs_u_b },
+    { "subs.u.d", test_msa_subs_u_d },
+    { "subs.u.h", test_msa_subs_u_h },
+    { "subs.u.w", test_msa_subs_u_w },
+    { "subsus.u.b", test_msa_subsus_u_b },
+    { "subsus.u.d", test_msa_subsus_u_d },
+    { "subsus.u.h", test_msa_subsus_u_h },
+    { "subsus.u.w", test_msa_subsus_u_w },
+    { "subsuu.s.b", test_msa_subsuu_s_b },
+    { "subsuu.s.d", test_msa_subsuu_s_d },
+    { "subsuu.s.h", test_msa_subsuu_s_h },
+    { "subsuu.s.w", test_msa_subsuu_s_w },
+    { "subv.b", test_msa_subv_b },
+    { "subv.d", test_msa_subv_d },
+    { "subv.h", test_msa_subv_h },
+    { "subv.w", test_msa_subv_w },
+};
+
+int main(void)
+{
+    int fail = 0;
+    unsigned i;
+
+    printf("TAP version 14\n"
+           "1..%u\n",
+           (unsigned)(sizeof(msa_tests) / sizeof(msa_tests[0])));
+    for (i = 0; i < sizeof(msa_tests) / sizeof(msa_tests[0]); i++) {
+        int r = msa_tests[i].fn();
+
+        printf("%s %u - MSA %s %s\n", r ? "not ok" : "ok", i + 1,
+               "Int Subtract", msa_tests[i].name);
+        fail |= r;
+    }
+
+    return fail ? 1 : 0;
+}
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 5d5bcd106ca0..c033e7a5500f 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -23,40 +23,6 @@ if 'qemu-mips' in emulators
 endif
 
 tests_mips_msa = [
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subv_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c',
-  '../mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_b.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvr_d.c',
   '../mips/user/ase/msa/interleave/test_msa_ilvod_b.c',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index ba94fb6a68ec..40ad347fa2ff 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -52,6 +52,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_dot_product.c',
   '../mips/test_msa_int_max_min.c',
   '../mips/test_msa_int_multiply.c',
+  '../mips/test_msa_int_subtract.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index ef30568ab5f5..cd3700e5e84b 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -53,6 +53,7 @@ tests_mips_msa_groups = [
   '../mips/test_msa_int_dot_product.c',
   '../mips/test_msa_int_max_min.c',
   '../mips/test_msa_int_multiply.c',
+  '../mips/test_msa_int_subtract.c',
 ]
 
 foreach src: tests_mips_msa + tests_mips_msa_groups
-- 
2.55.0


