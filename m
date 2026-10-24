Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17423606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E+pDtewh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kiv3t8o4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKVtn-0008WF-Sj; Sat, 24 Oct 2026 03:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKVtl-0008Vp-F4
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:10:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKVtj-0000Ll-OH
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:10:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O4dj6U3321644
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=b6eePErpjRJ
 NzkL1I7HS4Gn93oByi2E9DM7xAW/X/Hw=; b=E+pDtewhtPaYWtYuDuFvVn5kU79
 j7GiCnVdgc7Xzksl/0ItNcFdichqXXKVYx0N/jss2s8jjocpCebiM7hoPbs9deob
 rg4RuVfDTAMzi4Yfi6bN0UrZ+s7mLN4fxdakbo5ZQbOFBKTJ62lJ0CXG+HngN2aZ
 vXVPZVIOYJeDjgzUP9P0sz8qY827Cdv4SSp4tkffv7U3nBTpdlzQp6QhDuuXrOZd
 2Ao2Nt4fG13CtAaXrtFs/lHNHwSmbmyBNHHZmV9Wv2+b+/2QyFIOh5dknGe8FgBl
 g0GfLWTcz0wp0dCBy3wx7uWIMqTC/wiLEx1hCIiwpH59q9+y8960S8CMeSQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnuk88qv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 07:10:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ada8bc8575so2298795a91.3
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792825833; x=1793430633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b6eePErpjRJNzkL1I7HS4Gn93oByi2E9DM7xAW/X/Hw=;
 b=kiv3t8o4YGRhtzEOJNJ6UChJKrTz2eB2rNK9U/mBUSk6BWL468kdc5DgJS+OYsg471
 Do8C5x9UsYD+ug7z8Hh8BCPDNANmNqwnRy/1GBzEUE8NMu+iWlpU2ihHw047+9bNb/dW
 CVg6qFQbPH6Ddq+P9pQYQTEJ/rRK8sjJZxaesuAFRvX9HYFfwZdKlvhc5Ft9ze7SQElp
 1ZrtxUH3YsDmdVvorKV04vXwYIr631P37wMBL+WXasX6YnB9raKTCQtAc7J+MpUXyswr
 7ImXcfDPIzjKime5wWvB6SMkb5TQgfInIEQHW2XJF63BBod7HKBdZU2d9ySjAiXPAlsr
 O+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825833; x=1793430633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b6eePErpjRJNzkL1I7HS4Gn93oByi2E9DM7xAW/X/Hw=;
 b=edSclSelAANxVwZIZYJvJK00ZAd8QV8ETgXteIEPU81L3CGpEfgBYJwk3hndhuNHNh
 cG+ebWK1lS6TFWszEZezq3IaZas90lVzDn0yEd3ZQJRtSjint02qWbaJxtBnGKhaDNkN
 88mIpQPcexGeMDP2zk3NKlD1KAZlUDE+YCWuI5YNg0aA8W66Mg/sdff2fGrcR+W6SE+t
 ge8M/rcCoj+b41/S1ulqtmdcmjzj+NUYkhh8CPZSUC2Xqe65bOs7YLo6uG2T5J5IebYE
 EX8UTya4mNWjxOAwMdvlv0jUk+53qS6EgfqCKg3SVEiSSpH6ePdEX0ICdBI2Xoi4k3p5
 pNGA==
X-Gm-Message-State: AFq9FYIgeD4gIEcWr7UmKstCnzd9jZh5tLvM3UNM5jLsW1SBQsuQfWvk
 DVk0kW24ky7Y4ri5v/laWDokLksdDZxulsqxI2Vb2nljaNJ4umXJJNfas6ykNzpuoIS63Y3Yrz6
 vKJvfgSNV8KKlB8ieVTYN1ncH/Fjm9sh2d1P/PVdoEqjRBGl4Im9Gg+J+E0Elju9KOg==
X-Gm-Gg: AYBFou0QLnUAaaeMVfg1Fzc9SIVJhjDAHjxtIDGmcR3Rv1naj6sJYWpzVyIgzP4n94p
 mP3nH8vsiaVdy9scJssopHz41p152B3a0m8uASkrPAvUvvKldIJaNjB5492ZNHDOW9mvvGPLmxa
 CgmIahwVy+4ZvmC3/46BvxMMGuRPfuF90Se6ynxlnxso9nyaVqePxtKZslTQWuiZC/7jd3WVboV
 bf9x+HXqDHYdnYFf0PvNDqPxQv5KLrKj4XZbXTSSLnO9nS6Qs3NiV9vFcrbbzfn1I2ShuuZxzdN
 Sx6EBnKUPI/wYWC67zTzewXQvrQBHab9URFAJk7mjfkk90mUelfAsv90g85ubQpWJyam2eARRp9
 85CwV87H775VXo9+Kt13A4uMKl4pK+jnUhbyXWgoBeQa5MIY+LvznvBuZz5JS6Vc=
X-Received: by 2002:a17:90a:d444:b0:3ac:9f24:44be with SMTP id
 98e67ed59e1d1-3adead48632mr1215112a91.29.1792825833270; 
 Sat, 24 Oct 2026 00:10:33 -0700 (PDT)
X-Received: by 2002:a17:90a:d444:b0:3ac:9f24:44be with SMTP id
 98e67ed59e1d1-3adead48632mr1215092a91.29.1792825832642; 
 Sat, 24 Oct 2026 00:10:32 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0639bsm1936919a91.12.2026.10.24.00.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 00:10:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/3] tests/tcg/loongarch64: restrict gdb tests to gdb >= 16.1
Date: Sat, 24 Oct 2026 07:10:24 +0000
Message-ID: <20261024071026.5092-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024071026.5092-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024071026.5092-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Z8Z5j3RA c=1 sm=1 tr=0 ts=6adc59e9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=e1-sUNc-TyRcsT6M2wEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: abN6evgwKbdONFJ1vb9n0VEA5ktiEixH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfXxCCb+5cHAc61
 QoTgjtu4tnlFYWzHq8VpFSS3AHagdgm+iYNb8DL1P0806VV/EGljLA3Lzm20URKkCKxuDUL0G4+
 HLOF886KioV4E65nIIiyTYG/HozEfEWo1TN+1BasfUv1UMrWwJIGszuwvM7pGND8PCVQeFHnl5B
 9wUkSNayjnwNhEmHWwcpGvxwoIq4vZHFLJHoB7KUHad9k9T8uXw3C01uwnrrN2bjKOOsn3UJgIi
 PskBvsOZqJFQXh1cNLEIjdKQ63rR1veu4TjX4jJJ6He4Z43YLHIdTwgdu1TSZyH0ASvAxw+auZH
 6VKYZsECioHQCypm7ZXlgzk6Vibau/MNocZxId+mMkGz7wqrtg230qf2v2Lu8m+bkNMgyA4bimZ
 0qCUbXlls5BJcPG1c6LKO9Z90UrfV5PSPfHEfBdRo9hL6PP4I3f4MURRgEpAEB5VUF6wbSfR1bJ
 iTi46t6lM1F/Wiaz45A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyOCBTYWx0ZWRfX+7lGFJeoRD9v
 Po+2tA7eMpidSyBCo5uYyLJgc/0lFoEYvo4U8oeo+I4ajR/51yIvaAUCN8hdoWTMd9NtxSg38BI
 Zj0rEHDJIV67tYRG6W4W9YORukoebhI=
X-Proofpoint-GUID: abN6evgwKbdONFJ1vb9n0VEA5ktiEixH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240028
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On gdb < 16.1, there is a mismatch between our gdbstub and gdb target
definition, visible with gdb message:
warning: Architecture rejected target-supplied description

As a result, loongarch64-softmmu-gdb-memory hangs due to gdb not
completing a requested operation. To be safe, let's restrict all gdb
test to this minimal version.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20261022201733.1941651-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/meson.build        | 16 +++++++++++++++-
 tests/tcg/loongarch64/system/meson.build |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 4dd64f16d87..bff30cb49c8 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -1,11 +1,24 @@
 cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 
+gdb_feat_version = {
+  # previous version report "Architecture rejected target-supplied
+  # description", exposing a mismatch between our gdbstub and gdb.
+  'loongarch64': '16.1',
+}
+
 subdir('system')
 
 tests = []
 
-tests += tcg_tests['multiarch-linux-user']['tests']
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    if 'gdb_test' in setup
+      setup += {'gdb_feat': 'loongarch64'}
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
 
 tests += {
   'test_bit.c': {},
@@ -23,6 +36,7 @@ if 'qemu-loongarch64' in emulators
       'cc_dockerfile': cc_dockerfile,
       'folder': 'loongarch64',
       'gdb_arch': 'loongarch64',
+      'gdb_feat_version': gdb_feat_version,
       'qemu': emulators['qemu-loongarch64'],
       'tests': tests,
     }
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index d1ee3986b62..0f81ef9cfe3 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -30,6 +30,9 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
         continue
       endif
     endif
+    if 'gdb_test' in setup
+      setup += {'gdb_feat': 'loongarch64'}
+    endif
     if src not in multi_src
       setup += {'cflags': [new_cflags]}
       multi_src += src
@@ -45,6 +48,7 @@ if 'qemu-system-loongarch64' in emulators
       'cc_dockerfile': cc_dockerfile,
       'folder': 'loongarch64/system',
       'gdb_arch': 'loongarch64',
+      'gdb_feat_version': gdb_feat_version,
       'qemu': emulators['qemu-system-loongarch64'],
       'tests': tests,
     }
-- 
2.43.0


