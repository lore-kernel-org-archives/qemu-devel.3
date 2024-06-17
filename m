Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574DFC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 17:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGbA-0000HC-GJ; Mon, 17 Jun 2024 13:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGb8-0000Gb-5Q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJGb6-0003Bd-IX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718647011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l7dyhWz8gr7NDR26pYNBX8y1J0a5QngWlo3nKPpVzMs=;
 b=jO+VUzeZ8QmvjJRPw2laknf8O9nl6GNRk4GMn1rZiR09NxTMnVcDCZXqDKTSLtqOjUAkNd
 vI1ZK7Vpe0bv3u9TdHkkgTbDHxrQ6mRg5EWVOFQPMUdd+COIj6Bj9bVGDAcaNXsMKF54/5
 L3m0voU7pqXgtT7x57BcVKuGALHakzE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-NP8EZV5JPq66Ub0DJfL2gQ-1; Mon, 17 Jun 2024 13:56:50 -0400
X-MC-Unique: NP8EZV5JPq66Ub0DJfL2gQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f733400d5fso54111585ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 10:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718647009; x=1719251809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l7dyhWz8gr7NDR26pYNBX8y1J0a5QngWlo3nKPpVzMs=;
 b=u3dfxCJ/iWzGvRhdi4pHEjMUF3IUhlDW+BiqAY/QgBZV+fFxL1VkqdrVe8xnKoPPVN
 a12BmcIUh3X0SlCLknKQf/THL5MrAsN2XsvdGuZ9uTkWtqzoraOAEdktPhrAEkfdF1gU
 jherGzfyRGc4RQfl0pIDwRs+Sgr4AeInC6mHtiJiPfxmP/EqeNX8YTIKk+UnG5JnWQrP
 tdEPaC0Hy/CRXaCl7UvcV+zw7xByuz8hYeBoagRTqE5CYHl7fteNWgH9o2jHfDGKPDtn
 cz1IRLB8OcZ6JfoI2hNcOtFYKhiFFlFToO2VDQdBgcuhf1O5zCzu6RyO9NbsUWVn1A0n
 kGSA==
X-Gm-Message-State: AOJu0YxGkkea7lPMlNiVC/XGM8C9zaf6eg/Po6wScZ8EK9p80hhDCk2p
 VPGSnKWDSB8MPzC/GSO88ZuOsHJ6/1MQ/zlkago0A5Fi+ClsKiNmI/cuuAKfZp5pvxYQrEtCmJP
 sXz4Aj2sdxfu/RihWmzbMmWHGejiZvEvubprPoUG5KCwA+YJ2sSCryxcyY3h4o5SfXlKYJ4bLtN
 NyXGYBpqFJkeYGrG/GjmEoHUHSRdQ=
X-Received: by 2002:a17:902:da8c:b0:1f8:7584:b25c with SMTP id
 d9443c01a7336-1f87584b4b8mr89579125ad.54.1718647008584; 
 Mon, 17 Jun 2024 10:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuwR1pKCymyKeSHEGXGouSWgX7M1ZkD8oeCzbdqCostumac8U5hZd7BuKFv7tVpIqAFrSUXXH7gKA91kEm/fc=
X-Received: by 2002:a17:902:da8c:b0:1f8:7584:b25c with SMTP id
 d9443c01a7336-1f87584b4b8mr89578785ad.54.1718647008199; Mon, 17 Jun 2024
 10:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-19-jsnow@redhat.com>
 <87a5jn3gyd.fsf@pond.sub.org>
In-Reply-To: <87a5jn3gyd.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 13:56:36 -0400
Message-ID: <CAFn=p-Y2BgKLx5gN2++DQ_dj_hQzfYLw=MGKwNEHB6vFWeh7GQ@mail.gmail.com>
Subject: Re: [PATCH 18/20] qapi: ensure all errors sections are uniformly
 typset
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006b1937061b19b02a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000006b1937061b19b02a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024, 7:24=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Transactions have the only instance of an Errors section that isn't a
> > rST list; turn it into one.
>
> Just for consistency?  Or do you have other shenanigans up your sleeve?
>

Just consistency at this precise moment in time, but it's *possible* I may
introduce shenanigans for visual consistency in the rendered output, for
which having a uniform format would make mechanical conversions in the
generator easier/possible.

It's an idea I had but didn't implement yet. I figured I'd write this patch
anyway because it isn't wrong, and you yourself seemed to believe it would
*always* be a RST list, when that isn't strictly true.


> If we want the Errors sections to remain all rST lists, we should update
> docs/devel/qapi-code-gen.rst to say so.
>

OK, will do.


> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--0000000000006b1937061b19b02a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Jun 14, 2024, 7:24=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Transactions have the only instance of an Errors section that isn&#39;=
t a<br>
&gt; rST list; turn it into one.<br>
<br>
Just for consistency?=C2=A0 Or do you have other shenanigans up your sleeve=
?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Just consistency at this precise moment in time, but it&#39;s *possible* I=
 may introduce shenanigans for visual consistency in the rendered output, f=
or which having a uniform format would make mechanical conversions in the g=
enerator easier/possible.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">It&#39;s an idea I had but didn&#39;t implement yet. I figured I&#39;d wr=
ite this patch anyway because it isn&#39;t wrong, and you yourself seemed t=
o believe it would *always* be a RST list, when that isn&#39;t strictly tru=
e.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
If we want the Errors sections to remain all rST lists, we should update<br=
>
docs/devel/qapi-code-gen.rst to say so.<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">OK, will do.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000006b1937061b19b02a--


