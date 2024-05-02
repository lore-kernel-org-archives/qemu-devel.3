Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93F6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WXJ-0002Ft-LR; Thu, 02 May 2024 09:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s2WX8-0002C2-US
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:31:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1s2WWn-0006JG-FS
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:31:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a55ab922260so1065113766b.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1714656670; x=1715261470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJMlFcicgGua5z7kq0AwPVXWRSb+VKbkmd19FQKbKvE=;
 b=KSAXctGQuXb3hfK300XjKGO0TyfoFpii78M8f8wiHZGSPJ4wwr3yBaL6bjOY4cmW5k
 k3YKsyVZAGHA1pVvM58Al/pqAZpAwbVClQn1fo/7uQa3MEgIDuXIx2H5jEt2OjNZ4hnJ
 veamNYDPeXxqgRB1WLotn4DcGd5DdxSgQ8Dd1qS0HMQc4Bb0lJf2+M+6wK00ECAAuQU5
 ItIno32ohGBWR/q1lir1hbwCmBImd60z6kVZCGjkc5t0yVtfSepQFLvW5tB+bQJwm/FM
 /ywBJfgqvIaco1nPKKcmHno6MSYWeun7Kw9ep1sHpEddPiTxaT1ng4tcgdZUKhvTQeO0
 qofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714656670; x=1715261470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJMlFcicgGua5z7kq0AwPVXWRSb+VKbkmd19FQKbKvE=;
 b=F0rEQUPUlWPFMKHa07xdT47hlFIvng5BIPRyV2AQqNQgRBfdA/CCIkbm8pvLhmggY+
 7Gp/mzgSL0kw8T3cZTbLP8KjpjZCqp0YqFuqj/2gX73AYWQ8vzf8vf7NYGU7xLQ03B+A
 2M1qYVDuYz0kohVlw63V5zNMQZpoLLgwcdv+66EWRFbqP8eNPz2/YV+MalQ+QlUy1BCT
 2PnpqokMZfot7IUahvGkiBKc6219mijLE9bPrxXmCfEaDEFWxlatG8M8KHqm2UeYKzLv
 WssdHqrgg6STrqt8qU6Swqy3dkJQlc+rUUHDAxxAlcpRubKXyj6oL1WBG+3T5t45whSU
 NgfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGufxHJqbWLrLnHYAaQ3nxVDAX8YPhuMKUkhhgGvimaYNif+JcJPaP20X5R5qrv8ppaC/+oqKFJhTS4A0Fl3oKZpDm2/s=
X-Gm-Message-State: AOJu0YwB2hWLC/+fpIXdXNUKK2927RxH/bugaIDDivEqC0X2VLEmsgf/
 5V0MqkZZFxH2rAeesRBYf65NB9mut2rw3qVu60dXWl9GcfpqYuvRahOL4VdztxcoKSmbdX6VjCP
 LFd1g2irLpBP3ITXV74m3p1pVd8JPbmutCxA7aw==
X-Google-Smtp-Source: AGHT+IF/18vqPe/5aKj+pYNzkjt0bW9LkElxt4izfRYMnUNqeihdR8x/H/65IzIjqNRFamipFXdB+lnUokiZL0gHWNE=
X-Received: by 2002:a50:c016:0:b0:56d:c295:dde3 with SMTP id
 r22-20020a50c016000000b0056dc295dde3mr1515152edb.35.1714656669768; Thu, 02
 May 2024 06:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
 <877cgfe2yw.fsf@pond.sub.org> <ZjClMb-6MddpvHqQ@redhat.com>
 <ZjJgQcPQ29HJsTpY@x1n> <ZjJm6rcqS5EhoKgK@redhat.com> <ZjJqwg1H2nZbcekb@x1n>
 <ac86d9a7-02c6-9a07-4135-8327d17aca6b@akamai.com>
In-Reply-To: <ac86d9a7-02c6-9a07-4135-8327d17aca6b@akamai.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 2 May 2024 15:30:58 +0200
Message-ID: <CAMGffEm-PXOBi-jR3CTe5dwT12EgOAh1h0KKaBH7=1BETCbvWg@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Yu Zhang <yu.zhang@ionos.com>, 
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62f;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Michael, Hi Peter,


On Thu, May 2, 2024 at 3:23=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.com> =
wrote:
>
> Yu Zhang / Jinpu,
>
> Any possibility (at your lesiure, and within the disclosure rules of
> your company, IONOS) if you could share any of your performance
> information to educate the group?
>
> NICs have indeed changed, but not everybody has 100ge mellanox cards at
> their disposal. Some people don't.
Our staging env is with 100 Gb/s IB environment.
We will have a new setup in the coming months with Ethernet (RoCE), we
will run some performance
comparison when we have the environment ready.

>
> - Michael

Thx!
Jinpu
>
> On 5/1/24 11:16, Peter Xu wrote:
> > On Wed, May 01, 2024 at 04:59:38PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> >> On Wed, May 01, 2024 at 11:31:13AM -0400, Peter Xu wrote:
> >>> What I worry more is whether this is really what we want to keep rdma=
 in
> >>> qemu, and that's also why I was trying to request for some serious
> >>> performance measurements comparing rdma v.s. nics.  And here when I s=
aid
> >>> "we" I mean both QEMU community and any company that will support kee=
ping
> >>> rdma around.
> >>>
> >>> The problem is if NICs now are fast enough to perform at least equall=
y
> >>> against rdma, and if it has a lower cost of overall maintenance, does=
 it
> >>> mean that rdma migration will only be used by whoever wants to keep t=
hem in
> >>> the products and existed already?  In that case we should simply ask =
new
> >>> users to stick with tcp, and rdma users should only drop but not incr=
ease.
> >>>
> >>> It seems also destined that most new migration features will not supp=
ort
> >>> rdma: see how much we drop old features in migration now (which rdma
> >>> _might_ still leverage, but maybe not), and how much we add mostly mu=
ltifd
> >>> relevant which will probably not apply to rdma at all.  So in general=
 what
> >>> I am worrying is a both-loss condition, if the company might be easie=
r to
> >>> either stick with an old qemu (depending on whether other new feature=
s are
> >>> requested to be used besides RDMA alone), or do periodic rebase with =
RDMA
> >>> downstream only.
> >> I don't know much about the originals of RDMA support in QEMU and why
> >> this particular design was taken. It is indeed a huge maint burden to
> >> have a completely different code flow for RDMA with 4000+ lines of
> >> custom protocol signalling which is barely understandable.
> >>
> >> I would note that /usr/include/rdma/rsocket.h provides a higher level
> >> API that is a 1-1 match of the normal kernel 'sockets' API. If we had
> >> leveraged that, then QIOChannelSocket class and the QAPI SocketAddress
> >> type could almost[1] trivially have supported RDMA. There would have
> >> been almost no RDMA code required in the migration subsystem, and all
> >> the modern features like compression, multifd, post-copy, etc would
> >> "just work".
> >>
> >> I guess the 'rsocket.h' shim may well limit some of the possible
> >> performance gains, but it might still have been a better tradeoff
> >> to have not quite so good peak performance, but with massively
> >> less maint burden.
> > My understanding so far is RDMA is sololy for performance but nothing e=
lse,
> > then it's a question on whether rdma existing users would like to do so=
 if
> > it will run slower.
> >
> > Jinpu mentioned on the explicit usages of ib verbs but I am just mostly
> > quotting that word as I don't really know such details:
> >
> > https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAMGffEm=
2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com/__;!!GjvTz_vk!W6=
-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOew9oW_k=
g$
> >
> > So not sure whether that applies here too, in that having qiochannel
> > wrapper may not allow direct access to those ib verbs.
> >
> > Thanks,
> >
> >> With regards,
> >> Daniel
> >>
> >> [1] "almost" trivially, because the poll() integration for rsockets
> >>      requires a bit more magic sauce since rsockets FDs are not
> >>      really FDs from the kernel's POV. Still, QIOCHannel likely can
> >>      abstract that probme.
> >> --
> >> |: https://urldefense.com/v3/__https://berrange.com__;!!GjvTz_vk!W6-HG=
WM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOfyTmFFUQ$ =
      -o-    https://urldefense.com/v3/__https://www.flickr.com/photos/dber=
range__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl=
-yNJslN7A5GfLOf8A5OC0Q$  :|
> >> |: https://urldefense.com/v3/__https://libvirt.org__;!!GjvTz_vk!W6-HGW=
M-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOf3gffAdg$  =
        -o-            https://urldefense.com/v3/__https://fstop138.berrang=
e.com__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl=
-yNJslN7A5GfLOfPMofYqw$  :|
> >> |: https://urldefense.com/v3/__https://entangle-photo.org__;!!GjvTz_vk=
!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl-yNJslN7A5GfLOeQ5j=
jAeQ$     -o-    https://urldefense.com/v3/__https://www.instagram.com/dber=
range__;!!GjvTz_vk!W6-HGWM-XkF_52am249DrLIDQeZctVOHg72LvOHGUcwxqQM5mY0GNYYl=
-yNJslN7A5GfLOfhaDF9WA$  :|
> >>

