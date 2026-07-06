Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7311C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtU-0002ly-Nf; Mon, 06 Jul 2026 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtE-0002iK-Hs
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtC-0005Nv-88
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEIpb1639870
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jbhN8YHnUwS
 /Ktk5Fx4eP1tI2wK+gP/evMNYEP2U+5U=; b=UUEbQ/SxC+8tqcf37o63cDOpPuW
 Gxnp/CUuFVzYUlEG0qQkm66SCyQNCh57ND7fhGIbR8vfCPO+Qef/UKlEg1SKZDPX
 iIEvTBgDswLsOe/rTqDN8BQLkPvAMTfdvpjfpIG8+pYLP5recsW/iBEgx8zhIy2b
 HiGrXfTpMRJ+wMwG4LduUQjlO7YItJ3ZYywW9tZioN61ESJPZ4Ek3JHQqr23XnlF
 mlzjxdyzHQ6r/MbsfjHExBdetrWdhOMRXlrVndF0vpdPy5Kx7hHaIC4YZ7+2xCsV
 IXbhDpYGnXQoQmlgzAH+elfsyCMQRVS7ULmrfXomekbf4D1IbyTsypoqgtw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r34qu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381e93bfcacso7434685a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377247; x=1783982047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jbhN8YHnUwS/Ktk5Fx4eP1tI2wK+gP/evMNYEP2U+5U=;
 b=LNa7JtGLmLqTjAz04r+w2A7Iud/Snh39NihBkh3zzs8KxRLO2CWl3pDNGGvf/62xgG
 uiMrrKAXKE7ANQDvhx8vHB8HPyuc9cNd9kEYQpRxzg3E8VFEgtZ8+THJAwwfyBsntiWd
 JJ8HfgBBGWabiLGpxFKBeQOo9DQI/gCdEvUA8QPhsQVsCWX3HouJfiZHrxSz/9LkXYSc
 iB3oRxSPmaCX9InrHzhZ3BhT8R+MwtdsiUqjyijA7RXfqgyJ5FCxCcILXVKhezQ53il6
 YtSJuNpOn43EUH/Vc8V3Qym063iaXhj+S2DhoRZW34OkZfFgnCoQFl2H6JfOqJoIQQN3
 hF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377247; x=1783982047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jbhN8YHnUwS/Ktk5Fx4eP1tI2wK+gP/evMNYEP2U+5U=;
 b=i/UJ1bdN1An3fO5TdnKMJGrTb2ZugN8s4WpllvOtUaHYyvfr8TNNx67gj9hvqBFttz
 t/iVPhlnK+ArBDJYC5BwRvnMl0rvjiZL+MkIZBWbXJ+5OWO8FQFBZnRRj6MXQmPNuQ+u
 Oz63BMsFYIsU2hdAGeV9KZgEILfb2A6T1BvWbFHNaOkkOFo6QNNq3cA3NpmQcOkDHEd5
 1x9eUFGBqTbaX4wZ8q6+WYfptgh87GnLTzeIV8ogS1Q9jcdLPkTA0VqPMM2vUeP3cSEJ
 7TLQDv7MVyicQd/eoGP7z2vssAHUOSzuJ8m0kr+iyOAnFsjmo7MVEpehAFfj2NX0sC+5
 sAjQ==
X-Gm-Message-State: AOJu0YwKviRxE6Y/TiBbh/cOxlOpx6vNjuWkj9OfPuDwxlkhMnaPOk05
 GP91Dn5LgE7sjZBS4rd6oMArVG+Up3dQau/23yaqmFnQkbaEga9o4yhHp2SoqSob3V8MKxPijdR
 KsjeSSOXk/j5d/7Cmy7gZTmkW20g1G5A3D7X0J0bcyR4R4ZOgApgSfK1Y9yUo60zUtA==
X-Gm-Gg: AfdE7cnFrSBhit3nb6RpF2DXu4Sip0VEmF306c/0ROv1UQN3B4oKyntV35YqcJhJWN5
 zOcJ2R1R8FOlUSZWGregoMHMpuE1R2OC3R4SXr26PihR1Bza0DhyhaiP3vqpWhxldlVjpHqxJUW
 eAyG+X75M7RA9x2pRFNOzkLaZWc/OpgZwyJlfkJ6K11NjPhRFyp4nfbnb319IFyXHY15O1l8c9N
 1LQNC0aomtYR+yzgzUDSCzssFoTelJDQ070rKRYtHY4p0wgxEbE3g1UFWDHCEDdIeTFQC0JVqPM
 vLbaqHUmRgilrqZ+/qSTcxcy94imXTRRnCtC/+yuq4HukZZ8lUQiZ3olMJILWh8hspcTa300vpC
 rhSidkRsPyauxy5e28S4qTrN4GTE879oJQt3WX5nBAS5VaKTb23I4KNgpBas+Y6zvLVDaGphqo0
 3wKtHItg==
X-Received: by 2002:a17:90b:57cd:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-3875883a245mr2294141a91.23.1783377246681; 
 Mon, 06 Jul 2026 15:34:06 -0700 (PDT)
X-Received: by 2002:a17:90b:57cd:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-3875883a245mr2294111a91.23.1783377246131; 
 Mon, 06 Jul 2026 15:34:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:05 -0700 (PDT)
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
Subject: [PATCH v3 09/91] tests/tcg/meson.build: introduce env_var
Date: Mon,  6 Jul 2026 15:32:21 -0700
Message-ID: <20260706223343.988769-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXxO0ZNu/Kx5Ml
 Fn6bNViHm6wvB1d//D3j9gN7zeVjoTZhv8HkfqF8jlboD7UKL+ulFR8RD0bHdxGRSes4vsma/yF
 PL7LyyhNHNTw8u4V2f/yqBTLr91vupJctt6VsauHLupM4JSfx3Me7BJg4gBePyAb3U84zU7h+lp
 YrvZ3L7JTc/JMhOhiePropqjQrJj1+O6bh5WrfQ91ELNIlEemj8AqkWAdnbS9ZAgUe9sKyfM2I+
 Co5fjUnHNEwSsaFNmntmInQv0YayWfWOM0Ya8sVYzEqqkUpuViiIQXFbAoGmO4TB7blnnSH+6Jr
 1b5x9wZJ1KVWibQG08/q5FMiXwZo20TQU2/O9ZW8hoZDtfa7u3qW7n4GRdQhmLYA5em93oKIJEd
 rPxZxF8WEHflMOxrlROAVffVnKKjEs555OGTzET4UT0gfz8YxMdyZYU4wVhRDxMPijcZfDiT48h
 nZgANwiURFlmLEFW0Gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXyi0Lvgb80hCS
 25OxTsBPCmn77F2YWqOENz+D+89nrXOUbBZPQCOrhTAYI6o8r7M6Sojy8OtS1S2LAT4RDAcnXTb
 NNZQNWixwUfAodFVNWmhIUjMNAKyyIU=
X-Proofpoint-GUID: o-Bxh_H19YhgeD6zfMVSxwnrmoxq8adE
X-Proofpoint-ORIG-GUID: o-Bxh_H19YhgeD6zfMVSxwnrmoxq8adE
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2d5f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8c82a49b3ec..0acda478198 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -15,6 +15,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'env_var': ['VAR=value', ...],
 #         }
 #       },
 #       ...
@@ -57,7 +58,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -122,6 +123,10 @@ foreach target, plan: tcg_tests
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
+      if 'env_var' in setup
+        cmd = [setup['env_var'], cmd]
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            suite: ['tcg', 'tcg-' + target])
-- 
2.47.3


