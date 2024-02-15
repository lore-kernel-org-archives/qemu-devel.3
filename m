Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692B1C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafhL-0002lY-Dr; Thu, 15 Feb 2024 12:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafhJ-0002YY-LS
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:38:57 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafhH-00058j-Tu
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:38:57 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so1680840a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018734; x=1708623534; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y6pkeu6jZ6ZmZgRlPDpAqR9EIFF0QvDO6fF2xj7P6ZM=;
 b=OR25d1etD5qYxZXxfqUtFByVFZy8nF5OpedgBY11dZTwYW7/lyqEgcwdAz/9d4i+d3
 BisTWDjlqQvTbopjn47r/pFHw7+PfB4D2YP84u1evf9oL5FRDmfIMin5Mc/NUx5my89F
 ukkr8ISuLkVAz0BGcZDNhkRzA2PnnteaWe9WSdgoao3w2bdLmb9G/NHCAFSkb5MboElx
 06o9LuFVTAKpzCHZlGZZ3o2g8eAZwcnlf4CoZe4VS1XJKlJiob4ZmUGwyqhciXhKsGeE
 rC1MzJCioOk0LMcKt4ogpnXJUhpdF5rKWcytjVXdO+VybQLgyBAgP0f2zAf5STPPbcD7
 FAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018734; x=1708623534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6pkeu6jZ6ZmZgRlPDpAqR9EIFF0QvDO6fF2xj7P6ZM=;
 b=nY3K3SV7tRW09XfbxN8OU28Rm6AqETh66nqVJouPi1ooJulw4UoDW1KyK0XVYVLYUF
 60MQs6oKDlCOPsaa4mU5Vl0o1mjuw1MlFDL64C3E08+uirrC+nkWacd70z7lkX4t6yAX
 OkafD/QlU+ngMLe122WZbHD60eedTmo8PCIwKK3aY3UmJ54E0oiX8zIYb4JRsbf4aNbM
 ITj5ump6Bypi2pIOG6IntRz79t42/Lh2tel7/0OWUKCEl1YVgIHSzqyt9WRcBDwF9r6H
 mOAt67ns4dTiIFGSsZkyQGNTCIJsUMCfbZjkHefmx+S8FhKFg/nc8jFvWI19fdmtrnde
 XrpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYwI4nrlvyr53V3VFW7JGJZHuPzs8gi/LFPjFXJ+lRNcYRIlqR/RhoK6rF7SsT1Qsr1kZAysC+KBT+amNg8GoN/aaEShg=
X-Gm-Message-State: AOJu0YxPvo3Fne6sK5pyb6bQdSzDd6zPfyjugJl3U7LFMZccLzsuuTKx
 M4uPdIvShpiKETIUp9qnOAzQ+mfLSpj0MP9/hVx5mIGI1nq88MU+Bk9N3yz/AqJtLrlslVIR5mU
 KpIgoHGdFy2Cq7cYxgFZgEe4JiFAwitMmalZQ3A==
X-Google-Smtp-Source: AGHT+IFfjXB1ixHiZHQzDjM2sltSYywaCagw0slZjFwOIQ97z7bkIksMVWDafkhHxhr3zO8Y5I79EAKJ5UyWaE2gxko=
X-Received: by 2002:a05:6402:2151:b0:563:bd60:5809 with SMTP id
 bq17-20020a056402215100b00563bd605809mr1431081edb.31.1708018734452; Thu, 15
 Feb 2024 09:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20240209173103.239994-1-kwolf@redhat.com>
 <20240212152005.GA879395@fedora>
In-Reply-To: <20240212152005.GA879395@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 17:38:43 +0000
Message-ID: <CAFEAcA_sY5o3yzrWGw5JepTdYOzrfPEHuxDVuXvC+4wDcTizDQ@mail.gmail.com>
Subject: Re: [PATCH] iotests: Make 144 deterministic again
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, hreitz@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 12 Feb 2024 at 15:20, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Feb 09, 2024 at 06:31:03PM +0100, Kevin Wolf wrote:
> > Since commit effd60c8 changed how QMP commands are processed, the order
> > of the block-commit return value and job events in iotests 144 wasn't
> > fixed and more and caused the test to fail intermittently.
> >
> > Change the test to cache events first and then print them in a
> > predefined order.
> >
> > Waiting three times for JOB_STATUS_CHANGE is a bit uglier than just
> > waiting for the JOB_STATUS_CHANGE that has "status": "ready", but the
> > tooling we have doesn't seem to allow the latter easily.
> >
> > Fixes: effd60c878176bcaf97fa7ce2b12d04bb8ead6f7
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2126
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/144     | 12 +++++++++++-
> >  tests/qemu-iotests/144.out |  2 +-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
>
> Thank you!
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks; I'm applying this directly as a CI fix.

-- PMM

