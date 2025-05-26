Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71506C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 17:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJbVz-0001fr-Oj; Mon, 26 May 2025 13:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1uJbVe-0001bM-4o
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:21:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1uJbVc-0007VK-2W
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:21:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QAKdbF014890
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 17:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=YKC2HrSGo1jy2Us+JCQoreoI9BZNqqBSVAN
 PHiq5xLQ=; b=RvOi3nNpLkYh9xOWPSvIpCI6DJrps3kmRKAP64KtyWYRbUuytHA
 Ucv3jbivFSmT9O9R5PJ4aAd4yipkmkJvHvaGJlgmsw48TjT3DcPBh7noL8+Tzq9o
 lxQ7cEueuxq+4izA0s4HGmzWJX+9x68LTf6418psEvgcza65se/UjJCmb/4wtqgZ
 7BADGvHWztPvXXUv/m/8xwLP5oUeXWGW3auwbkCjAnHfxFmrzIzoWKPHs0BVeqCz
 273cIr3eOCv10etodca4PS/CPUaOpyE2khalQ8L3T2luvjmsX67F1ywRE9D8KoEM
 nhaHkOs1a9LdAGAHFAZUWypeLVecJyP0GlQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u66wcwfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 17:21:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31115ac777eso1840748a91.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 10:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748280060; x=1748884860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YKC2HrSGo1jy2Us+JCQoreoI9BZNqqBSVANPHiq5xLQ=;
 b=idGuoyplS8zctyB/W63gdQR463+k9vAfV6AMeR2XezTzMwNaepKMpNfRT87ZTlK3vJ
 6dKfLQiuZdNnzhbgs0RYedP424La9q+BOkeHeImzDgG2X8gYonqKUj9fA+vB1Oc7oaVa
 d05oOuxy5poR+sr0CM+yFr+fv8waghRbGFYANz8+WPc3eA4KyBJzx+vrzqu4s/VoGPrw
 IaqEyKYL1UZTGp2smrIROrQFo92V3QVLPB37M+NECgm0LrJk2QWb2VnDY0MT0o+uUtmM
 ZiLUtAtzqXc+6oSuNzNOYRyK4r4GxICiYHXj3NwDM4Qi85Rv0nzt17n+NjzQ/101pI4F
 7aYA==
X-Gm-Message-State: AOJu0YyjCZ7iAY17CdkrCYOvTWCED/IlFAjrzLS2Kd+gf3E5eNGy00NV
 tBxIbOamabIPOAofdR94o+89FokM/yiA1fvvwwMzDXEnhX5UHZhbbUn8Z2fARH4U1DLMj8PHPHi
 +kUQGUjTLqaEWLrxgbtwsnprMNLrwP9tfRINMX15cdWKtKIrHLdnJD1fPTBVLnLycBQ==
X-Gm-Gg: ASbGncsxyBKtuKTjFtG/jo864zI/LWNdjgpol5DoVWJ3c6HiguwP2My5U2b67Ka8p3E
 GMH6pQMenzPJ14NPxsOoQROk+Xj9joQuFUAvAsHniCKcL0mrmn8Gk04KJbDf5Gm+wuswqdv09JX
 0oEcO/3VUz2WtSbL9kuYmd9BpMN+KxSA/6Dn0TrfZ4RT5SAPRHP4HKGbjAXR1MOiW8/rH65t6QC
 V2dntpgR8ZqWqlqo6uCcs+s/qxTogskfGsKE05fKuImdf64/5/lw/JIWY8D5TsjBgmgJF4ZdEpI
 rcCKuNNvLcf0JyMasZUnfhal73w8MjRpCjuyCqcJ3Y6n7z+jDtVK/ZVhLf8KIWSEFmsL7jwKkOQ
 =
X-Received: by 2002:a17:90b:1d51:b0:310:cf8f:6724 with SMTP id
 98e67ed59e1d1-311106ac666mr14887626a91.30.1748280059644; 
 Mon, 26 May 2025 10:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr6L5GtrOL2DkxCR6A5kzmxi4bMPRdZAFKS3cucGrWe8SnDWHz05PTmRcHArWsRiICk+h/EQ==
X-Received: by 2002:a17:90b:1d51:b0:310:cf8f:6724 with SMTP id
 98e67ed59e1d1-311106ac666mr14887576a91.30.1748280059050; 
 Mon, 26 May 2025 10:20:59 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-234488fde35sm27244545ad.225.2025.05.26.10.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 10:20:58 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: jmarcin@redhat.com, qemu-trivial@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, brian.cain@oss.qualcomm.com
Subject: [PATCH] tests/unit/test-util-sockets: fix mem-leak on error object
Date: Mon, 26 May 2025 10:20:55 -0700
Message-Id: <518d94c7db20060b2a086cf55ee9bffab992a907.1748280011.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aYJhnQot c=1 sm=1 tr=0 ts=6834a2fd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=pkkCeIeTIf0A1w3mICsA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: PLVF3y8Cs6XDBWgQ0onDOQNaBlam7Cl0
X-Proofpoint-GUID: PLVF3y8Cs6XDBWgQ0onDOQNaBlam7Cl0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NyBTYWx0ZWRfX1NMG0wCsUfZg
 o+oPJP40jcsi/trwg+Xjda8ZLWnMxLxU05oUlttPa4/e0s7dSWqzsH1oXZpMKffBW5yWAOw8VmY
 035HMww0pquPPjV3xsji+G2HroKipPm+yILSGdv1a2443yfceS/+eU6gKShEwG695EhABJJcuzZ
 p7xn3kKmMvaQJqR1oWtLXWFn/byrrnHy8i958kk9hyDPiraWUjHha4XNbvAwoqBtTrtHNX7wL32
 U+fulzHmEQTOmh0jmgp5Z6CwE36X2UrjPxRrZXQJlS93TR3CTfqWsEVKvKxgydfuPLCm+jI9tE+
 XNLRBNq7EucLjWefMoT6eVH4TaIASBUPjkop2Z3THqFL/1eCozRYGZBa3G7ol7yYeZbe+mvSMlx
 HUJmzCXmbw/otOZKEEIZqWP5bGVLnYJmENXcZTSed2k5pYVNXgzDocR668ALj4ntAalaLyfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505260147
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The test fails with --enable-asan as the error struct is never freed.
In the case where the test expects a success but it fails, let's also
report the error for debugging (it will be freed internally).

Fixes 316e8ee8d6 ("util/qemu-sockets: Refactor inet_parse() to use QemuOpts")
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 tests/unit/test-util-sockets.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 8492f4d68f..ee66d727c3 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -341,8 +341,12 @@ static void inet_parse_test_helper(const char *str,
     int rc = inet_parse(&addr, str, &error);
 
     if (success) {
+        if (error) {
+            error_report_err(error);
+        }
         g_assert_cmpint(rc, ==, 0);
     } else {
+        error_free(error);
         g_assert_cmpint(rc, <, 0);
     }
     if (exp_addr != NULL) {
-- 
2.37.2


