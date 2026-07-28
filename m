Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A18C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfu-0005da-JD; Tue, 28 Jul 2026 00:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfU-0004su-UY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfT-0001c8-EK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abKQ1527466
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yp3t1GqfRGx
 mELMX3KmyhebiFLXsKgesnvj3KW+DrNA=; b=JSJdL/eIstqbqcvllc+m93uAIlU
 S1W1f63Q4yQZFo5Q3P+rTpMgy9EJ+TWJuI6dAou6tnqenkVieeg8sKtkoSYqt3xA
 HYf/Jk759Ikge28FyH8KF1mpbegmSKkhiHLtwYLe/K4GMrPFOKmF4TnGvfShDkiE
 x7IDTKBV+ZpDTo1VI3OftH+FlWuajfljEnaDfTvx9bRFBg2Ig5zQ34t+V0bKHFCU
 xy+K05oPuQE/BwtgLvqPtcY2rxVRUQiN3gie69Hoz32JAZHYsYMwWFJAl90+H0SF
 hsAnVJn1yagFT9Q6fUcrveqDWfnhRigmE1yMyuUKlxDqpL74WKwftTT8sSw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso7792022a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213819; x=1785818619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yp3t1GqfRGxmELMX3KmyhebiFLXsKgesnvj3KW+DrNA=;
 b=d0bM6VW3vpdDgl3CRUh9v1XoBLYqUl5/ONtYlgghnt6GTDQYlbSYp/Rp8cG+fzEr0g
 9ySxdZpkYvNhohojACA9L3wckkV3j6hyU3d8PRv+/5ieZXQBbcd/o+MQVNd6biV4WSQA
 +8VRsJeisQXA5ATvwi8FZiAzo52sMYYIYrFOxRBVnTvdNvteHUJZFT3HfRlHxjWrBvDI
 YrtNE4H9o7ol5/4kKAmbY13zuyaLSSszfB3am7c+W/ks256oGwmTCaaQn796345Ee0Pv
 14lhFXNLIz1rqMlvWsA4zqRYDYynQ21N/IyrZnC9hesItcltHIgW5Rko4GW3nAjeEiHA
 6RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213819; x=1785818619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yp3t1GqfRGxmELMX3KmyhebiFLXsKgesnvj3KW+DrNA=;
 b=pEKJDITWRCe64WA5L/X6DiflDoriZpMUtVb87Tl3tgbnEGS1jNruv5RA1P063ERBVE
 VTeBaxmXpsokZLwLTfe1oBRrNWTUf5i4Mcnky/Biz+Q6wmjLx4Q4InOZJTDGI8+mx9E2
 ors+PdOdA00APYUGixowYacSjm+w1Fog2bZYzROyrTF8li8B75VroKC8fEHN+1A4rUrB
 L4EejSbLMLBqLPijp8bTwkNKbRyJCxl3FwWAPH0wFdY+CSEjyF+XUl1DqCsydb39b2qE
 u9Xw+Ow8dK9HM/ISBDxmiEm5fDNoOisWRFLRONw8F4f2oiJ/hn+88EEPqemVMcVyGeql
 M3Xg==
X-Gm-Message-State: AOJu0YwUguzl4unjp7InRdp85r4jOKiOt1iDhHdFQth/DOcgzzO3i8Py
 vAGJo7IsDBPONHV5sCEFC1FGNsmnAYo7PLnbN/XwiAaw3g5aSntbXFrKgMqHBw9zITWvOV6Du/6
 ZmUHlB0Mr17bM4htZzdqE7ZwLH6iOzC3KdMeaBl3JEMZEGwrCe8gEAOicEvFNtONbrw==
X-Gm-Gg: AR+sD11zG+0zI6ivjhKyIDNa2xPAu4fxN075rU9DGFzYLis9cc6xnO1npEXyv6M7o5t
 70VesZlpVL8fjTok2flhiRAW5EJwbQ2VJv5jHAp3dG+pM/UG7md+WPx1v+ImbkdITTXqfCd9/CB
 DrhuGsUnQLIiSWQEJup5pFL4WLWOY5GUtCEkiQKpmnMPxvQjArwGzBvYGHMDTEEUC7QAf68hPF2
 72CEceJoQs54bkw98/I0Y9NyD5QikZHlrnXZ76/XSaeq3r2vxYyEt6zqJKh4AG0fmw046yqGKH/
 c2VPgubSfK//OOg6ox8XIo1+B0z74ESnH9saSLrc74RfHiF1JPXkWH698YfEgbpQ1i5Nei4HsfQ
 GDjUfSAz52l+iiohisMfCCTQ/tFyl/Kjr1Zo/RJsyXKek78bvjPcMHWweYvsQmcCHNiKJ22Y=
X-Received: by 2002:a05:6a21:b86:b0:3b2:8685:1473 with SMTP id
 adf61e73a8af0-3c8aafbb640mr1000446637.7.1785213819586; 
 Mon, 27 Jul 2026 21:43:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:b86:b0:3b2:8685:1473 with SMTP id
 adf61e73a8af0-3c8aafbb640mr1000426637.7.1785213819271; 
 Mon, 27 Jul 2026 21:43:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 025/103] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Mon, 27 Jul 2026 21:41:29 -0700
Message-ID: <20260728044248.137626-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX2uRb9PbCINNs
 HUArn+1ojrbzW5vPicDwU/7A3QyrRIlYcUYiTJx8d0qX4YGO1PQeHHRutFkfBZxcJJ6n2/mBDTG
 yD0zuHCZLbKVMCbg0XwAdJT0t9Rfyck6fzFnzPTeVQ3aW0BCNYEBHNTpUXAUGLG0CdG46hknqxR
 fu4ChsLZpt3E9be8bQXyavzFQkTjJV9noVU5vnOdqWUBHgzpflT7PEx0pMPdlm3VMHrbt/btAQC
 /oozPitIfWAS0XOaAkIgLc9g8TgW7HG3EDtOoek2hbhgpsdvIyXoqcZpSpJ/uBPhCYNnBkuk7BF
 f1/lCWo34CdjZe12OtHBLv3SD/v+1JW7b66/D9aBlzOYvSxULazW4fAKv4f0QX1DTGgmIh6x0T7
 wX/uACqKP6onn9qrgoAy9O0vzHH4ba/Q8eqz1jTQ4bhpb/+rx7xSwU7S1vI/0YCAOhBMOpEF32Q
 uwXI+JUOX1tiFMuf8DA==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a68337c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tvGfH4KSH3m2s3Kz7-kA:9 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -y5iu0cJoNvlBduKs1rkhypUSA7HLNb_
X-Proofpoint-GUID: -y5iu0cJoNvlBduKs1rkhypUSA7HLNb_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX3rJxsjuDKIZX
 pVpVhP4Y8C8YocS1uZ4shSUSRrWWHLq439wTkAqcWOfXqRONMb8fmEetw4BDsMZ7qokOLduieJw
 mJCnhyCpM3vWHMZ1Cqu+viCLwhp605g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c227bb52381..9c00d21f059 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -19,7 +19,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -96,7 +96,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -189,9 +189,13 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
+                               cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -202,6 +206,11 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
+      if not cc.found()
+        skip_test = 'compiler ' + plan['cc'] + ' not available'
+        built_tests += {exe_name: exe_name}
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.47.3


