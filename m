Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E177CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZO1W-0000i7-0K; Tue, 16 Jun 2026 03:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZO1J-0000gR-72
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:15:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wZO1G-0004QQ-RH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 03:15:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-46019edc13dso1924493f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781594133; x=1782198933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P8wZzbrxY/757qxW4lqRlFEVDMY14ACVHLYAS+5X+J0=;
 b=kK9HpdOtRFWAYUzK26Rzp34oisOxgsmejBtHmJSMb2yapUalbFuWrgz8Q2GCVuGbj1
 LkizyIUT2fzNN/RiF7oGA+AdWJtRjCgcJlF5wHTm9RULOl/dOMTA5J9sN6K7ER1kBP03
 58WOj7aCGdgfx3k+AkNg9FcEkL86q12LfTeFoWdGgGf9tGX9HJtRqv7CpaMEY7oStIih
 PJCHdvTZsTdtUEi8Bork0w2y2cSLRDaf9sjUpuqOwPl+X31JAafoJQYJoHToTRcU8QqB
 U4Y955t28XSNLeHo1YiMCZnE4e6VNPylJ7BJfuXtbU+QAFSfzh40elSUo0Ntknd+0vRq
 OGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781594133; x=1782198933;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8wZzbrxY/757qxW4lqRlFEVDMY14ACVHLYAS+5X+J0=;
 b=HDH9O5vS4Q7x+0EF7MiVp/wX3XGDnAohP2LUfF6AXZnwPMGLle7yNlp8OH8i5WdK6r
 Zs9kOeWbctQfqe8rwpoMLIGFMB+xEZdZvOiaP8RJhjm+6GUMkr9lIJAswdR25rPnNceK
 VRkfGn0WdcfHA9iBYAEP+JVRfxzNMCrNsuOs8PqCn2Ikj1vzCUorYsJzagtj+t2QckPA
 hY6ZEMTrTLvKHOx3a0f/bA6zk3Z3NF/E34QtIJ6sQW4N8vs1jY8BcxVtSb6/44ntBNLx
 Iap8w9pT1Lvoh9TT9iMdDpAQsa9LUDNLhAdzm67qRU3T8lRVcAlZLZkec24OT//t2uD+
 dZdg==
X-Gm-Message-State: AOJu0Yy+gT7Cdoi5+n9BYE7Ll7IrOrXPQJDrGSO5uKfGH5YD1KsKzNkQ
 qSoLw4wyg1BVbhQI/JVPixSQ/nLmWoMhFMmG0dupWM06UJMR/jtrdEl8xadOJ0IiD7KxmfujcR+
 fQSoKPic=
X-Gm-Gg: Acq92OEA44rNSn65gL6kRp+pFbimbKgF7QvIxBPNgXo3upH0/QOFhErK5aIa1XF+7a0
 Pi9cAz2WHOJieeTO/Sd1KR0q6PG4nWuRj9isQE/Xj25mgz5KZt7WA/gwsKtlUVDI9CdsVIY2Q16
 dAJM9cc71lbJMiWObW8GS8voAmuh9YNFqdw/HFs172GDJlpIc3Z+iR9OYEwpSyiWlujtn4r4ukc
 6tbE9IkjVrv/hdrSidJHkWmOOFCMBePE/AqPyaJ8Mv7By5jgc3dS8H3CtDCoscRi680ehpLyOil
 Z9V8Kjy9N6/28vaqfThw4vUZoh37ieaZKGmT812iZcCnMbCp9ejzLjFtCI49GEhQGI+KrimoURe
 X/saBFvC/R4iwTzeqZyFVwW+IcoWkjHnUcFk/we8QJE+dEgraD5jcH6htGjv/EUe4jgp5PZ8q6S
 9fQRI3rwr3j11PBLkLa0uF3A91JvqkbaLoKZRnsmVCIO/CYqzWViwFpjPuurFQM7b0SCTMv8E96
 zxtoMkRSTp9WRuNjcCrrWmL2dYYlHpWtpuBU8qAg2V8AQesDSWYrvZT6/TC/4ERd+0WvhD6i1bY
 tUmAJFklE4WTo/5LiXahv1VgGyAQnJET7A==
X-Received: by 2002:a05:6000:4213:b0:45f:f142:d55f with SMTP id
 ffacd0b85a97d-4606db9fd54mr23878173f8f.15.1781594133117; 
 Tue, 16 Jun 2026 00:15:33 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-183.home.otenet.gr. [2.86.135.183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm44648268f8f.35.2026.06.16.00.15.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jun 2026 00:15:32 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:14:18 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v2 24/26] scripts/checkpatch: ignore spaces required
 around some operators in C++
User-Agent: meli/0.8.13
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615193526.2883349-25-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260615193526.2883349-25-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgpqtu.29nv762n1pay7@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Mon, 15 Jun 2026 22:35, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>C++ has a different style when it comes to space around references,
>dereferences, so don't report it.
>Also, closing templates with >> gets wrongly confused with >> operator,
>so just relax this check.
>
>Some examples:
>ERROR: spaces required around that '&' (ctx:WxV)
>+                auto &[counter, p] = *static_cast<TbData*>(udata);
>                      ^
>
>ERROR: spaces required around that '*' (ctx:VxO)
>+                auto &[counter, p] = *static_cast<TbData*>(udata);
>                                                         ^
>
>ERROR: spaces required around that '>>' (ctx:VxW)
>+        std::vector<std::pair<Vaddr, uint64_t>> v;                                              ^
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> scripts/checkpatch.pl | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>
>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>index 2189db19f54..538e059e265 100755
>--- a/scripts/checkpatch.pl
>+++ b/scripts/checkpatch.pl
>@@ -2621,6 +2621,31 @@ sub process {
> 						if ($op eq '::') {
> 							$ok = 1;
> 						}
>+
>+						# Ignore * in C++: templates and
>+						# pointer types are incorrectly
>+						# flagged. Example:
>+						# static_cast<T*>
>+						if ($op eq '*') {
>+							$ok = 1;
>+						}
>+
>+						# Ignore & in C++: & means a
>+						# reference, and this create
>+						# issues with some constructions.
>+						# Example:
>+						# auto &[first, second] = pair;
>+						if ($op eq '&') {
>+							$ok = 1;
>+						}
>+
>+						# Ignore >> in C++
>+						# checkpatch is confused by
>+						# >> closing templates. Example:
>+						# vector<pair<A, B>>
>+						if ($op eq '>>') {
>+							$ok = 1;
>+						}
> 					}
> 
> 					# Ignore email addresses <foo@bar>
>-- 
>2.43.0
>
>

