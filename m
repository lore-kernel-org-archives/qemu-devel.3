Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094D4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ses9u-0003ze-JA; Fri, 16 Aug 2024 04:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ses9s-0003ua-3I
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:18:04 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ses9o-0003Uc-Uw
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:18:03 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5bed83487aeso51415a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723796279; x=1724401079; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nPpU0PH6JcycdB2I98txnw/CAZnoVrAUDVWZJg3o/Sk=;
 b=gWSHPBlMKkRqWaqU9+gHT+mcu5kHA9kde6sdvB4w1RYuHT5g6yGS+iBJL45fgCakJO
 5M9jq6Kc1KObKqCCAUOhdNtpDYGtwI5ISOynwyxoS+crdMezyI4D+ZJREoIHZAqdITAr
 uXaFrkANFagGo5alv/6atvdkr1G6yRij1Db1lxOfNBv47lSVmtX7eSwgRfJErsaAhNwq
 xcibQiFAtIc15VDIO80/wd0ZNdmqdfGUtWE9MnC63MK+D41k8UhhBWmMI9mt2Dl9hfSA
 yPIfNztCVA8Dkk6E8quMkj9y4ngFTbtsTnM9Q/nuorIoeK85DUJz5DVI8yJM19FdhElJ
 /lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723796279; x=1724401079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nPpU0PH6JcycdB2I98txnw/CAZnoVrAUDVWZJg3o/Sk=;
 b=n4Mwv4y6Ak9yTz/7d78WZD5bykwBVV6OE9JjAm9ZCDUeUtM1YZEJHFD1Ib1jCpBkIJ
 ZGnwcX0/Wi8ARbKsjqTLGT/tua5U24UeJXR9xGghQ6vxpNZDGTM9QjMHNr+SFl9prxn5
 au0/vUS2VWc+TIm/NrjaCn3MVBG7oLH5SDm+C0rmEUwvMfhpUN1W9Xuu3Nobh52xq9Qa
 RQmPt2R0a2/WJ0KqWxDFuEMztd3JQ/Z2rPm+EtdJDsjF+E3Fy5Kch3/UQi88WUACYEZx
 Q3tIZ3ouKVxh/vop2JbhtOR3xZWfhiAyPywnnawDlfUtWrnqhxQw1CRqRAdUG5qpTsaP
 rE2Q==
X-Gm-Message-State: AOJu0YzyRv5Wm6L+QpToMj3+8rxKIhVBbVkJ7xLyITE0fcdxzJFRRsHc
 ux06H3j+t/DsZPsCL8kzBYk9UwuB4d7XiZ1CKorro4LG/qu+tT8PghSRt3UDsajoDVBIwjV/8Bo
 jxPea+rGIWXX8BpNWQO+Zq+gUn2XrekZl1rkj2Q==
X-Google-Smtp-Source: AGHT+IHwBzP7404BHcFLdlD7qbYBGf8bhQDZW5S7N8RM6o9qavhPbf51m0tm6yH9raLsgP8+KMvrnH8N/L9NMM3uGoo=
X-Received: by 2002:a05:6402:2353:b0:5a1:1:27a9 with SMTP id
 4fb4d7f45d1cf-5beca595cbcmr1609888a12.18.1723796279045; Fri, 16 Aug 2024
 01:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <8f5f670b-313e-4172-a04b-ff8439bc4777@intel.com>
In-Reply-To: <8f5f670b-313e-4172-a04b-ff8439bc4777@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 16 Aug 2024 11:17:47 +0300
Message-ID: <CAAjaMXYyggQuenzEt-cTpENAM5S46_Wi4iqeXjzLYoDrHXzj2g@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add Rust build support, ARM PL011 device impl
To: Junjie Mao <junjie.mao@intel.com>
Cc: "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, "Liu,
 Zhao1" <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, ARM TCG CPUs <qemu-arm@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 "Hart, Rowan" <rowan.hart@intel.com>, Mads Ynddal <mads@ynddal.dk>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e0ce20061fc89844"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000e0ce20061fc89844
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024, 11:06 Junjie Mao, <junjie.mao@intel.com> wrote:

> On 8/15/2024 7:42 PM, Manos Pitsidianakis wrote:
> > Outstanding issues
> > ==================
> >
> > Outstanding issues that are not blocking for merge are:
> >
> > - Cross-compilation for aarch64 is not possible out-of-the-box because
> of this bug:
> >    <https://github.com/rust-lang/rust/issues/125619> in llvm which when
> >    fixed, must be ported to upstream rust's llvm fork. Since the problem
> >    is an extraneous symbol we could strip it with objcopy
> -N|--strip-symbol
> > - Adding more than one Rust device ends up with duplicate symbols from
> >    rust std library because we are linking as whole archives because...
> >    constructors are stripped by the linker otherwise :( It can be worked
> >    around if a single Rust library is built with all the devices as
> >    dependencies which is then linked to qemu. The fix is a small change
> >    which I will add either in a next version or when a new Rust device is
> >    added.
> >
>
> Hi Manos,
>
> I also noticed that when I tried adding a second device. Some other
> projects met
> similar issues [1], but no clean solution seems to be available yet. The
> options
> are:
>
> 1) Combining all crates into one staticlib which is linked to the final
> executable. That requires generating one .rs with extern crate decls of
> all
> enabled crates. In the context of QEMU, different targets may enable
> different
> set of crates (e.g., some crates have arch constraints), thus one .rs for
> each
> target will be needed in general.
>
> 2) Linking rlibs (or emitted objects) directly with other C objects using
> the C
> linker. That somehow works (with some tricks) but is not officially
> supported
> and may break in the future.
>
> I'm working on (1), but would like to have your thoughts and preference on
> those
> options.
>

Hello Junjie, I have also implemented (1) already (the fix I mentioned in
the cover letter). In general I'd like to do it on a standalone patch so
that it can be separated from the other changes instead of squashing it.

If you have something already too, please share here! I will send mine as a
reply to this thread when I am able. I am not familiar with meson so my
version could be lacking!

Manos



[1] https://github.com/rust-lang/rust/issues/73632
>
> ---
> Best Regards
> Junjie Mao
>

--000000000000e0ce20061fc89844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, 16 Aug 2024, 11:06 Junjie Mao, &lt;<a href=3D"=
mailto:junjie.mao@intel.com" target=3D"_blank" rel=3D"noreferrer">junjie.ma=
o@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 8/15/2024 7:42 PM, Manos Pitsidianakis wrote:<br>
&gt; Outstanding issues<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; Outstanding issues that are not blocking for merge are:<br>
&gt; <br>
&gt; - Cross-compilation for aarch64 is not possible out-of-the-box because=
 of this bug:<br>
&gt;=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/rust-lang/rust/issues/1=
25619" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://g=
ithub.com/rust-lang/rust/issues/125619</a>&gt; in llvm which when<br>
&gt;=C2=A0 =C2=A0 fixed, must be ported to upstream rust&#39;s llvm fork. S=
ince the problem<br>
&gt;=C2=A0 =C2=A0 is an extraneous symbol we could strip it with objcopy -N=
|--strip-symbol<br>
&gt; - Adding more than one Rust device ends up with duplicate symbols from=
<br>
&gt;=C2=A0 =C2=A0 rust std library because we are linking as whole archives=
 because...<br>
&gt;=C2=A0 =C2=A0 constructors are stripped by the linker otherwise :( It c=
an be worked<br>
&gt;=C2=A0 =C2=A0 around if a single Rust library is built with all the dev=
ices as<br>
&gt;=C2=A0 =C2=A0 dependencies which is then linked to qemu. The fix is a s=
mall change<br>
&gt;=C2=A0 =C2=A0 which I will add either in a next version or when a new R=
ust device is<br>
&gt;=C2=A0 =C2=A0 added.<br>
&gt; <br>
<br>
Hi Manos,<br>
<br>
I also noticed that when I tried adding a second device. Some other project=
s met <br>
similar issues [1], but no clean solution seems to be available yet. The op=
tions <br>
are:<br>
<br>
1) Combining all crates into one staticlib which is linked to the final <br=
>
executable. That requires generating one .rs with extern crate decls of all=
 <br>
enabled crates. In the context of QEMU, different targets may enable differ=
ent <br>
set of crates (e.g., some crates have arch constraints), thus one .rs for e=
ach <br>
target will be needed in general.<br>
<br>
2) Linking rlibs (or emitted objects) directly with other C objects using t=
he C <br>
linker. That somehow works (with some tricks) but is not officially support=
ed <br>
and may break in the future.<br>
<br>
I&#39;m working on (1), but would like to have your thoughts and preference=
 on those <br>
options.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Hello Junjie, I have also implemented (1) already (the fix I ment=
ioned in the cover letter). In general I&#39;d like to do it on a standalon=
e patch so that it can be separated from the other changes instead of squas=
hing it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you have som=
ething already too, please share here! I will send mine as a reply to this =
thread when I am able. I am not familiar with meson so my version could be =
lacking!</div><div dir=3D"auto"><br></div><div dir=3D"auto">Manos</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
[1] <a href=3D"https://github.com/rust-lang/rust/issues/73632" rel=3D"noref=
errer noreferrer noreferrer" target=3D"_blank">https://github.com/rust-lang=
/rust/issues/73632</a><br>
<br>
---<br>
Best Regards<br>
Junjie Mao<br>
</blockquote></div></div></div>

--000000000000e0ce20061fc89844--

