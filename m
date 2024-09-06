Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29715CD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smXCw-0000Lk-Ks; Fri, 06 Sep 2024 07:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smXCu-0000E5-JT
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 07:32:52 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smXCs-0001kw-7e
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 07:32:51 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c275491c61so2147916a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725622367; x=1726227167; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hi2SjrygMmK2WNFx8XgAzH5BKkoeBwqtydW1vzokC/U=;
 b=ugeMHwEWyBjvEohBzOn/h+NG3FWihNJ3p+0o0QtIEgy9fZAhthD2NeNZZHZ6K54gyK
 UrmTHTarTy3AcpicCmyd5fXkfJtl3CEpz6coPh4vOkJAzA0LuBi41f+1LLsUFVhT+XSL
 d51Stys5NNvRvmgYtIGcCHemOfFM926u75wJacFiq35zmMye4BzIQJHZxbVaS4HqgKgz
 betYI4iNt6Zg4bXMfhohr/fmhlyXI99ub+pqHFQMRpepCcwRoo6Eo8wYZGZIqH+hbCrU
 efLj0TJ4zXM0WWraejeeDzY5hn/M+cJx37gwZMlnwxEueGf2gS2skOhfj8G0Mj+KH9js
 QymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725622367; x=1726227167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hi2SjrygMmK2WNFx8XgAzH5BKkoeBwqtydW1vzokC/U=;
 b=WFjB+GhGlgA37u7pGKJdO9By+kJtHbavP8Xo7AMyq/0bBxHQHqQvFZ6GSzTDGGZM5e
 nCfVjURnd9EPhXpKvtRR5mysI8Oszw1zuSGLZIP66AmBXE1nKUawszPrUO3U8aoJGZJ+
 rNy+LEI1M0fASdImO2rMYx9qDDK3dH0lz69AyZhIfN7i1UrRRM7vp41y7QgZ7RxiwaoA
 wPRGlMTopED8B1GwQEyoSKyyJ41nKitXOzuWZjDDhrmy5WCsrewBVsvnf48dGNpP1SvP
 BHXfVRwb4zX0h3qP4Wbm2lQ8F8+ENTwXC+OENVa1rOOyqkqH1V3UZ19AQXVufNvHyMsh
 qvzw==
X-Gm-Message-State: AOJu0YxqBx2fwHepxvg/u/uHLNUXOQcI3KAkaVVEzXMEVoFn+8FK4kLr
 SwyplVwIjsekFUj7OYPRTsuNjMNAyBBz/XsODwqqNzKDHw6yfJTp7uPO9lah1NpMjKmy2VJXYz9
 VMnWyEZM6dfGWG0ZWEXGTZ+K0cgR8qZgJLpn9/A==
X-Google-Smtp-Source: AGHT+IEY9b59tbUHZODvIDqx4CBZS1oAFWKD9/gETxBTItpsj98Q2wbfTTp1zV75Mv3MKVPMAVx4U/Ks30lHLQZfpsI=
X-Received: by 2002:a05:6402:3592:b0:5c0:ad65:ebfa with SMTP id
 4fb4d7f45d1cf-5c21ec58f5emr20031635a12.0.1725622367304; Fri, 06 Sep 2024
 04:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240904103923.451847-1-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 12:32:35 +0100
Message-ID: <CAFEAcA-Rq+BbZeDABM-fRD7Jhj_4bbP8axgkmm+h1Oj-CPR_rA@mail.gmail.com>
Subject: Re: [PULL 00/42] Introduce new functional test framework
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 4 Sept 2024 at 11:40, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi!
>
> The following changes since commit e638d685ec2a0700fb9529cbd1b2823ac4120c53:
>
>   Open 9.2 development tree (2024-09-03 09:18:43 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-04
>
> for you to fetch changes up to c3e24cff2b27d63ac4b56ac6d38ef1ae3a27d92f:
>
>   docs/devel/testing: Add documentation for functional tests (2024-09-04 12:28:00 +0200)
>
> ----------------------------------------------------------------
> * Bump Avocado to version 103
> * Introduce new functional test framework for Python-based tests
> * Convert many Avocado tests to the new functional test framework
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

