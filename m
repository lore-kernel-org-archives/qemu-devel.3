Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B98C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPP-0006da-53; Tue, 18 Aug 2026 15:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPN-0006cz-Im
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPL-0006bR-VA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:37 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGoRt1518225
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=; b=CXfN/trE59seE8PC
 +Ub3H3NiN1p+07xPYGODJ4O5S6xgUy5dRorqtOrPPEcsVYYlMf2YzGvabL2SMVN/
 un37OFwHElEKxsbgKshBiQhLlITgVP2TDheabPyCqacfuPw6rV+GaE+Ux42XUVfc
 6MwEm8JEOgToqHjmrLH1U1j18KDqBGcsveazyV8qe7RBIBuLZQv7dErRATLw0fKG
 EAhTciOb6eHwFcALw+r/tfKx98briBj3fX7CzeXhHsYup02yHIOM1UE5VFKr2BqT
 sWtE1CGRX894T26ArlozRkJNtkzNYNpBUe1YG3GOJOO+ZvZ0v+aAWcu7On2EoM3i
 470Vvw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uab0nd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso1956765ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081014; x=1787685814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=;
 b=MUPK5CLuL3a9OyL+1Zaui4FB8OHOXmXQuredixufMBmM4hm8a96W00nto7x1Sb4sMC
 o4SW2KywjPfAvfibCp7X9h45B84kXc/8jcGlj6GXzfqzpkpj/FfvpSpKZG2DRI+jJCXK
 XFAg8NIOJyevqasditjUtrmmFkuxQMq1SaTTRpVRPys1FAqwG+F6jVWy8pVLU1C+rVbX
 WIwqEL2FK5ta2RoYBL64Gb6wDKvs6mowFthMAb0VgLpmgRUkNrLkqrMXQ2R8zlteh3lU
 Pzc7Dr/3X0Ur7TT3Y2K391pCh8BvfdXmgWgFT+BKTyktebKzBzgIBxv9ZeFntUFaWN4J
 F7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081014; x=1787685814;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=;
 b=QBuCs1Q8r8lg6/KtkhdQTEUpv8El47u/TbC9nCD27wZwjWtgF1jWTGchcYk86qRjin
 je6LL8kE9gUohT5Kiyt1JAYbtbzd3/cyY/8BqpfbiIqPXZUXTtb4gJCfwaEy+wvJHT76
 8NJ8FkPQmNb7xd01GnxlQJYkTvdH3L3gT7az1nRJXbRn9wlTBT97wMBRiLzM57Rjrxbe
 0bvGOQmx+3q8v2LIMdgaDHnAUajOtpEl7vReHqeVviu7XO2yODRmaBzChGoMi6GM23nC
 DGZi1u4G2gNj10XfyEaTPSOWBxuq21IXgDkcdUz4Qowavt97zzwF1p5sg9o7hy45pKzK
 WgAw==
X-Gm-Message-State: AOJu0YwQciQoEeMkOJdRF+WjpW9ZwEMiZz7r790YrsJV7voPFg+0Pvy9
 0KdEqO8hc3mViPmU7OQS3RL5GxwARCy6HSMeXYpcrnjvWLV8vTqZKX4TpItutW2nZDOI5ACNxTe
 YfcUOVpYv9xm3TqP+iHyiIE9maTNmyw7zA1ojvbd92JEv+mcf1pUGlmuowM6Rw3DZTg==
X-Gm-Gg: AR+sD12KVqte44HMSqoK0wH1qB17XLrW+joFXNrWzl8b9wxrnSi7VJhF5po+BzrbGuR
 BlolmpEcSipfZITAZh7x2k9u+LPKAXM0z7DH3m2rQfkO69NFPPd9kpsRkM1dsneaGQkgbFmlQRH
 dACbQUE2FjWzSi9/ubncss71hGc3ujspCQJ3svHfiAzuA5TAuc3gauED8f1JnhWLulJ0XEJXf9+
 v7DeNtjDjvKA9oP3Ohn/RI+uOf7DVvpaGURwBg0dRHERGu/T/iIfObY0tw5/PGbveztu3FAPzwg
 1tsQtKVeeAzzNI5qgNocGF/U7kwmwMg6SK5MAOThiUCEO15wZK1G0sDB/DHhm7TRFj7awxkslSa
 LSJAHTBe8UBtnvP9VeMx9RPjzuwZeSiinBf5jBjWdILmWDEoCS8nnAodUncc=
X-Received: by 2002:a17:903:1a6b:b0:2cf:a108:7605 with SMTP id
 d9443c01a7336-2d5f6cb75acmr677195ad.11.1787081013604; 
 Tue, 18 Aug 2026 12:23:33 -0700 (PDT)
X-Received: by 2002:a17:903:1a6b:b0:2cf:a108:7605 with SMTP id
 d9443c01a7336-2d5f6cb75acmr676325ad.11.1787081013080; 
 Tue, 18 Aug 2026 12:23:33 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:32 -0700 (PDT)
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
Subject: [PATCH v7 010/104] tests/tcg/meson.build: introduce env_var
Date: Tue, 18 Aug 2026 19:21:34 +0000
Message-ID: <20260818192309.22169-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX09MzIT72GNZB
 CUVJdlof70te5IDkjSRyV2roGnJ3Bps5hpR2YApFJJTCu9zoAVY2Zs0aXgaE3Po37eqopq/l7dD
 iGVr4A9lj+ZtaoA4h2rnCm024lFwyuQWNOQJpk9cdFgo84IaWGKDRUwRDEIIIYBDYOT7Hqp6s6Z
 8u1j7kF59wJyOOI8T10aH3+tNfCEHpPa5j+GPqf6onTP0PZPlB6M0nYkG2VO/3hFajpnNxSNboK
 hfWf2HerlpzxFQ41xQzDVSgNkuUgOjGGcmOUv5Fs6vRt6WVvIARhqsLkpIT3fB4x9haOiQzEIu9
 DcGQU8+eQLsAUSTZ8ytG5aAwWbOhGc9OuHdMQlVJHC9/mw/CXUrYLbB2YXlLK253pstVVV6lTVB
 c6slXViptkmulFv70F1Ifd67iglA0bDVL6Sic/oWMlf7H4cmWf9ng+hcwigAvCTO5QOk91WdjAC
 dGa8hUOAmBsJntLWmCg==
X-Authority-Analysis: v=2.4 cv=BvitB4X5 c=1 sm=1 tr=0 ts=6a84b136 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NTKMcpn-bxqVdeGoL4Nd0rVqCsPt-cRw
X-Proofpoint-GUID: NTKMcpn-bxqVdeGoL4Nd0rVqCsPt-cRw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXz7Xi9q4tep3B
 +VSfs5ZaEiFG4ozUjZUuewxLg5yQBbr6Y11h1+HD0mh1Q4jWAVjRrdJqjLyMkicfE22Lg0ZKC4h
 CWsLf2f3Zax1cmO1lLZ6ix80gbdKU0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a7699b7f62d..fbee86e6b4b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -15,6 +15,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'env_var': ['VAR=value', ...],
 #         }
 #       },
 #       ...
@@ -57,7 +58,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -122,6 +123,10 @@ foreach target, plan: tcg_tests
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
+      if 'env_var' in setup
+        cmd = [setup['env_var'], cmd]
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.43.0


