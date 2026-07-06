Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEBEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgryV-0005ts-OD; Mon, 06 Jul 2026 18:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryU-0005qa-8S
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryS-0007PH-EV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE6N31626349
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EiP3mU7KAXe
 +oFuetzV4hah/ftKxlIa9rSei2+9p+ac=; b=T9Os6qUuW8ntRTYtvAjpbrUEo6P
 b3ttfOvfnAbXWHKPq/C9FXRFIKq+ADz+pSyo4a9l1aHHd4wfzgOpjK4PU3hdtyHb
 6/E2LpcUI2xDyjlQPH38vTcXg1lMMH3Lvbi7U5q794tsySSDDsGskVCdTZzc+KM/
 +r6N5tCi1bWeicYAtEQCZ4tNlZUOBApOjg7q3ixEXkqEE2dAT9ZR+MAR5DuvXV/T
 yHt9wgNdhA7fJ3IJu85mfmYWleRLE+nLzAvjDC/M/J+xM4LVJmZ2X8sq01b45uJw
 vw/lXErP9MuqCpIj75DRPoZ/xb1EmyQntkbcizHaKpLPiHuYqXp+uCq69SA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bnsc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso3094237a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377564; x=1783982364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EiP3mU7KAXe+oFuetzV4hah/ftKxlIa9rSei2+9p+ac=;
 b=kD2kYAvFbTy5sM1+LTt7/OxD+1EOl9kmmn5c9YKJFVAEHdx3cfJjyuL5esFElgPbRC
 X/hi+PanMeFym1TlqcLCnrI0HqAlapj0FMPT1kVOJFgnUeBN+zYkUeV9e3nIXrmQwLqW
 OC6uzzXtdN4NV2gpMAfOvH/ZD6p912QB70lpaDgT1LNErIT1bmoi19/0XGMPhvD5ScH+
 Mvs2MGF8do21EUaWNIaKxU+ZSJMVk0NtLmBpgYi+KYguS9AEIn2rHGVLn7c8WSvgNYNg
 bT5q9SSEiSqScnkkDhzcMIcFG8jiu6lRl3J/gO0IYxK1PA3TRQTWPupDl+xOvbvPShPU
 JUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377564; x=1783982364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EiP3mU7KAXe+oFuetzV4hah/ftKxlIa9rSei2+9p+ac=;
 b=W0ljTgkcb0YtPDmce9nih4i5b+r7zy8dxYxnLlZd+7/ZdkLHPoBKippMC6gJQg5+27
 l7rmDLjMuvMrqfDdVYnIbud8tXwiL7a1Vf6u8k3Pq3TTtXIM+Q2NCvRQoEOgFwSEodzQ
 2w+Jc0cXCEPKQHGDK5h/7BIKu5ioVtUszbNmhoktHybfKBTfbaejHC11P7IlWbR7Ou48
 GqLcdPwMkeULjjBWnQlwBcYAJnILplb63nz6QYkTpZ2OYv78tCHltrRg9nOruLPgZ68Z
 IvWBINzIYxiX/qlbUgcxaP2KF3Tql3Qn1Q/y5lLAeQMa74nvrkecL77ihkznj8he99Rq
 /lOA==
X-Gm-Message-State: AOJu0YxiWRZviMvN1+TJbhD5oqaOkn6suXtht/wZEAFLbFQKuD6UrfQu
 tTaMTBrlp0XI5C4/m98F+l4REdpjEl2TT82ywI2lWyvJQGfUbqhpkMNYfn3F5Hkty0liXeEdebC
 s0Zv60v5ULR/Ff8jkYLu9Yd8NM1EUjt2XIAvVDH+4do4MrvdiwcxIyRKiTb2p9NB6Bw==
X-Gm-Gg: AfdE7ck2jkdg9SWFAt8/vTc1HhVxJEr1GZZr6rLmG5CnfZmuCKEEIy4s/3To3Aa/6M/
 uUF2KXGuvbskRvf4sZlDqo+X09IJOwy4vtwuJXp8WqsdcXi/WimOR7adEnZ80+qJzQrD9Qczdmb
 HeAEpbu+SBEbCJDKgQ3Id88v/cejVJFs5XUDooikkWA9H6Yyo+iggZPKHXmVnY4iScGkWgEmCTe
 AfWXMPvhgXIO8kUh//smqPlQf7EuAmth/fPuq0FV1xhsdXl7Kk5By4ibIY9IqkVrGTHUMYO2/Ad
 zPG1Bu0j65NfeHWsQzwFei6W3Pv/U7SIBX4N/Twad1VJ3Gpj6aDsu4705DxhnBWQd6ArSo2Gx6P
 OgJ4wMonMSJpcosPJWB3dXVsUKTU0DOfHPJLAR4N5vb45SBp8J1yFqlRrND6hhvNZkMgVHTMdpV
 F9PBNBrw==
X-Received: by 2002:a05:6a20:e20e:b0:39b:dea7:5626 with SMTP id
 adf61e73a8af0-3c08ee369d3mr3357374637.35.1783377564405; 
 Mon, 06 Jul 2026 15:39:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:e20e:b0:39b:dea7:5626 with SMTP id
 adf61e73a8af0-3c08ee369d3mr3357326637.35.1783377563878; 
 Mon, 06 Jul 2026 15:39:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:23 -0700 (PDT)
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
Subject: [PATCH v3 79/91] tests/tcg/s390x: system tests
Date: Mon,  6 Jul 2026 15:33:31 -0700
Message-ID: <20260706223343.988769-80-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2EXp3ZFPKxg5uN4rerpumZp-e2rl9O_e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX8I96zbCNfFj9
 062IHHOFswvyk5qpa5hATtaS4pxIHPs9ck5HxFyYCQH7dKG5eGu6kMqiprUD+ae6cDdBXTW0ulc
 QB2FvQ1/fpCJf22rnUTntDEnTsQjkRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXzg8BmhgF4zrm
 JiExD1pD7ncjksiJakWFs9rdWM63iIC2kcA4zTQLFYwQXl41axM8eTTTOU3iK2/titp83LS2DUM
 cuvRlO4m2VLHhPhmik30v4Bk/+qAvyZExPZvj5EwUAjI5nMC0irPFT3zKkVmMKEd3M9VlESsMVd
 HO4y/MalBY1B/wwrlpnAOpU8PxS1JHSRvabOQ2xcdh8R2JK1WWDdgIeMLj6Lg0XQIXzEj1NqwSN
 fv76QUwWqGMDmPqhI3cAGMfMZNmdjIVLKtWWOnrOZDMxutml5BPdxSoiroApfhSyMqkXo4AyaN8
 NH49KzWKu7lzYX+Invw50NTFJYek2W2P8B/wsn+uBdmfJhm6ifGfTRrqd2l6AX41QR8ywfAgeZG
 +cq06wtcrbLQC6Zl1cflRWwqmENaIv2OYsmRbZVkEwD3KlcyD3sxRHz5XJc5eDrezAFGGzx5/im
 /hK9s03UMKiyw1LsxAQ==
X-Proofpoint-GUID: 2EXp3ZFPKxg5uN4rerpumZp-e2rl9O_e
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2e9d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=sup0HnWOECoxuvPl1CIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
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
 tests/tcg/s390x/meson.build        |  2 +
 tests/tcg/s390x/system/meson.build | 92 ++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tests/tcg/s390x/system/meson.build

diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index 295d24f0e19..7993fc40783 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -21,6 +21,8 @@ tests_s390x_pgm = [
   'strl-unaligned.S',
 ]
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
new file mode 100644
index 00000000000..0cd79f77644
--- /dev/null
+++ b/tests/tcg/s390x/system/meson.build
@@ -0,0 +1,92 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('../softmmu.ld')[0]
+head64 = files('../head64.S')[0]
+console = files('../console.c')[0]
+ipl_inc = meson.source_root()/'include'/'hw'/'s390x'/'ipl'
+libc_inc = meson.source_root()/'roms'/'SLOF'/'lib'/'libc'/'include'
+cflags = ['-nostdlib',
+          '-I', minilib_dir, minilib_printf,
+          '-I', ipl_inc,
+          '-I', libc_inc,
+          '-march=z13',
+          head64, console]
+asmflags = ['-nostdlib',
+            '-Wl,-T', link_script, '-Wl,--build-id=none',
+            '-march=z13', '-Wa,--noexecstack']
+qemu_args = ['-display', 'none',
+             '-action', 'panic=exit-failure',
+             '-serial', 'stdio',
+             '-kernel']
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if 'test_name' in setup and setup['test_name'] == 'memory-access'
+      # s390x clears the BSS section so we need to account for that
+      # ./validate-memory-counts.py --bss-cleared
+      setup += {'wrapper': setup['wrapper'] + '--bss-cleared'}
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_args}}
+  endforeach
+endforeach
+
+tests += {
+  'mvc-smc.c': {'cflags': [cflags], 'qemu_args': qemu_args},
+}
+
+setup_asm = {'cflags': [asmflags], 'qemu_args': qemu_args}
+tests += {
+  'bal.S': setup_asm,
+  'cksm.S': setup_asm,
+  'clm.S': setup_asm,
+  'exrl-ssm-early.S': setup_asm,
+  'icm.S': setup_asm,
+  'sam.S': setup_asm,
+  'lpsw.S': setup_asm,
+  'lpswe-early.S': setup_asm,
+  'lra.S': setup_asm,
+  'mc.S': setup_asm,
+  'per.S': setup_asm,
+  'precise-smc-softmmu.S': setup_asm,
+  'sckc.S': setup_asm,
+  'ssm-early.S': setup_asm,
+  'stosm-early.S': setup_asm,
+  'stpq.S': setup_asm,
+  'unaligned-lowcore.S': setup_asm,
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {
+      'cflags': [asmflags, files('../pgm-specification-softmmu.S')],
+      'qemu_args': qemu_args,
+    }
+  }
+endforeach
+
+if 'qemu-system-s390x' in emulators
+  tcg_tests += {
+    's390x-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'qemu': emulators['qemu-system-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


