Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA5C35FEA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 07:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSHg-0003ft-Fd; Tue, 17 Sep 2024 03:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sqSHe-0003fK-2q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sqSHa-00041c-Ot
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726556750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/Nti9CqaU2f+tNuPgK9V89QroitnnvTKcGePrpOMzM=;
 b=iDWdqwT26NBhfrghUXi4jCjKbqzb0MCdZVbXfgI/B0gStO4f3bGXE1FjkP2mCUL2nOdscf
 1jZxzXMq4jSV3gPESFU0orehsw3xoqOPEouKF+Mz9FZ/GZkjKqz/izZ44lySYUNrYOYN78
 GNKOADS5anHnkwD/uY1pZTEvQF2NhEQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-pn_fdO9zP0uQlIrQko515g-1; Tue, 17 Sep 2024 03:05:47 -0400
X-MC-Unique: pn_fdO9zP0uQlIrQko515g-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7d235d55c41so5647879a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 00:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726556746; x=1727161546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z/Nti9CqaU2f+tNuPgK9V89QroitnnvTKcGePrpOMzM=;
 b=p5IhZn+pqZgxg/YsnoGPvhK4cVW/lKGu7wgHwbuHwxRtnw0Ho152E6EUcE+YIJ7vfE
 ZyHEbs/BYjc22EGYYvsfwlFxGTpCx2lrkXWbgi/HV05Vh+KwQ0YvgCRN0i2cU4DHqsUc
 LTggtVeq63oopdIFc2X7kPX7h872oJV+n+pMOAOdbmK07Whjc97eJRbkb/53U6VwNt1a
 /uLWm2cZ3ljSxmnlOJEZj2WasDQGOHmXFGGgz66SYWvEZMais4k0GxNGQA4BzKtgIlRg
 9bx6CsKIOWmKYyDX4CzDtc/Ehw0AaLshCOcKylHNZGrPxRpOZkqeYlEydwonBMfRwnVA
 HGEA==
X-Gm-Message-State: AOJu0Yw1WJLTemrTr1WIPRktvOo3BLeQquJaW58sT5R+QPrrA3wyjkyB
 xOCV1Zx5CoMveRxYzA3bIdV9WUyN8Ug+GEziH5S6Xh6qWxB9viZG65KJITuIPAYFUf3ohpiCWrd
 NXrUNiSJHui8EaKb4D5a+eVC8TaCl+P4j3Zt3OqllVLmc//Ienvu18zXVz7mrt7HYdBgrYjyKOw
 N9A0Yq9z6PyUlN05tC8W7iaoJI+sI=
X-Received: by 2002:a05:6a20:c70b:b0:1d2:e8f6:81e with SMTP id
 adf61e73a8af0-1d2e8f609b9mr497949637.24.1726556746712; 
 Tue, 17 Sep 2024 00:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1RmEcPiyQh7n08u1p/IrNjZdEKDSTB3sJpMyXatDo3bLdb9tSl6Q7FKptnW33zvekMpH0fV1QKMZKHOUd11Y=
X-Received: by 2002:a05:6a20:c70b:b0:1d2:e8f6:81e with SMTP id
 adf61e73a8af0-1d2e8f609b9mr497925637.24.1726556746395; Tue, 17 Sep 2024
 00:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240916175720.GG521955@fedora.home>
In-Reply-To: <20240916175720.GG521955@fedora.home>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Sep 2024 09:05:34 +0200
Message-ID: <CADSE00JqsgsgcniDoeaWZ7yETNm1wBa7MgrkfmOwACRCERM23A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 slp@redhat.com, hi@alyssa.is, mst@redhat.com, david@redhat.com, 
 jasowang@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org
Content-Type: multipart/alternative; boundary="0000000000008dd6b506224b518e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008dd6b506224b518e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 7:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:

> This patch series could use tests. The first two patches seem broken and
> testing would have revealed that the memory allocation and pointers are
> not quite right.
>

My bad. Previous version of the patch I did test with a device that I've
been working on that utilizes the map/unmap messages. But I skipped it
for this one. I will test it for any coming versions.


>
> One testing approach is to write a test device using libvhost-user that
> exposes VIRTIO Shared Memory Regions, launch QEMU in qtest mode with
> --device vhost-user-device, and then use the qtest API to enumerate and
> access the VIRTIO Shared Memory Regions. Unfortunately this involves
> writing quite a bit of test code. I can explain it in more detail if you
> want.
>

If we want to have tests covering the feature within qemu, I can try
to do this. I'm also more comfortable if there are tests in place.
As I mentioned, before this patch I was verifying with an
external device myself.


>
> Does anyone have other ideas for testing?
>
> Stefan
>

--0000000000008dd6b506224b518e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 16, 2024 at 7:57=
=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stef=
anha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">This patch series could use tests. The first two patches see=
m broken and<br>
testing would have revealed that the memory allocation and pointers are<br>
not quite right.<br></blockquote><div><br></div><div>My bad. Previous versi=
on of the patch I did test with a device that I&#39;ve</div><div>been worki=
ng on that utilizes the map/unmap messages. But I skipped it</div><div>for =
this one. I will test it for any coming versions.</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
One testing approach is to write a test device using libvhost-user that<br>
exposes VIRTIO Shared Memory Regions, launch QEMU in qtest mode with<br>
--device vhost-user-device, and then use the qtest API to enumerate and<br>
access the VIRTIO Shared Memory Regions. Unfortunately this involves<br>
writing quite a bit of test code. I can explain it in more detail if you<br=
>
want.<br></blockquote><div><br></div><div>If we want to have tests covering=
 the feature within qemu, I can try</div><div>to do this. I&#39;m also more=
 comfortable=C2=A0if there are tests in place.</div><div>As I mentioned, be=
fore this patch I was verifying with an</div><div>external device myself.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Does anyone have other ideas for testing?<br>
<br>
Stefan<br>
</blockquote></div></div>

--0000000000008dd6b506224b518e--


