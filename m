Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB51C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1T-0004xG-Fg; Fri, 10 Jul 2026 17:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1S-0004wr-6v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1Q-0003Sm-Lu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALDHsW1932812
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UQSpNEWV+K44PrWgscLDKx2w/PNtRjkvAr0Nf1Rinb8=; b=gtle1UqTAHDJXrh7
 WSI2Jx0tkFyTllhwvU8mV9TbGhoYdrJsTlYKObP1CLKqmpiHHdNpLXt6QesYTWfK
 mYM1Ou6dQekwxdxPhSCR6A2WLxR0WctAUOK1SHyPPb5pPtdFN1S0ElKYSLrLrAK9
 ZRqeNQIwoupIp9F2UZt7QtxEW7BuxIPDAG+urjFtoRz4vHTqJzznBHcH8+pYn3rN
 fvxFanJVmqL62mT2HLlQqS9wNrIYFpju7DJktdbo1i/j+8Hu+pwVtmSMtpmerzpf
 YLWRnutY5Ysx1F/2ioXnS6lfiO8fswHMRGiX0egx38iHF/d4TTovmTsB1q6djnKX
 F70Gwg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2js-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso1512566b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719865; x=1784324665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UQSpNEWV+K44PrWgscLDKx2w/PNtRjkvAr0Nf1Rinb8=;
 b=euHbw9fr1+LFuHJAjpE/VcQ1tjVc6YdESlPaEGZOG9PH83A/6cf7HL0JWyWt2GYsbt
 u1VFEUkdpMZ/OithlaElg6m9VBnonrY1RaDE7q6y6Ua0HItbodzM4O/R64quPJbEzy9+
 aeCwvMQqOpK7914d5Bh/qM1KbjKUNni9UHMmig5L4RnPPQ1dtMCg8QzOb/OXt5uj2s2Z
 9897771OIwMbOqh9xQS17wI6uSCtB7Lft9SCyd55+to9uiVqMlqe61MgQCT4nNh/+7h2
 ORlUog/XGvphN3pWwECf4lWoCR6mFG9ukcBC1TFB3TLXxk1MT73GBCVcO4TxK/1Ss7Ql
 P01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719865; x=1784324665;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQSpNEWV+K44PrWgscLDKx2w/PNtRjkvAr0Nf1Rinb8=;
 b=Vedllxlosw66A7dqF9qyAmDbsPQM9IHqXhMdUJaUoTG22tMwD8S/xRes3ABqiWGb8T
 F5aMMGk4/YkmX/F5JkahcHZ71yP8jjTC+9FzhvhinitpplCcZEpwC67ANssMpdXkcKMe
 BQA2TVYElg4JMlT2DRsbNr3CwYfLmzEymZNm8MUH+Jr3A9/o9KsQDEobEL50VW5SsveX
 f6tYD72ENu8e9PqQIWRp1bYDLj1Cm12afcptPIz8PGB7dIIkhizG3/EWfmwOxQCi9lbS
 cH6cmGWfFgkcJDqFfb5V+/5Skd9ZSgW+QASAUXmT2a0V8b/LAfL6VHphbn2hr5cT9RYM
 ZPUg==
X-Gm-Message-State: AOJu0Yz+qUzy5YA4Mv8U3HTN5K6d0bMJ4S12c2MTTqOGnCPxrUNaR/+e
 tVe/xgNFdE1rLw86ANUyxRMOWTgh/H2NMeOQVm6q2pw/hX7XI+B6XPPTVXtpT3ue/mhcN4sQXZK
 c7Vi3QMhYU35ubYpNEDapA5GmoRo/os+2Uq8HGnaqwnZi4B+hXPXvr4fnXAVFRoqvDQ==
X-Gm-Gg: AfdE7cnrKPV3UuJy4gikq06TGW1Ijs4B/lUPr53bgI9qzY7nTmvx3awzheK95xnK0e2
 w5wDBlPB7y1qYD6CDdYfHIOf4Z8zcLz2ySJ/jKBo1r0twS+D2syWO21NnDXlEuyKX2nvfUbBYOG
 x2c18NOeamJGGyG5eY8WUxoGTRs8GXkqFPgLRs3MJZbrI33hnveNYGBUJIgUTeEM0SjOgePB4aJ
 99tiOHD2h8WaoP+cQM18Z+/nwTMujYoP0Gk3QTCiY0X20P7CA7eKNEOevoFuFIzmvlg0noJ1q4y
 0b6KC0eOxJfMAWSAW5L0KmSChFtSlJd3ykBMNrLZKhLzvGCYaRJ1E0NEpNBgCOjOnE/THJRwAki
 AiUaye38q+RSWNlYm397h+bGPG67k5+o4ojHBIK+vS3xBaqI8I7fdD4nx7y1BxRDg/Mp566wZss
 O9a94PWw==
X-Received: by 2002:a05:6a21:60c3:b0:3c0:9c19:b272 with SMTP id
 adf61e73a8af0-3c110bc1ed9mr604526637.64.1783719864805; 
 Fri, 10 Jul 2026 14:44:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:60c3:b0:3c0:9c19:b272 with SMTP id
 adf61e73a8af0-3c110bc1ed9mr604508637.64.1783719864380; 
 Fri, 10 Jul 2026 14:44:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:23 -0700 (PDT)
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
Subject: [PATCH v5 15/98] tests/tcg/meson.build: introduce wrapper
Date: Fri, 10 Jul 2026 14:42:19 -0700
Message-ID: <20260710214343.2065491-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167b9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: q-gSHUCF3cFkSmfMDpwQsXL1Vcwiwb8i
X-Proofpoint-ORIG-GUID: q-gSHUCF3cFkSmfMDpwQsXL1Vcwiwb8i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX0yUwJlSff/Ef
 MsP7ZhOlOvRIcWcsybYDAUYNiINQ9Y28g1DBJo5wEO08imIHG1fC2xTvNTzMPRYyEmxJxRUm88K
 Ox7pRMsh9ZQeOQkXJjpkhrhlqZDzY10=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX+Nj3E0RXedlu
 pMWcPRyu2xbDKbu7ua8ovSX+g5C51POiWXAybIbYKsADYIicqC8+i5mFsB3JLrxXRnnUbrpUxNg
 qG3aMZEfrNyhJSVEPtomXXIuyBYuEISF6VL+zpJPuCxVHVn9btTLjAtCHUvSXzqpeGBMib+de10
 b/cBH3YA3CQNs+xxgrjGdeqN4u54hIMvWAEENmAm9OnhmMx+cRwmxcdbu5B0IIZkhMUSkgOsSVe
 B7rS93VrG0noza+lnvowAyHWOfny960lUiY2EucgifIvcNvd/QrJgR/aUCya0FPKpW5IpQsCWjY
 f6bJOt0wse6h5dxTM59kcSY/mBxmBeUM1SYWW6H2ilHUyg8PqwGGwhI3kenNSr1fk0za4NSKYby
 Fe/zHmgNRHKo3mn3WkO3nOv3BLTGASPsBrkag35zkPL02+2invn8/kkleMTQqYPB+TzQutDst/c
 6JvT4t7kYQFInl3QzqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76375615d0b..0311b2432e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -25,6 +25,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -86,7 +87,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -200,6 +201,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


