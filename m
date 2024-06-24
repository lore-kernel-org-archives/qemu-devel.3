Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C407C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkes-0000y9-AB; Mon, 24 Jun 2024 10:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLkeq-0000xg-Ir
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:27:00 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLkeo-0004Qw-P2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:27:00 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ec1620a956so52904401fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719239216; x=1719844016; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b5/ELZbK07QuVqEirB6191rfIWOxnwr8Ia4rNFVo7hE=;
 b=Wr7GbK7ogFsJZeFb4cpQ2yivygVJwIOnXRikoo8PfIUIJ1AbMq02HuDd7a0r1pluYt
 3WMzgFKIaRxulAEWKju+gXIOpQDqypPUBect6sJ59hbX9k66tYEYxA7QSElR4tPS38hN
 Bd6gT1JcepXLtv5bv5RR4eFuvGFQwtG76ZvWSUuuy/vCFykIhxMSJHD4C5I7gLSWT5cz
 fNwjmTD4OhjZvWs7QzcSYCFwPB/qLMER/UCHYbZZZVJ3sO60K9jCPmeKzvYvoFwDftpi
 XGsqOEhMS6RFcQ+sG45RBQESc0Hvzx9UuNhswQXAiQi00Hi+NBX9I868l8Trn4qdB3nq
 OqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719239216; x=1719844016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b5/ELZbK07QuVqEirB6191rfIWOxnwr8Ia4rNFVo7hE=;
 b=HfcIWY1isbLG4efUgAbuwbWSoJY1hwEQRgTt+uR/ITp+oradVhQEBvcvxBHvgFCwvY
 oIiKiWQbXlQsaxszMSHxvWZW6UwjV697+ebnitSp9c1U3RJ9aJd2fsj3rKvSxywHCouf
 byeTlUfj0/oXB2xqVlMfOF6LR1MArp6YhWvJikbQey7l3IYk+qNSiqZ++G4K0b6XeN0d
 bViDirGJeEYcPbQjYtLdMpeflNDtvnoLgqpm8y6x5CdybciDRShUm2tuL7QtGSgbEDv5
 qDwl5dQphb50vXSLrn0RMiEwRV2QlMWQo0tXl4ZhZwLKfbAGXuFItES8t4HuaKN3IH/l
 wbSg==
X-Gm-Message-State: AOJu0YzNYpXKnQrd73r9lQ9ghxmR1RKSexrDr6d/NiNZFnuk8uxh0oYz
 +STPTD5AOZcFhRNL/OhgmzWsJUBP3ohLmY6+x1xSQpdrcmSqRTdvUkykgZq167ZN5qoGriDnZ6J
 CrhP2Mfai6IBvdA3D4iVYTby4VyiRhKppxwdvS8UyQCxzQfhv
X-Google-Smtp-Source: AGHT+IHnNuyqqfC8ARqn62q05NqtH5o69U9Ehy/r994djLBPjC3Hbvv3pgIPAmizSY4KaXouq3lp5YJ0UZ4i9O84XTE=
X-Received: by 2002:a2e:720b:0:b0:2ec:4096:4bc6 with SMTP id
 38308e7fff4ca-2ec5b318000mr27467811fa.7.1719239216450; Mon, 24 Jun 2024
 07:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <mvmjziepgn8.fsf@suse.de>
In-Reply-To: <mvmjziepgn8.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 15:26:44 +0100
Message-ID: <CAFEAcA_ntKQpvtrzYubvsWKy+e3R==ZfUB=TeqDc7rnbT7oiww@mail.gmail.com>
Subject: Re: linux-user crash in python test
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Mon, 24 Jun 2024 at 15:20, Andreas Schwab <schwab@suse.de> wrote:
>
> $ /usr/bin/python3.11 -m unittest -v test.test_signal.StressTest.test_stress_modifying_handlers
> test_stress_modifying_handlers (test.test_signal.StressTest.test_stress_modifying_handlers) ... ok
>
> ----------------------------------------------------------------------
> Ran 1 test in 0.526s
>
> OK
> $ qemu-x86_64 /usr/bin/python3.11 -m unittest -v test.test_signal.StressTest.test_stress_modifying_handlers
> test_stress_modifying_handlers (test.test_signal.StressTest.test_stress_modifying_handlers) ... qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault (core dumped)

Just to check, does the python you're running this on
have the change from
https://github.com/python/cpython/pull/110659
? That is a fix for a bug in this test which was found after 3.11
released but was backported to the 3.11 branch, and which
(if I'm reading the bug reports correctly) might cause either
test failures or segfaults.

Though it also wouldn't surprise me if this was a QEMU bug.

thanks
-- PMM

