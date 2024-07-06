Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5523C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQBXZ-0001H8-Tq; Sat, 06 Jul 2024 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sQBXY-0001GG-3d
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sQBXW-0000yN-Gz
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720295865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v96Iudzvk9RJQu+17GRa/ssSPPY6WUybAwdzdLwBYIk=;
 b=csxkZgEXASmbymvf1Rvv1nW2IFg2SDAMzsIHi84LL1xw1YHN55RjVZnF5R4w/WdJ4RRrhl
 F00Xebm9+sY2rxv3z7bEezH3s9/oI92nucDkB77QV9AdyeerdbvKE5sBzCJa1+3f9aejLG
 B+1VJZg+exfMR2E7Px7XXN71WMe4J5k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-693qQYivNmWCZvBOpdx51Q-1; Sat, 06 Jul 2024 15:57:41 -0400
X-MC-Unique: 693qQYivNmWCZvBOpdx51Q-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-6c8f99fef10so2302705a12.3
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720295861; x=1720900661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v96Iudzvk9RJQu+17GRa/ssSPPY6WUybAwdzdLwBYIk=;
 b=TychlcN0EVsuNJt/8PGf5HUGfYjIj6diOJbPWyaq5r5jmxz6VUEbu7mV95MdQZy0pM
 iDo/Xom2kplevSuU/S9OTLj3gi3dugQZxvJYBqkwf363x0egUN8Z2zNPRP3gb2tVUazu
 lzsEqLGEnX2mRZoEq4KtQR27JmpBOb1UwzjKa9HXXyi01uawpzxIxtGHfs6T2w81UJT3
 NB8yNnavdutJMU+NI6ELDX6zLa6da1RNl0Hcue0gtlPxIeTSvwYPfkvYMP6nq+46X+6v
 GHB+FerMkr4O/lVrkfKBui2AHVhhVO0oDOvh/r3QrShTCI2P3hY/wUq33faF+3iliIvW
 DhQQ==
X-Gm-Message-State: AOJu0Yy61enHFOzn9o/Z4NvYmDdHjbK8lLVOfxx3aiMuMMHzezjjnM95
 p8r5cklc78jaT5kuqnxUb8hDrMytrkKaIyyXg6cT5Oo5Qb9DWTO4+uNoAK0I1IbdHQaag9+vhSx
 BbTacuU5n57Peu8lILv1xk4h+hecgTSkRvI5a9H8LqSx2uQ2BOpigkA0GbB8q123uKgCBpWGcZ4
 qMpahHH4Mzi/06rfRP6j3poAaXMg4=
X-Received: by 2002:a05:6a20:da93:b0:1bd:2944:d295 with SMTP id
 adf61e73a8af0-1c0cc90b54bmr10030562637.44.1720295860770; 
 Sat, 06 Jul 2024 12:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmjxrJZmYuQ4l7YNuh7arU3Hvqqby4rq7tgt/PZll0L94VZS3KDfPEhUlppcnAnt0BpCz7Kebm45x4FOCu3nM=
X-Received: by 2002:a05:6a20:da93:b0:1bd:2944:d295 with SMTP id
 adf61e73a8af0-1c0cc90b54bmr10030544637.44.1720295860408; Sat, 06 Jul 2024
 12:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240703210144.339530-1-jsnow@redhat.com>
 <20240703210144.339530-2-jsnow@redhat.com>
 <87o77atw5q.fsf@pond.sub.org>
In-Reply-To: <87o77atw5q.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 6 Jul 2024 15:57:28 -0400
Message-ID: <CAFn=p-b56yt70OkhDHyJoRWfNSJ5_mwgsqKRqjN+Zzt4tfffiw@mail.gmail.com>
Subject: Re: [PATCH 1/8] docs/qapidoc: factor out do_parse()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
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
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: multipart/alternative; boundary="000000000000ab31d1061c999786"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--000000000000ab31d1061c999786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024, 10:47=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Factor out the compatibility parser helper into a base class, so it can
> > be shared by other directives.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> R-by stands.
>

Assuming true even if I rebase on top of the 3.x patches and do_parse()
becomes quite a bit more trivial?

--js

>

--000000000000ab31d1061c999786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sat, Jul 6, 2024, 10:47=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Factor out the compatibility parser helper into a base class, so it ca=
n<br>
&gt; be shared by other directives.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
R-by stands.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Assuming true even if I rebase on top of the 3.x patches and do=
_parse() becomes quite a bit more trivial?</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">--js</div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000ab31d1061c999786--


