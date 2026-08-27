Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A062C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNb-0004x2-9a; Thu, 27 Aug 2026 18:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNZ-0004wY-R3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNY-00062U-6D
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLlEO795061
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=; b=S6V4I+KQtQJdeXb0
 daKnU2jeAINBD3WlCi+7dk2ig9D/hnQeA0r7gDH3mDG7ZZPQtyM4wcaQ2PR6y4wh
 QZJuZvIsLwVlCQxhces7mCvObQzA55X8D/XXlvWN6vBuzwIqeeWLplbhQbtH68l0
 hxVWGPGH2fz2kvBZl3gncTRjeiLIMx/Gi6sQfacHCrOePMqHHCRkkLU3SkMXsanl
 2kVDMAd1+938ZhLbchLGphk90Dlj07A5DzDNgX2XJsH9akE+vpj2QMc1qenDDQkm
 aexr/4UN3jI9/52QASP4VaB9pKNZhwu4AcF2Qk/l1oKopvpNTjULMQ9/8g4as/vC
 QUgf0g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjn48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so259473a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868922; x=1788473722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=;
 b=YVK8x3yE6MfeakSaF54U+1ueN1/98p/jvRnnntrC+XuFnRSSyHVBMYzP3V5YmLgF+a
 UVyXM32yebT0Kdq8teHpcFNS7pbudON3ZvvLTkzB/7TyQXsHnph56CtXi/k0ijC9uRtQ
 XvulPKjDfCw7qJpCwQNNK+yTaW+Y+oMcgI2i7N3r08GdHDKNbvea3Eeue+PCJ4TYMcp+
 XLszFkoNibIvwjcju5pqgnISu/00dsKRPV9OJUSwA1k/ZyuvXqM2Eyx/BXlXOtgNuxIL
 9wkCPLvg94Z8W4zoIN5apU95ww7mTqx8MAQ4VlJa09tAQazf5yak5hi/35AQ3pKeMDLT
 WPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868922; x=1788473722;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J3ka7H1GrvjIKt9eVaBVEs6E2xdmrGovko28Tez1z/M=;
 b=kTZYnLvIc6DIn2CVI++qZxpxVbO8JAJSAu5QTeKg0UiuFkH7HPEdnZtWxulB+ZYmqO
 evNKu4nMAqVV4vnWeSYyi958ubt8s2YWe1fdPF2TK1NLeyCS4ELCKAaEhIclzvVVs1Ye
 NTRTNANa3q8QX77Whn3LP5ZqfQpt7jCOHccvy5q5RDih3HZCUx2ANjTWjQpihsKy9Jz2
 KLbqpqzsOrynJKwTD3My7WtTWulUiP+TGEPDcb72Z8kp+p1VpsRIDB6rBfN+LY73Z3aj
 TzNnC2Fafb4JX7afOTsTLmIQoZ/+ErMEpTxt7WRfIzaOIy4CTLOks+lTZOQWqcjWDkNH
 ojmQ==
X-Gm-Message-State: AFuF++mn8hoRS3irAT80VFM+b9AdO/cFwV+fTwqYarLZk2OYweTHMJ/z
 hLN5l97aB75Ph1ydNjMDK+SyEtpTFJBr9HJs/LU54ItmEgKMphuVzFc6xeumt2GlJ3MNEKxQiIQ
 UoY7IUEY9GNmtp22cLj7yvuN4yL4VbTIEp9J1gSRpu7odBrj1949aXcxR5gf06RjEVQ==
X-Gm-Gg: AR+sD11z6lXDGiB4nu9pGy0dSJC5Hgz1aQYvJzIVhTZkoh7qQRNJQS0ElUYbgoJdSuG
 oHZtH9h+GfxlcvIXL6v4ZmHTSDGvBPWYsTqIjIziB3cAursXlI0RfNSxW10AjY/pFF3XkzVDce5
 99CS0y08lDeLq2tI+8Yg9PJ5smhJvvb+dgiqfkGtBa8PhwvqKO71ajlDS8C+29Jk2u80EYyFJ99
 a811uhiP7FkcxcPRzGmHr6sUqg47w+qTM3i73aN9JgXm6T0ic0uXm2tgFbjMrkspSzwG0w5/JTD
 dLjGuLLhrsBRYkwJZCUGAH4TzCs2pOfpbCal8hxHXV9hFVbX5P0yWXm9HVAx0Bqh+pQ62ykEjq5
 gYhBLFYB797fF6gO05fv6GDNNkscEIjQliZmPy4JKAgh41k9JT9Em1hZ/8FI=
X-Received: by 2002:a05:6a00:3ccd:b0:847:770f:da4c with SMTP id
 d2e1a72fcca58-8562bf5a609mr4188757b3a.16.1787868922192; 
 Thu, 27 Aug 2026 15:15:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3ccd:b0:847:770f:da4c with SMTP id
 d2e1a72fcca58-8562bf5a609mr4188645b3a.16.1787868921744; 
 Thu, 27 Aug 2026 15:15:21 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:21 -0700 (PDT)
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
Subject: [PATCH v8 011/105] tests/tcg/plugins: build list of test_plugins
Date: Thu, 27 Aug 2026 22:13:32 +0000
Message-ID: <20260827221506.91574-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX+8DzipTkLbT3
 eKwXIqzaMo7xeSS2ecs2boEcbRNd90xU4xHKi1BKWmpbw5WBfBDwqoJVSSrjegbWq21MWxk3M1s
 rVkePtwBMTOG8TjWEYHwFKz3VSmyeKc=
X-Proofpoint-GUID: dveZct3k80mWOfGpbT3m5NSJ8mMvqSZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5g8eV1NtSpJy
 TWGOE8LZV2CaOFDZVx3rdAcAT9otlxywhlHJN/SDCr4Oo1R3bEcTMC9yjpU0xdfa8sm1R8SKI2A
 ByeYRbiqOKLcJOcslOI2GygbZ8ch515z4NRil/hMl3rIBR4ZkCXw7SJkg6F0kd+9rYrmo6atcYP
 XwzdRK1msFJxvaOdQM2OtCTyYsCW2mMs/e6AmKSYKOXKmaI0YuK+vv2B6IwdoaFSrCxM/zwltxL
 tca8tYfmm1Dmn5M/BYpklrz+FrsXPQnTz0KzI9t/EyuoHQ0wWbdoB+WCmKZb01A1m/AfvOp779N
 s50QINJMiMY0ksFQSDMUxkG2/oKwt3hXbIIL9jygOWnOUjuyxJSdPPb9FVaN1tERmQcJeasX6ZV
 W+Ayj/ppOppaFJJsZ86mZy26UNxuZQ+73qNSUjzPk02Hgq/o4kz7rtV0di67U8mw6/WpmEPI5jX
 XA0qGXHuYeoF2PoQJCQ==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b6fb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dveZct3k80mWOfGpbT3m5NSJ8mMvqSZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fbee86e6b4b..9940bae80a4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.43.0


