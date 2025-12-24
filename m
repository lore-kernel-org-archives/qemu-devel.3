Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC0DE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQjq-0005N2-An; Wed, 24 Dec 2025 10:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjV-0004zt-SX
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:03 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjU-0004vw-5B
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:01 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64b7a38f07eso7575779a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589898; x=1767194698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCJ1tlPjLJjE+wtGLHdyiDA4PF+BOmUksuMCTAUXTnc=;
 b=qeQJ4DcIciJMW8URZJ3P3cSYBMRtGPsQlCfgXzWk5RqJwOk9S79PsnV3Zf74fcVT5T
 KMdvbxFmLdlWct2lXH9hAH3ZF1Xp4mGsgjsWcapZvK3noHEDSMTq9+EqYCW7cOQ76HGO
 OnMagEwneYb3CV53G2nSB4+lVCcqt9HqMnVFntojQTK16x3bbsNb4ryAX/QX1rIEnQHy
 sIqGg8VnLMMHuD92P8A2gmy01O6toJO1pKR2LAw4fbqMRFIQAg6o5iEHM93eIEWatZXg
 TykfNEIy6qKwUBBplQg9BIh1BzIGlYoEeM6lMtdpPtA8J4azGLDydwx65mtA8t3MI+4o
 Zp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589898; x=1767194698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZCJ1tlPjLJjE+wtGLHdyiDA4PF+BOmUksuMCTAUXTnc=;
 b=qtLSSbA0DJyBQdgTWna2r0yXbKKnf5/Iwf326h3SVmyTmRSVB6c6SSVMZgaTL/SOJ4
 GpFRniFZbKpBy/6jObrBDhf/xPJaiZ3pCXL5k9D29b3cEN6knsz8g3G3Z8RMJ7I3VpLS
 uRc1eKdrQqZ53aycSL+xlGMUjDLs+dyrP8u+K3qZFPMHZqs9gbW7djOqYYXPgdzF2gHZ
 XQXzkrO4gV3hhHLDaDVxrTKrYNRKTQGLyKiBeasP5W65joIUwU9RhnCzahEvqPLC8qtU
 vZSYVda+CK9i4fxvsA6GM8je08+DoMXmQjXwjCS4G1Q2Es8qd2BDNGBt/5O8ev0GoKrK
 Lt6Q==
X-Gm-Message-State: AOJu0YwzjaPysl6fgoIR2eZKKXOI/Y4OYHWmX4AgOBOpnbRv5eeJy7QP
 c5XChFWcC3MeGvPFhp89qK8iJl1nhABKD/qOFMLrq/GtB1okdP10VdWffFr/7B11Xcc8b3dUkIo
 ufXn6xRM=
X-Gm-Gg: AY/fxX6tPPk8d/bTwJxXKh/57D5ZgURr744zDKD8PbjsNfCl95iMf7UE8VueOmjc/n/
 F56az//lyVMglcLSb2TmlMGcorYzIlJNf4QHi87r9sNDszTp60vjUbJ24pbP+QVq6lrutMkWLEh
 ar8K0f/dIVzoaiv2axa98GJExDMVICi0SjPj68RDEdMVS7Shnvur9Cpbzsx1Na846H4OiEb118K
 GqaWPD66cY67cbo8qh74DODWOJWqCo1vkavSXXMs2eOx8DGdnJXOT7Jh8CSjR7KDuOz+Dg4O2/s
 p0KblUyJ1oheTjXCeKl81CVrZRDCHJqqqigJTEqESbGi2kI9+uWxDTqbIQKLF22bZ9xzxqb2rEP
 tcbXqIUuWw+im7bVWJPc1ngmqnSSP6MIiFoC7aQNBmEswfsA7MyrUae05tuiYunASajljZ0BmyQ
 Uo8nhyyhPjwhqQc26wi4kR3uLl/2/An6WESWkumXaG4qT3BuXdImBAklU=
X-Google-Smtp-Source: AGHT+IGW37h7sre+BEeKMCinxx2coFEHl3FtLiSSgdBxgAXA7jhZhxO5qvEs7XTgMWe4xL8KT1ATwQ==
X-Received: by 2002:a05:6402:510d:b0:64b:7eba:39ed with SMTP id
 4fb4d7f45d1cf-64b8eb618f5mr16551561a12.13.1766589898409; 
 Wed, 24 Dec 2025 07:24:58 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494ce2sm16989986a12.17.2025.12.24.07.24.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:24:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH v3 17/25] system: Allow restricting legacy
 address_space_ldst() native-endian API
Date: Wed, 24 Dec 2025 16:22:00 +0100
Message-ID: <20251224152210.87880-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory_cached.h   | 2 ++
 include/system/memory_ldst.h.inc | 2 ++
 system/memory_ldst.c.inc         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index 587e8a1453a..e46658400d9 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -77,8 +77,10 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_cached.h.inc"
+#endif
 
 #define ENDIANNESS   _le
 #include "system/memory_ldst_cached.h.inc"
diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index dd1fb482eac..896550bdd65 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -25,8 +25,10 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
           hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #include "system/memory_ldst_endian.h.inc"
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 20a2784e234..e4b76d26dd9 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -117,9 +117,11 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #define MO_ENDIAN               MO_LE
-- 
2.52.0


