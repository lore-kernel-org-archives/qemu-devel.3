Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B64C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bV-00016t-Dk; Fri, 10 Jul 2026 02:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bT-00016d-0j
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bR-0004XQ-BX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mssH3707448
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5asKIu6gYzjmUrKYnro3RAXgoJRh4Qh/hxYdDvseOyo=; b=P11OUy4z/XguLudU
 rg0QMtcgOLt2y7BhWJ7z9p3LYDV2aY9+YqMLKTdLXjZK7mKMQfphSqxwzuH8mcES
 mo7ox9V2wGr/rIdj+jgz6DncBTMK85A3bVHai28DB/T2yyMYy2nL2LyBkIgRicRe
 8RXoK+BKrnG6a3/08TWQlr4ltHCtnFiGtRkiv/EJF4NcRlHk8vA7rFGU0t2LIXFH
 wFa+7oe4wJ/vViypLftt6a8rP+vlYjqSUJpx6PV+vVG06G9EOt6RcraD3fNZHUT6
 oQBmkdTrWHYeo4flDX5jCvx2PRfVBMhs5ors3o5gCPzujjtx2x5LWaRCE70r9Wli
 792e+A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg5k31d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88ab059052so598454a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664447; x=1784269247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5asKIu6gYzjmUrKYnro3RAXgoJRh4Qh/hxYdDvseOyo=;
 b=bcPkXNuNy6NxnNKudgWdeEoaEu0GzDQeL3PQiJTQuobUw51MtlkxOIWr8VCb4rFrv0
 RJXmIRVWoW7KYQudWxy3pMkIttsCe7KZWcy1QsnXSshV7y5eDNf78yGXLBlkawJol2xp
 yGwT9ozqRBtejiZs9GLg/Bcvy+ROixbz2aa4/lvJVWo1HJsIH/h9iO5bNnzsQdkRBMOc
 EiMXtSDkSVMuHbAiknSCJH6CVVK6N87wQuy+FpbGYdTm6NjU66oVJbIt8ko5LrK1HULA
 kYVLESVNtZQS7ZZdzV8HBL0KthsPpQIdJx8FqCsdhzuIlhjB7g9uPXUOzlvugWFhiOdo
 7XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664447; x=1784269247;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5asKIu6gYzjmUrKYnro3RAXgoJRh4Qh/hxYdDvseOyo=;
 b=f/en1+gVBrrsCCSrdBjuDDjCVC1DF0z8mGUISgC+Hd0BH3wmO+lC0YHboIFDjEU1QG
 xym4ZBKIa7H5Gt+MN6de7jM8nizhMJ4RVc33iu7wNxzligm9TdNObfyEekMpE+B+MSNr
 XrkrWonUY+460Bl4KbkkMqPGn2x0sg1cGvGDMaCgOl1+v6D/Zxr/7X80q0Ijh2dWKplr
 IoSXahjK5HBTj4h/39Bsg2effRTQBqad09rpygsiBYd1Tn/PxzZfCzBF6clQQEzRg1wc
 l9vQg4RIWlZVx4ZZnMY/iZV3jVGw17FHYr3pcRdQHv1LWVzBFCe15k5MKQiDVLs2jizt
 yhQQ==
X-Gm-Message-State: AOJu0YwPHsFWuPmph4NERN/9xkI+wcX7lhUJQr2bKzuI4RvCziT3t+0l
 TWavSKYa+0O5BF+4OOSd1nsxbMYda77jy46Bf9OQWBSGLbOG/MLXtusDcpa5W62K1BjMVKkTUD8
 Bm12e2gKJG2E7JaZ7wuUCMNYq5nDyLc9qS6hvWeEgViobVyNBU23K0HAxLYnOi/Crag==
X-Gm-Gg: AfdE7cn5M9fybooBNZc8+OigZEudEgLRhRkr6VcjNzVh+C+4olsCSCrCeyqTRhzNg2L
 QFz5rr7VEYq9V8RUJbw5nPgQRfsqouet5gzS8Vgwz/eh+iLIYnfzVFsH9SzDoQMjHLPVteBpSe0
 b//U2TaZePMI4LybTeTMS2/Snc+kPKoJLqQIk1CZ21e27m787bycU8g0r4LlGBh18xz9epdMY0M
 RIbmDGeMzYr4dREIupY+a9cR4WpZXzGlFTsHXl13sRnEUQVIsJWlHBO28eFuI6n0k7wDrk+1ihG
 8FWM23QOa5PBC+kEWstcBJjDGB8pPq5Q02AFXnDcKUSBL5wsqjvaRQdx4NCKDGLAOOyGfnD9K75
 oqnAJ091DfxuIpVOvTioxHOtw7T5dlmlfCIde332fLPr/NNVYq06y/lmCRpUTVJ50sowutkc8yf
 MrNYRfuA==
X-Received: by 2002:a05:6a20:cf85:b0:3c0:b598:4983 with SMTP id
 adf61e73a8af0-3c0f0bc744dmr2587400637.30.1783664447268; 
 Thu, 09 Jul 2026 23:20:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:cf85:b0:3c0:b598:4983 with SMTP id
 adf61e73a8af0-3c0f0bc744dmr2587357637.30.1783664446777; 
 Thu, 09 Jul 2026 23:20:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 11/97] tests/tcg/plugins: build list of test_plugins
Date: Thu,  9 Jul 2026 23:18:49 -0700
Message-ID: <20260710062016.1818125-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FN8rAeos c=1 sm=1 tr=0 ts=6a508f3f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXzVNIEgq2g7gi
 GkeDcNkWDKzDzXEHJP8Tan4sy6+8qc9F4xywtXjIUg90L9/D1MQqcYNQwLPSo8R+yyqXpyAn8g7
 5QrZ36zOVJ7dYAXTR64j00Dkg3DkPUg=
X-Proofpoint-ORIG-GUID: DPdIiF0ldGds2u74MW-t1FSOkYfLN4fY
X-Proofpoint-GUID: DPdIiF0ldGds2u74MW-t1FSOkYfLN4fY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXwvcCayP0rnHT
 MFSo23t22DKswpB6US7wQgTlTgSEK/ziMzGd6q1LfGJqTrMSjJo5OYs0s0pr9/C/qzJGbt1cV1f
 kVFEJl+UKzjzX31X6OsyXBNg+4bZ0SiN8OGWVvPKDQX+/Hn4N3htqPJ0lUb/3bh2q4dhkG4H/pW
 ddEfnTbb248YB3STqyR7eGaijsppMt017ud8+5ngZfMCfOsVhqdziYitfJshnAYoFja4zCu+mPM
 hVLIoUpF2yOCmmkraf6AGgywuB5xdsoDhHKQYkCTLIffohlmBeBCAYj/5ZmkdPtBvx41EMl7i7X
 gd1EmiNyk6uxwAGJqJLbatf0iU0Gzccs+DYsFWh188xd+9nKVvBj7MT+pY5qQVYyDf4253/2ZmB
 aHRE0rCcdqowyX3SEcNicZXvPWut5leeimiIucJYZlEdeIwqeXMfZd2O80vc7uudbNuxpbpSagi
 jAtNoNA59i3mO4ua0Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0acda478198..3edb525dd12 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


