Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA663C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFm-0007ED-Lj; Thu, 27 Aug 2026 18:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFk-0007DO-Vn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFj-0003F1-BA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM4k7849150
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=; b=f7qEc3o12t2CNp9l
 DNt61+iIjw3knSZrc7sqB9CDS1SXUX2TRWthjJR41SSZxR2GGZAy49mSnKO95VCG
 zAx4w0uByuQ9Q2R8dwdMwsrnuJQIVdL1S3hXWWiakyYCVwS9pVKHfQivym9jSlP5
 dHQf/a4CG7XTM1lgpM+w4tJH8jp39t2U8EooBlbDCPSq7P4BsjIxdz1aRI8Nkuid
 2PUkHpX6OWMoQBTyy5xeiKiYT4neAPtFJyLFeaSdSzL0NTS/Uc++rZrWVB+dnvGB
 7hMLv8d15FWeznEWKYMEHSFCnTnJ+qQ3Nmuo7h2BgAPITGgVToqE6YTKK8AKp/2J
 CtLAaA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a62x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b8088203so255150a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868427; x=1788473227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=;
 b=eL2d2m/aivXprBhrRNTvONdfUYcJv+8hTsWpQxtq3VJJnnDtGpU/HRGnqdxVDscexk
 dsjzRl3jJ+XifWoGIZ41mQiXCk21nM10Q5qGipy66falU65HR4AfDsgs3DpPLPrIgLCH
 zJlQy1KCcaQ8rVF9m/8IDs9DZoKI3Z6DTf+0dQo2m4bYfsYpwo7ufJ2TbuI+X2i4Qw50
 a7g3ut3DNKdfQ3n7uxJZoO9vnOhoBhi5VCYg7WUhZWeALO2LaXIEn9mfOsJxs8muEau1
 eHqmZ+huiTnSaQADXcMDWTeUtTocU8YPJKd32SufkMe/DEq/WFHfDoWV+7wQxtPWcj6l
 w3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868427; x=1788473227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bXITIOf9FxnfEHs5dXe2PRtAVhk5aViOVnDBmrsar2s=;
 b=sLfJ2adADZKaY1iNiB4dBmA0UIbeXkcUWdIPoYHKF4wHkXxGb7xQCfb1Eyt1rZblcM
 Tpky2tkIMBfYlPjTSIqAOiFKyH/Rmtr+LDkXGTTPvE+Hi9T1kRbKr/iQk6I/zOoLWQQT
 f2kckmAmmFwTiInqDPMcqIAkCkhbhsOu1hvWimD9VqToBmqZxf1b44Emxo/EcgpcJfOo
 61+Mv2v9Ro4i2IVsCHpY/A79S9tsN50Y2J8vFy8p/U5NO5Py2CjFfB7SSHewo0ryE7uS
 2DjWsZTBBEWVgkiaRtGYxwOSJRJ/8x7WvXVMBBTJUc8+QZVMQ8WIOwaHX74CjJtHQjsF
 fkOw==
X-Gm-Message-State: AFuF++n+5f8DCZ6cHNcCgdmb6YfuwpaOFWGGLCbBqiRp1po6Vmwlw7AC
 a7E3hvZCPDAl5vlGzicCKMqK5AqvjlVTBAu2MJ/lzo5/5V4wrDyFgaEITFLkuNEvxpEH+q3seH7
 iNlcRmdxgDzYFG5WMNM3aGqVYlSX2HjL5FzTTmx3wirCdw/nljsMmOaFHv3sSYFlrFw==
X-Gm-Gg: AR+sD11EzwksvwqfdNjvXGOvwN8qO4R2BbcCIBMJODTa9H/iN/f7xz8UnRYbQhHtMWT
 18Lcq6sUk5mruaTpBNU7ETt8bPwUvya3psnRfyE8atoraXwqLNubK14LsF55vJyPFIT7BaLR5Kh
 CrXpSw6IEyK9m2j80gaT7i0eYFCPT/6B90SokzZqTYyVtwJinPiMnis85Tfhbc2weJHZQvQ2kEB
 f2dfTjQGn9f5vTqacfYaQWJukaa2vUWHjxwznUe0eJoO1p53awXVf4ICKn3w+6gDEaqZ0s3USl3
 YIZM1xt4DGprUCQrTC/156hguFdYdLleKIyNC9P6PIaqcbPWCAOVVcYFT3MKKbQvlbwcOTktouF
 kStx+3zey31FF/t8AUF99XpevJ+kDEWK/P6LxgECFagan6BLEwQ20XcCHXAo=
X-Received: by 2002:a05:6a00:17a3:b0:842:5b66:3c7f with SMTP id
 d2e1a72fcca58-85625842e10mr4369012b3a.0.1787868427304; 
 Thu, 27 Aug 2026 15:07:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a3:b0:842:5b66:3c7f with SMTP id
 d2e1a72fcca58-85625842e10mr4368936b3a.0.1787868426854; 
 Thu, 27 Aug 2026 15:07:06 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:06 -0700 (PDT)
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
Subject: [PATCH v8 013/105] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Thu, 27 Aug 2026 22:05:07 +0000
Message-ID: <20260827220641.84885-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxCcdTksY5Z84
 8VZ0PPR1xjDyb1e5tGK6IOkon7T1zFMPcdty429frj0iI8KQG/xEAzNtLHh+KBGKpasExBHY4vP
 WHR+uUzeW33AhnBcQPqVzAA35aPDZGR5SwWTObZ3hBK0S/WPMmvbMN0gJzZJfZo9cIbi+Fwq8/a
 bBwi3HeAomFfPakAVbRUj2tCCRLwz6bRTr6lT8A2K1IVkTwfWg8iRXPDGNemr/V2+c22+nE+LrY
 r9wUnzj/x+43uss3QOz6HWNyo0ykVCAOEZFF9LyAhLTMXRnMqrXqEaI2b/N6AK27FFOpBPCboPW
 28fFVBnA6VPoWsNNjpl7Uvel9GCGLJ3a1cjwcGg308S1IVbPA5iDyxRvSipXZDlgwcF15JK0BT1
 6a6+MnNLLgZ75oSLdB2JslVXoTO+eAfCW+a9UbjHajf1WzyR0HSXTHB4Z4W0I1puN5MxUE4W9BK
 wboYT5OSI8OC/LAvkcw==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b50c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xvJFuitT3hD0C7NryKjUHIRF8DZYInls
X-Proofpoint-ORIG-GUID: xvJFuitT3hD0C7NryKjUHIRF8DZYInls
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwchnfeK0i9H4
 k8cQ7ThGhfTBB2JuwiQxDVqfFbZv/3sbRIZnoC/gWgeteXVEY7S36+1e0+5IWTl6Fsjs+cHmFBK
 w57K3q1TBaAOypdF6QrSIe3oWsqiddQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
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


