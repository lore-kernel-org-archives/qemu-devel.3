Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC0FC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 17:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHRbb-00054d-80; Wed, 12 Jun 2024 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sHRbZ-00054S-Mw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 13:17:49 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1sHRbV-0007e0-1A
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 13:17:47 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d229826727so1961341b6e.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718212663; x=1718817463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N7ydFsLyGT1rX+bTNHeKSoHghDvJRwQkjtZYMo9/JcU=;
 b=TDTT/tPvaov1qtjQq3w6COcdy4SNCaZ4Cm/u5YNnn6r+QlDfCQ6IkGZCtQhqMu/T12
 ICjtE832igMAKaXdmAsr/qXjmRbKgpnjZYHe8u6yuTzRL/IbMkbWZWOC6mRVErN72t6G
 0o//2RNOG5X3NDpQ/p33r+OZYzVS/ljsDr9YN5QHtn0+cDJdFm3guO1sOqjx7hu53vyJ
 YUMmBd93uHwcjpHgpaAyFlgnnqsoi9+dr5JNBhDjPxO3HkhjAdpaIAH+443w+voDUuh0
 cJ5YImxRH5EZVbZHQAQoWFEEfgS9bJnBK4HVQEzArCRmNuMJVHO0ak0johVcN9C9GOfY
 77MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718212663; x=1718817463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N7ydFsLyGT1rX+bTNHeKSoHghDvJRwQkjtZYMo9/JcU=;
 b=kZzBWAFO0TiGKBdZaMTGWlFtRmD1druHiAqc43uiYfDK3c9Fqz0ATtbjOasFyc2lQj
 hq0oCWBxYaHUs9R/C7ieQ0apE5BU/rjhLTunPQsChAUhn6Q/X+aOoSsU1BuWi/fNYKEs
 QGb2HwqzTJHrJ1qzxsQUjn8aloxpL66iy4B9GJ0tCVpXnLH47gyNCO/r8twqK7C44pyc
 F0oPi+OGJ4SZaMnNrsvDm29+3qAZkKzBJpShB0eVftL1PGLIqlOhQdieWaXH6iQX5Rmy
 KR8dWOWz1rtNzX68wmY/K4HxVMR2fTAGkxas2vRd9q6iv0gweBp1y9lStidb8LEc/diZ
 88Vw==
X-Gm-Message-State: AOJu0Ywd3lWoCBp5E5ajZrxxUomKkDhDqloH9+FIFOWz2KQrCmznm4N7
 8PeHpZDARb35DRf9dy5lJNe0bwKV7mAaderw5FYMIhKEWIjBciuD3WNUf6ne189zFc+114CCmfm
 KCIPXs3zqGESpNycFadFR6RivhYE=
X-Google-Smtp-Source: AGHT+IEEIWdi+0SQ6dhtIJJ6UuOvXUaQydv1gDAow5mAs4Xdd1Ehv/alXk4ggYoHW+tW3Z03PDGcZ7Eitl/dvxumDek=
X-Received: by 2002:a05:6808:1156:b0:3d2:157c:23f4 with SMTP id
 5614622812f47-3d23e0cfc88mr3000702b6e.55.1718212661694; Wed, 12 Jun 2024
 10:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <87cyomxmvc.fsf@draig.linaro.org>
In-Reply-To: <87cyomxmvc.fsf@draig.linaro.org>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Wed, 12 Jun 2024 12:17:30 -0500
Message-ID: <CACBuX0SMvD6+vWGBv_m0rBnwgp8fbv6rHKUmbr-MWDLknz8LyA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Philippe Mathieu-Daude <philmd@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000595767061ab48f15"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=dmamfmgm@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000595767061ab48f15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 9:21=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> David Hubbard <dmamfmgm@gmail.com> writes:
>
> > From: Cord Amfmgm <dmamfmgm@gmail.com>
> >
> > This changes the way the ohci emulation handles a Transfer Descriptor
> with
> > "Current Buffer Pointer" set to "Buffer End" + 1.
> >
> > The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than
> td.be
> > to signal the buffer has zero length. Currently qemu only accepts
> zero-length
> > Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI
> hardware
> > accepts both cases.
> >
> > The qemu ohci emulation has a regression in ohci_service_td. Version 4.=
2
> > and earlier matched the spec. (I haven't taken the time to bisect exact=
ly
> > where the logic was changed.)
>
> I find it hard to characterise this as a regression because we've
> basically gone from no checks to actually doing bounds checks:
>
>   1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)
>
> The argument here seems to be that real hardware is laxer than the specs
> in what it accepts.
>
> > With a tiny OS[1] that boots and executes a test, the issue can be seen=
:
> >
> > * OS that sends USB requests to a USB mass storage device
> >   but sends td.cbp =3D td.be + 1
> > * qemu 4.2
> > * qemu HEAD (4e66a0854)
> > * Actual OHCI controller (hardware)
> >
> > Command line:
> > qemu-system-x86_64 -m 20 \
> >  -device pci-ohci,id=3Dohci \
> >  -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \
> >  -device usb-storage,bus=3Dohci.0,drive=3Dd \
> >  --trace "usb_*" --trace "ohci_*" -D qemu.log
> >
> > Results are:
> >
> >  qemu 4.2   | qemu HEAD  | actual HW
> > ------------+------------+------------
> >  works fine | ohci_die() | works fine
> >
> > Tip: if the flags "-serial pty -serial stdio" are added to the command
> line
> > the test will output USB requests like this:
> >
> > Testing qemu HEAD:
> >
> >> Free mem 2M ohci port2 conn FS
> >> setup { 80 6 0 1 0 0 8 0 }
> >> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
> >>   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
> >>   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
> >>   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3Dc20910 be=3Dc2090f ohci=
20 host
> err
> >> usb stopped
> >
> > And in qemu.log:
> >
> > usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 >
> next_offset=3D0x00c2090f
> >
> > Testing qemu 4.2:
> >
> >> Free mem 2M ohci port2 conn FS
> >> setup { 80 6 0 1 0 0 8 0 }
> >> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920
> >>   td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907     =
  cbp=3D0
> be=3D620907
> >>   td1 620960 nxt=3D620980 f3140000    in cbp=3D620908 be=3D62090f     =
  cbp=3D0
> be=3D62090f
> >>   td2 620980 nxt=3D620920 f3080000   out cbp=3D620910 be=3D62090f     =
  cbp=3D0
> be=3D62090f
> >>    rx { 12 1 0 2 0 0 0 8 }
> >> setup { 0 5 1 0 0 0 0 0 } tx {}
> >> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880
> >>   td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907     =
  cbp=3D0
> be=3D620907
> >>   td1 620960 nxt=3D620880 f3100000    in cbp=3D620908 be=3D620907     =
  cbp=3D0
> be=3D620907
> >> setup { 80 6 0 1 0 0 12 0 }
> >> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960
> >>   td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D620927     =
  cbp=3D0
> be=3D620927
> >>   td1 6209c0 nxt=3D6209e0 f3140000    in cbp=3D620928 be=3D620939     =
  cbp=3D0
> be=3D620939
> >>   td2 6209e0 nxt=3D620960 f3080000   out cbp=3D62093a be=3D620939     =
  cbp=3D0
> be=3D620939
> >>    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
> >> setup { 80 6 0 2 0 0 0 1 }
> >> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880
> >>   td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D620a27     =
  cbp=3D0
> be=3D620a27
> >>   td1 6209a0 nxt=3D6209c0 f3140004    in cbp=3D620a28 be=3D620b27
>  cbp=3D620a48 be=3D620b27
> >>   td2 6209c0 nxt=3D620880 f3080000   out cbp=3D620b28 be=3D620b27     =
  cbp=3D0
> be=3D620b27
> >>    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 2
> 40 0 0 }
> >> setup { 0 9 1 0 0 0 0 0 } tx {}
> >> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900
> >>   td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07     =
  cbp=3D0
> be=3D620a07
> >>   td1 620940 nxt=3D620900 f3100000    in cbp=3D620a08 be=3D620a07     =
  cbp=3D0
> be=3D620a07
> >
> > [1] The OS disk image has been emailed to philmd@linaro.org,
> mjt@tls.msk.ru,
> > and kraxel@redhat.com:
> >
> > * testCbpOffBy1.img.xz
> > * sha256:
> f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed
> >
> > Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
> > ---
> >  hw/usb/hcd-ohci.c   | 4 ++--
> >  hw/usb/trace-events | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> > index acd6016980..71b54914d3 100644
> > --- a/hw/usb/hcd-ohci.c
> > +++ b/hw/usb/hcd-ohci.c
> > @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> ohci_ed *ed)
> >          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
> >              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
> >          } else {
> > -            if (td.cbp > td.be) {
> > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> > +            if (td.cbp - 1 > td.be) {  /* rely on td.cbp !=3D 0 */
> > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
> >                  ohci_die(ohci);
> >                  return 1;
> >              }
>
> With the updated commit message:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>

Please forgive my lack of experience on this mailing list. I don't see a
suggested commit message from Alex but in case that was what is being
considered, here is one. Feedback welcome, also if this is not what is
wanted, please just say it.

> From: Cord Amfmgm <dmamfmgm@gmail.com>
>
> This changes the way the ohci emulation handles a Transfer Descriptor wit=
h
> "Buffer End" set to "Current Buffer Pointer" - 1, specifically in the
case of a
> zero-length packet.
>
> The OHCI spec 4.3.1.2 Table 4-2 specifies td.cbp to be zero for a
zero-length
> packet. Peter Maydell tracked down commit
> 1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)
> where qemu started checking this according to the spec.
>
> What this patch does is loosen the qemu ohci implementation to allow a
> zero-length packet if td.be (Buffer End) is set to td.cbp - 1, and with a
> non-zero td.cbp value.
>
> Is this correct? It appears to not follow the spec, so no. But actual hw
> seems to be ok with it.
>
> Does any OS rely on this behavior? There have been no reports to
> qemu-devel of this problem.
>
> This is attempting to have qemu behave like actual hardware,
> but this is just a minor change.
>
> With a tiny OS[1] that boots and executes a test, the behavior is
> reproducible:
>
> * OS that sends USB requests to a USB mass storage device
>   but sends td.be =3D td.cbp - 1
> * qemu 4.2
> * qemu HEAD (4e66a0854)
> * Actual OHCI controller (hardware)
>
> Command line:
> qemu-system-x86_64 -m 20 \
>  -device pci-ohci,id=3Dohci \
>  -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \
>  -device usb-storage,bus=3Dohci.0,drive=3Dd \
>  --trace "usb_*" --trace "ohci_*" -D qemu.log
>
> Results are:
>
>  qemu 4.2   | qemu HEAD  | actual HW
> ------------+------------+------------
>  works fine | ohci_die() | works fine
>
> Tip: if the flags "-serial pty -serial stdio" are added to the command
line
> the test will output USB requests like this:
>
> Testing qemu HEAD:
>
>> Free mem 2M ohci port2 conn FS
>> setup { 80 6 0 1 0 0 8 0 }
>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
>>   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
>>   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
>>   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3Dc20910 be=3Dc2090f ohci20=
 host
err
>> usb stopped
>
> And in qemu.log:
>
> usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 >
next_offset=3D0x00c2090f
>
> Testing qemu 4.2:
>
>> Free mem 2M ohci port2 conn FS
>> setup { 80 6 0 1 0 0 8 0 }
>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920
>>   td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907       =
cbp=3D0
be=3D620907
>>   td1 620960 nxt=3D620980 f3140000    in cbp=3D620908 be=3D62090f       =
cbp=3D0
be=3D62090f
>>   td2 620980 nxt=3D620920 f3080000   out cbp=3D620910 be=3D62090f       =
cbp=3D0
be=3D62090f
>>    rx { 12 1 0 2 0 0 0 8 }
>> setup { 0 5 1 0 0 0 0 0 } tx {}
>> ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880
>>   td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907       =
cbp=3D0
be=3D620907
>>   td1 620960 nxt=3D620880 f3100000    in cbp=3D620908 be=3D620907       =
cbp=3D0
be=3D620907
>> setup { 80 6 0 1 0 0 12 0 }
>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960
>>   td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D620927       =
cbp=3D0
be=3D620927
>>   td1 6209c0 nxt=3D6209e0 f3140000    in cbp=3D620928 be=3D620939       =
cbp=3D0
be=3D620939
>>   td2 6209e0 nxt=3D620960 f3080000   out cbp=3D62093a be=3D620939       =
cbp=3D0
be=3D620939
>>    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
>> setup { 80 6 0 2 0 0 0 1 }
>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880
>>   td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D620a27       =
cbp=3D0
be=3D620a27
>>   td1 6209a0 nxt=3D6209c0 f3140004    in cbp=3D620a28 be=3D620b27
 cbp=3D620a48 be=3D620b27
>>   td2 6209c0 nxt=3D620880 f3080000   out cbp=3D620b28 be=3D620b27       =
cbp=3D0
be=3D620b27
>>    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 2
40 0 0 }
>> setup { 0 9 1 0 0 0 0 0 } tx {}
>> ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900
>>   td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07       =
cbp=3D0
be=3D620a07
>>   td1 620940 nxt=3D620900 f3100000    in cbp=3D620a08 be=3D620a07       =
cbp=3D0
be=3D620a07
>
> [1] The OS disk image has been emailed to philmd@linaro.org,
mjt@tls.msk.ru,
> and kraxel@redhat.com:
>
> * testCbpOffBy1.img.xz
> * sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abe=
d
>
> Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>

--000000000000595767061ab48f15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 12, 2024 at 9:21=E2=80=AF=
AM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.benn=
ee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">David Hubbard &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=
=3D"_blank">dmamfmgm@gmail.com</a>&gt; writes:<br>
<br>
&gt; From: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"=
_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt;<br>
&gt; This changes the way the ohci emulation handles a Transfer Descriptor =
with<br>
&gt; &quot;Current Buffer Pointer&quot; set to &quot;Buffer End&quot; + 1.<=
br>
&gt;<br>
&gt; The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than=
 <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a><br=
>
&gt; to signal the buffer has zero length. Currently qemu only accepts zero=
-length<br>
&gt; Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI ha=
rdware<br>
&gt; accepts both cases.<br>
&gt;<br>
&gt; The qemu ohci emulation has a regression in ohci_service_td. Version 4=
.2<br>
&gt; and earlier matched the spec. (I haven&#39;t taken the time to bisect =
exactly<br>
&gt; where the logic was changed.)<br>
<br>
I find it hard to characterise this as a regression because we&#39;ve<br>
basically gone from no checks to actually doing bounds checks:<br>
<br>
=C2=A0 1328fe0c32 (hw: usb: hcd-ohci: check len and frame_number variables)=
<br>
<br>
The argument here seems to be that real hardware is laxer than the specs<br=
>
in what it accepts.<br>
<br>
&gt; With a tiny OS[1] that boots and executes a test, the issue can be see=
n:<br>
&gt;<br>
&gt; * OS that sends USB requests to a USB mass storage device<br>
&gt;=C2=A0 =C2=A0but sends td.cbp =3D <a href=3D"http://td.be" rel=3D"noref=
errer" target=3D"_blank">td.be</a> + 1<br>
&gt; * qemu 4.2<br>
&gt; * qemu HEAD (4e66a0854)<br>
&gt; * Actual OHCI controller (hardware)<br>
&gt;<br>
&gt; Command line:<br>
&gt; qemu-system-x86_64 -m 20 \<br>
&gt;=C2=A0 -device pci-ohci,id=3Dohci \<br>
&gt;=C2=A0 -drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \<br>
&gt;=C2=A0 -device usb-storage,bus=3Dohci.0,drive=3Dd \<br>
&gt;=C2=A0 --trace &quot;usb_*&quot; --trace &quot;ohci_*&quot; -D qemu.log=
<br>
&gt;<br>
&gt; Results are:<br>
&gt;<br>
&gt;=C2=A0 qemu 4.2=C2=A0 =C2=A0| qemu HEAD=C2=A0 | actual HW<br>
&gt; ------------+------------+------------<br>
&gt;=C2=A0 works fine | ohci_die() | works fine<br>
&gt;<br>
&gt; Tip: if the flags &quot;-serial pty -serial stdio&quot; are added to t=
he command line<br>
&gt; the test will output USB requests like this:<br>
&gt;<br>
&gt; Testing qemu HEAD:<br>
&gt;<br>
&gt;&gt; Free mem 2M ohci port2 conn FS<br>
&gt;&gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt;&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920<br>
&gt;&gt;=C2=A0 =C2=A0td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=
=3Dc20907<br>
&gt;&gt;=C2=A0 =C2=A0td1 c20960 nxt=3Dc20980 f3140000=C2=A0 =C2=A0 in cbp=
=3Dc20908 be=3Dc2090f<br>
&gt;&gt;=C2=A0 =C2=A0td2 c20980 nxt=3Dc20920 f3080000=C2=A0 =C2=A0out cbp=
=3Dc20910 be=3Dc2090f ohci20 host err<br>
&gt;&gt; usb stopped<br>
&gt;<br>
&gt; And in qemu.log:<br>
&gt;<br>
&gt; usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 &gt; n=
ext_offset=3D0x00c2090f<br>
&gt;<br>
&gt; Testing qemu 4.2:<br>
&gt;<br>
&gt;&gt; Free mem 2M ohci port2 conn FS<br>
&gt;&gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt;&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920<br>
&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=
=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620980 f3140000=C2=A0 =C2=A0 in cbp=
=3D620908 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt;&gt;=C2=A0 =C2=A0td2 620980 nxt=3D620920 f3080000=C2=A0 =C2=A0out cbp=
=3D620910 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt;&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 }<br>
&gt;&gt; setup { 0 5 1 0 0 0 0 0 } tx {}<br>
&gt;&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880<br>
&gt;&gt;=C2=A0 =C2=A0td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=
=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620880 f3100000=C2=A0 =C2=A0 in cbp=
=3D620908 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;&gt; setup { 80 6 0 1 0 0 12 0 }<br>
&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960<br>
&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=
=3D620927=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620927<br>
&gt;&gt;=C2=A0 =C2=A0td1 6209c0 nxt=3D6209e0 f3140000=C2=A0 =C2=A0 in cbp=
=3D620928 be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt;&gt;=C2=A0 =C2=A0td2 6209e0 nxt=3D620960 f3080000=C2=A0 =C2=A0out cbp=
=3D62093a be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt;&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }<br>
&gt;&gt; setup { 80 6 0 2 0 0 0 1 }<br>
&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880<br>
&gt;&gt;=C2=A0 =C2=A0td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=
=3D620a27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a27<br>
&gt;&gt;=C2=A0 =C2=A0td1 6209a0 nxt=3D6209c0 f3140004=C2=A0 =C2=A0 in cbp=
=3D620a28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D620a48 be=3D620b27<br=
>
&gt;&gt;=C2=A0 =C2=A0td2 6209c0 nxt=3D620880 f3080000=C2=A0 =C2=A0out cbp=
=3D620b28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620b27<br>
&gt;&gt;=C2=A0 =C2=A0 rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 =
40 0 0 7 5 2 2 40 0 0 }<br>
&gt;&gt; setup { 0 9 1 0 0 0 0 0 } tx {}<br>
&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900<br>
&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=
=3D620a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
&gt;&gt;=C2=A0 =C2=A0td1 620940 nxt=3D620900 f3100000=C2=A0 =C2=A0 in cbp=
=3D620a08 be=3D620a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
&gt;<br>
&gt; [1] The OS disk image has been emailed to <a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>, <a href=3D"mailto:mjt@tls=
.msk.ru" target=3D"_blank">mjt@tls.msk.ru</a>,<br>
&gt; and <a href=3D"mailto:kraxel@redhat.com" target=3D"_blank">kraxel@redh=
at.com</a>:<br>
&gt;<br>
&gt; * testCbpOffBy1.img.xz<br>
&gt; * sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3=
abed<br>
&gt;<br>
&gt; Signed-off-by: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" t=
arget=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/usb/hcd-ohci.c=C2=A0 =C2=A0| 4 ++--<br>
&gt;=C2=A0 hw/usb/trace-events | 1 +<br>
&gt;=C2=A0 2 files changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c<br>
&gt; index acd6016980..71b54914d3 100644<br>
&gt; --- a/hw/usb/hcd-ohci.c<br>
&gt; +++ b/hw/usb/hcd-ohci.c<br>
&gt; @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct=
 ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((td.cbp &amp; 0xfffff000) !=3D (=
<a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &am=
p; 0xfffff000)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D (<a href=3D"ht=
tp://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0xfff) + 0=
x1001 - (td.cbp &amp; 0xfff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_iso_td_bad_cc_overrun(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer"=
 target=3D"_blank">td.be</a>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp - 1 &gt; <a href=
=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {=C2=A0 /=
* rely on td.cbp !=3D 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_td_bad_buf(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"=
_blank">td.be</a>);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ohci_die=
(ohci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
With the updated commit message:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br></blockquote><div><br>=
</div><div>Please forgive my lack of experience on this mailing list. I don=
&#39;t see a suggested commit message from Alex but in case that was what i=
s being considered, here is one. Feedback welcome, also if=C2=A0this is not=
 what is wanted,=C2=A0please just say it.</div><div><br></div><div>&gt; Fro=
m: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">=
dmamfmgm@gmail.com</a>&gt;<br>&gt;<br>&gt; This changes the way the ohci em=
ulation handles a Transfer Descriptor with<br>&gt; &quot;Buffer End&quot; s=
et to &quot;Current Buffer Pointer&quot; - 1, specifically in the case of a=
</div><div>&gt; zero-length packet.<br>&gt;<br>&gt; The OHCI spec 4.3.1.2 T=
able 4-2 specifies td.cbp to be zero for a zero-length<br>&gt; packet. Pete=
r Maydell tracked down commit<br>&gt; 1328fe0c32 (hw: usb: hcd-ohci: check =
len and frame_number variables)<br>&gt; where qemu started checking this ac=
cording to the spec.<br>&gt;<br>&gt; What this patch does is loosen the qem=
u ohci implementation to allow a</div><div>&gt; zero-length packet if <a hr=
ef=3D"http://td.be">td.be</a> (Buffer End) is set to td.cbp - 1, and with a=
</div><div>&gt; non-zero td.cbp value.</div><div>&gt;</div><div>&gt; Is thi=
s correct? It appears to not follow the spec, so no. But actual hw</div><di=
v>&gt; seems to be ok with it.</div><div>&gt;</div><div>&gt; Does any OS re=
ly=C2=A0on this behavior? There have been no reports to</div><div>&gt; qemu=
-devel of this problem.</div><div>&gt;</div><div>&gt; This is attempting to=
 have qemu behave like actual hardware,</div><div>&gt; but this is just a m=
inor change.<br>&gt;</div><div>&gt; With a tiny OS[1] that boots and execut=
es a test, the behavior is</div><div>&gt; reproducible:<br>&gt;<br>&gt; * O=
S that sends USB requests to a USB mass storage device<br>&gt;=C2=A0 =C2=A0=
but sends <a href=3D"http://td.be">td.be</a> =3D td.cbp - 1<br>&gt; * qemu =
4.2<br>&gt; * qemu HEAD (4e66a0854)<br>&gt; * Actual OHCI controller (hardw=
are)<br>&gt;<br>&gt; Command line:<br>&gt; qemu-system-x86_64 -m 20 \<br>&g=
t;=C2=A0 -device pci-ohci,id=3Dohci \<br>&gt;=C2=A0 -drive if=3Dnone,format=
=3Draw,id=3Dd,file=3Dtestmbr.raw \<br>&gt;=C2=A0 -device usb-storage,bus=3D=
ohci.0,drive=3Dd \<br>&gt;=C2=A0 --trace &quot;usb_*&quot; --trace &quot;oh=
ci_*&quot; -D qemu.log<br>&gt;<br>&gt; Results are:<br>&gt;<br>&gt;=C2=A0 q=
emu 4.2=C2=A0 =C2=A0| qemu HEAD=C2=A0 | actual HW<br>&gt; ------------+----=
--------+------------<br>&gt;=C2=A0 works fine | ohci_die() | works fine<br=
>&gt;<br>&gt; Tip: if the flags &quot;-serial pty -serial stdio&quot; are a=
dded to the command line<br>&gt; the test will output USB requests like thi=
s:<br>&gt;<br>&gt; Testing qemu HEAD:<br>&gt;<br>&gt;&gt; Free mem 2M ohci =
port2 conn FS<br>&gt;&gt; setup { 80 6 0 1 0 0 8 0 }<br>&gt;&gt; ED info=3D=
80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920<br>&gt;&gt;=C2=A0 =C2=A0td0 c2=
0880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907<br>&gt;&gt;=C2=A0=
 =C2=A0td1 c20960 nxt=3Dc20980 f3140000=C2=A0 =C2=A0 in cbp=3Dc20908 be=3Dc=
2090f<br>&gt;&gt;=C2=A0 =C2=A0td2 c20980 nxt=3Dc20920 f3080000=C2=A0 =C2=A0=
out cbp=3Dc20910 be=3Dc2090f ohci20 host err<br>&gt;&gt; usb stopped<br>&gt=
;<br>&gt; And in qemu.log:<br>&gt;<br>&gt; usb_ohci_iso_td_bad_cc_overrun I=
SO_TD start_offset=3D0x00c20910 &gt; next_offset=3D0x00c2090f<br>&gt;<br>&g=
t; Testing qemu 4.2:<br>&gt;<br>&gt;&gt; Free mem 2M ohci port2 conn FS<br>=
&gt;&gt; setup { 80 6 0 1 0 0 8 0 }<br>&gt;&gt; ED info=3D80000 { mps=3D8 e=
n=3D0 d=3D0 } tail=3D620920<br>&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D620960=
 f2000000 setup cbp=3D620900 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 =
be=3D620907<br>&gt;&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620980 f3140000=C2=A0 =
=C2=A0 in cbp=3D620908 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D6=
2090f<br>&gt;&gt;=C2=A0 =C2=A0td2 620980 nxt=3D620920 f3080000=C2=A0 =C2=A0=
out cbp=3D620910 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<=
br>&gt;&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 }<br>&gt;&gt; setup { 0 5 1 =
0 0 0 0 0 } tx {}<br>&gt;&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=
=3D620880<br>&gt;&gt;=C2=A0 =C2=A0td0 620920 nxt=3D620960 f2000000 setup cb=
p=3D620900 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>&gt=
;&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620880 f3100000=C2=A0 =C2=A0 in cbp=3D62=
0908 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>&gt;&gt; =
setup { 80 6 0 1 0 0 12 0 }<br>&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=
=3D1 } tail=3D620960<br>&gt;&gt;=C2=A0 =C2=A0td0 620880 nxt=3D6209c0 f20000=
00 setup cbp=3D620920 be=3D620927=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62=
0927<br>&gt;&gt;=C2=A0 =C2=A0td1 6209c0 nxt=3D6209e0 f3140000=C2=A0 =C2=A0 =
in cbp=3D620928 be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<b=
r>&gt;&gt;=C2=A0 =C2=A0td2 6209e0 nxt=3D620960 f3080000=C2=A0 =C2=A0out cbp=
=3D62093a be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>&gt;=
&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }<br>&gt;&gt;=
 setup { 80 6 0 2 0 0 0 1 }<br>&gt;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=
=3D1 } tail=3D620880<br>&gt;&gt;=C2=A0 =C2=A0td0 620960 nxt=3D6209a0 f20000=
00 setup cbp=3D620a20 be=3D620a27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62=
0a27<br>&gt;&gt;=C2=A0 =C2=A0td1 6209a0 nxt=3D6209c0 f3140004=C2=A0 =C2=A0 =
in cbp=3D620a28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D620a48 be=3D620=
b27<br>&gt;&gt;=C2=A0 =C2=A0td2 6209c0 nxt=3D620880 f3080000=C2=A0 =C2=A0ou=
t cbp=3D620b28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620b27<br=
>&gt;&gt;=C2=A0 =C2=A0 rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2=
 40 0 0 7 5 2 2 40 0 0 }<br>&gt;&gt; setup { 0 9 1 0 0 0 0 0 } tx {}<br>&gt=
;&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900<br>&gt;&gt;=C2=
=A0 =C2=A0td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07=
=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>&gt;&gt;=C2=A0 =C2=A0td1 =
620940 nxt=3D620900 f3100000=C2=A0 =C2=A0 in cbp=3D620a08 be=3D620a07=C2=A0=
 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>&gt;<br>&gt; [1] The OS disk im=
age has been emailed to=C2=A0<a href=3D"mailto:philmd@linaro.org" target=3D=
"_blank">philmd@linaro.org</a>,=C2=A0<a href=3D"mailto:mjt@tls.msk.ru" targ=
et=3D"_blank">mjt@tls.msk.ru</a>,<br>&gt; and=C2=A0<a href=3D"mailto:kraxel=
@redhat.com" target=3D"_blank">kraxel@redhat.com</a>:<br>&gt;<br>&gt; * tes=
tCbpOffBy1.img.xz<br>&gt; * sha256: f87baddcb86de845de12f002c698670a426affb=
40946025cc32694f9daa3abed<br>&gt;<br>&gt; Signed-off-by: Cord Amfmgm &lt;<a=
 href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a=
>&gt;<br></div><div><br></div><div><br></div></div></div>

--000000000000595767061ab48f15--

