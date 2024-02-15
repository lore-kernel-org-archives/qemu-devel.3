Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578C0C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 05:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTu3-0002Ev-VJ; Thu, 15 Feb 2024 00:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTu2-0002ED-Ay; Thu, 15 Feb 2024 00:03:18 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTu0-0000q9-KR; Thu, 15 Feb 2024 00:03:17 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d5c40f874aso189782241.1; 
 Wed, 14 Feb 2024 21:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707973395; x=1708578195; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOJrSIr+FSrab5/ECJERd9ZL3GlptBROOh4RpOgFt38=;
 b=QJqnFJRz8S8O5lLT17enYt/QER7wH+psqIQRnnI/DcXI7c+7KTi7G/KK/sLvgf8hCk
 tw/fKp29s6Xeorxo/UpFmVclOqVeRMRokRuqomIo/aVR+4BP6cwEyt9tekeyQKmSNnk4
 eAzm1FZni6Lx00VddZP3cPlCT2GbpVLd8N/AZBvTGxpZwFXygadfh8AjHTRpa3xkVns3
 7ucN5rB+FWOxqqKxSyBvk9KDCDaeCgucF8c7cjBiPgQu4cEm4n90pj+4tPYPYnV5kP1Z
 IXSGvcM7EVjBx7qJZO8N/v6K1isZ02AhE4Gps/q+aaLTaxSfKTU2079MVt1sUejTVwTY
 zPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707973395; x=1708578195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOJrSIr+FSrab5/ECJERd9ZL3GlptBROOh4RpOgFt38=;
 b=fV3dvYNTDcDK9BMpnjTE8QWjQXRxQpJ8EdFmyFUM09vEbwb2QIJs+l3O374IPZSqWu
 RrYZf3lrFQMBJ+6c1d1nOP9poGyL4xy/nFPqXBKNjc6H3nvhpe6WxhvJJTtpPV1nrtiR
 pA8sop40wsPNsg9t0AAa7HXQQq3Me4TgIQiVSe00ZNWgBNHMYbiPgJ0qQavTbRVitOuL
 rSGwNBCBEo7CvIlyb94LaX/lhMSJhmoStLoVgyK7qmjnjwJbeX+2b+ulBks2zduDVSyI
 oviC53NxegJw02rdyPj2bFphetQ7k78pUvfsfv25L0Kaj9KNA0LglBxT7WvzFHili68W
 zdpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqImi5Hp/x0Wjpr0fO0ywVhgVFiNyBLGpgPDHdHSQeVqG1XCWwJsG+KlMK56kLvXt+8uptlCLgZIgIypa4tFoB9pmhEOw=
X-Gm-Message-State: AOJu0Yz7acJ6o+qbfcvWEBCUzuPEtsYBFGGWoX108i6ffetVTQ3ySMLU
 jIFaD7/PFX98BdAMUhagc/7ZFUdvlvSUqy7q584SePvEgJhhCqqUMHCxN8WNwoJuTlXX5dW/COz
 YX5AqXF6EszMm8pOP3VqWgBPZ2o3/mlWe
X-Google-Smtp-Source: AGHT+IF+G9D7LlSedKNknaFa0jxaDA21ZNd17AJmx3w0FAXg7bsN8+NH0bRbHSbuQJNZVP9EtezlBee+2LGS7l6e91U=
X-Received: by 2002:a05:6102:374c:b0:46d:617b:1bfb with SMTP id
 u12-20020a056102374c00b0046d617b1bfbmr1185903vst.10.1707973395139; Wed, 14
 Feb 2024 21:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240213191736.733334-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 15:02:49 +1000
Message-ID: <CAKmqyKNDig6RYhm8-+j_NO-t3eAy80DxDbaTP_49mLjDeFQwcA@mail.gmail.com>
Subject: Re: [PATCH 1/6] libqos/virtio.c: init all elems in
 qvring_indirect_desc_setup()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, thuth@redhat.com, lvivier@redhat.com, 
 pbonzini@redhat.com, ajones@ventanamicro.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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
> The loop isn't setting the values for the last element. Every other
> element is being initialized with addr =3D 0, flags =3D VRING_DESC_F_NEXT
> and next =3D i + 1. The last elem is never touched.
>
> This became a problem when enabling a RISC-V 'virt' libqos machine in
> the 'indirect' test of virti-blk-test.c. The 'flags' for the last
> element will end up being an odd number (since we didn't touch it).
> Being an odd number it will be mistaken by VRING_DESC_F_NEXT, which
> happens to be 1.
>
> Deep into hw/virt/virtio.c, in virtqueue_split_pop(), into
> virtqueue_split_read_next_desc(), a check for VRING_DESC_F_NEXT will be
> made to see if we're supposed to chain. The code will keep up chaining
> in the last element because the unintialized value happens to be odd.
> We'll error out right after that because desc->next (which is also
> uninitialized) will be >=3D max. A VIRTQUEUE_READ_DESC_ERROR will be
> returned, with an error message like this in the stderr:
>
> qemu-system-riscv64: Desc next is 49391
>
> Since we never returned, w'll end up timing out at qvirtio_wait_used_elem=
():
>
> ERROR:../tests/qtest/libqos/virtio.c:236:qvirtio_wait_used_elem:
>     assertion failed: (g_get_monotonic_time() - start_time <=3D timeout_u=
s)
>
> The root cause is using unintialized values from guest_alloc() in
> qvring_indirect_desc_setup(). There's no guarantee that the memory pages
> retrieved will be zeroed, so we can't make assumptions. In fact, commit
> 5b4f72f5e8 ("tests/qtest: properly initialise the vring used idx") fixed =
a
> similar problem stating "It is probably not wise to assume guest memory
> is zeroed anyway". I concur.
>
> Initialize all elems in qvring_indirect_desc_setup().
>
> Fixes: f294b029aa ("libqos: Added indirect descriptor support to virtio i=
mplementation")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/libqos/virtio.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 410513225f..4f39124eba 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -280,14 +280,27 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QTes=
tState *qs, QVirtioDevice *d,
>      indirect->elem =3D elem;
>      indirect->desc =3D guest_alloc(alloc, sizeof(struct vring_desc) * el=
em);
>
> -    for (i =3D 0; i < elem - 1; ++i) {
> +    for (i =3D 0; i < elem; ++i) {
>          /* indirect->desc[i].addr */
>          qvirtio_writeq(d, qs, indirect->desc + (16 * i), 0);
> -        /* indirect->desc[i].flags */
> -        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
> -                       VRING_DESC_F_NEXT);
> -        /* indirect->desc[i].next */
> -        qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1);
> +
> +        /*
> +         * If it's not the last element of the ring, set
> +         * the chain (VRING_DESC_F_NEXT) flag and
> +         * desc->next. Clear the last element - there's
> +         * no guarantee that guest_alloc() will do it.
> +         */
> +        if (i !=3D elem - 1) {
> +            /* indirect->desc[i].flags */
> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12,
> +                           VRING_DESC_F_NEXT);
> +
> +            /* indirect->desc[i].next */
> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, i + 1)=
;
> +        } else {
> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 12, 0);
> +            qvirtio_writew(d, qs, indirect->desc + (16 * i) + 14, 0);
> +        }
>      }
>
>      return indirect;
> --
> 2.43.0
>
>

