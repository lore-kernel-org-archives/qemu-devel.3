Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2FBC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiNQ-0006xU-NF; Thu, 27 Jun 2024 02:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMiNO-0006og-N5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMiNJ-0005vn-EP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719468770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZF0Kxkq4kOjJXZNKxVdG/eZBiItAl7rg+GkQRtUCCmQ=;
 b=cDu0fAtCYfA3L+j1mh7fr/Kr9fF11QZN9syDOv+TKAEh6xhtj3Oeg8Nh0ZlE22ouj4LKqz
 rcMOpy44nQQZaRMjWQH8gxyq9iTyLUtHMl1tt3vI6fmtCguVOTds5g6AXZnTKEnhgFJ6p4
 OgDcXLG/ohnqYsuO2VR561CqTT+Ihno=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-BXkgh6FcNX6fQrvwHsShRA-1; Thu, 27 Jun 2024 02:12:47 -0400
X-MC-Unique: BXkgh6FcNX6fQrvwHsShRA-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-700cb858788so3299082a34.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468767; x=1720073567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZF0Kxkq4kOjJXZNKxVdG/eZBiItAl7rg+GkQRtUCCmQ=;
 b=rZpjeCvSiIrRl8sDj0N+DN/TtInYh3oBcnMqc/gegZ1bs+yKrgvG+ilkaZ0X0YkNT5
 zFbSjnZB9VomzevfOLoEolqjXbiNhK7oNvOvufqKW+sr7YqzuV5eLB4aoV1pEbhihWSx
 JqrSy0JbMNmOQ15Jmjtqe8NHCcINjPiacWtx4XcxesQfVMSc/MHgZMgHjDdsclaLxdt8
 nsS6o+y5sF2J9f6QLgaEQYFKwHtoUOSRUA+faXf+L6oiuw/d9rxhX+UpNF0P/tV7mwzn
 vNSuCIg+A/6WSAgEnWIoBiccV9Ow8Td2ZcJccgZAVZy4xCT/C4jp1QIr9w7TYrmJGhyO
 1bxQ==
X-Gm-Message-State: AOJu0YwbHSJkSzGbxh0yK3icAIv5up5/2AolrihTUzAAOF8LUAyCm+Ak
 awjQyLa/hZEpqzPBmB3ehxSJKehY9xxi8STuYV8yKHU/B0uJbp+b6YGbSU9ZEFFXaT/96cE+Pp1
 SDK+H1JsDaq8e+IlyeeRKXAYvTZwblb6rto7NxcPxCpzxbwwp795bvJo27yyj28deVoqShOyzDW
 h6cjHQHn38eJyVcR4R87SUqwtpQzw=
X-Received: by 2002:a05:6358:3396:b0:19f:15b2:2825 with SMTP id
 e5c5f4694b2df-1a2389dc97dmr1600532855d.13.1719468767095; 
 Wed, 26 Jun 2024 23:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO6kbjTML1JevRNYR4GxoAnjgpHojPr7SwZ7RVpq+xK8ZKdCmpTXHga5bdm98LFoX81Zp0vvaHH6TGmOmpoqE=
X-Received: by 2002:a05:6358:3396:b0:19f:15b2:2825 with SMTP id
 e5c5f4694b2df-1a2389dc97dmr1600530055d.13.1719468766781; Wed, 26 Jun 2024
 23:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-4-jsnow@redhat.com>
 <87sewyj53r.fsf@pond.sub.org>
In-Reply-To: <87sewyj53r.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 27 Jun 2024 02:12:34 -0400
Message-ID: <CAFn=p-ZyCiVkBL=Uzpu7NXaHTgNtkWsJ4Fohiwimb=M4E5LHfQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] docs/qapidoc: remove unused intersperse function
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
Content-Type: multipart/alternative; boundary="0000000000000c041d061bd90547"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

--0000000000000c041d061bd90547
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024, 2:02=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This function has been unused since fd62bff901b.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> I assume you won't mind me adding a bit of polish: "since commit
> fd62bff901b (sphinx/qapidoc: Drop code to generate doc for simple union
> tag)".
>

Please be my guest!

--js

(Looking at it, that's a very weird phrase, isn't it?)

>

--0000000000000c041d061bd90547
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 27, 2024, 2:02=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; This function has been unused since fd62bff901b.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
I assume you won&#39;t mind me adding a bit of polish: &quot;since commit<b=
r>
fd62bff901b (sphinx/qapidoc: Drop code to generate doc for simple union<br>
tag)&quot;.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Please be my guest!</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">--js</div><div dir=3D"auto"><br></div><div dir=3D"auto">(Looking at =
it, that&#39;s a very weird phrase, isn&#39;t it?)</div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000000c041d061bd90547--


