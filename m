Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60789CFD31D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 10:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szD79-0002G7-EZ; Fri, 11 Oct 2024 06:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szD77-0002Fu-Ou
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:43:17 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szD76-0003O6-3P
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 06:43:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c918c067a1so2293822a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728643394; x=1729248194; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1mPqrGTZWk/Uq0BCrfXmLq1BmEFqRgOrhSbLMH92QbA=;
 b=PMR2XE3ubvHioPg4tKN7zkCuhc+Jg45mt5wC8tlckbE1o1ZnXK0TFZp92aiYYHaMt6
 LOX44yuuDrDErEkNEoWHfXql2A47QLUBzkn49lhKtuC93QpEdvM/l5TavIE057OfZ1Q2
 9tXYyQuK4bMUip0nuZRbAe3bvB1vqJjj6hLK7vz5Jyo7p5Iop0nESIp9sR0pRIcPQSdF
 afsNvLRIfWQsEjStpKwu8Mc4pe9c2N4iLN5dcl6hEeijTvRb1CfNHuh4jf6tj2Yetc/t
 lbVPOEefVyQcWB9zSwPflBeGq2FBfSi1hokkOu4UkWm4+XMvjvKv9o6KLQO2cRa0KqLM
 gW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728643394; x=1729248194;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1mPqrGTZWk/Uq0BCrfXmLq1BmEFqRgOrhSbLMH92QbA=;
 b=Z75ve+Q+3XwuTKMle5LZf6Rch7JhPD/H6tx86R0tH5fRFbSelbEjik+1XZs/B8idHz
 bVl455MIuxzj7qDdeFz+23LpwSVW8XYE8vwX1KSAvtYqPmwogt+MmEeiezXqxX6L2wKa
 OVVNHaHPu/DZ9zKQTQfh7CAOYIdNxfLLjn63I+gCDk3WxgPjz0mvHy+ieERmsAlagb/N
 O7LaY86roe4JAZLAgBxOYfdqn9EO4RBRQruLreaGHHelBjr2WyOIPECWVoRJI+xLskmf
 vYBP3KBiYAVlZnfh+HBWa66W0E5j1dCrZAQu0Rja/jn0dQ6YVgNs2OnXqQR1nwjvHut9
 Nhlw==
X-Gm-Message-State: AOJu0Yx7jNanXRHPaueibwZLgYszTRMc+EebEXEuR4ukiMhOZWE0zDyG
 UpMMxq1wAOrT+riP2PfhKyXdErCwwLcMFg5YrebH2sfwJOcdlObP+DfIp3GSz3esTq/iwtADjT+
 JnmGbOY0XP3jY/ZsiC81hP2aCNzt3u9fsVTfy4g==
X-Google-Smtp-Source: AGHT+IE7TPMHhr66z9BdWlzW0qQ9Xqx4oBsaEze+a/9v9WVsWper5WgwY28HnGFB11WeVwqv4HXzyCxxQtMimmT+UjE=
X-Received: by 2002:a05:6402:3487:b0:5c9:3026:cf85 with SMTP id
 4fb4d7f45d1cf-5c948d5378amr1405046a12.22.1728643394197; Fri, 11 Oct 2024
 03:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241011094948.34550-1-pbonzini@redhat.com>
 <20241011094948.34550-2-pbonzini@redhat.com>
In-Reply-To: <20241011094948.34550-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 11:43:03 +0100
Message-ID: <CAFEAcA9w1MRnZuS3FATy8tWnuKJ6FxM7aKNGXRDLgJNPXLVMVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs: fix invalid footnote syntax
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 11 Oct 2024 at 10:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> All footnotes must come after a separator in reStructuredText.  Fix the
> two files in which this does not happen.  This mistake is caught by
> Sphinx 8.1.0 as an unreferenced footnote.

Worth noting in the commit message that this isn't just new
Sphinx being picky about syntax -- the current docs actually
misrender the intended footnote link literally:

...from the venv itself[#distlib]_. If no...

It's a shame that the way the footnote syntax is defined
means that you have to remember this awkward "\ " in the
really common case of "footnote marker at end of word or
sentence, and that the rST documentation's examples of
footnote syntax contain only artificial examples and none
where you need this.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

