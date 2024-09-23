Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323BDCF9C70
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 13:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssjJd-0001Pm-Rp; Mon, 23 Sep 2024 09:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1ssjJb-0001O9-Ss; Mon, 23 Sep 2024 09:41:24 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1ssjJa-00071l-5b; Mon, 23 Sep 2024 09:41:23 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d877dab61fso2902245a91.3; 
 Mon, 23 Sep 2024 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727098880; x=1727703680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ob0tuLdSfnxvJkrNlv/G7sLiaNwKoC+yrUlbqE7BW4=;
 b=LD7huNsrVWZUXDTqcIpjvJUYpl//stmAgFmOQx9mqfvbnL1merBts5NO6gTGZaWtU2
 nVH+msx0So80wQ3EDvnHQk3JfITRNF/x/qtT/wn5SMhDiE1bRS7UdHpofVD/wXhtsDmK
 x1sHZrb6SK7S1NXu7vB7JohF/xn1l6OcLYFEIeYteksOqiO7ea7jFzCLZSdPXDEEPPuV
 sXfdEWxdd4Hs5jnVxrEJxkzPIiLfCGwnO7P1yjkMo4ujQ/dL1rjaMOdikay5h+iKN1LG
 oRzav4Bf2/n9S0OZZmHvrhnkZslylRI8nXxtWiZk3mLQ/EPBooyGJnMaLIB6PkLlhWGM
 GcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727098880; x=1727703680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ob0tuLdSfnxvJkrNlv/G7sLiaNwKoC+yrUlbqE7BW4=;
 b=YRPNei5DhUO8lMbRbOZg18wqLrluK2aCUGtIR+5AzRtrcb2JLPZzVB9BmxRErOKXS4
 jEarq2Gf0F4BJWKf/ZrsehdWjT6Hf8gvq9IgtR6giF6SYikXVymOKPX/rG9o9NZfyT31
 S7oh+mDBDy8DExXV9YK4X9W98bNIRFPNkbpDdRjV0/P8PYC8Tfh0CepxEZxHXIv4BmEB
 q7ALM0uVm25vGGdnAA+VParYhGirOt5F6S+RA2PNeXvurbWVA5x3GwTM3LH2KnA7MF3Y
 JiSveQ4iGHU7HOvIDMbzuZXxIJzWhkuvY3N7oLdI6NSs0Vfw0E90NlgFaQihs8OJ5bzX
 iwaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsaFleoKtu6NK1Any4ZrwS8dQoPDbh8Cn9hpHS2vn3MvlSebwqlW4rofK6LfrVVFJrKc0hqhS7XM6U@nongnu.org,
 AJvYcCWuUEu2CKcvY7qjluw951i4mONoBSM6mN7Wm1kcBd4gvb3kkS9B5MtL56uVSn7ZryZ9tP16mnyVVj5t1w==@nongnu.org
X-Gm-Message-State: AOJu0Yzw0ePZWLrotNodHXAHROld1ZgNGRIDKxvuClt5codn06qIcLxC
 K3aX1kyqgD3WZk9fGvC7JXi8LgAKALq+P8UNn1KhqGcO8r0VGf/Ar8+JeCDFkUvbmi5b1GAUxZM
 aQcgog8WaHxLpQQHgLhjHjb483g0=
X-Google-Smtp-Source: AGHT+IHmCZIuyLBJ/laPjV3Jf0Z+gglPUmbrQdyYY23PSa6O30wBPvotQMhxTxPbHOdVMewrxkZNfLHh/rovJWxx008=
X-Received: by 2002:a17:90b:4c07:b0:2d8:cd04:c8f0 with SMTP id
 98e67ed59e1d1-2dd7f763a86mr15047849a91.39.1727098880250; Mon, 23 Sep 2024
 06:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-4-faithilikerun@gmail.com>
 <20240312183010.GB389553@fedora>
 <CAAAx-8LyxDtZra_5TC0CLmq4F4ShYtQqVTF0OCGVZ9tYWP4QMA@mail.gmail.com>
 <bc821290-2003-4795-a5fa-99a7c55e1374@kernel.org>
In-Reply-To: <bc821290-2003-4795-a5fa-99a7c55e1374@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 23 Sep 2024 15:40:54 +0200
Message-ID: <CAAAx-8JrPFEgBPKWEjXCXi8=ReEMkCEVGe-GEPSWUnfEGcZ=XQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] qcow2: add zoned emulation capability
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Damien,

Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/09/23 13:06, Sam Li wrote:
>
> [...]
>
> >>> @@ -2837,6 +3180,19 @@ qcow2_co_pwritev_part(BlockDriverState *bs, in=
t64_t offset, int64_t bytes,
> >>>          qiov_offset +=3D cur_bytes;
> >>>          trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_byte=
s);
> >>>      }
> >>> +
> >>> +    if (bs->bl.zoned =3D=3D BLK_Z_HM) {
> >>> +        index =3D start_offset / zone_size;
> >>> +        wp =3D &bs->wps->wp[index];
> >>> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
> >>> +            /* Advance the write pointer when the write completes */
> >>
> >> Updating the write pointer after I/O does not prevent other write
> >> requests from beginning at the same offset as this request. Multiple
> >> write request coroutines can run concurrently and only the first one
> >> should succeed. The others should fail if they are using the same
> >> offset.
> >>
> >> The comment above says "Real drives change states before it can write =
to
> >> the zone" and I think it's appropriate to update the write pointer
> >> before performing the write too. The qcow2 zone emulation code is
> >> different from the file-posix.c passthrough code. We are responsible f=
or
> >> maintaining zoned metadata state and cannot wait for the result of the
> >> I/O to tell us what happened.
>
> Yes, correct. The wp MUST be updated when issuing the IO, with the assump=
tion
> that the write IO will succeed (errors are rare !).
>
> > The problem of updating the write pointer before IO completion is the
> > failure case.  It can't be predicted in advance if an IO fails or not.
> > When write I/O fails, the wp should not be updated.
>
> Correct, if an IO fails, the wp should not be updated. However, that is n=
ot
> difficult to deal with:
> 1) under the zone lock, advance the wp position when issuing the write IO
> 2) When the write IO completes with success, nothing else needs to be don=
e.
> 3) When *any* write IO completes with error you need to:
>         - Lock the zone
>         - Do a report zone for the target zone of the failed write to get=
 the current
> wp location
>         - Update bs->wps->wp[index] using that current wp location
>         - Unlock the zone
>
> With that, one may get a few errors if multiple async writes are being is=
sued,
> but that behavior is consistent with the same happening with a real drive=
. So no
> issue. And since the report zones gets you the current wp location, the u=
ser can
> restart writing from that location once it has dealt with all the previou=
s write
> failures.

I see. To allow the concurrent writes, the lock will only be used on
the failure path while processing append writes.

>
> > The alternative way is to hold the wps lock as is also required for wp
> > accessing. Therefore only one of multiple concurrent write requests
> > will succeed.
>
> That is a very simple solution that avoids the above error recovery, but =
that
> would be very bad for performance (especially for a pure sequential write
> workload as we would limit IOs to quue depth 1). So if we can avoid this =
simple
> approach, that would be a lot better.

Yeah, I'll drop this approach. Although, it reminds me of how
file-posix driver emulates zone_append. It holds the lock whenever
accessing wps. Does that limit IOs to QD 1 too? If so, it can be
improved.
-- one zone_append starts
>> wp_lock()
>>> IO processing
>>>> wp_update
>>>>> wp_unlock()
-- ends

https://github.com/qemu/qemu/blob/master/block/file-posix.c#L2492

Sam

>
>
> --
> Damien Le Moal
> Western Digital Research

