Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53FACD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wST7X-0001mo-Q5; Thu, 28 May 2026 01:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7P-0001h8-N4
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wST7N-0003g0-Dm
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:17:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKlhlr124645
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=35giVodLf81
 lJuJPIwpxYiwrV1aluPV9PhABuPn61t4=; b=Bk/Mwh/sLNqUqPBUnFkVIzOoMIF
 Ag0bWIXZKvF6C20FxthAplpr2X9WOHrzKItByjW5QpJM4awvMHRkyxcaNS0I6yjJ
 4nzvOzPTY20nZsVhOhpyW4Twhao/IBa4tKBHQEuy3PHS3I6PSbgkwYbsdiRHUpRE
 CGE9LIgLot9D0Hn54uTkG9GJEdWycInBTjhrBbtxQrl2a2fFVwXhNDewn+C70YE8
 tXYe+xBG9b0re4rdzJhXFWJ+HzRY8lqI5MlXT4JO3qflEO2WAljF/H7ZfYRCzRpd
 8Z4nHOR6JGVAajZga6vGw8I/0U6GYhl2yez4uhxW8d3ecfx6WQMNqEZgZEA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yahd8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 05:17:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304950e5901so2186302eec.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 22:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779945435; x=1780550235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=35giVodLf81lJuJPIwpxYiwrV1aluPV9PhABuPn61t4=;
 b=cO37+825NlD+Ob1BUscdZpD7SIYsou/OabKbQ67VKWM/7nYtbtkdQpT/C30RpBU7cb
 FsABKUBWhHG27KCbd2DtjGGjdPO5uyHEelXQ82Uw/8CBSMMp6VwmyHgT34w8Vjmmta2s
 DQmni7e98/DxUCCT9Sp4FZgHXGglgB1e2uavsHCe0LIcASpQYMpcSWG+QLdRJ7x0AZ42
 BE+8SM3WzO5q8XDWEkWYa3SI7AHK68VUnHBVHnHh0ZTTnrJa3UGQdUjrWauRTDJ/a7C0
 nN9EjN24lOZKcdtT5kM1EDUgi6oqQCpqq2c418MDC9HW0S2oMeIyR63BQqr3L1kYSNka
 UFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779945435; x=1780550235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=35giVodLf81lJuJPIwpxYiwrV1aluPV9PhABuPn61t4=;
 b=sfucFiPSi4LAnYIMKyP/dVtJVeavoh/vWHoivnaS386f62v9cbopRlYsiAabZPtnhr
 FBHe/6eg+CKMYfoDIUH2edhe7nudIvB2C6txF4yeI22bppR1ncxbypH0ivb5m98Meufj
 BPkyil15v6qB7jkTmiatQ1GS61hmS5f1yuF3mKroy0ycICl/qBV/bvAIypCKI/BP/xI0
 tZPjrOMRPAlEmiMgftUMW0Y6x3fS5tr32qCEmPdd9xMLy1Ax/J4VBnK1I2oDBedVoz1q
 sctQ7en33221B8kP8mEF8VMuEfsdny1BlrXQ6hwt1BZVza4gwhE9u4qoJUG7G+JVSX7I
 8MFA==
X-Gm-Message-State: AOJu0YyZC0XVMifkvg15DI0UAWVG3pLbzUZVqfyXYJSK2LFjKMm8uonX
 tL8q2okGpSI8c6twXELduU4i8qGbFX/4uQwPyDgyHRNa6PMnbOwpfpv7b5K/y9300386/hORxW1
 ribw5r3KJ2fI0pRAgNmKfGV84sk2uxZttfxbCX3L7lIoF/jmkE4bjlk/wddMpF5mFxzuG
X-Gm-Gg: Acq92OHPD86G/+D4jTfpU2ShShjdOhDgyVLV4EvuUnHOEz5aAtp/uKKgktIQfzP37DE
 wZiOI2UIivaTyD7DUAdjCzeaoOB8CYfRyW0iI7GdlT1MUxRF5a8FWtwL9Irod8sL/aUwfOWPF8h
 i+EbdnTa7jHuKJVnK6wpaWGV3CuxgAM3adXtdeWa4Ut85jucqT/mGamOIVIYpouY6WGBlqscKu7
 x+kWcBfuIA914kM/wET6J0BleAoy3I3caJhFKls1vwW33yyHfyISVjqau6DUAnX0LgCiPHwyFG+
 5DiV+v2+1fullibjy+3s116SRf+Gd3czAprG8kIKN38Ta1EQS85ivtk+vphmJADj7L8t5atTnwM
 VVP+4DFgM8Lc4D1CHFaosEJeDBX1APWpBpNl+8ygqJK6lOmM9dEn98p5/ivCVkfdC5yLQ9ASLg4
 lznMjpI9Ih7Y/cFVeA
X-Received: by 2002:a05:7300:1493:b0:2d1:9b35:4edb with SMTP id
 5a478bee46e88-304dd11a171mr54284eec.0.1779945434339; 
 Wed, 27 May 2026 22:17:14 -0700 (PDT)
X-Received: by 2002:a05:7300:1493:b0:2d1:9b35:4edb with SMTP id
 5a478bee46e88-304dd11a171mr54246eec.0.1779945433731; 
 Wed, 27 May 2026 22:17:13 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304b984d9b5sm4094607eec.7.2026.05.27.22.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 22:17:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Rolnik <mrolnik@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Xu <peterx@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 03/10] accel/accel-target.c: move compilation to every target
 meson.build
Date: Thu, 28 May 2026 05:16:35 +0000
Message-ID: <20260528051642.115721-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FWrkXGn-REK6RgjZW29O6OJE9OwSs0H-
X-Proofpoint-GUID: FWrkXGn-REK6RgjZW29O6OJE9OwSs0H-
X-Authority-Analysis: v=2.4 cv=E/r9Y6dl c=1 sm=1 tr=0 ts=6a17cfdb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=P7G6aJzc36RU-8N-B5gA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0OSBTYWx0ZWRfX90KIegcqJGRp
 Hv5msNbUtnJtjdyAAEoopShjNHzD8iQeYCKDw/LfMEjc6kt3ijP7CB+3RsV2BaB+phUaKyS4mOw
 ej8zhJ8f7J8IeESJBmmrEAuYbdFso6DD3v2ziX8/uW3h4rVtUPxoZNQ5RhRkCNW0+pNKSccLFdF
 8vgbVqngB7vXBLzBuJDlCfRT0Tol8Y4offVEu5UZDBLNe/AbhzeYj7pH6k1dV2Cd/qCWJr6o5Ab
 G/z/lvrXDNQlBr/GL3ORcesNYTCmDZcfu8P2Y0KCLL9jPL3ma5BsrMsYF+3YgJvxfL07SpZ1Lie
 uba8ikVkRG5EvAp0kLLAxNlgj7r0KnjClAT/J3uAgutPnCNtKeiTUTvCyTCWFOay/6MtKZJ7t2j
 TB6J3wbtqWo1yFzL8i2q1IxDjd9Adyezulhp1iLVju7xjWs9azbnrkGH1Kt7najKjnQipuvOumq
 wSLWJ8UPYkd3quGk+zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280049
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

This file defines TYPE_ACCEL_CPU, which is accel-${CPU_RESOLVING_TYPE}.

This type is used to define cpu accelerators, and accel/accel-common.c
relies on naming convention to find matching cpus to apply a given
accelerator.

Since variants of a given architecture share the same base
CPU_RESOLVING_TYPE (arm and aarch64 both use TYPE_ARM_CPU), the
TYPE_ACCEL_CPU gets registered twice in a single-binary.

Thus, for the single binary, we need to register TYPE_ACCEL_CPU only
once per base architecture. As a first step, we simply move compilation
to each target/*/meson.build, without solving duplication yet.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/meson.build             | 3 ++-
 target/alpha/meson.build      | 4 +++-
 target/arm/meson.build        | 2 ++
 target/avr/meson.build        | 4 +++-
 target/hexagon/meson.build    | 1 +
 target/hppa/meson.build       | 4 +++-
 target/i386/meson.build       | 4 +++-
 target/loongarch/meson.build  | 4 +++-
 target/m68k/meson.build       | 4 +++-
 target/microblaze/meson.build | 4 +++-
 target/mips/meson.build       | 4 +++-
 target/or1k/meson.build       | 4 +++-
 target/ppc/meson.build        | 4 +++-
 target/riscv/meson.build      | 4 +++-
 target/rx/meson.build         | 4 +++-
 target/s390x/meson.build      | 4 +++-
 target/sh4/meson.build        | 4 +++-
 target/sparc/meson.build      | 4 +++-
 target/tricore/meson.build    | 4 +++-
 target/xtensa/meson.build     | 4 +++-
 20 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/accel/meson.build b/accel/meson.build
index 7da12b9741f..f67623a7b4e 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,6 @@
 common_ss.add(files('accel-common.c'))
-specific_ss.add(files('accel-target.c'))
+# file below is compiled by each target
+accel_target_c = files('accel-target.c')
 system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
 user_ss.add(files('accel-user.c'))
 
diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index 818256a1c31..004fdb5c6c0 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -1,5 +1,7 @@
 alpha_ss = ss.source_set()
-alpha_ss.add(files(
+alpha_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'fpu_helper.c',
   'helper.c',
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 4412fde065f..158ff07654f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -13,6 +13,8 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
 ))
 
+arm_ss.add(accel_target_c)
+
 arm_common_ss.add(files(
   'mmuidx.c',
 ))
diff --git a/target/avr/meson.build b/target/avr/meson.build
index 39e5eb02c2b..8bd70be6bd9 100644
--- a/target/avr/meson.build
+++ b/target/avr/meson.build
@@ -7,7 +7,9 @@ avr_ss = ss.source_set()
 avr_system_ss = ss.source_set()
 
 avr_ss.add(gen)
-avr_ss.add(files(
+avr_ss.add(
+  accel_target_c,
+  files(
   'translate.c',
   'helper.c',
   'cpu.c',
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index d169cf71b2f..83b1db39ca3 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -387,5 +387,6 @@ analyze_funcs_generated = custom_target(
     command: [python, files('gen_analyze_funcs.py'), helper_in, '@OUTPUT@'],
 )
 hexagon_ss.add(analyze_funcs_generated)
+hexagon_ss.add(accel_target_c)
 
 target_arch += {'hexagon': hexagon_ss}
diff --git a/target/hppa/meson.build b/target/hppa/meson.build
index f47e54f5fa9..9488e1dd442 100644
--- a/target/hppa/meson.build
+++ b/target/hppa/meson.build
@@ -2,7 +2,9 @@ gen = decodetree.process('insns.decode')
 
 hppa_ss = ss.source_set()
 hppa_ss.add(gen)
-hppa_ss.add(files(
+hppa_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'fpu_helper.c',
   'gdbstub.c',
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 80062d1d0d8..38edd70131c 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -1,5 +1,7 @@
 i386_ss = ss.source_set()
-i386_ss.add(files(
+i386_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'gdbstub.c',
   'helper.c',
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index c5a2953b29c..059d145ec16 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -1,7 +1,9 @@
 gen = decodetree.process('insns.decode')
 
 loongarch_ss = ss.source_set()
-loongarch_ss.add(files(
+loongarch_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
 ))
 
diff --git a/target/m68k/meson.build b/target/m68k/meson.build
index c36d817134b..b57ae79332e 100644
--- a/target/m68k/meson.build
+++ b/target/m68k/meson.build
@@ -1,5 +1,7 @@
 m68k_ss = ss.source_set()
-m68k_ss.add(files(
+m68k_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'fpu_helper.c',
   'helper.c',
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 9c1ecd1cf1c..47efcdca8e3 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -2,7 +2,9 @@ gen = decodetree.process('insns.decode')
 
 microblaze_common_ss = ss.source_set()
 microblaze_common_ss.add(gen)
-microblaze_common_ss.add(files(
+microblaze_common_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'gdbstub.c',
   'helper.c',
diff --git a/target/mips/meson.build b/target/mips/meson.build
index 5acb3a2dcf5..0a9c149b461 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -1,7 +1,9 @@
 mips_user_ss = ss.source_set()
 mips_system_ss = ss.source_set()
 mips_ss = ss.source_set()
-mips_ss.add(files(
+mips_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'fpu.c',
   'gdbstub.c',
diff --git a/target/or1k/meson.build b/target/or1k/meson.build
index 7cea45287a2..baf79ca7087 100644
--- a/target/or1k/meson.build
+++ b/target/or1k/meson.build
@@ -2,7 +2,9 @@ gen = decodetree.process('insns.decode')
 
 or1k_ss = ss.source_set()
 or1k_ss.add(gen)
-or1k_ss.add(files(
+or1k_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'disas.c',
   'exception.c',
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index d4ebbaf0a19..bdc0e33bc9f 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -1,5 +1,7 @@
 ppc_ss = ss.source_set()
-ppc_ss.add(files(
+ppc_ss.add(
+  accel_target_c,
+  files(
   'cpu-models.c',
   'cpu.c',
   'cpu_init.c',
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 79f36abd63b..e2637fd4553 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -14,7 +14,9 @@ riscv_ss.add(gen)
 riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		     if_true: files('common-semi-target.c'))
 
-riscv_ss.add(files(
+riscv_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'cpu_helper.c',
   'csr.c',
diff --git a/target/rx/meson.build b/target/rx/meson.build
index d80ced11e2f..7e5218c8318 100644
--- a/target/rx/meson.build
+++ b/target/rx/meson.build
@@ -4,7 +4,9 @@ gen = [
 
 rx_ss = ss.source_set()
 rx_ss.add(gen)
-rx_ss.add(files(
+rx_ss.add(
+  accel_target_c,
+  files(
   'translate.c',
   'op_helper.c',
   'helper.c',
diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index c2cb4aca469..9c8994258c2 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -4,7 +4,9 @@ s390x_common_system_ss = ss.source_set()
 s390x_system_ss = ss.source_set()
 s390x_user_ss = ss.source_set()
 
-s390x_ss.add(files(
+s390x_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'cpu_features.c',
   'cpu_models.c',
diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index 3861d9b194a..ea9cf3905a8 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -1,5 +1,7 @@
 sh4_ss = ss.source_set()
-sh4_ss.add(files(
+sh4_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'helper.c',
   'op_helper.c',
diff --git a/target/sparc/meson.build b/target/sparc/meson.build
index 46289c86693..e4cd25b73c0 100644
--- a/target/sparc/meson.build
+++ b/target/sparc/meson.build
@@ -2,7 +2,9 @@ gen = decodetree.process('insns.decode')
 
 sparc_ss = ss.source_set()
 sparc_ss.add(gen)
-sparc_ss.add(files(
+sparc_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'fop_helper.c',
   'gdbstub.c',
diff --git a/target/tricore/meson.build b/target/tricore/meson.build
index 76cd78e990e..abcef2af13b 100644
--- a/target/tricore/meson.build
+++ b/target/tricore/meson.build
@@ -1,5 +1,7 @@
 tricore_ss = ss.source_set()
-tricore_ss.add(files(
+tricore_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'fpu_helper.c',
   'helper.c',
diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
index f8d60101e3d..dbb89638f60 100644
--- a/target/xtensa/meson.build
+++ b/target/xtensa/meson.build
@@ -3,7 +3,9 @@ xtensa_ss = ss.source_set()
 xtensa_cores = fs.read('cores.list')
 xtensa_ss.add(files(xtensa_cores.strip().split('\n')))
 
-xtensa_ss.add(files(
+xtensa_ss.add(
+  accel_target_c,
+  files(
   'cpu.c',
   'exc_helper.c',
   'fpu_helper.c',
-- 
2.47.3


