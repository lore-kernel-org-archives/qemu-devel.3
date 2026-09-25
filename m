Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB03C9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7w-0008AN-Pa; Fri, 25 Sep 2026 13:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7r-000882-Om
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7o-0000e8-JL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0KWw1363032
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LuqNL3CuJi9
 8/nAA+sNLmp6zeQFVYQDXZvqsrV03Ysg=; b=ZZFmJR9hHeKI86VPgzbkMIkw6Av
 mityjbJaI1qEsxcamg50KjTuPqH5H9398UU5kNjf1CPPXSUyugfYJchGIXcmGsL9
 qL59zY0E+tJX6E2ocJisH38MbM+2DaYBhQHag6CIRkGpZ1sjxiKhWESebAK+FAfs
 0daSbVMQG0CqFda/KSCEWzPRjFPA0vuwh3rwsEPHsQuplyBRQOOmfcfmmaHbI3tV
 o+YTUJhFdaOV67/RuVX9xknD4JxSwWakwk9TwvZ2kSDzpX2GB11sKPPYNRfqyRRS
 kAGsWGZ1MNEVelsg64DjZsIj9Q4izqbssPm/Q+U3cf4sIMoAZp40Y3AlelQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnsmmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33baaba6371so1251179eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358859; x=1790963659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LuqNL3CuJi98/nAA+sNLmp6zeQFVYQDXZvqsrV03Ysg=;
 b=hOqInGepLGoRxyEq2LyAPmNN59pn0sPgrppNvHLHiappGnAfgH+TovsYhExSEYjxkK
 nLs0RyYzeQy1eBOCnJxN4ZBqsiRdgY5RHclE6Bj92SSO8fGvcyePgCThjV5/+xoFDzHC
 CVAcjltpCeJF3edQP2o45eOOnYr/4TQRgtat/aMsb9uNXM1z34pOV8ea4bdfc5Dp/YKE
 8tN8dz0jrBOp+DAjuDR2kvuzMR0L6/l18fyirHvsAYwGDhT+EBVwAYMAoCtYoAgwYshH
 2XVRoQMBbrXDob1Jxl7BzVUVK0qJSc4RzQZrKISbAKLzvTfQg0JlYDFRuJ7GzCzZMlKJ
 3JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358859; x=1790963659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LuqNL3CuJi98/nAA+sNLmp6zeQFVYQDXZvqsrV03Ysg=;
 b=HUlnkitZh+8XhGfpaJ+uVN1lNRqqOXQgN5Tc18OMX288r1jx2Ib+urXxSKg6YDIl2D
 MShkIbbS3cELt9miNd6LR+w8tUSsXhwqm2PyZ2l37u7pS9a+xL4mxW1DdFp+0HZ9/u/b
 uT4SlQOyLt14FFv+TU0tzdO6Ex9CDsG8RG6MS8BsxTmDCd0/34E0SA2kOSbkY4lHf7Pc
 G5fCloUeKvzIjACOk/rYBtoDqWXPImH/7n81s+r6cNU9+w3wnUTgHGdbkGTbsGAczrEa
 7BkuTmikk0fO1LG29wJWqKooxqVmr83dAE0V/+pjkHidI+1AfwEy6G52SmizOHzaBw4G
 r8UQ==
X-Gm-Message-State: AFuF++m8H6Mrregdxx7NCkXxSexL3eCelS8yGSUj8T277UdfEhMw/BFG
 rkyANArDKVrt+IARPQ15V4sMO5C5/01jU1/EY2elvnb2DI2vmsfr2AWFdOgqJYTghE82tBlb0nS
 tbq0L5/YzX8+1tYmhWmKqUJPzj+AX4urCNQ4XtQ9i9kkLWO+GVgSQtJHu8ZaXc1FmRg==
X-Gm-Gg: AYBFou3DKkycCb9BdZTwalGLL73TUGaE79IIFQm+ZdEmbybl8lBfOmccd/iz0BppWt0
 DIxm+iEOghZcfGbwZE0zrlNRNHI/c9eP2Z0hMNOi10V2XFPW1AyZBUhF2tjcMG5t/pFanXaoEcH
 W47hRKu4VkNzVTHJsVPiOs5LbtvMriuiiHht0rtoO+NRbZw/qllBY5NlrRuqdULwnR5+AG42G4X
 1VFcXIPIUiSKv3mEgr6YZ87PJsBuvenKXD2PUXh2mQx75Xev1xNJqaCygBGUvMapXBTKMoPBLtL
 d0f3H0LdHgnYIIjTokSTUenBQ+PeutCgjetMOopT+1uRVjT502lOM4NcKqB4UH9wqSFSoYKuqM/
 3SpI7DuCPVRLJ2yTWNhLRMrpnCcZjg8p1CTr0LbrJnf/f5XkPkxtexppgHw==
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id
 5a478bee46e88-3426fbbe36fmr919827eec.8.1790358858503; 
 Fri, 25 Sep 2026 10:54:18 -0700 (PDT)
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id
 5a478bee46e88-3426fbbe36fmr919793eec.8.1790358857899; 
 Fri, 25 Sep 2026 10:54:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 09/13] tests/tcg/x86_64: speed up compilation of avx,
 mmx and 3dnow tests
Date: Fri, 25 Sep 2026 10:53:56 -0700
Message-ID: <20260925175400.1897574-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hTbFd-zHRUrikP70kWqylO0SG1SjezZw
X-Proofpoint-GUID: hTbFd-zHRUrikP70kWqylO0SG1SjezZw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX+JOR+cDksXCR
 oasQLsDP6hOCqKZdCEAW+Rzp8IpZZxz2CpJBSz00qMsKX3tRAtoYNL1Y+v8ky00ytkkmtT0LiWw
 hyT1X5k6g5VeC3F0VhxO7SB9cJfvyUE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXzjbjj46PalsR
 Q+bh9Z1oK/h9XmEfyx3C8MyxpBtp+z3HTIZlnzEbCg0MyVW40aQeJbfNB3mcvpYUpkKyTNa3lpF
 q/a9r7QJtZ7PArQADK86rM1zZFkz250K35/FhMRsNFM2WUmCRdjaEaC+ZaiZ/KmwAZpS2m4YmVt
 GxYlAjO0UDjsFj6CVQ5VG34CEu3vI+LY+wqjDHsW/yBaZfBYvh1cIXMDXtuPfvGCZmQvW5zsL+j
 j089iEUfoiBA2Y7VSTwdL/5G9Iyg2JolGCYJtYjdrOuJc46BZmdCOmZhqMHW0sdeMd++dqqlGJ4
 VrHSB+lhRYWNo3b6X4gZ9CfKGL9CUOA13WCQBWv4Um1UVvRB9PhUvOd8iVBQ5DF7s7AlM+2GQea
 dKnNKDUpDvRZxM8y8Xs7R66oE1VPbML3Y3FBRpv139eGjtLq+9VngepUUHZ29tVj/1A7wxfYfqF
 6OetKS1WoYQI4eWFNBA==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6b54b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jkqx9o6u7hr007S5IisA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250071
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

When profiling build of tcg-tests on aarch64 host (compiler running
with qemu-user-binfmt), it was found that those tests were the longest
to compile:
- avx: 1min
- mmx: 8s
- 3dnow: 2s (normal time, but for consistency, apply same flag than
  others).

Compiling with -O0 (default), compilation times are reduced by 50% for
those files. Since they use inline assembly, result is unchanged and
optimizations don't matter.

Link: https://lore.kernel.org/qemu-devel/20260923185725.863311-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/x86_64/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 787a2ca61b2..cfeef1d969c 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -31,18 +31,18 @@ tests += {
   '../i386/test-i386-ssse3.c': {},
   '../i386/test-3dnow.c': {
     'cflags': ['-I', meson.current_build_dir(),
-               '-masm=intel', '-O'],
+               '-masm=intel'],
     'depends': [test_3dnow_h],
   },
   '../i386/test-avx.c': {
     'cflags': ['-I', meson.current_build_dir(),
-               '-mavx', '-masm=intel', '-O'],
+               '-mavx', '-masm=intel'],
     'depends': [test_avx_h],
   },
   '../i386/test-flags.c': {},
   '../i386/test-mmx.c': {
     'cflags': ['-I', meson.current_build_dir(),
-               '-masm=intel', '-O'],
+               '-masm=intel'],
     'depends': [test_mmx_h],
   },
   '../i386/test-i386.c': {
-- 
2.47.3


