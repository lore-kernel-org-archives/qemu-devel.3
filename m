Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA650C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfV-0004sw-KL; Tue, 28 Jul 2026 00:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfT-0004sH-Ip
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfS-0001c4-1l
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40kKe1594079
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6qG7zCVGxjw8Z8MwNGwAb2KScaQrvETMjxwX8VWO6tU=; b=XLXOyeBxcZ27a0K+
 sYiT1NOa5Hcb7muKboC8lilsXNrNQzvu2TspUMqqa01j+BwcqJqlILJct1OW6nMk
 ePuvVknfFsqvZK6AqV1xRgh44sTRe0azi3oBGyhkVWO3qUEjvJHmY9MW3O0HFI9K
 ZJwD7WeibHIvsKdbtv8EUWYNnXJPXQBtU9L9Yu2LyVdF4ZY8ghBlLADmhPJrVdLR
 gkTcuSaNJVVRaQ2IuWxXdSNiwKoSO0QRMY6hvOPIkfwT963OOSYMJLPeN81ukPIP
 FHBk9UVMdfy53DMFsQU596KE9khoPnbPj8R1rTx19dVr05ZZ48tfsLjcaqfBvGGE
 ZK6b+A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g42h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb711c88f2eso2184055a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213818; x=1785818618; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6qG7zCVGxjw8Z8MwNGwAb2KScaQrvETMjxwX8VWO6tU=;
 b=EhgryPeEMs3zYiSnfxSNpCJbL3GCaKGXIfVGOTf411gAaY5L9Mrwo2aWvyoAMR8rPl
 1PZto1u1FBExwaPYNKjC5L5lSD2p1KeFbDLzYgcYQMbbJlC7yTEg+fc9HVq55whDgCQH
 F0UvfjsGumeTQxB1UHNNe/vm78MDrIcjqDlN9tAeXDtqCIPPi/VOXj2n1ghC32YLaICa
 SdfOSRq9vbT1q2oeth9COqz56H4QEmHNIefKUdppCrskNpImVVgiJA8WPfCioByhDbXE
 BpyXrryu3T2biqYECr6qjlWeV8bkZrHsylMIQ5i0ZoMsQW439/JwATgu22pwBuoXoj+v
 /cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213818; x=1785818618;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6qG7zCVGxjw8Z8MwNGwAb2KScaQrvETMjxwX8VWO6tU=;
 b=HE7/9+Y/g1tGX/gwSlfIojoHJyqA43lDDreIrAtuGpuAEhWlzUUFRMmXHS8Px6y93J
 rFlhGVB2gRNJO1NwDTAGxosdj/AOD17b27H9ifOlFheFP9IAEWqXdf8DztzdfktzZP/H
 op2NV7Ak5hfkTLlUAXUJbFFExbLrnWaYvvTi2FLJBIKbXgSefCfSH0QgQYFDYbPQlJNK
 aljlsLPi8UKvMg99jgZ/MgvOun/q3FFKkXK5OkbaVrVTBwEKKlaULKwRSbtgJYaCsXzQ
 c0r2gPn+fpzOOoU+NeEWxrQ+yk7ckgIEG+Udx8Fch5ASiMHfLuszcwEn5qpYIsbtkL4c
 bjlw==
X-Gm-Message-State: AOJu0YxWhnChevt9Tjp4yTDBsTOpJWBcs6wn5oGHS6XtZaAr0mBm5ru0
 2Feh5HPiGLjxLuUGW/55+52eYSZapsh53LwLNCxU7gF9rdggY3ZzfEZO3O5L7viDpX2YsAC0GIH
 heZVn5KPm4dy+MY7zt4vI/yE/D3NSMuWOg2KT2mKx6YBi0ogMVNvWCtHgsxKCEstkZg==
X-Gm-Gg: AR+sD11WhE87pQN6vHt2WgPBu704zvSPRsng8RTZ7Bu7hIIitzba07dvHXnNetlTZMu
 ODJ4EKYigHrzdiwtDjfMF6nJ9J/NqELpianIazf4OsY3mT5y6ZZBFqIlJ7V+KfIdgRg+huxo8xb
 1yaatSbgKOhAt7CjgX6144cDMZK6LLKoa1ksZbc297x3bTgDz9i9eTMCnbqZMLzJJSddYAhHQk3
 wDmxyBbEB83ed/aqzh1SulKI3bZBydyvz38qneIbxVUc7WTxoV4/vnNDWPkKyFmfY7JDDCdhHfP
 qtbY44yWqiJjzIiqnzpONo4iY/V9VvR+msMI7QO9qtEjrplLBbqYQe5LCdE11tCYO70w5j6idVk
 EqZ63F2OhXJ4jwkjz+Pbq+OsBVpgoWkXyMwZnc1Wig9vEutBk9Z1j9HhPDy4Oz89PBAz2kwU=
X-Received: by 2002:a05:6a20:7f92:b0:3c3:97fc:93e1 with SMTP id
 adf61e73a8af0-3c8aafa0153mr1192058637.15.1785213818221; 
 Mon, 27 Jul 2026 21:43:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f92:b0:3c3:97fc:93e1 with SMTP id
 adf61e73a8af0-3c8aafa0153mr1192036637.15.1785213817835; 
 Mon, 27 Jul 2026 21:43:37 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:37 -0700 (PDT)
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
Subject: [PATCH v6 024/103] tests/tcg/meson.build: move gdb_arch support check
Date: Mon, 27 Jul 2026 21:41:28 -0700
Message-ID: <20260728044248.137626-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68337b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XzjeZAZuwW6bxlwlfogA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX6dMugDZZ4Y1b
 mc4sJWR5cC+FfzUfZrdd7No1AYdqIvdmnfQe7sHZmvjGDoc8u4pwG0ZPo1Jn0W0sRGPxoHf3NQd
 8AbPadVG/A6+uGKl7MzJr2e1/Nwce5x9tRk7YRHSPfad2fyeR2/CZnjSw0cxp+w8ZHPp3YqafzA
 HMRzfjM43X3Qupn4m+6z27ONcXWy1j8ffxgYeZdbMWfVKtHFgKdIVVQAlVpOtODDlL0rimToNxS
 uEZRdRB1DP9wdzBzpxZZbY8jQhRAyoI2dRvoPNsmDj8Zmm9QXJ2efUP/z61bCrqRzlrrNbhjeCP
 itzcvu+ZRSSC0EoFhKD/vsPu8G0HwVCKldcc50Ezfga4aVg3H7Jw9KtE4TWDtaSNP6jGMX8Oq0Z
 V5IBR+49ChfrwB5DfdlKAogR5JXys/in+DnSlmJlvKJ7OHq7bXot8QcjZ8JCcNVu6DCbKA/fP57
 moKWazl46gWDM1gTskA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX+5cRJ6Ozc0D1
 9Dom1z8KeIE92GWekD512RL2djjQuxd9TFPTuQ37wd6RSQNXFsHVstCXm7iSWRjz6cD1P+6ERyo
 B9YHkNjYW5SfVJ6mPsEeVxnX9eBALRU=
X-Proofpoint-GUID: -JCugnXVUQKu0WwsbL3gXrkLFx7zuH4H
X-Proofpoint-ORIG-GUID: -JCugnXVUQKu0WwsbL3gXrkLFx7zuH4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7384786f7f8..c227bb52381 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
         endif
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        skip_test = 'gdb not available for ' + gdb_arch
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


