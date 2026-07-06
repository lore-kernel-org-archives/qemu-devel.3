Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA776C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtY-0002mX-Ei; Mon, 06 Jul 2026 18:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtK-0002jU-7U
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtH-0005XD-VF
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEODO1613950
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=a6/mgN81gRA
 1NC+yUra4GW+I9x+6dVpvk4tHMJHGu7U=; b=KOO2f44rsEjjCuHGulGNRejMi7N
 L03MtydqaYCtptZNT0OmgmHApetYw8M9laVpi01bDHbfHDt0M5Ja3EwfcNzXkVkk
 K7S/oeu5MNHB03knzcoMhvQ/CbZinRBajzdxHKC655fHZxif7JasLnXHCaXMrQZ8
 Ehelu66uDMX8xIln/0Z7JuAPkc2bKVsiOSrXI16uNlqhcHmyTVn6OKDw6ytMvrKX
 MZQI+KYZvHUzwHiXCIgmX9oVYfPk3so7aHpjUz2acRK3sFJjIhqmtAQ4fZ39zm2j
 vS0avmPcQbGo5RhffwDPycABifkFPoFGObXcZmWFNcPEDuEyLXN7z9ENr1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53jrq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37e24235ce1so5213327a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377253; x=1783982053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a6/mgN81gRA1NC+yUra4GW+I9x+6dVpvk4tHMJHGu7U=;
 b=AKIk4thEwZjBW5YL+3wVd/YHmTAadVnZw7UMsgiSW3T75KxhozwTSDG0HVabaZDQZE
 OCbWEuAVW5RI556PL9pElYJGsQzdu6aZ0sEdT7iba56OIZ+5On6SZTyXM0WAs7+hFD0/
 Tt2/UtM5436KT8yDscHTDL2d5PM8Z8vWwYv6dku/v+4lDTiY5SmFFt76MQ+UQtHUNEce
 vNsUXqeXwu0gsdgT/5daGrCbkfxG8CJDtzv4z2YqtEIVPlObyBm7Nv98SxFuPXkB2Ca2
 KUGSjibz+xaRPw1VET768HaAvrEmVi87YtwHNFOdV4BgVzJl7sFmvnWc8n0NKKf51fxp
 iNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377253; x=1783982053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a6/mgN81gRA1NC+yUra4GW+I9x+6dVpvk4tHMJHGu7U=;
 b=XFzkf44AQXoJzs/c+abSFyz5NrkYAPiUEg/zvNUVnxJUUnf8cOA8pqH5C5iKfk1pIY
 MrI5/jCoSiYLKp0rMfWmdAIWD0kGKAX2wKUH67apJ0lrOISUPhtMLp5Yz7vEdkLhDvGR
 7r1p1EI/XrkQPo4S89BIsQ3pGzPN7w8YSXe4xfV53XqDlFelW6UtjcR2blO+ktWE2yKm
 bwnmwj+xoPPOqH8/OGA+1GfCEvsZbTF6dm1RsVOgTLxZLxFrf82XKtV5TWzWT/w6y+QH
 kAQgYSyhXVB0hiXO0nXfrge0BIMT/aljYh+FsZpjJoMg5CcxR66rRy+Q0S36EUrfcU9X
 47ig==
X-Gm-Message-State: AOJu0Yyh2vPImgHB2Ujm9x+cRH7IrakYwXloMqR6Ae1/Z1fdWVGtk5o1
 CkdjFa7R7onD1qf3fGJUYDXjO1QfPAARLekgm6/7Td4q7tNgQqhTSX9etF+ArJmRDh53Hv8v17w
 R+Az6bq3nA5HLceLQWyl/z/P4VkDKWpymAUx3hmb23ZsKQj3EKReDUjmQY9S5hUyWhw==
X-Gm-Gg: AfdE7cm2K6jGgstE0snChlUoJvQjgtx5Dx6X+bzhb3CRWkL42jv+wh1xoBdYxUe0buN
 CrVJaywMSZYh3JNeULzx6Ruxq1SjZBz3VZxq/PEDYmvtvwzppLXv9X/UaLatm89EEnqrSr2vYFX
 VwAF3hjysB5DVaP9Uz6m1b4ECBd047bASohwO0S9hsjAO2gQgiIW+bk68GyIkplqlgbNSVi6ML1
 P5VR3acz/9T8AqyuIIVzS5XBlRKqaSCi43geFHFLcahyhs7Dt0br5q5OxgtNMxvDNRA85DeAEUH
 3/CqyrtDdOYBV1o9eornqkPJi08OTmLdbxYNJyYDuIpYnBwNrh3Hvx7yLU2txiHSxZft5iyvUEQ
 KGS/kEEhOn2gy8l7O5m4t0KhxXIBF6ZW3ECKfoQBxf4fGHAB/eNZWxT/QWBZUIpYjEOovpKwPkP
 aGHqRv9Q==
X-Received: by 2002:a17:90b:52c4:b0:37f:ac93:df8b with SMTP id
 98e67ed59e1d1-38756dd9816mr2794741a91.9.1783377253050; 
 Mon, 06 Jul 2026 15:34:13 -0700 (PDT)
X-Received: by 2002:a17:90b:52c4:b0:37f:ac93:df8b with SMTP id
 98e67ed59e1d1-38756dd9816mr2794708a91.9.1783377252606; 
 Mon, 06 Jul 2026 15:34:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:12 -0700 (PDT)
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
Subject: [PATCH v3 13/91] tests/tcg/meson.build: introduce gdb_test
Date: Mon,  6 Jul 2026 15:32:25 -0700
Message-ID: <20260706223343.988769-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0QxPMU9D8ZIcrwbMBSM7HGAN3DjHOEDB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX0HF850laCgJc
 8rtIdFxce2dKTFQkgHBTwgMYYN2JEODcEt4Rf6PDMCaqpgC6HK2/Jm1XeUvMD6eiJ/EOLFDFume
 uoPrhG01rn9t35RQgbHc5KJNyK7wxk0=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2d65 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=ZkoTrUv0hqWFqrPu6skA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX8CtJobPf0nDQ
 NItN6YESzCQYgbNE4l0RQP1GX7jL1YN++WK0TF4VrvghQ+5q5rPBzgLeEbgWQrLkklCuP6zEZrj
 OWayfvwWsxjSZsGlsd7jurI8rtdAq79pvl1ED6W5vmgOq2h93W8QhFNF2oEsKAZ5ZEUQfHEXqNu
 vJe6cinFLkrxPAFWit/fuwvwiNkqPZKhcS5ohblwTKxeKgm+CzwNpc6KxEl36VsK3ZbSN8sAP9E
 KtxZqx+YWhrYgh9X8RYkxXor0UulaXqBbK0bZVJf3kUUay66nNuIP0QT3X83V+I5VT+onAGhoFD
 q8Z0WEhH8lEjTv8/Fd4dBzJjaA6QiiYQ8ZYaW8bFhtvH2fL8aThP5HUq0u5XIe1shzX9f9sG21p
 aqxq+tXtyfXYcTDkSsl4b+T7EHOOKIBaNg0kDPJGahxqA+vGpLA7uojrYuucqRfZvs42Q7zC9dN
 M/1dENV7KqWZ6qq1iGA==
X-Proofpoint-ORIG-GUID: 0QxPMU9D8ZIcrwbMBSM7HGAN3DjHOEDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b1655f5200b..7b439ee027b 100644
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
2.47.3


