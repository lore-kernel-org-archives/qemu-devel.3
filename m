Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301CBC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZf6-0004PW-7R; Tue, 28 Jul 2026 00:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZev-0004LU-Ae
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZet-0001SG-Mc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:17 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3alZe1673427
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 juR5y3086AtEwCV1U2aEYSkueKGEDheKnXXjeP4eNIk=; b=D54mZ86E8h1C1qGL
 PVDvA9H02nHtv4s8NaaWU0sjhNskHauKfuEG1HiEFgH0KmoYrRnMQAqu7D01cHXB
 8P7J/wk34JLIw3c8VK63JoiO9DtL0KUAeYhv13JYS9lCfnDwkNjJysmWAA9VB4OI
 yjmqzp63Six9FC48cd5rMyH5xXNu58Qtt1klR7eMyXAt2usurv4Ehhou/rLVjOlo
 kVEIBkdbFv174jDnN4U+waDG1MrLKEP9V4D+v8AZzZ0aVCwLkDEXcBnDpDCa4HvY
 4UkUkwg9D8SoyxB5VDGTvpzs1OVFGFd5Wm7sA9Ki0V5MjXLl4U0l4nGOkf93GuRq
 UMpkjA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrstbuq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb5cc1e139bso2224345a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213794; x=1785818594; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juR5y3086AtEwCV1U2aEYSkueKGEDheKnXXjeP4eNIk=;
 b=Ac7dxCDtEPjiBAoQWjoJj5xn7XaqF3YDEVa7KfcvTjzebZFGi9BD6aJw+SaI2MY6Ff
 N6TB2IFF8NQmSYwl309d9wNsQAk5/bW2CySdUV320AfBr7HSF59y9bgvtILnFQYJeHLj
 cNWFi9HaCwHubvZuiAK/fXmULWy8Pr11g+/8PyzlrDJa2CdXBLay/zZrBfIlCvj+NMZG
 sKadp4kA6YIKbml7BXPKKQ536SEdD8hjHNO09roAYL+HSuJItfMfd75niIdNGUtWIv+S
 UT3gOHISOxFrqBurwrVK6rJB3XumPiYqSFOZDmH5xvCS8LGueLmlG8yOBHiHEGDcZHFP
 a52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213794; x=1785818594;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juR5y3086AtEwCV1U2aEYSkueKGEDheKnXXjeP4eNIk=;
 b=b/ZYTDu0iSaGV4FyYL9iOd3dXpfTmvHgNm+YH1IFUojD411jqowmJX2PHjYWEUHZlN
 H3bDQdp0j2jS0TIeLC0CKPBQwijkR7Q1pGZqTYCRDSk8eiVcS2aHAI2akid3LJsLtyDO
 V/uZiKqxZBAUPcKOCNUfFHNk8LeVdytBA+7SMxdiG6kXixU1FclNyb58I/X4wvKgYaPZ
 0CD58RkMRmXMgGOBV8TE+dx/RY966/a24tTKalhTt9/b+DmXxe6jZMX55hQkB2EL5QXq
 SGa4DhY5tgx2lOvNOxfLXPVSn7cCGIRyLyJhlm3tjVtV7yXqnbW60tr4vWit539Lzyut
 NDHQ==
X-Gm-Message-State: AOJu0YxmUdwTfuzyy4WnwHy4tlR0BuHnIINE5lbsl068F2h69zRB3e7k
 /xnhZkIG5csyEUhHHEwVyzsQSWf8nte/gJKw186wQYZat7K0kFsdwCAkmq/bZgKVRtOLNrTk7T9
 klUffiAnrNDgH6HV2+gZsOI16MxAo7Og5lPedbhsEQuznhnW45ke06jOQygGYJmtLjQ==
X-Gm-Gg: AR+sD10qGjbYshteB8FR9QV2crjjnAleGsy+u5WS+L1TdNdzpfhIE6k+uwiRe/c8VlD
 7F44wezJrFm3cKFuIyfzPlzoy+D6hPk3G75jYwxO1h1U+GBYcw4++WwyANe5cg/dGdxSeo2s5Oo
 BDW5Z+XGM0+TIb68XacnUQuMPv/xjrqyFbJY1exgrCIlEgnrQ04ZAUxEWdQA3B7h/ASv4i1Q8i5
 BiOfEa1fLQ0BEhGOlZYychmY1F9mJwRdq4FJ/C3e2qkc/l3OonBYvfBBy6nTyiu4A6Rn0WEtt31
 XQOjA3MGEzn1GjsBygxIQ453PH2DNlsZv0fQ9MNDpe7Ufrzwqll3lvrua5FV6lPK6Em9bEnyjyv
 m3j66MSZ1n/0jWPQKTm+XH7MfBBLnnnlTvuTKkaiTVhk19OVM+MP/70MHWU61CrGFCya9u5s=
X-Received: by 2002:a05:6a20:7f92:b0:3c3:97fc:93e1 with SMTP id
 adf61e73a8af0-3c8aafa0153mr1190776637.15.1785213793752; 
 Mon, 27 Jul 2026 21:43:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f92:b0:3c3:97fc:93e1 with SMTP id
 adf61e73a8af0-3c8aafa0153mr1190747637.15.1785213793301; 
 Mon, 27 Jul 2026 21:43:13 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:12 -0700 (PDT)
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
Subject: [PATCH v6 007/103] tests/tcg/meson.build: introduce test_name
Date: Mon, 27 Jul 2026 21:41:11 -0700
Message-ID: <20260728044248.137626-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9EsJ5MXEAvn8
 iiN67wi9Rk8w0o0ZLhmk8Jdp8e0rJexGrh4pOOQbOXAnhbWVPICWXYj5eKsES1iGob0xKKkfFTN
 84Cpdh/X9zX0tavSvMho+jLsz0LlU3QGgN99m6dSkYYWzMuFxUgFbOU8lr1an8cEOgvbzah9QGo
 2li66+I7Klest+0CaxlOz5VxDL1uZUNBdAOA+ZbjYkOkVOJM5Y9KGOAtLLPXUxtZRdsGK7QEFoJ
 iI2BO1AlG+UvJ5ppiuU86GAGcxZsIRFs7819aqUsm7Z8es58o8QP3TYCV+E1mx7CN+xFcxZ230/
 4poDjGCjuS6A5xHn5yDj041yvRGu2Iyo53fePygmRTxY8GpnIJiL4e+jBKxvI2GNqA7stBuHezE
 e4k8nTg/+I1t1SLd7PskMu6Te9sNaQc4zGQs/fsqF0WRxxo67R2XbD1Z+XKZUe7Kca+lKZLegzc
 nCKwh2rvAzia5p8DGeQ==
X-Proofpoint-ORIG-GUID: LZVm79cw0y-UPfs7BSEhGjbI6KwXgnwv
X-Proofpoint-GUID: LZVm79cw0y-UPfs7BSEhGjbI6KwXgnwv
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a683362 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX7Pt8NmameVcJ
 v30f/GsGYEUewW4PZIGkzkPwUncKyGEuqX+Uo1yDSIdTlNK/FVk8QHF4aEaUefPEvHRl4IexptV
 iOiSC+kT+YdxcN9Y9vKfBzMVBVp52N4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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


