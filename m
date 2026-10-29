Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D5606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jhhQKKcs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tz7dMN6p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRvq-00085D-TW; Thu, 29 Oct 2026 11:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvU-00082N-Ih
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMRvR-0003di-ET
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:20:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TCeWKo120284
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1b9R69wxnrm11xsTFBJRJNmGAsSY76XJjIwRw22joHQ=; b=jhhQKKcsJJyYHsYt
 lzjoRZShgGdzZctZJjWyyjIPJY4EZlHThgDabL4K+G6CBaOSQkSnZ9UuyU4kkLfo
 P1BJ6/PX+lFt8BarFSFfxeyK+7KYaQRet0d3poMaLaWlCh0/UpMdlBDHn1Xrg14y
 uv6nzhIUIDOgyoOi9ziHCIoj0AWjByJO280SGwm6WiDTUiGDX+fJ3xQRSEXo7r5/
 2JgfbgltGBO15jo125efgDAuTRtGYso4rYmpFM04SLqbIYEuDi6s+qRDDSEbm8oq
 Ap2dtRUR2TPDA1/Qfwf1liXA8m0/UvPMYlG/u5QM3/mb8FADTs4c1IrMFrAr0PCL
 HETbBw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkut3k0yg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 15:20:19 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc4149b885so1880696137.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793287219; x=1793892019; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1b9R69wxnrm11xsTFBJRJNmGAsSY76XJjIwRw22joHQ=;
 b=Tz7dMN6pINkiaoQ1i+c96H3W6xOIGTgKwBnW+/215tKyi9+VGf5GxOgC+BErdplZ6E
 6iF+bISY2hP6as2k69JEO6XWYHhZjkZs1lk26UNK+J+qO1Ev9vThdiEag9tmw93VHxwR
 8/7i4WIW2SWlIh/Zob/uWpYrUusO0SvK7FM4ltH8MvzWLgvVbyUduQlo3F6gb06f++fi
 4BTBxevu0mhHOobEMC0RYYlUYGZ0zkTB8bXSCGsWy5wv/Trl/q6AJ1wY6D1Fk3OTha48
 IAyMrsiLQ2QUmmhTpwzt307NcnQrmOGRrZJ3oifuKzHfKIHHXpOAL01UtUvhcJ1V9KRr
 /Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287219; x=1793892019;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1b9R69wxnrm11xsTFBJRJNmGAsSY76XJjIwRw22joHQ=;
 b=AQCqnFedErmS0Wj0oCyFwzRLh991pUTTa5ecMxX8oSS+/S/V/GfNG6YXNI32uFLeuI
 2Bj2kGTolZAPeN58IBMF5unRaTFDXlCyf5eDiY9VkAgrcnLF+PFAaKnJ9L9MjN3a+ezA
 qkm7s5pJATRuKFn4iPiiBHaXH3uLAIhKQzi2O0NHf4vEf9vFr7D1u7YAqxKJnWLZpeNl
 yYQ8gnzkYaxKs6KNBDycNb20FNt2M4gchU2yNfCrbZaOaHHjkbse2qxx9IqfSVI1sIXM
 mey5l190d/EyNH5I+bPiZu8KRYKWriMatY6z3JZWUfPA1u3peh60XX+8k0d6letOjkqw
 A9yQ==
X-Gm-Message-State: AFq9FYI1De41jK48FaIffj2RVeVNh9B0qihASdqCtQiR6gQYP9SKh6u7
 kvK9hpdPqgVilZgmfnM1cBHhDcJMahoBTQRYA+jCuZcqVJWJQkSw9VcU6KlDuQyVFlV+cF+Rtec
 B6UEbE0MeWljFXdLh6GYpiB2qI3zdy50S3QryzwoZBJe5DowGMP0rjJpZT50xuKlkiJNM
X-Gm-Gg: AYBFou0UDLpCzEp6zBQIl9wAFRqt1qPwmsRRoXoL1qv03zWs6tdb0+Sk0TCDKcMDXdf
 YLyogDwE78PvfgbgPxRlBC+evXMuu8j9HhRHIykuNZCo96qmYmrWxAUX3RHvYvO6nw5DEAZNoCQ
 WeoYe9n14+mdOQkWNXNzi0jEHDx5loDtNkbv2yuOrucaQE+CH/Hre74avaK3eOhwqmM/MVOkj97
 WZUgtnHOjnZBNjrB7V9mYetE8p0Q3x+1pt4z0TxkElXhzXyvBWs/py6HNVVa0n9p14Rc4+JmIoK
 V37TKstRYTGG2S78BcWzjgzWR3lTI8BluKtyWd7XpklCTQYPGhSdyuiIctjYr3+nhBhYa6c4vGY
 KXKewgPA3qwyIJJXBH6wd45awFAWnd0LqCijgP9Ax1cGBDdwLEJa5suADFYL5lDEbFHraC7NeDw
 JxNUBt0R8lfqhCIeC3TP5Ik4pVLYjXgg==
X-Received: by 2002:a05:6102:448d:b0:7cc:1967:5e3a with SMTP id
 ada2fe7eead31-7d03a5e4ca7mr3157154137.32.1793287218925; 
 Thu, 29 Oct 2026 08:20:18 -0700 (PDT)
X-Received: by 2002:a05:6102:448d:b0:7cc:1967:5e3a with SMTP id
 ada2fe7eead31-7d03a5e4ca7mr3157132137.32.1793287218411; 
 Thu, 29 Oct 2026 08:20:18 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7fdb75e0sm72311135e9.10.2026.10.29.08.20.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 08:20:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] tests/tcg: Allow tests to report results with TAP
Date: Thu, 29 Oct 2026 16:20:06 +0100
Message-ID: <20261029152009.19812-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029152009.19812-1-philmd@oss.qualcomm.com>
References: <20261029152009.19812-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX2zfGouhrMOxL
 2SA2DdlNTKYKIqUAY7PXTj2DA8tm1KEblU8NktMTTPh4B5l8bNDNL5bXnpMr2THrAa9MRUvCoKY
 yy1uDVfeapMcDQCKJZEYoNEVc8uCuOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MCBTYWx0ZWRfX46NbzS4u0FSH
 qOmSnsI9jEUJKu/P3PLGoi/RHsyKOTmCon5KFXY6VA7WKVDyzFYX5IMq0V1lDLcpsJ851zlQN17
 wZGcy09x3f4AF8eudD7LEdwX88DOHAu4Sb3PskPxhuJVQDwCTi3x7x+JdIWy4OVdh/QDE06WgWY
 qlFnXyTcfW2QHxSNI9a95QzDmkYxkxIvu7D5E+McdLUQTwEmMRzyO9HdZeQYlloeiGsFpyUHl8r
 OGikicBF82fOfdq2qFliHbTdXzXkEkXtzARLzA8OeANLXBh7XJFzDfQTmfx7kANe/KKNqCieZug
 zeBrZIPfKyOYmIhAraxLcC4OZpCRwZyYKKIUr3GcrqsFfbolzFquB2LkzTtmE6NodPyhVHzTJAN
 zp678tywgBSmnaUw474KJQxdH5HMoDPR99BZcLBOPiHw0rCU68je0TT3CDvT4mKeN8GlHkWlVjQ
 MtYmWNIkAOQmYiVmXQQ==
X-Proofpoint-ORIG-GUID: S6KTbGoLuhY-SBUOBnCKGrYBTR0sb6RF
X-Proofpoint-GUID: S6KTbGoLuhY-SBUOBnCKGrYBTR0sb6RF
X-Authority-Analysis: v=2.4 cv=HYSB3SE8 c=1 sm=1 tr=0 ts=6ae36434 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=QNv39Vzb0ykFVVrKWfcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290060
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Add an optional 'protocol' setup entry, passed to meson's test().
The default stays 'exitcode'; skipped tests (exit 77) are forced
back to it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 06f013fbe3d8..6666d0dcea2a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -323,8 +323,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
-                   'test_name', 'wrapper']
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'protocol',
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -519,7 +519,9 @@ foreach target, plan: tcg_tests
         skip_test = 'gdb not available for ' + gdb_arch
       endif
 
+      test_protocol = 'protocol' in setup ? setup['protocol'] : 'exitcode'
       if skip_test != ''
+        test_protocol = 'exitcode'
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
       endif
@@ -530,6 +532,7 @@ foreach target, plan: tcg_tests
         test(test_name, env, args: cmd,
              depends: test_depends,
              timeout: 120,
+             protocol: test_protocol,
              suite: ['tcg', 'tcg-' + target])
       endif
       added_tests += {test_name: true}
-- 
2.55.0


