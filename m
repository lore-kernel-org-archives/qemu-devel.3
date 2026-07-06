Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A29C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtq-0002xx-0E; Mon, 06 Jul 2026 18:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtA-0002gj-KE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt7-0005M7-TB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE9hw1504901
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5XeHdQVmn2r
 EDqSBcHFSkDIsgR7QzjwQM9sPKlJ8ZSs=; b=COLq8+OXyrXzYbSfPeVR0Q5b5a4
 HKDnj67zcab+hsbee1Zx2iOXLnLDVTX82+6/XmlNohbllkPfAHANqphoPgjOXPu6
 B00myj+L5fbQnrltKGiY4ZuOvoli4xF7LTs1nf+HoNKb8gNEZ4UGWHQFAL/Eztg4
 jGBQUNN61fBum2fgmkYUH9/UPfRIjg5JdYYN+rJGbbBGvLvXrawEUd4SzPq2qbxh
 dxXfL8jlyR7SdlxoMJwzoq/Mk9qTbUCzFXvSjKxzeGZwV76QH0xuHaE592qkiKna
 GyWEMLn9SOBAoWGE0ldVhZ9qe5815kxuz4VCXGa0i1TphR3EENEQM81VPOA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k2mc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:03 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so5545488a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377242; x=1783982042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5XeHdQVmn2rEDqSBcHFSkDIsgR7QzjwQM9sPKlJ8ZSs=;
 b=PZGUE3TEZvYFQs8TFlknnNkdgzTx3aolcjlV3uUqZ9G07imi1lC4McY26byHY8qEwd
 BJGHRaxo+s4W/vA+vuZKfQ6x00FuG9OdxsSjI4p6h8mn3lRWyn1PZi9UZGeKVBKUKLU2
 EHQZ2pkm4q1aU6j/4tcQHg156og5R45ubfEH7SX61U7krtvDU9AjHSxnVs5E5ae6Wy2c
 WK8gSYlgGmi+Jw5QQeILfYaFpEuG31Kp6cgnDiJX9i8VgZUlo1FY7SwFUpU/oTRl/Lln
 40fpmkFtDSuSb48qbdwgxTmSJHlD9wOYXtFTCqbLCLGxFITvYM+EoxoDT8zfu86uf2eX
 +Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377242; x=1783982042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5XeHdQVmn2rEDqSBcHFSkDIsgR7QzjwQM9sPKlJ8ZSs=;
 b=EgBeZYwgGrMOhRVZxeKvOIHK9PZp0ShYgnWJayzdSFY73BFcgyPXG6hUuuFg/UH95g
 B92LJvBhwyKb6Mo6blxh84OGeSeSGxDPxaVly8f1L2OMTtr4EAFRTvk+qsd1b7zcIuwe
 izRrTJhIE5URg6PO5I+xw8Kppv5OpwNDwkeky5DhEOSB1Nf+V4v+3jqZUeEG4riCok2l
 c++fhaRM7WgR9uhQG1FxQRHwUrlo+10ewizzYJVDnW6LrstyZ0lqoPoe1YKPS5t1rmZD
 O4noF1YxYveO5FQVVQQSkEObAACt066ryBH8NO8J00vdYTGE3KGZvEeJmekSEP4zx2xG
 yeGg==
X-Gm-Message-State: AOJu0YysMsN1C0LlquaIcX7+/pBGaoqyscXikENowJ59KzmKDg2f/dsR
 2gS7fVe9w2e7tlJGBp5dOETD8vQfdAjQbiYHgQjAojmE4O5g4yH15bOhQND2LQ2EE+JJ6ay436i
 TzEYjKyoEJZD7GdOC034BXq+JpsvSPEH+AIYMllLhAwo5O8MQEiABPmFB5anxmcpYpQ==
X-Gm-Gg: AfdE7cm3EXRq6USiW1ZX3RHcl6YT0mnVBB1GCB6yeFwVg6XgPQnVymZvxWXGI2MeCw0
 Z5gvmfwrHecfd2kEitEzJLXLYLjbd6b//F/rLrYqmKWGANaSGDczYfrCymOAZKr1UZz49G2tITU
 H97HNJ7iWdDkECy5EVHTWZ/TPnEEKAsbLFhuJjL2fTBaStvn0NsF54r/W9TDA3GOybOgjZjyNBb
 bQ4MA1BE+E3N4iYq9C5Ux5p2kupDX4kYBV7UWrIXaJtU6a22iMfIAIaS3S26QJjXMMR/lz2Tymo
 3mG7lT0hVdTrDSgCSNpLqhgRJpMz/Hb+5hB+GpCxf0rJ2ozLgK3VVTDbj31SEAuDFXfyl6Vs9K0
 JKBSbq2Uit01nhJMKWhcgtTtlGCd3K1++6/feXLPDGirYLUUtDDfcIvqvRWmmlvOoe6ndsnX6Zs
 Ae13tRRg==
X-Received: by 2002:a05:6a20:9151:b0:3bf:80a5:51b0 with SMTP id
 adf61e73a8af0-3c08ea3d412mr2948581637.0.1783377242513; 
 Mon, 06 Jul 2026 15:34:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:9151:b0:3bf:80a5:51b0 with SMTP id
 adf61e73a8af0-3c08ea3d412mr2948545637.0.1783377242003; 
 Mon, 06 Jul 2026 15:34:02 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 06/91] tests/tcg/meson.build: introduce test_name
Date: Mon,  6 Jul 2026 15:32:18 -0700
Message-ID: <20260706223343.988769-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2d5b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX9EMfHeH48SCA
 NZeQgnaYekt1H28mUJmM40rCVI6vCx0HLVJ3WVoMhQChcdrwWHTrDdrju6Y23EYKiLCtqAM1Mtf
 2TOL5r9TuszY9WPvgERopCEVg7lGEQU8PormqXGqo0llJHmdMCATptfLBPxzmradvCmNU8Sbeht
 zPRWG1PKS2lKVt+Tv8erN9GzjT0muSWuRWAvcLHFLtP3bs4HhUXH2Kj2HPHh6R5rEwdeZadWRmz
 Im+xrpLzJDA61I7ZSmFiivLKYPfX7hnEzijL8xdXa1eWmgoUy7bv3ggmCKrja/8RLEx9XpJeTG1
 dd3rpA0wivHqKoPc1FycUDVuta8b/Up++LmHlgKvfMlrZurQVJ1HVyvMfc/kq1rTPSOLr/17sP2
 iqFBxwNmGhW9dhx0YuyxmznLIyl8BJFcvclJ/tlTbtbh3mK4EM0TCEvwip1FMiR6zfa/DEgR2YI
 z0mgPHQTEJCBxfiqoIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXxF/sdPIbfqUs
 JHGXJ9uKpvcZqJ3I7Dc8Y6jp9m7zwUo+OiWROp51MxnaxTy65c6ylo1x85Navr4Zt5AUQQh89cR
 KRr8u8vkvXpOMPuzWzgrOvy4Gaw5K6M=
X-Proofpoint-GUID: LSREfxycI1noBEaydHW2qHgTLthZQmb0
X-Proofpoint-ORIG-GUID: LSREfxycI1noBEaydHW2qHgTLthZQmb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

We add possibility to duplicate a test for a given src. This allows to
declare several tests that still share the same executable, thus saving
space and compile time.

A side note to mention that meson perfectly supports declaring several
tests with the same name. However, we prevent that to force dev to
clarify what is the intent of each individual test.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1719eac0d51..3eee3847b58 100644
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


