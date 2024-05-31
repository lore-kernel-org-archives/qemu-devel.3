Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E04FC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5AI-00078D-H4; Fri, 31 May 2024 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD5AG-00077h-BQ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:31:36 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD5AE-0003X9-Fu
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:31:36 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52b8b7b8698so895880e87.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717173092; x=1717777892; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M5rrR7jRgSaMmgIxF4ICNj+bmc9mq5NVgvb21cUiqKU=;
 b=Ybat3Ejy2uskZTws2Kdn8GBO5w1zJ7JIhaEBfvffzevErTQERvaJRAtRo5hQdVA9Z3
 ih0+6IMKyu0pVxRPjjzFEh0E/FFg3zPBDGr14UqDzyvejF05cxPnd2NWqwVWlgfirkFQ
 Ho57bWqOmIrf9vauBOOvti4bltJ+Eo/bxRqlJySesw8uQAqB+6B7oZ+eyZGqStQUORjK
 K2S68UQtE3KgNn3gfNPJfslkn1IXMGDpD4D89Bm+50bNEcGjCBSl67NRTNM8crISeAKr
 spiopUCsj1gcuvBOkHXvQb3LOM9rfUTXab+sjvz5dF+Z5ZErzm0oXylI/r4J1GQTttb6
 jMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717173092; x=1717777892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M5rrR7jRgSaMmgIxF4ICNj+bmc9mq5NVgvb21cUiqKU=;
 b=DBRr6WpzxY6gvrJTBklpINtXLkADksNsLSCv6uNP9Cd/qfNRMFWRr/SHTSiAyp1+xs
 UfJMi8XmgJBN0pOyK7GI86H2Kg6P2AJ5eJ4TQhWXEZXRIpseKy0622hwW9RDbfX6uTYz
 BkyUEN77eBV6tSkFeMqf0Wgz4DB85oDRr82F9nUmI+vh1UfU45o+Y9aCAhWENOHZQxyM
 U8yFLGih7fBKil1hFDm3iI+r/jcr9tmoFvTa2ZanQ+Jemi0cqgICKzE+2vftMa8LNVXx
 FYs+g1Gnzv5WeJEtOZ5WwZNucdlQzBHjdI/RCoWgs4v8SH4zpzdAljtdJvqg75kgV713
 KLvg==
X-Gm-Message-State: AOJu0YzuX1KD75Sjrd6SDEAm+iZt1PoOVE0jdDr/MS98pdFwD+uF050d
 7oe8qYePbNYK1VtKKfz3aJEmp4Ep4RpsBp/GEb45PUeYgytk9xV+IDFs+akfP9kLKNUWMFIsTua
 EAZsTL4aTOPMIBeuZB2CbiBo7LgFB4Ce5zQkezg==
X-Google-Smtp-Source: AGHT+IF26KOz6XfwiYZ8ycCQiujiR9V/6feFiOCxWVKE7Nq2H4BfoJc9UuvEe9+xPAP1LmkJf9LNuTJPdOUALlemyXE=
X-Received: by 2002:a05:6512:48d2:b0:52b:3a6b:4066 with SMTP id
 2adb3069b0e04-52b896c169cmr1370267e87.42.1717173092292; Fri, 31 May 2024
 09:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240530122300.724226-4-eblake@redhat.com>
 <4ximmjurd5qkiryq76wsiff6ece7q7fkbodmcpuaq5cilxij4w@fhzecidxiyd4>
In-Reply-To: <4ximmjurd5qkiryq76wsiff6ece7q7fkbodmcpuaq5cilxij4w@fhzecidxiyd4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 17:31:21 +0100
Message-ID: <CAFEAcA8DjuQNUUs7PLChFnPJXwttZd3iNDoo1ciyAG0cKgR55w@mail.gmail.com>
Subject: Re: [PULL 0/2] NBD patches for 2024-05-30
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Fri, 31 May 2024 at 17:17, Eric Blake <eblake@redhat.com> wrote:
>
> On Thu, May 30, 2024 at 07:22:16AM GMT, Eric Blake wrote:
> > The following changes since commit 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80:
> >
> >   Merge tag 'pull-request-2024-05-29' of https://gitlab.com/thuth/qemu into staging (2024-05-29 08:38:20 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2024-05-30
> >
> > for you to fetch changes up to 109c59fa3a1cf6be88c2a39b4699a0041c64821f:
> >
> >   iotests: test NBD+TLS+iothread (2024-05-30 07:18:42 -0500)
> >
> > ----------------------------------------------------------------
> > NBD patches for 2024-05-30
> >
> > - Fix AioContext assertion with NBD+TLS
> >
> > ----------------------------------------------------------------
> > Eric Blake (2):
> >       qio: Inherit follow_coroutine_ctx across TLS
> >       iotests: test NBD+TLS+iothread
>
> Patch 2/2 only works on machines with /home/eblake; I will fix that in
> a v2 pull request.

Alternatively we could add that to our release notes
as a build requirement ? :-)

-- PMM

