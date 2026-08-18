Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14867C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPL-0006bv-Et; Tue, 18 Aug 2026 15:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPJ-0006b1-DP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPH-0006Zk-JR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGoRs1518225
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=; b=APMM2P9SoJ/GN7Tw
 zV7UK7noLsoqos/W88SkiZdSko1yU10z7/yJVGmdK6cadlR/onjZz02Fnkl58qaR
 jjC/xmsg6RgN/5Q5tWQA2h+JM7cQz+sjeaZhgyDNWCCDTUgal5VyrvCzEnvnX4Kl
 Reem72A51/vxZMLu6C+HSTk6kX0cLNvx/ow6c3uWyQGYkwcf/wIg6wnQjslkAged
 QK1ZzEO2DT3QafAM/11O/Ehhbaes0MssjBbdghcJAGtJgXjBSnjzMxdYza4VGnOB
 x/j2PImTF6olbNv/MUm9zrd7MMnvWKR9KJX9d8TTQIKV9R9DEC6a81PfRqRN3VR8
 ubSZgw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0ncg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so465572a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081009; x=1787685809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=;
 b=Ovv4pn8eksqZCcAoam7p7HuwzwOkfB3jdYZahyG1EVnQmi24q3/OGL2CV97FVXRMfG
 EzjDidgu0taKe35QwYJqVOXVdH4cyBUn79PKCPs95qisxE6RpbD1L+8T00tRYAn8JILS
 OKLICJfvjrbu8SrbL9cTtoX6fg5LywSfmcRTv+tIW1yZ/fi5wx3ujLY4E174B/RJBuNe
 747HWoM4ASQF7+CdOEB7Sa7xJRnSFBCFKWtEmOR71K3kATV2xtw64neh1RfHKBAVItsJ
 F5s3cycDTRQh6fzHWB2AyuyjOmyvA5M4MAxcYNuyY56S+CbVAEVUv1w+RbtCpjSaepk4
 JK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081009; x=1787685809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=;
 b=nw8EI1e78ih6HyNCA8eSHNXV1v1lLU8wRSwwue6gvA148M5U2GfpxeK061tFkJ3HS1
 vAIJ2qLhXboUs8ThlYA1PysSdpjPY6yT19WZS7yt/zZFL2hcd//oORtpidRnGf9h73M9
 3MH0GHzpv6E9xMDOrtIKF38yqZLxYmbOxH2XK96M000A0H4lUsmMbGI+xiJ53FpQdpqc
 mTeBS3hEpMzGMGMu13WfsofWbAqo7lEKvuWi4BdBKkLcAGVWdvVduhVCYn7NwFbMSPBD
 9TeFTLSFrw4jLeAibT1yTmRYeB5AcTm176w/UqSRbYCjUZzrxcdWhHBVbYsUcnJF+oqH
 ofIA==
X-Gm-Message-State: AOJu0Yyt3TKcKcfdRSJZ7u2y85z7lCfwwz1SLugUXIPmPCXdsvrh8J9d
 EmAWr9xL62p7bn7BBXpWZpKi7jzUVHIbmgbcX/EhVDqB7O/NdJijS7ZXkPyxbRF8KqsVjLsLFnc
 9rKMZqRESv8zWYIjvgGHYcPcEciqJcvvF2PvZYE4aqnKcx90WZeUsW21T6b2s5i3CVg==
X-Gm-Gg: AR+sD11dHKEUwgOx0GUa/73SFb07Wk2cCwRu4DVUfwUzhrv2q3T+CE2lZIvM5PihzeB
 +1m8LoxwpATsdUO3XdGpklwa96YoaQIc+x1cS516vSRiNKdRdMVGs115dyaXQwFjerLsgNdqAHS
 F3bqzz3iETMzkdaxPZMQVXTrFagVn/UbXPo5EFpHYtfD7MvT5K9861ELOivf7OSiFrqlN5h/dAx
 eH1pimlAu11iWZUyDF5S1SFI1nK66EUqjn668OAGVXymOWzoJ0NZrJ35J5h53SkBwJX0E7Tf7Ov
 g/D9GBR2//YZC1s5CAMBOizMyKRjpGWD+cEVLgwvY5xC9bb5EyXfoHFwqZuqNTYdc/rblL9T/vy
 BfntqtYZZz+1kypCTBPRxzle59BzY92ssdMixFv8UGX6jWuQIkTXJRn2yCNA=
X-Received: by 2002:a17:90b:54c5:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-3957b1c5cc4mr73612a91.5.1787081009310; 
 Tue, 18 Aug 2026 12:23:29 -0700 (PDT)
X-Received: by 2002:a17:90b:54c5:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-3957b1c5cc4mr73560a91.5.1787081008901; 
 Tue, 18 Aug 2026 12:23:28 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 007/104] tests/tcg/meson.build: introduce test_name
Date: Tue, 18 Aug 2026 19:21:31 +0000
Message-ID: <20260818192309.22169-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxfLZ5WhOw0mo
 eDcV99TeCVbb/y8NcA4aF03yNxA/eEfjEN4qO9xEt3d1xqXb8Lwv/bZlsIgka2obHVuJr/QQlCG
 BKmW9sOFnikzDbXZ77uOEc+toZrQnk3kanA9fIBVFyEPcOUwXhGnU0AoKT+/63SIY5hkjcWzOuJ
 v+8IvqIv9En2AQQDiWVuI5R/Klzz0RF50edfUUbyW3o5muVUm5+4PqYlyTnYmmZUqynjHeZKGyd
 lHcclsViS9j3+WVjQ5dfznX3U9lV5dpczyVLWbuAsyaeOAoibif1yA0zHg3eTmjIr0jMEG7m4lG
 9zsAGNTCLI1mu3m3chmDkctVxjNkt/XpwVR2pv6dqoIytzA2NBc4eVwH72sAKjbB1sBUgNnEA8b
 OVntb7cwTuKFj+Ia6j92e/ngvhvlnZBTGq/5QVA/Aa7A8QgfsJUjaiB2E5DprqXO+Wq0qC7SQ0e
 CAiJRlELoqHGJRKVBOA==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b132 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7uM63uTQTkhx8u2iWTJ7wiqvxXR99_Rh
X-Proofpoint-GUID: 7uM63uTQTkhx8u2iWTJ7wiqvxXR99_Rh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX0fLs7O8m4Y5s
 T1gkuGSesvo7zcCXlZ6y8chOrRe4GPW/mPp9ZFcXGkmzfYxsL2dGLzVfKr3uJEkcZLmm1+K2/Xr
 RW6McGfQQpql2SbO74PTRVoMWGnfUfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

We add possibility to duplicate a test for a given src. This allows to
declare several tests that still share the same executable, thus saving
space and compile time.

A side note to mention that meson perfectly supports declaring several
tests with the same name. However, we prevent that to force dev to
clarify what is the intent of each individual test.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 697b826a382..ae7ec998f63 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -12,6 +12,7 @@ tcg_tests = {}
 #       {
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
+#           'test_name': ['provide an alternative test name'],
 #         }
 #       },
 #       ...
@@ -21,8 +22,9 @@ tcg_tests = {}
 #
 # Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
-# is guaranteed to be unique also.
-# Default name is derived from src if 'exe_name' is omitted.
+# is guaranteed to be unique also. Several tests for the same executable can
+# declared using 'test_name'.
+# Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -52,7 +54,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name']
+        allowed = ['exe_name', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -67,8 +69,13 @@ foreach target, plan: tcg_tests
         exe_name = setup['exe_name']
       endif
 
-      exe_name = target + '-' + exe_name
       test_name = exe_name
+      if 'test_name' in setup
+        test_name = setup['test_name']
+      endif
+
+      exe_name = target + '-' + exe_name
+      test_name = target + '-' + test_name
 
       if test_name in added_tests
         error('test ' + test_name + ' was already added: ' +
-- 
2.43.0


