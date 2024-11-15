Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E67D68BD9
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC484-0005Q4-Sa; Fri, 15 Nov 2024 16:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tC482-0005Nz-Oj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 16:45:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tC481-00027U-1q
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 16:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731707118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pqdeOc/wVROCK5wO3ebyjrlUgVgaL/ZrTcY/U/uAvX8=;
 b=UTtl6zbD/5WjXBSkgPf9vZYIO2p7I7n5Jg3iKuz4cEJN5p92Opy6dEE9PifF27oSOPOyve
 DWCCr63m3OFPa4vwES+gHoAtlp1II5/d2nxH0Szyak/D0dDuYdhq9RfGDweckfskASrY9w
 aHRWjkUWqNtt50+viOBXjDfNYcl4MxU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-YLjww7vuNRaLypeFLpVaxA-1; Fri, 15 Nov 2024 16:45:16 -0500
X-MC-Unique: YLjww7vuNRaLypeFLpVaxA-1
X-Mimecast-MFC-AGG-ID: YLjww7vuNRaLypeFLpVaxA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d589138a9so1223201f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 13:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731707115; x=1732311915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pqdeOc/wVROCK5wO3ebyjrlUgVgaL/ZrTcY/U/uAvX8=;
 b=BeWSKx4f/nUJQR/0LDencbzk+GqdKrm/x+oAMdTTOy54SL+gHSAnAQthIdPFag9347
 B/kpx1ujCJQArvVOA7ja6mz7lj06AHA37LcjDhodPyqVQhKsur3ZLpZCQgu7unreG3Dc
 P827I52BGLmYZbQ9aBJTK5J5SeylX0n+hxJ3vokxFNSaowA8TFejujq74Ud7q73iDNOj
 9DWCgeREy+t5qK4PDOyrx9eIKYOGYf0gzby/67m9D1VLUOj8IwrboW63SfAcronAuy9e
 ShuvDvaRoed/mGjyhsY7433OB8mQOUawXGX6BFua11d/PezSfkMJaGLpZYNXX79TwZaz
 a5WA==
X-Gm-Message-State: AOJu0Yx/9z8wRPSo4OO3BASc1ggwpsUHmXLXqHNmWstMgPSXG1ecTMcg
 Vo1SvxXqZGLTXnOA88MiN1wQBwgpil0g+xgm0/xK2wjqmD+NktQBKqRuzRCLLhC3KLRWyx353Ke
 w3Yu8RKOUGiDoOwVbXdotLYQEeBqD4Q1Olzlzn8kpKVw3tcWMZ3EsCqwhFD/T6QT/K5Vo3poml6
 7Ib/CCODMJTeXKmFnIzguiam3XNpc=
X-Received: by 2002:a5d:64ce:0:b0:382:31db:d61 with SMTP id
 ffacd0b85a97d-38231db0d84mr1093054f8f.38.1731707115024; 
 Fri, 15 Nov 2024 13:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4cMQTEVdx/+KX2bMAxK0G25P5l+9UY2JcDfZd4dhtt4Db2ltmjG03dyt9UXhvwFVSzZ+6tgvaM0YkEDWsxvI=
X-Received: by 2002:a5d:64ce:0:b0:382:31db:d61 with SMTP id
 ffacd0b85a97d-38231db0d84mr1093045f8f.38.1731707114700; Fri, 15 Nov 2024
 13:45:14 -0800 (PST)
MIME-Version: 1.0
References: <86871f60-983e-4172-a6e6-1bd4b1e4e5c0@landley.net>
 <8f168636-3468-4dc7-9de2-a5958df97c2d@redhat.com>
 <a3778af5-5f69-4a6c-b24a-a72b35b88a01@landley.net>
In-Reply-To: <a3778af5-5f69-4a6c-b24a-a72b35b88a01@landley.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Nov 2024 22:45:00 +0100
Message-ID: <CABgObfY1kkQqC5M7ytDGL3rYGdqQuaW7Luig1iFL0JAmmD213A@mail.gmail.com>
Subject: Re: "make clean" after "git pull" runs configure before cleaning.
To: Rob Landley <rob@landley.net>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006d5dcc0626fa7bd6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000006d5dcc0626fa7bd6
Content-Type: text/plain; charset="UTF-8"

Il ven 15 nov 2024, 22:15 Rob Landley <rob@landley.net> ha scritto:

> On 11/14/24 17:33, Paolo Bonzini wrote:
> > On 11/15/24 00:10, Rob Landley wrote:
> >> Seems a _bit_ awkward to do that (and potentially fail on a random new
> >> dependency) just to delete it all again?
> >
> > That's just how Make works.
>
> Linux and busybox and so on use make, and I've never seen "make clean"
> trigger a "make defconfig" there.
>

Yeah, they don't have a separate (and lengthy) configure phase. But they
might invoke some rules in a more hidden way if something changes in
scripts/. I don't know, Kbuild is black magic.

(Or do you mean "Make" is different from "gmake" the way "kbuild" is
> different from "make" and you distinguish your build system from the
> make command by capitalizing it?


No, I meant "any implementation of the POSIX utility".

> If it finds that Makefile is old, it first
> > regenerates Makefile and only then looks at the target.
>
> I'm pretty sure the make command doesn't internally know how to run the
> configure script, the Makefile would have to include plumbing to make
> that decision


It does, the chain is config-host.mak <- configure. The special processing
of Makefiles extends to all includes ("all Makefiles" in the GNU manual).

and it at least LOOKS like it's trying not to in the top level Makefile
> line 336:
>
>    # Don't try to regenerate Makefile or configure
>    # We don't generate any of them
>    Makefile: ;
>    configure: ;
>

Makefile and configure are not generated but other included files are. Most
likely the one you're hitting is config-host.mak..

I note that if you run "make clean" twice in a row, it doesn't re-run
> configure in between. It's only when a stale target exists, which seems
> to involve dependencies making a decision.


... and the second time, it is not stale anymore.

(The file NOT existing doesn't trigger action, but the file being "old"
> does.)
>

config-host.mak is only cleaned by distclean, not clean.

So it's an artifact of the way you're using make, and hard to fix then?
>

Maybe not too hard, I suppose one could strip the includes if make goals
are only of the form %clean.

Paolo

*shrug* I'd use 'git clean -fdx' instead but I'm not sure how that
> interacts with multiple submodules.
>

--0000000000006d5dcc0626fa7bd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 15 nov 2024, 22:15 Rob Landley &lt;<a href=3D"m=
ailto:rob@landley.net">rob@landley.net</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On 11/14/24 17:33, Paolo Bonzini=
 wrote:<br>
&gt; On 11/15/24 00:10, Rob Landley wrote:<br>
&gt;&gt; Seems a _bit_ awkward to do that (and potentially fail on a random=
 new <br>
&gt;&gt; dependency) just to delete it all again?<br>
&gt; <br>
&gt; That&#39;s just how Make works.<br>
<br>
Linux and busybox and so on use make, and I&#39;ve never seen &quot;make cl=
ean&quot; <br>
trigger a &quot;make defconfig&quot; there.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Yeah, they don&#39;t have a sepa=
rate (and lengthy) configure phase. But they might invoke some rules in a m=
ore hidden way if something changes in scripts/. I don&#39;t know, Kbuild i=
s black magic.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">(Or do =
you mean &quot;Make&quot; is different from &quot;gmake&quot; the way &quot=
;kbuild&quot; is <br>
different from &quot;make&quot; and you distinguish your build system from =
the <br>
make command by capitalizing it?</blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">No, I meant &quot;any implementation of the POS=
IX utility&quot;.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt;=
 If it finds that Makefile is old, it first <br>
&gt; regenerates Makefile and only then looks at the target.<br>
<br>
I&#39;m pretty sure the make command doesn&#39;t internally know how to run=
 the <br>
configure script, the Makefile would have to include plumbing to make <br>
that decision</blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">It does, the chain is config-host.mak &lt;- configure. The specia=
l processing of Makefiles extends to all includes (&quot;all Makefiles&quot=
; in the GNU manual).</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
and it at least LOOKS like it&#39;s trying not to in the top level Makefile=
 line 336:<br>
<br>
=C2=A0 =C2=A0# Don&#39;t try to regenerate Makefile or configure<br>
=C2=A0 =C2=A0# We don&#39;t generate any of them<br>
=C2=A0 =C2=A0Makefile: ;<br>
=C2=A0 =C2=A0configure: ;<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Makefile and configure are not generated but other=
 included files are. Most likely the one you&#39;re hitting is config-host.=
mak..</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I note that if you run &quot;make clean&quot; twice in a row, it doesn&#39;=
t re-run <br>
configure in between. It&#39;s only when a stale target exists, which seems=
 <br>
to involve dependencies making a decision.</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">... and the second time, it is not st=
ale anymore.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">(The fil=
e NOT existing doesn&#39;t trigger action, but the file being &quot;old&quo=
t; does.)<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">config-host.mak is only cleaned by distclean, not clean.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">So it&#39;s an artifact of the=
 way you&#39;re using make, and hard to fix then?<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Maybe not too hard, I supp=
ose one could strip the includes if make goals are only of the form %clean.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
*shrug* I&#39;d use &#39;git clean -fdx&#39; instead but I&#39;m not sure h=
ow that <br>
interacts with multiple submodules.<br>
</blockquote></div></div></div>

--0000000000006d5dcc0626fa7bd6--


