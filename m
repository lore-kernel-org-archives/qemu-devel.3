Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00D8C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPd-0006gi-VH; Tue, 18 Aug 2026 15:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPc-0006g9-M1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPa-0006eL-H0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH7Vg2286939
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=; b=OhgAvIStkAWnhDfg
 cD42JCpJTvzxvr9v67adT/hVFRIBu5DspDEcMT0lhpEyvx+oTlcyI6O9ulwgG2NC
 pcCxFp3rTzvSQaX8Vs5amXt/tI3cWHbv+EGdnJKhHU0wmtH4jjDXjbTQr1k5g589
 OdPgMp0My18fEIUowEpqjzm/91peoMQ/Agkbydf42N0U+xycovzGiuASVyIORxax
 zNdEe3rcVREcPxIZKzNjH6Hcx68ij/KsTr3AH7KQsQER6a7qNM6yny/0b11njFMx
 dwNFf/xIhJ8ZHbjNVUBc8iOFlS1cMZEAI7jbcnnKrPXsUK3ulA+tWxBH3tlAA+0B
 +JovWg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uhd0p81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cacd6d37edso2353075ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081028; x=1787685828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=;
 b=QbJ9aTx53FjqVWL1jSL1iyK0Bk60oVNQV1MauaeC34lo37jWZ4x10dGhs2AyvMtCg9
 38RvjeCt1O/XymxD+Q5Ia8akN3haZaRTjpfWiJiroyUcp73CzmPzoduhOPozKQdWBPTm
 Yccm8aCpc9rwlMqur3OYIxnty8BKCBkWr5AQNn3r7+80iFehWL7lpbEdEO6Ofy1/xcA4
 +jW1SU/DrFcD3Hqu4XWJuaP/24FibL/7NS5pRPW/WgXTzIqXyeHWtbfkbBuBgqB6NdgQ
 92NqN/+x8IsID7ysvgsR59W0nidxjjG6CVHYx8vnX5dNdyoWxWLUOxQwgjotzfMOwsSD
 nXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081028; x=1787685828;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=;
 b=GLeggvF9c17N269kOMdT0PYuCQCfv0XK+ISC0/gbU86z1cGfBCdTrEXuKmGhWHxvqM
 EMhCI8m7R3hnBdbjxQsd9dVjrnGNfbKSjxqIU1UemaKLA7gmLXhbzPEs9gLV+NYXl4lw
 HpJ5TJ3hAFkfW9/bobBOflqGvgNbP1r/gamy1xpxSH/gpDwnAuBj5LrIKFrNYHYx0ZMe
 Q3vpxwpH1JZS+mlW8Z40eZnp8bLm5qpb2to/QwXy1qm84ZYEAEXW1Y6JKjcYvP2gU6x6
 INu6G9Ehay8ay/1uesB8BuP2A16NU1D23YAsjcQi3HsycDrBjpDCSx/C/XjIzAY9YfDa
 zaDQ==
X-Gm-Message-State: AOJu0YyMFT43K2j3FOtnJUDaKvlxJlA05dU4SnbjExslAD3VEJgNuYn7
 kORxBLhFcAlkITLkDyIT3ISFuPz22vJiLNAlJo4fVCFd2LkSm+tF/3izWkur/95LrWTWE1I3M4M
 ilYvXPEfjCWauZpvZ7EfAzvUId/bb69JUbmfwTunRcGEM6MMtPdYy1ImSGaas77Xmkw==
X-Gm-Gg: AR+sD1142yA6H11/vGrbpipeBv0P7VkNu4qiKsJLjuY6xI3H6OSRHrcSjoAQDo2OVwN
 Nd9qAMs738nNzWhd5Bp73dZ5cl2ZH4q8KQyDke+HXQoG8+qeGLRUqvqrRxQubR0JaBJb4yW7SxS
 MeUKtBrP0barmabBS4o8yhwYA6fw2b5PBRcVKBRzBq+611qiiIattWFz/gUsO+ELw9cnlarYNIw
 bj8kJw4UTQDa0mUg6KjUuVAKBmc05Eje0UQYHO4x+BNFv1nUexHC/q58Z6/HFb9/ItYgK5pP7BI
 c0RSVwm5OklahzVQ9f+v4VVr3Xtmta4jH/ZkBDOd/JAhbZbbvSbYxhnJ1YHcSI8znwdS421CLZG
 dEVKlblr+IdHLzs0WRQnpcg07B6k/qqWsluU/zEaTv4+oDg0Rpjfwxg3iVCE=
X-Received: by 2002:a17:903:1110:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2d5f6d06364mr469185ad.8.1787081028447; 
 Tue, 18 Aug 2026 12:23:48 -0700 (PDT)
X-Received: by 2002:a17:903:1110:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2d5f6d06364mr468445ad.8.1787081028067; 
 Tue, 18 Aug 2026 12:23:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:47 -0700 (PDT)
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
Subject: [PATCH v7 021/104] tests/tcg/meson.build: add logic to skip tests
Date: Tue, 18 Aug 2026 19:21:45 +0000
Message-ID: <20260818192309.22169-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX78Ei+ul6jRC9
 ghFTQeAy98GhGkX8qs3fFA9/v/qCNqoxrvuQkcVYJH8lk16sPY//H1toR88Th5h9s6QQEXjeWFH
 SisBEbSAwqVRpZDrdnY4JpaaglZWnXxRufVArAj9vT/y/+EeynopBO95nI87WgY9l5u++MzVhGa
 h40YVO2zQ50fnSmOdJdFpgS/JqzyjuQm0bH0rPZiHJwxKHuRxjv0MvUE06jgQk+ePVb/eeNBWBW
 CqrAcO89wVrTDKWv0zkIYqKQNYhk+S3zjYRsuz5o8CCcixPJftmh8s85JDCcBiFeslrSfA0q2GE
 SMY0B0mka7HKN5yRuCXY6M0eukC3poPcsK6JurXiUWDZWJ1uhqmqULmQuD5qoY6mfoKO3qXQqhG
 UdF1O94FhkOdZ8l31XOKWB2ZI0R4cFJBdF6fNAH7588cne8GdS8p69ls5Erwv8GBNdLP+h/JFFf
 ru90hqsYS4AH6tutlUA==
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a84b145 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Ge5SdhGJfqUYm85XP9UCS-vTx9Td2BH0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1QL+ZzyN0/px
 Pk+abJr9g3u872HhZoPDJYih5QwhkgRpTOiOVuy2f9G0Amc/YvfbcdQs1RGzRw9hCFmQCrHmvxg
 RXPFZryBjkTrvs3FC5H21S/ctUjRDHs=
X-Proofpoint-GUID: Ge5SdhGJfqUYm85XP9UCS-vTx9Td2BH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 779f9043abb..7b60ea53825 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -114,11 +114,15 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      # if set, we'll skip test and print the reason
+      skip_test = ''
+
       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
         continue
       endif
 
       if 'plugin_test' in setup and not get_option('plugins')
+        # do not use the skip_test logic, and simply ignore the test
         continue
       endif
 
@@ -226,6 +230,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.43.0


