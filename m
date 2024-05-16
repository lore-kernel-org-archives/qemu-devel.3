Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59150C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7czu-0007J3-LO; Thu, 16 May 2024 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1s7czt-0007Ig-8y
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1s7cze-0005fp-8x
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715873164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IYdMWOF4Cn/jq10inMPb5g39OtCoSDX7MqpcXyJIx48=;
 b=EZP1hZ33BJ41RrX0E+KKDlH+h0qZScV9uNNMHF1ClH/+P8aMfKE/EiTJbAPdwJwNm1AGo3
 NLpiTbbBg8H4pg4PjLk1+YPFXFR57Z9K5yNbferu2zVQmePAbxzs09WzYl93cf8IbKx8yG
 klpYozrewTJdPa1UxEVrXqkwuhttujk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-gRdkr0_KM7qf3_ee-CRPyg-1; Thu, 16 May 2024 11:26:02 -0400
X-MC-Unique: gRdkr0_KM7qf3_ee-CRPyg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de556e51355so371325276.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715873161; x=1716477961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IYdMWOF4Cn/jq10inMPb5g39OtCoSDX7MqpcXyJIx48=;
 b=gwYMxfwu2JW0OshgqQcDO37Vcb6LEWamQ40wUYrevRctpJEo1fghMKmzjc5E98ZkAh
 99GM4IuVg5VOKnqnzLQ16ZUwXKRzSo6oVgR5AA4seO50banI+oG9ycYS4cgK5Wx6jp/E
 nT1jDxGY4wo4f7ObObclNfvxupd67PJQerk5eQT5EanTz1hqINYbN7X88byqIAqJgpBu
 QRseIAqS4RuGBMN5BJvN3c3P8MUn8AyT+FnUz5GM15ptj3W9m34RJVyQKjgcs36OV9aY
 05wKk8vV9HJRIu78C8vVxFtllbI1N7w95FDcJ11z1e0zrg+gmjo0HayOfTGzr8dj3jLs
 DbTQ==
X-Gm-Message-State: AOJu0Yz77FNy+ztIu7szcQxXEvedak7XlXyy8AS2Hm/5KOxJjfHiEgYZ
 dG1vfSqVYMlssQRgJ6jhEOIpVFLB8gsmd4Vcxv7zKzMX+SxaceECP8FcaUDh9Z3WB80LtQve2WC
 Xw/TasyHHi9CQKnD8mvtxFQ6+c5Kc6py2+XED4+QVHDcbAziZykkAs1AB92sjVmnxujXgP2xpP5
 U+6EpggboLcZYiclDgBmkw0USWsUE=
X-Received: by 2002:a05:6902:220a:b0:dee:7ff9:a053 with SMTP id
 3f1490d57ef6-dee7ff9a1c3mr10661617276.3.1715873161330; 
 Thu, 16 May 2024 08:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmfua9KlbznF7mY4PaBcBjVOOWBsFBRNxc1U/FM7eHDEaGV5tpJFv2UlPZDy18cPhHFnKzz378r0rJqDy2tuc=
X-Received: by 2002:a05:6902:220a:b0:dee:7ff9:a053 with SMTP id
 3f1490d57ef6-dee7ff9a1c3mr10661577276.3.1715873160642; Thu, 16 May 2024
 08:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240516084022.1398919-1-marcandre.lureau@redhat.com>
In-Reply-To: <20240516084022.1398919-1-marcandre.lureau@redhat.com>
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 May 2024 09:25:49 -0600
Message-ID: <CADLectnt6_G9trMjfEVZ7tn--bGfEy8iMAdjntjDSTeHUw2cqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Fix "virtio-gpu: fix scanout migration post-load"
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>, 
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000385c24061893dafd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000385c24061893dafd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good here, thanks.

On Thu, May 16, 2024, 2:40=E2=80=AFa.m. <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> The aforementioned patch breaks virtio-gpu device migrations for versions
> pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is
> more
> complex than it may initially appear, as evidenced in the problematic
> commit
> dfcf74fa68c ("virtio-gpu: fix scanout migration post-load").
>
> v2:
>  - use a manual version field test (instead of the more complex struct
> variant)
>
> v3:
>  - introduce machine_check_version()
>  - drop the VMSD version, and use machine version field test
>
> v4:
>  - drop machine_check_version() approach
>  - property renamed to x-scanout-vmstate-version
>
> Marc-Andr=C3=A9 Lureau (3):
>   migration: add "exists" info to load-state-field trace
>   migration: fix a typo
>   virtio-gpu: fix v2 migration
>
>  include/hw/virtio/virtio-gpu.h |  1 +
>  hw/core/machine.c              |  1 +
>  hw/display/virtio-gpu.c        | 24 ++++++++++++++++--------
>  migration/vmstate.c            |  7 ++++---
>  migration/trace-events         |  2 +-
>  5 files changed, 23 insertions(+), 12 deletions(-)
>
> --
> 2.41.0.28.gd7d8841f67
>
>

--000000000000385c24061893dafd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Looks good here, thanks.</div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 16, 2024, 2:40=E2=80=
=AFa.m.  &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lurea=
u@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: M=
arc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" ta=
rget=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Hi,<br>
<br>
The aforementioned patch breaks virtio-gpu device migrations for versions<b=
r>
pre-9.0/9.0, both forwards and backwards. Versioning of `VMS_STRUCT` is mor=
e<br>
complex than it may initially appear, as evidenced in the problematic commi=
t<br>
dfcf74fa68c (&quot;virtio-gpu: fix scanout migration post-load&quot;).<br>
<br>
v2:<br>
=C2=A0- use a manual version field test (instead of the more complex struct=
 variant)<br>
<br>
v3:<br>
=C2=A0- introduce machine_check_version()<br>
=C2=A0- drop the VMSD version, and use machine version field test<br>
<br>
v4:<br>
=C2=A0- drop machine_check_version() approach<br>
=C2=A0- property renamed to x-scanout-vmstate-version<br>
<br>
Marc-Andr=C3=A9 Lureau (3):<br>
=C2=A0 migration: add &quot;exists&quot; info to load-state-field trace<br>
=C2=A0 migration: fix a typo<br>
=C2=A0 virtio-gpu: fix v2 migration<br>
<br>
=C2=A0include/hw/virtio/virtio-gpu.h |=C2=A0 1 +<br>
=C2=A0hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1 +<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 24 +++++++++++++=
+++--------<br>
=C2=A0migration/vmstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
7 ++++---<br>
=C2=A0migration/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A05 files changed, 23 insertions(+), 12 deletions(-)<br>
<br>
-- <br>
2.41.0.28.gd7d8841f67<br>
<br>
</blockquote></div>

--000000000000385c24061893dafd--


