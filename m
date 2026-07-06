Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4EEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxD-0006dV-T0; Mon, 06 Jul 2026 18:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx9-00069f-PB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx6-0006nK-D5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEF6n1495847
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uOH2TOf+Kok
 iaHPRwpl87GYReEgcHG2CRSJ4Rm2aHjs=; b=U9DRrDP6s+bHhr0eP/x6ggwOwrs
 CL5J+IEj4I6dyvlprUj+xfhCZ/ZgnHFpYkLFE4h+/nhwwzDnc8uKvtypuyWvr76R
 opdWM37xjQXkfmEv7UVRE5x/+ezJFpNhp8wP4SbnofniC9UWK7T8Carc8BJoqi8e
 qCzA4B4WZoQEHExsET7L5jLzLPRQSuP1wgYi9oV/PeWQAum6MXnejHJSEXBe95dJ
 R5Jbi2l4sAer2akEc82RmeT5uoDRrsck9TnXf+PHZUV5DCKIgSRog/SLx/jSAH4u
 glH6pq4WvPfyaX4EeyulRXqvKnmn5ea/vFEP7/9SJrF+IcvGCASdaGjnW/g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bgpu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so2648515a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377490; x=1783982290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOH2TOf+KokiaHPRwpl87GYReEgcHG2CRSJ4Rm2aHjs=;
 b=aWO9BP52+lO76SeU58bJ1l0U97pKwH9oGT8JtNU0jX51wHQaPL3OmoooPZQCmXSIjh
 +fc2YkWp86JCTV9UnZfd3ZPaK8/WIEkAy81fTC/UTSVFvB86+4CtmQDhJjItNmxStBAH
 OZepHScJ5v33tZcfrHexILbiI+sWi+MBiDexBYsDv6Dq2XNQ8EdJKjUDdTPURylHCijt
 JkUCbINHNwsSzps4Zo8gu7fx50W3Ns9HFDX3+KhRaGM4TZlsK2ZEGgq93Y6ytYQygDvt
 1V0IV6+PhTrqod2xmeuUO3F/w1vI5e1KozMcoaTT05N1mP46Csy68bgvi7tp3cqxXlYl
 z74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377490; x=1783982290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uOH2TOf+KokiaHPRwpl87GYReEgcHG2CRSJ4Rm2aHjs=;
 b=GuKJEiemgx3g2ujXp+vh2FwYm8BmEMoK/83dogUpO4WuOMZuK8a2fA34JASTs/z4mb
 gDjXvs/TpJ6fcImA8uh9oqD9vWWwLWYwKoHsW1M2mVbvfPTDbrdO+OAEX0u0NepqipGd
 lPic3iY9tte2WE7oNk7RirS60xlVO5YbZ9VAJq8cM+BNV0gw7NO+6IfW2pRqp70Cq6kh
 1NB/5Lj+MicrRB/Qpv0enZ9shLYBkU9UVBijdltbusVa3CVqgo+cF95YkLTbQRw5p3Oe
 gXq60bZx0BgugjiuTbpIj06ziJBrrKT86v5MMfRB68Qspp8rKTgjdVBLi84MTtcyOWsR
 zbRg==
X-Gm-Message-State: AOJu0YyVt2XBGp6B0FWlpj8tdjx7BQvBTVhNhqK1+vIlnqbaflRw5cwa
 fvpslTqZMFB+S3oil6BX2Pbn/y3X4hscGkuUFjHuIdAsh3tpmRUs8PeoKSQ57ZA7W+1mrf3RSG+
 cIoUebld72WO9Mpk1NqO7iBTxK9ufUrdohLLCsbdpPRKbJEDOCPtFe9ZVx8KBrUkFJw==
X-Gm-Gg: AfdE7clL3CYE99oqjb567dVjuU0NxgkiICOChylFq6BLn7mWrIo8JpF29aL/mELyvzG
 WAO48ggxIICIVztQfoSkF5+DlsmwsId4ktharA+0SHZulOdVt+CTSHPO5PYtiLOFwWuIRtndmka
 JQmTCEZcyEg8xGkuZK3cLGP3u2fW5hw7GBQX6/O2nUfHEt0UhOC+qb7v0+g7IQA/POV4GFUuujv
 IQ20WOschEbQSGgufbpZQZWkHeER0UX3QC63jh04JYR0tKAsZWq+6u/GmrBYTKtp+RAIwHI8dX2
 6arMB6MKvhlCrOQK7NNo57eDSouhDjaBcSD/zAy0TObFIheZ3gEXaNV7OKjgPrQt4kDpqyLtgNh
 FauZvkYmjlmtM1UVYTewDTTAc5pW20HvE/RLqOv0zd7+mm4WH3wo8nvRgLI9CTLKAwdOHq0RMB6
 mD74PnOg==
X-Received: by 2002:a05:6a20:7354:b0:3a2:d79c:416c with SMTP id
 adf61e73a8af0-3c08ee792cfmr3035986637.32.1783377490183; 
 Mon, 06 Jul 2026 15:38:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:7354:b0:3a2:d79c:416c with SMTP id
 adf61e73a8af0-3c08ee792cfmr3035938637.32.1783377489606; 
 Mon, 06 Jul 2026 15:38:09 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:09 -0700 (PDT)
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
Subject: [PATCH v3 42/91] tests/tcg/arm: system tests
Date: Mon,  6 Jul 2026 15:32:54 -0700
Message-ID: <20260706223343.988769-43-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXwEQRxuDGsAAl
 t5d/EuWpamXxH7IiQr/PGMl0YNKpI5pNm1e5HoLP8g52TV5m0pQnY0soVyA2wlgIgxXjyvV8EhA
 47INFARkMea6LKnJ7EMIX2i3v+Q4Dok=
X-Proofpoint-GUID: iGAygYoyNhUMd8Ax9jJIHsPS5O5YL_S2
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c2e52 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=9zj14YibL3QCELQp7L4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: iGAygYoyNhUMd8Ax9jJIHsPS5O5YL_S2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX0hU3ZvgJrxny
 5wQE7gSFjNz7lRruRVSoNDZC5O2EUUzXNXz/5AhpN2jQzj4zn6DIicGZu1mpaAer4RGcWZB8INz
 M97ODf73528WVqrqarbQxiabuXzANFocPaEqU/95KeQM5N3DBetQZRa8QJt/6zTUPatSb1kZpZK
 XCxKlD+QAONkiIE2GR1bstvXZdFTR7iD4vFlQgJe+Cg3yJYaxUWMDkFZ51jpvtZwhI6/Wt0rovO
 xM844HjvOEd1GO3bgwGr7ynioutiUZdDGPT7AYs3WCr2jESmPg+crToTBoZKs1aIxdzSYil6i0w
 uTE3MUnfXxUQG+vzRq1Bta0dCMEvz552fSheK+rXO4QXuo2z1Uk6IprIqSYimqdw3K8SDVNzlMg
 1WTWtWT1JPh2QnJT55O/BBLkduP7rttW2WJDzID7Uej49zlY8p42h2T3MJ/OOB2PcoXB8VM7vta
 wR2+dyRRnxUGQT/Yc6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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
 tests/tcg/arm/meson.build        |  2 +
 tests/tcg/arm/system/meson.build | 66 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 tests/tcg/arm/system/meson.build

diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 3b06a2f4fdc..ff9adf47740 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -2,6 +2,8 @@ cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
new file mode 100644
index 00000000000..ab0ca8dd234
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
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'arm/system',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-system-arm'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


