Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4102C43602
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG91-0003NC-D8; Fri, 26 Jun 2026 19:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8z-0003Lj-Ph
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8y-0003xg-57
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxNm22462823
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=25zx6GuWmhD
 JbEk0nfCAbhn5IDgkhlVN0bBJlhPbIE8=; b=Gp4EkwHbQlTUg3AVALiBVlFdBlC
 IKkjIijZZA0ustfYfdVcMUL8GcA6kJWMjep8dqB8L6lK6vjWF+C7/renj8xFu1On
 7tUddXqlwVU7CJPGrZPJLYvVfGHhL3Hct9kR9b+/cJP8tn1NNINZ6Ff7yl/O49q0
 Xk4b3ZpVhFhS/M7eCTTypBQ/nfJ7rNmMrZkE5by2EoELoQ00fd5mMwtmFYbw2nIe
 h8FoGtTxHZz3PeLberYxXss++3Q5gmQy2OJXq/HJ+GchPDMXXHR33wA7Hm9gB1Az
 o12ktBZle5WX7qZml5HAOnOL70rxfA1qTuKAAW6Z2EJNzLLuYwnVsa27x1Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2tu0hn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ca81e05bfso1093983eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517170; x=1783121970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25zx6GuWmhDJbEk0nfCAbhn5IDgkhlVN0bBJlhPbIE8=;
 b=eUKt0erUMM4wlGt8QjMuvUCldLkvYSAIs5x4h9gnXTx+tqpVY6Zj6kadhqDrdGEPG2
 CAchxoDen1F6dyGWQ776HhvA+0pWHzYnLDLY3+a+Y1EEqEYub+HwP808gK9pztjmCT61
 M/Xanj5nneaxHj6GKQ/eH7xRQmsqxdR96yKHixl/fYmEvSA1V6DfIVYNjiACTM91x1r1
 0AmbIB/DHGN3UMHlHYcPyMY/GgpuMjj9q8rTaSm/NPAUEPZwRY5N/Go6FglAULuISnlG
 Ej0e6zU+yMJuSmTGCewDdctEDPmbAxX331K1G9eVZbinGhBE4EY2HYVKGXkjPbitwvRj
 DM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517170; x=1783121970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=25zx6GuWmhDJbEk0nfCAbhn5IDgkhlVN0bBJlhPbIE8=;
 b=nhOh/eJXzTU8Z+VT0gGygTCR0PhxZ1UTW1QDR1j7GvETkOjbVap+RVHL+Ytf4uN1sl
 5Fx2O40JvcxT76kZ/h21C5T65/oUqTTDlxfkkclIHQP/P8GdWfdam+/HkwcwIB3XB8NF
 SFklpkEBeKml/dv1slCZ/FVa/rXp35OQQLSPE4rQ+uTkV5yzx2W9f4PDEVvSLqpd1H49
 blvXN3gMhQAIYeLDINgXAVTLa3emB0kzL+O+EMq4o1AFGRdxUeAOTVZkRa3gTuns4tFO
 rtPqx65/abZ9fg6ie8k63uyCpEjxRVcYnLKEp2YdB7jy5ZMXsHgd/QhLqxfbe9besYsc
 70RA==
X-Gm-Message-State: AOJu0YxwKZDt+W5fJ2vJFmAd7qFWZ4gZzb/OTz6g3tNxMDETFjwScuqK
 Dly9IiC4IAbtEgNarTsqga+QpH8AFA/WVZ8ifvybKDGxh8YC1hsEaQ34g8mCOPawi9OJYO0ue1T
 GKBChk/HTT1Au3Mr6WMNgerxOZRfyqKhKhAlXIqKwG4fRp4fGKyKsIu78W8MP0qSJug==
X-Gm-Gg: AfdE7cn6Lz/RiTbfwp9AgGB4AU6EnSopT+o03emAmuV3n+vioUpvqYT8PDmSyKnxI9c
 +3m2DkmiCTCuP6lT5TcgUAhjcaekl602eQKBKulVHb4ombGwOnd6nN6dRlfrWc5vjN1TjJqHRxb
 Y6J+8b+2opKvo+NlQtwKWb02mqTqbQPe/Kl7QMaKMcqm9HHROTxpAfBt9Bbh1c16HYilAnN75E2
 D09YNZJwBfwvGy4BWT0hj2uG3G8yDmQ+puf1pH5+rovzWVKTmnxUX8y1eBEjMHj6zPpwBZXgKU+
 qV82zQ0kPBbA/xAuOZ9TBIhRLsFg03gmPHDPHns2rCZrswH8YbEaeqtjmPcsrs0V3qQWB/r8MPp
 /0R2CT8eZ79m5HA2TNWFFnKqXp9jHTU7nauxzRA01s0iAAGnccTjwE6z3Pily9FsYTfv94DgDuZ
 W9+mLAMA==
X-Received: by 2002:a05:7300:fd15:b0:30c:ab4f:46a6 with SMTP id
 5a478bee46e88-30cab4f48afmr1730410eec.42.1782517170163; 
 Fri, 26 Jun 2026 16:39:30 -0700 (PDT)
X-Received: by 2002:a05:7300:fd15:b0:30c:ab4f:46a6 with SMTP id
 5a478bee46e88-30cab4f48afmr1730370eec.42.1782517169608; 
 Fri, 26 Jun 2026 16:39:29 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:29 -0700 (PDT)
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
Subject: [PATCH v2 05/37] tests/tcg/meson.build: introduce exe_name
Date: Fri, 26 Jun 2026 16:38:46 -0700
Message-ID: <20260626233918.158740-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX0XoyQPJpVOzL
 EUf8RFww/kxU66yaTBFjhakCZtJaiClvhIe1IhEdunKL2NtUkIw8fqPwlBTZiIbXtxHzxhKSp2W
 q5i2363sg+cIdQfFBgmyj6xc6x/fgvI=
X-Proofpoint-GUID: 1qq5VJy7fv_Np4qi3XRuvjBDxjtUUEY6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX8MFTLQyyU5b2
 oZsNcwpJC+g6/RmqCYJcLxVrrqUx20BYc9nxubpSeD4nYWOTmRabTwst4zWDgPnGqn478Vj5dDB
 4aLBiXR92Axaxvjr2PCgBxbRVys84RlnS6B4cpWPe0GfF2vCbNAqoqjPvkKuBGbAeXGGBHSs7Hh
 iJlpM/amVnXR31zpcuMcAIaaYvwWz5xfm/nDkzrq3js0Zqjc3MjbWps6k4Wy0QsOSBhnl2F/sqJ
 UcufG+0ZydpftzGm4KJb8APCUAOB+sRqOG9UmDZTw52/bhZHE1i477bPn9wyBw2FIZ7RdWnShrh
 5TUadjDHLZFtT6VrXSim0HbXZSPXH9mjCmwyt9QLEamUL/ftzCMRrMElqgDk5mFtpXVqOPSYLnF
 Kr7Z0oF2JqsPQwg+h3XXZPy6Rj3SsW8IgtTTMZBTWvd4wnvvT1n5aZnnfrumoK8ymzJyDNcM5AO
 lJ7V+khOgi0j/n9YGag==
X-Proofpoint-ORIG-GUID: 1qq5VJy7fv_Np4qi3XRuvjBDxjtUUEY6
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3f0db3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=vdizb8zAaNHivpZOFqUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c54c503eb17..d2b11bd6593 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.47.3


