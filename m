Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5A0C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4fl-0007Pz-LK; Fri, 10 Jul 2026 02:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fj-0007Ku-WE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fh-0005jV-IQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3pWJv3856687
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wZFc7930OFR
 utIK5Cw+ahSa8fbpaq1YrJOul3MnEytw=; b=El+2JkCr2rqEX5QmdStCvkVXDUg
 cS6lQsb9X28nRxvbC1O7V4spWoCA9bLmaWODZnzMLXWuk6AgAOxJVEDCZE0fcpxV
 NCjsuMhq93EimspTPVg1z2Dz2lM14cWNjUr2OUg4jX+p2EEnw8bi5R3hu487yZXs
 h8qRIaHpJfQodkU3P14psGgEP52lSerT/P4f3Tee+HGy8bIEZW+BBsjUazFDeyJ4
 U4hHR13ziQP1ZU/2CSmirgiAd/hiyRk5qW3FkmRKWKGnGfiK5ETm0VyfTCmVFYw/
 X3fy3QyDse3e0SAZAXSPF2M208wyyoCofTyuqkNm8dR5be6G5TYotVUgnyg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0hsy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dabfe0f80so277293a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664712; x=1784269512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZFc7930OFRutIK5Cw+ahSa8fbpaq1YrJOul3MnEytw=;
 b=CTuMNaqsq/finIf5y731ShZIAdXo2WTaTIu+efH3UH1tIgaOzDkwvI3RJDsS/E5/I0
 gxJggyEzfZFeBXkg4ugsLl48GP7s+wXzdQAkiCVXm6gl+x82x+NQtwCOhTMhuSyD1KsM
 8pjq9vy+abh2dcUOVC4/iVYxl5Iva9yodWfCxm9FRHDNEhlXiKUsx0qWPEIjlT+7h9Gh
 MVnTWvuZdydDQuz31zpEYOWQYjSp8nbbqB+zma2g3a4tOcXLZzyl4KRf5T7y/nfkHTkx
 JcW4zFcXTFjFvB1PGHGetshFv9tGVqwm9RH1jdhNP/COEZMRQv6bpeNvc34v50Nw5NAu
 pN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664712; x=1784269512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZFc7930OFRutIK5Cw+ahSa8fbpaq1YrJOul3MnEytw=;
 b=HjaXEGCIx0XBY8C4di0LBvaYNA67lLhHi4seFxEOzIx8G7j0xMzOC6KM2hjewfoFl9
 iJwAo3OfphbCtSGpfz8F0m/KLA8Sz1uSlHpRBu0aQS8b0WM02waJRAeWtW/+afaWYOIB
 1Z24RFgssCr17/2kuoDwENcKHflHwDIUMbCjV2ktAZpauwwMPr81zBtbUxINQ5zJ3w92
 vnJ67RQ5HffuSiw3w6V4WeYsMKk16/XJoxgw0mo/wZywPJs/V1ZOC46zY9ex0Bx14fQp
 iliN9/n0Oow5zK6R3Frk7f9RPzJHz9S15CJeNA2iDvxjgtN9m92+uiWHGHfVMsqxXaI8
 Z2CA==
X-Gm-Message-State: AOJu0YzSy5Wy2XtaHUMs7Snsrtrm7GjQTJyRb41G2O8nt5AIuSlAFNob
 6m/GX6JlGgsfUQyqLdOIBLU522AFEsIHjEX+aalnXdthGOHnkAJx/1ZXVqQeRKNQOnrX/Gaem1e
 5HSjpx8o8ROt/Jos1kS6ZdLw5YKmWevIj9SP4TgAGiKfGr6xtERvQgzwVJ4reUe1e7w==
X-Gm-Gg: AfdE7cmBibnNOKNelKGoilD8hnsO0ESH1pXy4xGi6O27C8TiqAvYdNABBQdogErZo2M
 IzuLawHajXMMiGq3SrH6f6f0mq9223HeMV04Zrp9YZjJDj4ZNNbQ7ys6DIHTtnCFG709+e1Vfa6
 CwHqGyMNPHG0nlRYKXSF8g/jOIJY0X71EScndXyw5ie7Sta1WXGJx0bg5DJz9zJ5zQKYk6p/X/R
 qpLTP7BLxcRGj1+OxQomfdD2+azW26CHVB4pp6mmv0U27R8hPTGyPRhF13Qm0apNXTej/cFfylc
 SrAp7mCcEgiVtTXVFk80qikkwOXxbNhXbUYxHHwy747xbXwhZK/ZOLX2wKGtNTDiXIcasqy/ErG
 u8rij1ot0nQqS/Z7j7EKlEhpG6YKlgDdJYOBA3Szv0B/IuDd6UaYQ7VJvllfw2QJ3xZsEpIA3XS
 /kGiLyyw==
X-Received: by 2002:a05:6a20:a122:b0:3b3:216b:2743 with SMTP id
 adf61e73a8af0-3c0bcf16171mr13474140637.4.1783664711591; 
 Thu, 09 Jul 2026 23:25:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:a122:b0:3b3:216b:2743 with SMTP id
 adf61e73a8af0-3c0bcf16171mr13474104637.4.1783664711142; 
 Thu, 09 Jul 2026 23:25:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:10 -0700 (PDT)
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
Subject: [PATCH v4 45/97] tests/tcg/arm: system tests
Date: Thu,  9 Jul 2026 23:19:23 -0700
Message-ID: <20260710062016.1818125-46-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX7SBQD10T4DBe
 33pMlNvPZq/V5evi1feMKe7Ndr87FKQMylLd0xKaDTRD5D2SEtFuFFnmj/Cz+T/yyKAOJo61E3H
 FYK+yAzWtCQwHaqfbW5ZTojXnTihrIE=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a509048 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=9zj14YibL3QCELQp7L4A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 6e8_VRuGAFSmBjGbWQWo98in4L2fgTeq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXy59zsZK2MfMc
 JGFVRet8tBfkKvUApTR+SD7mY/Gh/CxPWNS/tBpiLfKWdjepMA9ydu+h3FAGit2cQsiU7tKZEtx
 iUpSjoT33L8YEIzrgeCRr2JTd/x0RiDFxZQEKEqF5Y9HnMStrCcYtY8y1ULoKDMcrc12lXROS1V
 WpCVM7m/hctJPI+Aq9d8nWL4v23PXqz5nU0lTsfCQbtfacF4HhCCeU8NCML3mhb5mILuxnH0QF2
 fW9oBsE82pnqG1yq/NcqjIWUH0LXXr761bzWzS2Xcc5Osg5WQVXealYH0iTdzoiObrS8XncPg2t
 F7AYqJn+gGkiCYowGd22lFCa+YtPmw4p9mrdhHx/l/BFhXHGgYoHo4hY5yDqpl3uBD3T0xzuPe/
 /r5Sk+20OMwVbEJiYt/pO1dBbsvH0xyOVKkADGl/Z4PFZ7k9L0D6h+va0QBzLywl9JNa1SkNK5j
 lYA43l1d2mABJ2qd/xQ==
X-Proofpoint-GUID: 6e8_VRuGAFSmBjGbWQWo98in4L2fgTeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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
 tests/tcg/arm/meson.build        |  2 +
 tests/tcg/arm/system/meson.build | 66 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tests/tcg/arm/system/meson.build

diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 08a863699fb..1b491cea026 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -2,6 +2,8 @@ cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
new file mode 100644
index 00000000000..d507cf980f6
--- /dev/null
+++ b/tests/tcg/arm/system/meson.build
@@ -0,0 +1,66 @@
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
+          '-lgcc']
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+tests += {
+  'test-armv6m-undef.S': {
+    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
+               '-T', files('test-armv6m-undef.ld')],
+    'qemu_args': ['-M', 'microbit', qemu_base_args],
+  },
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
+}
+
+if 'qemu-system-arm' in emulators
+  tcg_tests += {
+    'arm-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'arm/system',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-system-arm'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


