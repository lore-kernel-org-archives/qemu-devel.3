Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058C9C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Ug-0003qi-LQ; Tue, 21 Jul 2026 08:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm9UA-0003QU-DZ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:22:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm9U8-0003x5-Rf
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:22:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARNHL1499956
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sW0H4vPzhW2N5b8QWJcMqMYu6iN7HTkZwHNpnDBN3VY=; b=TgbVVe/W1AhaBuJz
 jKO5zXm0GiI+PwpHbYAifkCk5MsU0/+/l1IV81x2NuZYoHrjdG5mBAkSNNCfNg9v
 YBw+hTz5oY0ZCrGRKEM1s8EUcXvXiJ2wwGA9eMD0aaIeWJQ51uKNv7ZQ8Lkf7gHH
 HKB/mIMnmUyCbTUDDS17TjOj104zkI6ZsjptaMcZlPDML2aV4r9q/4oiG+F7k4zP
 UVFuiMv7P9vdCaYEgr5AS/6ZUQD5RnpTb51yzv8DsuNiWIsS8ApFTf9beHF1uEiK
 RfIIv7bLf+UIq3z/H+y4E7foGZQxfUCui0NBnqNyg4fZtgjyc7pEDCySb+bXhrMf
 tBthRQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvt89w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:22:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d30035dso143634181cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784636527; x=1785241327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sW0H4vPzhW2N5b8QWJcMqMYu6iN7HTkZwHNpnDBN3VY=;
 b=cn8lYKDJ8jbx1JyR66r8bWLT9dqUHG97C7aOt3kxK12Z368V7VrKVoj8kYO+Ip82cP
 9W1LnaWsqhbQnN6DopvE6A/QIBSgQ7IRKGsK9Gz9w0dJHBfUcxzYJc9emN8lE76iCQt5
 7FU2OhoiKgiujcCYXv/xhMTQahrRQTtfpqpj8G3zhoFKPOTe/3n8WY4XR71CIfdMROAZ
 aKAidhAqjFIBjOrftyXQlv6VJ7sgFwuArOMRPtry0wuA7iIC/Wacou+k56//if0pyi1G
 9Q2OHONa9kTzcwWgkYmFTCx4mstbLL1+C3pk7vLecrJFLU+XHxPy1LDrDGqqe5bJ9v88
 tytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784636527; x=1785241327;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sW0H4vPzhW2N5b8QWJcMqMYu6iN7HTkZwHNpnDBN3VY=;
 b=G7PMNihxFfyH1dxnpgKsCq2npqo8mjOxZRSpnsYTMp5mMbXUVzH6L05a/n/bVNki7A
 vP9+NWo6xMExKHet2xKfKNLKk8btIEGEuKyQwS49IJzPHwqADqVwI98SD/0HYjKl1HzO
 LnKx6ehdM6wotQOvL3r30sP79r97r4Hgx0Blj/V88M5DM6X82cqnCbERnTn5jAOB9C3L
 aRond0U0/6Zi6hVzKI9I8wlcH6VhWw+Nm8636KKOF8LjQ2FAj50qBbYhCTrXuAH20fos
 0BiYOE9LZMVkgfXJLNaYjCYXSUQAmNXsry5b4k+u0EYtUtMoi0uYzANELO93yvc46vrM
 FJFQ==
X-Gm-Message-State: AOJu0YxuZ7bIfXl/QIB2IFZkwnMkz13x7KNma9tKrgcobEsnM9tODE6c
 53DS+8zixtI2qQCVNebBGoyHCBbLlYxhi9acilKXNQg/Rnp/Up+wYZ1foV1CLkGxFEwC9NlRDmq
 7hDoNfVhCi7064g6pGx95LUm0b+wjqR/cTjmisnhw73WEAGYRhlvRZePzenEJtw2IvA==
X-Gm-Gg: AfdE7cnMfnDkyWAH+qYcPn9ywkD5cZmXPjflPI72iLVl/GiDOav3h3V4WBbS2r2y7rC
 xWfJYplNTZil5xDRZHtMe5tocdbOwF5zvDuss+/4smTn087+og6Xaq0uFxGZxn1N7kKsE9m2Lim
 A0xFxV8mOQMXBUFDwhyQgnfEFs8cEAGO1gUrYOSa27ch03etR7kT5VeameKIdqbcSV9jVg6wo5S
 BYFlPGJkjawSb3ssPk+LD+3zat5pjiad8iVseFK9F/F7QwLMY1tpQbIElqISkVXNYwv6dktgC7x
 36aOpRHhkSBQQ2tyX0MGYfpcWX/N5tZBry8OS37h2zbBKqezbBeKgMZ/4O3Qm+q2UnOo4AdWfLK
 my2XcE7fyhkOZIgNgx5wUUiSBVR33TcuwNNgKU2WGiZilGvcojinFfreEsA==
X-Received: by 2002:ac8:7dcb:0:b0:51a:8c97:938e with SMTP id
 d75a77b69052e-5213e188626mr163570421cf.69.1784636527135; 
 Tue, 21 Jul 2026 05:22:07 -0700 (PDT)
X-Received: by 2002:ac8:7dcb:0:b0:51a:8c97:938e with SMTP id
 d75a77b69052e-5213e188626mr163570081cf.69.1784636526685; 
 Tue, 21 Jul 2026 05:22:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm86665805e9.7.2026.07.21.05.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 05:22:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 4/4] target/arm: Build TCG stubs as stub library
Date: Tue, 21 Jul 2026 14:21:34 +0200
Message-ID: <20260721122135.6288-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721122135.6288-1-philmd@oss.qualcomm.com>
References: <20260721122135.6288-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ml7CHUhWQn0RLffc-jOUG04gUz_aB15y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMSBTYWx0ZWRfXwtI0Po9Q5Pjf
 +f28Os1Qzq41+zU9K4TjYkE4L63XdK/Hor9K7s0ZE0Ys5sNbZ6VaJSabnPNybZNU2nYmjsTFxAh
 m3IPlQ4LB1dlQTIqchUShc5ZDtc9bu4=
X-Proofpoint-GUID: ml7CHUhWQn0RLffc-jOUG04gUz_aB15y
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f646f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dYXcIrvnCqDwK9geEd8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=0lgtpPvCYYIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMSBTYWx0ZWRfX9ceHaQgiXPdg
 L8QH2kTjvxZyNJTmY8aUcd8AoxYVuuxVIrXW25n1q4vpZZsJXLTHl+fwSyuBmMdGBNdYksOR3Vp
 A0B3tfC5uoSIkWBWk/hpb9m19HqtUvK1xL9Vcnq46IqnSJfIcuYwtwx1Z8xR3mYxvp6L9qV8qxu
 goHFhiwE4ohpCXO7TzYzTX08ScYN8SlXanqDzBOJE5brdesHwHvG7/JI42whVlN+0mXnP9Jy4IV
 3pAo+O1r7DkxMl28ok5p9nqTkIq8gUbeoC+MtHTJbYxTugQ0a+HJbcWVxpYy0gqP/StygcP9Tag
 68ZWPn9UYBr/iskRHO/20N6oYpmMTUWZMpzi8C73Zuzp9/aO0qY/i5EvajMgFI9/gtbjdxhiMDT
 T9Py1QPAptgDJNCxYYHV064H4T2GxkUhtHzop2AS7RROxRgc1pZwTYZfaCZ59yBVLAHgeysPxqN
 wmx4lrVhhPQvt4DNmKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210131
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Use the stub library introduced in commit 0da978cdbc6 ("target/arm:
define stub library") to prevent symbol conflicts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index f6ae8934d1b..0369f96b4cc 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -38,7 +38,8 @@ arm_user_ss.add(files('cpu.c'))
 arm_stubs_ss.add(files(
   'cpu32-stubs.c',
   'gicv5-stubs.c',
-  'kvm-stub.c'
+  'kvm-stub.c',
+  'tcg-stubs.c',
 ))
 arm_user_ss.add(files(
   'el2-stubs.c',
@@ -65,8 +66,6 @@ subdir('whpx')
 
 if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
-else
-    arm_common_system_ss.add(files('tcg-stubs.c'))
 endif
 
 arm_user_ss.add_all(arm_common_user_system_ss)
-- 
2.53.0


