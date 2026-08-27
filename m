Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97295C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFa-0007Ae-50; Thu, 27 Aug 2026 18:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFX-00079l-Il
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFV-0003Dh-Nt
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLwHJ218824
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=; b=WX3J91fL6d+bJI02
 1hJTJg6GhexcQF1wzgUHhdqd+OJ103dCjLUNfTK7wQyL+u2tOfr0oO5DQgOJYKvb
 9qbHMRHb71EJnP29ytsq43402ltWFW7EQDlWoqXqrrRvLYfZVM5IJ1kszf9W/LAG
 cdEhPxD4GP1I0cRXG9PyrWJOdzW+Usb8OmCY5vA8Mvbaw9mSBboJ/guP/BAIY4OG
 LQdY3H3BEMMLMtbI4JWuRnJ4jmbQfC6UPzTyn6m5t6iiTJbyALjDjzjayNBQAP0R
 FLRM2dBzfzUWNawAJAC99qdnn8eVB7CjEaE9cSK8HaxoEtchrHxxQrlRMDMIxOJA
 lCnOIA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw21fb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84859a64079so604251b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868423; x=1788473223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=;
 b=C/2qKufB7oz8j67vXl42DKJt0pycsurBtGqMp3vg7k4uaeMGFCy9GVnZdnpROzDPAe
 65jgDPNzLujauNaHKD8+mINWKGwx6Ri7tXoEyXpQ0DLoPFzFLcUHLBt4aWCSfEy+JJx3
 NhbM8YiPFYPsmIz91c9JslNAc47QJqFBHwwhHuPm+55l/XpjNu1H6z1iig/mD7EMRO4v
 jvKTfZUEBvWGvVvSqsEa4zqUbneCFUnjOQ+B+TBRg5ylnpngSXjP7RPAr+FOameyTTtV
 z7DrIBv//Dv2g6pvTitnql38UFCJBb5xqNwXZLH5t+3LOXwSr/n8TkClaRlScl4uo5kD
 oljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868423; x=1788473223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/wxH4CrH8Av1U2u9+mf/uLwQOQ4wCGvbnyshTP5qFdQ=;
 b=tX0vjz3LT/K9UIsW10L+NH0KtpodyBIewtpCeXRQ9Hdh/V+OkkoD5DmSjp9bS33va/
 poaw/Fk6BXJ9lov+CLcdyN8CFfHApzDxMeRokDT19hnOSHohf5R0u9Rxn7VLne8Gtzlx
 DE5MmOLrfT97K7HLQKKbe+SfEwa0XYnrrtam6Uu94TmGWTCFF/F90sXVOZ/e20qwzrAy
 le5TT9/rKtEC1lNxaYUZ5wR1XrwxHxbPE6UWRe1rJgT0bTKqeigetR8UbDUoKc8ZMe/Y
 PiG1B6MR4vD5wuwNAHUoZvr+PJOiSH2ddwmTUy0ffTIyZxRZ2P2VdGlPPZedTv0s0wdQ
 w23A==
X-Gm-Message-State: AFuF++kmknmXcMvgdJSSG6duq3d06WBPZHdx/6JIE4s1aYBOvIlA3rLe
 MJDyO9jeDMGlpKGWbhdcRHivb9nCWJwSZsstmYgMWjM7mEZdTiMWs9GB79HBLc2KCnVPflHQmYd
 MTOvXEV71efJJyZgcNH0JWHk7Ag8iRGzUtFAUlMVtneU9MY7aNkPmJGukms6JXSDcFw==
X-Gm-Gg: AR+sD121NZgOMiYIuFbKrjg131bW8X/nmhYxPadz8sCxVXubGqptK5yqoBeZuy1tX6e
 6mspSBopTmd/qtfbG/kMxORXlIT9i/k/lIN0gCbvDjRKTH2F6q6jw1DTV5utrNsXTE7MB0s6wed
 eTrd/wfh0gVIS4e7rmUERwzV+wi+/KNhV9v9Ls8bU8mhmihUoyQ8GZ8EejG/pUKcdhad8LYAehS
 Xk92FJ0v9q0C5osONvx0eJsvRT3yKi3MMjWwFsB0P/wh13HEqoDONQxo0bXz4dwLldMnwJRun3D
 FbAyZ0XMBw5MNjI6Wp8hhB8gRzFbFfDpgzvVSFAQrdCMK8QvzDnADMH1NQvXHaJO2g8anhBszc8
 iEugWTrxt2qPhA5TJx62Jvc6A2rmv+rbYWQqPZYW4TyDbN2Ohsepcw9HJago=
X-Received: by 2002:a05:6a00:1daa:b0:848:3f07:c5a2 with SMTP id
 d2e1a72fcca58-85627dc169bmr4496688b3a.4.1787868423519; 
 Thu, 27 Aug 2026 15:07:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:1daa:b0:848:3f07:c5a2 with SMTP id
 d2e1a72fcca58-85627dc169bmr4496609b3a.4.1787868423062; 
 Thu, 27 Aug 2026 15:07:03 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 010/105] tests/tcg/meson.build: introduce env_var
Date: Thu, 27 Aug 2026 22:05:04 +0000
Message-ID: <20260827220641.84885-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8RY3Fhz1Q-k5roBgyHnQ-En1vZwy0MvD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX7B6ZrHuC9cPj
 +CEDk8Ef55gidiseRWTcJyVTD7iE6aarrmOg8HJHWnK2EnjSc1C4mZwWl6ETO6uarZfpI5sIHCT
 tDi1prdG7ClTwnPHENfsERhywgd2fwg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX4DxD1wXXDinq
 sc8GSApsKFM+7y3F8BlRxpo1yOE0Zg+f6XdJOuxx+GvBMxqtrP0Cp4OyTJqr1snJmKangpTKTPb
 rD6DExTHGhGWinGqoYa3x8biwrpUHLiL/Pz/7JN4miOgtG6nwBWJWNWOiUWBC8GBoCGtd3Vh3o6
 N1ksHghgA1WAvLZduBCDVd85Othdnv5n4mWS9tBTg77mIOyAr7NhzMHkonBwVDQd+ZZ0J+9yqlD
 aHVRz819/apDlPgfrb1LnMsGtuTEVXqddMP055386wNF5NlnkMOzODJl/S/EkNZBkcK+Pw7l88a
 TijMng0PnXEnYh6ByzWVyXQx0rrO97adZvM0mAMG8u1BQxzzoGcIESC1B/TLKJIRR5jKe6DqZby
 xlI4Wcoja60TywaJuCJulYW3A71CcbjsKPU203qQAhTlt6T36WVWEZZS9eJTZFGhPUndcSzfqWF
 lOIH1bCQhOlYDYkp26w==
X-Proofpoint-ORIG-GUID: 8RY3Fhz1Q-k5roBgyHnQ-En1vZwy0MvD
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a90b508 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=gbQ6B9eDvqgx0y-0Ix8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


