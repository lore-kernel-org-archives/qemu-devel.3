Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3CFC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bp-0001Eb-GM; Fri, 10 Jul 2026 02:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bZ-00018B-5g
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bW-0004au-F8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nCbv3752746
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 le1+j5H1bJ8hudacW/Xs4BlGT2BcPOmn5A7j0TMV7w0=; b=bWCt6flhWPIlvHg4
 ykHGBh6zKGiTLbQfrAN6fX+PYn7muLaUxoiEjAksBUG4siny7ux/B44QwDUY4cNM
 97q5aDeD9RwOwtZm7+AesCzPvwRHBzzrwMziSZulqx6OszRaagYRAhM0fR2RPhKT
 vUexiS0hJRYXFWWl7bYcYOLc3GXgfwhYJ96WAterTh10qW8wHXrPegZbIep6MO9w
 L7IYR4JfPggwiYAKBBReqZVKPzdig09y2Ukg5OSAYU2eoiOku49dSZTutVPAC641
 tZ6McTJUT9oWGawZd26Yfdo4oFTQNze57ccrBquG2XQFO8v0oGrFtUWcnEBoDahz
 LX9+Iw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjb9k6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c890bac374eso1048311a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664451; x=1784269251; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=le1+j5H1bJ8hudacW/Xs4BlGT2BcPOmn5A7j0TMV7w0=;
 b=OlpDAijfGg1AKLl9d0HAl/K8U+GN8Q+tcfWiywsop4dQl99IM6UloAAG0D78w0BOTb
 r1o3zWtthNhk/g6aSjzFYk1I8zYMcNXXtVBdp5W+sehSiiSRdZ9FY357oWCUsKXZQVgT
 zTtQ5/y+urfvtigkU3wKEEQT7SR4rVyBeOrTyRunTItptd12Sf6lmUxW0fkA7rLs2BOb
 MCRZVO1QYQfBc8+YZ9lHmpWE6Gfr9Rd0WFLvzBti90dy+BCJPlvLjZh3BqCpWk1TV06c
 PYmbOGjyEF70wLfvGxGDv4ElUeOxda4xMnzALXRt1LxCQFz46K7DPIjeEe0zj+UQGErp
 Kk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664451; x=1784269251;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=le1+j5H1bJ8hudacW/Xs4BlGT2BcPOmn5A7j0TMV7w0=;
 b=s/chc1sPOlHTnn21ijAFE/UBeh8o5lOcuEPTg8vdNKXQSRjGBbhcgLQ1IdObDYp9th
 R5KGbiQqc1K+2FQ/iIO9xiXbcDfPuZTG2c8HS9DaBMmwnboAYO5qOz5yBD4ojNMHuz/Q
 AqatkufVBAqxKZLb1s+3gVVYPnFL24wek9NSS6Cpq0Sj8slvCZjKz7flz7G6WXTKnVQ9
 J8+iW99dCFDxSRHBeWEmMUNx1yQYhuuODQAK5VdIDYdQ7Exu/Nd0tK7GyobaEoZmIORb
 Vo3GV1GIiowNL1WFY3n6SUtgBihQeT9BgrAQrZyvyowdmo0dNDLZS3BhltPXtpZlxyqZ
 vJZg==
X-Gm-Message-State: AOJu0YwHRzDsGUN54g3ZTaZOHyrwnqaqc87suQGO5QAhFcanysOt+gTe
 bdPehw57VlAP89bRh9bSQtYMML6pwJBBABZN/dSFjE2IC467LdZpbUDJ+zA3YIZDm/Gmq2m0KsQ
 cLMnn0FFFu9V6Ivjgq/LczYanOwI6AOIgZx/WgZLCaaRLqboRbMZ1QlwE8iQ1fwdyRg==
X-Gm-Gg: AfdE7cmoK1BguyDF6pdJEz5Va9I4/kZ4Xg5arMWa/c3AY/DW63aR+9Z08+bJ5F4advL
 IJHHlvosue1KAtrQTA0gSUaJz34nE7kVXXDUP6HNApI35jZXXvVrU8+G/QZ4olNGqbt9MP2Xw4G
 UcPqptB/fh4LwR3aZ9i7B0DP07OTy5BuNizof2rRwIFKcxKwlfj+Ea7NZ56CblHENr4RQXpTc3a
 wKRihu/whwcDmmceQ/FQrbhq7VTELJKFzxqWy/WId+JV8/Mbz2sWY6W5fCmdZ1BfNFY5oOoTQ2N
 lzJjrISNcjspOlKaN8Q4nTNqRD0e+NI6aqgjyf8HAcIYpjKUDvTcPPMC5VuItI9SQdzcEot8JCN
 qR1117B1aY6ATtsueXcICHprnuxv39zEo3FTPQoebGt4OHy8NmFamJ1MzOHxx/i37n0U5XuAgxv
 RK4taX9w==
X-Received: by 2002:a05:6a20:918e:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c0bcbc54b1mr13047492637.48.1783664450981; 
 Thu, 09 Jul 2026 23:20:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:918e:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c0bcbc54b1mr13047465637.48.1783664450470; 
 Thu, 09 Jul 2026 23:20:50 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:49 -0700 (PDT)
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
Subject: [PATCH v4 13/97] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Thu,  9 Jul 2026 23:18:51 -0700
Message-ID: <20260710062016.1818125-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX15ZGi9HL3PD4
 fefoDjFkd44HUVnkqpaBuchpObjZsN92nCVHuVHG1YBIfwhlsN9XhyZUgiRXvk6lH+orRykhCnv
 gE4Y47mfWtgH5QTRxCKDEIF6acZaqwHxsP/8YodmmdGBmWzNbKvFl2gFu+1cXWqFmjRYF2QSsLb
 jyYPWNRpXStn+bg9sru+ER1cqOD3Rjw96OGXr/fXGOwbTToqxN1rja3CKSajckP7orMByEyb8Rx
 YaNkELiIrrqbTGuzXL3eZuWRXfYyeWY+NuTLb5WiOGgC2uTx9uVY6N4jNucspots1CwLmJ50lIY
 /9wPsZhfNOLDPwZamvmy9LnqEB/6Q2C7cjtZ3Cpszqs+BAKJzP7cq3vjLogN5+SQ994AywahkaE
 cFdaHGGqNyeGwolb8eHo6PPcomh7oscACoWIMTDNiyzQHhrWE1FrEp5BsZ2zo/MPTZ9ValSReKq
 OGOQ9dN4vgWp7FLYBWA==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a508f43 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7daLop4WeeZQusPs6K36G8MgzSMHpEVt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX8mlYEk6Tjinz
 ryXtYg9NdtMDCCBwwSX+iOUUK/UaTECXL5elRyUnHF3IuGWIdtEM6re+4935cAmhnxlW+4Obq9Q
 ne08lz1kvHMB3pNN2lluniMOR8oUyKA=
X-Proofpoint-ORIG-GUID: 7daLop4WeeZQusPs6K36G8MgzSMHpEVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100058
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
index 9b29669977f..b1655f5200b 100644
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


