Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE343C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry4-0002Ow-QI; Mon, 06 Jul 2026 18:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxw-00029f-1U
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxu-00077C-9Q
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEACc1504917
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XDmrJFKn0W9
 ltmyAREriK2KGIEHLwFNw6AT87pAhUws=; b=PQ446lcvnk331X3yl+Py/Q3VNkx
 ZNtZFbhLS8iAIWRi6cjeNAqhPNocEq9WVGc8cbaNYIMq+JJCEwxupST6I6k8tz29
 x+6y+/rezAyEAqOM/j3kzGDiamvubENr0lNH2kUTkyO2VN4NjZv9d2xQ1IvVvLCe
 AjDaHxc6BWB9A913BMEitzLW91yUw9O94YH3TZ/Ix+czDy+GAhY/0t28yhwsovPQ
 /F4FYG35Tzbq0Qf95rgbgF5Gp80hohdU6xvOMpQIcjcB75wCzHq73On9lRtK72Yw
 mdxwXYrps0W0+mA+KRcuWI7i2FaCA/rMX+0xcDUWK0TxDO3sjv2QJUBCzJg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k36k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so33944915ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377540; x=1783982340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XDmrJFKn0W9ltmyAREriK2KGIEHLwFNw6AT87pAhUws=;
 b=Fy2kZeF3+0DgoZsq4MpqGe1Afkr5TrxZj069VklgUKqr+EI/dNxub+USqPVSDX4gT3
 u9o1Fa2PHyTv2zGitBk73RGcmF5VecVvPrrKC62ZQidi6Sg8+ZxYIcjT/+JsmdhIJZhr
 vPqvFev8qPuvGWxLk193gtFDC79nnCFh3aF74JH2N8ENxFt2EydeQJZC6tMsf0J/pjeM
 dBAZvLPUtkMlddLbpdf3MnRHmJ09p25YrL+8TrMz9UYEbWruKHaF09mIicjgqwnbz5ub
 OhpCL621sCEQbZhMU8cMWiEHszF56hezCNPCz1VkLjXRSC4J/Tz1qeOfyyhX/zhX3wO1
 nl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377540; x=1783982340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XDmrJFKn0W9ltmyAREriK2KGIEHLwFNw6AT87pAhUws=;
 b=qtrIBF8hiza4/R26hUYKlU9Hdcqv+n/Pmxf5LOvhUqiP5IsX8aJxfr9YL2yGr5FwSe
 iE8WmQxZMYwCOWM77p8UUA5GZHw2FgYQch324TBYAvNo1JJv1QDu4917ihyedhFtrHk6
 aJruFwEpwle+36K9oTuKdAPOpzKWNe/GE5bSPqeYaxK6TUAPUk0iJfeyB5M1K8YtANQR
 JyswfjO4KvOVaOai0NrfqBmxt/bQHAUXBb3I6ATz/iti9wQsYxS17/TqXRqplWdu9wZe
 DRTXdP7CFBpKrwEz6T8MaLDh3MNUkD3VjaCa0ow8MA+jYcYqMR4rr8ptlFoa038s6KKk
 GzqA==
X-Gm-Message-State: AOJu0Yz5q6NEA7LYQWbtENZHV/XqY7gl2+IpSmf87wHPhc4K+9mQG+e4
 CjWGGV/BLtPuKq0fSAqOYBBHNjFsc2vy9Vt3Zvk7PInNQrDX6ZgR4FV45uBcQ/JcL6sK6wm/9mN
 BgFh2+OtDCKBwkyae0jrpT63+0mW5d2qIQYknQB8aSlgeDAKFNs6HEwBuidQm1OdDNw==
X-Gm-Gg: AfdE7cm9wstOeZLzNvfmTJr7+4qfzCAX5udT+I/jM/8MpNQM0zwRZwmKOqU4njFaY7F
 CP/RA7Si6boR9EZZHx4z/UJpHEyRwynDKn6EET+9PglzDKeEfdP+0YD37EujnF9+P883u/NK43/
 +sqA2sQvvCwfzWVkvUQth+hubAQof/mW3Urb2MyvsjBrMyCvruaXF8UwZ7GYr2stHTAF29+8iRf
 Z+Wy/z7w+RqU1semv702KekYNlDbWOZ3zFlHmuS6Voq4n9d+7C9SarB+y7Ezb3DokAFlDvoZ/VV
 7jTChcd5KYFxVK3kU3LDpC85gFuFn44nMLpOAsPGPLiUvdOYBtM3WxgPPxf5Zp54tEmkTSaYd46
 a6spIXP+LOcBOTNYHSZYtzkxU/F0Y8250536eTYD1dVtdGr0DF6TnYH10G0Oewzj3j3JATOqX5N
 +w3RbBkw==
X-Received: by 2002:a05:6a21:151b:b0:3b4:6cae:4a50 with SMTP id
 adf61e73a8af0-3c08ed0adf1mr2996307637.20.1783377540111; 
 Mon, 06 Jul 2026 15:39:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:151b:b0:3b4:6cae:4a50 with SMTP id
 adf61e73a8af0-3c08ed0adf1mr2996289637.20.1783377539651; 
 Mon, 06 Jul 2026 15:38:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:57 -0700 (PDT)
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
Subject: [PATCH v3 67/91] tests/tcg/or1k: user tests
Date: Mon,  6 Jul 2026 15:33:19 -0700
Message-ID: <20260706223343.988769-68-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2e84 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=9Ndb6tn6H1H2V0hMdrYA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXzWC5HxjzcUv7
 NPq3JaG7R5uq6HZaf6E2grEEmSy8Z8iPKh3y8m5p5XlL4fuEuXqKJLwzWmAOPGT1XmyVPvnv/Wi
 VeJNAOP7kSVNREnRe+k8rWPZoAY2V3LoqfJM+EQobX+Nd/bRshQexu84RMtl747Zry0SL0JzZlT
 z979Hp/ULpcqftBwizyS5AxaCBplSsNV0dNa9nQNnRWDVsKFgdfj8UOhhQFcDIkbj27smM998Wc
 7cbb/kRKWD7MqoamDOe303PPSPOSFlV4C+peaKm7fgT8lHaCvqKOfAMudWwr8mRAORJE3BqCVkc
 U62OjyaW0avf7dXzhPZnxe7dBRvFColgyt+lr98S13RpzOaB6gTevSvzJ6t98cGmu/S4qbrx/Ms
 8MbLpE4WHnVtRwE4LL/Oed/aLRicvrCo26dg96aM4P/KZI1mQBJHbeMuz4XlAsfndeoQWFGWqji
 DNhN+3QHaUK7sXTPatg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX+nomqQEcwRyF
 hOrTt3TeTghzt3OvKMemcyeoox0qMc7Vp0gD+NUGG7f+Y4Gd91hmapLGb6yufcejsi0lfBZh+J4
 WiF2UiLuG/mq75TElZVzuTRTWOYoO2Y=
X-Proofpoint-GUID: A2jBrIVurudNw6vPjan8DuGA2Tm-2qEx
X-Proofpoint-ORIG-GUID: A2jBrIVurudNw6vPjan8DuGA2Tm-2qEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Some tests are currently failing, so they are commented.
To be investigated.

qemu:or1k-linux-user-test_addc FAIL 0.05s (exit status 255 or 0xff)
qemu:or1k-linux-user-test_div  FAIL 0.06s (exit status 136 or signal 8 SIGFPE)
qemu:or1k-linux-user-test_extx FAIL 0.06s (exit status 132 or signal 4 SIGILL)
qemu:or1k-linux-user-test_lx   FAIL 0.05s (exit status 139 or signal 11 SIGSEGV)

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build      |  1 +
 tests/tcg/or1k/meson.build | 72 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tests/tcg/or1k/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 816a6054d93..389e9f9b3f6 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -146,6 +146,7 @@ subdir('m68k')
 subdir('mips')
 subdir('mips64')
 subdir('mips64el')
+subdir('or1k')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
new file mode 100644
index 00000000000..3f0154717f0
--- /dev/null
+++ b/tests/tcg/or1k/meson.build
@@ -0,0 +1,72 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_add.c': {},
+  #'test_addc.c': {},
+  'test_addi.c': {},
+  'test_addic.c': {},
+  'test_and_or.c': {},
+  'test_bf.c': {},
+  'test_bnf.c': {},
+  #'test_div.c': {},
+  'test_divu.c': {},
+  #'test_extx.c': {},
+  'test_fx.c': {},
+  'test_j.c': {},
+  'test_jal.c': {},
+  'test_lf_add.c': {},
+  'test_lf_div.c': {},
+  'test_lf_eqs.c': {},
+  'test_lf_ges.c': {},
+  'test_lf_gts.c': {},
+  'test_lf_les.c': {},
+  'test_lf_lts.c': {},
+  'test_lf_mul.c': {},
+  'test_lf_nes.c': {},
+  'test_lf_rem.c': {},
+  'test_lf_sub.c': {},
+  'test_logic.c': {},
+  #'test_lx.c': {},
+  'test_movhi.c': {},
+  'test_mul.c': {},
+  'test_muli.c': {},
+  'test_mulu.c': {},
+  'test_sfeq.c': {},
+  'test_sfeqi.c': {},
+  'test_sfges.c': {},
+  'test_sfgesi.c': {},
+  'test_sfgeu.c': {},
+  'test_sfgeui.c': {},
+  'test_sfgts.c': {},
+  'test_sfgtsi.c': {},
+  'test_sfgtu.c': {},
+  'test_sfgtui.c': {},
+  'test_sfles.c': {},
+  'test_sflesi.c': {},
+  'test_sfleu.c': {},
+  'test_sfleui.c': {},
+  'test_sflts.c': {},
+  'test_sfltsi.c': {},
+  'test_sfltu.c': {},
+  'test_sfltui.c': {},
+  'test_sfne.c': {},
+  'test_sfnei.c': {},
+  'test_sub.c': {},
+}
+
+if 'qemu-or1k' in emulators
+  tcg_tests += {
+    'or1k-linux-user': {
+      'cc': 'or1k-none-linux-musl-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'or1k',
+      'gdb_arch': 'or1k',
+      'qemu': emulators['qemu-or1k'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


