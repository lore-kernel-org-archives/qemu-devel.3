Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F507CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 16:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuZIs-0001tH-DT; Fri, 05 Sep 2025 12:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuZIq-0001sr-9I
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:28:44 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1uuZIk-0004SH-LZ
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:28:44 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce872d9cso2206623fac.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757089712; x=1757694512; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6qys7WtfqRh4Bndk8bsX0y7/fYV5jWk4y4VTK3mdZEc=;
 b=L3XyIdfsAs6c9caLTthvf4dBbOuA02h8DhkxyAzEbXzfGri8aFbiqoRGqPsuJgXbCt
 eu4e86cyxBguJsqMHcsA4pnN02G4/uXoo1pYBdAl7KBCl+6Dd5KdgRrD6h/8fPYUFR1m
 JbbTmksGATyS9wYbME2YEI37XRFJIyqsl99wWxr9rbgpt4ezPdu03FS0QtAaDIcpBWmw
 hoazsf7889TSe46kMZrf3RqYwa6J63k1R4czlRZntyKZROdNicD5KkL2QbqMC1BA51Fh
 uC7FXh//uoXYFwOF+qhxbuaUguIiHeBfxFBb5hBOf4bCKwX+juipv3Z6OvBhyNlCMa1K
 sPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757089712; x=1757694512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qys7WtfqRh4Bndk8bsX0y7/fYV5jWk4y4VTK3mdZEc=;
 b=FU60FHO20VlMIlPGfaLJ6jg7fx37sSc3lJ1j0nC9hdwu8KblI5RtdtvjmRnj14djuB
 eprsRWjISW9N/v0/2ZRkPT0OlUnXVi5TI/Y2R1cGNXxZ9XH0uDVIGpE/KX6MKXNvpjgg
 R3I+ngiNGrEE2XEveNwZdWg2ya+sSBoyK/gYcAZP+Wzb2otPWPeo3IRVDSYpEHxJQdrR
 XFtFHdePBESjUJjUdfkN0DlBLDJKxvZsn3iLsb07Gz2OSylklVpzvrSJwhT+GQMHCz7D
 jOV+An+SO0OPLY6OPttKuscDus5nKGhSsG2hefaNjnU0zawPIodRozay1T/2jjrWfog2
 naFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl6zLAoRS85nK6dI4CNZfJRF3RQi2xE3m1iAzn2XrcoJj8OHzJsgTGbxyT/wzyUE+CDv693EkuVuC7@nongnu.org
X-Gm-Message-State: AOJu0YxHXmu0P4N5ule79u3FmGfGk/kTrcQGfS63Xoo62R93u9YfBJQc
 oJ23foCBZbOHHFwx5fJM/SVeJgQCYcmWE6/DWLEwbL7r9+7M9RIcpSn0oU6HMQ8aEFv8XAMg58z
 JRvxfrzwi49rr5rmlkC0DoOmFnaJLnFO8AfI5hu7n
X-Gm-Gg: ASbGncs43PIKkWH+ryFcScD1NDnp0n5awmSseJndV3hBkoiQD590b0xTCmo5MzAaxuJ
 hhHhYkyfOmeULG01SG4AsqjHNEO0uELyft0l3bMywfIPj88DFYBAN9VT+UyZUuy4X9qhC4zE4KB
 N/c58YB3uz28ggazN3vtTJAMVO/v+VD/CEa5ar/eZCUR6HNY8Q/TS2HjpdBHwdfspo9YKGD1QXh
 jI4UcFnTfbd+E1RDlqc3AMYSJq8z5qBs2rvSfMh+BU79QukjuJ0WWs/ARnSx4YMAA==
X-Google-Smtp-Source: AGHT+IEmVT+ANrnmX68KLB1naIl/ZcFBtyuPZS5hYFRp6xbR61I/PHHiFfv3PhIMleEDZjKh9HYeLu/A6aNaaLs6x0o=
X-Received: by 2002:a05:6870:f116:b0:2f3:e087:6315 with SMTP id
 586e51a60fabf-3196309ae26mr14142654fac.4.1757089711917; Fri, 05 Sep 2025
 09:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250904-includes-v1-1-a04a0ea14fd1@google.com>
 <687f76dc-769d-4e8d-9281-5e5f10361bfe@redhat.com>
 <80ba3dae-0bb9-4a45-b1f9-5b80f4fdc47b@linaro.org>
 <CAAAKUPPbiQnCzkmnL0Luww1qeFQxVojzfkgJPrGgphXpkrXMGQ@mail.gmail.com>
 <6be94329-73c5-425a-a890-1199ddcfe1f4@linaro.org>
In-Reply-To: <6be94329-73c5-425a-a890-1199ddcfe1f4@linaro.org>
From: Peter Foley <pefoley@google.com>
Date: Fri, 5 Sep 2025 12:28:20 -0400
X-Gm-Features: Ac12FXzQ-gf_UyywktwreNhjd5MBeRPNq3ub80xKnjdBKqmRjyCbITFKAhdxqIc
Message-ID: <CAAAKUPOsbuXSUUkC9ufQD8niTZbzCRFPAy_ztsEa+XhnMnVQtQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add missing includes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, nabihestefan@google.com
Content-Type: multipart/alternative; boundary="0000000000001edc10063e1054fb"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=pefoley@google.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000001edc10063e1054fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:26=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 9/5/25 18:00, Peter Foley wrote:
> > We're using glibc 2.27.
>
> That's just too old.
>

Yeah, I'm picking up on that.
So it looks like short of back-porting support for MAP_FIXED_NOREPLACE to
our "grte" fork of glibc, we should just keep carrying a local patch.
Sorry for the noise.

>
> commit c42e77a90d9244c8caf76fe0e54f84200430a4e1
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Tue Aug 8 09:44:18 2023 -0700
>
>      qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE
>
>      In order for our emulation of MAP_FIXED_NOREPLACE to succeed within
>      linux-user target_mmap, we require a non-zero value.  This does not
>      require host kernel support, merely the bit being defined.
>
>      MAP_FIXED_NOREPLACE was added with glibc 2.28.  From repology.org:
>
>                        Fedora 36: 2.35
>                CentOS 8 (RHEL-8): 2.28
>                        Debian 11: 2.31
>               OpenSUSE Leap 15.4: 2.31
>                 Ubuntu LTS 20.04: 2.31
>
>      Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>      Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>      Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>      Message-Id: <20230808164418.69989-1-richard.henderson@linaro.org>
>
>
> r~
>
>

--0000000000001edc10063e1054fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Sep 5, 2025 at 12:26=E2=80=AFPM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/5/2=
5 18:00, Peter Foley wrote:<br>
&gt; We&#39;re using glibc 2.27.<br>
<br>
That&#39;s just too old.<br></blockquote><div><br></div><div>Yeah, I&#39;m =
picking up on that.</div><div>So it looks like short of back-porting suppor=
t for MAP_FIXED_NOREPLACE to our &quot;grte&quot; fork of glibc, we should =
just keep carrying a local patch.</div><div>Sorry for the noise.</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
commit c42e77a90d9244c8caf76fe0e54f84200430a4e1<br>
Author: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.or=
g" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue Aug 8 09:44:18 2023 -0700<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE<br>
<br>
=C2=A0 =C2=A0 =C2=A0In order for our emulation of MAP_FIXED_NOREPLACE to su=
cceed within<br>
=C2=A0 =C2=A0 =C2=A0linux-user target_mmap, we require a non-zero value.=C2=
=A0 This does not<br>
=C2=A0 =C2=A0 =C2=A0require host kernel support, merely the bit being defin=
ed.<br>
<br>
=C2=A0 =C2=A0 =C2=A0MAP_FIXED_NOREPLACE was added with glibc 2.28.=C2=A0 Fr=
om <a href=3D"http://repology.org" rel=3D"noreferrer" target=3D"_blank">rep=
ology.org</a>:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Fedora 36: 2.35<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CentOS 8 (RHEL-8): 2=
.28<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Debian 11: 2.31<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OpenSUSE Leap 15.4: 2.31<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ubuntu LTS 20.04: 2=
.31<br>
<br>
=C2=A0 =C2=A0 =C2=A0Reported-by: Akihiko Odaki &lt;<a href=3D"mailto:akihik=
o.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihik=
o.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:ale=
x.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:=
richard.henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.or=
g</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:20230808164418.69989-=
1-richard.henderson@linaro.org" target=3D"_blank">20230808164418.69989-1-ri=
chard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div>

--0000000000001edc10063e1054fb--

