Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C99DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1R-0004wO-0g; Fri, 10 Jul 2026 17:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1P-0004vz-JW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1O-0003S9-0j
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKslDt1948064
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dKpwp5oBkJ/y8AJ3LGje1zJDIDU0n3NEAYgUvWg2iAo=; b=k4XjX/PWjIrpKcIq
 2ISlGRw8wfP+c5xPDTXQ+Og9/wJY2tkfH62nfOqI7NVUAvzYzMAD4VsVK2AUjD5Z
 fCcdXIEH6lpEBUaZ8fStg5rFOdTGwk/fil9KFyR5XjLjDukdp6sNAzWg9bTAAvqK
 pHNIONrwC+XfQj0/NwhUTLvHO7itQ3u4fcyQ1yyuok8aBJg23ZwVC0i9cjQplK+A
 AoScAwt2VpmhOjqytQ+J5iLTubF8HTT+kMu6St1ahrXuB6a1kyZ59yhcSa0I2HK9
 cbwOhCgJ4a3Vcg4QaasMQl0r+4l619YyBJThNRqe2Q0pSPrqGxnh5F+Gne7wurxM
 cIDj8A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86eg44y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:22 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso340748a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719862; x=1784324662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dKpwp5oBkJ/y8AJ3LGje1zJDIDU0n3NEAYgUvWg2iAo=;
 b=Onurr6DCpBDTHz61r9ejyBHgzG4jv9PONk+pXFF0xeipHij2xLA6klJx6SwJV7rzIo
 XfcH3re4OYjP0trNfzV5XGQFyWCqnobgFzetuiJwH4ozULx7P4AnrqnRly6v66mfBJal
 6U6AC7Rw34TN/NcaYGRuM0qqkQTeUPhdTZpdVkHO8+hxSYJjhBcSEEHQohwEMyyLRr9j
 UyWcv9Lc+5tAhRF7kHj/bmVxsVY9b4qbHNzDu+VhB55rn6776cGl18iwylcm4NMCBmIj
 IN69r0rs9mSXohyA+ueCfNnczruVSuTEBfwc0D7hadlRgc49XP6f7xYYwB/RuiW3mhmC
 KQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719862; x=1784324662;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dKpwp5oBkJ/y8AJ3LGje1zJDIDU0n3NEAYgUvWg2iAo=;
 b=asXc4nWexigeIk3v1UVVL8b9r7f5ltMQYZZ6FTQUs8j01PxcdI/GZLbJ6ZXBbJDUja
 zUHBVO6RMH9nwzBqVwUrAl6EYDPA5V/WlcXbHuAeKoYGR51ghlhfRkGESNieZZ2v2lAV
 kAaTXBO7EX41uI+MHoGuntUPiBDpA9BYY2SptvW7l23csq3YNXM2K7YM2E6PdSg/t+Jl
 ACxcDzWCA+DfrRbNBMy/aLpby08QWSvgV+hJm8k2SGlcyiorqHderk/uG7e6CqOorgp+
 o2+DGUNfKceBybkCHvH7Jg6MBslrEub9rEXZ+c0jZe6B/dPJk95ri023mRVbYQ/fqc8a
 wY6g==
X-Gm-Message-State: AOJu0YzBgwqkqGgdzE+kd0UB0Kuh6PCUw2y+sN0h1+WIVrIF8Nb8rLho
 uwZCnNPdOmVegstZgq3lR5CHIwHLSrijuRpO7sXTleZn9EXoheanDfEa+nkHysWK2Wt/I4sS9nh
 cqtYNhRp2e9VIt/le+4xxuQebj7IxuRNRS8Fn98ZDmkRXX2gyPce8VpgiQLQ6scy70A==
X-Gm-Gg: AfdE7cmSzTYfQZ8K7z5bVp73NmjM/YuxaurJXCsuN6UmzZsLVwBCvsWG6+uz56eRxnV
 MgauIUi2HCim9y2bN5idD5vB8Uh+xGhe4IjxZIe/Av2Dr+0IjGPyqohLgZl4M33dh3y9EyvJohx
 Ywuq1Zkt2kWt6uvWqiC6jLzVzl+teQmA9oHkLNwpfaRA5Ws+dgnYGZVjLLJUJDI6VcuW7CxrKzK
 PupfX6AjNSc6cw1BAnMO2yZ5px5CyML0yJ0WwQWLSmFazu/JBzQF3VMXKYbt2CwbbJe3oHWq5wq
 EE9dm6qzVoPW1bBXINO55NoNbKmC22S/nTk95RwCAlqiQKHjlfS1eAzjePBLVabBGlTnvP+b5sB
 hoz2Z+zwaxGZeCMDoTy07gt/eXu/Mzxlq4Bj8Mj7J33Bt7h2PNXn3kfSRTic/2x4cR4dgW4X+O6
 qRg2AQ2g==
X-Received: by 2002:a05:6a21:2d44:b0:3b5:6b5a:4f29 with SMTP id
 adf61e73a8af0-3c1102a1727mr630815637.30.1783719861876; 
 Fri, 10 Jul 2026 14:44:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d44:b0:3b5:6b5a:4f29 with SMTP id
 adf61e73a8af0-3c1102a1727mr630798637.30.1783719861467; 
 Fri, 10 Jul 2026 14:44:21 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 13/98] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Fri, 10 Jul 2026 14:42:17 -0700
Message-ID: <20260710214343.2065491-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX3Jy7r5wMYmh9
 3ouPI587Qig2MQ/tLsu3O6PX7JZUiQTj8gzkMPWx7IVmlTuvmXflyFIUX8XdgwBrQVDUUrcZS0C
 3soukDjMPlaRdbXdwZeNNQMFqprt8kEcSxltndnD+nzmnI53Z+Ykbikn0sFBW8LDYNHFIX18ssv
 7yACOYZC8/ThC8pgTMSPdATvTuSZDUb05ZRrudk4tLMkQ2pgmXctY9qRbSDVMdE6fwaMcawzS4A
 LjvQFZ6JZR2qMzP84Nrzk0L4hhsdQDeJUKCjWd2EPYced6TkBB3CZkH8ngCOWi1eiIjbwZEfBen
 hAJvsWuXEsn03t0vHIsmROjkKdYu33MQlueXiY9uIviENovnitouIFE6K7TiWK4OMu/uaeJi2G7
 tX6l5VAnLY4Sd3kPoL13XCfS4GdizWIFnJsr6IANkm0S3Z/8vYAyPFvaYHD1PF3HZ8SvJ7VD17/
 O641IRoJJy7szy8AgOw==
X-Proofpoint-ORIG-GUID: nuaInn9vDcuceKg8IPT_tkoJD-7qOOLn
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a5167b6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX7bC6P2GdhQcZ
 WYGZOfi3YkEP6Ja0FkPQUSJ2Kq2eAeKB3WY63Z7O1Dc379RKlDDE6pHzqviRChswzrla1UR4AWi
 h4tLKIZ2Ug2bF2lr65bFdQ7qHcvci1U=
X-Proofpoint-GUID: nuaInn9vDcuceKg8IPT_tkoJD-7qOOLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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

A given target can now declare which gdb architecture it requires.
Also, we add the code to check gdb capabilities, and version.
Tests can use gdb_version.version_compare('>=X.Y') to test this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


