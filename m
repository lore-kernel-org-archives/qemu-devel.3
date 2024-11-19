Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C898FD6C295
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 20:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUru-0005vv-Ki; Tue, 19 Nov 2024 15:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDUrn-0005tj-5b
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDUrl-0005Qy-4g
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732048227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eeo1DIR0LCoIqKL0l+bRhH0UuukrWsFroOlN091p/zM=;
 b=bdIBOuQENApdN/ij6cciTCvR5vgDWnRUu8xQHfoRJZBQ/oGxFhy5J52LbjqDIDd0IRlVhl
 v+vTzAUNuGoWJL4rtEP9jBoFDMWx+fExvKLbjwb50Nm4DHg6dATkJHYJOBRApYLgnKiBlv
 /f3hVAoqI5Csr3oFyKeCv5YcNGsZQg0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-mCa_BwYLNA2i2CGiL71_cw-1; Tue, 19 Nov 2024 15:30:22 -0500
X-MC-Unique: mCa_BwYLNA2i2CGiL71_cw-1
X-Mimecast-MFC-AGG-ID: mCa_BwYLNA2i2CGiL71_cw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so37088155e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 12:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732048221; x=1732653021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eeo1DIR0LCoIqKL0l+bRhH0UuukrWsFroOlN091p/zM=;
 b=xGhmIok2ChAYDp3Caa1JFESrUG8J4QNMLH8C2kUT+5eULu3aQOhObzob19YJDcvzpk
 wvHAoO72OdBwxHlaNZeBvBZZRBptEHBZB7eLcGhG67VkZUJFTkBBkxEr/ko07hqe5K5m
 HAsUU1yhhSyrcbGLUuYUWUjoYYj89CnhL4W34P8GUZxpjkK+LxsUqOOgct3wg01EAZhc
 S/fBVUw8ihGmw0mSoIZ8zSlZvWTy1xG8kbwjSv+T+dr+Gg5WE0RDy9XhMcfMCbctJc4X
 BykOL4HfHo3dWR2fSBAcFW1iHvUXnGrq2sExVKr3tfEcbBZY2NxRFg5KrWmLreA9kQi+
 3P4Q==
X-Gm-Message-State: AOJu0YzDdD/ZjkaekAqrAgkifzj/N+E5KxeiOBQwn5P+h4IoIWpSW6+/
 lPcemy6UEHh9Qm1ueeiWOn7eIBRM3wVPPKlImUN8cf4YcxhBrOLi6iox83V/34WhuraqDPr7+Ih
 /lXFJqmrE+20B8qypx/zQe8kp8qgIfIm0ZOgXYQBeK9dzJ7GO65auhINcqhJ70MCxOotyGzPFXu
 Sfnn2dsax6vMORiZI36hZlhA1iAtE=
X-Received: by 2002:a05:600c:c84:b0:431:5ed4:7e7d with SMTP id
 5b1f17b1804b1-433489d4d91mr2485025e9.18.1732048221200; 
 Tue, 19 Nov 2024 12:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw0G2P/FUjYMeGyOoAYAok0XZMUR3DVcwB7clkaw/Mfg08j3kMTXowGJ1i9vySTDLD63iWpHcN/0THFDKHYEQ=
X-Received: by 2002:a05:600c:c84:b0:431:5ed4:7e7d with SMTP id
 5b1f17b1804b1-433489d4d91mr2484785e9.18.1732048220857; Tue, 19 Nov 2024
 12:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com> <ZzvIZ4EL92hEk4wC@x1n>
 <CABgObfamYxtgX7SubOd8OvA5w70xQ5uesJ1TuPoTK9onVO+58w@mail.gmail.com>
 <Zzzv32xlLAH4O5Ig@x1n>
In-Reply-To: <Zzzv32xlLAH4O5Ig@x1n>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Nov 2024 21:30:09 +0100
Message-ID: <CABgObfaKrOvfhK5KfoxOOXOyZXeEz33VkvDeE=5wwtq3Ep=QdQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f039dd062749e661"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000f039dd062749e661
Content-Type: text/plain; charset="UTF-8"

Il mar 19 nov 2024, 21:07 Peter Xu <peterx@redhat.com> ha scritto:

> > Ah, that was supposed to be the difference between type_register() and
> > type_register_static().
>
> Ah... looks like they're the same now? As type_register_static() looks like
> a wrapper of type_register().
>

And pretty much have always been... Zhao looked into it recently.

> Perhaps type->name could be allocated with g_intern_string()? And then if
> > object_dynamic_cast() is changed into a macro, with something like
> >
> > #define qemu_cache_interned_string(s) \
> >   (__builtin_constant_p(s) \
> >    ? ({ static const char *interned; \
> >         interned = interned ?: g_intern_static_string(s); }) \
> >    : g_intern_string(s))
> >
> > as the third parameter. This allows object_dynamic_cast() to use a simple
> > pointer equality for type name comparison, and the same can be applied to
> > object_class_dynamic_cast().
>
> Interesting to know this facility!  Though, IIUC this may:
>
>   - For builtin-consts, it grows 8 bytes for each call sites on the binary
>     generated, even if (I think...) most of the sites are slow paths, and
>     there're plenty of such calls..
>

Right, but all the fast paths will be here. Only a few will be of course.

  - For non-builtin strings, g_intern_string() will add one more hash
>     operation for the whole string (and per discussed previously, looks
>     like the string can be not always short..).
>

Yes, but non-const strings should be *really* rare and not fast paths.

So I'm not 100% sure yet if this is what we want.
>
> Do we have known places that we care a lot on object[_class]_dynamic_cast()
> performance?


The easiest way to check is probably to print the type of every successful
object_dynamic_cast and object_class_dynamic_cast. I suspect the result
will be virtio-blk-device and/or scsi-hd, but maybe those already do an
unsafe cast (pointer type cast) instead of object_dynamic_cast.

I can give it some measurement if there is, otherwise I'm
> guessing whatever changes could fall into the noise.


Yes, probably. At most you can identify if there any heavy places out of
the 34000 calls, and see if they can use an unsafe cast.

Paolo

--000000000000f039dd062749e661
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 19 nov 2024, 21:07 Peter Xu &lt;<a href=3D"mail=
to:peterx@redhat.com">peterx@redhat.com</a>&gt; ha scritto:</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; Ah, that was supposed to be the difference between type_register() and=
<br>
&gt; type_register_static().<br>
<br>
Ah... looks like they&#39;re the same now? As type_register_static() looks =
like<br>
a wrapper of type_register().<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">And pretty much have always been... Zhao looke=
d into it recently.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Perhaps type-&gt;name could be allocated with g_intern_string()? And t=
hen if<br>
&gt; object_dynamic_cast() is changed into a macro, with something like<br>
&gt; <br>
&gt; #define qemu_cache_interned_string(s) \<br>
&gt;=C2=A0 =C2=A0(__builtin_constant_p(s) \<br>
&gt;=C2=A0 =C2=A0 ? ({ static const char *interned; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0interned =3D interned ?: g_intern_sta=
tic_string(s); }) \<br>
&gt;=C2=A0 =C2=A0 : g_intern_string(s))<br>
&gt; <br>
&gt; as the third parameter. This allows object_dynamic_cast() to use a sim=
ple<br>
&gt; pointer equality for type name comparison, and the same can be applied=
 to<br>
&gt; object_class_dynamic_cast().<br>
<br>
Interesting to know this facility!=C2=A0 Though, IIUC this may:<br>
<br>
=C2=A0 - For builtin-consts, it grows 8 bytes for each call sites on the bi=
nary<br>
=C2=A0 =C2=A0 generated, even if (I think...) most of the sites are slow pa=
ths, and<br>
=C2=A0 =C2=A0 there&#39;re plenty of such calls..<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Right, but all the fast pa=
ths will be here. Only a few will be of course.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
=C2=A0 - For non-builtin strings, g_intern_string() will add one more hash<=
br>
=C2=A0 =C2=A0 operation for the whole string (and per discussed previously,=
 looks<br>
=C2=A0 =C2=A0 like the string can be not always short..).<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, but non-const=
 strings should be *really* rare and not fast paths.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
So I&#39;m not 100% sure yet if this is what we want.<br>
<br>
Do we have known places that we care a lot on object[_class]_dynamic_cast()=
<br>
performance?</blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">The easiest way to check is probably to print the type of every s=
uccessful object_dynamic_cast and object_class_dynamic_cast. I suspect the =
result will be virtio-blk-device and/or scsi-hd, but maybe those already do=
 an unsafe cast (pointer type cast) instead of object_dynamic_cast.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">I can give it some measuremen=
t if there is, otherwise I&#39;m<br>
guessing whatever changes could fall into the noise.</blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, probably. At most you =
can identify if there any heavy places out of the 34000 calls, and see if t=
hey can use an unsafe cast.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div><div dir=3D"auto"><br></div></div>

--000000000000f039dd062749e661--


