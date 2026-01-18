Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99930C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb3-0000Kq-HC; Sun, 18 Jan 2026 14:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZk-0006aG-FJ
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYZh-0006rP-Il
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so21974645e9.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768764995; x=1769369795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3ZoIJR3OjEuiKDmyBptqH1tgWzQzhR33On1g0jSsHA=;
 b=lkOpu1/vzmnfnPyp07+jX95k1TwVkWKR3Jef3A8sXbROGM1f4ucilatXXiifTV2sdb
 7+BJzE7TY5cPDYNvzab04yXucV5J5/xr+Zfs7dLg2L4ewsoFm4HO/hccgBAhv6VepjMp
 CtsAkNktu5oGmPwIe/NA11OOMlYjbjT2CcT3g0QZ1EQ4VpDv2IkJvLQPYGm+OAU2P3iJ
 7HcHYBwsnKTV1nYeRfOvQeUCL7YJnrqsGXSpFLkU8ZvENUuxFCbLNs4d4RpWn9qgKKVK
 LCKvLA0PIyytRHqH3g0Fyb4qas42NXR8O6IZOxsVzkSVc9bBhRpUM1peB7VBiOKpri69
 htXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768764995; x=1769369795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X3ZoIJR3OjEuiKDmyBptqH1tgWzQzhR33On1g0jSsHA=;
 b=sFNak6/JvhwJShHvhkLBapuYFPFRNQwTKoHLMLag0BSOxABhpXMryBMugyUYduOu1E
 B38TYKygM09QtVHZOVlHx20fxLkIRgr28EPC0GV8rlE+WZE6Ft5FosBQMpgXVdv9Eu+I
 3IM0J/kBg0KlpdjqS17sE8R1jOlzBcsIzarbdntuIHg1WVJHJoKdJ2J7ChC5dIbVvcDf
 fTF2SQaS0XHnu9dNnQ3ITq7VHLIhEAHvizhOTii/Mt128fT8zp57ur7D4MK30uSG/3X9
 0craBLnjKaEMFP4/aS4Cyuz/h4x/9P1PAoFY73brihTRSSQy6KZly2W93rB736hwxaIY
 R+ng==
X-Gm-Message-State: AOJu0YwF7S6ur+sR56svIjN+g1SAUkUBh0M2LWfbA7zB4hE255j4rcve
 EcrDiRcdfUpOJS64qMqZYl3zSeKIW6jkrlqq309aHOquabdL3ahCLsjiVS1VTHyl1wVp//KibuS
 N0JwCwU8=
X-Gm-Gg: AY/fxX5x1J6TkpI+tLzC9e+D8dx9EA9ThCaxqs6UPqYcPmlR640us7odjd3GRzvMF/7
 I4qsHmtkpswcv5pioxlX4b6BI861DZFACr4irGohkGgFYmBm7Jka51V7or6VECzu1wYYmJtNfpc
 nDicuPID2jS2KtWtn7fchNdCDRMvxzKUbU4qqRCbpSdpNXAMkAO3yU4m/W3Vs47YMtD2fU3Ac8a
 D2vC4DCHgtNUfgKDU/OoRZd48GYkO3I0SkXBl7Hg04NMM1y7CjfRBrmoS/alewxpfiehdub3Rxn
 wGJp5S//e9u+pVtfKZ6Pr2b8jfRRr6tBdsfP1k65RbXGRA5Yk+E2LPSSoJRp8aMMMsi0k4E3hHm
 xahb9ywqdGvBMsTo7KZO45Ia9eDaMnSRdZcaq484x/JDo0HXIU5w4troVuzERsPQiDyBzCUS1VK
 KzGt85hbDXs+igshr/MDupl3sHdmzTghjPNQ1HSCiMLHY+kb2Akcc/phMhFTc4
X-Received: by 2002:a05:600c:4e43:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-4801e34835amr110514955e9.25.1768764994567; 
 Sun, 18 Jan 2026 11:36:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996d02dsm18707790f8f.23.2026.01.18.11.36.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:36:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 12/18] system: Allow restricting the legacy ld/st_phys()
 'native-endian' API
Date: Sun, 18 Jan 2026 20:35:02 +0100
Message-ID: <20260118193509.42923-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Since all targets can check the definition, do not poison it.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_ldst_phys.h.inc | 2 ++
 scripts/make-config-poison.sh         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index f4c91dc7a91..66bbd3061c2 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -31,8 +31,10 @@ static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS  _le
 #include "system/memory_ldst_phys_endian.h.inc"
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 937357b3531..b4d61e8bc9e 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -11,6 +11,7 @@ exec sed -n \
   -e '/CONFIG_USER_ONLY/d' \
   -e '/CONFIG_SOFTMMU/d' \
   -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
+  -e '/TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.52.0


