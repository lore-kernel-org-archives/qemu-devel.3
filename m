Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B6EC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4m6-0006tt-62; Fri, 10 Jul 2026 02:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4li-0006WR-2V
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lf-00075i-UI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:25 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nS4e3848800
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0lg0yBtwgH9
 /F0Qa5nq/wWn1UEruf4rrusS0PSFd54A=; b=abZTbVAQBIIo5jDD5M89/sWrVIk
 Dt7+vlM7Us4T409HhDisTtOGJA7VoeR/wC8JFs8/qLMhROvClZyD+qXN4LpRCsGa
 CDr6WvH5ZxyoXpO24VV2WwlKIosNyrbqGtK3Ads/mbh9XP3/3pG327lp7HNTaElm
 ZaqbMPGKU+RBBeAUicxJxagBGsy1P2UyNUmPheN/LXNjX7HY3yIvG7BEpm28CEAc
 pVzGuxkWU177HbN0VkWE7lIKJCHEWMHARgbZO71GNvEUblmjQOdsqjc8Ujb1u3jw
 TUi3oTEHy+Qykjj4xbcAPb2cTeEZnxSUPveTC7Z0vm0nf6L2ZIGqu1tH9hg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu3n6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so809418a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665072; x=1784269872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lg0yBtwgH9/F0Qa5nq/wWn1UEruf4rrusS0PSFd54A=;
 b=LV7MOPl8mNtb6R8p8Hs3eyLFhkXdodknXKdzDIyrtmsSo8lcfDfyVp4D4k/oyvZsvf
 3ptth27A4yBn2uBZfy3JoO638tkLapP1lqp8lzT9QYU3fG6lBPPJLLb4ZEWLxBMu9zQ/
 x+V28OZwexh5trbHruwCGT8XNMEl/J/G/FNZdxZfEiEhK2DoVpNNJPo99oUjm0PRKCQi
 hoANK5dKNPfhtb0fY70+040/i/BxlspRbMADQYj3yuwWiaX7dMC6FgDTMFVd8szEAY/5
 qX+rjtMGnd4qaLFBslp5MoMRGB2nfFa/n9R8NU71Y+nwR8BGoQqdUK1I1Z8kqcdhnGIU
 4/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665072; x=1784269872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lg0yBtwgH9/F0Qa5nq/wWn1UEruf4rrusS0PSFd54A=;
 b=X3wloYSrRLx/rq5p15ZQSSpsZDITaLZ9RRpkZb09m8ewqL51vXu7KygRBC8L7PSbft
 E3RK+8yYUTkqkAfo4Bt4Ag1QKOCctR9LJsrq3lbT3fg36qauSVKOZ05RYu8LqSAXmDa7
 esl9xHa4o9kY8cD/NMiDFiQIoXi9ni61GFEh66GyjosO/R3XQ1zhywGBpZRWixP5n5BN
 1Gw2trOcyHEIHvmBtvI999szr5OOBVgUvMk3C1CTMoZNOSS7XBGady/w1G43csRvgJQG
 gLuj57cmc2x5UOAWjVLhEMa5K8XeamOQL0qkf4keZbmplG5IHc2lqKFxa3gp/Qz6cQYJ
 l3Vg==
X-Gm-Message-State: AOJu0YyuCMIxGWTnr17uqzGPyeukHMWnRMObAWc1uYUIvW62PZc9AMD8
 ODJq/cxBaxEsklElhxmZbyzYNBEVzCnOW/sPi8REsl1Rl/66kETFKL7tmQRr9pPeLUhf5PiAl9d
 UkAJ4veh3zYj9n36gIyeUaHrPik2T0RFzTLVFaSii849PIH+YRx/cAUrN2DKOWiS+lg==
X-Gm-Gg: AfdE7cn5yRr+aWdwMqDh8Imrkg/xeFKV3oULMtF8tmx0EgvSMVVytdewgkDb6lIfGG7
 A5u2InxyJ/jBwgXWrswbeVfjVg7fbORWLUG1lQ7aOoRfXQ2UqQ7KeuLA2DGQh/sgXWPMSiNWVTu
 +ZkSQBmdRyVISVe6rMdgTz+mXSwUk4F36RafLnEWL0/252URG2tKo1pfQVfqSefIAv87G/pXfGI
 iT9oF58XrQNMgFIXUihE//yNHd/qxUrO1hSmiXRcjOgsi4kFH+MNrRKHEml0wMng+N4TFEJHb3c
 tIx/YDJCYvOQIwum5eImDUfykSx+J+DcmJaw3Im+1gVLmBzzcyj7CbT+q3bt0x6Cv6FCqxIIO/9
 TtM5cy/A6JIALLrb7xzkVt9cxsYwIuUbKX1RxQZVIXmWTjhe9m2NglgfNK4yhmnnxnCQk5K6Mf/
 yTbHi6CQ==
X-Received: by 2002:a17:90b:3b8d:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-3893f97cceamr9083824a91.7.1783665072003; 
 Thu, 09 Jul 2026 23:31:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8d:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-3893f97cceamr9083780a91.7.1783665071421; 
 Thu, 09 Jul 2026 23:31:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:31:10 -0700 (PDT)
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
Subject: [PATCH v4 92/97] tests/tcg/xtensa: system tests
Date: Thu,  9 Jul 2026 23:20:10 -0700
Message-ID: <20260710062016.1818125-93-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OptCvRIIaEKKzV2ozArXMPnNYwrEKW8c
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a5091b1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=b2Vg0oTDay0eUBD8vhoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfXxa9y+9OvLJXg
 2Nc7tmPYaqkbAIbEaXUyqIWXr38PLUwu9sxyMM/kdNA/uzjrRb3kFCBik3MOVnlMIdIW4oQX9rJ
 NajKrgnKKz1LvGHzCyFRZVGDVAQ8nb4=
X-Proofpoint-ORIG-GUID: OptCvRIIaEKKzV2ozArXMPnNYwrEKW8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX/pRx3lvqEnl3
 bYIuM+gRNHzuFSo8HZT+/PSXXNQb0XGzp9eLcmF2j2MMbhqvOvzhCoEDkFhTIFShKAkQSxUDIwx
 H5zf5nRakB4jwg2Ql+mDcT0I8mhmkqCTudlMAC/aVb0agNcaA3INTAYSXHae/dXNENXhRHKi7K4
 +szdLXYroGV70ipt+l49GiRMz+DHuHw9NfVr0Fg1HZrREIFrsEgs4+BA9zL3ivXlfO1LuCOTbha
 u5f6/WuH+2mHfdHgZEKiuiMVF42gzNbe9bH5d7Xb2PEdrVcKE5Tu19TELibAvUbeeQQKy06ZL12
 dm+uJHmp2xQOBX1tQTC+8+YxVX0cpVYgGGXyYYd88/KoRVsw2iUkckNZ82NlnZvYEADL+kC065U
 uVU+3Vim+OKe1VeQbV9VvUjpIAunMavgOiCN0m6v7M863d65nIKuO8jB8ui8PIR2scOuvkEB3jz
 Yia8kq5YF44gHjlJy9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
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

We prepare structure to be able to test multiple cores.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build        |  1 +
 tests/tcg/xtensa/meson.build | 96 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tests/tcg/xtensa/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b7a8ea7f564..38eb9bb5a66 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -153,6 +153,7 @@ subdir('s390x')
 subdir('sh4')
 subdir('tricore')
 subdir('x86_64')
+subdir('xtensa')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
new file mode 100644
index 00000000000..7c3c4f7cd62
--- /dev/null
+++ b/tests/tcg/xtensa/meson.build
@@ -0,0 +1,96 @@
+tests_per_core = {}
+cores = ['dc232b']
+
+foreach core: cores
+  tests = []
+  core_dir = meson.project_source_root() / 'target' / 'xtensa' / 'core-' + core
+  link_script_src = files('linker.ld.S')[0]
+  link_script = custom_target('xtensa_linker.ld.' + core,
+    command: [meson.get_compiler('c').cmd_array(),
+              '-E', '-P', '-I', core_dir,
+              '@INPUT@',
+              '-o', '@OUTPUT@'],
+    input: link_script_src,
+    output: 'xtensa_linker.ld' + core,
+  )
+  crt = files('crt.S')[0]
+  vectors = files('vectors.S')[0]
+  cflags = ['-nostdlib',
+            '-nostartfiles',
+            '-mtext-section-literals',
+            crt, vectors,
+            '-I', core_dir,
+            '-Wa,--no-absolute-literals',
+            '-Wl,-T', link_script,
+            '-lgcc']
+  qemu_args = ['-M', 'sim', '-cpu', core,
+               '-display', 'none',
+               '-semihosting',
+               '-kernel']
+  setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+  # Multi arch tests are not supported
+  # tests += tcg_tests['multiarch-softmmu']['tests']
+
+  tests += {
+    'test_b.S': setup,
+    'test_bi.S': setup,
+    'test_boolean.S': setup,
+    'test_break.S': setup,
+    'test_bz.S': setup,
+    'test_cache.S': setup,
+    'test_clamps.S': setup,
+    'test_dfp0_arith.S': setup,
+    'test_exclusive.S': setup,
+    'test_extui.S': setup,
+    'test_flix.S': setup,
+    'test_fp0_arith.S': setup,
+    'test_fp0_conv.S': setup,
+    'test_fp0_div.S': setup,
+    'test_fp0_sqrt.S': setup,
+    'test_fp1.S': setup,
+    'test_fp_cpenable.S': setup,
+    'test_interrupt.S': setup,
+    'test_load_store.S': setup,
+    'test_loop.S': setup,
+    'test_lsc.S': setup,
+    'test_mac16.S': setup,
+    'test_max.S': setup,
+    'test_min.S': setup,
+    'test_mmu.S': setup,
+    'test_mul16.S': setup,
+    'test_mul32.S': setup,
+    'test_nsa.S': setup,
+    'test_phys_mem.S': setup,
+    'test_quo.S': setup,
+    'test_rem.S': setup,
+    'test_rst0.S': setup,
+    'test_s32c1i.S': setup,
+    'test_sar.S': setup,
+    'test_sext.S': setup,
+    'test_shift.S': setup,
+    'test_sr.S': setup,
+    # test_timer is time sensitive, use icount to control time
+    'test_timer.S': setup + {'qemu_args': ['-icount', '8'] + qemu_args},
+    'test_windowed.S': setup,
+  }
+
+  tests_per_core += {core: tests}
+endforeach
+
+cc_dockerfile = 'debian-xtensa-cross'
+cc_docker_host_arch = ['x86_64']
+
+if 'qemu-system-xtensa' in emulators
+  tcg_tests += {
+    'xtensa-softmmu': {
+      'cc': 'xtensa-dc232b-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensa',
+      'qemu': emulators['qemu-system-xtensa'],
+      'tests': tests_per_core['dc232b'],
+    }
+  }
+endif
-- 
2.47.3


