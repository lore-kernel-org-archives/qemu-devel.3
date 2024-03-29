Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB31C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlP-0002dr-0J; Fri, 29 Mar 2024 18:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKlD-0002bD-UA
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKlC-0003Yg-GT
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e228c12468so9083815ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751500; x=1712356300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWcnWOhOhEXp9gbRHbTUlAnAR9/XUgSdF/ra6Xk+uTg=;
 b=BKHhxuytUIpPe8ynZAQkkGqsYzHH9h6DFZoXzWM74l/s6WudT625GAWZVD5CXLpzRq
 wu9WB3YUL9dezqrsmvWG2kP3EkkTrkgRzqU8X+xHfrarNtTuhi7C6+jEpEICa5vx+8cN
 lCv96S1t9lRKSYGlViCLYObPoQhPyyWEh0k/YAmpuXi/1EgkmvBUF7bEOKfOZv8qxID6
 QxtRfbdhDoNAgxrV109/eIy4JnWuCZjMbuDR1ZQzVoyUVxckCWmXGLXNhfIO3QynwlMG
 1RkHK2CVrqOSBbWl1usLqZ7mREbzXCBQi8SJk840eA5rNbQ69uXxc+oLDjL3bDL78q+w
 RzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751500; x=1712356300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWcnWOhOhEXp9gbRHbTUlAnAR9/XUgSdF/ra6Xk+uTg=;
 b=D68Rgr8bOGk+wBC+MomqDE4CxXNnT5GyLPW/fhi5hDqgLrWCKk3U1fHRru7w5QJy8G
 FgWVTKo3y2vIH7GE5VRCWKPGgepFRey5hAj1Vb1cNWCma5tEdEwcvu4QYy0m+mZmPVfD
 gWO4AG3tFar5Ihfvv02lCLjDA4UoDeNXRHzSpPCvQbJeJEfv+4ajeuOhBecwGI/Y+fNm
 hc0mxNkqxbLJZzaXGRph4LuZzmY1ZFm9wYn9/I1FOtrborwDgKM2sKZg86NQDMOZlZT7
 BASXAx0OWZjvp6ceQlqelGjl8raG3W3D96Qi0Ef4BTVgs0yFPnexTTkqs+Yvpd+k7gkN
 0TJQ==
X-Gm-Message-State: AOJu0YzMv+6kgiNDj56t8Ya/KxXii9EaXs3KbW3GJ0qIjTwnHU9quBvc
 VG8qy3jy0hn+3cERyYlL8QFpKWJBmS21AvXtOaAIRlMKCF5jtVZcPjcO11lGVCPo0jSnnSxfWYA
 r
X-Google-Smtp-Source: AGHT+IHWkzXUZxZ0SCQV2CpsttSh1cNNzz+fBWDbapY6DjBw6rgLM+c6RpvtkKGZ9PCpH9V9JBFatw==
X-Received: by 2002:a17:903:11cc:b0:1e1:a75:a095 with SMTP id
 q12-20020a17090311cc00b001e10a75a095mr5352636plh.25.1711751500662; 
 Fri, 29 Mar 2024 15:31:40 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/18] target/hppa: Clear psw_n for BE on use_nullify_skip path
Date: Fri, 29 Mar 2024 12:31:11 -1000
Message-Id: <20240329223111.1735826-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Along this path we have already skipped the insn to be
nullified, so the subsequent insn should be executed.

Cc: qemu-stable@nongnu.org
Reported-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 143818c2d9..8a1a8bc3aa 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3948,6 +3948,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
         tcg_gen_mov_i64(cpu_iasq_f, new_spc);
         tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
+        nullify_set(ctx, 0);
     } else {
         copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
         if (ctx->iaoq_b == -1) {
-- 
2.34.1


