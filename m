Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FCA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b//MCg7g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kaJ89AMS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqoK-0005Vn-R5; Fri, 30 Oct 2026 13:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqns-0005TA-US
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqnq-0007nt-VQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:12 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERinZ3207520
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n8YHAI9iJOxJswDGOjyLG2qY0rvHHGV2vOgRiFmG0+M=; b=b//MCg7gz8LOv77g
 /coL/AcuG6H2+8bG/9cWSkpE1UohTeB6+k3MF3I1dcxkEDHQVQyo13IoMZxP1qjK
 WICERjM6dduAbirkmhzs/RH3amqAj+fDbWO3+ph9qp06faIExlG4ZjyktGDuzJVW
 MimM/bMALhFsWLTOstqkaKg/jJsOtslEEVWiI4a1TPPBKIM1Ij103TI2dMj6ioBq
 6DNVwovVh6Z/EZjwpr3O9mgOT/X+yhZsR2wKMWrHtx3JbaOhZcOtjr2L3NnbC0lM
 a1+iCtAxHSlODG5lw8oYFlylDpBPAU87ubaBQuczw1fxamK75zcEBZE/EnA0SUW+
 YCZT/w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmab3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so226718985a.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382848; x=1793987648; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n8YHAI9iJOxJswDGOjyLG2qY0rvHHGV2vOgRiFmG0+M=;
 b=kaJ89AMSncyUwGECVaVnvLb+AsqzvB4dsB7GYGXkqxGvSx1JcXkNKLDT6R+qGOr5AG
 AuILf86mXz6nXfyEZeFfdPE+XxSIrEcnRxxFUGSb1RRRpCt3b3Z2ngeBEtR9L5/F4cZ0
 w8xHnh41O+0fKWxyuAvVYOZC84LOTt5gTmrWPp92gZOkZ/7ngPK6ek00IddNPJSTpd6i
 oE2l3v59kfj4BQCr7vDbJl32fnszaqpUFjAkeM0bd4orvJ6p3W08jqQbptD5yIbwyvQU
 k7CVNBtXu9leOOm1HpAxMwfejq852gSaNo5boBmQiehWcGgx8ttGDzNdKo2vUN9MQQLN
 hgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382848; x=1793987648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n8YHAI9iJOxJswDGOjyLG2qY0rvHHGV2vOgRiFmG0+M=;
 b=XwNSaxD4n3oK9mW4AuATAu6y/JzmO6HwgClLrHJS3Kq/Yh5ICdR6TN4I3nxQTIlr3O
 Rukql1Zpa8UZvbVeP8UQ8ypNnWkhQ7cpcqlZvFqrw6zJaRal15CdG1AzPaerpFQcF9tB
 V81HNcpIIpBeah/P36XOPxSaCxOmoMPnwhdTPPJwR8wsZ+M4yi03SnxZwbGK14BUB02y
 Jq67Kc7/VzuXciPhxbrWoLja0LgpkXt85ov/NjR0/XrnFdb6nuW68MW5sABcyM+jndMX
 V53KgZe56E8nm9TCKnUcDyUxJIdL0SdTDSWhDAvocMOXuqeMlRZ44VzX3c6wmNZ2l+WF
 ItIg==
X-Gm-Message-State: AFq9FYIIgkyJOr4YTqNK9l3j4t3hD7zcZQNe3HpRVp7nbjFhF0MiA0Rp
 28wMLMXTOHW83R02PL6baahOLsbByy6JxMGHMuMAszkrq2kI9JiNTFaFa9iyTs+0ZkgM/oT5Q2F
 OigY0qaC5vmrQnK10bG/JBPgYefEEkYzhlhUFhrKraI/xakBZgMXD4eeHB+bkdiU60ZiW
X-Gm-Gg: AYBFou3PjNH7cpkaCi2skimWDB2g2/8FxQtAGEoh1MhODe8IGmHGZ3XWCChGQcpm7MS
 e3syQl8uyVcZxn1Xs5kt1tXM2fJ9yylB3JEFtl6SdTdNoK1hEYkhJ+/oIvwS/mRHFhdM/quc5fO
 2D7Qy0wi0JhJK6NNbz08yNqw06c2oBDj4aLDROf6NMDR5DBpQYJYNTGzT6MQLbMGK/Vp+rc9aiA
 fFgvCj7MzTgkJq63l7DfGvM4pmEwndiligei0EP8uNGV1FZ99aGv1Y9nCThkMdlzIU7uJNvkAFO
 YBsDnMLuRRzDgqcWtR/4SvUdW37iQ+Mu+juy8b6fL8AWxIa8NnvIQDC9g2pTMe2jDouF/nOlgb9
 WMr4gpFdsgLBu1tGeJ5FtP4UAhTQSOsRau3FtzZuSm/tJSyWRGtBTSZbSDn2TkKOJ+Z5w4vycyx
 aIfhY/0FRJT8H2IHQtt82V7NysyZh8DA==
X-Received: by 2002:a05:620a:26a0:b0:93f:52c5:a31 with SMTP id
 af79cd13be357-94421802977mr525440985a.73.1793382848189; 
 Fri, 30 Oct 2026 10:54:08 -0700 (PDT)
X-Received: by 2002:a05:620a:26a0:b0:93f:52c5:a31 with SMTP id
 af79cd13be357-94421802977mr525437585a.73.1793382847702; 
 Fri, 30 Oct 2026 10:54:07 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1076sm78326345e9.6.2026.10.30.10.54.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:54:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 01/32] tests/tcg/mips: Remove unused test_utils_32.h
Date: Fri, 30 Oct 2026 18:53:23 +0100
Message-ID: <20261030175357.99684-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae4d9c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=FyogFE7hAAAA:8 a=NfTWbHSiv8_zekX3RvgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=p2WyBLmlf5vdw_nX_QRo:22
X-Proofpoint-ORIG-GUID: -qT7lppQe7D69g3ctizSonEeO9Tjh9EP
X-Proofpoint-GUID: -qT7lppQe7D69g3ctizSonEeO9Tjh9EP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX6I1uRFMxcWvn
 EECPRf5BDvFE+InU3sgPVz1FXQU5ArKMUOeJywv15NYzk12pUneoSAwA6w2iwLyF9xl0ramVbNr
 558k+IMEfuwX+xY3BAPdHCtqsAbhFkGsZ2ZDyBCLuZoLwxq0QLs0HSwBdMs7ka6yEaj1RD3qELP
 EFg86zcFAXcYQogMXl3u4Ni1UNGQThijtF4QkY2wnizWUP4/xktFrNVSDjO3gmwBxBTFm6XHHx8
 vvFTLr4WPCk9kjM4vWIQDAuJe1i6T1jaJyCMuJOQUmU9HGc6M5Osg6gwwMQTCUrbpg+nW7556Kj
 YfveS8cfhW9KmviHMkNDf5+QxraGzTAvcIaaocBdqz6d00CdjjY5AyjxyD2igEznG0a0KMviwCE
 vzXivKMHpEOfbxCcigGbHA448MMPXpqU+sxfU+DkXKLZH7gewLjLqZTJtuXD45QOs4VlivXBy0f
 GFHSHgSolRMicQINdLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXzo30KK3Tzm1b
 b3fSbc3z8DEBUT8+fmjtC46ok3BnujrxT/eRBClIWkvGEKSgevYjOBD2GXNMcVthDecmKVpi2vs
 Li8Qu3ko7LSH2drspE75QiAMq26WGW0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

The 32-bit test utilities header added in 26b3256392e0 is not
included by any test, and check_results_32() is never called.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips/include/test_utils_32.h | 78 --------------------------
 1 file changed, 78 deletions(-)
 delete mode 100644 tests/tcg/mips/include/test_utils_32.h

diff --git a/tests/tcg/mips/include/test_utils_32.h b/tests/tcg/mips/include/test_utils_32.h
deleted file mode 100644
index c33990c0c544..000000000000
--- a/tests/tcg/mips/include/test_utils_32.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- *  Header file for test utilities
- *
- *  Copyright (C) 2019  Wave Computing, Inc.
- *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
- *
- *  This program is free software: you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation, either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
- *
- */
-
-#ifndef TEST_UTILS_32_H
-#define TEST_UTILS_32_H
-
-#include <stdio.h>
-#include <stdint.h>
-#include <inttypes.h>
-#include <string.h>
-
-#define PRINT_RESULTS 0
-
-
-static inline int32_t check_results_32(const char *instruction_name,
-                                       const uint32_t test_count,
-                                       const double elapsed_time,
-                                       const uint32_t *b32_result,
-                                       const uint32_t *b32_expect)
-{
-#if PRINT_RESULTS
-    uint32_t ii;
-    printf("\n");
-    for (ii = 0; ii < test_count; ii++) {
-        uint64_t a;
-        memcpy(&a, (b32_result + ii), 8);
-        if (ii % 8 != 0) {
-            printf("        0x%08lxULL,\n", a);
-        } else {
-            printf("        0x%08lxULL,                   /* %3d  */\n",
-                   a, ii);
-        }
-    }
-    printf("\n");
-#endif
-    uint32_t i;
-    uint32_t pass_count = 0;
-    uint32_t fail_count = 0;
-
-    printf("%s:   ", instruction_name);
-    for (i = 0; i < test_count; i++) {
-        if (b32_result[i] == b32_expect[i]) {
-            pass_count++;
-        } else {
-            fail_count++;
-        }
-    }
-
-    printf("PASS: %3d   FAIL: %3d   elapsed time: %5.2f ms\n",
-           pass_count, fail_count, elapsed_time);
-
-    if (fail_count > 0) {
-        return -1;
-    } else {
-        return 0;
-    }
-}
-
-
-#endif
-- 
2.55.0


