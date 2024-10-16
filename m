Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E0ED2069F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 06:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0xc2-0001kw-RP; Wed, 16 Oct 2024 02:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0xc0-0001ki-3v
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:34:24 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0xby-00087c-9Z
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 02:34:23 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4607d5932aaso4834221cf.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729060461; x=1729665261; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mgqNHEH8LdohH3/InvR5oxJ11HFOwQRfQbFktsOGF1g=;
 b=VWe5IumU55dSn3EEg14PPYbBixWEVWGF0jvAricsFFdid5Db/WnsqI0siUlYf3GNtJ
 0EWYCzWQN2zOUHRuKgleIBFOYkalna5QhF/olxBrFP/OQUDY9JTowj7v0B/+tGuiihJn
 R8j72xeX1QPPkL3bX7GyL3QuFedBHGrW+oq6mTh3/CVz88McvByXfD4tMkWYwuiitVQE
 WMmK7Rg9ZX6L9IuSCBBnzLaOgLudOT7/1oPlhTfEL6zV78gk6FCmxAh/qu64QYh9UoHb
 sJJV0T+mvf8xpkpup1/wKaXzl8J9Mjb2cQLUwMoJUSULZCwoaWrSzz+wdgU7trOg12PD
 IuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729060461; x=1729665261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mgqNHEH8LdohH3/InvR5oxJ11HFOwQRfQbFktsOGF1g=;
 b=WjiF2HxzKEEHZaZgtzq4+nCuyWgUu1Vg0ixOnviYixQ5on9yDREoYxqMNsVX106fqm
 X5tulWEd/V4gJnoqTF1bmwvRS2yokAhYmlOG+wH3+NYZYHp7vRkDXF/HT1X3JKpGxhaO
 faIMXEBmIGhqHL+y2/qQhBj0RtetQJ8/zEhzj+ScoUtLL9Cp9lzPvBaM8125hmqnnUlW
 osObiprh1DgCprVERwOX7KsgN4scrBSnjgqXz66gd9iBeqRQ5yWSB2LrTix4kDI0TqRo
 ElG4kJ/rULn6g17Fxm1RYdAe9TDcm9Zxyh/BhoZThNrGvX9f4pkrgxsvYQhFyT6OEntK
 2xUg==
X-Gm-Message-State: AOJu0Yy4IW2D9VhasIS6sRvsZJedpsCJgYYp7rC7hgFz/I8oNGTS5ajc
 37FRoxvhXCgi+m8mjV2c+4Hwi5sreFz+5sTGXrziOhXB6pHEXtowSoIo1sqZdd+Dc2zOhV3kCFH
 mjXH/SS1/7IfM83ysWpqXab8UiN8=
X-Google-Smtp-Source: AGHT+IEXIJ8tpDwRMKeSTwJ3PbOI9KY4fzEXZo42L6/9b9jpAv0k4hyXF0ujMpD76ClGadGXr+AfUXnzv2opOZszhBU=
X-Received: by 2002:a05:622a:5299:b0:460:8f76:cb81 with SMTP id
 d75a77b69052e-4608f76d6f0mr17430701cf.0.1729060460724; Tue, 15 Oct 2024
 23:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
 <d14c6eab-eebe-4844-a02b-9b3d1d9d43bd@tls.msk.ru>
In-Reply-To: <d14c6eab-eebe-4844-a02b-9b3d1d9d43bd@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2024 10:34:09 +0400
Message-ID: <CAJ+F1CJbWVwbEN_xnqMX9Vuz2eefcGehvk3KTcYvbtuNO+HhjA@mail.gmail.com>
Subject: Re: [PULL 00/20] UI patches
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="0000000000008e8cd00624924287"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000008e8cd00624924287
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael

On Tue, Oct 15, 2024 at 9:40=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 14.10.2024 16:39, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit
> 3860a2a8de56fad71db42f4ad120eb7eff03b51f:
> >
> >    Merge tag 'pull-tcg-20241013' of https://gitlab.com/rth7680/qemu
> into staging (2024-10-14 11:12:34 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> >
> > for you to fetch changes up to 4cd78a3db2478d3c1527905a26c9d3fbee83ccac=
:
> >
> >    audio/pw: Report more accurate error when connecting to PipeWire
> fails (2024-10-14 17:35:24 +0400)
> >
> > ----------------------------------------------------------------
> > UI-related fixes & shareable 2d memory with -display dbus
> >
> > ----------------------------------------------------------------
> >
> > Marc-Andr=C3=A9 Lureau (19):
> >    hw/audio/hda: free timer on exit
> >    hw/audio/hda: fix memory leak on audio setup
> >    ui/dbus: fix leak on message filtering
> >    ui/win32: fix potential use-after-free with dbus shared memory
> >    ui/dbus: fix filtering all update messages
> >    ui/dbus: discard display messages on disable
> >    ui/dbus: discard pending CursorDefine on new one
> >    util/memfd: report potential errors on free
> >    ui/pixman: generalize shared_image_destroy
> >    ui/dbus: do not limit to one listener per connection / bus name
> >    ui/dbus: add trace for can_share_map
> >    ui/surface: allocate shared memory on !win32
> >    meson: find_program('gdbus-codegen') directly
> >    ui/dbus: make Listener.Win32.Map win32-specific
> >    ui/dbus: add Listener.Unix.Map interface XML
> >    ui/dbus: implement Unix.Map
> >    virtio-gpu: allocate shareable 2d resources on !win32
> >    ui: refactor using a common qemu_pixman_shareable
> >    tests: add basic -display dbus Map.Unix test
> >
> > Michal Privoznik (1):
> >    audio/pw: Report more accurate error when connecting to PipeWire fai=
ls
>
> Or, actually, here (I replied to a wrong thread) -- is there something
> for qemu-stable in there?  First 7 changes seems to be good fit there.
>

Or only the first 5. It would be nice to have a second look before!

thanks

--=20
Marc-Andr=C3=A9 Lureau

--0000000000008e8cd00624924287
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Michael<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 15, 2024 at 9:4=
0=E2=80=AFPM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.=
msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 14.10.2024 16:39, <a href=3D"mailto:marcandre.lureau@redhat.com" t=
arget=3D"_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; The following changes since commit 3860a2a8de56fad71db42f4ad120eb7eff0=
3b51f:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 Merge tag &#39;pull-tcg-20241013&#39; of <a href=3D"https=
://gitlab.com/rth7680/qemu" rel=3D"noreferrer" target=3D"_blank">https://gi=
tlab.com/rth7680/qemu</a> into staging (2024-10-14 11:12:34 +0100)<br>
&gt; <br>
&gt; are available in the Git repository at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://gitlab.com/marcandre.lureau/qemu.git" =
rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/marcandre.lureau/qe=
mu.git</a> tags/ui-pull-request<br>
&gt; <br>
&gt; for you to fetch changes up to 4cd78a3db2478d3c1527905a26c9d3fbee83cca=
c:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 audio/pw: Report more accurate error when connecting to P=
ipeWire fails (2024-10-14 17:35:24 +0400)<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; UI-related fixes &amp; shareable 2d memory with -display dbus<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; <br>
&gt; Marc-Andr=C3=A9 Lureau (19):<br>
&gt;=C2=A0 =C2=A0 hw/audio/hda: free timer on exit<br>
&gt;=C2=A0 =C2=A0 hw/audio/hda: fix memory leak on audio setup<br>
&gt;=C2=A0 =C2=A0 ui/dbus: fix leak on message filtering<br>
&gt;=C2=A0 =C2=A0 ui/win32: fix potential use-after-free with dbus shared m=
emory<br>
&gt;=C2=A0 =C2=A0 ui/dbus: fix filtering all update messages<br>
&gt;=C2=A0 =C2=A0 ui/dbus: discard display messages on disable<br>
&gt;=C2=A0 =C2=A0 ui/dbus: discard pending CursorDefine on new one<br>
&gt;=C2=A0 =C2=A0 util/memfd: report potential errors on free<br>
&gt;=C2=A0 =C2=A0 ui/pixman: generalize shared_image_destroy<br>
&gt;=C2=A0 =C2=A0 ui/dbus: do not limit to one listener per connection / bu=
s name<br>
&gt;=C2=A0 =C2=A0 ui/dbus: add trace for can_share_map<br>
&gt;=C2=A0 =C2=A0 ui/surface: allocate shared memory on !win32<br>
&gt;=C2=A0 =C2=A0 meson: find_program(&#39;gdbus-codegen&#39;) directly<br>
&gt;=C2=A0 =C2=A0 ui/dbus: make Listener.Win32.Map win32-specific<br>
&gt;=C2=A0 =C2=A0 ui/dbus: add Listener.Unix.Map interface XML<br>
&gt;=C2=A0 =C2=A0 ui/dbus: implement Unix.Map<br>
&gt;=C2=A0 =C2=A0 virtio-gpu: allocate shareable 2d resources on !win32<br>
&gt;=C2=A0 =C2=A0 ui: refactor using a common qemu_pixman_shareable<br>
&gt;=C2=A0 =C2=A0 tests: add basic -display dbus Map.Unix test<br>
&gt; <br>
&gt; Michal Privoznik (1):<br>
&gt;=C2=A0 =C2=A0 audio/pw: Report more accurate error when connecting to P=
ipeWire fails<br>
<br>
Or, actually, here (I replied to a wrong thread) -- is there something<br>
for qemu-stable in there?=C2=A0 First 7 changes seems to be good fit there.=
<br clear=3D"all"></blockquote><div><br></div><div>Or only the first 5. It =
would be nice to have a second look before!</div><div><br></div><div>thanks=
<br></div></div><br><span class=3D"gmail_signature_prefix">-- </span><br><d=
iv dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></=
div>

--0000000000008e8cd00624924287--

