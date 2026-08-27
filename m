Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E66DC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFr-0007G9-8I; Thu, 27 Aug 2026 18:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFp-0007F4-A6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFn-0003PA-FC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMGDC1803885
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=; b=MjYegasaYFHk3t9Q
 qNpUEGtnS6/ncet9xSjecUTq6mmMI7kd85WHRIPd3OYjX0WYyjxV9bOjh03I5qaU
 VXiWf1pcRdaejM6Xv4rsyCWHSd1nb6/nviEWXr4bDl8KBzVNUrRBj050YxjLeRti
 qaHor+hBNjZSEQF2vKJyXtW/t9CyG+WUdHDKPBM716RHbyIM9T3EO/Fie0v3BrMi
 SCaQVZauqusDRLYFXmjjNXD1514ybgfcqN5uf4Lr0h4JUNANey5RZFcix5mqYnYi
 4fnKRL/7eG3j9uZA/QsNy5OnNPX2ZLxIXzu5Kvm6Y+XYkJFtk7i3ebnZIwqsxXnY
 dNmdYQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgu66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-85602449126so884002b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868441; x=1788473241; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=;
 b=gz3tbW5nY+xr/Q+QOw6f3rQxDKhtlac12YFvy7H3i8Gig3ylAEFnTZeCuVVQS2hKEh
 hVR3zZsBT1goB7vqfWgczIH/QxEnGZ4glSKc1N+7N19AvRdXa5aa8GdxeEzuqCEiPOF3
 rPcAgJqKsUni1bN9+JZTltQ0WRhnMtAU2V7kg3zRtop6s4sX/WhIBnXI0qV6XR0B+14n
 PAAS9dZfvyhByQV4SztWmoSHS1ynw5OMN0VuK5TAIWr7LmI06qSvG2Q0RTLtQYJ0DwF4
 JNcFxWblGC0yVqf3vtjeuNIZlx+opVkw3RFXaP58vIYG+tNeHYCdUPwXhW9PD1fXT/gX
 /8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868441; x=1788473241;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AMk1CMU9eBZ9zKutPaQToXQWF2Fw1PQUjMrnTHWhKlo=;
 b=gvfQEbXHoOyLijNWHkpu94aVy/aOwT19bMzNndavfgPRceegxh/MmVJLw7xyMVQTks
 THVefi1Nx6JVaJc6ckn0FyndIuesz/OFOEtKQ3ZYIWjj1yvK62gd6Tm02KbnQ8SMsRFd
 Dwm5nbdtgDHnSABezJz1cs5Lp/RZtQjpOJjiMOtpKeMHoVDpPuvulkG+yHAWc+LuIoGc
 BPhrDjPpBwSZQ9P66bG90iM6shB+sdMJuCI5McsXRdGp1wTtIOUXY/OXDKpYQs8PG8Uo
 FO6oaGsdqcTDiGTni70ANgV4KBtfbxFZxilBmMUL6mdo7DRhIwEP7jQsPsdFlYRRag8e
 4giA==
X-Gm-Message-State: AFuF++kTJxreheeOQiLcF2NlFonqanmt6SIfMc53iCBMb1/fvuuzBLrF
 j7seWXQZAOMYZrtN09wItXkliULqwmTUzqOOWeHU3SqVDTmeDAwa7DpiwTtXezcqFdNRxxBjbF/
 oBb+gNbTubNguCpEnng532NU3xVvbiV2TZLFfu53QpfKVETquv1qIxQh3X5zqSfbfCw==
X-Gm-Gg: AR+sD10zJCB4tBaaIhP6xbDHv89hQyQISUNM03xYRteCWDHTGHRKWveRdp4B22C4/45
 89ghYcpvXnQXoOl2W3xV8ZHprxMcfzZCXsCNJLJ8WMuGf45PEDjMPrNl3eWK52sOI7FG3sHh/E2
 5RsY809QJYYeUpDST3yTKqXlz3V8dWXFmUAiXo3WrM73Aekf0UD7skqliIrbtbaa0djLzmchkX5
 7FpXs1kbDDlE8pqH7S9NKVJeC2s/akxCjrnZ+fKdYJOR6LjyBRM97MCn47zDDh2TXuSF78+yfQW
 VjgbeaheQNYku0pNswg+w+UTS2oIhLGhOah0RsTeW/SG3yvZT8BizpVkJiAOG9ZIW+1tZUZyar2
 wMvxckOwVcu1FvwvQKhJ7dpdTE4DIVNaA1q2Y7A60wuMh/zAiJToWvZ6Pblw=
X-Received: by 2002:a05:6a00:17a5:b0:851:c2a6:172f with SMTP id
 d2e1a72fcca58-85628790cedmr4362857b3a.7.1787868441386; 
 Thu, 27 Aug 2026 15:07:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a5:b0:851:c2a6:172f with SMTP id
 d2e1a72fcca58-85628790cedmr4362769b3a.7.1787868440982; 
 Thu, 27 Aug 2026 15:07:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:20 -0700 (PDT)
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
Subject: [PATCH v8 023/105] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Thu, 27 Aug 2026 22:05:17 +0000
Message-ID: <20260827220641.84885-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b51a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=WryKx-XaCgVW6WutTgQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: D80CqxEry-t1Hi1MVNICCFrbrTTIV3Lj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5BpBH+/4Mw3S
 QouzLb2hhkxBSbGF/4/70X+N7gcgynBeGc9JsGVg5w0iZ+POw0ws1nIlhrBrEd83n0HOMqP4Olv
 flFf8/tM/hNDrnsOMmhMSrLnS7vKAuyE62hxvc7QNVdPmQfQTZzzDmfiXg5Mz6eBOW6/h9Kkc0K
 pNxSqp++MiE4sJxEVtanbD1Ey8ko13XdtqWNwkOjp3pKh/g3ebMjBzFwzOzLkxiWbJ+WCtQ/8S1
 PcHtR/HV0hZKxfYtQkPV4Yol73HGHZDHwxqeCtI5RT2FyqPJN5RTHvpGEK3ON+IHuW5GClH83DH
 p6tp/+p4MLxVpR0eNSKBfIN1T6nst3Xc+YIPGzQXB3yk4Ls8vF5od4+j1824ikzRphAZ/m8ltAd
 2IxipJYIA7/t/g8VEnXcscUkmt43GgnFV0KNzpttG4aNCDedwgXF5zB+TvogaVWv+qezJheip3H
 QQJzL0QZI6lpCBO1efg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2hJHxbu8/Nj8
 aFQ49wjogoBKzIjaEE7+JS5BAhE/bmiQJkZBa6aq8G4NtoyA8nNo4kvO25Fx/qPbSvE00s1LgTK
 pCDT1Dz8iBJOaKltwhxIQi41/yv4Rzo=
X-Proofpoint-ORIG-GUID: D80CqxEry-t1Hi1MVNICCFrbrTTIV3Lj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

Similar to cc features, we declare the same for gdb. With both
available, we can now declare all tests inconditionally.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4487d61ef6c..7384786f7f8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -26,6 +26,10 @@ tcg_tests = {}
 #     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
+#     'gdb_feat_version': {
+#       'name': ['minimal gdb version supporting feature'],
+#       ...
+#     },
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -37,6 +41,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
+#           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
@@ -83,7 +88,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
+               'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -98,6 +104,11 @@ foreach target, plan: tcg_tests
   if 'cc_feat_cflags' in plan
     cc_feat_cflags = plan['cc_feat_cflags']
   endif
+  gdb_feat_version = {}
+  if 'gdb_feat_version' in plan
+    gdb_feat_version = plan['gdb_feat_version']
+  endif
+
   tests = plan['tests']
 
   foreach t : tests
@@ -105,8 +116,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
-                   'wrapper']
+                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -261,6 +272,18 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if 'gdb_feat' in setup
+        if 'gdb_test' not in setup
+          error('test ' + test_name + ' is not a gdb test, but it requires ' +
+                'a gdb feature')
+        endif
+        gdb_feat = setup['gdb_feat']
+
+        if not gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
+          skip_test = 'gdb feature ' + gdb_feat + ' not supported'
+        endif
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.43.0


