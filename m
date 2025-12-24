Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1460EE776C1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQk1-0005jU-9e; Wed, 24 Dec 2025 10:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjm-0005CM-P7
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:20 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQjl-0005AF-8X
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:25:18 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so486880a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589915; x=1767194715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5/ovXmrcG0g8YopLTxIZH1Zb4vMJsdoapS9D5bHTV0=;
 b=IboLRbub2iamHpp6jZvcpoqKF5xsCxqsg70VDD8kqPWSblD5FvyWzceGL1VcWjf/tx
 p1csvkb3AsDfIEsqPF/gFY9RDsoOd+wup4x/OtQ/dRLTv4jRpKAp2NPsBV/esIakMckj
 mUcIrMGC1Tf8g+7x2GSdQ/UdNH0UspTwDR8EAM8ONvFlwMnsbnq4BMBTIP9dM9ZZUSRU
 BR7jxz1awjVuOoEyVfmnJ5Vhw5EhbQcNlGRltDU7V5e3KnchgNF6PzRaE+AYTW1IBRXf
 bQ3Nht7ICvnJnSwhJJVWYMRktmTKO3r5vBTS3kC898TqHDs8pJ6+N+tdgIBo1ZFjmxqC
 c2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589915; x=1767194715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5/ovXmrcG0g8YopLTxIZH1Zb4vMJsdoapS9D5bHTV0=;
 b=IYLIq3dcGwhttdJ1/makL3N2A8CexKDZmq0l+jPqxUNpXhLsh3Ml5Sq1UAY3gjbqOA
 OnitaEzGZDrTHhXqQtJre4JzLc3ObQ2nG2LnwQHv/ObIbK5MvoKPeRFuFx7lW7QyukA/
 pTenLgE8oqriuZOMJDGzwkF4/oJ5EOX5iafLtcAELDrpUCib8yqo7FaF8v1uWrmyZjXF
 P55QaE5SlvZzcIOIVPD8vAs0bJy5V3tuO+Qj2UB9UjbuMQ3R+pI0/JH0bci9J0qaFFIz
 StZZms7Uxg6AH1VYzJtY9Xg48qlVwdseIGYrwr0ybYEMp77FGVsVjWSa+Xf1ehQGiQaV
 N16w==
X-Gm-Message-State: AOJu0YxziUAEcLD0dpG0QVYsXV/iXtOLiXSqE7K/aHN1CdPxpfHyQm4D
 4QtvxOzGxNX1Kcm0Eex8P5Y33q5y2sRVYOFfIOsGSWjoEc9AxoWbgaYYKRWTRhJdsyPXkixLtHO
 Y0tFGFDU=
X-Gm-Gg: AY/fxX4vQuC3AlYOSMvwTlG/s4Txva0XwjrpZJAfdc8Hc0GMUZIOvtvK6U0GQkMZH/E
 Jc7w3ZpZIt/fgtwGee0IVqx6uG1duCVFfbpLrYpByYLq6b0uLmN+ppwKFeBaTKGi5zoj8oR27JW
 hXBoncFoXv8t7o5q+wWtTMN2EDnnxy4DNnpixmmYchVNRsEqNMbzTc/4YNhmvKo5SbE+XRebwPl
 vBop0+CdzzBDYtIFNKXaGELFJWG5uxOpkgxWDOO1cBJU0ziYoZqd1vIj9ov+58VMCsAHkRM3FSt
 tGd/uN0IhAUaD1+VwL7/Qq1DbiHvmjP6g6Fz5iuH12hz25ID/mmM980FfqNFwD7uN+wID1OBY+Q
 xR2sKb/EFkOOX2Bl/Xj/B7oe+ZNgjzd09m7zlCqlwGan/kS2gUPQtoWdAmuWVKhzzI1Ohkd8yK9
 mSFkIeRT8rporDp4gmVIRLNAJ2qx76CJia7dbDgU7huE+VAkiqjdEmuwoo4rgUz3duYw==
X-Google-Smtp-Source: AGHT+IEQNtUtd4TgSBHRyaiLFd66RBaiJPZ3tOzRSbpjQTtslQYzU5A5d2oFthObj1x3otvlpqF23Q==
X-Received: by 2002:a17:907:3e12:b0:b7d:27dd:9a54 with SMTP id
 a640c23a62f3a-b8020634a93mr2305767366b.31.1766589915188; 
 Wed, 24 Dec 2025 07:25:15 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b80426fc164sm1649783466b.30.2025.12.24.07.25.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:25:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 19/25] system: Allow restricting the legacy translator_ld()
 'native-endian' API
Date: Wed, 24 Dec 2025 16:22:02 +0100
Message-ID: <20251224152210.87880-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224152210.87880-1-philmd@linaro.org>
References: <20251224152210.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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
 include/exec/translator.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 3c326555696..8d343627bd9 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -188,7 +188,8 @@ uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
 uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
                             vaddr pc, MemOp endian);
 
-#ifdef COMPILING_PER_TARGET
+#if !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API) \
+    && defined(COMPILING_PER_TARGET)
 static inline uint16_t
 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
@@ -227,7 +228,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 {
     return translator_ldq_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
 }
-#endif /* COMPILING_PER_TARGET */
+#endif /* !TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API && COMPILING_PER_TARGET */
 
 /**
  * translator_fake_ld - fake instruction load
-- 
2.52.0


