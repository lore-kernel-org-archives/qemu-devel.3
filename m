Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5499C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPN-0006d0-Ma; Tue, 18 Aug 2026 15:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPM-0006cK-6L
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPK-0006al-IW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH4Ps1943408
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=; b=JKfSEE5LrThJckD8
 av96TGv18hFbyWAvuaBjHxGzQyLfLoSXedHhhiXw7F1WwP1+NWSjO/Y5wdtvgbot
 Pw67zgPc+VLETP4D/Q89/hPiN/w10siiPfMyu/K6Zp0iKCdPYB5qqUisRt5+H7Hp
 HwgyIxwt9yOSzNLW9i6J4Qmmx/dRKnDKNUcjW2deyCx9//W5HZVEaQlueqV1I0HX
 1iTwKgdN/LejSKIvaYHQhK0CMWqSp/9gs+qb15jbVFkghiQRvFR6D5tQpaMtYuF6
 tUMhjKZ8efekv1ytmMlJ1qN7pf2yIsCRKAjllpz9cFcIGthMkVYKYDcDL/0CYgcJ
 BJgfiA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn269r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d001671a54so3587555ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081012; x=1787685812; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=;
 b=ZZ74RIMYKU7hqPeKQNFlGgn6a7oQjg5VK3VO4hJ62EsXq4xDu5YlzAdZN1G93vOv/8
 ldS6i+NcJIYSgosXqvYT1t5iKV8xKeCD9kNfY0S/MywlpEN1dAGx4TaAqbYx8gDZJyQw
 tk0Pz3g7OthcxYKR/YpS8oLj2MAwI9wQWHzlt+fvdreBgLvPYHpg6Ho2vPSkU6pqKU7w
 9PAL1b/O+GvWM9bs0ALVy+NOGwICjDIC/VJZpbw1waPO8AHJhSYLHI/qhwyCWR9M/JL7
 e1AyafH6Itx5nhI3WxJWKUNGB9QiXvsBe2nWKqZ6HGXlgN44xAsG3TH0AdubJHRpnxKT
 u9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081012; x=1787685812;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=;
 b=pAEVeUqMKAu4Geno+h3v8Ll7ef3O/yvL97ZQ0PHdT9ukszm9QTKE+DgGa9v4CaFvZZ
 iQ1DlqUYRnTChooZ6VMOZDYWkP0c3+SfU3MhX7ioo1y4zcM/wBXNORyM5E6LBMRFygG6
 fDP3pDTj0gvhDz8QAbQufbQY2gPlQfhL43t9/vbcyiMdYVquVgptntym13bUbyaB/8vM
 lvzQy9grE5ebZpW6VDMm+7RUJ4w1mNMsiUAGVTrXRP0SCjagheuZ6w+M9G9Z1RJzIpQE
 xHDC+mWmGvjLJAL0dgaedZckqODK3+FlRLY5ytyQQSWd89bnmCravQTnEw8u5cSJjmsT
 TkeA==
X-Gm-Message-State: AOJu0YyZFQPlaH154/Bvn91PVnXpSaPlDFn3inYe6Y0g3zpWZIdv31A/
 dFmbxJHo+eYo/ACHhlvIY8ILd1rJu9QJi950u/kn1griX9Bum/U6R9FYoxw0FToCOzj6/Yjr9+0
 8iw1RH0nd4txfWULXJN0LiByd0Abya1UzNeCRKq1SULp84P7Rll/9PSa0QArdJ/tPSg==
X-Gm-Gg: AR+sD12klKyvFGbB0wC1BaYV40BBcfKAl9sAQf6N8oEFYk5en2PSjLzGoaeuNM5kKTE
 8v0ApKv9UPylTQS2CxzJ3VXg4ySAzQvGaC75j3ZfanIxM8Z8ajAdO3Xt6il7N0bHn03GjxHU7mU
 pem1Wn8iP1VKd2RsX7HuLai/ZL4hPRmAJ9jnK+N0WmioxRW1xGds/xB5Hygw0XewUB2Ey3gV5Yf
 gQ3zHKHmcHrkumN+S2Jm9x3MQ2DYyzJqUKDALAC5qbFbZ4D4dU9fVHZovhBeWH9Wwmxhir3t0k7
 pBrHSi7nXkvJ6vVPBbnX/rMmVMvrhXK6EbUJEFdVqd/Y/+dRk4UeDrSLAGOdQmcpQ3ay7J5JAOj
 h3LtlAh6WsFR3o9oAUtev8QZ5TIJTKKJzi5xs3kOfvbGR0ramap3M/Ata3tk=
X-Received: by 2002:a17:903:1b66:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2d5f6cf146cmr525315ad.7.1787081012166; 
 Tue, 18 Aug 2026 12:23:32 -0700 (PDT)
X-Received: by 2002:a17:903:1b66:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2d5f6cf146cmr524465ad.7.1787081011731; 
 Tue, 18 Aug 2026 12:23:31 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:31 -0700 (PDT)
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
Subject: [PATCH v7 009/104] tests/tcg/meson.build: introduce qemu_args
Date: Tue, 18 Aug 2026 19:21:33 +0000
Message-ID: <20260818192309.22169-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2LtuCGBaQBkX
 Uy1t5cZOkJ88iDNh/GwARTN5so0rrKD5gxRq7xwgg/v8pQa4c8vtazrtgqXdq2K/+HvlUuDCGHV
 t4g54/RyrJ81PoSPDmf7KUHZZ5eDITM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6KgN1Pb7O6sh
 7zWYjNFQb6f60vD/7UJ5GxedNZsS3RajgUXmUE3I7vem69h0yr6oPZAWSnjzCuZ2gkntvMNu4ow
 m78Lt7fT1Ff//EL/JQSFKZZjgBiSP4x4QW/udwJ7gD3eJ+bVqLa/ir6ZT6hYiIuLU9BJDKcvo4O
 Px0Djngi4NDUa8hwwZbEhbsvCnQ6qYkDKZLN5yq062vPUdlXN3wBtnr+Mi4O9hqjXrD28C25nFI
 0OtLJfQl+uOMCpkokmG9qIRto2Fn6kRxuMmahgNdNBrmv+Z40mFZ1FJHGn49j2AOID9Ph8r3ZgN
 PRfnI4yiiDuh6Xf0YnXFTtVfbuOmqWrzWQJcftlvp1v5tXA9zKItPUVE4Piz+GhfwVsR+1M1fZ8
 gBNP/JeXwMuUwQz9wL5QYdIhZEIa/sWJqxGs7Jd6DBJMxqMBmhVZ3vXtfYD4DmBvd5dM7PZoDm4
 xSMGEZLGJOYQwmF/dwA==
X-Proofpoint-ORIG-GUID: uqyonD2H31UFUHo1wikjBgoBx8_WWT_S
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a84b135 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uqyonD2H31UFUHo1wikjBgoBx8_WWT_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

We add possibility to use custom arguments when calling qemu for a test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e8d8cfbcf88..a7699b7f62d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -56,7 +57,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'test_name']
+        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -110,9 +111,13 @@ foreach target, plan: tcg_tests
       endif
 
       depends = []
+      qemu_args = []
+      if 'qemu_args' in setup
+        qemu_args = setup['qemu_args']
+      endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, exe]
+      cmd = [qemu, qemu_args, exe]
 
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
-- 
2.43.0


