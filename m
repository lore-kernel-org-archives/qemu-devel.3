Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A7FC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNg-00050a-U5; Thu, 27 Aug 2026 18:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNe-0004ym-BI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNc-00063v-Eb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLreM218748
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=; b=dCcbdCr09+re10M2
 ae/f8uFEqLYRp3dfGFubHSLTXUeY4sxbP+rWWNSEIo4igzwbtrq98udDAx+YDMpv
 JJRWSMn97YngvIg3vHTPDiGQVIwsVeeQhdEjeAyaORwDPMqp6oP5Gt9rnDWGsf6F
 1E8tEbZP0nOaR0UgwtjUCqI5QNDVokn0es0+7syD4AfUchxm1O8vYT5LoBodIyjF
 esvAox/jGt2Qul3D3VAlzZmbDQADgQnNowfy4HkQ7x5RCUGf2SdtSaz7Y6xChUq6
 vUK1kmMCD7vzdfHDQCl/wU9m7Rajutf0IAGQ9J2KqJjFvL8AFsx71iobTDyICPnl
 YruBFQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw22ab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:27 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbedb8673ceso427693a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868926; x=1788473726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=;
 b=FnaW6ZNiVbVTXX1jLaXdKq/KqSBFbdukZnDTJcjm5S6lsDYukT5WxPqC/S+yFUMNH/
 ZOzU8PGC+cNB4Qt1aG9eyIz02Gj+FqMZL2jVrcCxhmK1gQaPSFKxjM/+4uIfXfDNwZvF
 fmrbbrS7OhcTKkhijdWSmlYRmid92EuHAIshjw2gwijVhNRBYxTlUsMxc2rqUUvqT8Bv
 +ttcP2C0LlhtFJ7SnANhd+zZ79NDAU59WrafXspksYVl0bcGNlgEcRNX9iUzVPOcJYLy
 dr26yHhQoRJTadQ8Qv6N/U6WKtP7cJUt+FAUqy8EgQXa3poDkbceQqrhWBX544R2j26Z
 kH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868926; x=1788473726;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=;
 b=Hv2sJ/s8vw0DpUmuBVcZr4DCTo6XumFnK9YFkjUVg7Oj8fgiVig9aLdZxHGrICvbBO
 WRqwwqAFhpI3Sl/vPQvfAo1nsdO4BsN9ckq4HXO4f8uFpZ0onORExy0ymzF3wMAp1V/6
 8n9JyzhLdhlrWfsLR39tBkyKASMIzVTvUyVPnsru+KY83xvBcMQE7QH6+7yNl56BsjXR
 g5Uhm0Db24pUjR8rkkPOb7+abZ4fSi2BNrH9dDPNstblGkG4iUzCYwfojPdt/tduc2oO
 onqDQbust8Q/CVA0i1OYaTt+kaWhRgd2yq2yMEqb4bNc1C4CWRk4+wymWs+nE/qbIZZP
 owyA==
X-Gm-Message-State: AFuF++l1EX7B5JZyG31kraxUqmaWPRwRfRRupcOfaZ+H3ayV8ismNJCF
 IxXp6uzzBXK72UHtnlKLI0jPQbbazgJhKUE6tmKjlvE4oiWYcVbqkkmoVrZGINV+JiCANNtJ0uU
 XVQ/NNZJWSw2Yv6q6J6xnlOLNZDc9Ly3MrVxij6L61LHHQjoBW4soxaKoOhGN4qEhpA==
X-Gm-Gg: AR+sD13dpu64V3L67NsVdw10jP2ADPUkB3ICCyLtT7Z20dJbfGkImYJaH+QI38wGCKF
 O9jANiTIZbpGxzc2gD4Q70pkbpje3OROTcyLPGIpVi02ADEjS+WPSUPnMS3JfzpwUH0/Hudl136
 3/QrQmq9PT6mjS+XquADRRDsu2h8rwyWgzpQrR1WkrhSpx7rf8anjO8gJpN9pHMmHVOH6AEGXkU
 x0l9Jqf4i/fdAw2JNOquTBeGMD0IHgzwBrdf71Y3BpPymwYXnCtSlLBN4r1z79pilh0NSvF7R9Q
 vzEp2nL6XDKgmxUJp3/NHEeiZ5/uX9EWmJ2hNNKHvVW/W0UqjEgNpHI25SFXbvehG7P9ok3RmPz
 r6XtDvAHiaCFan7gBECCj2VkjferAP27M6zCye/t2OgFWaIcPaHf3ItTWKp0=
X-Received: by 2002:a05:6a00:4649:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-8562a1f6c2cmr4564418b3a.7.1787868926153; 
 Thu, 27 Aug 2026 15:15:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:4649:b0:84e:f90e:492f with SMTP id
 d2e1a72fcca58-8562a1f6c2cmr4564278b3a.7.1787868925671; 
 Thu, 27 Aug 2026 15:15:25 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:24 -0700 (PDT)
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
Subject: [PATCH v8 014/105] tests/tcg/meson.build: introduce gdb_test
Date: Thu, 27 Aug 2026 22:13:35 +0000
Message-ID: <20260827221506.91574-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dCPHLgKkkawAKCA6pYBiFNtaDIXcdtWI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX/3v0ZDVv3SLS
 iqaMqozGmUM1EB/Scz+/wd73kiPKBF0Aw8jas9Zs0DNSyUQKNLaraXd/EAtP0ggvnf15ozFe9x/
 NoXtbBaRLj+YEy5WOVGSDftj2x1ST2o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX+jwhgZKzWnvv
 erTOcIsGgh7wHWNtIu6A/DHBosagNO7czc6FeEsWAWgzNIrO3kgz3rsuLmmqs4f5vPW+U1EsTmM
 ZjPyEnYW36ktwJzu0Uq3kO5gqJa64G1RfybL1OhXXG6iE27GujBHjD1+njS1Cr0Izdi43ObwGiK
 48cf3rHdAuxjqdxXfc7pHRXizY3EpP7ubZaNmJ26WXcKuya710LceEqQW8hzfxf2gAlWQw9QzQo
 k1+vb8+XczOFZvk0lWI+gxbpEr0nTsrcR3DXsdbo6JHcH/vBT/VIqYdoXxA6mM8HT/qZ/N97TFC
 Sqxr60I2N0ouUsUFGpJSaYcKhYWgGIjqdEHvELHBMGWs6EFlFOXFRVvsvKXiZTdbVe/9QP2Hpng
 EybcryHvoCrF0GvM9LB2I5m8yiNivQBMZcve0GlNu8t97cpGaboufZ6dYU4FpEs+wrFTV54PNDf
 lK/SPBE/pBZt9/ybYVg==
X-Proofpoint-ORIG-GUID: dCPHLgKkkawAKCA6pYBiFNtaDIXcdtWI
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b6ff cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
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


