Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0386ACD37A7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtY-0002oQ-Qt; Fri, 08 May 2026 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt2-0002c6-Bm
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:08 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt0-0001dQ-L3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:08 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-66ee7b9af94so929110eaf.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253185; x=1778857985; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sHgtjD14wO1k4IMIvHt33UoGD2X3GvWB8k5KsdzFV88=;
 b=l+e2XteYDP6dSpBNd02SLDyC7CCW0BMbJUCeoMrb3TYr4oDK6oHFuZqV5D2L96YMTr
 /1jP7RrIGHlDt1Iam4OEMIpjZpUfnfCpjYP7TkZxePsnYVDTJC4TtMog8CRr9Vhlv71k
 U+IPzxrZdBcJGNklvMoyymUyQ4iGz04xE3XMPwiy5U9gEnVPt1SwrNdfgHIE9+4+qAdN
 jKrXroNDccEGpWWDlIbnmn0xAy+2pymBJADR4rzs42A01L9Rq8O7XJ/byGREcDMESXX8
 FEmcAs1VReWyaC39hdI6+mktihhp5S6ORdpqWsdmG+xkNNzdCj0EizDdG5UClmbzSB2e
 p2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253185; x=1778857985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sHgtjD14wO1k4IMIvHt33UoGD2X3GvWB8k5KsdzFV88=;
 b=oqAFVNaSuESkLVglzkTbLVrjlGDCZ4eqmviiAwgoGWk8pQ0vHlxT3RJQl+YwA0Trgu
 BzbLf0xAt+nxxQNdmdphRLNqlki1jClpcthHSZAxhXcSm91FnfuwXKPhBkmgRGGYbZ9O
 Bme6imHrzJqHK5k8djukf+kPs9ulEdg/ZIFTmU4qeW6TtvG54rTK4AfHXbqrsh009mRY
 +LMGDAZfp2WGcYx+DOPxm3TMhYXtXvdC3T3M6BJERKAc9IPXqDEDDn5En+Xi0wRGpPhH
 tK3743Cm3cHS/F1vDPm2rr6ugU7UAb10Hn010pfM9YISil2Iw5Pu+JbEqowuTMkN/0jI
 x23g==
X-Gm-Message-State: AOJu0YwojCuW73trs7RzVNDm++TAZC9xcJfz+I+9Tr5VBpmFdHL8XBoS
 7ZAHpaon0iijXOSp1sf2YR3Qf+zCxI9RFTHAkSKMjfxKJFsBmn1vqSyrcQ2Kpw==
X-Gm-Gg: AeBDiev9x7xhY9u7Vr8/rMMddzXO0XxO2kyPwCvgaaBZyMmTkIhPmwXWxCgLI6fd126
 1rBqNwZ3FqUus10s0h218ZlUV8j2NZdXjJsml6XIHfJawlgjNvNMP/4P8a/pGUXY0cO23TOeRd0
 C4e8OdomYgbeTiouOALotHF4XM1J+k1p5/ZdhzehqLQhoRHdHLUr9SUWgXgwRVKkDo5adofhKMG
 XTu9uQH7rkka4Z06phgVm+vsADWH8/c2IkZInlh5Xh2Jf2U6O7X0z+5VPV7zmddmTUYhh4T+0bF
 mTqc92Qex+GmfAGci+yM18mQGhe/CRmErQttPQtqZ3X3RrOzFryqFLG+JsGn73PKgYDvddAZM5k
 pV6xIrGbcL3CDSfD2/4+5Ej1wlIJeEjAKYDNimbGBSwBtyUhrsqoIlTioOP6Ga+mupjF0/S+uJf
 xHNbs1zz7VvminOMvg6OKGQXuqIqnkD8daiJxQC1FVTTp3uF0su3zPLTnu2/aZskaO+GDSa2R7s
 FA9BGqaNvmT0lask1lAQChpCKzXBEsljp9GKJhOtBXJpBqHGaz/k86P3RQT4EJWuOF5pZFDm77Y
 P2cBGYSYtGL2t2SyP7a8Wzmc0FbaQE4hEDHa2ZpbnWxPgiD8kXgG2uXlGtqg6X27kJWI32oCbxl
 6SWG7lw==
X-Received: by 2002:a05:6820:1529:b0:686:48b7:d822 with SMTP id
 006d021491bc7-69998d2e673mr7034841eaf.39.1778253185173; 
 Fri, 08 May 2026 08:13:05 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:07 -0600
Subject: [PATCH v3 07/32] target/mips: add Octeon multiplier state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-7-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add per-thread Octeon multiplier state for the MPL and P limb banks used
by the VMULU/VMM0/V3MULU instruction family.

Keep the storage in uint64_t arrays and migrate it as an Octeon-only
subsection, so later instruction patches can update the architectural
multiplier state without mixing state layout changes with decode support.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split the multiplier state out of the combined Octeon arithmetic and
    memory instruction patch.  (requested by Richard Henderson)
---
 target/mips/cpu.h            |  4 ++++
 target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 84d12b77f9..c6d75c67ab 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -497,6 +497,10 @@ struct TCState {
     target_ulong CP0_TCScheFBack;
     int32_t CP0_Debug_tcstatus;
     target_ulong CP0_UserLocal;
+    struct {
+        uint64_t MPL[2 * 3];
+        uint64_t P[2 * 3];
+    } octeon;
 
     int32_t msacsr;
 
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 5880b401b0..d6d6c23ad2 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -120,6 +120,17 @@ static const VMStateDescription vmstate_inactive_tc = {
     .fields = vmstate_tc_fields
 };
 
+static const VMStateDescription vmstate_octeon_multiplier_tc = {
+    .name = "cpu/tc/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(octeon.MPL, TCState, 2 * 3),
+        VMSTATE_UINT64_ARRAY(octeon.P, TCState, 2 * 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -247,6 +258,27 @@ static const VMStateDescription mips_vmstate_timer = {
     }
 };
 
+static bool mips_octeon_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+
+    return cpu->env.insn_flags & INSN_OCTEON;
+}
+
+static const VMStateDescription mips_vmstate_octeon_multiplier = {
+    .name = "cpu/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1,
+                       vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_STRUCT_ARRAY(env.tcs, MIPSCPU, MIPS_SHADOW_SET_MAX, 1,
+                             vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -363,6 +395,7 @@ const VMStateDescription vmstate_mips_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
+        &mips_vmstate_octeon_multiplier,
         NULL
     }
 };

-- 
2.54.0


