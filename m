Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00470C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTx9-00038D-Op; Thu, 15 Feb 2024 00:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTx8-00037I-E3; Thu, 15 Feb 2024 00:06:30 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTx6-0001lO-V5; Thu, 15 Feb 2024 00:06:30 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4b7fc7642fcso191414e0c.0; 
 Wed, 14 Feb 2024 21:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707973587; x=1708578387; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1rS+gyWI8Z1XzFPCrL+oD+do4dnsDnyP93zrYKLlWE=;
 b=LT7zSmBICKphRjBvIbz74/O0bLu96c2brg9nveu9Jp7EMZzrczAA4UMQnC0Ee6eg6A
 nc6JIChaUpKVm/PIJEBWq75BsWwuKdN+NIhK22T9pb0csSZRAWNDlwQgDApvx/QB9WeJ
 QRFQvzK/1/AbhofZ+fP/HS9nW63TItuCt28svwfpWepWRP4nm0q5Adf4jiL9Ir4oqTjd
 4W3hrVS+mUO/XuuzjJyXpLYztp8wGQqzqkce7/d7NvffsDnxhdPQx92Y/5hmsyJO6wJ+
 F2b7qlCJaem/RwNgUn9kjzYWPSbcpndp0TeoVw2oPdmTz+Dagz4Nvj9pJSaAAy5llNR1
 trGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707973587; x=1708578387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1rS+gyWI8Z1XzFPCrL+oD+do4dnsDnyP93zrYKLlWE=;
 b=jJcGyEG++sHeHj1oExHn2BturLTkJwVXBnCLhLtIVRhwoyriD+cyBTP9Xo1Oj3Htqh
 b/r/czwde7z7XzTWN8Q40Uf4X15uVEiDxUPHRWynq+26n6RJwQmPmddEdJWfQniPUcng
 JmcPlBInvWoY7vUiUcYBQiSlS12g5Rmyw08P6fMk9+evF6SWpd5b/8UwzEaN1KINy0HT
 6wLjApsgRSFw2XKAKFwWIUUmYg+EZCkiE+nkvVhHcWT68GMS4zKov3C8rPo5cumcSkei
 k3vpRpy8vf+6wgnP+ebWQr95y1qWZf0CmRo09iKDimAnwKCOmy7vURT1R9UtRwi9VfK2
 nPvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpO6xRJJiYjJlLLKiG4lQ03GLE/6eHrj8bZDtKs9xvpNcACQFOrbuLEI6oCYRwAhtsHDOwW3Fjth7C25xlD4MbmjZt7EE=
X-Gm-Message-State: AOJu0YxtHpOHZ1Y/jliI+Ck2FxKqkPjmUv61XuVkPNWMHW9CImNIVT4S
 3+6sdiIYM76MOgmTJ4tBdwVjvfjt1JTSF33aguA5k3OoKa0KdA77tPzqN/CSY6x9CJSHi7+GBTE
 2e6rjLVmUN+c4Z67Zbja0g/Fq+yEXBp12
X-Google-Smtp-Source: AGHT+IGOxuDOUFR2fcn6QoJH67QXMzQn4YGp/PGwhrJLEp8Byt50gjSL526UrwoV5yJkafkZZKv8eyWwEAB7fVwA/bc=
X-Received: by 2002:a1f:ec41:0:b0:4c0:2332:5b5e with SMTP id
 k62-20020a1fec41000000b004c023325b5emr672356vkh.0.1707973587426; Wed, 14 Feb
 2024 21:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-3-dbarboza@ventanamicro.com>
In-Reply-To: <20240213191736.733334-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:06:01 +1000
Message-ID: <CAKmqyKNbKHaUoobB1v77w76Yg=RH3HQKnVYpwj6Uotcc51VkMA@mail.gmail.com>
Subject: Re: [PATCH 2/6] libqos/virtio.c: fix 'avail_event' offset in
 qvring_init()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, ajones@ventanamicro.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Feb 14, 2024 at 5:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> In qvring_init() we're writing vq->used->avail_event at "vq->used + 2 +
> array_size".  The struct pointed by vq->used is, from virtio_ring.h
> Linux header):
>
>  *      // A ring of used descriptor heads with free-running index.
>  *      __virtio16 used_flags;
>  *      __virtio16 used_idx;
>  *      struct vring_used_elem used[num];
>  *      __virtio16 avail_event_idx;
>
> So 'flags' is the word right at vq->used. 'idx' is vq->used + 2. We need
> to skip 'used_idx' by adding + 2 bytes, and then sum the vector size, to
> reach avail_event_idx. An example on how to properly access this field
> can be found in qvirtqueue_kick():
>
> avail_event =3D qvirtio_readw(d, qts, vq->used + 4 +
>                             sizeof(struct vring_used_elem) * vq->size);
>
> This error was detected when enabling the RISC-V 'virt' libqos machine.
> The 'idx' test from vhost-user-blk-test.c errors out with a timeout in
> qvirtio_wait_used_elem(). The timeout happens because when processing
> the first element, 'avail_event' is read in qvirtqueue_kick() as non-zero
> because we didn't initialize it properly (and the memory at that point
> happened to be non-zero). 'idx' is 0.
>
> All of this makes this condition fail because "idx - avail_event" will
> overflow and be non-zero:
>
> /* < 1 because we add elements to avail queue one by one */
> if ((flags & VRING_USED_F_NO_NOTIFY) =3D=3D 0 &&
>                         (!vq->event || (uint16_t)(idx-avail_event) < 1)) =
{
>     d->bus->virtqueue_kick(d, vq);
> }
>
> As a result the virtqueue is never kicked and we'll timeout waiting for i=
t.
>
> Fixes: 1053587c3f ("libqos: Added EVENT_IDX support")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/libqos/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 4f39124eba..82a6e122bf 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -265,7 +265,7 @@ void qvring_init(QTestState *qts, const QGuestAllocat=
or *alloc, QVirtQueue *vq,
>      /* vq->used->idx */
>      qvirtio_writew(vq->vdev, qts, vq->used + 2, 0);
>      /* vq->used->avail_event */
> -    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
> +    qvirtio_writew(vq->vdev, qts, vq->used + 4 +
>                     sizeof(struct vring_used_elem) * vq->size, 0);
>  }
>
> --
> 2.43.0
>
>

