Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D91DC5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPc-0006g8-Mk; Tue, 18 Aug 2026 15:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPb-0006fa-Id
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPZ-0006cf-U2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHHA633003400
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=; b=VrODQOA4GCYzRIte
 nkhKYq/75ZKPm/r1Ztnz1rymdLLi3XVKHa2oQWQ0N0GP18Nk0vw1mQg5jVPy3yEn
 HTMVPsUq6LlBOk0s/L+CqhbAFmrATxvZs35JehL4RI6Sz9DqD99FzIanPxVjRxmV
 3l1MTFRidm3llyrf8hayspI+1iJU1mqdIFitz9O1rSdRyxUtbysoE/d9BGE5gF/O
 aWc/13YzmZlLG/MySTKio9a5f6zI3tjxb+HqnQM1/dE6OaYm/Grc+rNlI5vpTtxg
 GbhnDYALxz/cAMS/VPVqFy3IQg8tXXmlyiA1jzB1dsCjVhbm5GdmAlDpp/07v6bY
 AvcGqw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv3cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-395543dc382so319197a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081017; x=1787685817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=;
 b=VLGtEYZbWk6lcJAOCmf3ApVVDe/lC5H/r2ixiGXwvuv38bEixWcyTpatz/IDH5/QVa
 4vodjBXTesCoMU9pA6nMhejFoLyunf7ww9n1HZvSAlAmS0YJUwuINbdfmVvnK9qwsXBy
 MZlX1KnFtz9H+rwcM8E1viH2i2X7EX60vQknHs8BbMcgyDTy1phbgh2v/dHkZG4zq1d2
 zjFMoto/Svjojk/hOXhrxohdkI+145cOdbBdn9aJIkeOgCYYfuny+AxIxY+fHxQebbE/
 Bw9UanhalHjHxVgrawA5mQyUlu8EMQI86QIlwS8i/bqzyy7dScTrz1NR5OKer+4D9PIv
 2qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081017; x=1787685817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=;
 b=nVfp7Vdp2CKnmFky9iZLSXX7ZrAeTJTYia79eR0J1mRhzvOdVX7dkRQg//nRVi5BO1
 cTCPHKvFo+Vj0fd2jhcYIvISAns9in+JMvXvNPUc5NihxSxIniNFyfB5dY1JauhIAFv7
 SnmPQMB0onfL52/Pwp+HSgnKNVb6zlXGIfw4+GTwjie33NrUxxNdLmhURabgyZD63Ouw
 C+roOmG0Gc5eyfCsTZdn67uA5o4xGHznddHQNgMtfJxNKi0Gxgl1CbF6VZgNyUDzIYXn
 xquklI8vGEJ0w0lxxswlq1fPaox14NFP5U7M3hbqGe8H5a7ZESzh2s2VN1QgH/TvzPy6
 HrmQ==
X-Gm-Message-State: AOJu0YyHOGT464AmLq/LDwl1p4DVOHn1ASkhhDJtzdmX9JHKYJ3IFhNl
 hhQUQ0hjF/TEfn151MACPWoUE+tAfm4AR0Xv7Sxi96vszNok4MtLe7AFZ8D/H1ZUuvTznADd/zL
 QhqxuSz0ZfYcJCz8lc/tkinqoUQNlxTLV+D4qJsBcr7OV6yzImh1tdMeZDAEYvF3sXw==
X-Gm-Gg: AR+sD102Y0P06cdw2gE5MhMisbHO+LPIty2hRDmez4BzK4wRlQQWcduZ3L1ILX1WQfM
 y7pKKIY8+xnmJeHsq7N+Cprfetg46OZxAed6hgGNywzIfhEnVCcoV94w5muaBHwpHiaP0wAhJVv
 /j1UwSAUJlDMkwXC2z+sFEQnp9cJ5LEJpn8p3U53g6QoeJJtiqjWmxDENmKfXKTfmKeGz7cAXZZ
 PPemIZu1AshKzHvTYk8eaIVKIhtkbqIDiK4UH8N50PQJ54VE7hMd0/561uZ2UlPYvWsGxu6GFy0
 Q+tqfF/S/AYqjCdedeI/WriD7w1R6t8LvmLMsgAwIxzkaP/EmM5wzR75w9JDjqIaP8PZdEX1KSG
 +4okcPHPnFNhzyjNzBD8xXd+TveMNT3zHmgUQrmsToy0v7cD+E5AKY8BPFO4=
X-Received: by 2002:a17:90b:4b84:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-3957b296e31mr64517a91.1.1787081017496; 
 Tue, 18 Aug 2026 12:23:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4b84:b0:38d:f5bb:e0f4 with SMTP id
 98e67ed59e1d1-3957b296e31mr64428a91.1.1787081017020; 
 Tue, 18 Aug 2026 12:23:37 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:36 -0700 (PDT)
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
Subject: [PATCH v7 013/104] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Tue, 18 Aug 2026 19:21:37 +0000
Message-ID: <20260818192309.22169-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxTFNIC3tf7jZ
 rkvAbtvtcv198fQnsWNFmXM1qrmPJWhDRhSgSbSQ2iAN6HAwyBqgL+aKIOhgTnY4rSY7D411NGq
 qpcvsd4iiNcy0emBfdGBCRmVb0tyqQxjrY5VAcnkxuRBEWgQfAenbf2go/iG/6LAVpH2M2k6XZq
 RUxFUaXNzDdaZVBvtXpaxWgUfxKe4IXEvlZtPI7A73d9nCvArfVieZ9zu8Nm31w1O3xTAoPhkUY
 XdHgsbtlwzDQsIXpm7XIQgT4UjBJwDtPDPUKvYqfsep5qbiMIozLIxNJ6fvP++703dRSEhUCApU
 3ZjBiV80GqckCafEqETzPZxTaNemtoIoVRzGYDIQQl8srJe0CZRsGusYfSEfHKnSI/sH9hG+gTy
 V8cK7vUVe6xDzjBPtLbOu/3mCYxA6KVTgTinZJ7AhsA6id0eTs67+DLsElf2zNidO1Etkzygt5O
 WOONJR0PmUTBris8kyw==
X-Proofpoint-GUID: hdhs_hoIgWzEAEXfZKCR6NWvjiCdr2yG
X-Proofpoint-ORIG-GUID: hdhs_hoIgWzEAEXfZKCR6NWvjiCdr2yG
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84b13a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/X7mM81uP8Q1
 vQYc8rgMeir3YPfFx+Na0F8dLVOX41RChOh/VmoCOmSb8ASnV/Nq9hyhXa6hs8afItTj0uL9B6v
 6Piiw4rpgbpemttoz1AOIi+RdHjMbjA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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


