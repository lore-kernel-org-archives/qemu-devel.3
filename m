Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5A9C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCwL-0007vB-KO; Mon, 01 Jul 2024 05:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOCsI-0005au-Ho
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:59:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOCsF-00077t-5s
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:59:00 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5854ac8168fso2979431a12.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719824337; x=1720429137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l2lyDssl4G6ryHXDn9OaZUeP+3jqeJ+ldt2WC0u/TIc=;
 b=g+g6FKYpBUseHADFeRDDnnA441CSwUjmx103fjxJyhK9e3OXhhp9qwavP//P2Yb59c
 D8EflJV7o6mvIFDBeqbV7sRmTdGUAzz6DCbbgp24yDS60GGOZshb+TEH0Y0bFqFKnwWU
 ob3YHs+bTRjpj41u8fzivGmjXDtQnY8NjmAdLHkt/drHh3ZSKgw2pSQfWuioGridq7F7
 x7sGBeF4R2KG++I3tyZkjbkAKXe4n7pFZpkjhZJ+AOCS0GM4+T+l7K2Nk6y6BrSVXWFc
 xEgd1r5e1YS5WYzVRxmdUtRmzeOw8Qt6AvAz2tEjpcMjU9yBwI3Xk+IgV9Pr5W1Su5+l
 isNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719824337; x=1720429137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2lyDssl4G6ryHXDn9OaZUeP+3jqeJ+ldt2WC0u/TIc=;
 b=GYGlXnao/xKddk8QuwTLdsz3uCUGaZdlaUEzf4v0fio3YzdLtkgQk2F/u6dnoM8cMa
 cNyqR5hZ4f0uLzeyKyjd7BQl5gQuPDJ9dOgJgMRVliC9R8IgHW5ts4bxwH7VgjcIxoIk
 pzWDEaupbj7nc0xrLbSBTNvJkfnYdD2+O301sAKTe5N1D6S4/DJeKlErMaORyxyBWe3O
 +hmmeDcxdBhfw1pFv47u87p4s2FapRr5cdHFnOSueCJx4+C3OsKesvGTzo2FN3/8KhTZ
 5N4lMX4f7pO2E9bPGVcfhEqJLcbXjg/84etIhXwUBpZafAXpCxzJ8yrmiBIeJlijPzoq
 RFtw==
X-Gm-Message-State: AOJu0YwF41XFGxGYw51JVSb0d4S16xzLF82s1YPTyIDIbQBCHEW9hg5S
 XCjP+wj5opIrZNWKvckghSi0t7cW5UezoxnfKvQ8zygRFC076rB5SYE+nyoIztzO2W1HYsPMXw5
 qx77+WzG93RT+PWlQaomKDoyxTKX7Rkbg0PI1ZG+pfYhkV2mO
X-Google-Smtp-Source: AGHT+IHjh+YTvsjchGNVXEubpw9/qk3HiRdxy9sCou4DoLJphbXRFLcRXoP2EFm557mIMkot27H3XU5CrpJiI+ma5YI=
X-Received: by 2002:a05:6402:2786:b0:582:7e6d:6816 with SMTP id
 4fb4d7f45d1cf-5879f0c6348mr3753181a12.8.1719824336839; Mon, 01 Jul 2024
 01:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240701075208.19634-1-sgarzare@redhat.com>
In-Reply-To: <20240701075208.19634-1-sgarzare@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 09:58:46 +0100
Message-ID: <CAFEAcA_y-o40H7fytjC_uzHoWeyq-oNU_k-s98GbsRnLbyT7GQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 jasowang@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 Xoykie <xoykie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 1 Jul 2024 at 08:52, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Commit d152cdd6f6 ("virtio: use virtio accessor to access packed event")
> switched using of address_space_read_cached() to virito_lduw_phys_cached()
> to access packed descriptor event.
>
> When we used address_space_read_cached(), we needed to call
> virtio_tswap16s() to handle the endianess of the field, but
> virito_lduw_phys_cached() already handles it internally, so we no longer
> need to call virtio_tswap16s() (as the commit had done for `off_wrap`,
> but forgot for `flags`).
>
> Fixes: d152cdd6f6 ("virtio: use virtio accessor to access packed event")
> Cc: jasowang@redhat.com
> Cc: qemu-stable@nongnu.org
> Reported-by: Xoykie <xoykie@gmail.com>
> Link: https://lore.kernel.org/qemu-devel/CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/virtio/virtio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..2e5e67bdb9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
>      /* Make sure flags is seen before off_wrap */
>      smp_rmb();
>      e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
> -    virtio_tswap16s(vdev, &e->flags);
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

