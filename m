Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F85C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT7-0007Lx-CD; Thu, 22 Jan 2026 03:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSf-0005YQ-Ob
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:44 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSc-0005xS-B8
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:40 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so601892f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072076; x=1769676876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tbe+CTrwsu3putFe+VHS8JrJcH31OtqQG7lmkaqG/hM=;
 b=p5IwZOSHxidVDKU8bXn63C7zEmswmmY+ycNaphR4XPSvujXccQwiLYWLOLTJeqLL21
 MJHLDFG6jWJW2VZH/8qaV45NERYDUHrjZXFSLYmjQ+64eFATo1e6fZT8AxTWhjqs+xGH
 DVgKN8VJMBrvrbzvrZbX5KsrXXPa3jIDDWsic71g/fxtNB034iOf3Lbgu4LxWKNgYhIM
 8FvyyvzjPpbE5pftxb+wsif4KQBGiAQGriRNUs5AwrtNcq9fYsbQmcN3rLbAuTGUFDcB
 SnlqOOA1/OYkedRif0LOJ2DxonlECck56jWTSFsnJlOb0x1HY85uBjS1vqWmgpq9Uf6q
 2HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072076; x=1769676876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tbe+CTrwsu3putFe+VHS8JrJcH31OtqQG7lmkaqG/hM=;
 b=Ci6Bv5yAEp+8gE4lqFdBTjjOiVpXM7voowGQkohrHGSxTbLnRaFZYrf5zOOUfqMJ+T
 FS9jKgNXb5X4mUvMYG+SRjO5bYI6JWvey8dnIufJAsZGn8PRU85ox4gIbnST/SSg4hJ/
 2fDWFbm5w8nU/hCktVLl79u05qSKz413Ka0jWPn6MibXfTdqIgztbSDXLubIDfEBGXRo
 /B8nmSm28vihtbjtwmei1FawIBkePsSrs26RBWAOsP4BoigYRuVeEpEgklyWU8BfZ0Jx
 0Dpcr6O45GiDq3a044Swdacln8zVrrX9C768n1rks2V68Z4V2b8aEvr20zPssOCunSwd
 6g0g==
X-Gm-Message-State: AOJu0YzbtHCvqb3gsBQfkaTZ9IiGeAM8OyUDbrFdBrx6AN+ScmH2Mqky
 Ga6YB3r8HOX0LNqpJWmicpcg8Bt/BAYN4Nr5+oADy3ybWPvs101lPSOm1APZ2R4vqSTQsVfHM6n
 p4NcxLUs=
X-Gm-Gg: AZuq6aImPdzRV5d3aRx/jJy1zZLtstu5QZtMCezbcyxfviFBkYFQNaCvI6hmRQvOEJp
 1yyC2ZRIm9awM/uR6azhCpXMSGJ7RsPMC/mCduUpMOcxUqdeC2yW9sLWw8yGk8QzG7zf3plZexw
 qHMRR6uHucHyOkSA2STcZRj8K+PRqULGl9FK61T9yW/2tWWAQX7H5hgdQfgzWBs5vC7Xv4zMaeO
 WgrbjXZUsIzN18hajbltnQf/BZ5VZnXlL0Nbt1maQOWiYGdphP16rgTymlskK/woqJgPaU7517B
 nD6i4R2E4X4rtppAA/+pJwhJZNMq1o7ikk3Zd4klmVIvFX6fDnWqf9X1Mpjt/YCI0I3TZt3sHCU
 j8/xvX3iTI1Oq5TLpnC1tQ7hGgz/d/L9YiOhPbHf6X1nO0QKFzcyU2M83TdFEOoxB4AGycO+gF1
 L5vSvT2yuFc5YqMDgCQsvBXXfyCLvtUOaIIQ09L0sBQT/hjo8o/v91eUpjMoBZ
X-Received: by 2002:a05:6000:2f8a:b0:435:9bf5:b32c with SMTP id
 ffacd0b85a97d-4359bf5b507mr9269934f8f.29.1769072076099; 
 Thu, 22 Jan 2026 00:54:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4359333b924sm16167447f8f.13.2026.01.22.00.54.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/31] system: Allow restricting the legacy translator_ld()
 'native-endian' API
Date: Thu, 22 Jan 2026 09:52:38 +0100
Message-ID: <20260122085255.95035-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-18-philmd@linaro.org>
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


