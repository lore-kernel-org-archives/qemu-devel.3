Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB86C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9A-0003QI-Iz; Fri, 26 Jun 2026 19:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG99-0003Ox-97
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG94-000406-Un
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxBHI2675862
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pJWsk2ojtcgw92LwGjPWMswgUVyDfpZlPL8if2Cj6l8=; b=XTokW934bwI/gXaB
 LL9UHwBroFhHSn3f3aAfQpdBq/qNRkIg1HmpWNDfyTH/WwRXTdl7M5jK7s8Sx7Pt
 esZh3HZQVDKGvDtFMXMhGNQo50fK39e+CuI2v2Rq5ATI5LtYnf7+uBfW8M5Ti8CE
 doGyNuD+zvPVU3GzXNIgLqNHcbvVtN7UVNsphIXo9Gr6Matb55zb8HJRE/3gfycX
 xvaYmP4kdzWD1sof4uWrsm1cR/nWIwkOW4qHYgFaby83E6YppRzR/EM/CslNa72A
 y+kzYQKUjRDe4yaSheSSAUxDQ49KVa84ct5AdfwVW5O7PcOWPZBazjrNOSPpwA8b
 WHA5fg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xqa8uwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso376889eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517174; x=1783121974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJWsk2ojtcgw92LwGjPWMswgUVyDfpZlPL8if2Cj6l8=;
 b=Th7Il7bTLg37wLnZjpWngPZLmnItvGIvGpRPJD/+/idAUpVebiQBeZfj7mDGzR0yJO
 vYfJp8w9ny46XUjAQXo+q44fP6Q+nAr1c8mlzp1eunadDQBxOS2vC4QUSi9siG4hxFts
 DxivVZxUBcDU8n2p3MJiuEZhlEBMjmk0X8oQy40R9RnJV3d6HKUZzNHqjIGLepCLJ6jt
 HhZ3/VCQ7TO+qi8cddCWTg5dORDnnCfQbMpBYZJusHUH2rwQ9xX00tGYZwOOs5m+lNAJ
 rk+dJ/jllLw30Zv8hjpiRbcScCvXJtKoim0v39TZLs56mI9SkqMaM300dKFNStsKWKrk
 4p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517174; x=1783121974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pJWsk2ojtcgw92LwGjPWMswgUVyDfpZlPL8if2Cj6l8=;
 b=ZutOHVzinFu9MYBg49YXs+u1TRmke2tBUhbleneg4IoZ9OU0GLPTpctfh/EEwnhLaP
 RrFQ6s3omRtlTNE1xrhrVjPuGwVwKu44MuKV4g0M+xkiOCxEEJpYWycO0dzS62u21QqF
 8AskTZLMkV3Yh5I323b6ip0dx4JHWNlF75mkk33r8bEWO1bJI4WDl0/c6UA2pNDG7/4I
 A94GLSWUJQarc7/sHQUr7FXvrYNLLLcSLYENiHV/t0MSJE8bhjbf90/3Fs+CehZHWrIQ
 DcEu7zzrSNCjen/qAsUH+Zd/G5EqTvJs2+5qCmQVTORqMLiWFkUJ1lHuoYR0ifIetnKM
 aIuA==
X-Gm-Message-State: AOJu0Yy3RdHYUCor94WNX5cETDenVZL9MHGTTvWldV6Z/DQQbB0uzA2S
 FE/igu3xpq7dQEt0J9Dcj0uJv3Y2JF8sWnR/Gtn8fHYHy4jr2veXBcYhqN5eeWkqXuKFmzFkISs
 iur8bcTYDDtV5ItfL5mvmzMe+5pbFoXjT185PZ2Fza3a8vBG6wN19FsKxkVgC62b36w==
X-Gm-Gg: AfdE7ckuJ1ZJWSUst4KHfI666ZbE1fLt7h99MEg8tpzbM3m9JN04EeIsXj89G2gqHSY
 l0UtHE+4SeHvGuUE3nzrhoHvnxklSBtHTjaoYqaDVmEq6z+q9j+q0Kh8Jpmojk24uswveG7WDPS
 ont4+wmZU15OTo2eteDUMWMZB5bHDjRnre2zO5EeiDhSKgAu0AHwk+uiizBHWEWle18bthtWr8Q
 nhCy9Cik9HVWN7nzxBebF4XlmdsxQSUviRc6B5+F5QgGEiJxXbleo9NtmvScBPT7HNsCI5rQfOM
 09moS8CV0Ly/BL/gOLnor+UnuMXmo8M7cPpRDqd/VpnJPAb9Z8gr3Y1B07qiA6mWnW7ctE5afm2
 OrxbMttrBaOx/0rLGn95uhSwwLgXIuWLTPlsWKw4r8aFEKXM7/2MNEtGStdgO24gSdv34d4JBvK
 yobPLoCg==
X-Received: by 2002:a05:7300:e801:b0:304:2e00:5fb5 with SMTP id
 5a478bee46e88-30c84b2cb38mr6657291eec.3.1782517174244; 
 Fri, 26 Jun 2026 16:39:34 -0700 (PDT)
X-Received: by 2002:a05:7300:e801:b0:304:2e00:5fb5 with SMTP id
 5a478bee46e88-30c84b2cb38mr6657269eec.3.1782517173702; 
 Fri, 26 Jun 2026 16:39:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:33 -0700 (PDT)
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
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 08/37] tests/tcg/meson.build: introduce qemu_args
Date: Fri, 26 Jun 2026 16:38:49 -0700
Message-ID: <20260626233918.158740-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: o1OqnZm11zZrKsbiiO0Wne0OUe3GtYYA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX5wSrv4DM34QY
 4P7h59jruRZER2S1eJtJ3bshdeTdU7gFteVNHis5D6B/+OKIvKvLgA4e1EN7HqLOVe6pzaw4E2q
 K9USvOOCdX16cffcq/ZUAWgmjqQYx3c=
X-Authority-Analysis: v=2.4 cv=GPs41ONK c=1 sm=1 tr=0 ts=6a3f0db7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX5QYMF2rUSfb4
 4QUcNtTfp1l5NUdUPiWCYWoPRZ4Vw/aonKAHxhK/QdvHZpLNRTUNWlEEdtuddT0QrdEhdeqdwbb
 hFUeZyfDw7xMuVFzUlSu1g+ma9k3X2YaMEAcvOsKfzzSwhDn+z3aqRlKvshMD1DVFDx5SpHmr6T
 UnW5m1wkEwpg1wam0Nbigw8XAuChpGKaTlZxC7vXEiBzZMjqurk6ig4fHYsEusUOWkh4Pel3oSI
 YMJVqpummxSFTTcVbXR5yZwjR2mfqU7ULQBqJyzRxUJO9h4w6oDcXHaxk5i53eTjVcRLDPv7FCj
 HY8SlGvLbHhx70Z29C94Nw6el6fc86kvZuNk4c52GWj36sfTgTnWa+/aHlbY1Vs5iXl5ctjiFOY
 kN0yf7I1bP7kDBlTaG+Oqjyjac7eBXiUZqpbtwhnv+m2FMw5zy/X63rkHCIHj8x4CHsb0TN5+hl
 g1mRnQag6qcbe5ZYlNw==
X-Proofpoint-GUID: o1OqnZm11zZrKsbiiO0Wne0OUe3GtYYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
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

We add possibility to use custom arguments when calling qemu for a test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 47a600e4bd6..d1a5bf3deab 100644
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


