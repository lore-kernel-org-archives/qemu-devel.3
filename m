Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F6FC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPf-0006hf-PB; Tue, 18 Aug 2026 15:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPd-0006gK-AT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPb-0006cp-LS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGr1U1006260
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=; b=NJkRm4HqNF+my5Ms
 fZMMdKmRIRg9qllZTESRkUop9Hr4jpdD7Uwlu+YUoE5r72LzqWkTqFU5WGLH9wfI
 SQp18IBx/MfIjmLEh/yfjXteLXqRwifvbkMzQecSoRZWqkXWhZnNNEyEBbDC0b55
 ppxN3gU54L9oPcWvbZ2IN1tG7oiEhoaJceAc8agPsK/zcZn2Qqbdtf6BoDVH+6tn
 8rfJcLuiDT5uy8fBHkxvbLb7qxuV78OF+VhwmFBRKp51AnjMwb0zaf/vAT2/uAD0
 ZkSi/jeLMydgAJ8DUjiVpYo/wSx6tatHq1HhZDmMct6yMDrAqoDnHM4ws1ViSC38
 hW7Mog==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4tkmrv5y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cd01a14e81so2350185ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081019; x=1787685819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=;
 b=FQYkNxJtk/hmhWpTp5REY0ZUyPD2mMzM2uwwPQqYIwxMzR5fX7MZlyQ5UZryGO+Ejs
 W2acAHU5OaMNQAYnPeYOPCnpQ58Z+FVEzyrJ6vqKZkL0wiU1y14j37rWYSTaTChSmC7w
 IP90gWwsGIJcW8wpBO0t3ydrIpUxtPwmnY03wV7+sALPrPWwaBF2mM640+kIOZfuDLnI
 omqQ3c284OtfOhDEQ3zMhFW6dTI3gKDw7JN5Isl4gFfa6rbBOg2kDhfelgHvc7/tV3ox
 oK9guoPMW8CyBCVWUxQ/nkFZQsPBwBDhNq352URZ6H2ha00Cn0zSdtOMnBxN4BrhH/Gt
 HQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081019; x=1787685819;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTW13/fhDKJTuv3hBwmA2Kvox/3Erlxkx4OQ7LDKgwM=;
 b=F8Bl3YYuKm2VvfGK9F//zb1Fiz3YRMpWAM1lkzfKRbXan8y7UUeOX5rZ7uGcJ66n1V
 S30ZgOndvHvDVCPCDxvhBSULIyWbsN2KcscGDOAxEb7+4Qby/JAEjcxP1Et2WtIXlEkK
 8c7yFlB62juTIF2vylH6gsfDgCWKPa+pbPSagq2gZogJLnYv9uw/2aJ65Gd7mTTNMjms
 6e9Zj8H7gBRY0mnPtRW5w/fp3fUqKjs/Y7wESvoiOid3melgYi5f40WmpPJIUm3jzTqp
 +NdWm9UINfiTpTcbH9AKeIqwyjv98Lm3FOR7dsBx3vj2JAp6zkVoS/sTJjoh3cQqz/Yk
 WwTA==
X-Gm-Message-State: AOJu0YzSGqbcN0AxKN8u/C/vTGUnhJNvsKlcrUrCw63ATRTMr1myGMiU
 P3//PsX+tIvlsTS7ptTZoiAWun3/OXspE5k8MScdK2YfUJ2vdZpmw5INiAfixpSVdr2InPnW+yE
 OuKDKV4+8Hw2iZWTDyJBvNJNvUUC+7RWuN+CP6joP+ack0bV+aRuQ7jKywFdqHmL2sg==
X-Gm-Gg: AR+sD11OSjxkjLehxtZXuynwE2quYXR/guccli9aQ/U6gMbsXQwhNDwQ447zfT9ixTJ
 AeCrkwsrT5Ey4myBOZPAskKNsU9w8NYpLD8MXY8Zhuv57yWsja/Lp9R4lZiJxTD1PJacDdVtmO/
 0NZCfdwIGqZwO1ER3Vona9EIkgU7WAh6kRq43dDby9NYlMIGT7o0V6CQdAw4LzzQdXZqobToB9T
 SIInIq4Ci19HCcwWBiKhYvTWftiKZqmUI49XT5oPloHJMlu0TmaiYsZjIaGQiv3KaNBNE6R7ojB
 pEXPCiu1ktfkCAJNQMAOCA9jb1GXN522Ol2IgSGJWLfKGQplZESGyT3qzuPsPGsZiwTxWWRejet
 dv2tlzL/kSfTvTXqTWOyZLm1oQiVVFdCucSPIJypuYTSNRZ4iOGpgFO8vEc0=
X-Received: by 2002:a17:90b:3bd0:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-3957b2001c8mr107803a91.3.1787081018897; 
 Tue, 18 Aug 2026 12:23:38 -0700 (PDT)
X-Received: by 2002:a17:90b:3bd0:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-3957b2001c8mr107714a91.3.1787081018336; 
 Tue, 18 Aug 2026 12:23:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 014/104] tests/tcg/meson.build: introduce gdb_test
Date: Tue, 18 Aug 2026 19:21:38 +0000
Message-ID: <20260818192309.22169-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXx3Uk5MHpIWLW
 mIZOVOIww3uusnUVkSqWdyR76rf/Im/VjSrUywGjGcfXub2ss94cZw0mhA32rY7xSYq96xfa03g
 XjOzihKSfk+ckat7Hz0VPKS5r/3O7ZeMv2K5KCtY7JYm0+KKpLZtpYU3fhPfMs3zcSDqnoSCRrZ
 dwDqktcFgc40xChm9RlbTC3wrOHIi9w1UEHx2nv//ZdeWlNnd6gUfA48h7pj/l9Cw2qLyvzs2RF
 yvVKNxw26QcUNoENsChUTt+a0BXvv9nZbkDVbHCc6u2BZkS2fO6pN4Ub00Cv4+/Wv+ctyup6p9z
 FN5oSBUH/zQoqH0T72m+2Ckrlsc9R7SBdsdTSx/b43fs/6RJYtuvfhfkv30AChkXTdJZs9ZX5No
 EmztjbSgVOnxw0Upl+d0ORKzYdKtUXFvwazqhudoeHvrn6ijOpcv5QHWlULpuxz+QNKyvV79PSz
 htJGK5a9sxVBotzN+Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX4UMQqtGw7GVE
 JvOfouJLV8pm7cx7M8iDdNNtQsMsSjAr/fQoJq/5SH6BxEwGY3c0439EZwiiThZqzQ+nRSiAutq
 fpiMsH4Bl/+BGUXgPEVcTmMHyKJhEUs=
X-Proofpoint-GUID: FND42o62E1qirtFdnDY_IZVv5_mVsLPM
X-Proofpoint-ORIG-GUID: FND42o62E1qirtFdnDY_IZVv5_mVsLPM
X-Authority-Analysis: v=2.4 cv=R+Mz39RX c=1 sm=1 tr=0 ts=6a84b13c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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


