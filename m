Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47D1C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdNZ-0004Ur-5V; Fri, 21 Jun 2024 08:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdNX-0004UU-44
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:28:31 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdNT-00028x-V0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:28:29 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ec50a5e230so5244491fa.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718972905; x=1719577705; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RcoU8dNjuuMbLPmvpcGXNbe0tA3/ptO/v66er+1k4vg=;
 b=U1XllL/2ZX9l/jsYPJ6KN8ywJ2wPZGdjB9zRxaQwUm9/AAG6ErxBucfTVXe8rVIUPT
 qycrP6YST5TbCfkbYf4HY5C60JBRrv+C2a9j7T9EdcmCtbMEeFA4FB7yHybEkrMJzcwK
 Mm5M4uEIveqJVFzT1C9Vz0BUa9KlmrcAYKLDg6pqXwC/FNnfY3VAEfBJphb392BsdSEU
 o/NpQwBa1WdvhM/PKdWxjzZiWqqawX4jbEiCBDkuSjNJR/Tnm5FpjTFhvRVsIkEYa6Wk
 GVW1At2Fuw8iGCZ2IQPzxFsmMIoVxK5d252ta6vPy2akr8df2GrkNqgc7c5ySrFyt+3B
 Dx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718972905; x=1719577705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RcoU8dNjuuMbLPmvpcGXNbe0tA3/ptO/v66er+1k4vg=;
 b=UHm3dmkmhWo0Yet0PrW+xHTrCjOOH/mDC3zrjUEURIJOoMWt5NqiiUo1u1solQXi+n
 M4sxTDybhtxMLCDxJPt5+kkHssQYewv6/MgPByJhqvL9CPCum+tWpHSSbLteZd/Qp5FH
 inqlSP9NH3uJnB/xeblVeBD/jDNN3pBvpenNZU5LoHfxHZVL/DTEl9bw6xSMjKzDpkXv
 iS60vzVfHqYi7hDqrDLP+MJFoxjeMeKgYEd7rhVcNK3H0YMU8lhjo9Cq9fUhsgCnBtGy
 TFiKek9TpplbvA6DzDOzI+UW6nii3O/+ht6Hy/lKgZH+KQ6fKIvMY+ieihImKTtEENrd
 rf/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtGl5+CfAw1nbGrvAb4jHPS0r8IM01yoHaWFp2qvaQn80+WgGiH4CbOHK4egQgMwkaZmIy7xHWoLQ9c0XCAzJDDi+5qMU=
X-Gm-Message-State: AOJu0YzHaZxit8F3P3tRvwJvdz/7nahV19SpgyeQp76+F3naHnuurtTn
 xkLb6PMFFzwUWEZNtmztrrgjeLfzD2bJotB0CQLuFlmL2CqCpVCMeOMphfEX8nOlNurgOd6q+Cj
 sHl6sOhB//3cgJ9efke5TPFAjP2Ka1Ow35oZ95A==
X-Google-Smtp-Source: AGHT+IFeCiHUgSINMz9F7Ajoun+JJfztEnmUqXKJPaTJ8Tl5aImWv1CdmUh/qQqRdEMNMyTPGtWF7u1ZyBeKqLhfTcQ=
X-Received: by 2002:a2e:9e4c:0:b0:2eb:e471:dc39 with SMTP id
 38308e7fff4ca-2ec3ce9a910mr58161311fa.10.1718972905400; Fri, 21 Jun 2024
 05:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <4485ad60-45b9-4499-8f89-830c6e67decb@chinatelecom.cn>
In-Reply-To: <4485ad60-45b9-4499-8f89-830c6e67decb@chinatelecom.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 13:28:14 +0100
Message-ID: <CAFEAcA8ix+iy1mzUFYAq4X69ZqQvH96ULN1bLeJkKjW5GL4Zmg@mail.gmail.com>
Subject: Re: [PATCH] docs: Fix title format errors in the multi-process.rst
To: Guoyi Tu <tugy@chinatelecom.cn>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
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

On Wed, 19 Jun 2024 at 08:46, Guoyi Tu <tugy@chinatelecom.cn> wrote:
>
>
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> ---
>   docs/devel/multi-process.rst | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

I have a couple of questions about whether these are
the right heading levels. But this document uses quite
a lot of heading/subheading levels, and I'm not very
familiar with the contents, so my suggestions below might
not be right.

> diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
> index 4ef539c0b0..223f878139 100644
> --- a/docs/devel/multi-process.rst
> +++ b/docs/devel/multi-process.rst
> @@ -185,7 +185,9 @@ Another difference is that in the vhost user model,
> a single daemon can
>   support multiple QEMU instances. This is contrary to the security regime
>   desired, in which the emulation application should only be allowed to
>   access the files or devices the VM it's running on behalf of can access.
> -#### qemu-io model
> +
> +qemu-io model
> +'''''''''''''

Should this be ^^^^^^, i.e. same heading level as "vhost user model"
earlier in this subsection?

>   ``qemu-io`` is a test harness used to test changes to the QEMU block
> backend
>   object code (e.g., the code that implements disk images for disk driver
> @@ -587,7 +589,9 @@ described below attempt to ameliorate this effect by
> allowing the
>   emulation process to communicate directly with the kernel KVM driver.
>   The KVM file descriptors created would be passed to the emulation process
>   via initialization messages, much like the guest memory table is done.
> -#### MMIO acceleration
> +
> +MMIO acceleration
> +^^^^^^^^^^^^^^^^^

This seems like the right heading level, but should the
following headings ("data structures", "master descriptor",
"slave descriptor", "kvm_io_device ops") drop down a heading
level from ^^^ to ''', on the basis that they're sub-headings
under "MMIO acceleration" ?

thanks
-- PMM

