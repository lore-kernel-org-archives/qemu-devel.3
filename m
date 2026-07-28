Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C40C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfC-0004bC-Nw; Tue, 28 Jul 2026 00:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf7-0004Ss-UL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf5-0001aw-JQ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3amQB1423508
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UQSpNEWV+K44PrWgscLDKx2w/PNtRjkvAr0Nf1Rinb8=; b=kqn0ZSI5eDjrCDdB
 QVogyERpLIlMqS4Gj+RhSE+N49ooPIOzKpe+VCaMM2Cybom4jizWawb+JFsDweJ0
 +7ooLv8ABUv2ML78zGjvBYtnS2fKDyhkMMmtwzk7Ce47K10SquRqCVdPJBtQ7vQA
 aWGJFMQBpEaF0+BSd4i62i9k4ULHx/H3pICNCBVdfYINetqV+kkL5aUv0q40lV9G
 xHgGQtzduM0dzMWF0tnM+Act+3Xi1hutKfMqWSxYuRQpi4L+jI0KHRznJh51ZZqd
 G8Z+omFipT8KF/OPPfVjAMUUMBbd9J6B7gePmgSaED4SVg1O9X9Xaes8DNXR3DOB
 x6kJTQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mpd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso3672728b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213806; x=1785818606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UQSpNEWV+K44PrWgscLDKx2w/PNtRjkvAr0Nf1Rinb8=;
 b=HQxX3Aw7gyJYGVq9sh4WK56Q9rJdsaoOGwtUlzylu+g5Gbl3zeBpoFd0mfXUvRwZx5
 qC1ep1E/ktwu3HKZEVIa3ilWgV/FfV9iQJabeXXpAzBl0KfLuoEQAnarydpANeE1U8M4
 adsTb6guEmdq6eCL78WiP2QrU/PcU/YnKGEZBv5PimB8wr0ilDt9SurbSzyaHtx05f3u
 Bp4RV8ZWzbOdxAGmFrOvDjekVZG4b02gFLee4vWJb8fWqIyNjLQgVLAX1LdZWk6bWPtK
 /hhAraMmI8JmrotZ57hl6G/vpNjxofI8Str5Ng6MAxy1ltFCl4UItEgIOtS5cnczq6Uq
 A21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213806; x=1785818606;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UQSpNEWV+K44PrWgscLDKx2w/PNtRjkvAr0Nf1Rinb8=;
 b=UmMSZ65WzUvZIy0LCJ8yUDaVapAg5BcZ/dZKTwa+lHBPHsN8ep+fhUCMiUDpyl23MI
 Zwq8FusToV+zbsansJ2eMMg1wvvmdjtII1lX4zecqQBIxHjH+QpxxrDma5I3ZKwjWo9i
 6guS3z1WVysW8XQNLZ5fQ/KZFTwookZsLjdisYEv9ML8tKlJ6vfPCBKBxmaHTSyvJmy9
 RsFayhc7UsY+SfOhaAPhv0D6kW3zRqPH0nIjebdCII4luyOzIo6+qLvM8XEM1cTBdf8i
 8fS83IMF7MM2YI2NczGCoGJ+3a1xpruCBDLuVHZgBmvDLbk+pSimL/fgQckYexhB2gEx
 Wqsw==
X-Gm-Message-State: AOJu0Yz94qrl63IYgZZzDujP8pwhuMgC1MUvC13rVa7ypqPJR40fPs4b
 H1o+N+mG/Xroei7oNHqDJ8o7RapgHg+BZlwJzz1JXjs7llKJVgOYo5T+dKxegKgpMM7kuOJ85uz
 N44156lAM9/YURIqfgLASAQ3IMpBBB84CwLjfK+dm2kSBWzjE7qh/RAc3TPfD+klqxw==
X-Gm-Gg: AR+sD12hwAcJU9vHg4YxYyUdnh0ZLEeBjxoVTHhtBDwDNQ1n2kt7e0ZBteEl1XMYsIU
 Ok9AbI626tuSH3jcSYrpt2C2xJvJR9zyTt9JoQWf+ikIbzVR7imW4Msmt+XDhx39EbtIffwzey5
 auYRKkhQfcicTkbjxfdugXt6pZs23q5z2y3fmAC2YESLll7JoY6DkE1Ie8CjVvnjjkbVIpmA9Sd
 UOjP9+VaWRUl0Vr5HHVO4hSJPqk1iYtgeRqZZqdAOk8YX4kzpkBiqEyOus7BqGg/H1Qw0jHlfhS
 UTHb+a253+3mMmZUmSw0h0fgn3Jp0FAwTPtGwK6TxGxsl6jB6rkgJPTEJ/OKY4RpNdcHgk01zUZ
 8TddIZkAvL2AQztWalxPuemLqMC9U5/c2j+f9Uesgr523xCm1C6STiyCtZUO8trHYG4tzp/0=
X-Received: by 2002:a05:6a21:7106:b0:3c3:7f8f:88c9 with SMTP id
 adf61e73a8af0-3c8ba616cf1mr935039637.54.1785213805657; 
 Mon, 27 Jul 2026 21:43:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:7106:b0:3c3:7f8f:88c9 with SMTP id
 adf61e73a8af0-3c8ba616cf1mr935010637.54.1785213805231; 
 Mon, 27 Jul 2026 21:43:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:24 -0700 (PDT)
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
Subject: [PATCH v6 015/103] tests/tcg/meson.build: introduce wrapper
Date: Mon, 27 Jul 2026 21:41:19 -0700
Message-ID: <20260728044248.137626-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXyBDsEVd8YGQ5
 7rIjHhccdq0PCMvE8CzQNgqFOXaG24OBd/mEKRfx0hh8nVUOapBSdB0C17AZaECOYaihH8mnS83
 1w4bs4cNtE3fsce7lu/WqZ/D4LFpl/c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX+8iAux5tGjVR
 fhDeufeiF8pz8nh9xG1y+YOIB07CZ+SYYqmsbBUbCBRm0kQenIi6BR97Bw1q79kf/1GtqM2bISP
 OmtjajHg542CVqc8sxJ8fMQ8GT7vrtKcMpnkG1glL2p6hrCVqwzJwRqewKSL4Kerswc2Hq4aaDO
 0+OQ5vkaB/K80dXBen5KkLT3UUIo3+/2RaNt+zS46P5tD88AtmXY+eUfHlig9zbx1JiOul6rCz0
 2tfUnhJkRwSyneQAmcyGKW0JX6pEq6yXtZOXjaR6StzFL34FrpACaKBVFxFHnTWD18iAeZFkvLV
 9wyD36OzIcttkzkES3A5K16CeJBs65jxOdBbLAXwZEVNOXLdYSaDlAiUr/OPbWf5DkT5cIkTamf
 bB+WXqo17RiMmD03hSOpJ6GFJdoZO8A9IqD72xkxpOsg7ULScVzwEnoPSLgr0O83fcz9qUvzVpL
 yuiB/4rm4Na8wwIt8/Q==
X-Proofpoint-GUID: jEeYm7jtspmZiTe_QEcHt_S79nEPphNs
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a68336e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jEeYm7jtspmZiTe_QEcHt_S79nEPphNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76375615d0b..0311b2432e4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -25,6 +25,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -86,7 +87,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -200,6 +201,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


