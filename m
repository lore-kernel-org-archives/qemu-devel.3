Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0143BC38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 08:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRSIG-0001VN-HN; Wed, 10 Jul 2024 04:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRSIB-0001UO-2n
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:03:11 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRSHz-00013D-4Y
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 04:03:10 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77e7a6cfa7so373721866b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720598575; x=1721203375; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YU+aIGZJKyC5HBUlOysXtqW+/0JzqIRrb6iEa16fP8I=;
 b=CJpfzdHA8O4HxL8+eRRevoFILo+uZHApJ3+0gw4s0Tv/cwineg76dedf4GhGwMJgSk
 jyIKZIULNEevOIwLOc8wh8OnhnczR865I08czmYhipvoYEgZLdoIqLkFE2ZWUMHfI7Gr
 4+/u1MJb1HM78EaHdwAtSqUZxGWdejTe2fL7Fv6bI6oVFGYvKKx+ghcDywCk2Ks1bnV1
 l8USBt4vmVpyZwoIVvcga1LgoQrvixNQZ1UOWOSlIO4zELG0FQhEkYk77+OyKxv83AZj
 B9okHW0YWUiTXSCgE6rheaiLOc6qU91dYBbQd4vMwr9MSNrb+wvNXQ2I6Pf76tzfTvN/
 8QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720598575; x=1721203375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YU+aIGZJKyC5HBUlOysXtqW+/0JzqIRrb6iEa16fP8I=;
 b=SY17u9NPo++Mmi5HfGuxrYd23gX4lx53vpmYvLH7jEX7z1jwhxcbAJxdiOXyyqKtyf
 BBXdVw72pGQLjoSUCz42l1RzZLFz1FjSePzqntjez5Bb5tAz/raFYTM9M14L1aVH+B1q
 3Wuw9pvBgYV67geIzDPgH8ipIGXJwRBnviF1cNj7s3FURPq5E7NrjYCvAKoYzaXrdAYL
 hoVn3s/FBnVu8sIceGGot1zBv2omEcXNxOOw9jtxFIZJ5/gHk/A83huGwEwZTeC1JxIx
 kHoK8u7CZP1ivB+njh4EGB52VATgwq9H+WBlQubhaA58LhPAfJ154vBkW2EUgGiyf1hQ
 8dQA==
X-Gm-Message-State: AOJu0Ywq7HkkVo60e6DtbD4d87Md9uoz0de6w2fBOr74S97/JYPMJr+1
 Ls1iTEnBVzQdvN3nI+T64630K4NAz2HMjKxrvfHQgHc+nNuA474m2rsDO9d9kMMfm0oI1pitm4l
 Abnr6zL5oUo0VUL5/HxPhycwWZpA=
X-Google-Smtp-Source: AGHT+IHh7nkG+p882ePI6xBOIdQX3ULsUWsuA7Rk7xFLJ3RRDWpdRuAMoZnn9jAeZcywTinW4aQ+EnzspwA/8crXqBA=
X-Received: by 2002:a17:906:2985:b0:a72:8762:1f5d with SMTP id
 a640c23a62f3a-a780b8848a8mr294825466b.55.1720598574761; Wed, 10 Jul 2024
 01:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240708112520.106127-1-junjiehua@tencent.com>
 <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
In-Reply-To: <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
From: hellord <halouworls@gmail.com>
Date: Wed, 10 Jul 2024 16:02:18 +0800
Message-ID: <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
Content-Type: multipart/alternative; boundary="000000000000d98e09061ce012ff"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=halouworls@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--000000000000d98e09061ce012ff
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>

On Tue, Jul 9, 2024 at 10:39=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
> wrote:


> > +#define MAX_CHUNK_SIZE (128 * 1024 * 1024)
>
> I think we could add a comment here, something like:
>
> /*
>  * Maximum size to fwrite() to the output file at once;
>  * the MSVCRT runtime will not correctly handle fwrite()
>  * of more than 4GB at once.
>  */

That will act as a reminder about why we do it.
>
>
Thanks, I agree.


> (Does the library fwrite fail for > 4GB, or for >=3D 4GB ?
> Your commit message says the former, so I've gone with that,
> but if it's an "overflows 32 bit variable" kind of bug then
> 4GB exactly probably also doesn't work.)
>


It fails for > 4GB.
The msvcrt.dll!fwrite(buff, (4G+0x1000), 1, file)  works as following:
(based on assembly, not the original source, irrelevant parts have been
omitted)

size_t fwrite(const void* buff, size_t element_size, size_t element_count,
FILE* file_p)
{
    size_t size_t_total_size =3D element_size * element_count;
    size_t size_t_remain_size =3D size_t_total_size;

    unsigned int u32_written_bytes;
    unsigned int buf_size;

    /* The register used is r12d but not r12.
     * So I suspect that Microsoft wrote it as an unsigned int type
     * (or msvc compiler bug? seems unlikely)
     */
    unsigned int u32_chunk_size;

    while (true) {

        if ((file_p->flags & 0x10C) !=3D 0) {
            buf_size =3D file_p->buf_size;
        }
        else {
            // Always reaches here on the first fwrite() after fopen().
            buf_size =3D 4096;  // mov     r15d, 1000h
        }

        if (size_t_remain_size > buf_size) {

            u32_chunk_size =3D size_t_remain_size;

            if (buf_size) {

                // div ... ;  sub r12d,edx;   size_t stored into r12d ,
lost high 32 bits
                // u32_chunk_size =3D 0x100000FFF - 0x100000FFF % 0x1000
                //                            =3D 0x100000FFF - 0xFFF
                //                            =3D 0x1 0000 0000
                //                            =3D (u32) 0x1 0000 0000
                //                            =3D 0
                u32_chunk_size =3D size_t_remain_size - (size_t_remain_size=
 %
buf_size);
            }

            //call _write() with zero size, returns 0
            u32_written_bytes =3D __write(file_p, data_buff, u32_chunk_size=
);

            // They didn't check if __write() returns 0.
            if (u32_written_bytes =3D=3D -1 || u32_written_bytes <
u32_chunk_size) {
                return (size_t_total_size - size_t_remain_size) /
element_size;
            }

            //size_t_remain_size -=3D 0
            size_t_remain_size -=3D u32_written_bytes;
            buff +=3D u32_written_bytes;

            //size_t_remain_size will never decrease to zero, then
while(true) loop forever.
            if (size_t_remain_size =3D=3D 0) {
                return element_count;
            }
            // ...
        }
        else {
            // ...
        }
    }
    // ...
}

note:
1. The path of buggy msvcrt.dll is c:\windows\system32\msvcrt.dll( mingw64
links to it );
2. fwrite implementation in another msvc library which is called
ucrtbase.dll is correct(msvc links to it by default).



> Is there a particular reason to use 128MB here? If the
> runtime only fails on 4GB or more, maybe we should use
> a larger MAX_CHUNK_SIZE, like 2GB ?
>

According to current analysis, size <=3D 4GB all are safe, however there ar=
e
many
versions of msvcrt, this bug exists on Server 2008/2019/2022 and Windows
11(all
with full latest updates), and it may also exist in other versions, but it
is difficult to
check each version individually. I am not sure if all versions handle
boundary sizes
like 2GB/4GB correctly. So I prefer a relatively conservative value: 128MB.

Maybe we could use #ifdef _WIN32 to differentiate the handling between
Linux and
Windows. For Linux, it remains unchanged, while for Windows, it processes
by chunks
with max_chunk_sizeto 1GB.



> > +        while (offset < b->size) {
> > +            chunk_size =3D (b->size - offset > MAX_CHUNK_SIZE)
> > +                         ? MAX_CHUNK_SIZE
> > +                         : (b->size - offset);
>
> You can write this as
>      chunk_size =3D MIN(b->size - offset, MAX_CHUNK_SIZE);
> which I think is clearer. (Our osdep header provides MIN().)
>
> I think we should abstract out the bug workaround into a
> separate function, with the same API as fwrite(). Call
> it do_fwrite() or something, and make all the fwrite()
> calls use it. I know at the moment there's only two of
> them, and one of them is the header so never 4GB, but
> I think this more cleanly separates out the "work around
> a runtime library problem" part from the main logic of
> the program, and will mean that if we ever need to rearrange
> how we write out the data in future it will be simple.
>
>
Thanks, you are right!

--000000000000d98e09061ce012ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span class=3D"gmail-im" style=3D"color:r=
gb(80,0,80)"><div class=3D"gmail-adM"><div><br></div></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Tue, Jul 9, 2024 at 10:39=E2=80=AFPM Peter M=
aydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">pe=
ter.maydell@linaro.org</a>&gt; wrote:</blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br>&gt; +#define MAX_CHUNK_SIZE (128 * 1024 * 102=
4)<br><br>I think we could add a comment here, something like:<br><br>/*<br=
>=C2=A0* Maximum size to fwrite() to the output file at once;<br>=C2=A0* th=
e MSVCRT runtime will not correctly handle fwrite()<br>=C2=A0* of more than=
 4GB at once.<br>=C2=A0*/</blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">That will act as a reminder about why we do it.<br><br></block=
quote><div><br></div></span><div style=3D"color:rgb(0,0,0)">Thanks, I agree=
.<br></div><span class=3D"gmail-im" style=3D"color:rgb(80,0,80)"><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">(Does the librar=
y fwrite fail for &gt; 4GB, or for &gt;=3D 4GB ?<br>Your commit message say=
s the former, so I&#39;ve gone with that,<br>but if it&#39;s an &quot;overf=
lows 32 bit variable&quot; kind of bug then<br>4GB exactly probably also do=
esn&#39;t work.)<br></blockquote><div><br></div><div><br></div></span><div =
style=3D"color:rgb(0,0,0)"><div>It fails for &gt; 4GB.</div><div>The msvcrt=
.dll!fwrite(buff, (4G+0x1000), 1, file)=C2=A0 works as following:</div><div=
>(based on assembly, not the original source,=C2=A0irrelevant parts have be=
en omitted)=C2=A0<br></div><div><br></div><div>size_t fwrite(const void* bu=
ff, size_t element_size, size_t element_count, FILE* file_p)<br>{<br>=C2=A0=
 =C2=A0 size_t size_t_total_size =3D element_size * element_count;<br>=C2=
=A0 =C2=A0 size_t size_t_remain_size =3D size_t_total_size;<br><br>=C2=A0 =
=C2=A0 unsigned int u32_written_bytes;<br>=C2=A0 =C2=A0 unsigned int buf_si=
ze;<br><br>=C2=A0 =C2=A0 /* The register used is r12d but not r12.<br>=C2=
=A0 =C2=A0 =C2=A0* So I suspect that Microsoft wrote it as an unsigned int =
type<br>=C2=A0 =C2=A0 =C2=A0* (or msvc compiler bug? seems unlikely)<br>=C2=
=A0 =C2=A0 =C2=A0*/<br>=C2=A0 =C2=A0 unsigned int u32_chunk_size;<br><br>=
=C2=A0 =C2=A0 while (true) {<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((file_p=
-&gt;flags &amp; 0x10C) !=3D 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 buf_size =3D file_p-&gt;buf_size;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 // Always reaches here on the first fwrite() after fopen().<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_size =3D 4096; =C2=A0// mov =C2=
=A0 =C2=A0 r15d, 1000h<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (size_t_remain_size &gt; buf_size) {<br><br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32_chunk_size =3D size_t_remain_size;<br><=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf_size) {<br><br></div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // div ... ;=C2=
=A0 sub r12d,edx;=C2=A0 =C2=A0size_t stored into r12d , lost high 32 bits</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // u32_chu=
nk_size =3D 0x100000FFF - 0x100000FFF % 0x1000=C2=A0</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D =
0x100000FFF - 0xFFF=C2=A0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 //=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x1 0000 0000=C2=A0</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D (u32) 0x1 0000 0000</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 //=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32_chunk_size =3D size_t=
_remain_size - (size_t_remain_size % buf_size);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //call=
 _write() with zero size, returns 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 u32_written_bytes =3D __write(file_p, data_buff, u32_chunk_size);<br=
><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // They didn&#39;t check if =
__write() returns 0.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (u32_w=
ritten_bytes =3D=3D -1 || u32_written_bytes &lt; u32_chunk_size) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (size_t_total_s=
ize - size_t_remain_size) / element_size;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //size_t_r=
emain_size -=3D 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t_remai=
n_size -=3D u32_written_bytes;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 buff +=3D u32_written_bytes;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 //size_t_remain_size will never decrease to zero, then while(true) loop=
 forever.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (size_t_remain_si=
ze =3D=3D 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn element_count;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // ...<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 // ...<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 }<br=
>=C2=A0 =C2=A0 // ...<br>}</div></div><span class=3D"gmail-im" style=3D"col=
or:rgb(80,0,80)"><div><br></div><div><div style=3D"color:rgb(0,0,0)">note:<=
/div><div style=3D"color:rgb(0,0,0)">1. The path of buggy msvcrt.dll is c:\=
windows\system32\msvcrt.dll( mingw64 links to it );</div><div style=3D"colo=
r:rgb(0,0,0)">2. fwrite implementation in another msvc library which is cal=
led ucrtbase.dll is correct(msvc links to it by default).</div></div><div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Is there a particular reason to use 128MB here? If the<br>runtime only fai=
ls on 4GB or more, maybe we should use<br>a larger MAX_CHUNK_SIZE, like 2GB=
 ?<br></blockquote><div><br></div></span><div style=3D"color:rgb(0,0,0)"><d=
iv>According to current analysis, size &lt;=3D 4GB all are safe, however th=
ere are many=C2=A0</div><div>versions of msvcrt, this bug exists on Server =
2008/2019/2022 and Windows 11(all=C2=A0</div><div>with full latest updates)=
, and it may also exist in other versions, but it is difficult to=C2=A0</di=
v><div>check each version individually. I am not sure if all versions handl=
e boundary sizes</div><div>like 2GB/4GB correctly.=C2=A0<span style=3D"colo=
r:rgb(34,34,34)">So I prefer a relatively conservative value: 128MB.</span>=
</div><div><br></div><div><div>Maybe we could use #ifdef _WIN32 to differen=
tiate the handling between Linux and</div><div>Windows. For Linux, it remai=
ns unchanged, while for Windows, it processes by chunks</div><div>with max_=
chunk_sizeto 1GB.</div></div><div><br></div></div><div style=3D"color:rgb(0=
,0,0)">=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"color:rgb(0,0=
,0);margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><span style=3D"color:rgb(80,0,80)"><span class=3D"gmail-im">&gt;=
 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (offset &lt; b-&gt;size) {<br>&gt; +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chunk_size =3D (b-&gt;size - offset =
&gt; MAX_CHUNK_SIZE)<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? MAX_CHUNK_SIZE<br>&gt; +=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0: (b-&gt;size - offset);<br><br>You can write this as<br>=C2=
=A0 =C2=A0 =C2=A0chunk_size =3D MIN(b-&gt;size - offset, MAX_CHUNK_SIZE);<b=
r>which I think is clearer. (Our osdep header provides MIN().)<br><br>I thi=
nk we should abstract out the bug workaround into a<br>separate function, w=
ith the same API as fwrite(). Call<br>it do_fwrite() or something, and make=
 all the fwrite()<br>calls use it. I know at the moment there&#39;s only tw=
o of<br>them, and one of them is the header so never 4GB, but<br>I think th=
is more cleanly separates out the &quot;work around<br>a runtime library pr=
oblem&quot; part from the main logic of<br>the program, and will mean that =
if we ever need to rearrange<br>how we write out the data in future it will=
 be simple.<br><br></span></span></blockquote><div style=3D"color:rgb(0,0,0=
)"><br></div><div style=3D"color:rgb(0,0,0)">Thanks, you are right!</div><d=
iv style=3D"color:rgb(0,0,0)"><br></div><div style=3D"color:rgb(0,0,0)"><br=
></div><div style=3D"color:rgb(0,0,0)"><br></div></div></div>

--000000000000d98e09061ce012ff--

