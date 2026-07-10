Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8464C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ2D-0006ou-FX; Fri, 10 Jul 2026 17:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1h-0005W1-Qg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1f-0003W1-7v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Uc91752826
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yp3t1GqfRGx
 mELMX3KmyhebiFLXsKgesnvj3KW+DrNA=; b=aBzfl1aV9MeU5EvDKcfaLliza9s
 b0y3jkpVU1BZWJsbhW0njIqFOi0h4Mv1JEduetNF4tvukxq6dK5bk7seXwBXBOuH
 707TVtxUTDg7UFBXTIYRE43cTP2tOzVlsehDIRpMr8WyWdCkk8sc6swxdRXhcw2k
 vxVsxRbGjfBGfcq0i0OfF8dY5ieYEztvzjVA6cC/8GwGu+wA0JfqW8vgQvAJk3sG
 SpSZJsX+YwlerYjZoIxSwwVDzx4Y/iDNvpmdFTbDAa3wa4PE3qAIjGK+ENzISHC0
 ta8SWoGcToH3je+QtKupBYIdwcZcJi8f3eadd4BDsGulFD0Vi0U+uYSCUfg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9gk2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cacf17c7e0so16873855ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719879; x=1784324679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yp3t1GqfRGxmELMX3KmyhebiFLXsKgesnvj3KW+DrNA=;
 b=EwWd5Rol+zly61TCUJiOKxz9V6KSc5oxwcAMO+pwwNQ/xYWPxpmI2ITERga4ib61D7
 tymtZ+uzGOcK0m+vlGe0YEE5qIx3yK1ov4bfDCyAF8oPGd4u96h49kIpvHLGLxT2HOsS
 46rRVXX3G9Io8TNflzCadNHuSA/J1QrjZ6Y0GLU/l0Stg07R+dYAMZxp2pVDQqMgxo8g
 K3x/YDCiXFLtlDGuTP2WbO9iTuR0iLV7I0hcGxeyrGiWM40XyNDGinXyx8Q/5VTpQMH3
 lM7Rngh3SmcHa9Ldksuuz4Ew2aGOHqvWFJpMg2o6zqRsDbfSCNQT4kkbRbMBeXdvaKnz
 A2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719879; x=1784324679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yp3t1GqfRGxmELMX3KmyhebiFLXsKgesnvj3KW+DrNA=;
 b=XM8DIYql3S1fQm+HMGT3xHVkJSiC7FkpdRslJSNbLzoYnTF/yVx/WJ01tvKyMoT3tk
 K+7TQL6WtnhuNH4FyzhG/D54ghkVLAvmFGXlR2s1pjVqY36ppE/t0Yfa5Z7p7rp3QBXR
 l9KH3xvuPdxN+7tBjDJCCfYtdEHN8yhuS5sPTLhsX9OIQCPGV5pZPbAkX2AX3cLl9yTC
 YkBZAKuwHVfnnPlVH0UHJlGV91hq+84uCKzEPiuwqvwrjMW1vHKDZdvcMHFnYuPLQZ93
 aX+dLmTyxHzQT9qVpF7flJdbzM+kNGhW11/2p9kkzihUlnXoPJaxWyQUsVvrK39pcXYn
 w90g==
X-Gm-Message-State: AOJu0Yyc0COy5nHuojukPb6cco0cnb1JBvuSJCo1+85rVWC11seQxDvK
 zOFI7xgizncMLWCrEsWCZzKCVnBG3pvLTJpw/BmV6+3BOS46X91srWz+e9wpunZL0XUafKPc7JZ
 c7r13qnZFJDCllQ4p3lvHn2Hi5KGrPf9fA8Ut4k+3fWczqBVOnJPG3xkzPpAlXm1hNA==
X-Gm-Gg: AfdE7cl9f+aeik7Q1lEDKqWQKfgYI+ANGI3obDUTOix9VUFxTXLzx/FGeMr4rahvOjD
 n9/AT6Za9oqkTr+9zsKPjjqhwADT1OOkfTLrDFpPfgao3yZDjYl4VGyw9zlFKGeO4WEM+wVhMDf
 iIEOJRTRola54SqaWvtpEjdS2GBydVraqrqX1X/cYpMezE30Ghxt5RPHjXoyu/I7zAgjny9eKQS
 Rjq+SbU+JpACgwP/NNQ96wLOlDTDur3rRtJ36R5fgVGMa+DrmOO98UngvnShtysVJDSO3MeL/i0
 Mi+92SPIOg4fKrrZ2WQfa33qZvPZQwHleYpESmqXgYhzWHQ3azwf3b3B9nV4l/eqOyHcWs/RtrQ
 dnV4+MnQRv92F83s6fgbJOIp0BU397mdDrAWPcr8pCOBu1PmUuDDe6HxjiqA3dvySC9z9INIxD8
 QdW2YbvA==
X-Received: by 2002:a05:6a21:140a:b0:3c0:9c19:b27d with SMTP id
 adf61e73a8af0-3c110cfefa5mr719135637.75.1783719879313; 
 Fri, 10 Jul 2026 14:44:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:140a:b0:3c0:9c19:b27d with SMTP id
 adf61e73a8af0-3c110cfefa5mr719105637.75.1783719878851; 
 Fri, 10 Jul 2026 14:44:38 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:38 -0700 (PDT)
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
Subject: [PATCH v5 25/98] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Fri, 10 Jul 2026 14:42:29 -0700
Message-ID: <20260710214343.2065491-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX658IzbNmptp/
 e/4gTAd+X0WRVimVQeF4woes3ecsnzN0CVVm2vxvOa0lUe+xs09/NGiKb+PTHVITwyvTEJ6W+7d
 aEu2NGdf83JLGb0A5jHGRwKzGFag+xTUlWx9q2peBLPD0HJL8dER4vEa7//1K9GgsLDQeK6nPT4
 hYKBj4MZcgObnvPNeg+pmGjBkP2jLFPL/xivI5M8ApDwVvvz4KsgTbugx4Eqy8furEf/P/BcztS
 5fbbfnIvoDnDwRLc+/RrctEH1RbsFSiHg5+fuOTAfCkM+YtsSXyxbsFGYctuApxx+ZAytvp6CG5
 YfWf7EAFlUmXCsfClyBV6aCi+aGuoRcW+StcJiXDLaF6FResAE1fVs+zFLGfJKQYSrFLDpULUc+
 ePrxeNeuAc0MDlWD7xGEkWW0INt1nq/4TzjJcdIZJPkYFyaruz1GTvBc/WPAPWdRK9G0wNsN6lg
 9lZE+6jvswp2auLxB1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX7en/mzWB0+Aq
 x8Xyv/h2urPiFKxQLzLWmbBGDD37lxFtbPRMOGDZgsIxKeDUlE+8gksr4O2lPpLgcTaIS4cAVg+
 nk6jCag+ygH2WL4cBftHbEXxSUXnoV8=
X-Proofpoint-ORIG-GUID: 1KXbBR-oyUWNyQNvffZ6eHDT_Pod9sUx
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5167c8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tvGfH4KSH3m2s3Kz7-kA:9 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 1KXbBR-oyUWNyQNvffZ6eHDT_Pod9sUx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c227bb52381..9c00d21f059 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -19,7 +19,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -96,7 +96,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -189,9 +189,13 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
+                               cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -202,6 +206,11 @@ foreach target, plan: tcg_tests
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


