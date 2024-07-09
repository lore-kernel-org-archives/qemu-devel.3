Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D6EC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 22:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRJkt-0003be-C3; Tue, 09 Jul 2024 18:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRJks-0003ZX-4T
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 18:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sRJkq-0008Lx-6m
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 18:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720565770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6tETFTZtC8FaYCt4b3uDBQoiM8n1nvwG7SruYtFzEw=;
 b=Iz4PeC4noAQYNIlOx0QHDEgvLD2o6qoPh86lzUVcM+48dPeF2OE25//D5kDxlOsuS0CP3E
 usPRixTCC2TELcC1LkbYTH7rV7MflU6XoOQfeimf6WEF0EvQwSDw2m5YZsHfbmgBtogwWB
 d/l1PecULyROCqsJ3UXY7+OLPE1GWUo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-P5kryOS1OM6fz0tTUP5o4A-1; Tue, 09 Jul 2024 18:56:08 -0400
X-MC-Unique: P5kryOS1OM6fz0tTUP5o4A-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c7430b3c4bso5201059a91.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 15:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720565768; x=1721170568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/6tETFTZtC8FaYCt4b3uDBQoiM8n1nvwG7SruYtFzEw=;
 b=fK62M32wUlX93gA/DFKYeRXpcWplfFuADy/pSOZJTog1M6pl63ifHRhy/mC7/6rgtM
 BQwxQRuHOB29SuZQYMTvstOBLcMb7IFRj30EfaNkOca6jp9TQCMP0MNsFaXjryNEXA6N
 85bum5xIrSq367hiq7bVr1owgMn9Ul8rRhqa0icGP6UUv4/JCMfyml2vcHC6lFIE3Brh
 FvNGpA6rCM4IiaOfoziuMRhi0xIbb+pXQ7plQNlv+Z4Ilt6IyIDfFj2er/g+o8k5YA3E
 vwX9sUk2xTBWQosSn59MbC91vhYPfIVzkHhi8EoxpJe4uN1bVCaDLnfjxopH4vN6vSne
 tSrA==
X-Gm-Message-State: AOJu0YzNgvjqbe7UMf2wOz69Sj1y/okJ3ZgidH4cKPyaXMlUkAqmIIBk
 pNHoPdltePhxEC9zJdZtP2dxTU1NlyoURiEvea9Ey/eemo6FZELjjEVqWr0vCEX7+LZ3SYEphPA
 CKhqkrNwxuHk2UtD/Dtj6VsXdsb1YZ/vCnDmb2mZu/seB6EeDl8103oPG8po7l1R7jDvSYXfJoi
 bjBb+DGaOYeCWzJstIn0zoOKL8jjM=
X-Received: by 2002:a17:90a:9a81:b0:2c9:69d2:67a8 with SMTP id
 98e67ed59e1d1-2ca35bde653mr3551636a91.9.1720565767511; 
 Tue, 09 Jul 2024 15:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE59peogspFv/uNAiVO+qVrXuI3M1TEm84Tjp7zIlUQlt6ZX305IqsRcY6DEXjDbPKjhlMjy5lKZEJGAQKdg3c=
X-Received: by 2002:a17:90a:9a81:b0:2c9:69d2:67a8 with SMTP id
 98e67ed59e1d1-2ca35bde653mr3551612a91.9.1720565767113; Tue, 09 Jul 2024
 15:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-5-jsnow@redhat.com>
 <874j8yj1m7.fsf@pond.sub.org>
In-Reply-To: <874j8yj1m7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 9 Jul 2024 18:55:55 -0400
Message-ID: <CAFn=p-bryJu2jNmg4t=j+n7NeN7D+3b27kJAS7LZnT0UEE2kQg@mail.gmail.com>
Subject: Re: [PATCH 4/8] docs/sphinx: add CSS styling for qmp-example directive
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, 
 Alex Williamson <alex.williamson@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Jiri Pirko <jiri@resnulli.us>, Harmonie Snow <harmonie@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000005ca883061cd86fa9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000005ca883061cd86fa9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:34=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > From: Harmonie Snow <harmonie@gmail.com>
> >
> > Add CSS styling for qmp-example directives to increase readability and
> > consistently style all example blocks.
> >
> > Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Same sadness as for the previous patch.
>

Should we do anything about that? In the long run, I don't expect anyone
will actually need to care about what this directive looked like in some
intermediate state before we ever used it. If you want to evaluate the
directive in the in-between states, I recommend modifying a document and
seeing what it does; but I didn't really intend for anyone to really see it
that way.

(Isn't it a bit overboard to write unit tests for intermediate tree
states...?)


>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>
>

--0000000000005ca883061cd86fa9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 9, 2024 at 6:34=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsno=
w@redhat.com</a>&gt; writes:<br>
<br>
&gt; From: Harmonie Snow &lt;<a href=3D"mailto:harmonie@gmail.com" target=
=3D"_blank">harmonie@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Add CSS styling for qmp-example directives to increase readability and=
<br>
&gt; consistently style all example blocks.<br>
&gt;<br>
&gt; Signed-off-by: Harmonie Snow &lt;<a href=3D"mailto:harmonie@gmail.com"=
 target=3D"_blank">harmonie@gmail.com</a>&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Same sadness as for the previous patch.<br></blockquote></div><div class=3D=
"gmail_quote"><br></div><div class=3D"gmail_quote">Should we do anything ab=
out that? In the long run, I don&#39;t expect anyone will actually need to =
care about what this directive looked like in some intermediate state befor=
e we ever used it. If you want to evaluate the directive in the in-between =
states, I recommend modifying a document and seeing what it does; but I did=
n&#39;t really intend for anyone to really see it that way.</div><div class=
=3D"gmail_quote"><br></div><div class=3D"gmail_quote">(Isn&#39;t it a bit o=
verboard to write unit tests for intermediate tree states...?)<br></div><di=
v class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--0000000000005ca883061cd86fa9--


