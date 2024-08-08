Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F3C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc26H-00026l-2K; Thu, 08 Aug 2024 08:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc264-000225-Mz
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:18:24 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc260-0004Kk-UZ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:18:23 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso1333781a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 05:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723119499; x=1723724299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zi9sX+DTI3feKYd7o6wdPYkpWEi0A/NxHg7OEi7mzRY=;
 b=wS0jIYQ2GuQ5BCNvovQKtLtvNWqblOOtR5K019cERgR7aW2WOvPqDWYdJct5SOCs7U
 Y8HGX7YMMBnZ6RXZDe6VYoS+cP4g6RtJjI2TZe9mhOg6utYsIiNX3KSIHfDbiW27R6kM
 QbvPJwlbT3wYW7EkmRrNupdDdMaBHx1yoeQsJ4gl8qUNYIEI9om/GzloatmTtXd7wtIm
 0+RpISaRFB2dnmc18IBcAYs4Lr+HIuQGYM3cIHE0XKtx5gQlNanLAbVQNGg54miLJSXn
 NGoAOpmunQGI4rWNKTPFRqVfnIryxeNYCqmMAH5/1MbGo7/tv6LrrBQ1JfbN1fzEDcoN
 sLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723119499; x=1723724299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zi9sX+DTI3feKYd7o6wdPYkpWEi0A/NxHg7OEi7mzRY=;
 b=INza7+AblmyhcdrAL9K+DvWajuJLlGyAej+G0nx3UJX6kJuRj91IKtLCR2tjGDGDdq
 jsWH7ZHpcfQmlOXfr2K0Cl0ryPHj/cz5PZQVxTNmzBoJqGxaKMoI8bqXP+UEuNZgGv4C
 ADuey7UVG/e20faX0aOSf+RuqZqGZ83XivMS5pXmeg9fF/aVjsDGvfHGjom6Ar5l1i4Z
 T5kIkluw8D6KOp6CRVLrQTinGmLZBfeIdEiJ02UQ5SNg/eSP4FM1UdYtcY4vQWVyUOCH
 aBHr+/3cqh3s60d7R8BH9fvlCSEWFw1Sbf60r38gGSeyxXYFak1XItgGlvXqlo4YMoS2
 bb1A==
X-Gm-Message-State: AOJu0YxssVRRGh+PaDbbBf3EGlK9AwokZjsmTRUa5O5AgS95vfbmgGCA
 NVwCKBez8y0lkQAfExObdQDTD7Z3ajSmZanL9fGuNx0WdYgFhksfjQicjhDp1RAehsi0kk7X/ff
 KKO8Ft7/F68dn9ltmDt81oJgWtE1BnZdbi+IvkdRZkTkNXtYi
X-Google-Smtp-Source: AGHT+IHOX2t/07T0DhI+AGpEKa2FqUAw1zJcEnjC3vjvbrLJRWuO+yVe55+hdss78lB7w3ApTiRMt6sAMHQdy49vY9k=
X-Received: by 2002:a05:6402:5206:b0:57d:455:d395 with SMTP id
 4fb4d7f45d1cf-5bbb3c054bamr1375018a12.7.1723119498601; Thu, 08 Aug 2024
 05:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
In-Reply-To: <20240806160756.182524-3-jmarcin@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 13:18:07 +0100
Message-ID: <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
>
> Some devices need to distinguish cold start reset from waking up from a
> suspended state. This patch adds new value to the enum, and updates the
> i386 wakeup method to use this new reset type.
>
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  docs/devel/reset.rst    | 7 +++++++
>  hw/i386/pc.c            | 2 +-
>  include/hw/resettable.h | 2 ++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> index 9746a4e8a0..30c9a0cc2b 100644
> --- a/docs/devel/reset.rst
> +++ b/docs/devel/reset.rst
> @@ -44,6 +44,13 @@ The Resettable interface handles reset types with an enum ``ResetType``:
>    value on each cold reset, such as RNG seed information, and which they
>    must not reinitialize on a snapshot-load reset.
>
> +``RESET_TYPE_WAKEUP``
> +  This type is used when the machine is woken up from a suspended state (deep
> +  sleep, suspend-to-ram). Devices that must not be reset to their initial state
> +  after wake-up (for example virtio-mem) can use this state to differentiate
> +  cold start from wake-up can use this state to differentiate cold start from
> +  wake-up.

I feel like this needs more clarity about what this is, since
as a reset type it's a general behaviour, not a machine
specific one. What exactly is "wakeup" and when does it happen?
How does it differ from what you might call a "warm" reset,
where the user pressed the front-panel reset button?
Why is virtio-mem in particular interesting here?

thanks
-- PMM

