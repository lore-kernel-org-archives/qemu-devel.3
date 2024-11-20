Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7896BD63930
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 11:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDj9Q-0008Px-RX; Wed, 20 Nov 2024 06:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDj9O-0008Pf-QA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 06:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDj9N-0008Nb-2P
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 06:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732103134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XXU5uo2qbPU7/AxikUwODjXM7iccKKg7EZPcZSU84Cc=;
 b=hVcNKRFi5nswUJCMBZVnoB2IFisRaEmxxIsl3Ni8R70och3fglG2y3D3oLgFqpcRR3Ues1
 lVgKp5RpeQuPc1NmDefWLtS1LTXOjLm0GQXASeXl0GFKktWzh8oVr0x95+FipopEK5Hop2
 onMAuYm+WJwQWcUjNTf/onOUlfTJAW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-lyeH3GIAO_yFpV4XYuOcxg-1; Wed, 20 Nov 2024 06:45:33 -0500
X-MC-Unique: lyeH3GIAO_yFpV4XYuOcxg-1
X-Mimecast-MFC-AGG-ID: lyeH3GIAO_yFpV4XYuOcxg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-381d0582ad3so3055130f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 03:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732103132; x=1732707932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXU5uo2qbPU7/AxikUwODjXM7iccKKg7EZPcZSU84Cc=;
 b=OoYqzK9bgCM1m8cJbpVOgIv1uuTaDAeiusNKhf/9l8UCS2LwXk7mLtkc98c2LqAZEz
 o61nQSuwCykV7/i8bU7fBDVcpberJR1iiXlgVP8L2mn0sH+YT718X+gbOtoalET60SOc
 AyhH9JcYBeDTTWPQPbyB3koPT0udUxSOIDe4cvtNmoHFClZBXaaVp2PPSZCH/1PVqa6P
 pbyYf733Ph3h70SLAixq6ABfQGcbNIY8qQuws9of8maN2OTPOITPi0zBYze3e1/zrsRC
 TXizVigyBNd+QCvDYumlX9O3I1Fp2+MxgwoW3labdgfI3CeWmvTrRsUFsxBhNqS6zZ64
 mb8w==
X-Gm-Message-State: AOJu0Yxd2KDmzD6mzqmdCW1f6gLtFw7n5xzoPtLw+yNXs/H+YVXQAGq1
 +MGIiGzhc2RSAR+cMrzLocuwodAYJDbiKNJZbeZJWgh15NJtrk2vLG6GR47CFPv4V45mdFeSk1V
 yw77EjrmQRqzMu4TV7YLIgyRSKueYncLyKfg8EqRIcfqT0MO4My6iz4+kYSY/NQETtc5BdX/rR5
 rEh6wKGGk2OYQu9N39LMAu+2yIOzk=
X-Received: by 2002:a05:6000:471a:b0:382:503c:da45 with SMTP id
 ffacd0b85a97d-38254b14041mr2347764f8f.38.1732103132123; 
 Wed, 20 Nov 2024 03:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKuVKVQY7zw8d+qaep71TvGnCAiX3bm3z+I99zqy+82hlt8SXA5UvQobpYZLy55zzbmPVvEkNBvAg49b1QWnc=
X-Received: by 2002:a05:6000:471a:b0:382:503c:da45 with SMTP id
 ffacd0b85a97d-38254b14041mr2347749f8f.38.1732103131854; Wed, 20 Nov 2024
 03:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com> <ZzvIZ4EL92hEk4wC@x1n>
 <CABgObfamYxtgX7SubOd8OvA5w70xQ5uesJ1TuPoTK9onVO+58w@mail.gmail.com>
 <Zzzv32xlLAH4O5Ig@x1n>
 <CABgObfaKrOvfhK5KfoxOOXOyZXeEz33VkvDeE=5wwtq3Ep=QdQ@mail.gmail.com>
 <Zz0GlJAYOzWrrOcC@x1n>
In-Reply-To: <Zz0GlJAYOzWrrOcC@x1n>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Nov 2024 12:45:19 +0100
Message-ID: <CABgObfbXuiqw01mzVLZEgw-o_tdbf83QzYugq7oL4g7TFVV_yg@mail.gmail.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e38bf5062756af23"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000e38bf5062756af23
Content-Type: text/plain; charset="UTF-8"

Il mar 19 nov 2024, 22:43 Peter Xu <peterx@redhat.com> ha scritto:

> > The easiest way to check is probably to print the type of every
> successful
> > object_dynamic_cast and object_class_dynamic_cast. I suspect the result
> > will be virtio-blk-device and/or scsi-hd, but maybe those already do an
> > unsafe cast (pointer type cast) instead of object_dynamic_cast.
>
> Yes, it sounds more reasonable to me to optimize specific call sites so far
> rather than provides something generic.

Though it could still be a
> generic API so that devices can opt-in.


One of the things that I am excited about for Rust is checking at compile
time whether a cast is to a superclass, which makes it safe automatically.

> I can give it some measurement if there is, otherwise I'm
> > > guessing whatever changes could fall into the noise.
> >
> >
> > Yes, probably. At most you can identify if there any heavy places out of
> > the 34000 calls, and see if they can use an unsafe cast.
>
> I can still trivially do this.
>
> I traced qemu using bpf


Nice! I want to know more. :))
A

> and interestingly in my case close to half (over
> 10000+) of the calls are about ahci_irq_lower() from different higher level
> stack (yeah I used IDE in my setup.. with a split irqchi..), where it has:
>
>     PCIDevice *pci_dev = (PCIDevice *)
> object_dynamic_cast(OBJECT(dev_state),
>
>  TYPE_PCI_DEVICE);
>
> So IIUC that can be open to a unsafe cast too


Hmm no it can't because there's also sysbus AHCI. The fix would be to add
an AHCIClass and make irq toggling into a method there

but considering IDE is ODD FIXES stage, I'm not sure if I should send a
> patch at all.  However I copied John regardless.
>

Well, MAINTAINERS only says the kind of work that the maintainer is doing,
you can always do more. However it seems like not a small amount, so maybe
adding a comment is enough if somebody else wants to do it?

Paolo


> Thanks,
>
> --
> Peter Xu
>
>

--000000000000e38bf5062756af23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 19 nov 2024, 22:43 Peter Xu &lt;<a href=3D"mail=
to:peterx@redhat.com">peterx@redhat.com</a>&gt; ha scritto:</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; The easiest way to check is probably to print the type of every succes=
sful<br>
&gt; object_dynamic_cast and object_class_dynamic_cast. I suspect the resul=
t<br>
&gt; will be virtio-blk-device and/or scsi-hd, but maybe those already do a=
n<br>
&gt; unsafe cast (pointer type cast) instead of object_dynamic_cast.<br>
<br>
Yes, it sounds more reasonable to me to optimize specific call sites so far=
<br>
rather than provides something generic.</blockquote></div></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"> Though it could still be a<br>
generic API so that devices can opt-in.=C2=A0</blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">One of the things that I am excite=
d about for Rust is checking at compile time whether a cast is to a supercl=
ass, which makes it safe automatically.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
&gt; I can give it some measurement if there is, otherwise I&#39;m<br>
&gt; &gt; guessing whatever changes could fall into the noise.<br>
&gt; <br>
&gt; <br>
&gt; Yes, probably. At most you can identify if there any heavy places out =
of<br>
&gt; the 34000 calls, and see if they can use an unsafe cast.<br>
<br>
I can still trivially do this.<br>
<br>
I traced qemu using bpf</blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Nice! I want to know more. :))</div><div dir=3D"auto">A<=
/div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">and interestingly in my case close to half (over<b=
r>
10000+) of the calls are about ahci_irq_lower() from different higher level=
<br>
stack (yeah I used IDE in my setup.. with a split irqchi..), where it has:<=
br>
<br>
=C2=A0 =C2=A0 PCIDevice *pci_dev =3D (PCIDevice *) object_dynamic_cast(OBJE=
CT(dev_state),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_PCI_DEVI=
CE);<br>
<br>
So IIUC that can be open to a unsafe cast too</blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Hmm no it can&#39;t because there&=
#39;s also sysbus AHCI. The fix would be to add an AHCIClass and make irq t=
oggling into a method there</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">but considering IDE is ODD FIXES stage, I&#39;m not sure if I should =
send a patch at all.=C2=A0 However I copied John regardless.<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Well, MAINTAINE=
RS only says the kind of work that the maintainer is doing, you can always =
do more. However it seems like not a small amount, so maybe adding a commen=
t is enough if somebody else wants to do it?</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div></div></div>

--000000000000e38bf5062756af23--


