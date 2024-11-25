Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC25D58D66
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFbwQ-0001RT-8C; Mon, 25 Nov 2024 11:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFbwN-0001Qc-Ii
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:28:00 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFbwL-0003el-Ox
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 11:27:59 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aaddeso6451455a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732552076; x=1733156876; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U5WYbADqcHaoeh6B3WcFvUkpp9G2Y8lECWRPkEPRMUU=;
 b=qoJGggfhBKbm46qMXbo9ZnBhlOLHnqDk7xrAY41wL2a8jIgdrTk1wuJgJnvCA5CUdz
 qQ303OirCHZ5ZvNTsaK9Zmkhjylmn52dZa8B4ojMF9esDRU5NRW9NtlKdm5UtNBjGlbQ
 I/CC4cqIgBdbuKCAXn+7cH0Ubm8KtR6v3cyYULdNssV4wkVJGqS1cWGYIG4erV8xR4iT
 iakAP2iKlrx5fI0dLDHSV4y1dngnHNdUad2/lZX9s1Vo02Krmpdsj/SR8kInI2z5+BYf
 giw687JoUfyFWn8aXoFgCOnplTv3pcZEChzk4XuuOlQA3zBfB10hRKI14+VsCpaqevWe
 sVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732552076; x=1733156876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5WYbADqcHaoeh6B3WcFvUkpp9G2Y8lECWRPkEPRMUU=;
 b=XCmpfAuMFzEbF26GQkgNs/NSfEPCzeGxQkjDtObYqm7hg7AxSNwSceq87hNYHi9IBY
 sMW9F19FyFGxdiWXwYcXrOeAjlSleSdfZUctzFKvdtnmemnSz5lybb1mNt1Ji8bPq4nY
 b98EToebTOe6UUKGFZSQ9N2lGc8nIFsggldXu5F4ELmmgBSNEwJcvskizvMyfzZV3fHF
 6pxu03Qg1NlrBtDHilmX0xxJKUoKrjrozBzKxPwjGWbYEwecgJJH7jMiYXUxzolzBqaE
 TNMd6bFwPRHUbFlnjCwvPHCwBx8BHIp5+K7goggtipIPkndQcdKxiUazZN2S9uDCSiIU
 h7gw==
X-Gm-Message-State: AOJu0YwrNQt09TPsMi08cVl+TzEzr3cR4feCi/JHiFK5/xJl0jEz8gBJ
 bOY6nloy5yJaef9d8poUAX4X27605lR2H633JhOVGYCnjSjkruQbPs5GZ2+TFiDUjm5n4qEgzG/
 eE6x2rDohshnQ+qlICxYSDi1bq4QB/rAa3MYYvQ==
X-Gm-Gg: ASbGncvPMN+ue7fKFBq1mR83hp5+GVVOCcZsoemUCUqj62UfD18W58ipzmanr2sV1fq
 nORqc0Z72HT++WOSkS3Af36MznOKSbfuz
X-Google-Smtp-Source: AGHT+IHNVkiccZwYzHXVBLrqVgj0Mg+6roRNoEZr4gZq3lP7hCx6DVC9qTtjBYeVEcRY2xwH3d3c78xDbv0+eQa66ck=
X-Received: by 2002:a05:6402:2707:b0:5cf:a1c1:527e with SMTP id
 4fb4d7f45d1cf-5d0205dbaf6mr13006910a12.8.1732552075688; Mon, 25 Nov 2024
 08:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20241125060809.15543-1-jasowang@redhat.com>
In-Reply-To: <20241125060809.15543-1-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 16:27:44 +0000
Message-ID: <CAFEAcA-N-vHFg2bwpZQCJbEbEZGaqGQBGKZozTiuno+JYKRbuw@mail.gmail.com>
Subject: Re: [PULL 0/6] Net patches
To: Jason Wang <jasowang@redhat.com>
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

On Mon, 25 Nov 2024 at 06:10, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 6b99bb046dd36a6dd5525b8f88c2dcddae49222a:
>
>   Merge tag 'pull-lu-20241122' of https://gitlab.com/rth7680/qemu into staging (2024-11-24 13:39:06 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce:
>
>   virtio-net: Copy received header to buffer (2024-11-25 14:00:51 +0800)
>
> ----------------------------------------------------------------
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmdEEtgACgkQ7wSWWzmN
> YhH5qAgAlKdcx/gFt4EBXtjVq/qbPluEGOQxvcRYLlN90rPLHPgCjAoT5ly3fIv1
> 4kCgcVZyG8SdGu1n0TzTTS9kg5tL7weQ9xEWwF0oyyuZABgAB7w/wpC8MHSkJFOn
> 2Tv+2Iab0dJ+e1pw71OMpE/YR5X2xq5vopsSHRtnyGWfRPGswJFwka+f8FS5DSiq
> 2CeNxADgTkPxJgDmOrNSsAPz8Rns77FAZdvDMqFjx1Lrqm8kPv9jzwOMO+a/2LpC
> t6OkpFzGjiiskPjSnSn/tzo4TfWYoABjJaI7b3vEqmNEJSTAaxltZNtSXZucctEt
> 1ihnFdjr/wPwGK/5Wu+qGnfDbFNxBw==
> =W4y1
> -----END PGP SIGNATURE-----
>
> ----------------------------------------------------------------
> Akihiko Odaki (6):
>       net: checksum: Convert data to void *
>       virtio-net: Fix size check in dhclient workaround
>       virtio-net: Do not check for the queue before RSS
>       virtio-net: Fix hash reporting when the queue changes
>       virtio-net: Initialize hash reporting values
>       virtio-net: Copy received header to buffer


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

