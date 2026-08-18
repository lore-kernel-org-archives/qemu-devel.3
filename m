Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677E4C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPZ-0006ez-GI; Tue, 18 Aug 2026 15:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPY-0006ep-Ho
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPW-0006bl-Vu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH9VE1454263
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=; b=GEZxpQEz+i4XHLW/
 GXUdoS9uuCe6lBuRRr6FKfpV+H1xyJrYi1HlqWKTWocyqxGHYLHiHsct84LbMaBj
 nGWoyTJiem5KtMp9OAX60+amt2pDBbeXisqgELUrZKOkMgl4/tRypW5Rf0ORUHac
 584hR+HLpHmoZ3rUjLJzjqUEpXwZrr/qeyefsg2vVBYiGN4w8gkYeTgwk97GGMDG
 o93kOmy0o8gwfTtnOb4tgUElXPp7AfehpXnfzXomUXoycWhSa6Q46we5Yak8cst5
 xdHRv1rvXf8KCpSjiO0+e5/bnulXic/sX7sBZt2xYxMQyteARslQs0+VmWPRR+Pd
 FlpRTw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1ubs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso2389575ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081015; x=1787685815; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=;
 b=I6tOiwN/laVH3xjbVuFuUD/Nn+N7CyvfdBWNvGCxHfWGL83jugfvOWvKr0EA54qXBC
 MC+DZT14UNPlkjyhcQ2YOK5Y5fO8rSJudT6+cLtoLcoeifnDDB9L+c+suGwoNMKMMTrI
 eh35ZiYJ0Uk+RMxjERn9tgg0Np1j56uZ2Sdc1AIG1dQNcMXU86TAmK2wpET1eK8cI3Ky
 ULj9ZXNtEKJmqVBzLo+4D5aymuy11DJKdaRGBP3vYFUsxPEaWo0O46rHESmxC3n/vCNA
 gjcU3cfwDI/ziDRO/SBnE7VQwa9quA2GeSw4OT2wDKQnCpKS/9+t+2KyCxSZDviU3nqt
 kN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081015; x=1787685815;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=;
 b=HuOKyJbp1Jq2ul5uVoNYIXxNudNsUUV8PvEPGTNsUQA/P/CWRRAZnquH8QNWy6LqIj
 vfPRmAldEvSYLOF7Ll394rU98g2gaxopDaJOzK+Ti+e62s8A7nDcfDs4FXWrTqqHlX5a
 5YvpC5oedG4r2G80GrggINU8HeTMquZR/ALHMmAe11g5mx13+AqQPnOSQfDafS8fgsl8
 kEwq/q2f/J6KFFfvmzo215YorCRSHVWeDsnwJA8zfadSh5uJs6hBIA35DtLRY/ic2jzO
 kNtE2bmMdNQo2zbPR9GZ97EPPAShLRXFre7VfpbTmX9/fbuzj0bwoGYN1hA7P89ihHTV
 4vzg==
X-Gm-Message-State: AOJu0YzkYM/KSB66c77Asyf7xtt5+yLaz8RQL3Zw6TGFkNYaWvGeyliH
 qHwmpSCievGJpj9XRvCMriISUSVmd86SJ3uVEn2m4UM+O1xE86F6wHH6+465pOZ2MYz2VerC4if
 iYDhPdxW6hodhP0rXs8vt0s3XBLaCXK0Kjf3aMxVoV39ADueVIlxC1cAjRgFkeaOPNQ==
X-Gm-Gg: AR+sD12M91RWZmxD/P/hVqe4TYdRUHkdSmBmy52HhZrV0hcRiModfShlTRSWNV135wk
 lrGHMcirg1bfo1lCAd1xvp69or6muJEp1GhLPcrGSrlP2wCKEeWyard2hhBYVV4hHYqb5kWZu5K
 YYkL9y3Uz63EwVe0UvS1Gi1hP8qJPE4/9T/bd/Sh7xqV9Semveo7oCnUNs+/580llmm4vljj4cL
 X/fmC8zmykTcsu6kfIo32a9ailfr40F8jFB0ub8YRZzDm676EH2OJTldxBhOgPuwNJA5b+jtn4d
 MKXgV8dRPdm2mUxo7P0QJn9+of5/u4gAuZL0rDVToMpkaX1ZppAmOfydccyMY2A+9CUhz0RiJS9
 dtxWpRVIYa5NtBiah8fQoBI4mD5lZ0rWcAIhR3tlxczr88uuNpy7WVUsFCdY=
X-Received: by 2002:a17:903:17c5:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d5f6cbe0b1mr688505ad.4.1787081014775; 
 Tue, 18 Aug 2026 12:23:34 -0700 (PDT)
X-Received: by 2002:a17:903:17c5:b0:2c9:df1b:e948 with SMTP id
 d9443c01a7336-2d5f6cbe0b1mr687705ad.4.1787081014366; 
 Tue, 18 Aug 2026 12:23:34 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:33 -0700 (PDT)
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
Subject: [PATCH v7 011/104] tests/tcg/plugins: build list of test_plugins
Date: Tue, 18 Aug 2026 19:21:35 +0000
Message-ID: <20260818192309.22169-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1kh6KG2cgjWp
 u70L7EjgWEnTcSdTR3fFmenEgFCiSEcDOqEpBQmpP/SaFuTRlwz0QOx6S0W/N/kFzzWpPLhd7IT
 rlW7S3jf46eqE9imWEa8ZBlohPMF50c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX88B6UYsr5Knu
 JflK6lAwjanjOJ/yNrG93zxLKTLmQGXJgp5rzBScrPN2FR7XodgnAzoKdZGq4hNf3mly2HKOD5A
 8ByjBU/Y4TBcCClTa2hFJgaCadHoNLuvpF7ETw1tbiY05ZjIAyp3oXzawubGaGl2w8oY9lXYSQf
 xzwbrDcql+hpIVsD759o6djYo8bxHti+xZz2IZsfbnIu5XEdhliFReZ0Fy8Ea2PWXAzBQAmFHT5
 bl4mEcblRvHEXXWbD0cJy8whA10Eqa5Lrhl8k1dEeV3FVD/xxKtg+edtdfWLwzUghhaBHbjC3m4
 M/aOiItTL9fNnPFbWvlqCLQkTVKFOLS/LPQsdXSwJPk4JgGb2NRSi2Wi0N5qNc3sxUmoeSU3rPV
 8lUj4JR9nr3Hb8H/h0iz7wE9AllOhZurvcxZ7oM06fvkogjWvgFmZMOt5/z9bTJVN9evYbnnrqZ
 FufTxCovx9nByf3FvlQ==
X-Proofpoint-ORIG-GUID: L0ts6AF26Ha-ZI2FylDakskirrbEMpqU
X-Proofpoint-GUID: L0ts6AF26Ha-ZI2FylDakskirrbEMpqU
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b137 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fbee86e6b4b..9940bae80a4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.43.0


