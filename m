Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159E6C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFV-00078j-5N; Thu, 27 Aug 2026 18:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFT-00078B-J0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFR-0003Bn-Nc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM1VP1117762
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=; b=RceKYX0pmeB40Qfx
 uSmX+dHtxjncQwXcNQHT4AhyX/OX0kkRDgC+TPpnHd2EMxZhvnQh1ePH728eDT2a
 kF4PLmoZs6b/zQ9QSwWsr8cWhniOtkbd4MlL6zhT1Jbnm+RxvX/BwfZrd19XWJWI
 4aFy1lFhY0F/+87WcemeJC19TsbwEGu2qz1Brbqo0OeBmmCOFyYSK9ZWLcVCAJaS
 JvkZ7SoG2vfPTUQl3Fnm5FneKy+ytPmvlnhO3vAc0MJPFiS98uWVaKSSUhNjWTQn
 6esNoXURgVyA0TRxO9m5rdqbv1byKQiOJDFZ4JQb+LUFyDvZkbbMESYGo5ziK3S9
 Z1NMwg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hed9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso226063b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868420; x=1788473220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=;
 b=L2baoUmS2dkmLce21DbRXw54+6I1pJSGf8PU4/n3YVQvdvoseAPPEyMvXsbzmalEPA
 0v/CBVVj8yWn0p0X2b3D+abexTZ48SL5rzhO0SQd7CU2ukXxDNQBLcfmyy59rLWhlUTc
 U/qiWlv4SLGVhKxvZWTwPuOJcUN//8YLOLjAJpm0oAChHD13VLuRCQgnNEYkEjjBPZpM
 LDDvDXIq4ZrEkdsNhnJsHr/ktLqDSNFiakdGwQ5YIy7gOOYqDYumVhybwW1US+FE6koW
 y26kYO4TwbExxnHyYkQG3Odqr/QefWVaF+a8mNh3Xtfdk01NmZ/ymxHH2JQ5uHsTHFE0
 czvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868420; x=1788473220;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vflMtiTx/GloD+fDZ2VfBCCuY1XgVEjEly+8gq/xKDU=;
 b=VmQuP9hq7gkqINSNeLTzTptTW0bLxcSaKgp/1rriZj7IriqWDvykitVICuLLiblPWm
 JG25wiz9vzMqvLIBYHqYBeyTl2Jjk7D4qBfeKkSeFtRd4hRnKeSZgWuo3A6+8qHciUJl
 j1xgvBN4PtmK+xMxWNZdt6ejPNKGiH2CFqyQoue+pavR704KCPDlFP+z4eB3DvhsBDD6
 xWI4dppqfBlBChIyAFnwIKiaQ6FJAGpaJ09RwsVZRHwTLVlY5dSP7mGAYHsNOFIRsNE+
 54Sqwt65Yor5lbEBhuNH4rl6mDZ59qo3BQ2W2lS0wxrHYeo/PnqFbufmFRXJAAQuAoQv
 KbYQ==
X-Gm-Message-State: AFuF++kUqeh6G5xzA1Geh8jTO9k3vgaC6DrYc4rGkASsueifOd+hqLyC
 U9mVl3zhIbs6KtLQFmeST0gRXDh71yA9aL06Bz5mKlN2Q3vgssGe3tfp9YPk/359RPcNpGCWgok
 GiZYSrpHq4tV1VUBodZgJkaoSLO4LIZe9TlWqLwb80sWlPM9SA4Ja3Zh6JOLOcdbHiA==
X-Gm-Gg: AR+sD10sBfBr6UYUKD8z/jQbKNE3mMa4thAuDiJUuUCk6XT18u1K1BGVSl2MKNyx2H4
 ikIPhAcc4Cef418R/1bMtsiryWT/IwUZYvKyKgZTKnJToaZzNwmqRQCfgQGtKE7DxWVFr4dUQXa
 EKkWWbZJO+NL4V4tFYNnvJhuWoYaavWD3c+P81wk7WHo1tjZMMDO53u/8rX8NHCpTMbbVjRIzeW
 b56gxpUHpunX8bIs/MPEKKtVKGuoNFe7dk6wIAzDI2ZFlHmBsT+74Q83Cd5nFrlxyVqdz6a87U8
 grZfpXyY32lzc4l0nESPg7u9XX2bZOfTrxAxpz5AAgEUEhb+VtA6BH//h/jxe+Qr/uJ8vH7nfs4
 LjhP43h/6sUv+dlivY5lceUHTJrsw9XihAFdmdTBsqVjqKVtcfQ1lKkcNX3Q=
X-Received: by 2002:a05:6a00:f0a:b0:848:4859:a45 with SMTP id
 d2e1a72fcca58-85628988a7cmr4503804b3a.2.1787868419589; 
 Thu, 27 Aug 2026 15:06:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:f0a:b0:848:4859:a45 with SMTP id
 d2e1a72fcca58-85628988a7cmr4503729b3a.2.1787868419150; 
 Thu, 27 Aug 2026 15:06:59 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 007/105] tests/tcg/meson.build: introduce test_name
Date: Thu, 27 Aug 2026 22:05:01 +0000
Message-ID: <20260827220641.84885-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2Yq4PoWCHSQi
 aeEjQrtLT9o6k6G6Ye1aj/UCXR6g01/2EV8kRftPj4/GszMXpZVEXZSmvspL0s6L+4PDtRdkg0G
 9MGimmf9y0+qq5wFRzS8zO8kxvu7l8tZQgyEizYVtzysvycQ7bEGZSNl8OP1IIgPPOEqk8OvCgI
 N14kfd1sgzKjok1hjjD1WDpXj2rHAjtXN6wl9YMqDRI8aeNwqBgTTn7LrKu/Gz6IWtiw56d8j4M
 l6/YVJpZD1hj595ADN4VnMmU+uSIr4kcPW3lvm+FkMsyBW+tu7xY+KrAMxBn+GIcOyEFnVJ7mMX
 Dliwl4Et/biKmLLZqK1dus86TtFspbdLJIMaCwHLXvN1Crb2IW+S/V7rSPV32PIHJcIERemi42E
 LJyoorj5TnNm0P5ooNV7djwmt9l8g4NkvykERZdy6QaScxa7HOFGVuW6IZd1lcicd05wO4ziMLB
 WIo1WEXGEIyOgTDmvww==
X-Proofpoint-GUID: qQ7C6Zn0o5vP5jH0ye6iH9BguNnRP0aF
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b504 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qQ7C6Zn0o5vP5jH0ye6iH9BguNnRP0aF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXyBHcU9ht9Q5A
 8dRnN8OMulO0E96CU1iZnhbGZypZuujfQoO85KqpfT6//nCOOfX7ilW1VvTqRbpNrKcl7sz7g8C
 ZjTAAreDU50+LZLCZ3MPUOZXD/PrSkc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


