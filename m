Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99DAC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNe-0004yr-NE; Thu, 27 Aug 2026 18:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNc-0004xv-Q8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNa-00063I-TP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLosp3848239
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=; b=Yfvk51egP4FrBUfU
 7kakSNdA723vIaZD6P+kgdgMaze/y00SeIDzqnfCrTEgjy25JT1TzTgcppDE4Lbf
 8wspQj5b9rUxO8XMk1wxKDkDfdHY37cA4QhGqmuc9jWr4T0Ff879BGUy8WTgG1OR
 2oA+m5PRFPyMKDiiLHrOJxfReSZXVYbVuS7rwhlnW4l3EtUeEvgr1F9z11TdRNof
 wAipKA2WjZXa7HTJZjiTaTxqS36Vw8Dl0YpFemZQXfiOwrVl+vnwwHWedtRvBqM3
 +Ha5VDdWghaepmWGZk3TcwGO8+tZizqVgwPBMBq4yGaTUMoY52aKKrzlGytGFpG8
 NrMT6w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc0tvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-85602449126so903215b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868925; x=1788473725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=;
 b=dMuXk8+TrC8NQfKCZQ3VMkuUHGb5Y6eXC0sJ8iOMAR4V/C0yMspyz2sE+47oV1O8kg
 4xN7UaYflhdGbxSxC86LTbPuPgGkAvcPKJvQUxMA6Th6kTIZ/XkfXqZ/ef9g1ye3Zs2g
 IEH5hdt9l9aGY1a51KUz3l9ghEeFwXzppBwtjcj+P979LmmtwcD0TY8izcvAVHiYrJmc
 Y1Htq0QDicQfPEHfIiLRTG8/DYZ6nwPKI9A1vV/5hG97Ue5Ag/yyLA61RggU+gU+kITj
 u0C88XRzhjFTnN8ETS78Y+r+4YMkH5gWLoGyVZocm2x7SB5u4O8eWaUgGiI/s+RsoLXb
 y4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868925; x=1788473725;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=;
 b=PsAkOGRG5sZYWJb8EV6/Sb4RG8/rVTdKVBbfL8J7a/Gz3D7V1ddxAoJZ5caLbTnD9K
 zNtLJoT2/xxDXpzktl874kmW2JmxYYYIegQCb0st07XyJ6o2/PIV6IQz6TVf4SLBLa6Z
 6bZZsfRIIW3JlMjhoTqoJRRMvfH8gqFyN3atFh5Kz0BkDOHb0H3Hz0D1hvzIcMirXpR3
 xysORa6/eEWoVwDM/xFQ2rbxP07mBfqE/R72v9Y0Ce/sNC8ezhL5fA21AujQRziuHQUM
 WEQttcnrqdkMMI/d4SoF4Rl1eTPJQjrQ8aXGX2fzxK4IdAbfye2ce2JXUtK4c5BHsBhS
 JmxA==
X-Gm-Message-State: AFuF++lqjTBjK7JbnTlzif5avl8WuQy67SwDVF5q0xLRwq1OBoEpzCWu
 99X1LN9gXmumjPZZw7vFBH6/lSJdWmI7YiESnFHVeGI9JCieXmvyfpU7WfRX54xyb+605OrhWf9
 LecDd2L14gTuXkF2h8K117XNEalBKDXHmq3gCg2FrbHeBeFcOv3uGDIBHp1i9sIFZJA==
X-Gm-Gg: AR+sD11EoGeaye/zodxN/L/jzswzdge6WcAioNcRU8rVNUE+gk+mRjTwv4qU1ISw90V
 BqG+DxFwAPdkAs3M+5Feb9OM9sk5M5BpflhY6KRHelJ/M8We177aFQqBPq56LLeTn/sOnFQYSpQ
 Hi9fmYcpKTU9CzMqW3F1F/DvGPHUllo6Q3vD7cIS4BthNiUCJFT9UshwuhpdAS/wsI9eCqwSRZb
 b8U3TqKKy2QCq5VWnwf7UpYY9AgfWdQO9hHd9ObqDJFep46Uk5/RmbcHxK4JP/nJ5EUk+1VG/5s
 spteR1JUX+Q/z2R0hh5C/ednaJFBLSSkE4I4wuWR4UTzflPAd9374fBENgiOREAfNaJB1qMr+ph
 hWHVI4+TBDFS7x4PJUJg2m7hOZck1RHTUOCIbbewCEDZ3cfg17xHrW60LMJI=
X-Received: by 2002:a05:6a00:909e:b0:848:467d:293b with SMTP id
 d2e1a72fcca58-85629f0a1f8mr4868278b3a.11.1787868924785; 
 Thu, 27 Aug 2026 15:15:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:909e:b0:848:467d:293b with SMTP id
 d2e1a72fcca58-85629f0a1f8mr4868192b3a.11.1787868924391; 
 Thu, 27 Aug 2026 15:15:24 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 013/105] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Thu, 27 Aug 2026 22:13:34 +0000
Message-ID: <20260827221506.91574-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXz76PatoohHGC
 n39PFVDoI3rIieU4jvSZ4eyYfbi35lG7OApCWHsbDqFKORQJKMj8JQQbsmGiK+bucVZZyQYkSNx
 2sY2eJpuqGw9ETxI7kjkTH92qhTXPvTagtOU+UyleuOXBHGDlKjtjKoVxYlBAhVkhOq08iZ3tOF
 lEZM1lF4W7YgkRDwTCa2vMNbKEAWV/1ERj6tjk2Fw1Os1NN4GbNLxe+KJH8Pxv1b+oXuWmYXL/f
 6DSEQ186cgeqciXU2EzTzPcrQKa0//k003deHd5KsLcvR6SvE0tJfwmRsop4Xp/fZMf07kwFZpI
 +/9JPAAPSBeb5vm4jD00yrevgzEFM5iuZ09wcDcXY5vvrD5lfkBK6MNmfqLpSUm4ld35RNnVWOm
 Rxu95EC/LP/x7t+92e3G3mlkdcdZBJ+v08eW+qrHJaWR9oW5R4FUBpfcWnq3pm+fJg4CoMnBlH3
 K9RrYXX18elOH2WL1XQ==
X-Proofpoint-ORIG-GUID: cbZX6wUcCrX2l3EFWBdNG5QJamk5l9ae
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a90b6fd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5uDg+lhR4fsN
 wZIVOmP83UpaPbCJtebHI/8BEiCwgdgU1KN/QwfepdRql6henSgH8gqZrYm6a2o6RwSHEgKaeki
 0iOxLUcm6KeLJJnrypRQM3pb3glsS9I=
X-Proofpoint-GUID: cbZX6wUcCrX2l3EFWBdNG5QJamk5l9ae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
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

A given target can now declare which gdb architecture it requires.
Also, we add the code to check gdb capabilities, and version.
Tests can use gdb_version.version_compare('>=X.Y') to test this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b51750b016..3714fe4dc0d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,5 +1,11 @@
 env = find_program('env')
 
+gdb_progs = ['gdb-multiarch', 'gdb']
+if config_host.has_key('GDB')
+  gdb_progs = [config_host['GDB'], gdb_progs]
+endif
+gdb = find_program(gdb_progs, required: false)
+
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
 #
@@ -7,6 +13,7 @@ tcg_tests = {}
 #   'name_of_target': {
 #     'cc': cross_compiler,
 #     'folder': 'folder_for_test_src_files',
+#     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -34,6 +41,18 @@ tcg_tests = {}
 # declared using 'test_name'.
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
+gdb_arch_supported = {}
+gdb_version = '0'
+if gdb.found()
+  gdb_version = gdb.version()
+  gdb_arch = run_command(python, files('../../scripts/probe-gdb-support.py'),
+                           gdb,
+                           check: true)
+  foreach arch: gdb_arch.stdout().split()
+    gdb_arch_supported += {arch: true}
+  endforeach
+endif
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
@@ -47,7 +66,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'folder', 'qemu', 'tests']
+    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -56,6 +75,7 @@ foreach target, plan: tcg_tests
 
   cc = plan['cc']
   folder = plan['folder']
+  gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
   tests = plan['tests']
 
-- 
2.43.0


