Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC31BCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JJ-000752-MP; Tue, 09 Jun 2026 17:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JA-0006sD-Sy
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J0-00086Y-He
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:23 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K59UR3268515
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6IllM3MWfuZ
 IMmsK/xFF+IuXRuKVXdKJXZZaS3jjbSE=; b=E9+ny7jifDP7Vlc9+7//t834qse
 vyZ6l1DNagrSuFSwlg7xHeSRNHswdL4SNV+peBSwYWq5YTNSMjeLn2dYmWL8hQor
 +ZpSN+e2RObCoj0sHoWlRUX3pXapg4KtApMCq4T+k59eqwQ7hMM8NA4APkcc3Dwd
 /owHTStYmt9s/jFCmrDXiGCxHuNAPyetF+dnVcqbXgLa52BPEjcxKvPM4+Xn5sNJ
 QAfyu+S7gw6tOoVoLfhD5n4+yJSnEfDQ4Al51yZh7sWKtO6vtSTw/eHStPzcO7YV
 BrEoV39ZLdzYbXjZHupMaXE19Rsaed55MIxZj461jHaz2uQ6hBeUjsyobKg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3jujk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:07 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-13815e0e6baso5107368c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041686; x=1781646486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IllM3MWfuZIMmsK/xFF+IuXRuKVXdKJXZZaS3jjbSE=;
 b=HF/x94rFgjNqlc5nikzvwg5hbVIu8D4VzOzhGyUexkuXXAZUJgRLOaAceeFIQ4Kqsv
 yvxqAUHn91+lvA++WtXqYSVsEIKWfWH54a9iTMLYYpJx+E07ak8oCS3MyxoLbWVKB/qd
 PhgCKQZoGo8A/suP4Gws74miDb5omgu9QGsPwdQUQj+TBTbyEXpcm4hQJqn4B84jNb/6
 dH98W/U1MUiPwxU5sn9WR/PxetSllTjmOsbQokGWlaoNNe8T44QsyS01KVJsZn9Hndda
 +ysrlN6mlSOTcqVVNRTBZF27xUmq/FPxiCDmnQISZSwNhnCeIP2RGarl2RLUXjYGHgYg
 p8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041686; x=1781646486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6IllM3MWfuZIMmsK/xFF+IuXRuKVXdKJXZZaS3jjbSE=;
 b=JxbgDCufXBEojAhOT3VRaADnVP0es03RTbR28dx63rBTAWC7WVZHp6pYisNNLot+5Z
 fWKd8jjK4tqDp/oChgD0mLKDp/fMS7V6D4yUX3f9zIEqkCg/1Dgzu476pf07roga6FGV
 rwfymibE0zAirB7Gxlcki8ZUA5xR5InNtz0TGoqU9QZwAFJevu+kI6EM2cxOQ19KVou2
 F5cNWGMdiqpMs9HExawbUFXdT90TBg0j+QnbLulIiGCiWTnxM/yg/5kVtiaCkb6SWqrp
 9L9gFlyxDw6SNBN1yQG1OkE8z1sEJLytRGHMXbb+tW7ChpFVBF37k0HYjfx0BRXHvR5v
 pJlg==
X-Gm-Message-State: AOJu0Yz3JQCC6B/zHyjBD0tX6gxPSx4esRiXNUW9ha5oIfSbqjr8wZra
 /vQFv0SUUndhhZU4yGb7lZfNI1LZM0It1j4MnTo3rBwgc4WyEc+n5Dqyz3c5OloLX35q7PhFL/T
 iEI0Jb4NrMZGFgB7cNH05oy09O5CfVPLy0ONCCCYwgjswo4grAGA160kF+zjESkk9c8Gm
X-Gm-Gg: Acq92OH9M76GPJ19CAAkGqzywhAdsqcGFrRTawnGZgOiWDhmYuN30v5IabSNDJGjemh
 oWcEFmXSV6+XS1ydGcPio5Nw5+TrQq50F4g6EoADKI8XolOpFeipfBcJqEo1H75CudeKRhsjUsp
 xbCvsuzqMQ+C4FVyf4m7hEeizNbSQHxB8VA0mZR+KdgolR9sE76NVauTkBN0ivW/bYc8tWAfKUb
 PKWqk+moZUi13ewhj16vDOStx9gA79RUC0/wE5ZD9B32Q/O/u/YvXumOYJfh9YGUAGZCb0DbJEg
 qYSDuhRX8kl31pR6rWNUnDb/GpnLk/ZYwAHkHovJmkaPJjTkdc+nif8viAJTyjDKRkC8vLlr9nB
 xn0UDl0Pe4KZOgBfSdhM2bYO6ob5Fa2mAXTjLwcu60grNDIRFKY59k6HURpNMO5ZndRrB9SP84J
 9bJu5GutHRwX12tZnH
X-Received: by 2002:a05:7022:10c:b0:138:267:af4a with SMTP id
 a92af1059eb24-13806687266mr12324935c88.8.1781041686438; 
 Tue, 09 Jun 2026 14:48:06 -0700 (PDT)
X-Received: by 2002:a05:7022:10c:b0:138:267:af4a with SMTP id
 a92af1059eb24-13806687266mr12324913c88.8.1781041685901; 
 Tue, 09 Jun 2026 14:48:05 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 13/27] tests/tcg/meson.build: introduce gdb_test
Date: Tue,  9 Jun 2026 14:47:31 -0700
Message-ID: <20260609214745.772536-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XeRychqnVRp24w1ORVevlp4E8-EXBUc3
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a288a17 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=ZkoTrUv0hqWFqrPu6skA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfXyH0fCBsyZotD
 XpsGplKwzVbWuWjfLlKBBB1AQd3p9LSvnZIPeIA0VmFNUC2+aU7YMuECaymVKpgeuPAG4r6rhuC
 cWtCx+jxTQ0GthlyfLzhv3Gsnkaq8edRxwNNQw3LtmlTlWvEvzjEGWcJcfbB5UvfbKUWs85zvTU
 t0qvzBa7cM2Nj0zDSYE5GVlfAhSGWZi/wAIYyEl/4BAmNtlyheD0ucfOExZj4j5rZOi98r8vdml
 IJfMffIfGujZLmkn00vMfYjcubrdL6nTjEV4yv2zMtug0cJyGlHTIpl9h/jxYf9iBufR0vFO350
 SrpqH88CHDmmT/BxsFWdIx9n8miad0pBhdfDrFOUPIHdXebHlLs7GumKFsLlcc8HucpTIOMFROV
 ctAVj0TGtQ70BZYs232CfbcM15QW7/tDsQg1AkC6E9JPcuiRltBXiyFRsPqbtaHiDFsx1FQnvFZ
 fGfcf60ngu74yVUjFZQ==
X-Proofpoint-ORIG-GUID: XeRychqnVRp24w1ORVevlp4E8-EXBUc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1496cba460c..d0080eb0f9f 100644
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
 #           'cflags': ['cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
@@ -80,7 +82,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user mispell a setup entry
       foreach key, _ : setup
-        if key not in ['cflags', 'qemu_args',
+        if key not in ['cflags', 'qemu_args', 'gdb_test',
                        'exe_name', 'test_name', 'env_var', 'plugin_test',
                        ]
           error('unknown tcg setup entry \'' + key + '\' for test ' + src)
@@ -96,6 +98,10 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        continue
+      endif
+
       if 'plugin_test' in setup and not get_option('plugins')
         continue
       endif
@@ -113,7 +119,9 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
-      if 'plugin_test' in setup
+      if 'gdb_test' in setup
+        test_name = 'gdb-' + test_name
+      elif 'plugin_test' in setup
         # remove lib prefix
         plugin = test_plugins[setup['plugin_test']['plugin']]
         plugin_name = fs.stem(plugin).substring(3)
@@ -177,6 +185,16 @@ foreach target, plan: tcg_tests
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


