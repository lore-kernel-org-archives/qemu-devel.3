Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7821C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1j-0005kk-Up; Mon, 06 Jul 2026 18:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1h-0005iA-U5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1g-0000Ec-B3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDvk31566474
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Khrvf4zmu/M
 xVkdiaIiq6h4hg6oTs+7kLctbfWUpyCQ=; b=SRJCGbD6EVl0XS5gziOv+2ULSC2
 ET6t14341Lwtjuf53cMH0/smVnQf1VWu5PXkEu9D/kDBu8RRqhFGSswNkqsUSMnk
 5xSEDt3AW1bpC9wg30LBuED3aYsXAtu4BCqCC47ZkrDZPrje6od+XpeoimflyUBr
 3CKfOfr7GdzAGyIVQRcK6o/t6P6Xd4P2myO9cYm4lCn6QN3/eS8NsQiHbN7X7ouY
 E364wtPL769ftBMrGWeXl3BGnyXsf6yCOhXra+vgrp/XVreQ1EY781/hKT0tYxBU
 fddk+f98nMSG7Af2sJ/+gbA962oJsXlJkqnY7JC8dNw1GR7GiJfejxyEQXQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7kuc3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c9ed5caa3bso582795ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377774; x=1783982574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Khrvf4zmu/MxVkdiaIiq6h4hg6oTs+7kLctbfWUpyCQ=;
 b=BneNGp32znZHFHIGEv67E03JYMt3vn+Lc06SsF1HoIlbhLEnIfyl7FtjTwjcN+8+Me
 DTr8hNH0nUGg7Nz1biCSrSEWm5llwu+dGDE17+Fs0cwT3en1kznLb+PNv++hECih7mYg
 jxVsCi0HX007xm9cZQ2xcgUYc3ucI6BmKMK43RNIi2kGFfE3ibOAOv2DR+jv+0stN3Zn
 O/N5uyq8cUtmnzz3NJjs1qfCK7ao2lhVNe4mi27uY4SHtTNp47qFpkI61V/HEW1SW5jr
 dn0H2pk5BfMA0BBvTDXjIIk6nvaTB88PRKrLi24N2L/MwkxtcMrwKN5UwRYyu+ViHp5C
 XkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377774; x=1783982574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Khrvf4zmu/MxVkdiaIiq6h4hg6oTs+7kLctbfWUpyCQ=;
 b=oYK3O/TdENENEAGTpY75QDaujsiR09+rpNjByHH65Hud7R8rkXe4S9HJbvu42jSwt4
 e/8YYavxx3qQoRMq+o78sLC+0268nVKNT038/itOFN4/9zTYutXSICwIndhnHzyoW9qD
 FeO5Lu6Q8b4Pc36yPzXLAHJ5+8fr6wgZ1cYIp/CM4xyUunn+p0IaKAnc+bQUhps9R5n1
 Q7e++CQjubMxBn6VgJUi6o9QPti/vCsgSgLxihOHFLQV+p4Ve4iyvHLxtFvQfAlzj+l+
 828mhOZkbORvigvwqK/9IWCO6P35ydyMUiUt9qU+gUN1k32ihskG7GfhRI6Peo6R/v3O
 gkog==
X-Gm-Message-State: AOJu0YxfCVUanrlPIdh1g7utBV+xEYj6eH9yBmTX4huvdsRTEPUy3nNQ
 jntGOdNVGt4jLbYrT7VCeQbP7obcCwABJg9W3P1O8d3fHTfCdbvHmz/gFr/R4zsZcCF5ga9WURA
 PYyWmdzVGsAXdgMK00eLy50lmdVa0nqtLlyUpP5C6PCtEJxsBUVgQ8AJlsm5sBnV8EQ==
X-Gm-Gg: AfdE7ckQyw0ZWZEXhwDrOfBNrnslA7e7Or4jm+aE7S5BmmwYu5rORi9IPdjApMHLAJK
 PbUzpXJETATZ8FQM40Iz8I5boSzwSqlpzICndBFds+cF5LJAnIRGMfM4SU0o+fCxwbVtFrA9zjv
 /7rgU/C4zgf2W37jCs2y252cHHwKj8dnZgmsgfpaK5AflwrTy64ZD2AwGklFiE5NxtKI/LP43Ue
 xJN1T+9VA36QG7r55fJ5usvN658boBQSBbgv9ntiS/gqxrrhjG4VHpf7CHY7/pc5uSYgPyICX+k
 IOgC7tYfsGxQgV8nUEaWPWVVmrudTyKOvq49DzKL7UnPvVwS8r+ik3k0DrDPXK1zDSlEEF9ipmC
 uJGiyDjsl4RCgky2grtdtLnqoRWXYLiPzs8vQYrqm5TGLyP2kOIwzqFWT7Xn3T9iQ5+TazOe+G/
 MBJjQE1Q==
X-Received: by 2002:a17:903:ace:b0:2cb:402:70cc with SMTP id
 d9443c01a7336-2cccaf18246mr2394435ad.28.1783377774440; 
 Mon, 06 Jul 2026 15:42:54 -0700 (PDT)
X-Received: by 2002:a17:903:ace:b0:2cb:402:70cc with SMTP id
 d9443c01a7336-2cccaf18246mr2394185ad.28.1783377773949; 
 Mon, 06 Jul 2026 15:42:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:53 -0700 (PDT)
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
Subject: [PATCH v3 86/91] tests/tcg/x86_64: system tests
Date: Mon,  6 Jul 2026 15:33:38 -0700
Message-ID: <20260706223343.988769-87-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXx3IEFQ0HrGKg
 7+nPY8jPG3mN6fdgRmEAnM7tg/X/h35rBEvHbUNIMtaW1EW3JSlWyfYxQo/u4PMoHeqDfYebOIc
 LxR2owq23D1xCeRD0nH5YDqqVk9GbXk5gBtwdHBZwyoimZ6+nTM7rzuledVJYF1PwjEniAd+bWy
 RypRrgABY7XxnBHZp3dg/b8+D7/8sk+IUGKUjFMXZxNITHZ1sqqBeSK3Ho80yuvahiSbSCa390s
 vLjRj1y6EbTu+0QHb3ISXNgC2uIlGqjoMx/1SSOY9JCYHrFddLl/AGgHRzqKtZ/oQ0shQarTlWa
 H3rB7qo2DuIbth+5Ss9fM/brEhChP3OXFAJVmx6L4hCHJ1ab8k7n8Nd8FesMRcvojkNgdSlysq3
 kKdq2PruBHb+ZlyPWf8u0Vja2g8la5CvQjqrsIIbcfm6B7bRCdINXQJQAzUdtywkNPquWJnXhdE
 Q/RqD6G622460jbrljw==
X-Proofpoint-ORIG-GUID: GZL6BKvG7jaDzWcLE4LlAW8YX2OSTv9x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX7kQdxCZlQdHA
 o9Q5I6aBz/OHr6Dn8y/u68zXGLuQoSljWFPFoBUYb2vwlF2CELg925SAb9nrEDfjtAVjT6LWD0v
 qf2CMmkUP3GIJjzVjNpFtVuz6+Vgpjw=
X-Proofpoint-GUID: GZL6BKvG7jaDzWcLE4LlAW8YX2OSTv9x
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c2f6f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=Z-FU8ZK0wJ45pbiLfnUA:9 a=GvdueXVYPmCkWapjIL-Q:22
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
 tests/tcg/x86_64/meson.build        |  2 +
 tests/tcg/x86_64/system/meson.build | 62 +++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/tcg/x86_64/system/meson.build

diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index be4672b351e..600b35e7867 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -2,6 +2,8 @@ cc = 'x86_64-linux-gnu-gcc'
 cc_dockerfile = 'debian-amd64-cross'
 cc_docker_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
new file mode 100644
index 00000000000..ac832e596ed
--- /dev/null
+++ b/tests/tcg/x86_64/system/meson.build
@@ -0,0 +1,62 @@
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
+          '-Wl,-melf_x86_64',
+          '-Wl,--no-warn-rwx-segments',
+          '-Wl,--build-id=none',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-device', 'isa-debugcon,chardev=stdio',
+                 '-chardev', 'stdio,id=stdio',
+                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
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
+  'patch-target.c': {
+    'cflags': cflags,
+    'qemu_args': qemu_def_args,
+    'plugin_test': {
+      'plugin': 'patch',
+      'args': ['target=ffc0', 'patch=9090', 'use_hwaddr=true'],
+    },
+    'wrapper': [prog_check_plugin_output,
+                find_program('./validate-patch.py')]
+  }
+}
+
+if 'qemu-system-x86_64' in emulators
+  tcg_tests += {
+    'x86_64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'x86_64/system',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-system-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


