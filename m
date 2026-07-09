Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F616C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgj-0007ic-Bn; Thu, 09 Jul 2026 04:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgf-0007iE-UX
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgd-00088y-MU
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so4349205e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584043; x=1784188843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jNPUc58VtrZ3eu6Yl1jjKzdNjjYxYlf7SLhS+oRDdB8=;
 b=MBcM5pJJ+BEohgMdjRQBTsrWgVY/gaaNS72Rnay1pAdV2oDw1BL/rM5+EyC+dnyecz
 QVuggqNryVHPxTZaDeLNCHkhPJwJfnoW0wJ0GZWibzuBUSq9rxo+mNtZY7d7EXjoiTt1
 tJdQqrTq0EyNDhOJU8jzRJRI851DaKrtngnyneJ8X0XMJCn5kFJJX75yELfZCUK4BQVm
 bB7AocaU7PNdy49lZuE1U375cdEkBxlpLIakqo8gex5UGxkI0LTJfB87SDHgwZLjWIU2
 WgoFTWTtFm29y0HJ+P293yFp3AqqXF+AFfGAeQmwpIsBrWL8TPCfju+2HDerp1pfZuci
 3jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584043; x=1784188843;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jNPUc58VtrZ3eu6Yl1jjKzdNjjYxYlf7SLhS+oRDdB8=;
 b=czQ9yExbl+xQWTjNbHnTIt1fWX4UkPdVpEcdGl0j7zVAgMxtPUOZHFQQXXI8Pf4tbi
 m1CuCjbUbkPmH/00fAEd2wrs9ErxwIkq0Y4qHIruSxjaHQvFwk4CHCOeih3/aE/PgNWz
 hu+6lurcJAMFAdBvuNjqV31VS5lXi/KoA8IDQm60qIaLpzzecuc9hmA4RURICUY8SdwK
 SasGM8GkJfNos1BFyRhxeTfEte1hiQ4koGwl+TlD7ZnTLTem0qCUClugJ47hJUj3b7bG
 lwNcGs5kailXn3A1IRRydEW3mzpryu/kvQvgNkrRfNvu4aHGnG4S7gLi6BX/LdPMN2hp
 zEdQ==
X-Gm-Message-State: AOJu0YyofLTy34gJgbd53b3QpnxDFMj0aWs4wX52+HXZFm2VyYMX6SXh
 spMMWqL5egPYBQw0Td0D9CEfrY55zqHlm1TeVu529PXctcm18Gu2FRmYCkkib4Imh2M=
X-Gm-Gg: AfdE7ckz7WE7bnn9SnP3e7mvCINdHxhjLw5shbwBBe7LVBSJYfiIRuFUolOG7ysQVJY
 mHwtOvfIoGHXWb/gqdP7D84GZbsGwHmfPIVLpvvv7mDyD+y79UfKM0azt2aJpTfeD+ajDXw7zpi
 l9xL6rRp7Xam4qAn6XIburxDLGvFkWgN5ZxEjHQ9VoO721uqNzEC4jvbj74gM3DDlS+vfnN5lvY
 ZDwLewIcobKQ9gNRJ7Qvf/6b+jOSC8zFsp5oa2WlMNl7uSQRui4etKWXG6aaOyw/KeKJ343od/W
 keDnYSS6tWFJH1+AyBPdnwZur5G6ulYFyciQFweWzk6ljRBkiwDgmKWn8e1pt9Q/7XHczR9D0HE
 FoR3mc2X9qfEFu6/Q5JOJ89x4vm4W+gOyDQUcMXSLRplUN8AJJAAleSuaXr9Q5aEMefOfjKqqab
 Kr3CjHUbo1pNcI
X-Received: by 2002:a05:600c:5303:b0:493:e41a:9b23 with SMTP id
 5b1f17b1804b1-493ec561411mr15808535e9.1.1783584043099; 
 Thu, 09 Jul 2026 01:00:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm41336295e9.8.2026.07.09.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5AC186003E;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 2/9] mailmap: add email mapping for Alexander Mikhalitsyn
Date: Thu,  9 Jul 2026 09:00:32 +0100
Message-ID: <20260709080040.4157324-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

I use my company's email to sign-off patches, but send them from my
personal email cause it's Gmail hosted and works much better than Outlook.

It causes some misunderstanding and inconvenience for maintainers sometimes [1].
So I would like to add this email mapping to clear out all possible confusion here.

Link: https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4wucnC+yWvMo2-jr2XBTby4zqf6CTA@mail.gmail.com/ [1]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Message-ID: <20260708134744.169452-1-alexander@mihalicyn.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .mailmap              | 1 +
 contrib/gitdm/aliases | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 7665ea87562..9ad072234ff 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,6 +123,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
 Song Gao <17746591750@163.com> <gaosong@loongson.cn>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
+Alexander Mikhalitsyn <alexander@mihalicyn.com> <aleksandr.mikhalitsyn@futurfusion.io>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
index e26b00a71d7..f838768792a 100644
--- a/contrib/gitdm/aliases
+++ b/contrib/gitdm/aliases
@@ -33,6 +33,7 @@ malc@c046a42c-6fe2-441c-8c8c-71466251a162 av1474@comtv.ru
 
 # canonical emails
 liq3ea@163.com liq3ea@gmail.com
+aleksandr.mikhalitsyn@futurfusion.io alexander@mihalicyn.com
 
 # some broken DCO tags
 yuval.shaia.ml.gmail.com yuval.shaia.ml@gmail.com
-- 
2.47.3


