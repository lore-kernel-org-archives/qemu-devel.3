Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BF7CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utULJ-0007pF-7t; Tue, 02 Sep 2025 12:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utULH-0007nz-9J
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utULE-0006OH-60
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756832322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LVeYqJdh0gWTptJ984ENesueo1jrJ042YYmDQKvpreg=;
 b=PBHO93boic3TfEwdwZ3XNIzq/6VWe62UwVff3Ht6wxfOXigeThv6Ju6s9Q/k7ME4f8VeYh
 4yv4AykjtohNfwR5zBJAuk4fJK08pfoGFAHiyRllBhyZbyff2NfA4L0pjjRJ39BfAxTWnk
 vWE21dAYWkl6Szyo3AlejQNsE/2N7I8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-X1CN0ZjyOHSBFJ4thFhb3A-1; Tue, 02 Sep 2025 12:58:39 -0400
X-MC-Unique: X1CN0ZjyOHSBFJ4thFhb3A-1
X-Mimecast-MFC-AGG-ID: X1CN0ZjyOHSBFJ4thFhb3A_1756832318
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b4c2c09a760so4349848a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756832318; x=1757437118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVeYqJdh0gWTptJ984ENesueo1jrJ042YYmDQKvpreg=;
 b=Ks7i57OziMIlHXSB98CX52bp+qAc9t1Q0i7IjtJqDBO2oLzmP7p9//4/3s+5T/mZb5
 wuSobIuNPoL71cXDEZ/zWHL9EGKI4Ue7sVCjOiETexpQbOWiT3pVvizZEKZMjtf1E5R0
 RHJiGdVb348Ga5OrcXiqLrK3aSnVTrj9P6au6NPK7Q7Y8xHSt/putwEQBgxqAMHKPjMt
 0zTMKJtsVnTJwV2HnaCahj8feXMh3g/Tbd14/qzS0JLQMp114PCYURMm0hPNcDtJ2tDV
 wjsZCUTJKWf8e361JHrw4ewwJ6L+Ff5eavnYFh8FIXRaSBfS+UTclLvKHiuuY1dfeXwj
 UyDQ==
X-Gm-Message-State: AOJu0YxcvNsKF6tjAw6MQ6swRRz9nh+8IKwFEG9MpBifIOOOMHlJS8Jh
 xbazqiSYhQej9hmlx48vaHbHUDdbABTIQ/0KhkmOJ9A/8YnT0eukvq7QzlCFy6tCZx6VYg7Ho0x
 yb4g+KZZeqyywwyShxwgjCEjnRoApow1IYUJRAaMUxGLLin7wDXjkoST2NiKqhzduBzR/fQiNle
 kwg7rThWwoz6a7DYguvKvSxAkhbpQ8plY=
X-Gm-Gg: ASbGncs3P9b8zoe/hbJxCKFNdp1bBS/yb1cXULsSiMHk8QIPwLw3MrELvm0lGzezsit
 gvDUg/HRgGdLNOJHCpae9fMwdJBszlPcmQ+nJnf0ul4552qSnLvSF95K2QN4UST1AQKpcJW5f4a
 M5IGwGUltGw3zGINavfuQcxDOH/62oFWB9UvN/wCBtwm45897+n9IR
X-Received: by 2002:a17:902:f652:b0:234:a734:4ab1 with SMTP id
 d9443c01a7336-2494488a6d2mr190830345ad.3.1756832318086; 
 Tue, 02 Sep 2025 09:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5I/dJf6NhcIE5Lxt/kIS8+TBR7tgG7ZemfI/8EgiECgArWjq8ebeeXbqd6vqBFfO5sVxznJFc4yX6medLUjA=
X-Received: by 2002:a17:902:f652:b0:234:a734:4ab1 with SMTP id
 d9443c01a7336-2494488a6d2mr190830035ad.3.1756832317607; Tue, 02 Sep 2025
 09:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250901202702.2971212-1-jsnow@redhat.com>
 <aLchMLLyGb0GAZHJ@redhat.com>
In-Reply-To: <aLchMLLyGb0GAZHJ@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 2 Sep 2025 12:58:24 -0400
X-Gm-Features: Ac12FXzfUU6UPA8-Ndd3I4O0iY4ysN-AcavqZ_w5T6lO6C9oSE1YEiu9cORCWuM
Message-ID: <CAFn=p-bq42-CGHfNe=WENHQFTsCbD0iKNywYYqXkAM_Aq_aamA@mail.gmail.com>
Subject: Re: [PATCH 00/19] python: 3.14 compatibility and python-qemu-qmp
 synchronization
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000038b05a063dd466d5"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000038b05a063dd466d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025, 12:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com>
wrote:

> On Mon, Sep 01, 2025 at 04:26:42PM -0400, John Snow wrote:
> > RFC: Should I squash the last two backport patches? One technically
> > introduces a regression which breaks our "no regressions in series"
> > rule, but makes the per-patch relationship murkier. Please let me know.
>
> What is the effect of the regression ?
>
> If someone is running 'make check' (or a variant thereof), through
> a "git bisect" will this regression be significant enough to break
> their git bisect ?
>

It could, yes. To avoid it I need to squash the latest get_event_loop
change in to the second-to-last one.

I guess I'll just notate that it's cherry-picked from two commits and
include both commit messages.

Does that sound OK? (I've never really "cherry picked" across repositories
like this where the file paths do not actually match, so it's been a bit of
a manual affair.)


>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--00000000000038b05a063dd466d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 2, 2025, 12:54=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Mon, Sep 01, 2025 at 04:26:42PM -0400, John Snow wrote:<br>
&gt; RFC: Should I squash the last two backport patches? One technically<br=
>
&gt; introduces a regression which breaks our &quot;no regressions in serie=
s&quot;<br>
&gt; rule, but makes the per-patch relationship murkier. Please let me know=
.<br>
<br>
What is the effect of the regression ?<br>
<br>
If someone is running &#39;make check&#39; (or a variant thereof), through<=
br>
a &quot;git bisect&quot; will this regression be significant enough to brea=
k<br>
their git bisect ?<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">It could, yes. To avoid it I need to squash the latest ge=
t_event_loop change in to the second-to-last one.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">I guess I&#39;ll just notate that it&#39;s cherry=
-picked from two commits and include both commit messages.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Does that sound OK? (I&#39;ve never real=
ly &quot;cherry picked&quot; across repositories like this where the file p=
aths do not actually match, so it&#39;s been a bit of a manual affair.)</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--00000000000038b05a063dd466d5--


