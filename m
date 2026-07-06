Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2786EC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1n-0005mn-0t; Mon, 06 Jul 2026 18:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1l-0005lk-1v
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1j-0000Jw-9B
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:43:00 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDvgY1566484
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iLRFTW/0BvS
 O0TqxJ/8jR5u7qYix/fwI04st+z6D75c=; b=R3QKNC3dS8udRZrT+E47tvdjMRm
 cVw686ysaHZE77Mh3ax/xi5z2JIrXq2MOiFkNhwB8fAyNzNuScViKUTf0iLUuA+P
 k5vQxvU1SupSCHWyms+cQ+BITSZMtyIed52lVTE0Z8dGNBxoCNNyus/edZ3Jbaxs
 HfmNym90FGg7Gn44fMRB8mHJ63l5wktwyV1Yh5ozK56nU9HhJG+m82ko6eYaeYes
 ACYo2Q1q/53Ez0PF6Ct6QbUnUcPB368gDj9xJx1gPrbRvt3j+OytLTCAdQsNutmt
 twkZ1a4jvFZVaU4XeklAT5QstXK0+43D25X212JFCaRN6b0ovLjPy6Mp2BQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7kucp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso2972195a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377777; x=1783982577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iLRFTW/0BvSO0TqxJ/8jR5u7qYix/fwI04st+z6D75c=;
 b=GIgK8Y2o3FVncdIRXlkvoiiTKerlbJBgimKALaOjh6/QujAkmDdS9QDSPXKVtiPyjU
 EVdxK7PVWomhUNVuwRa0pCGovQop06T2wRnl735D74xYbZGBVCMGfOpT7UZFHVh5kGv4
 x0vORV8oB/N8tfVj5ojP7gWRzdI02uP3WOs3iZy60DHMySEf0Rw+varOyMPUxbnciLyj
 IRiwzeEnB4yLSF0iEEB/w2zJituOlEDpazo+WlKsARiUvzzF+Gfrymll6o+GHARk1E4O
 QNMVW5Se4c6sZm4suFt154F2AaOzyhhQfKE9LVUg8Uasx98ig4AK3neeMvox0j4uTts2
 Jcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377777; x=1783982577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iLRFTW/0BvSO0TqxJ/8jR5u7qYix/fwI04st+z6D75c=;
 b=Os1K/qoNi6TDyJpXmMzQO7B4XG0m7JWcklJ37GTqWaQ4MFr04fe3IzVi5TyfCKxFPF
 KRcx0EC3yAyCfrgr7awMpFB1CZKY2lsQFSxVBJweUysXe3e2G9oTiLzyifC4UJdlqe1O
 4NIq213ibWdzTw1r0HSORvJE2wBBMM8zqjtc0UFUNBjvVVFpG8Dwn9a1gtx2Rd3B4ndX
 OFXXbEICldyBJU0ma2uHYF7l0U9K1e7Olhe5uhnibWicQ1uPvxU2LBNH/TBhkEXyTect
 Z9+aPIZHjO8xs2/SFd1uLlBys5CdSHBs7F4Q+Elv7cnjQ6cuZSsWrnupbIwbBp9pDFVj
 kUbA==
X-Gm-Message-State: AOJu0YxD8YZqWKpsINpxHrJJTMcEc+rAqBRqIsoSSIVmuOHNOE5S7sry
 4TBO+ud6scQIiLxESu5W4BVNTUF3k0YWLCPALdkkl/DVJBWYdQN79T4k2bRdstLYG1FSJJhErIQ
 cmndXFIfl8Z8E0ODVogaFVIwvb9BsxN5b364a3YK6MRGWOXlpgqsDnq3OMueoS4GGpA==
X-Gm-Gg: AfdE7cmWpV1DDINyqYt87DQ3SzC2uVQa/m5IGTQ0k1/IUBKhfJwTHh/bHAu/MPtrZbQ
 2lpg/bOXaG3WoAcZvZDzklxkEHUZGk/idNgHaUh3Vwi0O0xs27B6FMlhjCVax+dH3e3AtloxUwj
 MYbiFjAjQLswFMFlGgzIRSZp52N+ijFggZ2649FMy1SZ00jU5K5A+Xcc20CzhH+Z8jw4S/Fsj+S
 4Fnv2y4VqO8ls1GMc5wqar9YZiCg6DcyOcsrWUJgs9hv4qFfqbRxMxwCun8XpXuLW/Axu6BYRVJ
 QqiwAhMog++6euC1JNNHMt3YqCS/6Nw7eMcx9kA4lVwZazKVk24R8nwC1VOJOzRYC7ForN/rJUk
 e8QzG1U2LJCbm5QXAOxJY1mwtrzNfPBm5VgZ0AasTEmNkHfapBLRewOe0rD+szaJYo1vnGxII3y
 ptWGhH+Q==
X-Received: by 2002:a05:6300:193:b0:3aa:ec1c:84e5 with SMTP id
 adf61e73a8af0-3c08eeb2658mr3123382637.43.1783377777214; 
 Mon, 06 Jul 2026 15:42:57 -0700 (PDT)
X-Received: by 2002:a05:6300:193:b0:3aa:ec1c:84e5 with SMTP id
 adf61e73a8af0-3c08eeb2658mr3123350637.43.1783377776706; 
 Mon, 06 Jul 2026 15:42:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:56 -0700 (PDT)
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
Subject: [PATCH v3 88/91] tests/tcg/xtensa: system tests
Date: Mon,  6 Jul 2026 15:33:40 -0700
Message-ID: <20260706223343.988769-89-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXx6artxejwsWg
 HbhSBHwZXHoa2bdkaTCOmJbz87IBm7lopVptsh+6u+65Rgb74TnE9P0b99ZHxlRN/ZL7ClxZuzC
 j6JY50VEBNdkPhp8xqCEUikXqI3hZfghIenVhAgSLHeQejhkotkc11liCy0rE3PQhFpvq0r/Hbn
 Fbi0A+czde/BtVABVXZAzuIgdN1Coiz+C9ZI/zr89cnORK2gf2cL5AKCDXJRBaseNiMoehOmXtq
 WKH0aURcNZb4dn2Ze9qrXwqbEwL0/Tsl2gd2eVAhiY0leWUn/5fnOxR6YA0RdvgJ1zWF7EUhG6G
 IvYVStf58RchQP3W8cK694TSVwJ78cOsFGSNTKaCjV5lyp5a484Ant57sFLsjA1iUd2YKYAdle1
 Qi0Jg0qdolHWgCStmOr9LawVPLUQjpdGg3OoOHtagJg3r6zThLNrd1QuIRMuahCNP1/WyNR80Sl
 21TVDF30v/how4XyIFA==
X-Proofpoint-ORIG-GUID: JCHJLgRxNm4rosTRBULp0GI5DUMGTTa-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXzeqMUEw5iWuG
 wA3Dda5U3t5ng6EAKiz8sgi8x/SGGS34jOjma7wQ3x7PMXDSTq6ZvA4BVoJumvIC/2XhkW4VQ+I
 vdMXRYnAoOcvlftN7rIIdANA/TdPZxc=
X-Proofpoint-GUID: JCHJLgRxNm4rosTRBULp0GI5DUMGTTa-
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c2f72 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=2v8U_cp9r4gyIXDJjHgA:9 a=3WC7DwWrALyhR5TkjVHa:22
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
 tests/tcg/meson.build        |  1 +
 tests/tcg/xtensa/meson.build | 89 ++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/tcg/xtensa/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8b3006ad4ad..c16c63e0275 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -153,6 +153,7 @@ subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
 subdir('x86_64')
+subdir('xtensa')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
new file mode 100644
index 00000000000..a31658e64a3
--- /dev/null
+++ b/tests/tcg/xtensa/meson.build
@@ -0,0 +1,89 @@
+tests = []
+
+cc = 'xtensa-dc232b-elf-gcc'
+core = 'dc232b'
+
+core_dir = meson.source_root() / 'target' / 'xtensa' / 'core-' + core
+link_script_src = files('linker.ld.S')[0]
+link_script = custom_target('xtensa_linker.ld',
+  command: [meson.get_compiler('c').cmd_array(),
+            '-E', '-P', '-I', core_dir,
+            '@INPUT@',
+            '-o', '@OUTPUT@'],
+  input: link_script_src,
+  output: 'xtensa_linker.ld',
+)
+crt = files('crt.S')[0]
+vectors = files('vectors.S')[0]
+cflags = ['-nostdlib',
+          '-nostartfiles',
+          '-mtext-section-literals',
+          crt, vectors,
+          '-I', core_dir,
+          '-Wa,--no-absolute-literals',
+          '-Wl,-T', link_script,
+          '-lgcc']
+qemu_args = ['-M', 'sim', '-cpu', core,
+             '-display', 'none',
+             '-semihosting', '-icount', '6',
+             '-kernel']
+setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+tests += {
+  'test_b.S': setup,
+  'test_bi.S': setup,
+  'test_boolean.S': setup,
+  'test_break.S': setup,
+  'test_bz.S': setup,
+  'test_cache.S': setup,
+  'test_clamps.S': setup,
+  'test_dfp0_arith.S': setup,
+  'test_exclusive.S': setup,
+  'test_extui.S': setup,
+  'test_flix.S': setup,
+  'test_fp0_arith.S': setup,
+  'test_fp0_conv.S': setup,
+  'test_fp0_div.S': setup,
+  'test_fp0_sqrt.S': setup,
+  'test_fp1.S': setup,
+  'test_fp_cpenable.S': setup,
+  'test_interrupt.S': setup,
+  'test_load_store.S': setup,
+  'test_loop.S': setup,
+  'test_lsc.S': setup,
+  'test_mac16.S': setup,
+  'test_max.S': setup,
+  'test_min.S': setup,
+  'test_mmu.S': setup,
+  'test_mul16.S': setup,
+  'test_mul32.S': setup,
+  'test_nsa.S': setup,
+  'test_phys_mem.S': setup,
+  'test_quo.S': setup,
+  'test_rem.S': setup,
+  'test_rst0.S': setup,
+  'test_s32c1i.S': setup,
+  'test_sar.S': setup,
+  'test_sext.S': setup,
+  'test_shift.S': setup,
+  'test_sr.S': setup,
+  'test_timer.S': setup,
+  'test_windowed.S': setup,
+}
+
+if 'qemu-system-xtensa' in emulators
+  tcg_tests += {
+    'xtensa-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': 'debian-xtensa-cross',
+      'cc_docker_arch': ['x86_64'],
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensa',
+      'qemu': emulators['qemu-system-xtensa'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


