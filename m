Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D28C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNd-0004y6-6e; Thu, 27 Aug 2026 18:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNb-0004xF-C8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNZ-00062z-KR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLu0T848979
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=; b=AzBI/Vvtu3OYFvSN
 50xR0L5HkxxYOZUc8TBlBO3ELsgXNBjChGYH2bQJ1kkhq4BU0URYnYlAzhn0bq0T
 9wb3k/7OQGoXQrSkBbxuy1USDoDRAPhX5HxFX9JURJ6LjGLA58yMSGAeSreGs2hI
 LbQCVFwtC3XUgiBhOfDZ0dlpCPY0qxk5JMYosOamRZXKKQlOUhfVtf6078D6sMR/
 KLHI4FrVE7TgPsb2tQzr2lU4dD2TPZmP97p7MqasuOWfQJmhcIPwxwzo/NKQ77tF
 colh/n67B6XTOoikmPMxzJodNpybWGd169xh1x2bR68SLQ9kTYoIMub9qDUkg5qR
 P+xYng==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a732-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so472040a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868924; x=1788473724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=;
 b=GoJxat0ZSRSKIpQvT2Gw/0UiUTkkr6avraD0d79nvK47MdFp608vEXXptEGTNeF6v9
 kHFcHY4he990WypArzXWS+aT2gWDWXagV1bHKYczvaPfhvSeOA/iLCGc1hwK4fm9YX6A
 7vX1vMLRQ4YHNzzxkChtxaLvvpSHJgnYrErSIH3+S2Yta1pz9r4+FmCnamy3twyK03S9
 jTjJv7V+Hj7FvgmL1IIyw9bFCntBsk0UWzcRaPCAQzrlD7pAZSxkIRgtvr2PP2tz2WS8
 +cK7z/Ih2/sYxtqTJpNP+o0MoUACkCP3Fn88C58WCB7GH+5gA5tGL/mU6JpZ2uYzwIQz
 Fozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868924; x=1788473724;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1TGLE4RQs0OGV9XCsf3oe5c9HqDogRlZu/fKVEARRAI=;
 b=XGBNRe/qu1MgztrvLGADEIoAGSEwldKFpR4eNc8wtK3N8Fh5hJKuP1fAZWLBcQqEaL
 upy0tAgOeUv5vj03b5CQeLc2hCRv2uJrWsaRJFCpG5e8zKWHQdYiPk+MiMH7hRMYKImM
 yYVUHl7C50wTrAlqwpqet2TwdpxZEKWy4fJaeEE/XH3VRarChKrunY3vNfyWyl6GB3CD
 n6aY+ZwuFCVtEOt0FGUGNqzZmOBtvdCtGHkMAxBpgLBO3yqdW70wAQlobhRyxjTDW+yM
 C8XvRmp/ucrqQlrUIcMBDSvLmbhDxEOQ/ahVsWDvON6YKWDPJKmd6zfPnzFX7MPINVZC
 i1cg==
X-Gm-Message-State: AFuF++kkTY/QSQi3uW5IziVuQbn36nd0XI+oY+rfu+KKYZMjhGr4wqKd
 yGaQvj3wWq/ZCGl5noXSwOkUKB+nwLHVT25zD2YbHAdtfrmG20MqM1W9hnLYS+FNKQP2IspU8sP
 kzvkum6BkclbcLpSPX+24xSzkV8M3kLNGtOFFfaSozRk8DVK0lmZ/uTiKnc2VmUtdjw==
X-Gm-Gg: AR+sD13g8xlxAS/5TbMRrVySOVhSH7vX5xrxsChSWtlhAEEWPBGQpVFncOSOwmJcVRO
 YjYBpqVwua/R1YL9V93SuB5ornCuOa+cr9GTzcyglW77SR77GmnN96WXLW29yl5t29mUl6/9PGZ
 f8551Z9FXaWa66OZIUEzdKsB4xJkJntO+4InIt9gVlBDsQfZeit4z/udLtijmfMQGpPmrQ+UFAD
 vuN/dm1J7xbtvZ3WF3a7AwBX0wQZerUUryf+h47BfpyxY4xGPozL5Ua/soGKdO9VhjYT9ipyQmC
 X/iXHURWSjfsPbdBeKw5jyAYyJUb5LAmQzWfpp9KDOSYxEom1xkUX+EeRCqFJABDxZfXT35mEft
 6XVGJjHZbMinUYuSMzH6spptnidSfLxIKAqBRg9Po0d4s5zMNnXC5NLfiSEw=
X-Received: by 2002:a05:6a00:f04:b0:848:2c2e:c79e with SMTP id
 d2e1a72fcca58-8562b498507mr4809370b3a.12.1787868923515; 
 Thu, 27 Aug 2026 15:15:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:f04:b0:848:2c2e:c79e with SMTP id
 d2e1a72fcca58-8562b498507mr4809256b3a.12.1787868923096; 
 Thu, 27 Aug 2026 15:15:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 012/105] tests/tcg/meson.build: introduce plugin_test
Date: Thu, 27 Aug 2026 22:13:33 +0000
Message-ID: <20260827221506.91574-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2RlTpLgf1cCi
 C7WvCOgn7T/PS55B5GFzMWR6ezFyeeWtgshN3LQrBoifpRx2sMG3yCtKwJth+C78xpaYs0126xk
 jPwC9jGMyjTMKc9nBrtrwk3Sr2gddPNuKeHfHsW8ovHPH1eYCkupfIHtIPsf7b7Uw1QpgMSjP4y
 uvLx/IWGdApbTXHQWM+evCJkcfhw3YZGkY4wlzxjXzHWWn+igBfOm1aJWgvs2NHMz7wUrQZUZzY
 Hnv8ZcMsPdi6uzC4k3KHkKIoPwGTzynMlVySj7SOYLA2KYr4tDs9TO6HkL1AAt8Tzl+/EOZX5u4
 5TzKm4EJRym/He6L9C/FvXAi6U+Hdk30AanGFymYwBp3zn+zEEmH9f1Fa/P4iyYtkjSvmhRxa6M
 fgtsKnOyGRKGBgPK6rUqC7jPDb4FLdDEEfLFQIYAPICF5RX0RDs/wZffG48xXqcAirBm6yrahW0
 fGWSKKhIZJjAMfkZybw==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b6fc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=f31TsGN4npWs9EMxSNoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eVj3RZ7tQdu2ufkrJ7M8bigJ5azMOmBc
X-Proofpoint-ORIG-GUID: eVj3RZ7tQdu2ufkrJ7M8bigJ5azMOmBc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX2LiL9cinsmrw
 pDrVcUR/6C1o6wyI4DRfAqmm//tTZDzZJ0McEV7z/fChrenPcRMzFJIA46tWEgvnAo+dwqcM+ML
 yoSfij9BUzDJD7sBAFeb6MFhmS6ar3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
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

We add possibility to declare a test that is based on a plugin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9940bae80a4..7b51750b016 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -16,6 +16,10 @@ tcg_tests = {}
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
 #           'env_var': ['VAR=value', ...],
+#           'plugin_test': {
+#             'plugin': 'plugin_name',
+#             'args': ['plugin_args', ...],
+#           },
 #         }
 #       },
 #       ...
@@ -59,13 +63,29 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'qemu_args', 'test_name']
+        allowed = ['exe_name', 'env_var', 'cflags', 'plugin_test',
+                   'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
         endif
       endforeach
 
+      # return a clear error if user misspell a plugin entry
+      if 'plugin_test' in setup
+        foreach key, _ : setup['plugin_test']
+          allowed = ['args', 'plugin']
+          if key not in allowed
+            error('unknown tcg plugin entry \'' + key + '\' for test ' + src +
+                  ' (possible: [' + ', '.join(allowed) + '])')
+          endif
+        endforeach
+      endif
+
+      if 'plugin_test' in setup and not get_option('plugins')
+        continue
+      endif
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
@@ -78,6 +98,12 @@ foreach target, plan: tcg_tests
       if 'test_name' in setup
         test_name = setup['test_name']
       endif
+      if 'plugin_test' in setup
+        plugin = test_plugins[setup['plugin_test']['plugin']]
+        # remove 'lib' prefix
+        plugin_name = fs.stem(plugin).substring(3)
+        test_name = 'plugin-' + plugin_name + '-with-' + test_name
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = target + '-' + test_name
@@ -118,6 +144,21 @@ foreach target, plan: tcg_tests
         qemu_args = setup['qemu_args']
       endif
 
+      if 'plugin_test' in setup
+        plugin_setup = setup['plugin_test']
+        plugin = test_plugins[plugin_setup['plugin']]
+        plugin_args = []
+        if 'args' in plugin_setup
+          # add empty arg to generate an additional comma
+          plugin_args = ['', plugin_setup['args']]
+        endif
+        plugin_args = ','.join(plugin_args)
+
+        # since we turn plugin into a string, add dependency explicitly
+        depends += plugin
+        qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
+      endif
+
       exe = built_tests[exe_name]
       cmd = [qemu, qemu_args, exe]
 
-- 
2.43.0


