Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F281C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4lS-00069x-HF; Fri, 10 Jul 2026 02:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lR-00069O-9J
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lP-00075D-FG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n1FI3661656
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WEy+/BJ3s9Z
 ra2TOPaqMgjXaQS/noyviqVYFLHr3DlQ=; b=XYlo5u5Qw4+lOm4ZKC5Fy+qIlQ1
 KbdDGsNTjrtfwaOJzg1bhgWgVDf42PsY4+1GFnIbGXYpUiDy15rI5nAKQCEQil9c
 fOGG3dE31Na5kl7FgdKZKjMu+UmAnNTAPdaaz+Ijnd/pKXAmm2FXlBtt4ELYLANi
 e0y3i6u+/1Um3wZN8y9Bjy63fdZ75T4njDIQGddcc0FSot0PDCOkusnTMcyn0ocL
 O9xzArdP7qGoxP5kzLDTseCthJjCHNcW8jvZ32xyZHIwyxzyfQnHvNIkzX+Tbuqh
 FHNfKT2FN5iNXZ9YmbgRdhsDAzqteQLhGvJqdZYQpkxESkkwLgas1Gsp5gw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24txb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38869800848so1161375a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665066; x=1784269866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WEy+/BJ3s9Zra2TOPaqMgjXaQS/noyviqVYFLHr3DlQ=;
 b=PLTcrevJVFgZZDx7v6Apu/4r/YjfTR9UE40d6X6V8HzxEwPwDFGjVCh1QCpmvue8wh
 5Nv/dwtI9MTDmAt7Us6aoF9esh8E0kyRItXt3BOrbScyPR8I28UWkSmz4lVnJYUbhI4d
 0jqD21mB2aiTdZCKnuz5EuFjiNkGVRaLQZDNafWBglELNj4OTGUYiOZofJms6Mq42Nve
 Jrl5tJdJNkN0HncG6OAf17VeTHv05cpDiAbd08n85CC1Zj2hDpJQNODYGnPBJmwD2wS6
 lkBPJd1+5e33WI6QNTbzHVq9b0TA0BHNJRE1DOoXnMrd9j7SXr9pmzCwGYacARq+Wxet
 grQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665066; x=1784269866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WEy+/BJ3s9Zra2TOPaqMgjXaQS/noyviqVYFLHr3DlQ=;
 b=nEGVOwM/uGgpupeeYU6Y8uk5iBAoJc2T1ClZngI5UR66FVhacbrF+1svkdB0CIJf9R
 eAvJQ+c88Fabwe/7g3y7A9z/1vZu7CgU/RExP5j8lswxXJ4B642DOi5BIi/8b9hgXAnU
 PK1qSDsefRLD7h/+WenCIRcN7mlxjWBeHlCSryQeZr2zrMgDfWfwp4Ug8hzYituz+Y+W
 VWyg3g1oRLhRJMmf9UBpy7vaF0AUy8JSCve9j14CSKCGqmM2BTCLzGnWfb/74Oykli86
 qcVFnvl6v+He2o2Fd5CKXVf3nuHmrLePFgp/v2V/pP7tdPpILWa9IFWp0shfhdNs1247
 bG6Q==
X-Gm-Message-State: AOJu0YzPY79nDvktcOZ5kNZs1tGtgS/my/OIrg40TqgoTm0Z9tOUeRZ1
 8jjSm0Q2/rvPV9koPAlvnb+4OJEMghXTrf4hgdW51neMO6x9r3ywjvVjHKWtMQ9lCx9gOQ/Af6c
 WtIHeEV9MHDuw4X4ZN2sTz4E0Kftznpe+97/g8VPykBGQWVBJc3QvaAcHDR/ENZQFsA==
X-Gm-Gg: AfdE7cnueScfFoEzsYcTu4d0MJX5VOy+LpSQ97NuIsciiIrTN3GnK+uJ9GLHJ6F9cNc
 +4OBP8YO/U4TTFqUFYOsMNwhN0gAC3mcvV8rhtrnLNoulR4GbCPdxsHBfbcpkrHryWeGrAn9z5h
 +peKk0FbGjrUAZaG6VQYBkxBEuPDe9DdSM4qfqz+Lf9e7uknR6mAgTLyne6X7S2Wh1naEw9Aup4
 bI/P1ZTWjhtFJPsf4pc07lViV2Fo/3mc8Yxzbbb6HD9xzT5Mj95bVlTjICByn2fjmhLtaOcsqG1
 q4sw8pTFsUG2fCHmP+QtJBFRkA0bpEyunvI0Md8LuRHOoxD4ALvt0LfkbesRmSeq7L0jfzbI459
 G8Pxfedczzhkd4qaYm3UG+j/0LbX/EMQTAL4qYaGsX+Hkax+DOb5EhR1USFcv72ymoXhoP/a8PP
 YbT5i+9g==
X-Received: by 2002:a17:90b:1fc8:b0:380:7d9f:81f1 with SMTP id
 98e67ed59e1d1-3893f6937ecmr10486373a91.3.1783665065455; 
 Thu, 09 Jul 2026 23:31:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc8:b0:380:7d9f:81f1 with SMTP id
 98e67ed59e1d1-3893f6937ecmr10486332a91.3.1783665065015; 
 Thu, 09 Jul 2026 23:31:05 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:04 -0700 (PDT)
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
Subject: [PATCH v4 89/97] tests/tcg/x86_64: system tests
Date: Thu,  9 Jul 2026 23:20:07 -0700
Message-ID: <20260710062016.1818125-90-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kGP-w_HzEc-g8hYi6nH1krs6DRVm42pZ
X-Proofpoint-ORIG-GUID: kGP-w_HzEc-g8hYi6nH1krs6DRVm42pZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX2MI7v9PbKZgN
 AKcYx5/y54TV/1t0r8nW7WmScaBTij94NuzYTedVtR+JMH7JVlf94iOx0QYB4Q9kp9xvpYboO91
 nrg5HCAAxGLZvHFwPbtqjw2Vacnw6lQ=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a5091aa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Z-FU8ZK0wJ45pbiLfnUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX0DqzMnV1IXNU
 3qq0f3e3azoVPgSW0J5mgW0PUzjYjoipJ8wNWApiQZO+GNWf2oub3FSMtdLMGvBPTz56CRihGNe
 ncnE6BbZasyZkXJdWYaK+XdZ6E8w97M7Lv/+t/LbEE3bC71dqfq/5yGy145h6zakWncDiB273rT
 2JoGoWby8DWFHjVJBiNdFPd8MWQxaWVKqFbFv0OjrKEMa+IuwuIrVPxkW7Ac+HAUQOoYOMYWpvc
 4uVRx7//uMerBq9JdkjzQXRW8U50v3AAL1gJtwb5zEzbM5aBad3ZTM5Kbduan2AAjcfhAUmrqno
 52tvfDHNfIGFlTdKT+OKACra8zoiChKsr5sCNogAk8Y9sPgdU1wwowXsyCIT30w0Ud6ofGQutVd
 xbFt2mn2KJ9dJ79bOn4ls4KJh6Z+HCALw4Owk/SdL7HE8+Q4de652vnjGo5JtH4iwSTdR+SGOgR
 Gn3jTWTNGbQFFo6J3FQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100060
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
index 9d655a466d4..928fc297232 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -2,6 +2,8 @@ cc = 'x86_64-linux-gnu-gcc'
 cc_dockerfile = 'debian-amd64-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
new file mode 100644
index 00000000000..c5348102e8f
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
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'x86_64/system',
+      'gdb_arch': 'x86_64',
+      'qemu': emulators['qemu-system-x86_64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


