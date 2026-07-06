Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7C0C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxC-0006Rj-NT; Mon, 06 Jul 2026 18:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx9-0006Ax-Ra
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx6-0006nE-Ck
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDvuq1566475
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Nkxpk9WYuqe
 geS25Rf3Bg12VtNis6H1jtM3YqLCFkhg=; b=Eu9cguqajeNpdpk20QAjT9o7BkT
 +AmEUKzoVJGUEr/Ng/k0AkBDbufQbveTmfWpvgby58PM0cIiz9RXJOpNhUJcRZiL
 3dUt49z6hdv+IJ2Y6hqmwxsjVEjG2dUl50yS+69jVV3otb+R9xbIv6SEn8RBSVH+
 MsWUaDorT6DXPk6jic4OKwFwb/GQbUUlBoi5o+CvM6IxfjcwTfKF891+B5n6ID3c
 eNuAaUWpn9iq1doUrXkoxIP0P0+k2GmNlVSMzC22Pgmub20Zno//C1mbNcBtIIJj
 KXVPfoRfsl5rUhFGJJsPRIP7mffXogEpkpZWudrGfuQkeoinGoQTbQTcW/w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7ktxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c9ed5caa3bso536915ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377489; x=1783982289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nkxpk9WYuqegeS25Rf3Bg12VtNis6H1jtM3YqLCFkhg=;
 b=abxd/emVgsz1GnVqkwfDEFlt8G3hiTd7LZpHoffwYUvExpw+3wjnnUl8HVDTHPToLC
 il37MVtdw01c4mPdLTt9Gf00gNRhMLb84Kdgbf5+ayrd1D8wM11qU3Eqc0fKf2WxHx35
 Rz8hf7R1J5F8QuE7K/3CDagdfZK6a05Uf/ZuHVDtVU1jBtrsrNTNrJZePNtoMlFI2PRq
 bX0rrpELMRui7F/XgKW9LHtL3HPffke+CkmFnScs8fqhooc8zosmnnseH5ANGmGe8+sn
 8V1jv9Pwp95zB0zCanJ2+7uBHqCTseEgRHbWgZow2qaVTQGTilbY12frSRozaYFols/6
 VjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377489; x=1783982289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nkxpk9WYuqegeS25Rf3Bg12VtNis6H1jtM3YqLCFkhg=;
 b=QBEm+cWEAb1V3b+f+947CV/Uh8X+kq/oU9jVUOuOHh4rU+NkJrly3tXGi3oGuaorxY
 WOwtsSwBFLbyKtS6qW5EGLhJJcfOnJJWxdlpMVYkmvCpWNPM0aAPOrrQaA8lqj6G2fJu
 759RKQPmnAGd6SAp1fQwvCZ986nwwWG4EUAKmYKBbBoC+Xr5xGcNLCbAVIGYeG4MkHHn
 f1yxtD4f+JbbYY/A/oUNlSt2jLfyo5srAZ6aIwD6LSzu5XNfz4IuwV6KYrD0GkFWNLAU
 SeXUtx8E7bDe9tRw4TAPOC/0KHhIek2suNRMiXSShRKpjpg6Qh+QkLaf9zgbRS0LHPEC
 He0A==
X-Gm-Message-State: AOJu0YxGlzHj+H3I7OsHtHn5TZ8eeQ0tFh5/lwzd6LXk+Ax8xkLKsuoH
 d/nHo/AMzJhDlofRYL6VAfRxfbvrNKOYHE1DSGrYY5ie8B0PrD5OOtoK2MSQltZ9Xl6ZSLW0+QD
 HnDJ8rXvh2syMZ6oemW1iUOPKafmGR9jf4X/eY2U73kb2XxODnxktWpmBM3stap0Eng==
X-Gm-Gg: AfdE7clbkuXdNc0ZBrt5DbxcpB35xauQUQAytjS0nuRNMTwD9hDhUEsAqGfXFUpUTZt
 q/19+EUvxBAUVUq1+dDTUcNHapBrVkRI0F8B08Fo028lsV/3X6bhiG0K43Ume906ipQnX1vf59p
 vu1g6Ym1uBKoMB+PTkkCflhnxXvyklMbPVgo8KK6ubvi5cH3qlXNL3Q5fBUqzTE6MIUOWFxHrQC
 EqVQzNNvzjNiT8H+nHv3ZYMfcEby/3wb0Yjuo/0k+6e3fP5TrWCvZtMZ1EE8zKM5io+woZypkGH
 BNavjhSQbfEVlA7O4BEMrYD1ZYOhEbYvksLwLxiclQ/76+ccOyJMGkiwd81FSXbnICN3D5w+TTM
 Z56zSQOa4X3GP883nWWSico/YvLuXhYuHMcM0a6yvXzfxoLxFuoA69NdVLqM0PT6JgjIX4ENTg/
 /84wQYzg==
X-Received: by 2002:a17:902:ef4d:b0:2c9:d27b:af11 with SMTP id
 d9443c01a7336-2ccca8fed79mr2486715ad.11.1783377488700; 
 Mon, 06 Jul 2026 15:38:08 -0700 (PDT)
X-Received: by 2002:a17:902:ef4d:b0:2c9:d27b:af11 with SMTP id
 d9443c01a7336-2ccca8fed79mr2486395ad.11.1783377488229; 
 Mon, 06 Jul 2026 15:38:08 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:07 -0700 (PDT)
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
Subject: [PATCH v3 41/91] tests/tcg/arm: user tests
Date: Mon,  6 Jul 2026 15:32:53 -0700
Message-ID: <20260706223343.988769-42-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX/1DnsLZUxJZQ
 USnM8qL9T9Gxt+8dy1Ow3LoqE+8YVgQ/6oITSiJDIyt3fLpx1nkaZbm7ZQVG+6XyH/Qvpj2FN9/
 JU1/aOg4ypp+P9cWK7Q1AQ3LNVlQXYd78Qj6YTdF8I5VY9BbyVtvb0iVgmlBV42Eo7JCT2sSlOt
 vW1X6unvNEUX8b24phmOfjsuD5tG//x/fuK9cW2u8uvi3jcAZ1xQ8hLvxif2FYLqoK7wFn3Buc0
 yfiquzBdNkThASQ5HOfrsHw1dJufUzfEDqloYQE8ARUzDOoBnIDeNIB7gXCg7Pz6CifUWX8U6hm
 vzOhvxrCaj7b+l/WohB75EsibQVL6WanG37ZBfgroN4n0qJZWVFQ2nGRk+PeDIL8TrynsDYFGbh
 /jXdwi7m9QJfFhXL2hSHK6cv2cq5rsPQTn43lmEm3Za1aTBwWby3D+Zg0YYMaWg/M4z0ShOH27J
 TXl/5aPDjaxvG6EWWGg==
X-Proofpoint-ORIG-GUID: KlckV0HtMKdM6E1uBANEWerJS50KtKky
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXwPd2nVpuNymJ
 hUctTZ1G5ayfdIx61V4voFmOMMUcvfB/VSqf2t4sdfrIjLjVcYgPaMjTyQIbjeimI+xj4d+6f1H
 TiNrUYNpLPzb2WNidLigFYGbvnzztk0=
X-Proofpoint-GUID: KlckV0HtMKdM6E1uBANEWerJS50KtKky
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c2e51 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=oIIpJXeRkLvric16TfEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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
 tests/tcg/arm/meson.build | 78 +++++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build     |  1 +
 2 files changed, 79 insertions(+)
 create mode 100644 tests/tcg/arm/meson.build

diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
new file mode 100644
index 00000000000..3b06a2f4fdc
--- /dev/null
+++ b/tests/tcg/arm/meson.build
@@ -0,0 +1,78 @@
+cc = 'arm-linux-gnueabihf-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    if fs.stem(src) == 'float_madds'
+      new_cflags += ['-mfpu=neon-vfpv4']
+    elif fs.stem(src) == 'test-plugin-set-pc'
+      # Require emitting arm32 insns, otherwise the vCPU might accidentally
+      # try to execute Thumb insns in arm32 mode after qemu_plugin_set_pc()
+      new_cflags += ['-marm']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'commpage.c': {},
+  'hello-arm.c': {
+    'cflags': ['-marm', '-nostdlib', '-ffreestanding', '-fno-stack-protector'],
+  },
+  'fcvt.c': {
+    'cflags': ['-lm', '-march=armv8.2-a+fp16', '-mfpu=neon-fp-armv8'],
+    'expected_output': 'fcvt.ref',
+  },
+  'pcalign-a32.c': {'cflags': ['-marm']},
+}
+
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
+# Semihosting tests
+semihosting_cflags = ['-marm', '-mthumb', '-I', meson.current_source_dir()]
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
+if 'qemu-arm' in emulators
+  tcg_tests += {
+    'arm-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'arm',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-arm'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d43e34225f5..1c29c421ff0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -137,6 +137,7 @@ endforeach
 subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
+subdir('arm')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


