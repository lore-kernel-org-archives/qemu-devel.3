Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37696C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Hqu-0008Dg-L2; Tue, 07 May 2024 06:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4Hqt-0008DL-2A
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:15:15 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4Hqr-0007t7-8e
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:15:14 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-61be4b98766so34010057b3.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715076911; x=1715681711; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpKQRCEqyzJjjbPPWpSEgjupZ5HS3Nt1X99gw53bpPo=;
 b=GGITFLzLGGsPTCoX9WHVQ584iH84q81+dJc64TCTVWjUQzwtECHpgTKNZB0t1ak7Xp
 //aNpHR/1osf75BGs4OB5YOkt1w7rcemxOIA2kHI12yGHboenTt1zbt+BuhpE9GtJlXD
 /9/AbNLit9Vrdwc7zwXFVdkURUCnBQh+A86p0xoAeC6hQJCJCqF6WwNUHb9KoC+pp6lT
 pqzQVJgQfJXFA8VHMD3FY+orKeNT9yl8ulbkNexYFbbKkhseM4wnrWJ/dFE9KTUmXFxH
 I9ohUb9k/xfKNkMQ7NyAMaB8iGIf/eBYBhM3Llp6OZ679SDqzt/MdybFrkVjlc2X+9C4
 0vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076911; x=1715681711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpKQRCEqyzJjjbPPWpSEgjupZ5HS3Nt1X99gw53bpPo=;
 b=ENIUyCHmzrWC265SfM1Vt8hy8Rd5ISq/D6A6VCCYU/2ERwtnum03WqAv5RykK0jV/l
 X9lwPDQKQXoRCHWkvC7czqXN9A1ONvDxfcKJTXxSQpwWM807GGIGxbkzxIRo6XFaovWb
 pQZUSiF5DYl4emlLsEpvAEXRI7rqdXQ7Nx+FBuUBGcoySWKF24hVdylZtZD3ZImZR0B2
 e5NityccN4dBKYGc1u9KDvrLKWJ8hiJKJNZLe0LIQNgyrxndT38iKIJY80ImelsNPWXI
 tWMqmjqCXGScY5RT8xYyZZYAl4VLhmnVOBgPlT6un0ZdjrZBwdv6QVpV6vrEUFlwb6nN
 xd6Q==
X-Gm-Message-State: AOJu0YwBl+SIQfHkiFjokfYGlgk6uj2e9F8dre5zKqzrRXJnCSKt3eO0
 9jhreKDCTjRjM1cBFQAIi0zaokvVm4XsyGNdYc/vcCmzlfEbBTEfp9sIGpxfXZsL3W+xm+2fQqb
 2diG0vssDvfMTUfpJDKFiPn3LOVM=
X-Google-Smtp-Source: AGHT+IFl8se267y1h1ElikM7wgwT34ose40NrHPKAXO38rG0J0U/cPfZQ1n08ygfMiUaUhqpUR4tP7PZrg8hSJSd/rA=
X-Received: by 2002:a81:451c:0:b0:61b:33c9:4ee5 with SMTP id
 s28-20020a81451c000000b0061b33c94ee5mr11335086ywa.46.1715076911018; Tue, 07
 May 2024 03:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240312140216.313618-1-marcandre.lureau@redhat.com>
 <20240312140216.313618-6-marcandre.lureau@redhat.com>
 <b3215169-005d-4766-ad19-3b649ff0e4c9@proxmox.com>
In-Reply-To: <b3215169-005d-4766-ad19-3b649ff0e4c9@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 May 2024 14:14:59 +0400
Message-ID: <CAJ+F1C+UMCTrSSE9Mx2BvrH=ydjVg+3S7hkFk+143wz1Eh9BDQ@mail.gmail.com>
Subject: Re: [PULL 5/5] virtio-gpu: fix scanout migration post-load
To: Fiona Ebner <f.ebner@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sebastian Ott <sebott@redhat.com>, peter.maydell@linaro.org, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1132.google.com
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

Hi

On Tue, Apr 30, 2024 at 4:31=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 12.03.24 um 15:02 schrieb marcandre.lureau@redhat.com:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The current post-loading code for scanout has a FIXME: it doesn't take
> > the resource region/rect into account. But there is more, when adding
> > blob migration support in commit f66767f75c9, I didn't realize that blo=
b
> > resources could be used for scanouts. This situationn leads to a crash
> > during post-load, as they don't have an associated res->image.
> >
> > virtio_gpu_do_set_scanout() handle all cases, but requires the
> > associated virtio_gpu_framebuffer, which is currently not saved during
> > migration.
> >
> > Add a v2 of "virtio-gpu-one-scanout" with the framebuffer fields, so we
> > can restore blob scanouts, as well as fixing the existing FIXME.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Sebastian Ott <sebott@redhat.com>
>
> Hi,
> unfortunately, this broke migration from pre-9.0 to 9.0:
>
> > vmstate_load_state_field virtio-gpu:virtio-gpu
> > vmstate_load_state_field virtio-gpu-scanouts:parent_obj.enable
> > vmstate_load_state_field virtio-gpu-scanouts:parent_obj.conf.max_output=
s
> > vmstate_load_state_field virtio-gpu-scanouts:parent_obj.scanout
> > vmstate_load_state_field virtio-gpu-one-scanout:resource_id
> > vmstate_load_state_field virtio-gpu-one-scanout:width
> > vmstate_load_state_field virtio-gpu-one-scanout:height
> > vmstate_load_state_field virtio-gpu-one-scanout:x
> > vmstate_load_state_field virtio-gpu-one-scanout:y
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.resource_id
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.hot_x
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.hot_y
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.pos.x
> > vmstate_load_state_field virtio-gpu-one-scanout:cursor.pos.y
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.format
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.bytes_pp
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.width
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.height
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.stride
> > vmstate_load_state_field virtio-gpu-one-scanout:fb.offset
> > qemu-system-x86_64: Missing section footer for 0000:00:02.0/virtio-gpu
> > qemu-system-x86_64: Error -22 while loading VM state
>
> It wrongly tries to load the fb fields even though they should be
> guarded by version 2.
>
> Looking at it with GDB, in vmstate_load_state(), when we come to
> field->name =3D=3D parent_obj.scanout, the
>
> >                 } else if (field->flags & VMS_STRUCT) {
> >                     ret =3D vmstate_load_state(f, field->vmsd, curr_ele=
m,
> >                                              field->vmsd->version_id);
>
> branch will be taken and suddenly we'll have a call to
> vmstate_load_state() for vmsd=3D=3Dvmstate_virtio_gpu_scanout with
> version_id=3D=3D2 rather than version_id=3D=3D1, because that is
> field->vmsd->version_id (i.e. the .version_id in VMStateDescription
> vmstate_virtio_gpu_scanout).
>
> Would it have been necessary to version the VMStateDescription
> vmstate_virtio_gpu_scanouts too using VMS_VSTRUCT (or am I
> misinterpreting the use case for that)?
>

Sigh.. this is embarrassing. This patch didn't receive enough testing
and breaks pre-9.0/9.0 forward and backward migrations.

I think it would be reasonable to revert the patch, but it's already
in 9.0. Is that acceptable?

There are various issues about versioning:
- VMStateDescription (vmsd) version_id are not in the stream (only
start & full section headers), so any nested version bump should
somehow be bubbled up/down..
- machine versions don't have specific vmsd version_id associations
(that I can see, or is there any way to do that?)
- virtio-gpu uses even lower-level vmstate API and hardcodes version
to 1 in general

Ideally, I wished adding versionized fields the way done in this patch
would simply work, but this is really, sadly, not supported atm.

And it would be great to have some testing for back/forward migrations.

Any thoughts, corrections, encouragement perhaps? :)

thanks


--
Marc-Andr=C3=A9 Lureau

