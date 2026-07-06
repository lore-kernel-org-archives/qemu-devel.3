Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE88C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtU-0002lk-Hq; Mon, 06 Jul 2026 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtE-0002iL-JL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtA-0005MM-C9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE5HC1428858
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QKjJHMdqb/5ihyRotieyzeKIyxrLi1ZiNYvQlQicLDg=; b=gBXjmO8W/GZnAnp7
 deUJgy/7Ou5njPnfb+D51xs0Bh31Cx0Gtb7HbjAXY0kaBLVsLsdMhKL9apTAQV9q
 Fco9pWk6vPj7ItV1/TC2fK4CCzSukRlihQz2s1x8Vqk7tdGWohLZDRJRYrdeGLRs
 AskWMNEhhGYCeoChOx94cqvxStJyHpGF5GDGXTU5bAOf24VH8AGNc5dPwxrmVXcp
 Hn8o5rN8fRdv47I28JAAgs1XedbJ4hD5UCgSmBDPSojcYlJX9FKXmJuCgXAxLCxx
 uJkemelfbleyE05R577ywZVm8mgcik86OHhtamTNOEeRpO8m903YVt+rn9Y9G0lb
 QgfaaQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxut33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-384419c6c74so3040748a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377245; x=1783982045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QKjJHMdqb/5ihyRotieyzeKIyxrLi1ZiNYvQlQicLDg=;
 b=LPgZEcaaamBDeHm8wzCsighP4tA/o0T7P9Kb/cdeZ9JXho+iCK24oDd+tn/fEEsMLz
 mflGrxR0TZeg7dg6gsNBu9QJqTs5UJEhvfGNx5A+6eWw8f5k9QSIxofTBOfYLWphb9uy
 E/kJx2C3cdlZkF3J0Mv0nlQgoduGc0Jt7Ens85TD69WI8Ghcq7T+7D+LuX4Ymt78SBY+
 ekvMTMVjKJmDibJom5ZDT+dGCntYs+4nEKwSlng58IyjfFgour0E/Ux+MBVMyKc8eWLY
 4sdMlphM2q9chjepOJY35gJU1xTRsLRZRQdghr11v5sjIMPi4hQYB564x0sZjFEaQq+3
 gXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377245; x=1783982045;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QKjJHMdqb/5ihyRotieyzeKIyxrLi1ZiNYvQlQicLDg=;
 b=inZ7c65X6QaPMPS4UmCLWor5rVSsf6eEJRGGilJQCOHURis8aI1PQ47EECD33Fdn0l
 KVHz+2XOky7Z7C1Q7hkukTnnEflmghuDeXPSu2vqO4L6Yav8l/64PmM4dG6NpxLpdd0C
 FMx3eBWlM5uFO45NAiv9RGuzOq7hYC+D3ZGPoCVGFKCvHDQ5e2VglIdw1pHJK+/W+7d9
 jmX2Zy4n64iR4w8xDQmCJJG1fsqMLQA1PucsSwrnmocI0vSpKEw66nO0lWOstcIQQEom
 wkQ1DJG+wTb77/vESywhJ0CH1QCfc+dsT0br6VPBu2fppgJCEuxOpEmbvESFuIqR23ek
 gORg==
X-Gm-Message-State: AOJu0YxCtnw0kDuE0tQ6n9mbr4kYfgnYLwloSHa1sGwSOtxcvLz/WuDw
 yepyzz3l4xfPQX0wBfaRL47Q1Dl2AYqYbKIQX0qSAM9MaoiKBdX+Zx3oNc3bpBk6Bpt+SvUdLIY
 FtEPxF06aDyiH7pG9xOPbg33wj35wKc9swJQ/NUMKgLlf8mrwbHg0ncG82EFLNmOwyA==
X-Gm-Gg: AfdE7clyYovzU4I6YOvNnmIqaJdcDAkWh9RV7RPwxwSQJ8ZL+NnSAIb8/aTK5TnI05a
 wJeMEaePfZI62jjha3Dr94qbP/FtVs2YT2VLHiBHgRnDo0r34M8gGYmQDLXrsbLggqUCcRULcbe
 zvB/wNbdafaUTN3aa0WZO/+vVlqgi4HKF0Eu2Ij7r0c4ujvrlHihCq2QaGBZX6Ns0MQMPAHTKUY
 oR00xRJ5DJRVkvmm7UZT+dnncOZWVLqEjksA9iqRPrD41VhncnjT8HzUPwzRep9p8bPlo5M8Y0q
 NRyuS9/ChUqwgcz+yerx36fDMf49zsysYyjEHI585W2XH+G8LgMpIW9R5nOmpT50CU5bkBNFcYz
 Y/HLwicIL52NWY9YMg+8nNLWeWPBBQjxjjII2EAMv8UEQoXBCRTnKfaIW8Xm3dLgK9GJNb1fp6R
 2SgzhUAw==
X-Received: by 2002:a17:90a:dfcc:b0:36a:a16b:5f6d with SMTP id
 98e67ed59e1d1-38756802c30mr2410417a91.7.1783377245127; 
 Mon, 06 Jul 2026 15:34:05 -0700 (PDT)
X-Received: by 2002:a17:90a:dfcc:b0:36a:a16b:5f6d with SMTP id
 98e67ed59e1d1-38756802c30mr2410391a91.7.1783377244725; 
 Mon, 06 Jul 2026 15:34:04 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 08/91] tests/tcg/meson.build: introduce qemu_args
Date: Mon,  6 Jul 2026 15:32:20 -0700
Message-ID: <20260706223343.988769-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZBCe_Z5H9fszS1ae0Dg55kQx6fWFBFp-
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c2d5d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX7oIhJSwLfY2p
 R4Xgf4IMetUR7xphxBqrIUdYYxPHRKqApiAIQk63m4rd2BfhSEcKJe6LO1Pon1Q5eFPLC82X7jw
 le5AFxCfsWyCT/fbrS17zyxT4K6s774=
X-Proofpoint-GUID: ZBCe_Z5H9fszS1ae0Dg55kQx6fWFBFp-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX6RJjwuUbwE4+
 zF0MMb/L8bSzi6L3zkhGUzFrv5j7n6Q4cCSgrBQDNTFsQR2NKslJ7swad4VSzPJZH7giu7N2/kD
 kH4tsnyqbnxDlp0s4jm8TzkoQWl6tfSNPNPE/b+Iu7u0pd8j70pqtVzZCdLX4+zsQ1D316xq8zi
 mw3jUHZz/nArFD8JHb+Iygd22s5HbyVWTDEBTz15nVRqqq0+57Vin9hspNfA683XyfbaAmg749o
 w8RyeUUhH3D4zCmFGabV681Rx5JU60NMSwKSsYL2DcyQxvyHBTWlreY0LHjccxcRjtViIVJAIku
 Ck7X+fc5r4/9RiI83S8/EXtuoheFkJSFiZKJTo2jc0g6Ay/WLwjNVvy2c9svIOW1ozv5JzsPG+Q
 8+vba1odRybDt8Ap0zsZhHgSZQEbdRrEEmuc7o1ni6InJeDWAjcVwwt5dK6mxjgV/Xch8Uv2BTi
 WgzVHXJkwbIu2gIO4FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 495c1d672f0..8c82a49b3ec 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -56,7 +57,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'test_name']
+        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -110,9 +111,13 @@ foreach target, plan: tcg_tests
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
2.47.3


