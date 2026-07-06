Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxB-0006Id-7q; Mon, 06 Jul 2026 18:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx9-00066G-Ca
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx6-0006n8-D4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEM171613914
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0DxPzUHX4sY
 ggneOU2VPETNHaLhNxHWf4WVxwKyJQXQ=; b=KqzKn4arclaPuNAS5n/tELz1tZ9
 7qZ0o+MltkMWVinibEm2jk3G0VB0fOw70OLCrSuQaXpEY804DUxDP6s0U8rFidrE
 nAR+lXjvdjYUSczG7tCIRHIMv73CRYOUi32nc68yNLYVx86KK7SWwkuzYWhisCzl
 0l5MJJYgsl/tmARrFeZioc7rqfMwmBXnC7KiFMgJ+KsgjYdo9IJ4KTver/U5Mg1i
 HIrGbCdBsCbtACKnuvZiBUYinf+OXjgxIiAWNdagNpUB5l252wxhcaxM8kw8YNH5
 Hs77ZTP/b16wcCrsL6nS3l9LWtAT8nKfwsxQ6t2rSYhbT24C0voCl7DAwQA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53k6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc7e86e7c5so33934305ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377487; x=1783982287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0DxPzUHX4sYggneOU2VPETNHaLhNxHWf4WVxwKyJQXQ=;
 b=MVY5JxL+d8mE4sA0Wu7mPlw/iMVDQLTomcZLdVTKpBWIcKwKqTANwxAv9XpRzPpIQL
 6b+g2k/Z9WdFfRJt9MzBJb16G6KuhNesKDdprl4ezoi7M14yrZAXOPRfD4zsNASA7hMs
 6uR+ItAGX6xCZ0sN62VySm91NyyNovwrDxbVbbgCNXdVZdq/Kqy81FLXLPTarQXZoe2d
 RcQmzmryKMsQAGWA4u2iiP/nCki0RN6va3hAiQejKxBlfduhW9usdschr8rdSK9YHImK
 xkp2fDYbtGEsmvjpdL+KX/qGET9ry0bENbeMy1yHlORo42gH9piVFAUfosc5dpYUdR8c
 nsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377487; x=1783982287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0DxPzUHX4sYggneOU2VPETNHaLhNxHWf4WVxwKyJQXQ=;
 b=oxKcNMLfBMfnoSk2GEMe3bcMi1p/CTufz4vzQ9zrNSphQwA950E9RDspe0UvIMmj5z
 2/8M74tUyzHo2tObay0TYSbEsKdS9CVyStOsLMsdlamir5WbZDmXK1S7KrEZ1OKUVLDp
 7rO5zoGHQpJPgg2JPBkvtEg2T8HaVTn4lOCwar+ZribB5XU4bAujWAA8Z/xKuj07fpD3
 UqoZFqU7F/sTfbHcya1M/T77WUF/XwNwJWeLA2ov64DG3ynzHsqOuWopYndSrzY66L6o
 IccOUjZ8DCa6UmkzJmnqH7LziXR9r7XiGb+1mVxDpkASlMyMYr7kGa8ZKQNqGmgGfe2K
 h3MA==
X-Gm-Message-State: AOJu0YxsEsdP6e9ycUqCQLHUo9B3QlYLq+TLBeAGYPB/fYRqJ54lRzF3
 9DEPm+foUGk82M2xJBpqeiYGPwpzkH5PsEDS2nkJjnG6smfg5vHAUCxhuwoz+IDCwbxf9wSVHJT
 xGdVfcQIfWyQxNVh3l0jAT1tqzlN4PSPMG+UVBGaDZUuEPoZfloPlBdOlJXJ3sNVtEg==
X-Gm-Gg: AfdE7cl5PWhD8cN4XlFExx/tLS2g7viogEZZTXcQicVTH+Fk99c0FS34wJbAqacROTp
 CruK0CTNQPASsCQZe0OkZX92Asrf3iVkRKSKAP/bMvTBOGG82EX+Phz+BhAwNcM8oi3N10vpHQB
 MxV+Yr0Z9y0PW1i8wC+/J7TpNxrmiOlcw+N5BQVlrzj7LZhd8BxgD+h/jeIixtbw73Ep8UQWK8h
 xoBiv97bED4W4WLc7vSFvDDoMjYRzcx+VWX/V2y6op5/aPJIn5CYaBxV8OlxWQdIhh6goUI8hRO
 w02B9tSAwfztICPsLnytvltH56oBzuRiPiPq+rouZceMILvZx5DpCzjMddDblKBZMJRWpetFmBk
 NV42mHs6aDsgyhNxn9greR4xHWJP8fdo+QK1ogg0dgIlbeT9oJAEGAE5pJ3XhNBU23HImNMBLY5
 b44GbOFg==
X-Received: by 2002:a05:6a21:10d:b0:3bf:a0e5:99a1 with SMTP id
 adf61e73a8af0-3c08eed68e3mr3065315637.51.1783377487144; 
 Mon, 06 Jul 2026 15:38:07 -0700 (PDT)
X-Received: by 2002:a05:6a21:10d:b0:3bf:a0e5:99a1 with SMTP id
 adf61e73a8af0-3c08eed68e3mr3065279637.51.1783377486655; 
 Mon, 06 Jul 2026 15:38:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:06 -0700 (PDT)
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
Subject: [PATCH v3 40/91] tests/tcg/alpha: system tests
Date: Mon,  6 Jul 2026 15:32:52 -0700
Message-ID: <20260706223343.988769-41-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GPVJ7JvAN48zaaRTU6rsmMsv6B-HVhCZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX++C3ARQpvBpA
 qHiqKwo6gNdBxpmC0e0CK7E5RvzJGeKq/GqnxswqnUEQ26vXGp5FRHX46soPo6qxQT4nYZ3qLCf
 oPNIo/OB4QfOtoEevO+Z2ABJcbrNN8U=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2e50 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=c4cJLtc-M2xr-Rx9CbYA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9xcr37xC/wuy
 LjJcDTmVoGbCyw+txDewUP8PR2wQI+Hhk/sjG+wMcpfIAcnswjECa2UPyQpJMRy7XWGiXgoZpFf
 xSO7OQGiY7MmarVpTwLXB3+q6WPiSzvZkCnKNsD8DYpgfna5+A0vJa5pI4gsHS/bScC9W4gqgTK
 DqVZi//7KPQO3ysfgPIaJSOLVzrD3MZoUjSK/8jTf8ufByF/tCfvOq4jDgkv25fIoiytY6IH4gQ
 +gDI04+OAulvEQRK30UtTA6boWl6JXpxVSDFy49vzkkPvjvQtge7Ju+56LMm+/IVy8DixP+yKPC
 XX+hOmusnXYhzaC0wefK0X8THM+J0+jJFy+A7+Gii7z4HGG616EIP/cOqMJmldkpCDiyC/YGtCi
 A1qH+k0idhgNoku0xNVKMEDCg7ltgPM2WU8+VKKuI4kxyUxlTuJZYibLkn91nAEqOFjcZD3777D
 HZepv8KNegMuaizOeHg==
X-Proofpoint-ORIG-GUID: GPVJ7JvAN48zaaRTU6rsmMsv6B-HVhCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/alpha/meson.build        |  2 ++
 tests/tcg/alpha/system/meson.build | 46 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tests/tcg/alpha/system/meson.build

diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index d473f62bcbc..b0f441a0c98 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -2,6 +2,8 @@ cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
new file mode 100644
index 00000000000..bc6813b9dae
--- /dev/null
+++ b/tests/tcg/alpha/system/meson.build
@@ -0,0 +1,46 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-mcpu=ev6',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += ['-DCHECK_UNALIGNED=0', '-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-alpha' in emulators
+  tcg_tests += {
+    'alpha-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'alpha/system',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-system-alpha'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


