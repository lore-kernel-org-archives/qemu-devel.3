Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D21C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgruA-0004Oi-Uq; Mon, 06 Jul 2026 18:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgru2-0003jA-TC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:35:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgru1-0005fe-2g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:35:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDuaN1628903
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=omJAn05jTW5
 imsQyp6hALRrY1qBf6hUi82Elb4+V5CE=; b=FicjDS+vGoijOOJSSgLAN7GoaU8
 yby2iK3ZubBbNQ/J62pQeAaZCMJED7yt+p3v3c1qUFxZS8aDpgLwwbfrkkRWHiZI
 AUoMhgUkDB5BC6oKee8qkLJCcW4d/Hsam8k5IpaaOZOU19Z1OhCe1olHTgoPZTUz
 60UwIsnyFQQaL1i0ZR2OqM2EP38BYK+CvQ0mQVv90icylsG+Lh6fQozCB0HUOzKI
 o38TWRYXwi7ygdSM4C2XeaMSQFS8f7Cf9WFsP6kKk30P1dW7DmuD2zrG4bKsAHQA
 Ho7hJHQ9HxcDtbAD3TDMnx08dEO3AuwgHOGlrKyW0Z5XmATe9bMqYBq5rzQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw1hg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3810fcd9adbso5423792a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377289; x=1783982089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omJAn05jTW5imsQyp6hALRrY1qBf6hUi82Elb4+V5CE=;
 b=HSHl5f7yJVMO21t40UFyu169kTEG0RdS5ysT4YXlVXjU7v80t6n2up7YKcoCCnR4c3
 PjKyk2c7t151bW/Y6pKGr4864sg0qgZ5zcCsHuz6BMfK6M8if+M91lUSP6JFP6wud/YL
 VMRgQTeVwC0Al0ty2wj26LpZCXAErUdQH+dD8MRW3z0astfyqTxHJbJPBKkKgX8vipFE
 eca2hgWIO1kXpbk/JMxx+8zz1V3YJcTACpijoePo0FsLBr3dhDNWAA0sFEFcFgdmT1t1
 E15cpQGhvt04JBSW8BrCveJVa2pPHoSaNc7V42J+FL9mKWABWzrPMYHcTWSgioGTfy7/
 0QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377289; x=1783982089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=omJAn05jTW5imsQyp6hALRrY1qBf6hUi82Elb4+V5CE=;
 b=NUBiKmyuwYZhIbCijKKLwoDLnT1FTveulgjtRfLi1AuYm1Svv6bqoaNE7xWmJ4uOS5
 GHpycqeEqjG/0ALZZvTTvRG7jBM5vLYYU0zceJDoEjES3Mk3fcjMoPI44pUR6cg6kBIn
 n1UoeKv8AIJ3YB5PY+9JSEmPnsysxvCZKC6q0dYWRy9bMYGJoCKkSCFFjscZCPyzWvaq
 jZ/gWPN+G87s5lAVAq+cBKZY2RvuJrGkzzPf8iUkLY2CtW0SCkWpsbWhOg1Cum3hAfxg
 vc4vLVnu5zKdJL3+lVlXFhDIEBcqW59I00FbeVcUVMSr/eqci88FmNW4QaLPkDc6pQ6w
 DuTw==
X-Gm-Message-State: AOJu0YwPtn3ZbwOL9KGlbahwQftrJO1VS/9TRfzUWB4r/h2IwemjtXLH
 tyvW4/S31/hWVKkBeVZ/rOirafba7a1Ya0CQjwANN1fRL/FivdAVe2JCxRvWL20wc+dyCAsMiAb
 yvECOJVrbOgvhDy2jduZAnHbPZDI7g73FXyr2SNs+PoCG4cmV+kEf7rA4P/UIRoA7dA==
X-Gm-Gg: AfdE7ck4Lfsmk655+hTWElQIfTmcI0q0nAQy8Aqc7E41NZ5YhzXI98PDpTPrOmi5UuF
 b4kmZkSEPdOZc/wxlAZNP2TpENdTrDie+M/JIowbYhbJfT+CBNG6kYxWozkp2hgi8PGbPwxOYhv
 fkTxsdp5/rh/7CN8foNT5kIeJH+J8nsd+ic4P/+FiPMAh7nP+cR+rcb2UPA57uWHPxKDzljr/kY
 vXGhsD3BRtfCMpOE/5vskRRWPQOK9ThXBVOcTel+mOQuijBAm5FJ7KCJEVCP7xMiM68dlmENZ5Y
 wO3FTXUYOR3YHZw26BIGO3N05FLDm5ME0pOrYx/x+bVPu5t4+jPATLAn6h0+FfX0d1+q3ZR6nWX
 UCOIgEpV10zTVgMxv4iUHqPuk21na5/Zu/L3SQsS3pq2cvdWw8UfA/UeGIxUVeNgKgqLFzdl57H
 ZE5WoPWg==
X-Received: by 2002:a17:90b:270b:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-387572b45fbmr2325316a91.18.1783377288912; 
 Mon, 06 Jul 2026 15:34:48 -0700 (PDT)
X-Received: by 2002:a17:90b:270b:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-387572b45fbmr2325289a91.18.1783377288446; 
 Mon, 06 Jul 2026 15:34:48 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 37/91] tests/tcg/aarch64_be: user tests
Date: Mon,  6 Jul 2026 15:32:49 -0700
Message-ID: <20260706223343.988769-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXwcGsosZtiCK+
 fHBZo5mavsktdTv6M0L/C5EoWDsv1Z3zVXayx8oKKzMzKXbzioH3vj9z+Q2goUExLrwGDoXjXQR
 85YKM4gihxKIbBJgVNSMNB7W/WhrIv4=
X-Proofpoint-ORIG-GUID: Tct1vSIBFrXryHkGkIxg2d33eo9sqk5K
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c2d89 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=14urWzF9DTBOP6QPqJUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX/k1e3mOx3PNU
 SbP4Td+joFr4Vm4+Dwb2cCYIlzyjawqjuB5sqtRKXrUBBTSYbMgxrzTyqmGc8vCHweGknBJXfcD
 itdzXJd1pyn7lmZfuxqRMtbhzLGTXoxr+rF/M6CP8dLuPHS/k7DntaVrIWvWOvUEfs9fYYibsc1
 xoH3+HzyAnfWJaFBbVRK0p23Aymh6i3mUH8kjH3Tq4sCRK0p7Rntyl1r+At88t+xhLRd6Avg9ow
 T2lJkBCbDj67ZjyZiD3kaavMaYN/relakTCWN9YEsuf6K4C/xtTw9QKpp+nr5KxVK3vGf4IeB3l
 xkfOfYLZu/n3vJDoMf8dJHIfsK28oQXDTY5iPfmxB1+eniy+cflrAbixdWA49QXzAlcmpEPfDb1
 UMeMduaClGPsGysJl1gGPsSuvUxXz1BhGY1KXuCEM73FWy3DarT+7TdkxkfdFQ1XRQKPNxt2wMi
 wEp3dGprm1hLfzS5odQ==
X-Proofpoint-GUID: Tct1vSIBFrXryHkGkIxg2d33eo9sqk5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64_be/meson.build | 22 ++++++++++++++++++++++
 tests/tcg/meson.build            |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 tests/tcg/aarch64_be/meson.build

diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
new file mode 100644
index 00000000000..3473d9124db
--- /dev/null
+++ b/tests/tcg/aarch64_be/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+# As we don't have any big-endian libc available,
+# the best we can do is a basic Hello World.
+tests += {
+  'hello.c': {'cflags': ['-mbig-endian', '-ffreestanding', '-nostdlib']},
+}
+
+if 'qemu-aarch64_be' in emulators
+  tcg_tests += {
+    'aarch64_be-linux-user': {
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64_be',
+      'gdb_arch': 'aarch64_be',
+      'qemu': emulators['qemu-aarch64_be'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 50ec5af4906..bfd426c4459 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -135,6 +135,7 @@ endforeach
 
 # Now let's go through all architectures
 subdir('aarch64')
+subdir('aarch64_be')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


