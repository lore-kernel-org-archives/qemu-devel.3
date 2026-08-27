Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ABDC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFn-0007EI-Ek; Thu, 27 Aug 2026 18:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFm-0007Dj-3I
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFk-0003FX-D7
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLwhk653895
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=; b=PSEnFkZzpuo11PF6
 EnywM6R5bZxpbJH9hc/XcsJtrgs6UOzi7fI6Yu9h5hqBHAbRutI2MX8/DcD14831
 W8u9IUVgJxCvInLKEI2mwb2R694H1nna5lBTHtZ9f73hGcBU2/3ZXaMo+D/Ecw1f
 AWXwFolmrYBmj4RsqeHHoCojVvxo/F4pkw7/3fW5OCYZ0OWUFw1Jf6Wwf8xn+tHa
 1ILQsIwPF886qV6/LBVjC3lkLSlz94wFH2nYmSa+AzVZgOSUICxWGIFXnm45S2le
 uny/9W0fVuBWoQ+fxxHLN9Lrwp1eWeA9BU11NkZ2kI8jqgvZvf5sTQ2usNF9dl3o
 Wv8ahQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuj16-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so227677a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868428; x=1788473228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=;
 b=F+Wyr572kLJUXa73i9s0dk7m46b9i3Nj8HhLyMzHIO9qSBqhO0kfwN7LO9VVXGuNZj
 TVwssLt/VKjF+vgJ+Ce+8UooddZlmaNF55pGL2k4sxpa6NAqPdWbGScjHVnRYDxyVy2r
 8bykrqxoD5w5Jb20WoTQo1+wnk3hEec2ViJq5gkegUcVBGyAtRJeYQ3FUneJATn0a7xh
 Ske7bMuT1q8ZvQ3hScOiXeWsY1ASr8iutuwc9I4wp9Y8U2cqz1irf2iHrGgLNuFtqkTr
 9CWQPi7NUZT4zgozNdZxvUKiDkrgEE1jcmOcZWExD+rPKOUEejHFDvpQngBP1Pd4MhqU
 lc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868428; x=1788473228;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=;
 b=G1vaJ2Lqrqqg+Pu/cEddux0hp1ow9OwcTNqC2ztYkbA5sjqQlJjVG/AtuGm6mX3r2q
 rqN2BDCr24SuK+UyZZlH0OdkXGbQ1AfXLJ8UEn7gjFskkJ4NwonCpBvJW4S7/roYukCR
 J+4MnPZTB9NFfKd0qhCEfVg7Wvkc9G9pQH8VbHZqdjeQZQ1ofCS79dSIyvlBt37bMYkm
 +9t4KoHzvRCu9nE+vL4nlHVJYQIVT8dqXDvyol0sIboZi4XehZHZH2+4VyWdBRnwbYyy
 Z6h2p3wp9Zxfwm/QWacFqUaNP9syzRUl782TenMyq++Aky8P1XC0SM1OzmiiybxW9lTr
 Fikg==
X-Gm-Message-State: AFuF++nxG/PWMitwUnvoL1QqRaDn/X7ucOuKukkRKREJjEGL4T2IHzQ2
 rkfMdcfFbG9a8FAHsHPg8NCJQrI/TF9h52fULkfUJ9PFaI3kM3v+ZQu4GKxNyozcct2CNogtOFD
 0Y+jdmzV5AylNdDcIVMDmgyu+pgaoomoC+KQms59WsYxLoa4xb6m4NjeVLsXE0v12ZQ==
X-Gm-Gg: AR+sD11MjlEN80/m4gUSc88/6I+Ela4Sput2Fek5S/9NoXSiBlk3bxSRvaFeUHIKpJs
 ByG5z3+FQQI4kgvGpmrCBaerF4e8rXkQnbC3iKwoEj0Koilnsq/r/Pf1GHqzITOTZBXwEESAGdQ
 Gb4mLCXIP7+qlXuokTKc4QVOhZGIHyzLMCUIdP2pWNdpkzlNNDU5hPFh+hexCMGBnoiBfCmEPMN
 lrIAasCulGlsMtUSQBIhLRxhx5o0xGodvlMoXTIwfpswju4p9/kG0IW/TOmehaWBgZ522FENIa+
 eJmNNRAiP/mAJtzGY5+ENc/sQqtPN3Costm/TpwS1SN11Vizslrd3OzNzJM3U+I45LGUc4y9Yzp
 V2ZyiqvXEU9dzVTT+lzR1w48DIWdwkhVfiJcox8MUMyNsEfg/JYIcdgVbq2E=
X-Received: by 2002:a05:6a00:1143:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-8562a1f7635mr4063959b3a.7.1787868428453; 
 Thu, 27 Aug 2026 15:07:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:1143:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-8562a1f7635mr4063883b3a.7.1787868428027; 
 Thu, 27 Aug 2026 15:07:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 014/105] tests/tcg/meson.build: introduce gdb_test
Date: Thu, 27 Aug 2026 22:05:08 +0000
Message-ID: <20260827220641.84885-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P8IIl_jf4YqvMb_ANo3Bgp-VAEYWrRoB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7/rRfDWdfJP2
 7zXEvhtUTXmwor52G1nBzwlSWwxsttsuovt9Z4+xv7gMIfez3TU+1Xv31u891R1YPHBsgFdXZVZ
 1Y2iiV3XgWDztvp7NMHq1E+uR0k01y4bL9KFK4MHzYKM2kWsHl66rn9l8wkCk1HJsIKAzPFlObE
 TWqTChlRzM+2aNLiVr7H9/xAPAzX9RSdcXpPQPLYm/m7iqlvfpufg4DAJYJnXs5RuHFZFABZHWI
 PMpdfdyjV/z5RX4lRUXcPzSTyb12AfNEc40U3Tq1IvG+tBvM56Jxu6WN8GW6Sk/HCQBMT/cvsod
 rQ90emdUyWgiMlsFuPgH+ulX7NsaFXbjEGYUv7ZdFCprbHP+v4skbpiYFeBancAESbxCUh9i0JT
 LWc9MurQQR63YL1QFqfSZKiSmsoCJZATxEqV5TJG+F4eXFgrnYZbhNsZtcmVEtSgUstrPxTmX2u
 GMZutDGLUCpscFAAnHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7rwzVzFTCR9L
 A6srQfY3QYrZhrgpbSLEVOa5ggDYTCnYYMQBIwAcjHW90DePfBARcqafOC3mCO5FOKA2NOEQeD2
 oEeR9W1AWVWyH/ZJ/7ZNiwVmGy2UVeU=
X-Proofpoint-GUID: P8IIl_jf4YqvMb_ANo3Bgp-VAEYWrRoB
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b50d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

We can now declare a test requiring gdb interaction, based on
tests/guest-debug/run-test.py.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3714fe4dc0d..76375615d0b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_gdb_test = find_program('../guest-debug/run-test.py')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -22,6 +23,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
@@ -83,7 +85,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
                    'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -102,6 +104,10 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        continue
+      endif
+
       if 'plugin_test' in setup and not get_option('plugins')
         continue
       endif
@@ -118,7 +124,9 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
-      if 'plugin_test' in setup
+      if 'gdb_test' in setup
+        test_name = 'gdb-' + test_name
+      elif 'plugin_test' in setup
         plugin = test_plugins[setup['plugin_test']['plugin']]
         # remove 'lib' prefix
         plugin_name = fs.stem(plugin).substring(3)
@@ -182,6 +190,16 @@ foreach target, plan: tcg_tests
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
+      if 'gdb_test' in setup
+        cmd = [prog_gdb_test,
+               '--gdb', gdb,
+               '--qemu', qemu,
+               '--qargs', ' '.join(qemu_args),
+               '--bin', exe,
+               setup['gdb_test'],
+              ]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.43.0


