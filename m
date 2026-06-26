Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E66BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9m-0004Z8-Pj; Fri, 26 Jun 2026 19:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9k-0004Oa-Ne
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9i-0004Ly-U2
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:20 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxNm42462823
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=99bpuWSg6o4
 v5qulMLRIRcUM8YO8KgbmTU2MCc2c3sE=; b=fScIwhf8vZRh3W2XcGA8Q/7aEoC
 /OV2NLapxxqVONC8C4jqT4Qgoj8dSuYEKmowVkqzu61Cd7K7GTUet1vPbfxxNV3h
 14OkfIwL4buFnEdhaVqjgtaSmsrOSqtGvCv8KenWKQz8wKQRtyntTrgsFycSkjGA
 pNR77zbZQS+MnKYXnc3S5RwI3n7nuJWhni0hqxOrvu51ua+XK8vk66QcKcMObohH
 TnTstR8NxLUCcdFC324NkwL7dgPNTgAbSnPEoXbRiF/ay3DBBhXDN5iS++rz7NAV
 YJbEo/RlfhDJpV3hvymBDUC4VQE2GXMhC15bMJe/1D5go6wyehvTvn2F8Jg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2tu0m3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:07 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30ba395b047so4488520eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517207; x=1783122007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99bpuWSg6o4v5qulMLRIRcUM8YO8KgbmTU2MCc2c3sE=;
 b=LnkP2uW2Y1nqeJQ3J69DSDLXi77O1dBSV/9sRN2LxMaltW56w41V+oFZT/SBC9/+Z6
 0ib4QANP9nRoHmaF+vCU6fhbB6Ia3kQQZ/9Rn6NJHNJ91qcwqUizk/iQxGH3rQqErNy7
 4BKzmhq4yuXk6tz0DszMQvusyfYnqiLDdPmkyGYibjSCb3jovs5XNN0y704fVW51GfYu
 ZM3PN1jwSB/S0G6x2O7SpHlZ9bNhW2/OdB3KBonXR/8Q1Tsy0C5QOZHyV2YYXr8Ys6fl
 WIzjPoeWUd1uTrzSzgELqRKgsqHVanipY8eO/6+thCClJJEx5PWND6/PsYEWZSLgnjIV
 LZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517207; x=1783122007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=99bpuWSg6o4v5qulMLRIRcUM8YO8KgbmTU2MCc2c3sE=;
 b=G7V/1zuGS85M883X2UzZjtHfVI7ldrE90Z+FjDft4DM0X7wKFvJQ53oL7CVgvkHwAL
 4sHg/9MabxuKDw2KMagHXGQpQjv+gyt42ml9KAFtZ0JjuUt3biSg4mkyOQ1iCNuz7gWy
 rG/jd/aZefW8+WbunXDONQxIAYScs9hLunloTPS6+KSLsdOQBBNPaeLbMBA+rz1qw3wA
 5aB1BM2hbj5kYnLHDak7rqKsj6P5qWWdJgOi/VXi+BZtwn2x7MqiIcoZK7ZdGGTebyuf
 CJtnyghe1SuWkY/rILnLoHfLQuIsZlDupNE0mGqRpqFIEOugEnYeQ0ihG0Zk4KuwNMpy
 /3ZQ==
X-Gm-Message-State: AOJu0Yy2gvBV01XP/Ql1AcFacXpTDMi+U2PCsu7MhkU9pZloNpvmE0Zj
 D5sfpz20enNRKTGBwtNf53MzTHVrPHGleMhI9y6266WnZiplrOX8M2R2Zbm+ysPC8SwZ9Akr2fo
 5wzwjEUxzPeFinfIfjN/4lP30s1qZBMshBZ3C8Xlfyt+9mTNpFrmmqNGlfTteVKzHCQ==
X-Gm-Gg: AfdE7cmbhMU9FVAYaHygpoWFEbvsZb4ari4U8cu6LLSRqKwCqkVVaf/+nGtdk2zHwnH
 Fsl6KFDLhc6tmmLHmnnVFFjxtxC9zGuNDBRPuH7HmlDfjuP0gWOJUiqPsz3sx+MeIk48hHhhKZr
 ntyccKf69zQiZ5btB5Q3BY1aNlRmLDQ9HBr5z7uv5kMt30Q+8lZyXf2YpLz/K7aUjEQmw6TsCMr
 FVb21eZ5L2ts81q//hgzJtbbldlinoTB7px9Iiu2lM/cdOUTZ9wnPpeixP4f9qPR65BVLDfPPjh
 fhwQ3Z421CsFkbB7AM4lM/kT8NdyIthVjrBHFjv/LFw/EUHKexCwvxdloVRkIbKsAJ79IIP5zZs
 qbQZt7ai6BSgfc9LPv3i7eiHjZjXHSfIKMvoeTOfC3S6oeAKaVXEaLJfoI/q0saygm+RG/fvEIO
 Z0LbVWDg==
X-Received: by 2002:a05:7301:e04:b0:307:4797:ccb8 with SMTP id
 5a478bee46e88-30c84e99bc2mr7950401eec.32.1782517207025; 
 Fri, 26 Jun 2026 16:40:07 -0700 (PDT)
X-Received: by 2002:a05:7301:e04:b0:307:4797:ccb8 with SMTP id
 5a478bee46e88-30c84e99bc2mr7950372eec.32.1782517206515; 
 Fri, 26 Jun 2026 16:40:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:05 -0700 (PDT)
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
Subject: [PATCH v2 31/37] tests/tcg/meson.build: move gdb_arch support check
Date: Fri, 26 Jun 2026 16:39:12 -0700
Message-ID: <20260626233918.158740-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX7rIuEmNmJGV2
 Mbw5/vhwQT8yqHpYgiphgVFEwtXGD6TcGwB+3qFkuDE4Fl85fvuild37T1IlbO/5wxAloCjQxWj
 xGKRdKOrkDwkad1ZSpvnIHyF/tXjlyE=
X-Proofpoint-GUID: Fu4oNltf0AG8BKKilRTohV5NPQSTwkz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX3JDd7u5Vqwml
 HE8i33sO92uaLk9zYWSVIRE6fj9kLL77tOKj0GwTckjblK9xvKZ1JIi5bOELEk7aiViCb5LJ5hN
 NTQC6HvD2/KdyPolL8Uzuy89U4a5Hiidi1tVsOO5h0aCfmxxK1uJ9BpwSVXlbzWeVkW70doQPlL
 TVtsLuBql3f1hno1tIqopcgjUtjjjF5jhKwR0vg5kXo9T8ixUqur4wadmkbQEHDu3G9w42NhXOt
 kjQ6ki26OhmRXA+ZqKTZtUk1MAgDtLOw0bb+zJogq+j7GawXxUIDn9qosU7cXjjhBlUHwJBFu8J
 opJv2tidJ3s7dAj7N+1lhpr/jT/ytb/sJu9rfzWfT+2avG0MiNIQY936qeRE8x0/4fyW9o/Voml
 qJGXQKVZ3aBf1JICg91GGOWvU0EWlyBCAMirXwCdxRMP6f5S9BWlJjMcIS+XWm9r/06GMaIocgo
 keG4KfwhoLKNFk0ZBqA==
X-Proofpoint-ORIG-GUID: Fu4oNltf0AG8BKKilRTohV5NPQSTwkz0
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3f0dd7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=IyeoL6OE1jcpBHINtK8A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
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

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 80743c2ecd6..54346668eec 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -185,10 +185,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -329,6 +325,10 @@ foreach target, plan: tcg_tests
         if not gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
           skip_test = 'gdb feature ' + gdb_feat + ' not supported'
         endif
+
+        if gdb_arch not in gdb_arch_supported
+          skip_test = 'gdb not available for ' + gdb_arch
+        endif
       endif
 
       if skip_test != ''
-- 
2.47.3


