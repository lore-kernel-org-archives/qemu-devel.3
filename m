Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E54C531DA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 10:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMvq-0007v3-GS; Fri, 09 Aug 2024 06:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1scMvp-0007uZ-6e
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:33:13 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1scMvn-0000Ky-BX
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:33:12 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-67682149265so17500667b3.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723199589; x=1723804389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SaTmdmrsiy/0qGg9dy6659gMUCXSwzMlRF5F9PlimJ4=;
 b=V084oDKKJBb/y33YsDBJh88gHAj1MrH5jcRK8RGgkUzyfM4E+P0H1QoE6S5Edknfqy
 kqou2TyB2crOZdDjfO71WT69FHvbFZJfwe585tTB50WYo1bAs7I0htpaHs4AQQEI6jo/
 9CrSQINrI25J7jUu3dKWbNmthKuBTmi8EseIwktw8D14zNgX09tM5CRpi7oKbcYeflxd
 haZ/0G3zwOuBp+ONJpmDHMfXm+Y4gzpXAK6wfhDEBmKbRi52dj0JraWc+Kwf6jgNFSui
 XcVaokfRH5yvEcdbhVxp9yo3SyUozHiL8E4PXbnHb1pA0RHhDAZqw/pIeR+uxW8254nJ
 G+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723199589; x=1723804389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SaTmdmrsiy/0qGg9dy6659gMUCXSwzMlRF5F9PlimJ4=;
 b=gfqE1z3seroZfajeTt8/NGauggO+z2lukqOupNiVYDojmyY3zDqaxG7uRfLPFr8Qmu
 1E5L6ABg7vAD3wGqp2d+WQSQp5npsB+9TI8or7ubfEpnzeRviKZFe8AYgjPHOxudP5oX
 uwbjCsWSaPIDNXQvrIAIWGoD44iUr+g0aJHp9Qj19MUTkuUIgIGVOqKDPoc781v7jyoN
 R+lsoPO8I1afCzs0TN/pgjFzrCc9+1TlK1ZN76wMUZAGWaoULRCND1Ikt36fsAtj/3q/
 4tP38FExiAjm+9qw3AI+1R5T1+PlvjffnRbr8sCmtPe30iAdN8VtpnTiojN4JNdeOnth
 +33Q==
X-Gm-Message-State: AOJu0YzhwV6IHef7/eutp76ngHBcfXOaYLkImknRVne1cFnS/W9/ObLe
 G80SGaMakmiROhYE3b9EcBia/ZZBjAeXQU3rW84Jr99BdjbWtKzJzxS+le0A52duzKV56t0+OX9
 H8RK+5s7aRWGWJgXkH4+4DDQ0XW4=
X-Google-Smtp-Source: AGHT+IF+HKavGxdvHmmccy3CBeoC9Z/Q+OwrcFiR+b+7y3C10BhG+KPXMvILRz7LEqXO4X9/6DU2DWGHQMHCiyB2Nn0=
X-Received: by 2002:a05:690c:2706:b0:650:1ee7:7689 with SMTP id
 00721157ae682-69ec84d42e8mr11054377b3.35.1723199588828; Fri, 09 Aug 2024
 03:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240808030411.76990-1-yaozhenguo@jd.com>
 <ZrSGwy0H7nhIwMZz@redhat.com>
In-Reply-To: <ZrSGwy0H7nhIwMZz@redhat.com>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Fri, 9 Aug 2024 18:32:57 +0800
Message-ID: <CA+WzARkXrqPv9mP1afadfKgzf_ifgEfy1mHBV78KukjBOKhNxQ@mail.gmail.com>
Subject: Re: [PATCH] qio: fix qemu crash when live migration
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, yaozhenguo@jd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Daniel. Sorry,  I don't notice that this is a fixed issue by
b8a7f51f59e28d5a8e0c07ed3919cc9695560ed2(chardev/char-socket: set
s->listener =3D NULL in char_socket_finalize).
the following process can lead this issue=EF=BC=9A

char_socket_finalize->object_unref(OBJECT(s->listener)); // free
io_source, free s->listener. but s->listener is not clear.
char_socket_finalize->qemu_chr_be_event(chr, CHR_EVENT_CLOSED)->
qio_net_listener_set_client_func_full //
g_source_destroy(listener->io_source[i]); memory fault

Daniel P. Berrang=C3=A9 <berrange@redhat.com> =E4=BA=8E2024=E5=B9=B48=E6=9C=
=888=E6=97=A5=E5=91=A8=E5=9B=9B 16:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Aug 08, 2024 at 11:04:11AM +0800, yaozhenguo wrote:
> > qemu will crash in live migration cleanup process at source host.
> > BT is as below:
> >
> > 0  0x00007f740fc9e165 in g_source_destroy () at /usr/lib64/libglib-2.0.=
so.0
> > 1  0x000055a2982a0f6e in qio_net_listener_set_client_func_full
> > 2  0x000055a298345130 in tcp_chr_update_read_handler
> > 3  0x000055a298341598 in qemu_chr_fe_set_handlers_full
> > 4  0x000055a298341655 in qemu_chr_fe_set_handlers
> > 5  0x000055a298191e75 in vhost_user_blk_event
> > 6  0x000055a298292b79 in object_deinit
> > 7  object_finalize
> > 8  object_unref
> > 9  0x000055a298292b3c in object_property_del_all
> > 10 object_finalize
> > 11 object_unref
> > 12 0x000055a298291d7d in object_property_del_child
> > 13 object_unparent
> > 14 0x000055a29834a3c4 in qemu_chr_cleanup
> > 15 0x000055a298160d87 in qemu_cleanup
> > 16 0x000055a297e6bff1 in main
> >
> > Crash reason is that qio_net_listener_finalize is called before
> > qio_net_listener_set_client_func_full. so, listener->io_source
> > is used after free. fix this by adding more checks.
>
> If finalize() has been called, then not only has listener->io_source
> been freed, but 'listener' itself has also been freed, thus....
>
> >
> > Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
> > ---
> >  io/net-listener.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/io/net-listener.c b/io/net-listener.c
> > index 47405965a6..c02965f919 100644
> > --- a/io/net-listener.c
> > +++ b/io/net-listener.c
> > @@ -143,6 +143,11 @@ void qio_net_listener_set_client_func_full(QIONetL=
istener *listener,
> >  {
> >      size_t i;
> >
> > +
> > +    if (!listener->nsioc || !listener->io_source || !listener->name) {
> > +        return;
> > +    }
>
> ....this is still accessing freed memory for 'listener'.
>
>
> What is the call path of the stack triggering qio_net_listener_finalize ?
>
> Whatever callpath has done that needs to be setting SocketChardev->listen=
er
> field to NULL, because tcp_chr_update_read_handler will check for NULL
> before calling qio_net_listener_set_client_func_full.
>
> > +
> >      if (listener->io_notify) {
> >          listener->io_notify(listener->io_data);
> >      }
> > @@ -264,6 +269,10 @@ void qio_net_listener_disconnect(QIONetListener *l=
istener)
> >  {
> >      size_t i;
> >
> > +    if (!listener->nsioc || !listener->io_source || !listener->name) {
> > +        return;
> > +    }
> > +
> >      if (!listener->connected) {
> >          return;
> >      }
> > @@ -301,6 +310,10 @@ static void qio_net_listener_finalize(Object *obj)
> >      g_free(listener->io_source);
> >      g_free(listener->sioc);
> >      g_free(listener->name);
> > +
> > +    listener->io_source =3D NULL;
> > +    listener->sioc =3D NULL;
> > +    listener->name =3D NULL;
> >  }
> >
> >  static const TypeInfo qio_net_listener_info =3D {
> > --
> > 2.43.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

