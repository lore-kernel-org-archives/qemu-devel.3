Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78BDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9r-0004ur-9C; Fri, 26 Jun 2026 19:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9p-0004kb-2b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9l-0004Mj-QG
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:24 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxNN3796349
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wKQeEotw9R8
 U9zmYAVhh/2XrHru3vAtf8h1EgETCxFA=; b=JCKU0DnArUq8Do9n/1zQlYNXgkf
 dH3rePjbLMoWl/legBkkwC6PoHqSaak2d+i7Y9RXQWZSoLw4n65SdLfIEYbpVSKG
 ODyx9ooIauw02+LL0L5v83UZ9rVhZ2HKJWPg1jUuwmQlQ2WDNL1fUEJAGXY3yVAx
 xeW2S9WfVs41pIroCMXeJCll1AhSM58UEymmcNvc4/PaV+N2Ik75m1EhgYIaaEpv
 1MFIaaerB3Q91Nllhv1KpmcqsDfIHXrJOmJ1VSOggZzKKtwBEHD4wZd/i/jsg9GZ
 oVnKiu/DVX9mhVEIE3PQzl+GrWAEXK8J23AcxFroFsZbbQWAZtK7vdW002w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ups9kmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c9bd8b9c7so1587047eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517210; x=1783122010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKQeEotw9R8U9zmYAVhh/2XrHru3vAtf8h1EgETCxFA=;
 b=kVjLWTtaa/jxOrlTmBPTsTZBzoUHsS5+49Wvcz2Jc1nQjNe56w8pled6NZehdvP7uq
 AkbcJ3iNyiu27px+rtpqTBbfagt5FVKvhsIkxDLD5QWEW0NZ+1OzM+Bofo7UKtvgih5U
 qOZV7YRsg6kBYnnkuYb5u1NgBm/EIBNyuq3JT3B2rcg4RZkqfPxsTihbDRxgdUVhNJOC
 D+nNySRugbfEw+4+0+oiTIGqV78CxCdL5qwD/6OpGV2/f0Zfsoy+pwKpsVrw1sHxilxA
 xo5ft/oE21JDDsRwBNpkDHqoUlRoKCqctNtEXxzFl51y+vH6ifbKPHE40MwB9FvHn1Ss
 jPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517210; x=1783122010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wKQeEotw9R8U9zmYAVhh/2XrHru3vAtf8h1EgETCxFA=;
 b=H3ry734o2vHnK8uayXvhfFOy+rMuTxRC86vBYgmVpv4fMLm89kJ/zssgbezdrTcz8q
 jdvR0FWCCCOKv7brfGfEv/5vSDZV6QUlCoRO724eLA4Ld040v9xnClOlQIZcwAYsgG0a
 pXqUxev+t8bAuwH2crqbzP291oMZF5msL52Xw9tF7W7K5Bl8ipp74L2eEBCjeMBwlF5S
 dNjh4/W/CoCyP3gSkMUXZ7bGeoI1SrpiwND05MuryIhKuk+BMIiWNuMGf74m8/gDB45C
 vdbfXJHqJxU9WfgKeVIclN/AW2FERMICbksvO1xfxTdnYGaFsQvoeRkee+22XrT3LxYP
 QZxw==
X-Gm-Message-State: AOJu0Yye1Bu+7+D5oQv9vhs5s2owt31fGYcwtXKWmF2GiRuJFR/epbgc
 0T9G9nB+SjQkqTzMb3vJ4w5T4pg9xIhojK3bpuVvI1SeCHjhJx2I+0/jODoqBlYObyTMqvp51K6
 O/47ZGUucurAqKXvDDG/i1Z0Ivh9HodoQPAosyeFruF0EbD/4hMt+KTbwZgcAg6SgRg==
X-Gm-Gg: AfdE7ckH0KFZByK+1HSEhTTTilmyqZty860Sy9tsR4RmU3OBCvghcBeHgorgKnrgwTt
 uXZg+zyVMJc/JS0NZLzomF+w/jqXpGiP0Mx8PD378jz6XroiX5lQPg4PQkmsQVW+xVPDStzgWIe
 XZXkWKzfmvHXTXO+qQnHmv8C1x9Krchv3Ahe3VshTpn//JRjz0OSpTMkJPRCFgkJrG+vax0f26z
 Do/Bfsi6djKR2SSxCBW35otKT65cbrXahzK5t9Hbywyo4msJ7tzW7C7TQAkdvYVDH9+tvU1zOWl
 mtEz22xIRxf6quqEchlECWQ8VF9MNB8sHt4QIiWwf4bVSX7PkIFcJKspdyI3D8eho/I5djbW8gg
 WlYZOOCGxlIZ/Ab6e2iPamExoWQVqKMV6geEAaFVJyETkAzO+xP6D8+yVJ/RlWz4AGBaXAfDxoI
 9SGLuhTA==
X-Received: by 2002:a05:7301:6a05:b0:30c:5254:788b with SMTP id
 5a478bee46e88-30c84db2886mr7691961eec.10.1782517209714; 
 Fri, 26 Jun 2026 16:40:09 -0700 (PDT)
X-Received: by 2002:a05:7301:6a05:b0:30c:5254:788b with SMTP id
 5a478bee46e88-30c84db2886mr7691936eec.10.1782517209189; 
 Fri, 26 Jun 2026 16:40:09 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 33/37] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Fri, 26 Jun 2026 16:39:14 -0700
Message-ID: <20260626233918.158740-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX0IcQHs2RxIVR
 GuRxo2FzyVsPhAYKPpxK/aepbpgHzwivt+ME5wc8ECSyUsAXVt9K4M46i4VZieePp72T3FT2Sqj
 9fZ7grcM+ay1qi+ocAgbJzAcg2U3ghFPHLpbjThxLNXbkJ3nyCWo6stO6S5l1CL4bfHhTeUoYzs
 uKfPc7aFp1a1LXGe9kjKi7Uq0rgYtDh0X7tHhF3I7kcJDowe/f4ZWEZzyTym7Iaj5trUUGCWq5A
 pqzFP1CfmJc88kz+ReGf9hSJ/IXqkWtYzDBWv6y3HJ2KYpEEoOIs5oD6Jsmzdmjz3sjSDXlT/hf
 0z1XtAgOXY/ecWyR4GN9p9iOIT16C6d8CMtE4GBjWVUJ1RCeNS+BpndK7bYRdiIfEh9HDIKS8zo
 V8zSaXDoTwXYE75Dfr6L4l8Z21I/VJljMfeyZwipgz4E3R1s3APCWkUxw7B4JAWvAMDL6N8FqfA
 tG9LMADzRNnNhJnIUgQ==
X-Proofpoint-GUID: ajEqxuC8bqFcIUibjSqoXi6UqWVxUDvc
X-Proofpoint-ORIG-GUID: ajEqxuC8bqFcIUibjSqoXi6UqWVxUDvc
X-Authority-Analysis: v=2.4 cv=R6kz39RX c=1 sm=1 tr=0 ts=6a3f0dda cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Wi9rtk2BGP7ztX_oZ9kA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX5H6XxOzkL0Xv
 30as1CHAZocsGOckmllTbs/LmFDxFeDGd5CkHt0WjlLSjK/QZgFyHOG5q26N7ESbO5wOiwlVQAJ
 lOzFenakYVm+U8qgw7dt4C0ATludbK8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build |  6 +-----
 tests/tcg/meson.build         | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index f7c0202ed1b..9baf98bc054 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -1,8 +1,4 @@
-cc = find_program('aarch64-linux-gnu-gcc', required : false)
-
-if not cc.found()
-  subdir_done()
-endif
+cc = 'aarch64-linux-gnu-gcc'
 
 cc_feat_cflags = {
   'aes': '-march=armv8-a+aes',
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 54346668eec..2a308d8ad32 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -20,7 +20,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -143,7 +143,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -236,9 +236,12 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -249,6 +252,11 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
+      if not cc.found()
+        skip_test = 'compiler ' + plan['cc'] + ' not available'
+        built_tests += {exe_name: exe_name}
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.47.3


