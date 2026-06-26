Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75277C43602
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9i-0004Et-LJ; Fri, 26 Jun 2026 19:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9h-00046Y-0a
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9e-00049a-VU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:16 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwukJ2164239
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xRGWgjcmxxW
 mhPzEdMdtz2o4wlC3qDxpEEhiYzASCrI=; b=pRjas55xr7fMHfB/sc99U9h/58T
 o+YB0cKSEpugxrsP+mpyeWb78uxRbHRomD4xOvy063GH0YgWGaUWoW6YuHSIJAU3
 Ol3q/D916sw3Md/k8gPhKn1x3H13ArlAZJeQ1PLL3P8DPdsfnYdy30jgzCXSZwhG
 D7B8s4MouPAka7NC4tQmSrtErhh0iABN+3cizh/hcOl27TsRIfsprHf73AQXanah
 VleCU3+mIvszstUFEXko3m4HnluW8OZbS2emQSuLPtLlLVZU/Sfn+BMj3T+gHreq
 sprAE8GYVUhxSajFqKW9oZFETM4eHtkhfABG6KWXO2ZR4NWzHzrHepwcA+w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgdvkrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so720866eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517203; x=1783122003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRGWgjcmxxWmhPzEdMdtz2o4wlC3qDxpEEhiYzASCrI=;
 b=LjlT4HWCdHbzU74/o3TpQBfhrR5WqN1u19AWmwce1umXk0Z6Y4z55jAnmQI95HE3x/
 SWpYTsPY0DUCWHmVxgDSCwPeFzLllzOitPGuThff+35LRxd2SNnt+1WyRsCu63fux7BE
 qeVG6U6XZFPb315qqIqyeB1HvarPTYAtcQKRw+7EYTOOiJ3wTJHw+YGCLUhYFq3txhFv
 QlQJ6mfVlTKbN++RmsCQ5S7U1iNUceELJ9SBykeesRCY+JYMdB2r+GOVedRe1Lje3dyq
 C5NnGJFpeWatNepSuxHZ0PcqIE/LRHLyVDm8AXCaRW7HDk3Ekz7gHd4yrO86nvDQQtUm
 Zveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517203; x=1783122003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xRGWgjcmxxWmhPzEdMdtz2o4wlC3qDxpEEhiYzASCrI=;
 b=SwHp+ATqIQteLCXPMj2JidrHCVNBWFeQSU0t/rtO9MBX2Teyw4J8jRqjx5AKRZrANu
 6MT74DIPXw6VzfEdQOZAFxtHp47l9nP2iuky5xtGKIqeG9F3mbrxuEYoP28k8I+hlwl5
 fuuFE7JugKM8VuvoyNoNETAIutSW2zNsGB0aCx1zYs58uWSsrqewSr1r7H4R/vH9TpIJ
 x3CnGxOT1NlVpOzwwDd1fNPd0DAxX+u5Gypa4v8qOAgSKgdpMgDPYxJHHcO3vH244Iy2
 jTV+hXzkDBqyfPYKUKNBZOnNReSoENs/NHvGo1o1CDnEGKcL0jy5p7/bQXwaEWvzaVr5
 h2Yg==
X-Gm-Message-State: AOJu0Yz3Z0w0oiDGRJwgwN7k/9RCsbk2LHAKTkPm0+HvGCU25VYIkv/w
 LqcKOscX9Q4Y0HTy0kYz9wp4mNIkg2nAogc3YfqkbW439qEcXjM4bl1VWv9mI/bQ/finM5DZqrN
 nBCI89oHiUu8ADy5d78kxc1N6Ul0XlMPib9hPrnVb3HLKDvMf1RU0MJUO9ZvW7k9LCw==
X-Gm-Gg: AfdE7cmcAxqBZjvu4w6DIQyG4Rb+T//I/aazRMou/4ojpgY5z8bx6JodWps+kEIcH1M
 Uso3iTyERPA5scZ7NOnvgoLVPC3xfoqORX+pimoi7idAChb8/ldg3cljomyh9ebFay+cYyla0Hb
 H0qhRyoyWsUwgQDfwwvRtoPJrxf2T77tdgd1kwM3853cjUCyrB2Yb99ypw1Prw1bu1dLBgblnE+
 3HCP9sQVvMvm+7CHI11phN5jvZ580R7TqPhmA+d2vFFDSvitWpXdzfe8IT7or5o26ClECxH0s8J
 VLk8N339NvKEPOFjn/LVJvjWTjjzh92rYJGGmN53H+2RjApjRcaXiEQoI1lKqjspjJW8BTtJ0pR
 2lbYaLwIxtXp13tXROKkVarzsQdHocyEmc1B6Gq+e2FxbadV6nywbY5q6cFYvxdo4EcX4I3eLNa
 SFN3cekw==
X-Received: by 2002:a05:7300:430f:b0:30c:5ebf:63c9 with SMTP id
 5a478bee46e88-30c84d9ba29mr8946469eec.5.1782517202968; 
 Fri, 26 Jun 2026 16:40:02 -0700 (PDT)
X-Received: by 2002:a05:7300:430f:b0:30c:5ebf:63c9 with SMTP id
 5a478bee46e88-30c84d9ba29mr8946442eec.5.1782517202374; 
 Fri, 26 Jun 2026 16:40:02 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 28/37] tests/tcg/meson.build: add logic to skip tests
Date: Fri, 26 Jun 2026 16:39:09 -0700
Message-ID: <20260626233918.158740-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=API5kwXb c=1 sm=1 tr=0 ts=6a3f0dd3 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Yg2_v1zmUQqHFUBEWrgA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX6KxxxGesvkGw
 Do66v/PJI74BmfvnvDQNd9d1sYIYMljXZrqnc/rwcv0Po4DrRSMTA5ls4eWjpBffZPQiypXm5iF
 EdbOHFRFY2SERtM2vDfSeEZ0rRvqJfm0u7xzGBtNCZKjy0mQmJv65CSb78tuVD6pt6VYOdbbRpK
 3XDfpUHfXMLWvDUKfFiEQprCkgUJgvhEqcGnGNL4C7ETpGZekPmTeEm9EhfRSs17qtPPlHsFbJS
 Gt3wlPV15nJ7rjz2CByW8sWBXZy2gMXcGucfPjUx4TmwvBBTVaXAFJTAJuJCpn/Qcxqpps7fIUx
 pxvJZPbu5tTTrecHYtMENguLXhKdGdKpSGvKX4qTTGss4T2VjXXDwXQttqFh6ca4SrBiIaDbPmI
 vwhcive4dE/hES8NbeLFS6yDmUClbupvTz3sTgUOHAsLhC9Gh0E0RmIyixzGO3pWtovM6URroOi
 hRwvP4wRVBkMI13m1Nw==
X-Proofpoint-ORIG-GUID: OL3dVu3Q9QKRQgTqLYmmZDThdZudTMux
X-Proofpoint-GUID: OL3dVu3Q9QKRQgTqLYmmZDThdZudTMux
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX89H0yiJR9C7r
 AdZaRCda/IwVJ0VOWy6hp53afKwb2+TLicQTsNV2x3HIch2gFLM9El5F2qBmQwipKHxPwMoI4Db
 BpTfuRedv0VPTXSRuJP4fFrXOz81J7k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0f0a2b578af..17996561798 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -161,11 +161,15 @@ foreach target, plan: tcg_tests
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
 
@@ -273,6 +277,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            suite: ['tcg', 'tcg-' + target])
-- 
2.47.3


