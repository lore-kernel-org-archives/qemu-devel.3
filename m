Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE1C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry1-0002BO-Iv; Mon, 06 Jul 2026 18:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxj-0001ku-DY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxh-000717-Hd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDvuw1566461
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DaMB5gXuobv
 n9ik7g73Dn0rAohbIuBvsoArp6cFMLBM=; b=KGJ+n/HrcPT+vuMz43KVZrajj5x
 LYm2gyUFCen3PZ/bVXIqHsjA2cSavvBWR0YuAcpZYmOkNjL5qKm/paJhNzVrypvc
 kd2sKrvqpRNh/0PYoafYS8HZPKSoelKzBk+/NYfYPTdSNAxoHbrFrR1YlyH6ZmuP
 q1VHQChScMPEk7oPwaODPxFOKa+vw7h3hBQt0WRKIq28BZUGkJi3RbkLjfU0TN1u
 aVC1eqlMAjCAnIo12d1eJOdtQ/9xgpZcgZDvt35e8ArgrCB1uY9njcPi0CjM97Xz
 aRbuq/Ct13VGXoYlGu1YMYAXx2CGxU0qfnqm6xgXMTJ3IlAd96K8+DjCnbQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7ku0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so3026897a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377527; x=1783982327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaMB5gXuobvn9ik7g73Dn0rAohbIuBvsoArp6cFMLBM=;
 b=fJG2X1+Kx2lfe9HC7/XSkFASS6IqX7rx8VR6o0S0cyDBuSiV/01CHWUwScqCLHEROV
 JGspBe3b0LfcwzrNN+OYYUbH7NHTVJwbh9OolA0aZSTiB6sSicJJDArI0SKIXZtluui2
 SjoIzDLqlxa0aUCpt531/r30B0K6ZHIeA2J9Qi/8qU2AKtpm6FeABTVxmg0fGPZdo/Lo
 4T5fRuca+otRUvTDcyU7fPRxa/ORnndnM34iDufmGWEsce4PYY765/hpHPmugAC685GV
 j7Jl06hmTMB/2fb9IDeWG2t9SwKCfWV64coFPxlYpqkvz9o/9Jg2nmiiii4MFXXfe9/O
 L2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377527; x=1783982327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DaMB5gXuobvn9ik7g73Dn0rAohbIuBvsoArp6cFMLBM=;
 b=awKC51zxqDhmtsaoMkFW7Pu4wD8PaPsUVRxOTL9Y8ZYpltAtMEeBU8MXylKN0sXeWP
 wabIISDs25QAaF2oG3DitjEQS14fvDnffKqQF1TyYxPEC9itIwFj8dsOmAwj5K4ctYAG
 GHhxBx5belmsIBzho9ITann2cv/5MGvBjjHgTTjUbAuyJM1PbFTfnIE/KQ/UZFh4V5ci
 9+4eP9NlW+z6+FOV4RVmPC3N+wNXXeNjsnooHmMrpA5urUjLFDXNfEC8iP2/VTPFi2bB
 ejwXgjqU33JUK6r5DLUe4RoPB3O8Fqg01RKNi4tI/BWyZ0xaGriqlfrG10TvSzl0dlit
 eXwQ==
X-Gm-Message-State: AOJu0Yw9bVQ/aAONP6v26P56qLbir0scH0reXmNqPfbZ8m++jNrVvJ8w
 HMYbnuimVzU4Qtfl1k+hZtN4sRTKJhAon5TDNPn11CdB20jpJKWq97yG7xoWX7KBWmRa3IQIgqp
 FglzW+KUQlDS4zkoxf8/9c7DaO4STOvY4KtKgr0iWeUNfTuDN2P7XXBdlOzvnpINu+A==
X-Gm-Gg: AfdE7ck6iUvrbHSOmpWW1gbAouHwBkuVJByBqajr4KZVK2lVnjH4aiJvysV7nXAmfyS
 cErPsdl4r7Wl0pq7cS9jWi5YJxWHqt3/apeEIBz5g7rZ+RSLNyA+Pu/gsdcPFCOaTEpzMvlLNlP
 fhD1NZZJ0cDpwL5ICiQiBwn3QHyjE9d88L1GcnvFZLgdSDcCy9CpVUb6bkwMcS8pg46Muax0gx+
 4m6DS2degP6WIaZ2K84SXR4624EqsrQftsdEI8LNrJ/au5qH+BSsGGOqZXIQdiZ3DwWTrtVl7jS
 VcvoZkQBdCrJ3DomkN7oGbrr/WVGhfi4v+TVWSCeUm7nwXFDgJ3iZf0rNfX0q4vCDUQ+gKmd4Zo
 sISc4AIJfQq8wHQUGiwuntRgYyVwDPEwBonLZeQ3GJlduWaVzM5mgQQUWWqNgzPNqkSSVMbNj+R
 Q77rGqCA==
X-Received: by 2002:a05:6a20:da17:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c08ee6df1bmr2787475637.32.1783377527439; 
 Mon, 06 Jul 2026 15:38:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:da17:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c08ee6df1bmr2787450637.32.1783377527000; 
 Mon, 06 Jul 2026 15:38:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:46 -0700 (PDT)
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
Subject: [PATCH v3 61/91] tests/tcg/mips64el: user tests
Date: Mon,  6 Jul 2026 15:33:13 -0700
Message-ID: <20260706223343.988769-62-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXwvo88yKHF5Qk
 bkw6A7rw5R4kB0e5Y1UfhNA0Nyb2WQR0owQCATp8s+yjHv2xPk4yTlUn9hFXM3bkXmxWgREOJje
 rljVjLfOCqhgw2szrWgI146n2rOgnwDI1FDJY/JTFodjNoCv931kncR6yejNxIe/UE2E0TgIIxa
 VgQFMnEBjSX9vf4MqxC600VMBLTBCugo2+YpQ7KJlTRDqJBsUpzBwbelS1/5rs0pf09j7aF4qeu
 sbWj5rSu71IdUr5MD8Ij0j6Mf6fvGGUlnLZvfWUtcA/2m2Q3OFjNEENN2Uvuw3wnLUVKzv4Y9Qv
 m9kS5q58e/2qTHHwCKxjgCkUI0N3gH+2vuJjlC/T3HHjzTeXy8WwkKyNNz4Y+rk6GvpwIp7+3r8
 eJ5LJCMZJbkfU1pRHhImadkuruJXAimznskuZHBmxD4T3NGf986p8CsycU56wNQAya7Rur2bem4
 kwqPr46jiKt4xLgp4Kw==
X-Proofpoint-ORIG-GUID: 4BJoNjVZ_tjvprgT9CfBilnU101v3iuY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXypuS799SZ6BN
 CiQFt2IO8QpyR2A9w9iQILbIFzizzjhtTyUqRAO2AMV74Z81Jyg5gMpelrQls93NCcCQOgPfL39
 11KOnWloUxi8EWJPuP81bn3Wjbq6jM0=
X-Proofpoint-GUID: 4BJoNjVZ_tjvprgT9CfBilnU101v3iuY
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4c2e78 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=NRaK-Uu9MM2q_eLxIrgA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build          |  1 +
 tests/tcg/mips64el/meson.build | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/tcg/mips64el/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 2f4bb4b579b..816a6054d93 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -145,6 +145,7 @@ subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
 subdir('mips64')
+subdir('mips64el')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
new file mode 100644
index 00000000000..16bc2f32509
--- /dev/null
+++ b/tests/tcg/mips64el/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-mips64el' in emulators
+  tcg_tests += {
+    'mips64el-linux-user': {
+      'cc': 'mips64el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
-- 
2.47.3


