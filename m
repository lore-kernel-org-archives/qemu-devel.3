Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1938DC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFy-0007OP-Q6; Thu, 27 Aug 2026 18:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFw-0007NU-Oe
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFu-0003Ye-U5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:32 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLeb6124903
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=; b=DYW58tyasBKvtui1
 btFHsdOuCHYnCrgDHdFpfa5X0LEA1DwaZKgOjZjKDCpaSXSDS7dOXI5eTTu/V+zt
 CFcVVDEm0ab8OSb2l2N7Q7m+y6tyhJWjgrn3ouO7nbJmXKwWKqiJFQG2URyZZZy8
 wUG5dbzfZotO0zd4Agcjnr8od+5fE2Vj2tNKgu3R1iC/qpZDohLjMka0KpAIZz7m
 TBCwQDnrLY3UWov5uvXP90zXY6VZgoJMi8tkhsu2bC6OAdjtla6DehM+0pH0tFhd
 RsK0v6HTwBDDFm5X2rwO9VKoKLA8QJB024GsG/78b2opsg0sEXjH327k2jLXatgI
 5odlZA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7tut2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-855315ccb64so320443b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868449; x=1788473249; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=;
 b=QcD2y8AAVDf2sxr5Aw8maotvcFsRvsz6FZcQXRSbuOmUl9J+AEkXdkykB+UOzjwyij
 hrys5O1gLX2eLPN1+DSlirb1jJmo4pDFlTVlK9tYFXEPddWLx3cMUOmYJXYGK2K2t43A
 iEeu+Qhdm2Pid41uCt5nV3HyRmu48Z/kTbnOUAIPyUjTdeEsgXMtx4Gv8Wn9UozYn9xp
 Vee4/kKyl+/HaS5hkZYvT6E63ir4tHgOE6TA+u49cSCh4mPl+gBcLTgHsBku5ZftgB0r
 a1ePU9hL4xm/mQeY2L5P7QVxvJKhyo/rgzGGzNFsBnQ9jpyaZQv/c9RU1O/7KvP/YVbK
 seag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868449; x=1788473249;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bz7B20RD72QpezR1e6/rqmE9F52VLa2IVaFmxlNoH/I=;
 b=OgJ67Z+X+eNUw08m0L+KohgGPf6JZTnKetRc4WFyCwQW5+UFvIzGhP+03MTw+zWKPS
 o8LFssjXsRaALjxih60xfkyRcYhxADfpQa8khNH9j+Bx4nWNCIKZQtCDa4ymF+emnsTC
 LJ2WBQoT8/Vo2O/9eVxCYykWyn+3LaU8UhdjUf8aJ7Q9f2TFmeAneOzZ1jdTQQ2UYaP3
 RLJiaIJwInLAYjJ61l2ZSF73NrRBAKOBUdIAMLG3lD4kQ7CcRW3rAntKNeSCD0hIWvPR
 mgZh+3MhyrYiP09le6KShsVRCJYodz2rkDgjRXelZ4GtbmKPvqAaUHDV8eYPrbuDlST2
 Gn3w==
X-Gm-Message-State: AFuF++ljj9uUS2Z3Di3HZHXTSq4C6vbJn4fKxZjRx8a3RHYCg5050Lwg
 +IAu+gcH+RpQ80KP5U0LcOo8+9NcVfessG8DIr8Ex/KWycDH9zESnEu9SPiLRnLn8JKoxfEVot6
 ImbA4+INYB66RWeIO4Mw5XvnB6n8RIn7C6BTZMXC0L+bnKKTbI7yTr1afCuhKn03IgA==
X-Gm-Gg: AR+sD12XDvcxV2sGyE5FTT5WID9HTZGkNH0neerHsFG0h/w1CPxADR92Rcmpr6Cio3K
 xBzFl4nWZovIwbhrGjSOsdAXD1x9x4Rc8iLkp38wVBSfulrAm2zIR5mKfy2I3qe2vjarJAMo/tU
 uuRCqhFUCbcDIG0N+aMHuOlr6JgiOVaiWhN89h4sMYLrYQD19VpZfYPgv5k9puoKS8Zkm/K03SE
 d23nsW0SYy7E56QatDWJ75pgYFozmVvjwLC1QGu4bdgJ5jCHtEIF2UrYehemD8DNXr6ear41bXl
 CcjSqx/PodiFdXrTx1koal1mYpPw41qzoyw5cFt30u5ETGyXZJ154oDdKZqevkSYakpxAfh8K0D
 f0TPDMHl6iDDUs7Mfi9A8KKmWJkEzCBVNX7099c5JAiFRvhLO/NNEB6bsOoc=
X-Received: by 2002:a05:6a00:2888:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-856281ac5dbmr4238817b3a.6.1787868448748; 
 Thu, 27 Aug 2026 15:07:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:2888:b0:847:9315:fb8b with SMTP id
 d2e1a72fcca58-856281ac5dbmr4238735b3a.6.1787868448253; 
 Thu, 27 Aug 2026 15:07:28 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:27 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 029/105] tests/tcg/meson.build: check host cross cc is
 working
Date: Thu, 27 Aug 2026 22:05:23 +0000
Message-ID: <20260827220641.84885-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzozFZIk7gRjG
 qwK6CJimuAem6Y688SfcKXrWq4ubjxRvGPRHDLZ4LVnXisU0/ahfly0u2ymVPXRFj45hy43CE06
 hT7jQ9Knh0HBz5YMmY5DORh9jTU29hrqV4pUrJ8TDSXx66m/MfM6thPqX/pRGrtyI88oNkamI/q
 625f/sKbcp4IP3JvY/DDqbXluxxoXR681FQFCJqT/QIQyuLGwH/LauRa4uv+wepy0cgyMUJ1ODN
 +ETo/7eBcCavcPI1yEZCLTeVgPP/pGHM6TY/S/ujo/WNKPHOenzbQIE4wlEjENGhajcajlcs7NN
 vfI4IgCf8iY+/KxTxhCoH7D3SPp4KRwbOeKxylKgkx4CnzC9pXBMVaJvUoizRht9HMnt0dTWamP
 UoTyki2s9R2X0nfTAJF614SJSFfdr8eorKvP+QvnuxbWVUkftv3qZv6mhGRGQtrkvR46pU4x2Ab
 HJqI5QpV4IaO0B36hTQ==
X-Proofpoint-GUID: 7GKnwXAOyHKpAk4kj_9gRoQbjPvAbhn1
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b521 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=Y7GLNXJ1w4EJNdMAD_QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 7GKnwXAOyHKpAk4kj_9gRoQbjPvAbhn1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0PAxrZL7aC0q
 dgch+W50wdL41rrtisplqqnBkYGawYaiKVJ5q5ZDyTJv9OtNy01PTvIX3eJT3RDqLAYkPdwoDOB
 fwCCTZ5L+4zDCwG5SUX8DJdhMWIvWY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

On Fedora, cross compilers are provided without runtime or header files.
Thus, even if program is present, it can't be used to compile files
directly. Check this, and fallback on docker if not working.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 12 ++++++++++++
 tests/tcg/test_cc.c   |  9 +++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 tests/tcg/test_cc.c

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ab7090a62fe..9809695f3b8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -109,6 +109,18 @@ foreach target, plan: tcg_tests
   cc = find_program(plan['cc'], required : false)
   cc_from_system = cc.found()
   has_cc = cc.found()
+  if has_cc
+    check_flags = ['-static']
+    if target.endswith('softmmu')
+      check_flags = ['-nostdlib', '-ffreestanding', '-r']
+    endif
+
+    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                      check: false)
+    has_cc = cmd.returncode() == 0
+    cc_from_system = has_cc
+  endif
+
   build_test_depends = []
   build_test_depend_files = []
 
diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
new file mode 100644
index 00000000000..d3614a01fe6
--- /dev/null
+++ b/tests/tcg/test_cc.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Include a standard header to make sure cross compiler provides them */
+#include <stdint.h>
+
+int main(void)
+{
+    return 0;
+}
-- 
2.43.0


