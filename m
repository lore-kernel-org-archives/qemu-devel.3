Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD98DC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCiY-000666-BC; Fri, 28 Jun 2024 10:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNCiX-00065T-0V
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sNCiV-0003uP-D5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719585405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QM7eQrwLC79kjpAR0BXKRomvhlSBINXfF7dfvlkf+tA=;
 b=czQwO3wKH5O3sCrB3yXsC+8+ITYDRfY8XMjCiZ120tiVER3xTytdXLXyNgTvAZmjWpKOvQ
 Y7EoT9DizYw6Brh1FUtv9BG5YAqwTvJmeXxBaqQNyzFyxTbgj+13/b5aoFKzEw0sQKY19P
 eLKn1/LDfUdKdoris7BpQWFfodvG4HE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-sc5Lc1JuPVaGv6xuaimSPQ-1; Fri, 28 Jun 2024 10:36:42 -0400
X-MC-Unique: sc5Lc1JuPVaGv6xuaimSPQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-72268cc4453so553642a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719585402; x=1720190202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QM7eQrwLC79kjpAR0BXKRomvhlSBINXfF7dfvlkf+tA=;
 b=N1yzQGhbsbRwEFIDkWqq4m7F083OTs8d2ZLB/Szd2SNsFcaX2SzAtGjLxZ8f37b56l
 WonQhgsT22Ga9W3ttJoBodMRu3nF10N9Pm0ivr6NRjvnVjnnjpJNFNnZaiQ6Etb7gVkH
 euuz0mNWtll+4K/71HrxjuH8XtbKhWvfCMMQiR+eDJD+wooHbiEbiPoFMx+pFYxZIjoy
 SwHRe3F8IhaBToX5R74veA/Y1HArYIKoDhmjOU1/U3dwlOvLgL/Tsotv83TlcEmt6NgU
 jlvysbD9UV1KDQEyYr4rO4tScw/7ix7/abFW8XHCo0y5Z/94NWXrp/znpEK9IzFgw3q5
 W72g==
X-Gm-Message-State: AOJu0YyA/F2yXE2opOt1FwmsAOHszm0bVqGVSlWePN4K8sGCB+7gvoOD
 maX/2Ju0Sd4MWGdmdWKDIpkMzgj0+7P8xaYuQBYPUZKxi31N+VoNQD/9dIQpbdk2JUiKfxIJJsz
 T/3l3kRGgBWNsa+8hKtGq4bQ+ijaOLRDyezR2pqoQHxTB8KPpQ4y+CcLV7UfLKCbrFmFNt+YeBT
 XFIG0KKEpJ5YOMmFHF/Kx/0NEk3O8=
X-Received: by 2002:a05:6a20:6d83:b0:1bd:2d4e:53e1 with SMTP id
 adf61e73a8af0-1bd2d4e556amr7544635637.46.1719585401698; 
 Fri, 28 Jun 2024 07:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRhGlDtwizJdIFH5jGVPkJPW/PFNo1Sh4BqvsVFXDPYKiHimapkmcPPhbe03/gP0tPsbeGN8aYEMryb/WVrzg=
X-Received: by 2002:a05:6a20:6d83:b0:1bd:2d4e:53e1 with SMTP id
 adf61e73a8af0-1bd2d4e556amr7544590637.46.1719585401221; Fri, 28 Jun 2024
 07:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-5-jsnow@redhat.com>
 <874j9d1q61.fsf@pond.sub.org>
In-Reply-To: <874j9d1q61.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 28 Jun 2024 10:36:29 -0400
Message-ID: <CAFn=p-YKYXZk5TGDb016vMkPm7qLyHOeHGiFeddURzzVmbS2cA@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] docs/qapidoc: delint a tiny portion of the module
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mads Ynddal <mads@ynddal.dk>,
 Jiri Pirko <jiri@resnulli.us>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth <michael.roth@amd.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>, Ani Sinha <anisinha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000005685061bf42dae"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--000000000000005685061bf42dae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024, 3:29=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > In a forthcoming series that adds a new QMP documentation generator, it
> > will be helpful to have a linting baseline. However, there's no need to
> > shuffle around the deck chairs too much, because most of this code will
> > be removed once that new qapidoc generator (the "transmogrifier") is in
> > place.
> >
> > To ease my pain: just turn off the black auto-formatter for most, but
> > not all, of qapidoc.py. This will help ensure that *new* code follows a
> > coding standard without bothering too much with cleaning up the existin=
g
> > code.
> >
> > Code that I intend to keep is still subject to the delinting beam.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Not an objection, just so you know: I still see a few C0411 like 'third
> party import "import sphinx" should be placed before ...'
>
> R-by stands.
>

Yeah, I think it depends on precisely where you run the script. I think
because the folder is named "sphinx" that it confuses the tools in certain
contexts.

I'm not worried about it because we don't have an enforcement paradigm yet
- I stick to my little self-test script just to make sure I'm being
self-consistent, but I figured I'd worry about broader compatibility later
when I reshuffle the deck chairs for qapi.

--000000000000005685061bf42dae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 28, 2024, 3:29=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; In a forthcoming series that adds a new QMP documentation generator, i=
t<br>
&gt; will be helpful to have a linting baseline. However, there&#39;s no ne=
ed to<br>
&gt; shuffle around the deck chairs too much, because most of this code wil=
l<br>
&gt; be removed once that new qapidoc generator (the &quot;transmogrifier&q=
uot;) is in<br>
&gt; place.<br>
&gt;<br>
&gt; To ease my pain: just turn off the black auto-formatter for most, but<=
br>
&gt; not all, of qapidoc.py. This will help ensure that *new* code follows =
a<br>
&gt; coding standard without bothering too much with cleaning up the existi=
ng<br>
&gt; code.<br>
&gt;<br>
&gt; Code that I intend to keep is still subject to the delinting beam.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
Not an objection, just so you know: I still see a few C0411 like &#39;third=
<br>
party import &quot;import sphinx&quot; should be placed before ...&#39;<br>
<br>
R-by stands.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Yeah, I think it depends on precisely where you run the script.=
 I think because the folder is named &quot;sphinx&quot; that it confuses th=
e tools in certain contexts.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I&#39;m not worried about it because we don&#39;t have an enforcement =
paradigm yet - I stick to my little self-test script just to make sure I&#3=
9;m being self-consistent, but I figured I&#39;d worry about broader compat=
ibility later when I reshuffle the deck chairs for qapi.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000005685061bf42dae--


