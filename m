Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E1BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN8Q-0001oN-HW; Sat, 30 Aug 2025 11:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtZ2-0005gl-At
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:30:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urtYz-0002DV-Vw
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:30:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b82a21eeeso321455e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756452619; x=1757057419; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LL74e/RfB9WIOsr69ZNP2N1kc8B6HK4y6eGiWFQYVWA=;
 b=GGtW4IlmiuNxSj3JpKw+Ax3OJ+1loS66qAapFlsoW0QWf+viFHpcX8VpN2oHtgsxoO
 vxsntV709OQUNUstFoFLdadGvs2jkxZ+vlCh+s9El7Cynf34CgefFlna0gaWDL43H6WW
 ljZKVphRw03F3SDt73BvmjfdOq8q04d7YoNvVadeFnm40hMpHKtTq0QdAai9qEQqBlSp
 E2PlKAuxBP5KLwuuBF3ZBvKp3QVSZ1IA3p/xIOOH5vFQTgCD0X53Wy4KvabsMLOYmXyX
 hLBPcAsjkdYwrn1uWzJgwSyJD+rP9NbL7rRyFw7U7yA6HP6b75HUVKDijBxPjrdhQAm5
 Wd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756452619; x=1757057419;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LL74e/RfB9WIOsr69ZNP2N1kc8B6HK4y6eGiWFQYVWA=;
 b=NtkK3cwQEiz+xyGfcc57ePqShndV8iNwudihP4dBtbjvG3iTWXNAoe32WOpSAe6v1N
 r/RM/6K1oUYHjr/U9l2YBd/L8SJbJaF41KgTDUYLNkdnK3WJBhV4ES48VK5OYKsIRPtY
 gPtDjEdID8naO2Q+JVUvlWkk3q2wSkJk3IM3RuWYcJFfty9W15o+IubbwzD/w4nIZLoY
 n4g/sleTU7/VEpDtlApVrU4rYEnS/l84tNV7tniU2hzyl00GiW2+vAifHPTuOin+HZxs
 LPqa2y8fb7c+WdnMXd/LyiWvMJLAjQeiqb1TEyaU1kvC9+94omavNO9JYgorn7Yzy/iq
 fJUg==
X-Gm-Message-State: AOJu0YyKL5h5Gm2OwykHzgX4cuvcPGesIfHSijytttX9UvwEQX7rHTYq
 FUZX4Koh8hASClmQnC1YbORiyxj20Phg5xZgVxYcMmQe5fJplFd/TRLKoHh5hlnnKFexx+H3bf7
 3TeWcLPM=
X-Gm-Gg: ASbGnctWXhUZqOH4IcJ47rS7tWpDm7fY0yIBFd8IWNnH09+DjrIX1jFJTV7RmPfefhW
 g3P0vF8VxmLQw1rv+/MGgiSTzHbns06DjPKcxB6gtsaIyhR8oyrjj1/c6dD3pG70R0nnryYvPpg
 xs4SVH+FzjLcoTaA9gatL81uJJZxpVMIcSp6UVOQ+mh4fkGyLllvwH/oBLf2LuBp76d1IO8dXuK
 EPHDm4QepqtIXDWuxrGz84Mdycci7HBK+YwgsentaR/TWPuKa+IG/I0KzLGknrrY9nOf2YtkNnw
 9nNQB/PETsLcYX+nktqHtuqFTEESv/FyaZBQ3fqo0AVFNnlXXiIpwWEt3GUkM1mDxHbw7Q4/Opx
 nZwH/KEpj9f1rymhLTLqEas/uHX4TO7b4lz0Yo+I47CyqzmrlWd3/6XsbTLtwf3SptjOl+uJC
X-Google-Smtp-Source: AGHT+IEuQm6IMAi0ezvzj4YNk7d7iamnwp4MxgBupN+x+86/0s8pxKFOymnb169A7cG0PrbhB5Zzbw==
X-Received: by 2002:a05:600c:35d2:b0:45b:80e4:4e05 with SMTP id
 5b1f17b1804b1-45b80e44f3dmr7092425e9.6.1756452618953; 
 Fri, 29 Aug 2025 00:30:18 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7f53a947sm10788115e9.3.2025.08.29.00.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 00:30:18 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:27:26 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 15/61] target/arm: Add CP_REG_AA32_64BIT_{SHIFT,MASK}
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-20-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-20-richard.henderson@linaro.org>
Message-ID: <t1qvih.2mkqztkoudm9n@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Give a name to the bit we're already using.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---
> target/arm/cpregs.h | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index b6c8eff0dd..3dc4c9927b 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -178,9 +178,14 @@ enum {
> #define CP_REG_NS_SHIFT 29
> #define CP_REG_NS_MASK (1 << CP_REG_NS_SHIFT)
> 
>+/* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
>+#define CP_REG_AA32_64BIT_SHIFT  15
>+#define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)

You could use include/qemu/bitops.h

>+
> #define ENCODE_CP_REG(cp, is64, ns, crn, crm, opc1, opc2)   \
>-    ((ns) << CP_REG_NS_SHIFT | ((cp) << 16) | ((is64) << 15) |   \
>-     ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
>+    (((ns) << CP_REG_NS_SHIFT) |                            \
>+     ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
>+     ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
> 
> #define ENCODE_AA64_CP_REG(cp, crn, crm, op0, op1, op2) \
>     (CP_REG_AA64_MASK |                                 \
>@@ -202,7 +207,7 @@ static inline uint32_t kvm_to_cpreg_id(uint64_t kvmid)
>         cpregid |= CP_REG_AA64_MASK;
>     } else {
>         if ((kvmid & CP_REG_SIZE_MASK) == CP_REG_SIZE_U64) {
>-            cpregid |= (1 << 15);
>+            cpregid |= CP_REG_AA32_64BIT_MASK;
>         }
> 
>         /*
>@@ -226,8 +231,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
>         kvmid = cpregid & ~CP_REG_AA64_MASK;
>         kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM64;
>     } else {
>-        kvmid = cpregid & ~(1 << 15);
>-        if (cpregid & (1 << 15)) {
>+        kvmid = cpregid & ~CP_REG_AA32_64BIT_MASK;
>+        if (cpregid & CP_REG_AA32_64BIT_MASK) {
>             kvmid |= CP_REG_SIZE_U64 | CP_REG_ARM;
>         } else {
>             kvmid |= CP_REG_SIZE_U32 | CP_REG_ARM;
>-- 

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>2.43.0
>
>

