Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEC7C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bJ-000135-Ew; Fri, 10 Jul 2026 02:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bE-00010Q-Na
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bC-0004SJ-4I
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3orq43854964
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lXVGlYz0DTP
 EroHroj86/br4bW/BfcatYJoHWR5m8SY=; b=l0FKYfYl/WijgxE0z1cxzsumCM9
 kq2IjuazGkUFMOfxj8FbFFL0+8dDfnKY3sCXtP8Jrpj7DOC/ziZmy4jRPW42XEWF
 2GarWfvRMxQzp8a1ZL6Aw8t8NvQErMsIpHESq66P60xKcKtmk73/Vf1jDP+vCUOp
 i1eq/SD2r3JEgkcFMU38Fjq+E5RPZKp0e9Ye9murdiAH7KpYdEYwphCyKozgVcd3
 WJekmu4lTryEJNbIyesl+49Yvvoqf57rMBR0tye3q7FIrvxmlmAzsNr5gTAai9L9
 sq41FampuRFTap3jXCGeHwLNjefGM4M+w5mY7sEUpHHm+GlGJtloMNxyHcw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0h39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso582896a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664432; x=1784269232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lXVGlYz0DTPEroHroj86/br4bW/BfcatYJoHWR5m8SY=;
 b=GaMmUCxblaL5zxvetx0EFs3CwiYyK6g4agbqj25T9uNjAipJFKdIZYdQxEqq1/YtXw
 81TpVCIP+c9wjdP5JXy+nJ7zlnnkovQ3zmzo0Y0eG/j1OieLWbriBtmvrvF5ZFTVB6j7
 db2fPH/mrdQ7uTjn18S00vcluaKERph8aKkzzAlRt2/eKVxuvxpK/4QO1x1ivhBSmfIu
 yiGp9/xXMjyixK0M5MJ4mmP0WtZvZzzIpLGHzqhlc8kR7TIFegbcmvb4uaWUoi+t13SU
 iO77flby/IKhIHXCXdxBThq8uvLPfJXnujkdrYgOrN494oE7u6Svgb3iKZ2mvMYuAS2E
 3Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664432; x=1784269232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lXVGlYz0DTPEroHroj86/br4bW/BfcatYJoHWR5m8SY=;
 b=VWu517SvaIuoYd3Pmji+CRKFvba2dsRkKMO5sPcJhQvUvwvtkkRrLLoPC3nU55ogkG
 nQMzMXkKAa4eGCMR4pFdVS7loVKojVuWgmgVtJDwXat4SSJFnXnZwsNvImk9GDMcMylx
 G1BeHeHIBVsg+bVDV00dxKuIiVuLz85gm3inQZTNVrqICrPYt/+pBjpwgQhBTGArlqW6
 k76YNoz3kEs9P4PZMeySt8fh2pshRUYZaaXdkPsfnw6AmY9w43Hcj5sgVJ4O44VsOYoL
 tXs2T/qe7ZQjbYaU1Wpyv4wmHKiKunPXrjMCXWqT9gNxFeLnuW9tIf57s0eygHoZScg9
 yDdA==
X-Gm-Message-State: AOJu0YyVEs7sjg3pEiKsVXXiRyUc5e3sNXVe7H1mHVl8ySXMmeUYlwDy
 YDYaTHcvwApHP7Fv4czDuirFb2fNQz3gdVnF8OyM9N9m0v42+GQrRl/vrvlmIUcPaxiZ5NF6hjp
 mrNKSi8b+hzixWtHf6Lm8WQHFVqhw4oJm4RsEBWJ6NYggio5dHim2oRkIj6W8BgIG+w==
X-Gm-Gg: AfdE7cmy6tf0S3EY6m+ilJ6S3sbNqhULd8TSdhJsQg8Cv9El6x3QtZUkNfF4NYTdVQ0
 IOCnC57WjbZKtWvEvBarjdWkYeVgjPRAZRKNxMtms+UzML5Xiqp3EZsKu7ZA8qnMLt2dhGvsR6n
 9aBmTb3EDkouxT0saMv9qRrxVfnEVAyH5S7abdF6U/yR9BRMXnEB8c6tGZLeeCjeLcVSmS2f1pd
 zC8YVlnFV9DdRebkQUm1aknSN1J2Y5jKmdU34lsFtOSpJo9cT9lAG4cfEpedXj356rCNO/8RhUB
 UVaV7JViL/uOf4m3HvlirLGQn37XlOuv5n6+b0YPDYxDhsNXxxVq38CTzfzQgZ0OgkWc8RD2I9g
 MuohM2B4+X1/Z5sxYUp9TudtnF1DTDOPsQmzCZHUhSlqlLHFvdhVDTzSJgP5PgMZVM2dS0VZMDy
 7KGqerFw==
X-Received: by 2002:a05:6a21:e083:b0:3bf:a489:1483 with SMTP id
 adf61e73a8af0-3c0bd048ae1mr12320891637.33.1783664431793; 
 Thu, 09 Jul 2026 23:20:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:e083:b0:3bf:a489:1483 with SMTP id
 adf61e73a8af0-3c0bd048ae1mr12320820637.33.1783664431074; 
 Thu, 09 Jul 2026 23:20:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 04/97] meson: bump minimal version to 1.6.0
Date: Thu,  9 Jul 2026 23:18:42 -0700
Message-ID: <20260710062016.1818125-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXyMu19S9BsG1M
 PAcvMKlUCI3Uxi2O/1hDM7yX7RK1nI7BYszf0WGN9aAAqFkOupTP73H6y2MqH7imYhJYjl6YZYL
 Q94i0Ot2h6Z0qpdvQY3ufKvRC+5nNdw=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a508f30 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=OdLkAQov_zCaxSa-YWIA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: _Pkk7A8eiDwnNEJX52ZhDEVCcL4dsl-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX7aLgPVaoFStt
 Wgl0kter3uDGZJKeRbWA2iX/4YwOY+YXUS/JO1Et6QOGrkBzg/4oLy6huj4m2hW1kmFDGnFCT2a
 H0D82fJD7ovV4kYsG4YMzaeKgZv7shYDBJ4HL73YM78EHZn7nqt4qpovmxGT9uEAngvj0aLmMdD
 J7PAQuTDloOBuAD/okC8bnx0fmmNBfymT+6UOJHxLu+pH2eZk/zoG3lnJpa9o4eXDx7XkFPRxM2
 U4d6Ef1WV2fC/3c9E1JNEdjR2QNThwMpRMOF+ykW15zFRGVGLoQFCAOTtGI4yD4+oW+Knbk9uzS
 C/b5gmgsd0WycNvQSf7vkPDHsERBANX2ZQxjoiIh4aY3IEphJHXtH5B9kSNuL85j/6P3U8VCLcg
 Y362bIWBeX/IuRgZJ3BnaxztWU+j2uDHUJYVicUeJBk012OpkjcRMGc+HRTdm2JwxxE4Rk0Vfic
 IidiATK0Um1x49xkz2A==
X-Proofpoint-GUID: _Pkk7A8eiDwnNEJX52ZhDEVCcL4dsl-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

Without it, we'll get the following warning:
WARNING: Project specifies a minimum meson_version '>=1.5.0' but uses features which were added in newer versions:
 * 1.6.0: {'test with external_program in args'}

Which we require because of how we build iteratively our test command
line.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                                                   | 4 ++--
 pythondeps.toml                                               | 2 +-
 subprojects/packagefiles/anyhow-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/arbitrary-int-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/attrs-0.2-rs/meson.build             | 2 +-
 subprojects/packagefiles/bilge-0.2-rs/meson.build             | 2 +-
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build        | 2 +-
 subprojects/packagefiles/either-1-rs/meson.build              | 2 +-
 subprojects/packagefiles/foreign-0.3-rs/meson.build           | 2 +-
 subprojects/packagefiles/glib-sys-0.21-rs/meson.build         | 2 +-
 subprojects/packagefiles/itertools-0.11-rs/meson.build        | 2 +-
 subprojects/packagefiles/libc-0.2-rs/meson.build              | 2 +-
 subprojects/packagefiles/probe-0.5-rs/meson.build             | 2 +-
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build    | 2 +-
 .../packagefiles/proc-macro-error-attr-1-rs/meson.build       | 2 +-
 subprojects/packagefiles/proc-macro2-1-rs/meson.build         | 2 +-
 subprojects/packagefiles/quote-1-rs/meson.build               | 2 +-
 subprojects/packagefiles/syn-2-rs/meson.build                 | 2 +-
 subprojects/packagefiles/unicode-ident-1-rs/meson.build       | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index 164328ded83..fbb7d4ac6d4 100644
--- a/meson.build
+++ b/meson.build
@@ -1,4 +1,4 @@
-project('qemu', ['c'], meson_version: '>=1.5.0',
+project('qemu', ['c'], meson_version: '>=1.6.0',
         default_options: ['warning_level=1', 'c_std=gnu11', 'cpp_std=gnu++23', 'b_colorout=auto',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'] +
 
@@ -1382,7 +1382,7 @@ if not get_option('zstd').auto() or have_block
 endif
 qpl = not_found
 if not get_option('qpl').auto() or have_system
-  qpl = dependency('qpl', version: '>=1.5.0',
+  qpl = dependency('qpl', version: '>=1.6.0',
                     required: get_option('qpl'),
                     method: 'pkg-config')
 endif
diff --git a/pythondeps.toml b/pythondeps.toml
index bef88d49a6e..e2ee450ba68 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,7 +19,7 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.11.1", canary = "meson" }
+meson = { accepted = ">=1.6.0", installed = "1.11.1", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
diff --git a/subprojects/packagefiles/anyhow-1-rs/meson.build b/subprojects/packagefiles/anyhow-1-rs/meson.build
index 348bab98b9f..e82b1f20bb4 100644
--- a/subprojects/packagefiles/anyhow-1-rs/meson.build
+++ b/subprojects/packagefiles/anyhow-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('anyhow-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.98',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
index 00733d1faab..267357fa912 100644
--- a/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
+++ b/subprojects/packagefiles/arbitrary-int-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('arbitrary-int-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.2.7',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/attrs-0.2-rs/meson.build b/subprojects/packagefiles/attrs-0.2-rs/meson.build
index ee575476cb2..9b76fe0f73e 100644
--- a/subprojects/packagefiles/attrs-0.2-rs/meson.build
+++ b/subprojects/packagefiles/attrs-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('attrs-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.9',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/bilge-0.2-rs/meson.build b/subprojects/packagefiles/bilge-0.2-rs/meson.build
index ce13d0fe80f..4d4c9bde404 100644
--- a/subprojects/packagefiles/bilge-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-0.2-rs/meson.build
@@ -1,7 +1,7 @@
 project(
   'bilge-0.2-rs',
   'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version : '0.2.0',
   license : 'MIT or Apache-2.0',
 )
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index 04617b875c5..57bdf30ba05 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('bilge-impl-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/either-1-rs/meson.build b/subprojects/packagefiles/either-1-rs/meson.build
index 04c96cc5fb3..d869201e43e 100644
--- a/subprojects/packagefiles/either-1-rs/meson.build
+++ b/subprojects/packagefiles/either-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('either-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/foreign-0.3-rs/meson.build b/subprojects/packagefiles/foreign-0.3-rs/meson.build
index 0901c02c527..80e68967ab4 100644
--- a/subprojects/packagefiles/foreign-0.3-rs/meson.build
+++ b/subprojects/packagefiles/foreign-0.3-rs/meson.build
@@ -1,5 +1,5 @@
 project('foreign-0.3-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
index 8c5483311ed..b9ceb12463f 100644
--- a/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
+++ b/subprojects/packagefiles/glib-sys-0.21-rs/meson.build
@@ -1,5 +1,5 @@
 project('glib-sys-0.21-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.21.2',
   license: 'MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/itertools-0.11-rs/meson.build b/subprojects/packagefiles/itertools-0.11-rs/meson.build
index 2a3fbe9ee5a..3081639890b 100644
--- a/subprojects/packagefiles/itertools-0.11-rs/meson.build
+++ b/subprojects/packagefiles/itertools-0.11-rs/meson.build
@@ -1,5 +1,5 @@
 project('itertools-0.11-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.11.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/libc-0.2-rs/meson.build b/subprojects/packagefiles/libc-0.2-rs/meson.build
index ac4f80dba98..d1a9da194da 100644
--- a/subprojects/packagefiles/libc-0.2-rs/meson.build
+++ b/subprojects/packagefiles/libc-0.2-rs/meson.build
@@ -1,5 +1,5 @@
 project('libc-0.2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.2.162',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/probe-0.5-rs/meson.build b/subprojects/packagefiles/probe-0.5-rs/meson.build
index e6ea69533b7..1d33800cde2 100644
--- a/subprojects/packagefiles/probe-0.5-rs/meson.build
+++ b/subprojects/packagefiles/probe-0.5-rs/meson.build
@@ -1,5 +1,5 @@
 project('probe-0.5-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '0.5.2',
   license: 'Apache-2.0 OR MIT',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 8ba558e1330..523572173c7 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro-error-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.4',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index a85d7c07143..85f190e56e0 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro-error-attr-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index ba7de070292..7cb4f93bb08 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('proc-macro2-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.95',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
index bf41fad99bb..fdd549e7648 100644
--- a/subprojects/packagefiles/quote-1-rs/meson.build
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('quote-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.12.0',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
index 3e6dc318a9c..a7baa6feff4 100644
--- a/subprojects/packagefiles/syn-2-rs/meson.build
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -1,5 +1,5 @@
 project('syn-2-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '2.0.104',
   license: 'MIT OR Apache-2.0',
   default_options: [])
diff --git a/subprojects/packagefiles/unicode-ident-1-rs/meson.build b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
index 11a5dab97df..ee483e13423 100644
--- a/subprojects/packagefiles/unicode-ident-1-rs/meson.build
+++ b/subprojects/packagefiles/unicode-ident-1-rs/meson.build
@@ -1,5 +1,5 @@
 project('unicode-ident-1-rs', 'rust',
-  meson_version: '>=1.5.0',
+  meson_version: '>=1.6.0',
   version: '1.0.12',
   license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
   default_options: [])
-- 
2.47.3


