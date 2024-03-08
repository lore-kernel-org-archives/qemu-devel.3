Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE8DC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricNr-0005RH-TX; Fri, 08 Mar 2024 10:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricNq-0005Kr-0X
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:43:42 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ricNo-0002gL-G8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:43:41 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so2714245a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709912619; x=1710517419; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lcTpTZZ/2XI8WSkm7ytBCAZELUZXEe8MGU72YvT8FKw=;
 b=tNaMMZnKwVcipxHjupR3ssTEqZBG63RbGv1RKKOHg11yN4EjCKkF5V0L4Zetx+5ZEz
 III6+D8aKBaJzv2hvJ0AUnhXNbrNj0N1HDMbTTrahS/D8XynzeReuCtBnuuvf9CCOpl0
 H2jRt9n1WVlsSwX9fbd77TnH5571Yjxcy3WuQ+NCLlzCUCR4qyrkZ/Sa5WV49MwWO0Pm
 9vLBQbWTKX+GKOg26i4JS4pS7bQpDhUldD+dsxKwOXy/nVJaHTBrJtQoKkRE7K7EpYom
 aBiXXoMInC0gmo9EP7QpHKI4NpFIqwj1T9+Zt9sLzKOdQMOOyiALgxnRV9jrPP1/6Oa8
 sr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709912619; x=1710517419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcTpTZZ/2XI8WSkm7ytBCAZELUZXEe8MGU72YvT8FKw=;
 b=WPRmSfvO+9v6RfJvo2lZkXe7mGpVAFn6GEcMICJhG751VaxiQ111ukUZVJ6ZJVmH6K
 MK1gibH6RMrnmTff7A3HcHqF9cYHqhOTzL+nUlDVAZf2pZp73GwCXmT1/NuPQk2PP66n
 3PeSDYCH2pwaSMsZQbtgWLX+O3pDuSeqY+yerhgVWPVAGGxFm8ek8RXOgl+TqGK+GWgJ
 Usxl6Wi+T6NdDFBGSyyaTnvDcVYdFEQ3emFJQfBDpU/1yG5EOHxUs+5cNxWYi0UaY4QB
 NlOw+lm+9GD8R/mYdyvLkF8ph7e/W0PzIdrevDNwAyKRSoJf5y6ws/P2KBwYOsU33I85
 jXuA==
X-Gm-Message-State: AOJu0Ywqka8nJzW8a5b6zSVDq2BuNnOccLeeDq93Bg7qIRu/Y3eLYWvN
 gH+q0b8IY16XsUeOQNQ3G/tFOaZuQu5EgFE5I5+IygRplwHXUmgBJPse/P4r5nTt6CaBTMBcSV5
 4NqE7YOoQmRYhumoXS5ll7nbyNBUjy2dWNM82Vg==
X-Google-Smtp-Source: AGHT+IG84v4Y0v2fGR7J3Z/ZTK8vCdPe5VYMhmXWuAcaHLJPEQIKDRnDq35S2gQ1VF2n9LyOhKCYvLKLYb27PqVAfFc=
X-Received: by 2002:a05:6402:5c4:b0:567:9fef:f7ee with SMTP id
 n4-20020a05640205c400b005679feff7eemr2199933edx.16.1709912618790; Fri, 08 Mar
 2024 07:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20240308104206.480929-1-thuth@redhat.com>
In-Reply-To: <20240308104206.480929-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 15:43:28 +0000
Message-ID: <CAFEAcA8nsTfK1dBO+ZaCAzRAsJzn9+Kvpao_C8uwZeyeRQh9tw@mail.gmail.com>
Subject: Re: [PATCH] docs/about: Deprecate the "mainstone",
 "tosa" and "z2" machines
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 8 Mar 2024 at 10:42, Thomas Huth <thuth@redhat.com> wrote:
>
> Support for these boards has been removed from the Linux kernel
> in version 6.3 in 2023, so there are likely no users left for these
> boards. Time to mark them as deprecated in QEMU, too!
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/about/deprecated.rst | 8 ++++++++
>  hw/arm/mainstone.c        | 1 +
>  hw/arm/tosa.c             | 1 +
>  hw/arm/z2.c               | 1 +
>  4 files changed, 11 insertions(+)

I agree that we should drop these, but I would like to be more
drastic -- see my other email in the "possible deprecation and
removal of some old QEMU Arm machine types (pxa2xx, omap, sa1110)"
thread.

thanks
-- PMM

