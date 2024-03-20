Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77376C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzvn-0005Dr-Nc; Wed, 20 Mar 2024 13:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rmzvb-00059f-MQ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:40:39 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rmzvX-0002mV-Jl
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 13:40:39 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5a485724ddaso71931eaf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710956433; x=1711561233; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gG8tDD70qjH8tEUTkZZNu/A5lFJ/cn1XnBlvMkLynGM=;
 b=H0p6beWGt2ueruY865Jcz92IDLCmOm1UHC7P8Cuqg0IE6lXzlTg6pgLwSYgoHVZExU
 jP8MtBlv/cWrJkppL2MTGOZQwmbp6knkg0NGMA5bU1/x8bzcbpkuENr/aB3xlpz3yih4
 1hc5CqyHnDIWUgxgX7uL9PojW2WmUTGvbr8XwwKBR3SkQJhMTKt4NxBOF3ywrYFWJETa
 vvTOxzgmn9K2mdlaXTyDBXKiNUHBUPsqxSR5Z12m75jgbB+etZXiIeexF4TwQ/cKrSGA
 x2pNs9ycIt5SyK+p9cGDJ3hIvdtzVRx/owAU98d0AlfWwe4pE35tGpiVv8+n6sQxKpw7
 KUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710956433; x=1711561233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gG8tDD70qjH8tEUTkZZNu/A5lFJ/cn1XnBlvMkLynGM=;
 b=S2RxoXsV2qQ5dPdvf6ffjeA4REp8k1fAL8CfZpcMjwUuehLZbmPyKLUzs36kEFbbl6
 Ml3N7dcx1VBb7gMi5lt4XE3619dmVF0EFTLbOWYasqJ/OHW7N66I7jTYrR90Lumc6j5n
 1yueBIG5yJ7+lgicO9TyVAuxqgdVPxyxM1styhj1TfbLb5urXqVjiEbgNkFpk2q33i5v
 ZfTgU9Cu2Lg19o2v0M7x4ZRYS4wPGxJ/L75ZZi8nswFiTCswIsAc9MybbN0ozeyPACu/
 YiGWXrGspamWrvb9qji0Va5v3ccGneHDvYlLddzsn0OkFrozAB+CY4qmxRR1AM50rnoP
 JRig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCGgWdnRP9Kdx6y831iOGoRc4Gd0PaiDlGNAL6qBgrR91Jqn7SHXlgGuESz254eQJQjm9FzCK5Y5xmjHtetmzQIlVnQ4A=
X-Gm-Message-State: AOJu0YwskTz6bqmYKZAWaAjJ+SnFQM65zbWbFG5BLofqmC4fpN1kHno6
 rIsRIhAhWUINVveq5up3+aT9HKfpK2TA1+5/NeJTpdd4HyvFH1Tskjcj0Z8CdpB4njIMnbByrvY
 HkuPHrmLiyVRfeqc9tDMIMOgYG74=
X-Google-Smtp-Source: AGHT+IETfy7CpR4I9gJvmTkVNXZQr961WcJJsuqbbXhXEtmEpJsPQuIqKKjVshky/gxansH9bxqlqsjczsvLMrdgutU=
X-Received: by 2002:a4a:7614:0:b0:5a4:75f2:54d0 with SMTP id
 t20-20020a4a7614000000b005a475f254d0mr12725754ooc.9.1710956433437; Wed, 20
 Mar 2024 10:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240320090442.267525-1-zheyuma97@gmail.com>
In-Reply-To: <20240320090442.267525-1-zheyuma97@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 Mar 2024 13:40:21 -0400
Message-ID: <CAJSP0QU5GU56T1ffaAkpdx03aZtM71+e-gEC3uYERxFj991RMA@mail.gmail.com>
Subject: Re: [PATCH] libqos/virtio.c: Correct 'flags' reading in
 qvirtqueue_kick
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 20 Mar 2024 at 09:10, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> In qvirtqueue_kick(), the 'flags' were previously being incorrectly read from
> vq->avail instead of the correct vq->used location. This update ensures 'flags'
> are read from the correct location as per the virtio standard.
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  tests/qtest/libqos/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 82a6e122bf..a21b6eee9c 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -394,7 +394,7 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
>      qvirtio_writew(d, qts, vq->avail + 2, idx + 1);
>
>      /* Must read after idx is updated */
> -    flags = qvirtio_readw(d, qts, vq->avail);
> +    flags = qvirtio_readw(d, qts, vq->used);
>      avail_event = qvirtio_readw(d, qts, vq->used + 4 +
>                                  sizeof(struct vring_used_elem) * vq->size);
>
> --
> 2.34.1
>
>

