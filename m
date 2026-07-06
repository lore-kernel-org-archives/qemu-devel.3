Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C151BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry7-0002bx-IB; Mon, 06 Jul 2026 18:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgry1-0002DA-LQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxz-0007Ci-Gd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDqjX1628705
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mLh+rIsU74K
 JkrK/M7vKFtR6LsCE9Qv0lqbtAykot0o=; b=ccaPr98N6cYcitxMIn6RkuI1aYY
 dQmFtHaE5wZqEFoEP51/vfllUscF9bLFh9ViloFVKFRKtNsCoxuhvc/RQHAwnkqq
 LNuV4f7tgARvQHLRH9KVm4ZMJHH67c39zG1hsOqX0jFH56CJWnxuoNX4cj27Hbdc
 vXT/XLx68TV0jMjW5a35nksKdA/GnrM0iacVQleDDxVEP/JW+/5FJBT8MN+8Y5JF
 oFl8ZEUb83c+j4hvKNLI121uNIV6h3x4FnJU+riojQqyZe2QFc5r2OgUO5ARzrL0
 yPxq9Oh+BMQQDaNIgIhMQYIQ8hqqK3lIJj2WyYu6HF8fxesmYRkAUjXouoQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw1j1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c890bac374eso5451217a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377545; x=1783982345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mLh+rIsU74KJkrK/M7vKFtR6LsCE9Qv0lqbtAykot0o=;
 b=AQY3sHCT+mve6vfxZOcs+f0c5ahP4hiNmgQULCgX4wzjTqCF6OjWwXDJrb+ZsluKPs
 DZAeL05r1/0AWP2D5+0J4spziA/MtY31n6PuKQ2sYPmrzqR52OnC9w9xmddipWHdGvx0
 7FhJ6oyQcMZ31Ol7PXYFjReheCxq0bH8M12Ug76dAOehUfZIYfHQcRVHpzO4SahBQQkS
 AiSJtBggs10EQBtD97HjKmhUhhAypw5fTVrCc4GqjrZAN8Sb8v5mHwPCOePt6lsbq6iC
 BwyT5a5I3sney5Ur94O7NM27+NkylCvH7YxGxmqwNyePtbg1fnDy+UYsJkbaLhADAwyV
 9eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377545; x=1783982345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mLh+rIsU74KJkrK/M7vKFtR6LsCE9Qv0lqbtAykot0o=;
 b=C5Zfkt5fP9r1fTcde5EeN1ZBqLp21chgKIVwvfcrvG2aS+Gu+o4KXrY9FqVqsdycVp
 2h8z8uq7MUxqhR1U25XRKO1e07hEBHSnQs/ZeteY/eLJginQfB1H6fODfzsxmlTZAm9s
 0aXIHbagF7DsSDz4yjWPgvBjGCF2yIlsuPPvVsybo19wAHKVcj3PWc7UTv0zfnDC+zvj
 lIPKE7nWQqwSNLlmVd1Ydq1rmQEtg2Gz8hJndpf2+QSmi7zU2yi4C2BagHfO8CTwmyeO
 as7STJpI5xEow6PzI9wvPa9ayQaDa6THO+/yXdAIJR2vs0GvDq3N51kXQ3Rjvjs1aEe6
 XR1A==
X-Gm-Message-State: AOJu0Yw5ldwDpV3JAOXmw83ZNdVQhmYUL/QgeV1iotOl2s9ZfLPvdxPw
 BW2NPtl+lUqsIcLkyaSIeoovcRXsZLLAZMV/sseN9du6YzcbhK0mhID0L3pGTHnkp/2Z3SpqUUE
 z3dGoRA5MZf8AXCN0PXDfCwaPex6v16lKvGNqUIZPtd4Sx9+y1WWXsuBuMdzYEuQOlg==
X-Gm-Gg: AfdE7cl/QTlefjtwJTf3Fq5zlwcsjChOvLWiCagQmgsQx9DbUfpcN2wkB8BgsIzbPZW
 YGAOoQb5GdmljJU/JedwXNEhsSDR6m2PHiblEVb1KAOyscvd/cu7+Kochm3t1dIQl7h8QkpmAsO
 cb3RPnp7AheAT2zoVnjcMTKybXsoHQLflmgVeMtdr4dEkx/bPTo/KAKqBjnUrLXQwxG4Jjj/kJe
 1EtiM0RcEmtBjvLk+GYPk5jT9pLBQZMSBjVYFLLVAKI158Do8badwLvRVqCoGZmVQ/A+a94aTuW
 QFC3YnE5gaXad3K7KV7ErvopQ+Hv4JJbgx5l9ljR286vYF1sq1m7wltZuIyyK1oVBLXskDwVPRw
 DrBijxx661fPrb/tjODV5MDWxyxtqUZNZDZQp3mb5eqZQ5XNdui7Mgs8zWqmcq4EPdhhLsSm4Ew
 ZH410y8w==
X-Received: by 2002:a05:6a20:d494:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3c08ec61813mr2750800637.2.1783377544997; 
 Mon, 06 Jul 2026 15:39:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:d494:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3c08ec61813mr2750773637.2.1783377544524; 
 Mon, 06 Jul 2026 15:39:04 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:04 -0700 (PDT)
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
Subject: [PATCH v3 70/91] tests/tcg/ppc64: user tests
Date: Mon,  6 Jul 2026 15:33:22 -0700
Message-ID: <20260706223343.988769-71-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9gGqk7HkQNhR
 Wju0A9LvqEwSMRFoiDqNd3rBLPtSGNhZWc2cJqpsdIu8LdIWy224Zu9xUv6KpQ9sD08YZX8kmgS
 dtPjx6UAV9jHESM18hWJ8506/4O+9s4=
X-Proofpoint-ORIG-GUID: PtyG-XrXmDb_TOQTHzUOFu_oJ4xIGU9r
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c2e89 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=GgvVSD1GJW6-qgdqck8A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX9UIq9+lFgJdW
 9WCMqZ6eHeVA12F9Qnwkf4u9uDuHxthm2QyLDrq8C559hoEuKQEly84WCGMbkebsjBIWmErqn3I
 3L700MStSzTSaJBc4UZY63EfMyPwTXY2Wi/wThdYaYS75DdE5XUJ7iocz6fWT318XRt+giT3wtB
 xyXyu49tPI3JVCCB47kQn6xnCsZh4U81YNSeRL39KVug9WJaTjaZ2WodaMXLFHBmapkZM3rOQtH
 4JRr9UXPK39ykfDZbjjQDBJ4lBsrLLg27Ce0Ehs+v38BbS3qMHFFzeLflNPqs46qi2RFLzWYA66
 StugX680EuOQDv2ZbqCwKxmm/QKF7HjEVFDsvhRyxc9PuiYMJWg+HvoMsHpirIA+yzY2bjjCFyg
 E4C7fZLjhNseg3vko0z+mRlDz5viyXcPAB1/tLXeEOKNMXuiLqk89XT7JtDIhowP9YGVwPxHcws
 hlKXDbZXiwPRpZWXfpg==
X-Proofpoint-GUID: PtyG-XrXmDb_TOQTHzUOFu_oJ4xIGU9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build       |  1 +
 tests/tcg/ppc64/meson.build | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/ppc64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 389e9f9b3f6..a23e63b8909 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -147,6 +147,7 @@ subdir('mips')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
+subdir('ppc64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
new file mode 100644
index 00000000000..1d06d2dc5a4
--- /dev/null
+++ b/tests/tcg/ppc64/meson.build
@@ -0,0 +1,56 @@
+cc_feat_cflags = {
+  'power8': '-mcpu=power8',
+  'power10': '-mcpu=power10',
+}
+
+tests = []
+
+# Multi arch tests
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    # ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol
+    # for a given instruction. Thus, skip this test.
+    if fs.stem(src) == 'test-plugin-mem-access' and 'wrapper' in setup
+      continue
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  '../ppc64/bcdsub.c': {'cc_feat': 'power8'},
+  '../ppc64/byte_reverse.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/mffsce.c': {},
+  '../ppc64/mtfsf.c': {},
+  '../ppc64/non_signalling_xscv.c': {'cc_feat': 'power8'},
+  '../ppc64/signal_save_restore_xer.c': {},
+  '../ppc64/test-aes.c': {},
+  '../ppc64/vector.c': {'cc_feat': 'power10', 'qemu_args': ['-cpu', 'POWER10']},
+  '../ppc64/vsx_f2i_nan.c': {'cc_feat': 'power8'},
+  '../ppc64/xxspltw.c': {},
+  '../multiarch/sha512.c': {
+    'exe_name': 'sha512-vector',
+    'cc_feat': 'power10',
+    'cflags': ['-O3'],
+    'qemu_args': ['-cpu', 'POWER10'],
+  }
+}
+
+# export tests for ppc64le
+tcg_tests_ppc64 = tests
+
+if 'qemu-ppc64' in emulators
+  tcg_tests += {
+    'ppc64-linux-user': {
+      'cc': 'powerpc64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64',
+      'gdb_arch': 'ppc64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-ppc64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


