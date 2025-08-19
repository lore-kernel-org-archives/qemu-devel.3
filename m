Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D655BCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 13:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoMBL-0007Gu-K2; Tue, 19 Aug 2025 09:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uoMBA-0006wk-AU
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uoMB5-0007jY-Mb
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755609301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KOjGwKnHXPyPha+LoIO6Lfude4PLyYCOBrGW4SnURiw=;
 b=T0+VNx4hC44TtqwSJCN9DZUnDnJQE03frXHgUFwuHwpqFGUHKc9oZB0CVtU+F1DZdiidpy
 /uuRxCkNINb1tcFJQzwu5yhRtXdLwptyz0ShJevMFpo0ytbUnUKLhC9ohO+dO42h74o0xq
 rm67Hj7fTHNVs+BLx6t6Rd2AAnC3seM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-y9npDz5rO9m2u6y8DvzdIA-1; Tue, 19 Aug 2025 09:14:59 -0400
X-MC-Unique: y9npDz5rO9m2u6y8DvzdIA-1
X-Mimecast-MFC-AGG-ID: y9npDz5rO9m2u6y8DvzdIA_1755609298
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6195c331d9eso3264396a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 06:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755609298; x=1756214098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KOjGwKnHXPyPha+LoIO6Lfude4PLyYCOBrGW4SnURiw=;
 b=lgISFVB3VgWubrms91EBabTqPrdnE0UMJdzE+zjR6GHetHql05hTPcsEk28NBORG0v
 rhRhBnviZsgcP1F/EmbGXc+/sUt7MWcgqq1g6ouiTjusOgNUflyqFJeC+QLqQhPauSzV
 LCGy48rHIHC52sKw6/0MiB6th02eBfLOYYJPpkVEHp9ZPPT4qQ2mzEXcGb1dkIjHNvq9
 BBOOWR0XmDM6sJeC4ogAuOXVyHfsZ2ZECl42UmUL53tXnFmofADHb5xr42Y/lHfmoYUM
 xybAm83OV09NgLor/GGCdXt129qIjSmLLy+bE6KEpV5M2xLcodIlOmHgQUJgS3TaWcoK
 4ibw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXFA/poHEujQmwlLLVMDvb6JuWcv3ZrD/wKAIl34PCsxakiBiEfRDX8hZIxxkD52rZ/MgazYiES/kP@nongnu.org
X-Gm-Message-State: AOJu0YxdYzbM9iT02+zjIrEAasEpkq0X91cqKqh6SMeGTRXBtO1W2R8E
 88GTCIKIaDn3MfkSb7GlDYTiaWP5D/jeuYw7EaoMSWMUKp1ETELrdSmEQ7NgQK7RoBXGA7Q43iy
 HlNGqte0i3cuaPCcecnNR6L2aTICfjqI/v+uK40SequQciXSCStaNoihG4ZLNoAbmTRNy2JLNth
 rhcjlJedX5W6aWvQn7POPco77RFK/Hyv8=
X-Gm-Gg: ASbGncuD91qWlkUC6kzHURz8YQHO3BkwJNmnenavgx//jsNQuK2+8bkii093TXaYhIS
 OFJk+dcL73aV/jvXilw6VY08Txtj8wJKQxYRnryjcBnBCItPhqhw0RTgU98izK0z0EGksZdSJr3
 jD9Ax+A+WJQ1VuX5EqQnO5wg==
X-Received: by 2002:a05:6402:40ca:b0:615:2769:88bb with SMTP id
 4fb4d7f45d1cf-61a7e757039mr1876660a12.34.1755609297669; 
 Tue, 19 Aug 2025 06:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+bbJuA+GzweL2myCdgP7zV3ywuzIFT6UPayaK2pBwJm/LAquHzzjG4bELJ6Blip6nO4tFw23AewdG0BSegak=
X-Received: by 2002:a05:6402:40ca:b0:615:2769:88bb with SMTP id
 4fb4d7f45d1cf-61a7e757039mr1876642a12.34.1755609297233; Tue, 19 Aug 2025
 06:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
 <CACGkMEvHXy0=vwAGS+2S7jCa5TjLxOso-SYb15TTE5q=VtPA2A@mail.gmail.com>
 <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
In-Reply-To: <bcc0adcc-4d50-454c-abf9-334e15c712e4@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 19 Aug 2025 21:14:20 +0800
X-Gm-Features: Ac12FXw7gUvkk4HtktJw2770g8mLaLzArC--TEYybcS72jmmwhsxfOv23te482g
Message-ID: <CAPpAL=zQ-PQo78TeqmYgvGRnGeQFy0g-BAd2R405pdBbtCJQpw@mail.gmail.com>
Subject: Re: [PATCH 00/19] TAP initialization refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000086e01a063cb7a46e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000086e01a063cb7a46e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir

From the QE perspective, this series of patches cause a regression issues
for multi queues:
[qemu output] qemu-system-x86_64: -netdev ..."vhostfds": "20:21:22:23",
"fds": "10:16:17:19" : vhostfds=3D is invalid if fds=3D wasn't specified

Thanks
Lei


On Tue, Aug 19, 2025 at 4:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> On 19.08.25 05:45, Jason Wang wrote:
> > On Mon, Aug 18, 2025 at 10:06=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> Hi all!
> >>
> >> As preparation for further development of TAP live local migration
> >> (passing open fds through unix socket),
> >
> > I'm not sure I understand this, but I think it has been supported now,
> > or anything I miss?
> >
>
> Hmm, may be I missing something, but where?
>
> I see no code which put TAP fd into migration channel. Nothing about
> migration in tap.c at all.
>
> So, normally, to make local migration with TAP device, you have to create
> a new TAP for new QEMU
> process.
>
> I want to add a migration state, which will include needed part of
> TAPState, including fd,
> to continue using same TAP device in target process, avoiding also any
> initialization steps
> on that fd.
>
> --
> Best regards,
> Vladimir
>
>

--00000000000086e01a063cb7a46e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Vladimir<br><br>From the QE perspective, this series of=
 patches cause a regression issues for multi queues:<br>[qemu output] qemu-=
system-x86_64: -netdev ...&quot;vhostfds&quot;: &quot;20:21:22:23&quot;, &q=
uot;fds&quot;: &quot;10:16:17:19&quot; : vhostfds=3D is invalid if fds=3D w=
asn&#39;t specified<div><br></div><div>Thanks</div><div>Lei</div></div><br>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Aug 19, 2025 at 4:42=E2=80=AFPM Vladimir Sementsov-=
Ogievskiy &lt;<a href=3D"mailto:vsementsov@yandex-team.ru">vsementsov@yande=
x-team.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 19.08.25 05:45, Jason Wang wrote:<br>
&gt; On Mon, Aug 18, 2025 at 10:06=E2=80=AFPM Vladimir Sementsov-Ogievskiy<=
br>
&gt; &lt;<a href=3D"mailto:vsementsov@yandex-team.ru" target=3D"_blank">vse=
mentsov@yandex-team.ru</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi all!<br>
&gt;&gt;<br>
&gt;&gt; As preparation for further development of TAP live local migration=
<br>
&gt;&gt; (passing open fds through unix socket),<br>
&gt; <br>
&gt; I&#39;m not sure I understand this, but I think it has been supported =
now,<br>
&gt; or anything I miss?<br>
&gt; <br>
<br>
Hmm, may be I missing something, but where?<br>
<br>
I see no code which put TAP fd into migration channel. Nothing about migrat=
ion in tap.c at all.<br>
<br>
So, normally, to make local migration with TAP device, you have to create a=
 new TAP for new QEMU<br>
process.<br>
<br>
I want to add a migration state, which will include needed part of TAPState=
, including fd,<br>
to continue using same TAP device in target process, avoiding also any init=
ialization steps<br>
on that fd.<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
<br>
</blockquote></div>

--00000000000086e01a063cb7a46e--


