Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D42C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgf6-00054A-CD; Fri, 07 Mar 2025 17:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgf4-00051n-C1
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:59:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqgf2-0005nI-Da
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741388351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAUmYDykDVhZJ6B9pI3DDNXkNRhT2Ad2lSwaZ6QN6h0=;
 b=FqyA4sJM2WVgHp8QyD4mx5wSoVJ0yotyU8lnbMOMjthJCikQp55yC41O5vYyOyIu8tJZbz
 15Mpn/NJ+Wse+lhPP6MgCr4Zor6k+YYVE1HUNQ7VxDQ/YrPhDFZvTLWPHe4XyO/Uiru9fA
 QRWADhuY0DxtPLfyBDrx9fHoJJ93G3s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-UT5cjimJNea2gqm5l5tyGA-1; Fri, 07 Mar 2025 17:59:07 -0500
X-MC-Unique: UT5cjimJNea2gqm5l5tyGA-1
X-Mimecast-MFC-AGG-ID: UT5cjimJNea2gqm5l5tyGA_1741388346
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-224364f2492so7817305ad.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741388346; x=1741993146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PAUmYDykDVhZJ6B9pI3DDNXkNRhT2Ad2lSwaZ6QN6h0=;
 b=NVLn40wh6a8yStIpfUY2zwc9pb1PlUZMlLijjvEZ2s4zTsOCLQ8odNGtGBbAA0sAZV
 ggkrlkq8rQOV92IM+dcUBtP5Gaf3cAqrh8S9ZC8taGWEhRKzA+/D6d6ZTEZykutR1isR
 2jimIR9KAilyy0w4she6cMva6DS8fNsaXxj2D3AsvgCPcvLVflYiU6k7WLwA8CQd/3X6
 bTCQYTzZ9k9aO9i+kQF19vPpFEINsHzaDM0SjBxp98nBD8maQQ1byifRm/AFzBZP9SPl
 mDG93O1wJlBOtEFk/t9GQb69LRRErIAttN8IsQvBhke8fWOGC1saJZvBEFyO73lwBLGE
 Syog==
X-Gm-Message-State: AOJu0Yw5MT8ZZUaQ8IgFLiex0M4VGf9ocF8WAEeTtuIlQ0f5etpocJW3
 vDkA1V0CzI0mLGMoIKQZbkb0DN4jHxQLnnsd0XXtgE5nrnzhdLZoibawCkesmcx4lVur6fXqNXE
 Mi0WE551d1TnzZRX5B8H2womKIZB5Pea1soWUksOVN5axs3nAV8YKYoL5yHA45anLrwP9dPq/5h
 vuBrTT/nBXtQHdToZuXCmqxQcHxNI=
X-Gm-Gg: ASbGncs+ZrS8YByQzQpPofUh5jAxIoSgWMSjHdxaI0hC/kD/TawjAo3InmI50cSj279
 7Cwu4AuAk8rORHYpEwhxUdFXrgX3ohZRYqTkjohvrGeyhFPQ78npr6Xf3x2yysnj/L1Welg==
X-Received: by 2002:a17:902:ea02:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-22428c057f6mr75859935ad.39.1741388346475; 
 Fri, 07 Mar 2025 14:59:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3B/Wb5POINmqscV6FJfHtQLc1KpYKe7XgUPLbNegNGo8Lu0tJkVtk0u5YY74ix6X34V+Ov7ivpPYOz2hnvgk=
X-Received: by 2002:a17:902:ea02:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-22428c057f6mr75859745ad.39.1741388346206; Fri, 07 Mar 2025
 14:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-17-jsnow@redhat.com>
 <87tt85p90k.fsf@pond.sub.org>
In-Reply-To: <87tt85p90k.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 17:58:53 -0500
X-Gm-Features: AQ5f1JrMfu5WLWAb8OssZdxMGeb5CFHDdDS7mMdY41d2k09qln69fUCAf9R3uNo
Message-ID: <CAFn=p-ahdYmxDsPg7NmfwBK-vAHFEQ3jkB_vuAEi2Zj-naFWgQ@mail.gmail.com>
Subject: Re: [PATCH 16/57] docs/qapi-domain: add "Returns:" field lists
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cacfc9062fc8913e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000cacfc9062fc8913e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 2:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add "Returns:" field list syntax to QAPI Commands.
> >
> > Like "Arguments:" and "Errors:", the type name isn't currently processe=
d
> > for cross-referencing, but this will be addressed in a forthcoming
> > commit.
> >
> > This patch adds "errors" as a GroupedField, which means that multiple
>
> "errors"?
>

Copy-pasto :)


>
> > return values can be annotated - this is only done because Sphinx does
> > not seemingly (Maybe I missed it?) support mandatory type arguments to
> > Ungrouped fields. Because we want to cross-reference this type
> > information later, we want to make the type argument mandatory. As a
> > result, you can technically add multiple :return: fields, though I'm no=
t
> > aware of any circumstance in which you'd need or want
> > to. Recommendation: "Don't do that, then."
>
> scripts/qapi/parser.py rejects duplicate 'Returns:' tags.  So, to do the
> thing you shouldn't do, you'd have to use the QAPI domain directly.
> I doubt such shenanigans would survive review :)
>

Sure, but it's a little weird to be in the headspace of writing a domain
extension that was based on one which *can* be used directly. I know we
won't, but I suppose I am still documenting it and treating it as if you
could.

More the case, it serves as reference if anyone wants to adjust the
behavior of the transmogrifier.

So, consider this documentation for me in the future, or whoever touches
qapidoc if I am felled by an errant spacerock.


>
> > Since this field describes an action/event instead of describing a list
> > of nouns (arguments, features, errors), I added both the imperative and
> > indicative forms (:return: and :returns:) to allow doc writers to use
> > whichever mood "feels right" in the source document. The rendered outpu=
t
> > will always use the "Returns:" label, however.
> >
> > I'm sure you'll let me know how you feel about that. O:-)
>
> My personal taste is imperative mood, always.
>
> Sadly, the QAPI schema language uses 'Returns:'.
>
> The Sphinx Python Domain appears to use :return:.
>
> I recommend to go for consistency with the Python Domain, and ditch
> :returns:.
>

Done.


>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapi_domain.py | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> > index d60cccb8e95..7531bdfbba7 100644
> > --- a/docs/sphinx/qapi_domain.py
> > +++ b/docs/sphinx/qapi_domain.py
> > @@ -292,6 +292,13 @@ class QAPICommand(QAPIObject):
> >                  names=3D("error", "errors"),
> >                  has_arg=3DFalse,
> >              ),
> > +            # :returns TypeName: descr
> > +            GroupedField(
> > +                "returnvalue",
> > +                label=3D_("Returns"),
> > +                names=3D("return", "returns"),
> > +                can_collapse=3DTrue,
> > +            ),
> >          ]
> >      )
>
>

--000000000000cacfc9062fc8913e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 2:58=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add &quot;Returns:&quot; field list syntax to QAPI Commands.<br>
&gt;<br>
&gt; Like &quot;Arguments:&quot; and &quot;Errors:&quot;, the type name isn=
&#39;t currently processed<br>
&gt; for cross-referencing, but this will be addressed in a forthcoming<br>
&gt; commit.<br>
&gt;<br>
&gt; This patch adds &quot;errors&quot; as a GroupedField, which means that=
 multiple<br>
<br>
&quot;errors&quot;?<br></blockquote><div><br></div><div>Copy-pasto :)</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; return values can be annotated - this is only done because Sphinx does=
<br>
&gt; not seemingly (Maybe I missed it?) support mandatory type arguments to=
<br>
&gt; Ungrouped fields. Because we want to cross-reference this type<br>
&gt; information later, we want to make the type argument mandatory. As a<b=
r>
&gt; result, you can technically add multiple :return: fields, though I&#39=
;m not<br>
&gt; aware of any circumstance in which you&#39;d need or want<br>
&gt; to. Recommendation: &quot;Don&#39;t do that, then.&quot;<br>
<br>
scripts/qapi/parser.py rejects duplicate &#39;Returns:&#39; tags.=C2=A0 So,=
 to do the<br>
thing you shouldn&#39;t do, you&#39;d have to use the QAPI domain directly.=
<br>
I doubt such shenanigans would survive review :)<br></blockquote><div><br><=
/div><div>Sure, but it&#39;s a little weird to be in the headspace of writi=
ng a domain extension that was based on one which *can* be used directly. I=
 know we won&#39;t, but I suppose I am still documenting it and treating it=
 as if you could.</div><div><br></div><div>More the case, it serves as refe=
rence if anyone wants to adjust the behavior of the transmogrifier.</div><d=
iv><br></div><div>So, consider this documentation for me in the future, or =
whoever touches qapidoc if I am felled by an errant spacerock.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Since this field describes an action/event instead of describing a lis=
t<br>
&gt; of nouns (arguments, features, errors), I added both the imperative an=
d<br>
&gt; indicative forms (:return: and :returns:) to allow doc writers to use<=
br>
&gt; whichever mood &quot;feels right&quot; in the source document. The ren=
dered output<br>
&gt; will always use the &quot;Returns:&quot; label, however.<br>
&gt;<br>
&gt; I&#39;m sure you&#39;ll let me know how you feel about that. O:-)<br>
<br>
My personal taste is imperative mood, always.<br>
<br>
Sadly, the QAPI schema language uses &#39;Returns:&#39;.<br>
<br>
The Sphinx Python Domain appears to use :return:.<br>
<br>
I recommend to go for consistency with the Python Domain, and ditch<br>
:returns:.<br></blockquote><div><br></div><div>Done.</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapi_domain.py | 7 +++++++<br>
&gt;=C2=A0 1 file changed, 7 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py<b=
r>
&gt; index d60cccb8e95..7531bdfbba7 100644<br>
&gt; --- a/docs/sphinx/qapi_domain.py<br>
&gt; +++ b/docs/sphinx/qapi_domain.py<br>
&gt; @@ -292,6 +292,13 @@ class QAPICommand(QAPIObject):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names=3D=
(&quot;error&quot;, &quot;errors&quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_arg=
=3DFalse,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # :returns TypeName: descr<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GroupedField(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;returnv=
alue&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 label=3D_(&qu=
ot;Returns&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 names=3D(&quo=
t;return&quot;, &quot;returns&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 can_collapse=
=3DTrue,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
<br>
</blockquote></div></div>

--000000000000cacfc9062fc8913e--


