Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC96C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMijl-0006iw-5k; Thu, 27 Jun 2024 02:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMijk-0006in-4h
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMiji-0005u4-8C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719470160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4nF1TVWbu52ahYOg1Qq+/d/HbjK4fBbAV/YvpuuoLdI=;
 b=ZkPmfPtooIKYTQvfCGiqy0jVQN2CloS+5YEKVTB5trNcKcoO42LkEaUfBOzkxcDVq5DsTu
 lnGCODz6SLkDJaV3y2FGLT/04u/qWqIFimHkfkcA6VQ27ThCGqxx16mcvYDuc5nrV5yNyc
 URYKuM01GCeSJLwsfzoDOml6F2CHneo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-M-buIQHmPEyZo1V04SSn6Q-1; Thu, 27 Jun 2024 02:35:57 -0400
X-MC-Unique: M-buIQHmPEyZo1V04SSn6Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-6fd42bf4316so6266852a12.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719470156; x=1720074956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nF1TVWbu52ahYOg1Qq+/d/HbjK4fBbAV/YvpuuoLdI=;
 b=ocSCF2nrY/T+LQh2NjrG7aCbyxBGhfOdwjR4pgW83bMsqXmqHYaOe4MljFvwwybskf
 zJE7+pEh8T1OeylheArLOi5K0hfp74iD9C+AB+2QTbFRwrdJOCfLj3MO5YmtLPblFts6
 5wG5IwU6opgqTJEApJN7XbN1K5ZH9GS6+83Zx2YVFNUXEaQCknwFh7fJ35gIjEnDFaA2
 ZFzYY6YQwzpcZjSPFx0xp0keq6nXLc8RhelkjUuJsEK9kbe4h0reoT/atnqyyD6UmZN5
 9TUw/1DSVcZgIGuFw5reyy0oRH8y+y54+c8QB+xF7ct2NTtW1jAicmH3cihY74Q1jcG7
 QOpg==
X-Gm-Message-State: AOJu0Yzc2FLffA3d96Hx5JiLPGq0srQo1kUC5BlJKCiaM23rzKqKnZ4p
 bAShUrNkqzJ82ewEuG7n6SlBXpSYkHlbiT4af3mqIh9Z6bNfAHiWleaYyL7GzfyXzxU67uynXQu
 rltlPcGBKBsMR63DPkaegxAQq3yzn/iHz/2je0FWU3Og8E9CcwQC8AjCEPiaIXXzRXswP/M74eM
 Z20VS/t7oP2rqjCDQYhofRb5Sz840=
X-Received: by 2002:a05:6a20:b91:b0:1be:c054:1ce1 with SMTP id
 adf61e73a8af0-1bec0541d49mr3033697637.55.1719470156514; 
 Wed, 26 Jun 2024 23:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG97cdnDHu3VM8O88wuHK5gAM+tCBSjJ5P2wl3O6zU3cjgv/xrr2I3LqDVVKB3EZ3E0r8nJQQxI3MG5u4bm8VU=
X-Received: by 2002:a05:6a20:b91:b0:1be:c054:1ce1 with SMTP id
 adf61e73a8af0-1bec0541d49mr3033671637.55.1719470156173; Wed, 26 Jun 2024
 23:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240626222128.406106-1-jsnow@redhat.com>
 <20240626222128.406106-6-jsnow@redhat.com>
 <87o77mj41s.fsf@pond.sub.org>
In-Reply-To: <87o77mj41s.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 27 Jun 2024 02:35:44 -0400
Message-ID: <CAFn=p-ZSj8f3fBEr1uN7a0uwaLWkhHNm0X=Oo=XNWC4BhdXe6g@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] qapi/parser: preserve indentation in QAPIDoc
 sections
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
Content-Type: multipart/alternative; boundary="000000000000dc6bf1061bd9572a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

--000000000000dc6bf1061bd9572a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024, 2:25=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Change get_doc_indented() to preserve indentation on all subsequent tex=
t
> > lines, and create a compatibility dedent() function for qapidoc.py that
> > removes indentation the same way get_doc_indented() did.
> >
> > This is being done for the benefit of a new qapidoc generator which
> > requires that indentation in argument and features sections are
> > preserved.
> >
> > Prior to this patch, a section like this:
> >
> > ```
> > @name: lorem ipsum
> >    dolor sit amet
> >      consectetur adipiscing elit
> > ```
> >
> > would have its body text be parsed into:
> >
> > ```
> > lorem ipsum
> > dolor sit amet
> >   consectetur adipiscing elit
> > ```
> >
> > We want to preserve the indentation for even the first body line so tha=
t
> > the entire block can be parsed directly as rST. This patch would now
> > parse that segment into:
> >
> > ```
> > lorem ipsum
> >    dolor sit amet
> >      consectetur adipiscing elit
> > ```
> >
> > This is helpful for formatting arguments and features as field lists in
> > rST, where the new generator will format this information as:
> >
> > ```
> > :arg type name: lorem ipsum
> >    dolor sit amet
> >      consectetur apidiscing elit
> > ```
> >
> > ...and can be formed by the simple concatenation of the field list
> > construct and the body text. The indents help preserve the continuation
> > of a block-level element, and further allow the use of additional rST
> > block-level constructs such as code blocks, lists, and other such
> > markup.
> >
> > This understandably breaks the existing qapidoc.py; so a new function i=
s
> > added there to dedent the text for compatibility. Once the new generato=
r
> > is merged, this function will not be needed any longer and can be
> > dropped.
>
> I'll restore this paragraph if you don't mind:
>
>   I verified this patch changes absolutely nothing by comparing the
>   md5sums of the QMP ref html pages both before and after the change, so
>   it's certified inert. QAPI test output has been updated to reflect the
>   new strategy of preserving indents for rST.
>

Nope, misunderstood the instruction. Go right ahead.


> > Signed-off-by: John Snow <jsnow@redhat.com>
> > [Edited commit message and code comments per review --js]
>
> And I'll drop this line.
>

Vestigial remnants of a more optimistic time.


> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000dc6bf1061bd9572a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 27, 2024, 2:25=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Change get_doc_indented() to preserve indentation on all subsequent te=
xt<br>
&gt; lines, and create a compatibility dedent() function for qapidoc.py tha=
t<br>
&gt; removes indentation the same way get_doc_indented() did.<br>
&gt;<br>
&gt; This is being done for the benefit of a new qapidoc generator which<br=
>
&gt; requires that indentation in argument and features sections are<br>
&gt; preserved.<br>
&gt;<br>
&gt; Prior to this patch, a section like this:<br>
&gt;<br>
&gt; ```<br>
&gt; @name: lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; would have its body text be parsed into:<br>
&gt;<br>
&gt; ```<br>
&gt; lorem ipsum<br>
&gt; dolor sit amet<br>
&gt;=C2=A0 =C2=A0consectetur adipiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; We want to preserve the indentation for even the first body line so th=
at<br>
&gt; the entire block can be parsed directly as rST. This patch would now<b=
r>
&gt; parse that segment into:<br>
&gt;<br>
&gt; ```<br>
&gt; lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur adipiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; This is helpful for formatting arguments and features as field lists i=
n<br>
&gt; rST, where the new generator will format this information as:<br>
&gt;<br>
&gt; ```<br>
&gt; :arg type name: lorem ipsum<br>
&gt;=C2=A0 =C2=A0 dolor sit amet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 consectetur apidiscing elit<br>
&gt; ```<br>
&gt;<br>
&gt; ...and can be formed by the simple concatenation of the field list<br>
&gt; construct and the body text. The indents help preserve the continuatio=
n<br>
&gt; of a block-level element, and further allow the use of additional rST<=
br>
&gt; block-level constructs such as code blocks, lists, and other such<br>
&gt; markup.<br>
&gt;<br>
&gt; This understandably breaks the existing qapidoc.py; so a new function =
is<br>
&gt; added there to dedent the text for compatibility. Once the new generat=
or<br>
&gt; is merged, this function will not be needed any longer and can be<br>
&gt; dropped.<br>
<br>
I&#39;ll restore this paragraph if you don&#39;t mind:<br>
<br>
=C2=A0 I verified this patch changes absolutely nothing by comparing the<br=
>
=C2=A0 md5sums of the QMP ref html pages both before and after the change, =
so<br>
=C2=A0 it&#39;s certified inert. QAPI test output has been updated to refle=
ct the<br>
=C2=A0 new strategy of preserving indents for rST.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Nope, misunderstood the i=
nstruction. Go right ahead.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; [Edited commit message and code comments per review --js]<br>
<br>
And I&#39;ll drop this line.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Vestigial remnants of a more optimistic time.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<br>
&gt; Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000dc6bf1061bd9572a--


