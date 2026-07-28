Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA82C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZf6-0004QE-VT; Tue, 28 Jul 2026 00:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZez-0004MV-IJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZey-0001Zr-3s
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46M5Q1820990
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RFjVJTQ2D0Wts7nay7wAsDwJ8itGt0KQqTQeD36rVUc=; b=E3Oa4qTm0LwuX0fQ
 I3AQU9hvzURqwPWtQpPQ7J66IfT09h5jJI8bwJOswYq60Oxsh+c+7JSHgb76UxSm
 TL3iIQdj3Gyq37LZ4y42nxTi/XR3fJmJEhpB4+s1rLsCpOKTBpm17Sw+9eydQ/J4
 QvW35xmC/ZhqDomGsx+MJKRxYA6065CnPkx43z4+B8qA3kt9btn2avQQkszuOF+m
 4jeMMElwQ7sik7oZzp77/GA+l41W2QXt9mvB7IscPS26dbZ314KPZx0u/czt4MHd
 QDoq+magEg1ApOFQvPkhtvySy00qE9gSmyvMxVKYlX+vDKJtnlP3jD5oQbOapVIH
 6vc3rQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y03ea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso3572610a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213798; x=1785818598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RFjVJTQ2D0Wts7nay7wAsDwJ8itGt0KQqTQeD36rVUc=;
 b=GLKQ5RPrjkZ6Obcd+0JKylaxjAYE/EbUOYkSWlTH3L30+qw2Ta1Q2ahvpM9l81CI2H
 v8T960onquHZxdvG1iKRZFivM7yq7RUNPrIXxae9OLYRJ4yOoXKjGlKtgExtPGDm4Sfo
 9iSY54YVDeHPv6u8NkGSx3jNfIL6AGlSVDmxI5kwe6XGDUqsCug3DDpqUr2JyWpsAMqc
 Gn/rQR05h12u/uogzoPs0jKtx7JmL82q52KpF8HLvNCJzXDJAiBXA1VjGxruArppEIUy
 NFT8xfJeuf1878pI45L/+m8de3c2ixACSA9riFgQCfomNu26Bc1zQFPFeOpKtlmyckah
 87IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213798; x=1785818598;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RFjVJTQ2D0Wts7nay7wAsDwJ8itGt0KQqTQeD36rVUc=;
 b=qiQDVbbrv+qq1aOp3jS20lzzVvztcqDGg9MME9iuYRKS6Qb6kLyJhjZoB/rlCHwtHA
 /uz37sl0KcF6woqIg3inKBOTyRxjrPBjE6rjgC0BTX/YDH0JLlKo2RtJAfDKd/j8n/2D
 W6ZS5kSQA5W+m3hsWW7SQGi1eUFRTQUDmutKXMOt5V1smsWjruVgz5UnLoXVTXegbPaH
 cFaDvUAsnj4srtRIDvB8BuHAu1fjg/LpdJGmEmCoxzKkV0arcOrE6t4aMAfBrMrmVUTg
 +TuMTY5oL9NX3T1g7sowP2so5B+c9RQfrkL0KR5625BFDXTlYgh+awOmWb3ZsFfzthgc
 IaSQ==
X-Gm-Message-State: AOJu0YwW9obEwhbClOvXNPDrkjuOoCUU8e/J27AfNuN2nQzW2fQY7ySS
 PT6SYaewm7dLU3G12MHySvVTZt3G6OYeQ8Z6P5RuRseoSmwPgjKy179thZTHoHRdEJoNvvKjYlr
 hRBgNvmwHJT9fWITVqiqEEgLjeLlOmVKWLyYEtqg4+oGXXY2Vl+kinjWz+rF6x24yxQ==
X-Gm-Gg: AR+sD10dDNu8W9ZFdwOFDdLBZ/6xIVdja25oFmAwRI+Znl4ZiAnelXe1bp7wmR70ggl
 pzrVR2Q9oIPTJVw3nKjxbuKieEWINWXol2jKkYdF76krHiZUULZCXnTSHxCruLT0OjmZPt1G5Nk
 Hdi2HVpSIkK/0h5ZSe7muVdcZFRfOsYSJX9lDcrWr1vu9tyZuGx1GXkmCtlH5yg5gq4tBf8j7MJ
 9S5tUpHKRui8wOBNAV37C1Q1L9IjLMOV9Fp99m3ogUv1FFyfz8r04cnYScUqtRsyhY5m0CcI3vC
 lkhCJrUdezWxLRHePqlnd9nZrqMG8rnieF0IdhjnEb+4lA+79H9s4XlYfpFZY+NuM8rK9iu5WNW
 1r+tlLeYaI8oEQuUj87PWbU6MgljbMtaorX27Hjd0LfLY0ihxov+Aq+2jYdv/f59to2KbB0A=
X-Received: by 2002:a05:6a21:4d06:b0:3c3:7019:64ad with SMTP id
 adf61e73a8af0-3c8ba6c56e6mr1130104637.66.1785213798225; 
 Mon, 27 Jul 2026 21:43:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d06:b0:3c3:7019:64ad with SMTP id
 adf61e73a8af0-3c8ba6c56e6mr1130084637.66.1785213797772; 
 Mon, 27 Jul 2026 21:43:17 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:17 -0700 (PDT)
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
Subject: [PATCH v6 010/103] tests/tcg/meson.build: introduce env_var
Date: Mon, 27 Jul 2026 21:41:14 -0700
Message-ID: <20260728044248.137626-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a683367 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX3xCYwIB2BQUJ
 PI5JVRor9pVTPWugTcgF+c2Lf40pogxw2NpItyX549FEC1UMH5VZ9zcp4aZHcon/ub+qcLED1ci
 1ITtUns8BwzGaWi5YONwUy4f1Pg91TM=
X-Proofpoint-ORIG-GUID: BNY-dMBD9VKFgaS7TOxATeb9rbQnZAfT
X-Proofpoint-GUID: BNY-dMBD9VKFgaS7TOxATeb9rbQnZAfT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXw8yQOko4JsOR
 y7yYHWzGPorQqENL/4YjluN/VTnCpPtHMdqGwjilo5hflLTrP3hf34j1NPUpNoTxGods5A0jisC
 j60EdYsSn17XTXaW2ikKGiMsnLa6+GH1iOjP9I9oUT3YpA/qvaQHgsVqieFkD7MUcwSJpuWhQBx
 LYOD4oAhGQvnLZ/f1dgQLPQ1LuXSu+4oNTiqrwiHro52ijZ51/RQ57G4NC8N300e7keOS2aYx/B
 fgdkuXdKiAtz3Oao45gtAlaxaLV6QYwLvpwlSQ2LbbXcaSiaA5WPoKa1lW1tUjRMaaXVWlUnBSm
 zdU5tKvbdLlnJTbqbb+OujFslOUPsFZM6zRF+MAYPXX28nUZynpOXGTfrMYiGVshC0jUBITY6db
 SsVpdcMlsB0pgXU0VPlV9MZ8z+nMwnYFg/pXQ8jj+tLxZ/mMBTRNMeRRjT6y0nfIc4GG5+XLK97
 +Fgo6fZ/GIKas4RY0sQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

We add possibility to set an environment variable when running a test.
An example of a test requiring this is
tests/tcg/multiarch/linux/linux-sigrtminmax.c.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


