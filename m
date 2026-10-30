Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wNLbKpzU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsWA-0006AI-Ux; Fri, 30 Oct 2026 15:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVh-00063Z-Fd
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:35 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMsVf-00009o-Uo
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:43:33 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-823b938464fso888957a34.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793389410; x=1793994210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qz/ar/VtSNtWTZfs/nkOnoi88aqwJzzP2HZG0XzfKtw=;
 b=wNLbKpzUGfK793Qpbc85j3xCblQSXBv5qUWkxaOFG9ys7eNsSgBaAOwhrQrQY9ddxq
 29snfQhxQCKAtAtE4PHGxUT3Cn//FMJBbL8lAPK9ox69O1vL3D4eBEhINtUyoZKOg96l
 qLfoQlHyHyN1JXlM51XZp/uK8gyqWAxFLc3iYNWlwspQSK8wXLwGEhurOekT0XO3fyn3
 px7tR1knuYh4LAs5EIe4J51ONEwvw3X+d8DgQTkEvMRum3lHAVjpxFy4g9SXX7jLKy9g
 RmWXxTAex2BUIzq2tKzvo7X+gB8oWoqCuAA4aPKt6l8jx5BQYWSzinfbDpq0g7tyddra
 PSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389410; x=1793994210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qz/ar/VtSNtWTZfs/nkOnoi88aqwJzzP2HZG0XzfKtw=;
 b=fVIXPXgtaE3YieX+xlWFlTYSFPZftYtofUrZ2JIkxuUzAXZQJWDXKs3HJVv8LIsoRB
 LuZFb1vbEmdB/URdcP/AzxzOvgSSnOsBtzKFTAo4o6M6i4jLuY/5ipqF7CwNrCWaTUvh
 /LX6i14CEqxIYuU28is0lZ2Y1ROlRiBwWeTppaWn2n27pMeATWxbdo22zKSp4s+ARVjR
 n3LFzBxa8uWhdVZsX3Op3NcMxNxy0dR7BoFk7+zfCvEEQ/qpNJOPThsqOZKTWxnL49bO
 +rLM6lcMB+hBD9RSFAPv2Vjnp+raqQh0sjhHl8zR0a7pyz0mgZN2TdK486yt1Pyi3uRC
 nwOQ==
X-Gm-Message-State: AFq9FYJaoNlVbK//t3XRbJirjqCNosmF6X04OwXoc3MQt0jOMxHjvJSE
 I+5jnbNwn/NZwwdDkamEefJ3RuCPRGjv9TZORuOCtK2kSEEEIxqi94RqctuwIWgrxFUefnymd9T
 kGUyy
X-Gm-Gg: AYBFou0K4j+jVFPd8G/l9AOrqLDcX03R7QbeiTtwivi5N+k11YLXqkg/QA4hrFFcFiA
 QmJgsbW4XYt9oWxJjyB7oiQ9kZ2F6+hin7wK0ybbIE1giHdLVx+6/0S3fU1iaY1LAwO0l2VxH83
 1br0FPjC7hAbGEjvERuc1h3TUpBpByf7xhyNetLkLH/DPeldj55u/7d9bSUWHyjF+Hv4wtJrRF0
 8QcUOIRG1O6z4Tc6Hc51pV/KhhvuACGHlzdNiiYP8RitXFWTfM62fJfqexn5y7nZo0wbvirKVOE
 qJdaAw1KXMVwyGZQK48soJKnOfU/0s4mEKEkPJvHQ/80abTD1vRQAFYv/vy6HK+BGrPGY85JXTR
 oqQMnxPV0DfjraH5fWrZk59ePRCWGRsqwWXKG6s+2Cdn5tyJOyDseya6nF40cL57Kl/+95KYrHC
 nd9pDsWppU3hSyplqE4Xqlqx55b8zjq41j5tFoQbkqOt5BqtCl/sBt2BLCiOiF38ffVLNgFonm/
 h5ITw/GUZUYs8lASBWwiiBWPDtejJfG0blvFAB+KUki2+bL3NSE4tfPQgtlmTBYv2hq/OWUeU3R
 S1kxT79oXY1FSoS9//RGtdAz0/XhGeE4FpNn
X-Received: by 2002:a05:6830:905:b0:81b:a5aa:e82b with SMTP id
 46e09a7af769-85d364fc6f4mr3097778a34.24.1793389410130; 
 Fri, 30 Oct 2026 12:43:30 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2654768a34.2.2026.10.30.12.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:43:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 7/9] target/arm: Use DISAS_TOO_MANY for simple TB breaks
Date: Fri, 30 Oct 2026 14:43:16 -0500
Message-ID: <20261030194318.319310-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030194318.319310-1-richard.henderson@linaro.org>
References: <20261030194318.319310-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e66ccdff6f..0f6331a695 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2420,8 +2420,7 @@ static bool trans_ISB(DisasContext *s, arg_ISB *a)
      * self-modifying code correctly and also to take
      * any pending interrupts immediately.
      */
-    reset_btype(s);
-    gen_goto_tb(s, 0, 4);
+    s->base.is_jmp = DISAS_TOO_MANY;
     return true;
 }
 
@@ -2435,7 +2434,7 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
      * MB and end the TB instead.
      */
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
-    gen_goto_tb(s, 0, 4);
+    s->base.is_jmp = DISAS_TOO_MANY;
     return true;
 }
 
-- 
2.53.0


