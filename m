Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB4AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkvi-0008O9-Pc; Tue, 16 Jul 2024 12:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkvc-0008Fn-Px
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTkvb-0005De-4J
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721146881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T1yDFe3hj0YJjOJzhlb1uQHoSl+rlkpb9cDmjsCmvBE=;
 b=PvXXhOCyac2MOaiWvbuAwcj3Gt4NFHV0HxLN1VMMr+Shp3cysHgtxmIVHwe4A1K24G14Rc
 9JGnJDETSUdbRAEDYomcNBde/R9su+5FrDAoXSKLXE6fqPCBebgIkx7T3loqJ4gJkqWpEo
 U6leLIZrd8iIMNcgqdm89Vpz3H3YwqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-jt2zfYYYM0ejr01XaXVL9w-1; Tue, 16 Jul 2024 12:21:17 -0400
X-MC-Unique: jt2zfYYYM0ejr01XaXVL9w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3678fd1edf8so3266320f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721146876; x=1721751676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T1yDFe3hj0YJjOJzhlb1uQHoSl+rlkpb9cDmjsCmvBE=;
 b=Bebu+QSuTBnPNboSvm24+QePFoH0TZQ1ofKJiC+CqNgdZpInniFp0YLbfEmINsPJFE
 7ERealnzzqxQ+C+tkcVukgS1TkbT2GY1hykWvyrhbXjxgYvsoUKm360zjKafzVh/gJQ6
 Dm210uTKI2+ZxyzFwxpaOodfuAu44le8QXFws1sD+2tzeTnuOSvA2UZGxSbTYVmWaUmV
 e2mEKVtTIba5CkqkByF1hppKIamssOUPo7eyWMf6Oe2XyTi8Y8amtt6n7y1KMLg5grZV
 m1xUcYsafdMhKTwz+S/aB4sqH9OWGcxLN7/L4r0Uzu0VwNvdjEVM9zavdz8m7EhnZtVV
 HaJg==
X-Gm-Message-State: AOJu0YzkflNrbhl6ByCWzWMpp9Q0wj6udeGKfNKvZ2IA4usDQKyyfjq4
 oYuTGRUDylBmlXriINoywqgfSsXMaRpteFG7ciELIId4pqrFbR/kf+j8DEf1MpMLSBfdQyouaMf
 jDb2fzZpm4pUZ9NzMQJE8rreV14am2WsZtY7JYSh1R8XlkVgYMwURB7BknrY6GvEH3t+h0Zd/PI
 4buwlDLS2HPcMUEPaE/GR+YVjpPWc=
X-Received: by 2002:a5d:5f4d:0:b0:366:e09c:56be with SMTP id
 ffacd0b85a97d-368273500b0mr2126985f8f.6.1721146876528; 
 Tue, 16 Jul 2024 09:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0/W+A4C4hfhYaYM2Kezg8mMBJKu19/7+SxP+TCVcozB/lMow8Mg4dCuQYveC/V55R7ASoXNEawWC2Br81rQQ=
X-Received: by 2002:a5d:5f4d:0:b0:366:e09c:56be with SMTP id
 ffacd0b85a97d-368273500b0mr2126953f8f.6.1721146876110; Tue, 16 Jul 2024
 09:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240711112228.2140606-1-armbru@redhat.com>
 <20240711112228.2140606-6-armbru@redhat.com>
In-Reply-To: <20240711112228.2140606-6-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 Jul 2024 12:21:00 -0400
Message-ID: <CAFn=p-bKnQEegGaxe_zOMwsEBkPsn=T77OP=SUsWsrvMWQXQCw@mail.gmail.com>
Subject: Re: [PATCH 5/5] qapi/ui: Drop note on naming of SpiceQueryMouseMode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000028470a061d5fbc5f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--00000000000028470a061d5fbc5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Doc comments are reference documentation for users of QMP.
> SpiceQueryMouseMode's doc comment contains a note explaining why it's
> not named SpiceMouseMode: spice/enums.h has it already.  Irrelevant
> for users of QMP; delete the note.
>

Hmmm, yeah, alright. I feel like this one's sorta borderline but I don't
feel strongly enough about it to argue to keep it :)


> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: John Snow <jsnow@redhat.com>

---
>  qapi/ui.json | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 5bcccbfc93..df089869a5 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -273,8 +273,6 @@
>  # @unknown: No information is available about mouse mode used by the
>  #     spice server.
>  #
> -# .. note:: spice/enums.h has a SpiceMouseMode already, hence the name.
> -#
>  # Since: 1.1
>  ##
>  { 'enum': 'SpiceQueryMouseMode',
> --
> 2.45.0
>
>

--00000000000028470a061d5fbc5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 11, 2024, 7:22=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Doc comments are reference documen=
tation for users of QMP.<br>
SpiceQueryMouseMode&#39;s doc comment contains a note explaining why it&#39=
;s<br>
not named SpiceMouseMode: spice/enums.h has it already.=C2=A0 Irrelevant<br=
>
for users of QMP; delete the note.<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Hmmm, yeah, alright. I feel like this one=
&#39;s sorta borderline but I don&#39;t feel strongly enough about it to ar=
gue to keep it :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-by: J=
ohn Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt;</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0qapi/ui.json | 2 --<br>
=C2=A01 file changed, 2 deletions(-)<br>
<br>
diff --git a/qapi/ui.json b/qapi/ui.json<br>
index 5bcccbfc93..df089869a5 100644<br>
--- a/qapi/ui.json<br>
+++ b/qapi/ui.json<br>
@@ -273,8 +273,6 @@<br>
=C2=A0# @unknown: No information is available about mouse mode used by the<=
br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0spice server.<br>
=C2=A0#<br>
-# .. note:: spice/enums.h has a SpiceMouseMode already, hence the name.<br=
>
-#<br>
=C2=A0# Since: 1.1<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39;: &#39;SpiceQueryMouseMode&#39;,<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div></div>

--00000000000028470a061d5fbc5f--


