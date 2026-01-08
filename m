Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E9ED148A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdifa-0004Mr-Lc; Thu, 08 Jan 2026 00:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifY-0004Ga-Es
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:48 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifW-0005wS-Bl
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:34:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so22126405ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850484; x=1768455284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GW82N8hyUsRQ+e2I2fodb/3OyOkI8Sxoz9ABKF/EoTc=;
 b=NIzALj2wk6a5L9cGlgfnCCcjCS7SaBe5WK8glWGXnqLKS3P2CpUzKrMP6vj2qkSS2e
 7D6R2sgV3PWyMJNUkKp9tJkvE9MH6RcKEM4umaS+R57+dfVfYby0YuN/zClzdL/28x6g
 H39Mq8X3Nett53fc0ROlvpvcb31ytnQfXxyAVXFwIbsLP9nOK14TCd8wybCSl3zvblAx
 tvX0pNHceCpCgtkqwpHy6DYyb6PSZopIRqua3F9GaqYbj/Ew5Mxc0G9NH7I8y6eHy6rp
 4l69+g3vBpnR1j8zhmWQCbTRzuFL5DCu+A6JmKqmq4C5wwFpeoczT/5jXgohDmwelaS5
 3ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850484; x=1768455284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GW82N8hyUsRQ+e2I2fodb/3OyOkI8Sxoz9ABKF/EoTc=;
 b=i+2rDYxDVOp6zdmm0MhoNqHMHfcxq8SPcK3jl4Mljj3zkcgF/kobVp6FKSgMvgxXwJ
 MbssMVUXSfPAy1V02lmasmdtJn86gwERd30i6cG8ol5HNYLUvrMO1APYskxePPPVTHrw
 0PL5UpFEFJJGdCpia9GEkSNKZXQQuqCn8cwsm7dZW8LJD1swI2GT1ut5BIhoZG+x6be3
 sCsMmLFoA8djOjP/OuLJFkOzAHt2fHic2JA8HJcv/Zhm3lNMT1dsdrXSHakk/IaWkfJj
 LjdHkp0m70e8aoVfYXnVCzkFRBMff/sxGRTZFz8EmR4eWLxbObMh0PSsPFVwpzISHVQO
 FxJg==
X-Gm-Message-State: AOJu0YxmseR2eUOLO1gBv0JNXWKWoShhZB2D390wXvS+OP1MmT2aiyjm
 6xycLyZc7ChIw2jDfnEgKRJZBLtn3+U+H5KPl3mDTWYMVKouQMM2GVGe3jMuRWhi5Rtj+1MH3hs
 7oqLqoNg=
X-Gm-Gg: AY/fxX4iWVax+obBZYTA55QoNiJjP86fReR+t8CkVpL0FDxLOuqacOs4CKZBuuOp1Sk
 /xMnWDeTGoa0vFdXD0D4EKA3/1Lwo3lbi/QCRfqvXc5vJc1TykaI8aV+3YOawzspUYCHoIJIpo8
 M3z8FgBUdV0q7zhqmjga6fQ2kAX2ITPkhuslCMj/e1am3vfOJEy3GtjaVvvhpWHVf0Soe7qQK/3
 6+d2bSD+a540OikydiaLUkDT7q/eZep9omDrABpOFL3OOPGoYu//TWLMNqzYYP7BbryXXBK6j8h
 N5zO2mlk5R7rZeVWjh7kXhfzuSoM41pYlZAmQZT8sDaCemp0D4m1RJZlhMPH3ezNdtepDvySSa/
 BTVwAG20AuKtsAYMdBlFNhU0t9NvTGPtG3sHg3cCsVj+yiOBr8vzbL2ma/fg1ZiNQ9xZ9Ef6GLu
 M/LKg9bG27Zcw7vu8BPg==
X-Google-Smtp-Source: AGHT+IFJguRbAH68pJvFjTCBHFmvLgFS5aBAl0cZ60zQe1LWVcEi8sfR34YKzUtFcTGlnCIXJiCdOQ==
X-Received: by 2002:a17:902:e807:b0:2a1:e19:ff0 with SMTP id
 d9443c01a7336-2a3ee4b3165mr44371345ad.39.1767850484448; 
 Wed, 07 Jan 2026 21:34:44 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:34:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/50] linux-user/hppa: Drop CONFIG_ATOMIC64 test
Date: Thu,  8 Jan 2026 16:30:08 +1100
Message-ID: <20260108053018.626690-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/cpu_loop.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 356cb48acc..e5c0f52d94 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -83,20 +83,8 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
                 uint64_t o64, n64, r64;
                 o64 = *(uint64_t *)g2h(cs, old);
                 n64 = *(uint64_t *)g2h(cs, new);
-#ifdef CONFIG_ATOMIC64
-                r64 = qatomic_cmpxchg__nocheck((aligned_uint64_t *)g2h(cs, addr),
-                                               o64, n64);
+                r64 = qatomic_cmpxchg((aligned_uint64_t *)g2h(cs, addr), o64, n64);
                 ret = r64 != o64;
-#else
-                start_exclusive();
-                r64 = *(uint64_t *)g2h(cs, addr);
-                ret = 1;
-                if (r64 == o64) {
-                    *(uint64_t *)g2h(cs, addr) = n64;
-                    ret = 0;
-                }
-                end_exclusive();
-#endif
             }
             break;
         default:
-- 
2.43.0


