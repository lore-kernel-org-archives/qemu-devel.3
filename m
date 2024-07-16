Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9614C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiR1-0004wL-O8; Tue, 16 Jul 2024 09:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTiR0-0004re-HI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:41:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTiQy-0007NX-QH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:41:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5957040e32aso3620411a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721137292; x=1721742092; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SMGSvdkAZ2ivdrUTWibwSzorLwbEhV6yFHc4izlqJA8=;
 b=SSRWsDwpLAEOdavMkE25YH2N+MPj6dhvZUR8OOxU659GJ68/GgHif8YPUDU8W1uCIh
 26zh3++NRrL0WdGCioqi1E36hHv1jM0EwBWtF0brFAGjlbLs1MLPUVlkxEHh+F7qtz8D
 Cg09LzdIax6Tfg4DcN5l0+/luh0ieCSrMN10q4zP0Q+99kGVcPCGOVlvF2a+Y1BAn+wR
 E7oMHdgtUGYjU+1EEdT+olIp3FFamwHgifAtBkVUS8eT/kd6gPG0AHH5KVN/TS2arqyV
 TBBovDCsJ3Dv6Rlux4dFkbPvRs/JrXdTwwQtOdCwu+gux4S+BXKfNGjEQT2pmaibubhJ
 MuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721137292; x=1721742092;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SMGSvdkAZ2ivdrUTWibwSzorLwbEhV6yFHc4izlqJA8=;
 b=o8cCgxX57psxK6XSqY5VKVVB+seoy/jYSkE4xurHAJ6WTc3IcJkX1O7rg8wr0QGX6X
 VKl96nSvvRnRJy0kXVqcxr4fcG4W/kIIDhnGjGLJm67tgl8ZPMj0OlT12vZcBcDraWxG
 NHGtYenDiVz5AaqZS5W3/qFX+fAydOZYJkmBe6XL406/Em9wpSjNqq2Ncn7m1bv4EZDP
 HTWSJfTTz6jtPpiUGduosQViD70emxcS2D3ktWTynq6yNTme8T8eH4xg3EnWmD6TjYjy
 LB1wWu/NEf1XnY8gdxnaDTSMmMnXPaT2dM700vypZDM6RjKy5scCv6mqdPVCDn75fXnE
 C7aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQH4ow0fHHNN9Ijoh+1sIy/g9V0vzP9tKNBRtD6lDWLRNirtwNQ+HgwoKjHoaLsNaTBVA6gdV0ioiCSgeyhDGhAglMJg8=
X-Gm-Message-State: AOJu0YxreGzJXpbZCzDwnKqkU49Zz6ishyO1wcQgI4fPkHFzR52OAeal
 QPN4UpNdu9w+G3EULzxalSNbNXFN1w0+vN+PshzwE+ZZq4QXEdjbs9xUNuB25mKyHKdjzkdF2M3
 unsrRC719PNTnOKP/Uu849XRiJoe45GGDdD7NNg==
X-Google-Smtp-Source: AGHT+IGzvURVjgAvBpi59siz2mu5LxNuIBJ3Krigouwe/PTgpuTXowcZvqbI/c1x0oDppI8l2MSNleGgDnLpoTZ3VUk=
X-Received: by 2002:a05:6402:3553:b0:599:98c8:37fd with SMTP id
 4fb4d7f45d1cf-59eeda74796mr2435761a12.4.1721137292449; Tue, 16 Jul 2024
 06:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240716125930.620861-1-imammedo@redhat.com>
 <20240716090554-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240716090554-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 14:41:20 +0100
Message-ID: <CAFEAcA-YOK1XikAKWi1JrYyFprRt7GvPkp-17MT+C8XPprxhUg@mail.gmail.com>
Subject: Re: [PATCH] tests: increase timeout per instance of bios-tables-test
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 16 Jul 2024 at 14:07, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 16, 2024 at 02:59:30PM +0200, Igor Mammedov wrote:
> > CI often fails 'cross-i686-tci' job due to runner slowness
> > Log shows that test almost complete, with a few remaining
> > when bios-tables-test timeout hits:
> >
> >   19/270 qemu:qtest+qtest-aarch64 / qtest-aarch64/bios-tables-test
> >     TIMEOUT        610.02s   killed by signal 15 SIGTERM
> >   ...
> >   stderr:
> >   TAP parsing error: Too few tests run (expected 8, got 7)
> >
> > At the same time overall job running time is only ~30 out of 1hr allowed.
> >
> > Increase bios-tables-test instance timeout on 5min as a fix
> > for slow CI runners.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>
> We can't just keep increasing the timeout.
> The issue is checking wall time on a busy host,
> isn't it? Let's check CPU time instead.

The last time this came up Stefan had a look and reckoned
that the problem was that we try to run the qtests in
parallel when the CI host is only giving us one CPU:

https://lore.kernel.org/qemu-devel/9692cfcb-ef59-4cec-8452-8bfb859e8a6c@weilnetz.de/

thanks
-- PMM

