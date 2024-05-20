Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484E4C25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 23:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9COo-0002Uh-Fa; Mon, 20 May 2024 19:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9COm-0002TQ-8Q
 for qemu-devel@nongnu.org; Mon, 20 May 2024 19:26:32 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s9COg-0008KG-LL
 for qemu-devel@nongnu.org; Mon, 20 May 2024 19:26:32 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7f15c0296d9so1352227241.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716247585; x=1716852385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YYYoeliG940T/PafTFjh9YVwhwrairAtRUb4lIJbVCM=;
 b=fCB6bQng26Z0BQgNhZtUlUwdCsAz7cqhfYt3vXDdVecCkFoE0bf2i7DDm40+0oWzrv
 e0h4UH9mLTjlqYt9732E4NluxARYEZsuOlM1ANEARKF4lYXl9E9F07r+u/gEiVjwSiZX
 d0dtSGbpU4XvF10IJDaSlo1wBrRTitkA6lO61lUicmDMz5GrL9jhp2cv0trB+TxZZepB
 PQRBNjZ3tVHDD+3VKKcay7vJ2cxrY8cqJWAbRGBscJcc2YgMJzD3bYK5ivfT1EUNCLqF
 MQ8q6azeFnJk/7VD1qeRqvw06sMl3nnQhOILQ3kQHfyASCmZs0ULm4gvO0u4pd6zMbxW
 tTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716247585; x=1716852385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYYoeliG940T/PafTFjh9YVwhwrairAtRUb4lIJbVCM=;
 b=jceS35jDs41wTXuYF+Re2XRTwNSAitshj1yiIKleyOLxZpSUy7wpodR7l7ttYINSEv
 tAutuFakUJ49tLnpnjUvVd2Fgd6lY1V0LnTmwV+pMJpRNp/YiiNxDyHNq6B/rJM+aQ0l
 WZHlmVif9XoFZafSnGv+v191mlMhCP9lI2/g5uCVYzg/ISbJRpZZV1zar4O07D7YdLbs
 XJ8wf2M2FKZpwhfkP7kSF5f1KXpfzyYXlw2dysjtHeQjnW9OVBn2Jy3kOJhg8IihYQqT
 905boGHFH5smGUor4DPy3sqd90q1lhlsxaUjs6fCbGNSxkvMAE05iJLD5awbKlqh3hJZ
 2NJQ==
X-Gm-Message-State: AOJu0YyAAfeMFMUgUOTu1/IjXaOSd9un6gsUgXSjMUVfaWxkt/YMLQGm
 Kv59ZqCnw/v788YFSRVz1/wzlJ1T9QoGncxu/ofK5Cj+hnOKNfFtd3/oJKx69PIS6QeHN7UU3lB
 xUjrqzD/RPRWVCuOqAsIj2IkkxC/3lA==
X-Google-Smtp-Source: AGHT+IEox2s/EV4CwUqmy25yFHmxzvFD48+r3Kn+W7d16Rpn0p+m39krtiIQB8bzq0oUVlXPDKhvd89rKbXi5ZakjiQ=
X-Received: by 2002:a05:6102:2ad0:b0:47e:cdce:b760 with SMTP id
 ada2fe7eead31-48077e8407dmr31373059137.22.1716247584942; Mon, 20 May 2024
 16:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232434.317879-1-dmamfmgm@gmail.com>
In-Reply-To: <20240520232434.317879-1-dmamfmgm@gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Mon, 20 May 2024 18:26:13 -0500
Message-ID: <CACBuX0Q-xHsgEEN5jkVDO_tmFtprKigVvfDJw3nRFTLPA1xd+A@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daude <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a5b0a30618eb070a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000a5b0a30618eb070a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 6:24=E2=80=AFPM David Hubbard <dmamfmgm@gmail.com> =
wrote:

> From: Cord Amfmgm <dmamfmgm@gmail.com>
>
> This changes the way the ohci emulation handles a Transfer Descriptor wit=
h
> "Current Buffer Pointer" set to "Buffer End" + 1.
>

Please disregard, this patch is no different from the previous one sent a
couple weeks ago. Resending...


>
> The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than
> td.be
> to signal the buffer has zero length. Currently qemu only accepts
> zero-length
> Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI
> hardware
> accepts both cases.
>
> The qemu ohci emulation has a regression in ohci_service_td. Version 4.2
> and earlier matched the spec. (I haven't taken the time to bisect exactly
> where the logic was changed.)
>
> With a tiny OS[1] that boots and executes a test, the issue can be seen:
>
> * OS that sends USB requests to a USB mass storage device
>   but sends td.cbp =3D td.be + 1
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
> Tip: if the flags "-serial pty -serial stdio" are added to the command li=
ne
> the test will output USB requests like this:
>
> Testing qemu HEAD:
>
> > Free mem 2M ohci port2 conn FS
> > setup { 80 6 0 1 0 0 8 0 }
> > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920
> >   td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc20907
> >   td1 c20960 nxt=3Dc20980 f3140000    in cbp=3Dc20908 be=3Dc2090f
> >   td2 c20980 nxt=3Dc20920 f3080000   out cbp=3Dc20910 be=3Dc2090f ohci2=
0 host
> err
> > usb stopped
>
> And in qemu.log:
>
> usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 >
> next_offset=3D0x00c2090f
>
> Testing qemu 4.2:
>
> > Free mem 2M ohci port2 conn FS
> > setup { 80 6 0 1 0 0 8 0 }
> > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920
> >   td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907      =
 cbp=3D0
> be=3D620907
> >   td1 620960 nxt=3D620980 f3140000    in cbp=3D620908 be=3D62090f      =
 cbp=3D0
> be=3D62090f
> >   td2 620980 nxt=3D620920 f3080000   out cbp=3D620910 be=3D62090f      =
 cbp=3D0
> be=3D62090f
> >    rx { 12 1 0 2 0 0 0 8 }
> > setup { 0 5 1 0 0 0 0 0 } tx {}
> > ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880
> >   td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D620907      =
 cbp=3D0
> be=3D620907
> >   td1 620960 nxt=3D620880 f3100000    in cbp=3D620908 be=3D620907      =
 cbp=3D0
> be=3D620907
> > setup { 80 6 0 1 0 0 12 0 }
> > ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960
> >   td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D620927      =
 cbp=3D0
> be=3D620927
> >   td1 6209c0 nxt=3D6209e0 f3140000    in cbp=3D620928 be=3D620939      =
 cbp=3D0
> be=3D620939
> >   td2 6209e0 nxt=3D620960 f3080000   out cbp=3D62093a be=3D620939      =
 cbp=3D0
> be=3D620939
> >    rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }
> > setup { 80 6 0 2 0 0 0 1 }
> > ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880
> >   td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D620a27      =
 cbp=3D0
> be=3D620a27
> >   td1 6209a0 nxt=3D6209c0 f3140004    in cbp=3D620a28 be=3D620b27
>  cbp=3D620a48 be=3D620b27
> >   td2 6209c0 nxt=3D620880 f3080000   out cbp=3D620b28 be=3D620b27      =
 cbp=3D0
> be=3D620b27
> >    rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0 0 7 5 2 2
> 40 0 0 }
> > setup { 0 9 1 0 0 0 0 0 } tx {}
> > ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900
> >   td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D620a07      =
 cbp=3D0
> be=3D620a07
> >   td1 620940 nxt=3D620900 f3100000    in cbp=3D620a08 be=3D620a07      =
 cbp=3D0
> be=3D620a07
>
> [1] The OS disk image has been emailed to philmd@linaro.org,
> mjt@tls.msk.ru,
> and kraxel@redhat.com:
>
> * testCbpOffBy1.img.xz
> * sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abe=
d
>
> Signed-off-by: Cord Amfmgm <dmamfmgm@gmail.com>
> ---
>  hw/usb/hcd-ohci.c   | 4 ++--
>  hw/usb/trace-events | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index acd6016980..86caf5e43b 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> ohci_ed *ed)
>          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
>              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>          } else {
> -            if (td.cbp > td.be) {
> -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> +            if (td.cbp > td.be + 1) {
> +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
>                  ohci_die(ohci);
>                  return 1;
>              }
> diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> index fd7b90d70c..fe282e7876 100644
> --- a/hw/usb/trace-events
> +++ b/hw/usb/trace-events
> @@ -29,6 +29,7 @@ usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d=
"
>  usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
>  usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
>  usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad pid
> %s: ed.flags 0x%x td.flags 0x%x"
> +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp =3D 0x%x > be =
=3D
> 0x%x"
>  usb_ohci_port_attach(int index) "port #%d"
>  usb_ohci_port_detach(int index) "port #%d"
>  usb_ohci_port_wakeup(int index) "port #%d"
> --
> 2.34.1
>
>

--000000000000a5b0a30618eb070a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, May 20, 2024 at 6:24=E2=80=AFPM D=
avid Hubbard &lt;<a href=3D"mailto:dmamfmgm@gmail.com">dmamfmgm@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fr=
om: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=3D"_blank"=
>dmamfmgm@gmail.com</a>&gt;<br>
<br>
This changes the way the ohci emulation handles a Transfer Descriptor with<=
br>
&quot;Current Buffer Pointer&quot; set to &quot;Buffer End&quot; + 1.<br></=
blockquote><div><br></div><div>Please disregard, this patch is no different=
 from the previous one sent a couple weeks ago. Resending...</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The OHCI spec 4.3.1.2 Table 4-2 allows td.cbp to be one byte more than <a h=
ref=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a><br>
to signal the buffer has zero length. Currently qemu only accepts zero-leng=
th<br>
Transfer Descriptors if the td.cbp is equal to 0, while actual OHCI hardwar=
e<br>
accepts both cases.<br>
<br>
The qemu ohci emulation has a regression in ohci_service_td. Version 4.2<br=
>
and earlier matched the spec. (I haven&#39;t taken the time to bisect exact=
ly<br>
where the logic was changed.)<br>
<br>
With a tiny OS[1] that boots and executes a test, the issue can be seen:<br=
>
<br>
* OS that sends USB requests to a USB mass storage device<br>
=C2=A0 but sends td.cbp =3D <a href=3D"http://td.be" rel=3D"noreferrer" tar=
get=3D"_blank">td.be</a> + 1<br>
* qemu 4.2<br>
* qemu HEAD (4e66a0854)<br>
* Actual OHCI controller (hardware)<br>
<br>
Command line:<br>
qemu-system-x86_64 -m 20 \<br>
=C2=A0-device pci-ohci,id=3Dohci \<br>
=C2=A0-drive if=3Dnone,format=3Draw,id=3Dd,file=3Dtestmbr.raw \<br>
=C2=A0-device usb-storage,bus=3Dohci.0,drive=3Dd \<br>
=C2=A0--trace &quot;usb_*&quot; --trace &quot;ohci_*&quot; -D qemu.log<br>
<br>
Results are:<br>
<br>
=C2=A0qemu 4.2=C2=A0 =C2=A0| qemu HEAD=C2=A0 | actual HW<br>
------------+------------+------------<br>
=C2=A0works fine | ohci_die() | works fine<br>
<br>
Tip: if the flags &quot;-serial pty -serial stdio&quot; are added to the co=
mmand line<br>
the test will output USB requests like this:<br>
<br>
Testing qemu HEAD:<br>
<br>
&gt; Free mem 2M ohci port2 conn FS<br>
&gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3Dc20920<br>
&gt;=C2=A0 =C2=A0td0 c20880 nxt=3Dc20960 f2000000 setup cbp=3Dc20900 be=3Dc=
20907<br>
&gt;=C2=A0 =C2=A0td1 c20960 nxt=3Dc20980 f3140000=C2=A0 =C2=A0 in cbp=3Dc20=
908 be=3Dc2090f<br>
&gt;=C2=A0 =C2=A0td2 c20980 nxt=3Dc20920 f3080000=C2=A0 =C2=A0out cbp=3Dc20=
910 be=3Dc2090f ohci20 host err<br>
&gt; usb stopped<br>
<br>
And in qemu.log:<br>
<br>
usb_ohci_iso_td_bad_cc_overrun ISO_TD start_offset=3D0x00c20910 &gt; next_o=
ffset=3D0x00c2090f<br>
<br>
Testing qemu 4.2:<br>
<br>
&gt; Free mem 2M ohci port2 conn FS<br>
&gt; setup { 80 6 0 1 0 0 8 0 }<br>
&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620920<br>
&gt;=C2=A0 =C2=A0td0 620880 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D6=
20907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620980 f3140000=C2=A0 =C2=A0 in cbp=3D620=
908 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt;=C2=A0 =C2=A0td2 620980 nxt=3D620920 f3080000=C2=A0 =C2=A0out cbp=3D620=
910 be=3D62090f=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D62090f<br>
&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 }<br>
&gt; setup { 0 5 1 0 0 0 0 0 } tx {}<br>
&gt; ED info=3D80000 { mps=3D8 en=3D0 d=3D0 } tail=3D620880<br>
&gt;=C2=A0 =C2=A0td0 620920 nxt=3D620960 f2000000 setup cbp=3D620900 be=3D6=
20907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt;=C2=A0 =C2=A0td1 620960 nxt=3D620880 f3100000=C2=A0 =C2=A0 in cbp=3D620=
908 be=3D620907=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620907<br>
&gt; setup { 80 6 0 1 0 0 12 0 }<br>
&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620960<br>
&gt;=C2=A0 =C2=A0td0 620880 nxt=3D6209c0 f2000000 setup cbp=3D620920 be=3D6=
20927=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620927<br>
&gt;=C2=A0 =C2=A0td1 6209c0 nxt=3D6209e0 f3140000=C2=A0 =C2=A0 in cbp=3D620=
928 be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt;=C2=A0 =C2=A0td2 6209e0 nxt=3D620960 f3080000=C2=A0 =C2=A0out cbp=3D620=
93a be=3D620939=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620939<br>
&gt;=C2=A0 =C2=A0 rx { 12 1 0 2 0 0 0 8 f4 46 1 0 0 0 1 2 3 1 }<br>
&gt; setup { 80 6 0 2 0 0 0 1 }<br>
&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620880<br>
&gt;=C2=A0 =C2=A0td0 620960 nxt=3D6209a0 f2000000 setup cbp=3D620a20 be=3D6=
20a27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a27<br>
&gt;=C2=A0 =C2=A0td1 6209a0 nxt=3D6209c0 f3140004=C2=A0 =C2=A0 in cbp=3D620=
a28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D620a48 be=3D620b27<br>
&gt;=C2=A0 =C2=A0td2 6209c0 nxt=3D620880 f3080000=C2=A0 =C2=A0out cbp=3D620=
b28 be=3D620b27=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620b27<br>
&gt;=C2=A0 =C2=A0 rx { 9 2 20 0 1 1 4 c0 0 9 4 0 0 2 8 6 50 0 7 5 81 2 40 0=
 0 7 5 2 2 40 0 0 }<br>
&gt; setup { 0 9 1 0 0 0 0 0 } tx {}<br>
&gt; ED info=3D80001 { mps=3D8 en=3D0 d=3D1 } tail=3D620900<br>
&gt;=C2=A0 =C2=A0td0 620880 nxt=3D620940 f2000000 setup cbp=3D620a00 be=3D6=
20a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
&gt;=C2=A0 =C2=A0td1 620940 nxt=3D620900 f3100000=C2=A0 =C2=A0 in cbp=3D620=
a08 be=3D620a07=C2=A0 =C2=A0 =C2=A0 =C2=A0cbp=3D0 be=3D620a07<br>
<br>
[1] The OS disk image has been emailed to <a href=3D"mailto:philmd@linaro.o=
rg" target=3D"_blank">philmd@linaro.org</a>, <a href=3D"mailto:mjt@tls.msk.=
ru" target=3D"_blank">mjt@tls.msk.ru</a>,<br>
and <a href=3D"mailto:kraxel@redhat.com" target=3D"_blank">kraxel@redhat.co=
m</a>:<br>
<br>
* testCbpOffBy1.img.xz<br>
* sha256: f87baddcb86de845de12f002c698670a426affb40946025cc32694f9daa3abed<=
br>
<br>
Signed-off-by: Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com" target=
=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/usb/hcd-ohci.c=C2=A0 =C2=A0| 4 ++--<br>
=C2=A0hw/usb/trace-events | 1 +<br>
=C2=A02 files changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c<br>
index acd6016980..86caf5e43b 100644<br>
--- a/hw/usb/hcd-ohci.c<br>
+++ b/hw/usb/hcd-ohci.c<br>
@@ -941,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct ohci=
_ed *ed)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((td.cbp &amp; 0xfffff000) !=3D (<a hr=
ef=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0x=
fffff000)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D (<a href=3D"http://=
td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0xfff) + 0x1001=
 - (td.cbp &amp; 0xfff);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"http:=
//td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_iso=
_td_bad_cc_overrun(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer" targ=
et=3D"_blank">td.be</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"http:=
//td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> + 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_td_=
bad_buf(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blan=
k">td.be</a>);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ohci_die(ohci=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/usb/trace-events b/hw/usb/trace-events<br>
index fd7b90d70c..fe282e7876 100644<br>
--- a/hw/usb/trace-events<br>
+++ b/hw/usb/trace-events<br>
@@ -29,6 +29,7 @@ usb_ohci_iso_td_data_underrun(int ret) &quot;DataUnderrun=
 %d&quot;<br>
=C2=A0usb_ohci_iso_td_nak(int ret) &quot;got NAK/STALL %d&quot;<br>
=C2=A0usb_ohci_iso_td_bad_response(int ret) &quot;Bad device response %d&qu=
ot;<br>
=C2=A0usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) &quot;=
Bad pid %s: ed.flags 0x%x td.flags 0x%x&quot;<br>
+usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) &quot;Bad cbp =3D 0x%x &gt;=
 be =3D 0x%x&quot;<br>
=C2=A0usb_ohci_port_attach(int index) &quot;port #%d&quot;<br>
=C2=A0usb_ohci_port_detach(int index) &quot;port #%d&quot;<br>
=C2=A0usb_ohci_port_wakeup(int index) &quot;port #%d&quot;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000a5b0a30618eb070a--

