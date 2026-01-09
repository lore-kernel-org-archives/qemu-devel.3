Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BFCD26D7A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjq-0000YM-7i; Fri, 09 Jan 2026 11:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjd-0008U8-Ix
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:14 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjb-0007bE-U9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:13 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477632d9326so27309165e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977589; x=1768582389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCyMmfY1je4KK++qvAKc5w59+JOFx7vAsdkNeOooSpo=;
 b=xWcEZCXhCrIBoVHFfdQBEBcTau08RkSOG4B4E6zTY3DHNYzYozUawKAMjZCWQfSb0o
 WsHDolm9I5QGJCxzna5L1QQWlkTPTL3UgpL1a8ysGVtEpaWmgW2Aw7zDSJKg7R9WqKU3
 Rn7tdDwJSxjiyT8rrzQeSHFt5AYGJ2dNlmaq8S6RbzQ1LfBYlw7vyzSt5Bn8bNX30Hng
 Xq5ODwR4UIynXYfkgak/UdVeipaKKnZ3MRg5ZLNhVan7vps/Hw2c3h7SyBKlIFTYgt5p
 iqiw381iyyYbjRqGRIgFocLoI5MK7bBZh4KBv+BqFPLdd/7Oif8I86SDzNrEq07597Hg
 Z8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977589; x=1768582389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uCyMmfY1je4KK++qvAKc5w59+JOFx7vAsdkNeOooSpo=;
 b=Vyf8F/xZoMIzrgLHTVjYXnesDQ7FH74ESiN6UKM2c96THGlA3jRmC/Rm6/vNhO4jXo
 AdAqNVHkfqgVQt+H7W29Wz6d5tc8cD4RNUQmc9LuhgTnI8PoOlbweQg0hjzYKONKVRTV
 u1mzYOhOG3EUgCvVV7lZPVVvc/CNSBNJx6FewXgE60Akb7DDTxz0MHgN8dM7p1ceMXvd
 OFnZv9mVWkhuiuY3M9TD2Vusr3jYtyl/3re1okHNxjvU543JOYX1UE2bJKTHlr+G/KXP
 vCfbh9ksZsySd3NHkwu4wu31ZH+UlduUSCt6IaMcysc1XeFowjGxLX7Q5dzaBaynJo3/
 zGQw==
X-Gm-Message-State: AOJu0YxpKubwIyGcV3waL4SG/yARFq51YpSAYU8iRpvNV5bM/taXMz6F
 msqP88bvU4gbGJ3pMoeyxaOb+ixix0/vOHDKg+jF30nOqityDpBjyYoTIjfF7KhHbJr1NhcOsDo
 m9axnsMY=
X-Gm-Gg: AY/fxX6fdbx8Pjrak2QF2xQRFRFHfGCpibqz1NMoLE+y6RiYdyplet8T06e6y283ES1
 zEWsKjxqvytrsh6jPRHWDdAMRs/zpp/rF0wp5tftNtJEowIw7tNma0sG4Z4E32qG/WJD02UBFHb
 e5WLXaVLbhkTVJFIXt9UYvmk9Ssrzt8CDqhbhuKNM2u2PZG/0O7Y49RQdWs0C4cDHv7/g22OanP
 jq8NHc3amj9sr966blSQd6Tri0Gx0kSIfLo3cwRkxuwjYO1Zax/m6LIukcflH5BoARE3rtlCaY+
 pkcc3MthyNvCfYkYgHuLDdUEGFSfoEnWQqybNTmyrzBYZvlM6ed01mKYMlEkLNBCCDFQDgDRsjz
 uVLiZtfMSeIXcMFp7qRa3f9kgoWG9KTnnxEahPlaJgBz9JjWCCfs9ZmQTEuD5Ie6S+TtdeX8ebR
 imCV4OEyoew22SOsYqwik0o+BaX4OPXgn3tAUEuVn+EWySpOmMiGB+BySvaJue
X-Google-Smtp-Source: AGHT+IFGJnvyZWZ1AjLFB7MJDn8krIPBrH3fe02U/gXWaKQ9AsNlibaNg5dWyTZFEoQ9L4Z5uP7GdQ==
X-Received: by 2002:a05:600c:630f:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-47d84b3b4d7mr117619205e9.30.1767977588845; 
 Fri, 09 Jan 2026 08:53:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d87166d0csm69469625e9.6.2026.01.09.08.53.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:53:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 19/22] system: Allow restricting the legacy MO_TE*
 'native-endian' definitions
Date: Fri,  9 Jan 2026 17:50:55 +0100
Message-ID: <20260109165058.59144-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Guard the native endian definitions we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 799b5b42218..4aaa6a0ab02 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -36,11 +36,13 @@ typedef enum MemOp {
     MO_BE    = MO_BSWAP,
 #endif
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
     MO_TE    = MO_BE,
 #else
     MO_TE    = MO_LE,
 #endif
+#endif
 #endif
 
     /*
@@ -150,6 +152,7 @@ typedef enum MemOp {
     MO_BESQ  = MO_BE | MO_SQ,
 
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
     MO_TEUW  = MO_TE | MO_UW,
     MO_TEUL  = MO_TE | MO_UL,
     MO_TEUQ  = MO_TE | MO_UQ,
@@ -157,6 +160,7 @@ typedef enum MemOp {
     MO_TESW  = MO_TE | MO_SW,
     MO_TESL  = MO_TE | MO_SL,
     MO_TESQ  = MO_TE | MO_SQ,
+#endif
 #endif
 
     MO_SSIZE = MO_SIZE | MO_SIGN,
-- 
2.52.0


