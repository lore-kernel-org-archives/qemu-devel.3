Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A891BC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1d-0005DL-0S; Fri, 10 Jul 2026 17:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1a-00056a-UV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1Z-0003UX-Cp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Uc71752826
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M85wKm2rDxEWg7Na+MjBuWpOW6hY1FLQ5Zv/wM7+Q78=; b=RckuBu5pq0yM7IBp
 quTdnPqnxUET10tFzYYoaULJxUqvOdRPcRDve4xUPDqk2mLwkcfOlxPG5TvqSfzR
 e2iyiB1r6A6dgo/mbnYj+5iB6ekxFspv86EsPK2L+qA05LqWBVK+PVHpig2WqpWE
 qXWcCaMuzlBOymf+MZCRcoBwTkkatTmTpvPGQStgoE8k8O43u12KJAIHZNLXi13Z
 mIpFgZay9UBLEb0CD6LRk1Bggo9Cii6Ig8pYd6TihGtDJGmIMXMNotg51MD2RFqz
 Lme7ykbdqpbBtj4icITyRF38AbbmReA6wNjYya61B0Zw720L6a3IrG5q0umiLdaD
 wDKQ9w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9gjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38db4fa2e25so1133445a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719873; x=1784324673; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M85wKm2rDxEWg7Na+MjBuWpOW6hY1FLQ5Zv/wM7+Q78=;
 b=bHmTuzC24/aTfW6Ovt2Ey6Ew55oHaS1dxed4Qh3OAhyLAC/m8i+BqTIXcqDvGkKC7F
 ZWHj8BinU4ll2GCyQ1W2wzchvEsOrNDYYl9hrJkbc46IsTINf764fYer+b5eD62hYmm2
 cxopoD+7Ef9HIHiqhH9KNsmlH3nvGHdTnSpffjazBWZdgZxguZAHn8gp9N6JSck+JwvM
 ymPnuaslisRPV4o4yC+GDXB+2SdoH6/mz9M1oKW1LlZ0fOMMoF3vuVFaKrwpzB2S0v5a
 AN4X+3MsBUU6HrIbAke3MYm5yvd/GUM5lH8UJtbEKvst/WI/oZXMcZFdXbpoXKwUBqpB
 fIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719873; x=1784324673;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M85wKm2rDxEWg7Na+MjBuWpOW6hY1FLQ5Zv/wM7+Q78=;
 b=oX9aMhKj3wE6BQelkZ0vR1MnS2LqMcLO2W29FRdPXXFUW1k8Zg8XX8r/rL82zqPHSZ
 Zm7E1YCCGEJoQ1YFmTHSi0mkyxYGaRuBlumcv3gQU7jjMXjrxRrTQWieJ6ACp8b2X+Cx
 96qrEHFrDYGbUSgxZYcc1oyicr+R4I8VK/0Q9euLlTU3bHqk5yLc+/C/JbcOUw2KXi6J
 QWdBNcrAUr5rkrZFkF6AOWmSgVgnXGZ4EM0VBpStIJL2uQ4p8pS4RwVnpP8OXbS8Wxne
 v4PbpNyucdFFHnIw9n5tbDnkmELlDdNg1If4kBA4P2pC0VW9BXNNR2K2naONtnT5c+CL
 k79A==
X-Gm-Message-State: AOJu0YwatWNI2XAezZfFBwrhcBnVnJqguWdNaC+4qTrR4y2D/VXBvyZH
 471NP0PFZi4Tp0tJ8/B1RuKBjOeFDnyGFK4ca3gHbIm8i3fxWCDcacWCtWKmMlvkh6yGdCGc8ay
 UjzXJeGTpwf8sxh2W3DAFzpiYrkoh2GNCg1glIc2YEkHcadf4p8ybrCrwrScgPAYb7g==
X-Gm-Gg: AfdE7ckO05e5AWhUTffvb9V4VlRN9a5cAJlg2TthVOMIoku8kheXjdijscW2hQ+Wwqn
 dMYRMRTRJs0fpXqkUcJm9j7lxLPXMFC2trlBSUGIPTUk7nBIz7riLMhYAGgjoMhTW3lbjOeaiB0
 8lduUCUSD9Z/j+ejtFeC4TyxNNXA1y6M0p0d/Qh3MRyjXUUVJvBH38iChPwewdimx1nsuSqTH/N
 IZijXpdqSas2qDl7Uk6YPSHNh3wWFSe8H0Ix+Lkl9yb7IjPq/0VGADM5gfCqjsIcKCAeGMQMBBh
 jr/zfUJt2T6zcTOeTeTajrp++q6lgIkSsJB8/EY0w+fpeSceGaDXnYhcT3i7AB80aI/bi1JXc0w
 64wkYxRvKNxAa3nHEx9GTTwBIsQGnbfsBc5cAfgAC/tfkzIhNF8kOUxXJhsnD4bFlhjsN/fjwB2
 QiS4S6tA==
X-Received: by 2002:a05:6a20:6a25:b0:3bd:203b:982b with SMTP id
 adf61e73a8af0-3c1108af77fmr695782637.16.1783719873449; 
 Fri, 10 Jul 2026 14:44:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a25:b0:3bd:203b:982b with SMTP id
 adf61e73a8af0-3c1108af77fmr695765637.16.1783719873053; 
 Fri, 10 Jul 2026 14:44:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:32 -0700 (PDT)
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
Subject: [PATCH v5 21/98] tests/tcg/meson.build: add logic to skip tests
Date: Fri, 10 Jul 2026 14:42:25 -0700
Message-ID: <20260710214343.2065491-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxvvRu/dIcoBV
 FF1jGL/vy1war5mXTi5nC6r3YBEr8w5b2FYE+jhFEcige3MT5j0PD7eZQZXbNLW4fzip7ok1E2V
 JDb/ph2m8lEKX/CFiJgwQmWrJevn7bafsesxqftZVXUk+1TfCBL2gCxgiM16bQ53ox+CRzms8T1
 7aZtJyEFbFxTf7UB4XCK3vHMzJzN2qmZYaxDL0Hk03fQBS+ZXgxJDi2ANE9HEt0VIsJI3vc4deU
 Sm/mu1iAA3Tg3hVl2QD5AT2xHMbdgvNqqaLqDJ74IVKfbGi5IdWqoV57PXBv4YJOzpSKm/cFDEF
 MiEux4QTt1lNW6sInwX5KvwBC3DSSy5ZuJpPawkFIp8vxdwS5fZKd8kJcuf1nMCO1f2D3kmVon4
 3BDPISkbedOCMUr/bkIAg1MFGPWAk38v3+y59k/I4K/ntpGtIPvuVchMhHFM5fmHjXOZvPYYkG6
 rM8b0+TITY0JA3eUsvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX1bJuHK3N6yRx
 mzlPEWy4x0pvWoDBmAay/sxyzviJcj0Dtgjjh5fSgD/emYPr0RAWRgkXA86WMH/GzdS6kIp/RKP
 SBVAevlep6ArgSWyP9Dfck44ErchV2E=
X-Proofpoint-ORIG-GUID: zb282iHfjwJlTLx-vMGSZh-Kbs4JkPzu
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5167c2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zb282iHfjwJlTLx-vMGSZh-Kbs4JkPzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


