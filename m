Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D08C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG93-0003Nh-Qc; Fri, 26 Jun 2026 19:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG91-0003NG-Hn
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8z-0003y2-Mj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:35 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwqEX2164224
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4iPG7HgoCwy
 yn3cVBfy/apwnSNpE2+3aArsuuasPz+M=; b=TGINbvTjC0twA9DIVN4jPw0+VqN
 qbflU3L82n1rsb2yfKyHtth1w8Lvyu6zKRlExEVnHJ5BkYxwS0OW/VS+BE34WjvA
 XnMkXgzc0GBlu3Z12q9+AvMjgUhOn9il0c6ZWLLGctI2PprBKyOHO2WElHPgt8zN
 nk7I6xd7CHyG+alc45bHRWsEWlolfpiO03CUq+Uhv9M7g1YFmhDagPWDQF6NJFy0
 BCWEU/Xm1S07zhC0MB+2GlvL87Y30u+RUoUDMo2ZAj+YyAT3uk8CQDyoP50yuFEE
 ZyT6dnfPHuKiQGz5l1ONgTlLf0gNKWKd7TQiZvVGShuMRAzoqP5vLvmX5oQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgdvkp2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c42d96713so1188214eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517172; x=1783121972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iPG7HgoCwyyn3cVBfy/apwnSNpE2+3aArsuuasPz+M=;
 b=Xd1SyeLiVXKPLtksjiPRThGUisNFSI0HatPb93M/hONCmJS7K8DPklPVkFdM+eHOON
 mEVOGrj0RJcBRzimd/6fyxED8VDKbWQilCnwC+p4OMqFMfrXyA8NaoE5JNMIPny/cjfQ
 iEfEpPnQVJTuIgfuUkfRdSuxqyBKW+cs0omZJbZKl2R19aZ2dWRQpG6N6bQDPOZhVohh
 2gEFaJ9a2nJ3P9h8+G3yDolhYKNKCOKk6usL8T1UDCI8vwBsj/5xb9h/YyHlvaa4o44c
 nHbtb/QA2Xf6rT+3DGe7IWKdm4lQf61B8Gr5TPKPTgVFmnljHHkyPlDaXhVIA4tDewrn
 DkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517172; x=1783121972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4iPG7HgoCwyyn3cVBfy/apwnSNpE2+3aArsuuasPz+M=;
 b=UVpvV6LN9BQrofY+6K3iOHsCL8zfyw2ODLZX6gV17RNedUZ2HIybtchUYPy+T+A59M
 SZrypDYT6b4MtGSyBPbrlsth0aKDNpPiao8RqK7dyhnMeiW5jdAdjfNIsGf46wbbLdRE
 3sJxfzsVd25Lneu07I2RxzB4sAtlwIhTBxaLOZQDYjhy98KlosoGu1W979uyehtPUKV/
 7zCwWqTsVB3fAxqKMHeFfDltysMz3/uw3jJZTfou871Ie9QRMXNjS6jU/28eAJ0xlNNG
 ccERbf7hm2n/Ndbrlyx2OUSGpHE1wY9qu6wHXnWAZYN3lD8c8ov7JJ76IGWNlm2gYpyg
 wTCw==
X-Gm-Message-State: AOJu0Yyn0z8pSfnIg9z9QjAy5RfQws/D/VQ9Df4TQx9PLTW91Pkoutt6
 wC2F9w5pHZt+XsX0SCFYe69cegDxaLy8x53DPBae53uGXeHdyfKpp3WKjbm26fXRC9c4Jis2Uhz
 egqp9J/f2RfepM5EgXlrC7sl9Zb1F/YMMhZpeCYjQ+GqInt2zH91NYdFSH0zbCBbGwQ==
X-Gm-Gg: AfdE7cnWpjmsyppXydgUjtuoNk7cBPcBhaV0yQ8MaIcqAhvM2SzU9pEt6EUdSKQctEP
 jtfPi5qSJy8Bn3Rf4Iauxj6d7lt820MfjoocyHuscc+TkOMn0VhFHS/XcEV7y5HFvbqIHJZeT2x
 uZUIEDggHmzrp+kragH4cvqxQnIFFRltPjJcYsgZXq6XPQNafy21prv0SVF6mFF7uc0kmhttvOw
 Zq76KyF9c/qLxIXGXr8x0zL/XPJYO+ZcS35J/fUp41bJSmUoVwHcY255WtXEloqQ22ZhLbrzjsN
 u0SSdULW8FjHyd0aVok4hdH/BkKCXbvlOwmJQ7fbfyBzMnMuVZsQ9VPL+htPy3NLVo7+0oqxJGI
 8Xlko5coVZ+xTxR/6LRnUm4xDAga7xPLxuwgXkeLwzUT1Bpj+6xuDCh94zvaY0vxObWiVcoRa3m
 aa6jfSbg==
X-Received: by 2002:a05:7300:6143:b0:30c:ab4f:9b9e with SMTP id
 5a478bee46e88-30cab4fa14dmr1882158eec.38.1782517171478; 
 Fri, 26 Jun 2026 16:39:31 -0700 (PDT)
X-Received: by 2002:a05:7300:6143:b0:30c:ab4f:9b9e with SMTP id
 5a478bee46e88-30cab4fa14dmr1882133eec.38.1782517170931; 
 Fri, 26 Jun 2026 16:39:30 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 06/37] tests/tcg/meson.build: introduce test_name
Date: Fri, 26 Jun 2026 16:38:47 -0700
Message-ID: <20260626233918.158740-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=API5kwXb c=1 sm=1 tr=0 ts=6a3f0db4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX4spIjS/cv+H7
 zPHsnuazOpUoqg7JmlROL1ZQCiqdlxlO01CDNc1R1RFAYyRhdDqLpU/I7WfQ5lzieKeT8QYUsGT
 B1YNcZDTC4Y3ZFwGHzNXV5iDapQ7tQX+BSwAAoVXKE5q0RZOjJY87FVI2CBqNvfwMz4kGEo1S3X
 FzOitISE1RsMWzRAngCNYoHaowNSsd4mZrFWsDA31Mm7HgKCqtBQfdHPeugh6yaJsr139Ro47A3
 mWmowsFvzbeqUqKpu3PL2Hh50sZvAVrSEk+DmLAAP62mTut2loADCjBlEoLXCf8F86Rc7QBwSXt
 ZYc24kDQuHVYX1yodPNO+3hlxXhRVJq96XfOYLkmqukrDwq7QCVPn+FRECdp8AMyBW3FgVN6vAB
 SID1Z0r5gOnumGZvW1AgWosXQ7oi2bh1+JLwF1ZGgZJvztFc4uJ0+B0ZJvFzZe9Dzxd49w3E8Tz
 nUCDhR5akSzf53/PE6w==
X-Proofpoint-ORIG-GUID: EuC2ToJsBMPFYTmGKXCRMAgg6Q2S8N2B
X-Proofpoint-GUID: EuC2ToJsBMPFYTmGKXCRMAgg6Q2S8N2B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX3BYh6RbVcagl
 LTo4FQzdHXOA0RovIBtdA3cE3oWhbjBHd8LutV+3frpKv1qlssLFN4jx9wqRqoN+JiD3FruPYbz
 j5MHITuF0K811mo+LfmdRCTCILlOw9I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d2b11bd6593..49c8681e53e 100644
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
2.47.3


