Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EB0C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfZ-000522-UW; Tue, 28 Jul 2026 00:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfU-0004sS-2B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfS-0001dD-5p
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:51 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aXxt1467084
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UPUEO9X9Us57TO55tyYsMLidlUwsY8iypu2Par62Hso=; b=T5aeaTl6CoCF7Kvo
 849FRX9p9eMw4CHoY/pwxISQavoUQXEc3FLtJ87nAbcMwIv/8FYM1Eil/gEUhMS8
 apsnrreo6+UORp+ZvDo/ieE9213yv9ozGdMZt2V4dmRHqApqoclwHw2f3T6eTMAV
 Uza4bfgY8qw1/hF2JjD4OA7iwBDxNGRRAIPqwjOukZqdpqA6L1Ay1AbDkPe/q4AK
 9hug7E5wciTG/b/zUXzzE9EgAqasmD7x1OjrZmtgRlPx8HEBo07cxNXpv0fT7PPa
 XFZ4swW4jFcMF5xZDugJ0mJzhHYlOvos3lWiHI8p0C7f8Cj3WGwM6cdY1yZDb6Os
 DAKBVQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbvgww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so535193a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213828; x=1785818628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UPUEO9X9Us57TO55tyYsMLidlUwsY8iypu2Par62Hso=;
 b=Qdatmyt/YeWrfHkKWnzOXr+Im/QYiJfIy4ON6K4IIdwA2B0BwXl7uL/eDzTs8ptTL/
 9ZK/wvYZCmVPa9q6J2Wf4zQ+HqgHENTRrIVgZyvC5zf4yz3CDGBGzdlwFpTbBu7Z7IIQ
 9qsZ23qleHF8EkkHHE401yUxZFsWOehwrgPpBOjtgA0KFNeF8KS8mHUdr17/jBiyMVe4
 2nNaylxsWF5jbo0W+NkzoV+3HAftEUZ9SBvD6whxJ0BOsBSvNeE1ux5Uroy9ixrNWVjr
 pKozMSs7n2fvI0/txzCzOzRHUgOUJFxNZrkPFVenSXaol8UN9jQWEYnBJeAKZCsKajqp
 +FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213828; x=1785818628;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UPUEO9X9Us57TO55tyYsMLidlUwsY8iypu2Par62Hso=;
 b=V4d9TH/VYs/4mRtkTWp9K/qQK7HRLg/5FjVxr2kQNjgl8w/kdA1D84uCVlxwzxbSyN
 3Yh11rovnQse29pPS1r5pxBy+JBWhzBezIGn2id7jny3NrJ46h3xK7p3BZ+hv7RBprx2
 DqJd2NZXQxeKpuY9LByFVBPypdNlG+P/DyU3jE/VScqtxFO3jIVqF5tZnZW8enoZWwQj
 4MnDdTfFvMvARHT0rhA1408PHQDFKIzE0tCA+XzdZ7ff9YXoIji2LJk6D/VJj3N0Jk1T
 GrfxDJ5/F6dTLynWyK74LrhStvEudRpi6rwxMJQV9GVCTzVaOJDqSIwhHId0L1lw2UGf
 +FTA==
X-Gm-Message-State: AOJu0YykGFhj2Dhrdfv7MX4G37J0CS0RIkivO6LhBWl8j5IRE5llqjlQ
 XZCWpGW1NfGNsBj83gJ7adIAK0OpckDLCKFyndiH2rB38b7Uok9B2A/9FYecSr5lFBtx59MqEZ3
 EsXFyPxEFBx2oaWWJ1apHC8l8kJBAVYWalaJA3cA3N9R4gvaYbcovXYOM6GCDc6TX1A==
X-Gm-Gg: AR+sD12Fb74SLwby4IDkSfdiBEGyJW0QBT+A0F5LbQANDWfygRV+Uh3r2A2aFTthgo4
 m+WNWv9ToHeGRO9To8qD5hZQHERIh1yqlnh3vNNxCOHMjFWN84tJO2dJS6P1mDTKtiY6HlV8KTA
 OCo5dNs4XHV3WEOvm3N/qV4cuGSic0AF7jM+PcZa9gkUy9i4Fg0RHn3W6i9pMmiELnjxledU1k9
 96M/z9Z9CedNGkN3uodDzvLwMHHIofV+qG7Xs5jN53y4BqSqCeQ5K/jpoSi88HyD9fwWz7siIsO
 0Fk9G6FeUyHY5USMBA3YI//wFUr1xL4MySejzoGRxZwo8+i1Xw08XNmrZpBKqXJq8pFkvH7sNZL
 UNR8ffW3wx54joQgL41FSCblN7nY/IfKtNWnRBhBjz0NqsLS3wQOGY6ce4Eeo4sMMQ4xVcwQ=
X-Received: by 2002:a17:90b:58f0:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-38f6a426700mr921272a91.9.1785213827997; 
 Mon, 27 Jul 2026 21:43:47 -0700 (PDT)
X-Received: by 2002:a17:90b:58f0:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-38f6a426700mr921242a91.9.1785213827592; 
 Mon, 27 Jul 2026 21:43:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 031/103] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Date: Mon, 27 Jul 2026 21:41:35 -0700
Message-ID: <20260728044248.137626-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nK89no_4pQd8AukWVEVckfkvPkl4-ZIx
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a683384 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WK-hs4OApzzqMslTwvAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXySrf0Chov9BO
 0JG7K6RQEVjvEoSs2QHl/R+J6x635IQRYNIXUIgUI2uyj8IhzowRsgT7rLeVB11Hfn+6d6mJvUZ
 LoTflQJBSN7zNU6Xj/dPix2AUMO6LUk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXxQq+Aw/ZL5j8
 B1O5eTIfs3sWXmNYmAxVwGOHNQzXscHB06DttwTS0qk+Bs8fxIriGPtw8lFhp5K3pVzQEQhJVgA
 Da8T+vUW5C1OpXSlMTYvZcG1uhpaay6YSdu/bTuvVlYRoMxZH1Td2EaXhYy8Z394J9n5PoD4K44
 zwHLegNOUScPXi5CYi0vydK3f/JRnavzW0Bo1GFo0WOEYqqwiGTDq1u/9N7hKSItoY6GCjVJoG1
 5n4Z/iCKMOTaMYU+e1B5mQvE22IPMJGlKBj8w+BU5Lsz2YJCFtcbEWIrev8+1duNiuO6x2sy+BM
 oMVWdWKNgDN8P9pHH+C20mIDmMxKS3p7gRvEztqTVndNR7/pkwNmRs//0JljL8bcSJ2YnTElewW
 4nXf9N9hod21pIeF/GBoGZCgODYJ89Uta7yxyzT9zbcQfbuhXVSBy7aRs10jtjM4mZckekSV0do
 7ENj5R2HSdiKLGZDlNg==
X-Proofpoint-GUID: nK89no_4pQd8AukWVEVckfkvPkl4-ZIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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

Add a target to rebuild all tcg-tests at once.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c2b29b2a99c..da0f5a69771 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -89,6 +89,7 @@ test_plugins = {}
 subdir('plugins')
 
 image_targets = {}
+exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -298,6 +299,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
+        exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -380,3 +382,8 @@ foreach target, plan: tcg_tests
     endforeach
   endforeach
 endforeach
+
+if exe_targets.length() > 0
+  # finally create a top level target to rebuild all tests
+  alias_target('tcg-tests', exe_targets)
+endif
-- 
2.47.3


