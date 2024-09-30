Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408FDCE8340
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGQA-0008NO-DD; Mon, 30 Sep 2024 09:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1svGQ8-0008M3-6E
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1svGQ6-0001ou-DD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 09:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727702793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKerWnxvqHjLDDcEYOLwacIylb17/ffCNyoe3X/eOGY=;
 b=Nh3vFaIOAuEuDY6dZiehPMZxQgyPhqMH0cUXhK2L61I01gPitBvxBpkDAq3W7Baa/u0ftx
 n92c6ZhCJ+oRQ7ukVCsPQvxKM5jSer/G260TOOEv8jCdQKVZQL+dU8LT5AN/DazcpvmKrZ
 cpUa502bf1NSSiz7n9sUxhb26ZydBfc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-cfuSHFprN0i4b7eN8kXxyA-1; Mon, 30 Sep 2024 09:26:30 -0400
X-MC-Unique: cfuSHFprN0i4b7eN8kXxyA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7a9cfe4442cso636316985a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 06:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727702789; x=1728307589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKerWnxvqHjLDDcEYOLwacIylb17/ffCNyoe3X/eOGY=;
 b=adygE3cRSdwgKSIqVyk4c7kZME0m9wnMjYzThnNCtv0wnC5+zjumXBiTHgk5iOTqdr
 ObyrZ1QE5S2RG5K99krfxx7wOzjjEpiGEyRp+0/wFBXNBt2bAHrioiUK6G30DHQOqnE4
 V15bMQI9TIAvdMviwM6jjGW9m2HRQnrD111+t1P8cLjby9w9TKYIqJRUfC+X2jIkPMvg
 92iNsmLf3OAqDWDST7st/YzcyZ0iGx3uKB3SSk7GR3iRDSeg8HzLbVcGAOnu4SOjxxu6
 lmL1V1UJR3UF/5WkqR2GRsIg5GrJUIb17SJKeojp8+044QYBv6NSSheTezn+7RUKDeEa
 3z/g==
X-Gm-Message-State: AOJu0Yy8fTNXuuA66ap2zAcf/zFsTJp/A8HKhvY1uMePDDy2hQnQfVRA
 p0LGxPzgypWQKYo8pHRFHph2HzfdFOASzlY7AfsQu9stWzSHzmTJ+cAiJiJChdhow0sYCXsf2oW
 1VDJ/zsMuGRuro9OTOEjo++n+ClmeaOU/afRTADOqWGEmVEeZtkfZ8711cGQXj3ERo5VGDI2bhr
 8hm0OGhywMkIqc95qmOJtRKbA0r5o=
X-Received: by 2002:a05:6214:451f:b0:6c7:c8b8:8d3c with SMTP id
 6a1803df08f44-6cb3b5efa73mr178583656d6.18.1727702789306; 
 Mon, 30 Sep 2024 06:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKpm5SE3V+ZRBLdXN3PsvSe161JeJmfNe2vdYuk3Og5T7xGHFa0m2TjkadA1X+QQwkWKm+hnYOVjHM0HERheY=
X-Received: by 2002:a05:6214:451f:b0:6c7:c8b8:8d3c with SMTP id
 6a1803df08f44-6cb3b5efa73mr178583106d6.18.1727702788835; Mon, 30 Sep 2024
 06:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-16-marcandre.lureau@redhat.com>
 <c1eff411-53f7-483c-83e1-ac09cb6b4c89@vivier.eu>
In-Reply-To: <c1eff411-53f7-483c-83e1-ac09cb6b4c89@vivier.eu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 30 Sep 2024 17:26:17 +0400
Message-ID: <CAMxuvawGGZ_Rzro5A3cTprtg3WYbCkRrzdSFvmfjNGqwoy8JVQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/22] linux-user/hppa: fix -Werror=maybe-uninitialized
 false-positive
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>, 
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Laurent

On Mon, Sep 30, 2024 at 4:19=E2=80=AFPM Laurent Vivier <laurent@vivier.eu> =
wrote:
>
> CC Helge Deller
>
> Le 30/09/2024 =C3=A0 10:14, marcandre.lureau@redhat.com a =C3=A9crit :
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ../linux-user/hppa/cpu_loop.c: In function =E2=80=98hppa_lws=E2=80=99:
> > ../linux-user/hppa/cpu_loop.c:106:17: error: =E2=80=98ret=E2=80=99 may =
be used uninitialized [-Werror=3Dmaybe-uninitialized]
> >    106 |     env->gr[28] =3D ret;
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   linux-user/hppa/cpu_loop.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
> > index bc093b8fe8..f4da95490e 100644
> > --- a/linux-user/hppa/cpu_loop.c
> > +++ b/linux-user/hppa/cpu_loop.c
> > @@ -43,7 +43,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
> >           old =3D tswap32(old);
> >           new =3D tswap32(new);
> >           ret =3D qatomic_cmpxchg((uint32_t *)g2h(cs, addr), old, new);
> > -        ret =3D tswap32(ret);
> > +        env->gr[28] =3D tswap32(ret);
> >           break;
> >
> >       case 2: /* elf32 atomic "new" cmpxchg */
> > @@ -64,19 +64,19 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
> >               old =3D *(uint8_t *)g2h(cs, old);
> >               new =3D *(uint8_t *)g2h(cs, new);
> >               ret =3D qatomic_cmpxchg((uint8_t *)g2h(cs, addr), old, ne=
w);
> > -            ret =3D ret !=3D old;
> > +            env->gr[28] =3D ret !=3D old;
> >               break;
> >           case 1:
> >               old =3D *(uint16_t *)g2h(cs, old);
> >               new =3D *(uint16_t *)g2h(cs, new);
> >               ret =3D qatomic_cmpxchg((uint16_t *)g2h(cs, addr), old, n=
ew);
> > -            ret =3D ret !=3D old;
> > +            env->gr[28] =3D ret !=3D old;
> >               break;
> >           case 2:
> >               old =3D *(uint32_t *)g2h(cs, old);
> >               new =3D *(uint32_t *)g2h(cs, new);
> >               ret =3D qatomic_cmpxchg((uint32_t *)g2h(cs, addr), old, n=
ew);
> > -            ret =3D ret !=3D old;
> > +            env->gr[28] =3D ret !=3D old;
> >               break;
> >           case 3:
> >               {
> > @@ -97,13 +97,13 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
> >                   }
> >                   end_exclusive();
> >   #endif
> > +                env->gr[28] =3D ret;
> >               }
> >               break;
> >           }
> >           break;
> >       }
> >
> > -    env->gr[28] =3D ret;
> >       return 0;
> >   }
> >
>
> Did you try to put a g_assert_not_reached() in a "default:" for "switch(s=
ize)"?
> This should help the compiler to know that "env->gr[28] =3D ret;" will no=
t be reached if ret is not set.

That works! I'll change the patch and include your r-b then?


