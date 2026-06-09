Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6488CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JH-00070l-Ib; Tue, 09 Jun 2026 17:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iw-0006g0-Hs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iu-00084Q-Sz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4gvU3229242
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uezoR3BkJ4+
 T8uRdVffETCeEc+kHGXZaY2hX29AcaEg=; b=dOzABGiXil/xcpjqOEVGRPejxUa
 uyVL2eBnxQ6PxZrWME3pLeo2vpik/SMR/JwCQlD07fBrk3n0Y0c0e9FEo/CEHUqO
 7VpPV1EVU23HfemlWEXSM5/IdEtubMjUhsuywiTtfquaBaCkE0cGeCOz3n7EGT6H
 kHkm/x/4QICcei6pBfajeq1QBj4j2ZTVt/QWJBln6Lw0yRAJramKUhynmUuz3W5J
 CGY7cHI+HzMYnnZAWRz+uQzrgRLks7S6Zg83uZBeu59FkWwcILGQFNjqlaZ7gh/T
 NQZHki5MS45tuHiH93HBRVoLV0AalDyAcLQpcssl1e6XKjbG8uSJzq1hwPw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wkg1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:01 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1382f39e4b5so1101655c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041681; x=1781646481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uezoR3BkJ4+T8uRdVffETCeEc+kHGXZaY2hX29AcaEg=;
 b=NBE/rD/hgD4uE+ae319HnQTpvC/zd3IF76zyChh1enEgrz+C6s8cXSxB2ruyM96hKg
 eh4OXm7sgljc+ZPNDrsue631dmdSpB/ZYwZrmFREf/wb5/z8OwmRMbYW+8AP/UdcK0J4
 Kgx0+vfWR61cyIQDYcFTYm8u3yOdN0MCR6HxaFPQJVq8vdOKNGomS5RhxFps5CjxjZw+
 lgaTfDMDvSBxSm4BObi04rgRPbwROM9sgqdoHyxb1SA8eV7lVbyQGijIrdHWM1yMQ+bE
 nBpFNb9lMHuqqqdLFi4nWoSc8+nWrc0sgfWjTil9E7BSO2jA7hD9cOmidwEnJJ9hvEtE
 zcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041681; x=1781646481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uezoR3BkJ4+T8uRdVffETCeEc+kHGXZaY2hX29AcaEg=;
 b=OeP4GWP4uY0AWlrs9KsDBBp3vsfkqJsQIR8eo1q6JjO6dnxEAKywSVSdWnxIcj/8gH
 5ODJa0yfUeR+naIiHS9j2e7RW2owbuwLFxPVlQCb5COCoqTPzHJilHuMLtVi9KMtFeDp
 w6foWMx7Mf3PbaMs4CVigs3CxTLrnCs/8+J4I/LlTm0WmstMhL+r9/Uk1ESxeQSdvaUv
 sG7OKAyWOBqvk7/CcAtxHTN936FSKHB6bJNUtLrRxHukk8kkNCB7VkpU7uS5JnLLnlIi
 LFqmWwrZqpc9SJupeuogjOTM1k6L+oDO0GC47MrVjCPDVI7ZZP8EVKxK0c2qs0n8BmaH
 6E1w==
X-Gm-Message-State: AOJu0YwBfs/dNRx1vK8ijcK2g95tsxh955tg4K6xKCFx5x8NzIA+C5WN
 n+2m1FyWRscmlT/FnDI2zca1VvsXPr34kmD3hs1UQl+B8xTImphhGhOqIZfzd5Q9ycMNx/kFyIA
 RxhYXvD1jULaLeZQplJMHV3M+WrYBDADmgSflgEweov260X6OaOEoFV6hmZygb8RvM+jx
X-Gm-Gg: Acq92OEoMZXZPrZA7qYA9FlU6wLHRXX1zj383Q/mIUxeIApkZfxKwqu+AJzB+zh9Kbx
 dEMKArhAEhgGZi8nQ0eZ4PIT9TjCSXpYBx4q4SgBECM6RmEeJBgyHtKCmH9N99dsxLyYVr58OW7
 0VVgABqKazjFaXhttnqBsCp7o7DtsO3Iqxn40aQMmuD8Ypl4PixqI+5JRvj+fOlzmC3JDlQJZ+D
 uFrAcu75Ffzc7lCZHD6l9mGXiA1oF8XQQpu+HQusqT8zKL5lmMmgre+5ECq8cLu3+DGiW8N2z/B
 zktAM/RH8SIE57pHrpvbp9jVU9eiaVBNEVsy0vGj/1RJLA7Gz2tWKStGizphL7+6qj7wupLBEtL
 O4Rt0/DHsVi/O6laprpnW5bAjeNIVi3GHWnvYmNHbOC22UnBsndlBuT2jlC47HxgxVPA197Q0HX
 HPMLFFDXOt7H2NTWRG
X-Received: by 2002:a05:7022:327:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-13807d7f8a8mr10475842c88.16.1781041680724; 
 Tue, 09 Jun 2026 14:48:00 -0700 (PDT)
X-Received: by 2002:a05:7022:327:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-13807d7f8a8mr10475821c88.16.1781041680152; 
 Tue, 09 Jun 2026 14:48:00 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:47:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 08/27] tests/tcg/meson.build: introduce qemu_args
Date: Tue,  9 Jun 2026 14:47:26 -0700
Message-ID: <20260609214745.772536-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNCBTYWx0ZWRfX1Y5Xlk4q9AW9
 1X84eLWv60YvlTxzXblP8pWhV0nOZK5z0405FQ7j36Mgp8y8Eecm5NpGMlw0NRHL9Et4OZOTBwi
 K29o0gtJPn9ryeJGMdjJ0JKW7ersUcV163W9CT/1Hj/RVGGCpp1tmFYlTwkCwIA//VWEv25VCjs
 8otwR1n3LBAOTQX0nz4tPHk2AiIiXedfTFkqdJRyWrFPfTi0jFfh9d+WHCDbJSbkTdjsRwVNh8C
 rgMYm50PtqqY2JDkotbqgvDOFsIi6lQse6s2uXm5iH3fdstNdueY7ax6pY8JjQB/96j2UhFkYhg
 h008jUk0Vlz37J+uxgVCK+OjYzP54E7luTiN2qC1jFTE7fW8L3eHiz5hM34nc1BtrJkMTbMvZRg
 wPNdU7/rWfczqVsDJYXbV/IO6q0v3xFGTI78c2tEJJECqERpmDk4lP09ZwBFKfjnfxaFjtcQMuL
 iTLUJntsORmi48OaPoQ==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a288a11 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=mjsBmtCu2CUIJ0Z8OpQA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: i56hvY39HvOcbjwQ85NPqDhr4lDbW0rp
X-Proofpoint-ORIG-GUID: i56hvY39HvOcbjwQ85NPqDhr4lDbW0rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090204
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

We add possibility to use custom arguments when calling qemu for a test.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ad56fdf4ab5..28a7e529c7e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -53,7 +54,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user mispell a setup entry
       foreach key, _ : setup
-        if key not in ['cflags',
+        if key not in ['cflags', 'qemu_args',
                        'exe_name', 'test_name',
                        ]
           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
@@ -108,9 +109,13 @@ foreach target, plan: tcg_tests
       endif
 
       depends = []
+      qemu_args = []
+      if 'qemu_args' in setup
+        qemu_args = setup['qemu_args']
+      endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, exe]
+      cmd = [qemu, qemu_args, exe]
 
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
-- 
2.43.0


