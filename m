Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02006C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xb-00005l-4n; Fri, 28 Aug 2026 18:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XY-0008VW-56
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05XV-0005iI-F0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTSqs015055
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TyE4vdeEp8C
 JsgUjR0QDbBBdvB4ulAMI0trIdFd8j9s=; b=BAOSoNPvapxe4GKNQp64vT/GZgY
 Cg9r/A3tnCYPcKFpspSDI74cgQg+lhSQCBP+x4mKUN+NezARXF+sDkTX2o7LzZlo
 sJXTAZwNrnP+nw0PxzMHJlXMUT/WTkHNjfDE8PaaskzMrKOhytudi08oheylDPEa
 rI1LiselyId7hHJwSLcgSdN+mPPXlo18KbJdoq/O0zcLhzIKdMYF22PWssf52Gnc
 VWxIKKC9v3YFGlTodE22koN4/RvKP6TQinY50QfR/OCJC3jcXktBxQlAUGludw8t
 uieV9g6PEy9YwPn7HmRf4XZ1/TnOMoGiNNOu3JbwUdP7S1V51AYliL7meMQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgvfgf3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so2583173a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957947; x=1788562747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TyE4vdeEp8CJsgUjR0QDbBBdvB4ulAMI0trIdFd8j9s=;
 b=hmiQcr3ch7i2TYX3a87CGc8YIYIm40l7llNh/Kh/snsgS6XMtxlLmdjuoI9vwVCmgI
 QMKigB4d+05vnA2JkxTOvsTryl2Ug0Gog0KpvFN16ulhyEb7CigGTRUnhyouvf6gxWOG
 8I9JYdglcNqchotD//P1vPeWmqSNxtNu8uzrG0ynM4320R8y9GUI+vCJYwhfnEL99o9d
 p/GdcseTAuwaATTi2o6o4oCi9ftg+QxwZWtJIz6mRDvWsbK18gGfUGLEomdemjuztPxj
 BlyJgHQy9HJgAbdVbEXwZu9Q4Z/qavejj4D69BCN/oETONuPFimA7h2esYg4AKG1ZeDL
 SAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957947; x=1788562747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TyE4vdeEp8CJsgUjR0QDbBBdvB4ulAMI0trIdFd8j9s=;
 b=HTIoLe4GckotR/Mqraad2UPbhCaZuQMVp9GeeoQqrhzikaME5t9d/uhWPm+oO/Hh3z
 dWzDhw4sJFJdY0b16gmgjikO6KuEVbcHRf9nlUcwQmA6Z6r+xnwGq8jD3Tk2U6lpEf1h
 mIY/cAnzrZUni/dcy4EpWrUwAoJ6WKxSTqzF7eT+KnTKIBt9nUkx2uDNWVvDgo5H2zXe
 Ev5NrxZRnydW8B78T8Q/QyNvwNdTHPIiXCOaiCMiDt1+cyZnkMYeGCLny1RHkbLHmPI8
 NjwKcxiJmXLdhsB7QiSxlxj/0hGGgCGYXOA99dxdtMdIMTsuQIhJnWoX2IJ6csTbfgBr
 jmGg==
X-Gm-Message-State: AFuF++nUNOaB/eO8Q3dK5i/i/HZoCxAxTAs5Vh3fuHncq2RP/ikUrw6M
 9aWnMahNIUv9REovgY4GUJCYKbldx3Kdy/5CaiTYdFdF93zP4NDA5KRI9pC45UIshTCt8D3MiST
 a/wXsA3I6J4DxOoii6gpTwQ/NYy+R3zWcn4Q7ytAKUaJDeB76a+IqPwfn9FMfz8cOcA==
X-Gm-Gg: AR+sD116NlpWPRb8k8ug/brZmriE2aqlX2JdvB7OLVeyNj4ZFQJJEVMiN7f5bWs8q0s
 dN61rPNpKIKzDNaWu/lekxyHtwAPfmWSBnzg5wbJsyOUeOdJRcxglcGqbva5bpMJzGrZXXwz+7i
 5LNaWtX9swB5xHPO6v1ASmvAVMI6LUfFtghsyRC97Ssx7msZ3VRI2XJpd9xqXfKArpIHKwBCTse
 RHGXw8GzPCYZ9JUZi6MahP8fCJTQ7KUiyQLuvsGeew2DYCgP74Xp/ZaeZ4dOhKQ1SE0jmvgGHqF
 OKh/xXdOhkmXopIUevbbW7RYyBHAQL3S6yhr7l3DuU1uG4MLm+XqucAumsE9IocU8cqPHoz+7Uk
 /r4wULlCE3Zq6dAxkh2dHfp0YPJ8/EkkFBrN5oxirR/O37mZUb0L05QvzVPY=
X-Received: by 2002:a05:6a20:9c98:b0:3cc:8f53:26c0 with SMTP id
 adf61e73a8af0-3d26920cce2mr21225231637.17.1787957947132; 
 Fri, 28 Aug 2026 15:59:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c98:b0:3cc:8f53:26c0 with SMTP id
 adf61e73a8af0-3d26920cce2mr21225191637.17.1787957946738; 
 Fri, 28 Aug 2026 15:59:06 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/47] target/arm: Build cpu32.c once in system mode
Date: Fri, 28 Aug 2026 22:58:16 +0000
Message-ID: <20260828225901.367438-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXwtea0WxhIeuO
 982Ijg7XBdTUaLbJUv4TYpncMEau+BmqGvyL5axy2Z0DQ6qWLsFY6lO2YL4+TYZfRwq02USbexu
 Un0FL270HrXGILQLpz6nvItt45FA34zfjMNoK2v8ytuXZRG9f/BVj6nikyW3vGt3w3esCmiql6T
 TggKy4nHd9OSO96sh9AxjsYvR1friNdHWos3v6e4k4jrFJQxCA9K+3SGSST7p3H0SPym61ex2Ic
 yIMNqPl38r3xrV9XtPc6ni85yQaqIbaAVqbHqXq9N8OGpc+3hsJtOxKhW857W/bV3aZ3r53xmW4
 jfwz1HOdXOdUAqwjx+2B0gHkieCskptJ62no0c4RPZ2Va+YPehf3XkpsDagdwaaoDfEK150Fq9y
 BgQr6fi05w44kKSlX9dYhKs0qpiAJxVL37fwcPCbG5u2uB1YHvF6oPgRcfeb6hXfXPuWgQe68uV
 9Ll8Mj1sV5XLi86hRRA==
X-Proofpoint-ORIG-GUID: g_u8Z8Bc6MEW63Oe3Fp2o2TKcrE7NTf8
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=6a9212bc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=I96WErnV7fbJyWXvMysA:9 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5IC+EpSEaFX0
 jjyLFfmUwA8YEYkS0mcqoVKd04SzCCdSJAHVUPAv4Kv0yitsPLyqMBjqFFp+Blh+gDkHKXzv/eq
 1V54/cAXbipcCyGAiLxHmQZUkCfdw4s=
X-Proofpoint-GUID: g_u8Z8Bc6MEW63Oe3Fp2o2TKcrE7NTf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

From: Richard Henderson <richard.henderson@linaro.org>

"Move" the ifdef to meson.build rules.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/tcg/cpu32.c     |  5 -----
 target/arm/tcg/meson.build | 10 +++++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 34436ad6ec4..2d642ef8787 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -19,9 +19,6 @@
 #include "cpregs.h"
 
 
-/* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -756,5 +753,3 @@ static void arm_tcg_cpu_register_types(void)
 }
 
 type_init(arm_tcg_cpu_register_types)
-
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 35e70b004d9..a3e9d55e853 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,10 +30,6 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
-arm_ss.add(files(
-  'cpu32.c',
-))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'gengvec64.c',
   'translate-a64.c',
@@ -49,7 +45,10 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 ))
 
 arm_common_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
-arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu-v7m.c',
+  'cpu32.c',
+))
 
 arm_common_ss.add(zlib)
 arm_common_ss.add(files(
@@ -86,6 +85,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 ))
 
 arm_common_system_ss.add(files(
+  'cpu32.c',
   'cpregs-at.c',
   'gicv5-cpuif.c',
   'psci.c',
-- 
2.43.0


