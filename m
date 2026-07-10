Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B781BC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ18-0004tQ-FI; Fri, 10 Jul 2026 17:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ16-0004sf-KH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ15-0003Pw-3Z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCjQL1931534
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 juR5y3086AtEwCV1U2aEYSkueKGEDheKnXXjeP4eNIk=; b=nhgvwOZRMFsev0UT
 FCpZQqIP/9tcoPinkbPO39viBoec5VTp8szvyu/7w4I1oaVkRxZC3LxdTvMAIusZ
 nNbqf1O0OTNkKlKLUwAjsr2j2IsppNurf8W26hhhWC1c6G6HCeEykqgz3tLx/5yu
 IQjPl9F4bkyVudzezGIgatpg0MhrkBArAxHEVxFZ74m1dgiy5qdSa/kka3Y7fFO5
 SyAPdrl6vKXKEmnJL1C2TrRcKAmN3xE3vQ7QcOAURAvAXL0FLcnEsu9Z3AnKkiiq
 TytLR2aKfZbn03dhAiouUEO4O7e+nQDG13GSTCNGTUM/t0Ps1thf/zJxzhi6tNNT
 jEeiPg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2hu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso12245795ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719853; x=1784324653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juR5y3086AtEwCV1U2aEYSkueKGEDheKnXXjeP4eNIk=;
 b=TYws6L+6uQiSg+gyKSqSmS6rllew68qdmOlW/a6V/YInQUqu7lryS+umEOi6RRie5R
 YwxjzSw/Acy6u/fnigF0Lc2p1sDhuSSGXwY/927GDEFwypYGqyLsWebYCoW4A+eBS0ff
 G34ssfRW+UJQD6EQvFvDk/4P6u6loXbO6duU91yZjd2j7Bp/hJTym5t+IHgdFCtabPzu
 311vcq5QmZMWsp9SGIvw4AQFSLeq0vsOV3WImvcOkVS9nlEPgfoKgKICn04rsQNQzvr+
 /QP+IQxAjQU/iy1rpSiHEgrxtrhEog1ylN41XmkdBR/Ueb5lWELY3OxxBmji8u1uKV7E
 Jw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719853; x=1784324653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juR5y3086AtEwCV1U2aEYSkueKGEDheKnXXjeP4eNIk=;
 b=IUSQetKWaO1oe5DamgxsWE1iDz+1dl01K8B6rmnkiWB2r6orJW7rk1JuFbcy6ulVm6
 dFWxuxWP4eTIPOVKk55iCXW3rOTjAwbNyHC53453ZZz2JcsXr+cmy1OUGuoUAsYas0dV
 N1Ob95Xm42e9YurJbQyDpB9Oo0j3BQ9MFBlJsR0g01gCdUmJwZ6QR1Jb8ksK72epFhLW
 HN1KC+3OtDJeKbJVO+peAZz5V4YMNM1+V0d6to0oZYFymN9OjYFvj6siFsweHd5nfIhe
 GZWTgpEdl3hvk/BFHsP7QsEOKs28kNKRvtYf5iqdgrWGRyAwFHYshuvxo5wLKq3uGLHo
 0BGA==
X-Gm-Message-State: AOJu0YyLLtI5ipwWulW0NXIqT1FWF9rjdTyAn1kJahBymkHgwQNrz3FY
 3meGhihjubdJ5n0Jd3yjfAFWDs8pDhFf8r5H9XFf3O5ZJrIMuFAiAANYuBZVuz1ZXVekbD8R1x+
 uTC6/KtqnEwqG+LMpaZjeLlHOY2GsU0HWjPEqPF/InSW39qqAxGESaT+B6Ehj+yLVJg==
X-Gm-Gg: AfdE7clGWav1oM29rCEnxoXQ8FA62z9vVJ6lLuyLa9h7/zLh51JOQvWazdjBzcJhAuH
 MWDah0phmssV61Ws5ReDJHhpmH9u25MKr2PNLLsOeWPvzmHK5d4RDV5t6sYaj08rpP35L3gwXxf
 r5RTRnVXsXyzeRfPQHFZSDEU4RcJYxKt6hXC9Gp8NK64g0P78d2LSgjQKela5DfJ2iA4MOf1Tji
 gCtLO19hpB3qzE7cB3OycthPlpcOcxpZqP5vEPcZSOcG+yJ/c9J6pjeGHr9vqk7X+dod/oRvVmW
 aCrCtL2awFAnSiFdF2JRv8y+PxQeHel8812pt+rH0TE7k0dmGJDkddBjDu8/+/h+jw0uhrzYOdl
 GRyNiiRFxZmAPUJtAq4y1PQC4V6LRVCu/wmgsmERZrQ0krJME6TSDQvM30ZXENhvy12LTwXJd7A
 aGn42BOw==
X-Received: by 2002:a05:6a21:b95:b0:3bf:b4ed:5579 with SMTP id
 adf61e73a8af0-3c110b2f94cmr695109637.59.1783719853116; 
 Fri, 10 Jul 2026 14:44:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:b95:b0:3bf:b4ed:5579 with SMTP id
 adf61e73a8af0-3c110b2f94cmr695082637.59.1783719852685; 
 Fri, 10 Jul 2026 14:44:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:12 -0700 (PDT)
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
Subject: [PATCH v5 07/98] tests/tcg/meson.build: introduce test_name
Date: Fri, 10 Jul 2026 14:42:11 -0700
Message-ID: <20260710214343.2065491-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167ae cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zwvJcQMDSVm0FV1SxG8zkQX0zPF9KpaB
X-Proofpoint-ORIG-GUID: zwvJcQMDSVm0FV1SxG8zkQX0zPF9KpaB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXyzmONrB9LbAb
 BqNHpUU6wBYvvFerXiMdoikzMzUmFk/zUu3JxegCMPD7s4ki9H35nwYgEtOh9+g0hALqB8Jz7EL
 /x+t3iJHWnMPUfbl5Jk2iHkKc07agw0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX/dLvHJ7WX+26
 RtLS1gU+M0jfpzRjb+MIlgiKdKbO5+kFnfYosGuiztSPKNjjWEs63AsaS72xKt00cKgt1y6M7z9
 AJLgn9ZUclPdbRKIYF8yRZ9LGnO9R10Lu/7YRS+Vvtq4arBURzQ3mIZN3ocy+gJgShb7DqqnyDA
 6+m9GG7KugXoA9wuDrz3va+9oQnPxugxJDeBx4SG1SEmZDdejG6IQZJwUrAf2NpeOEG3M6N2zYR
 CuTGdNHxEbzXE7mB4XphXOQcFxpBxANzeb5dHGotuQbHB+v8x+7WI2950uevXkPLBG1eFcyUmi1
 gPCDcWKAvHFzDvra9cdApxNIqVoM2lSJq67rNHvUjI65SXjNopz4L+f2RK/KastxowZd1INi1IU
 BZ1iuk0ZygRzc+EeOfMHgxWhQ4AlD9cAF/1qGDkucPtWH8pIqPqlBi8cocPixTr7etoOB3/3NSr
 Zkc2S2XPA7wTIuVx0ug==
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

We add possibility to duplicate a test for a given src. This allows to
declare several tests that still share the same executable, thus saving
space and compile time.

A side note to mention that meson perfectly supports declaring several
tests with the same name. However, we prevent that to force dev to
clarify what is the intent of each individual test.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 697b826a382..ae7ec998f63 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -12,6 +12,7 @@ tcg_tests = {}
 #       {
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
+#           'test_name': ['provide an alternative test name'],
 #         }
 #       },
 #       ...
@@ -21,8 +22,9 @@ tcg_tests = {}
 #
 # Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
-# is guaranteed to be unique also.
-# Default name is derived from src if 'exe_name' is omitted.
+# is guaranteed to be unique also. Several tests for the same executable can
+# declared using 'test_name'.
+# Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -52,7 +54,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name']
+        allowed = ['exe_name', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -67,8 +69,13 @@ foreach target, plan: tcg_tests
         exe_name = setup['exe_name']
       endif
 
-      exe_name = target + '-' + exe_name
       test_name = exe_name
+      if 'test_name' in setup
+        test_name = setup['test_name']
+      endif
+
+      exe_name = target + '-' + exe_name
+      test_name = target + '-' + test_name
 
       if test_name in added_tests
         error('test ' + test_name + ' was already added: ' +
-- 
2.47.3


