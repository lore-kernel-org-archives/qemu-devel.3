Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F63C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0yt-00046l-As; Tue, 25 Jun 2024 03:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sM0yr-00046W-9r; Tue, 25 Jun 2024 03:52:45 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arthurtumanyan@gmail.com>)
 id 1sM0yp-0007As-1q; Tue, 25 Jun 2024 03:52:44 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6f8ebbd268so1024055366b.0; 
 Tue, 25 Jun 2024 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719301960; x=1719906760; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=psxBGR4BEdSA8CxtBRYpCiDkFnYW9Y8BOVctpJ+Kmdk=;
 b=lVCrVefjm83FAD3ocr9D4VZ0h7ra6+/F6OyAsPK4Nfp99tbd0l8QO7erYBK01v+jpm
 ZZsshqOqrAlz0QWwZrF0Eh3Hs9JwB2L0uhmXr+PJZlt66fdRgISv1CKhNqmN1Bbiq0vZ
 sxdzt8hSprURzAOIQO57lJI1K48okIRFDbmEqnwjH+P4+p7D3Z6hjNkqWRcFw2BRxQ6+
 vD+nq5U7kweXvqJK+e3jAYvtG/yV7U8w5ciCPIQ6oP3pStpbEpmod2CDVomwFXuIUUe9
 zXFUiL1Z5YRSFMnxaVop4QdBaWFq5UzKHrOm1VaO6nC8eFqjB2qG2dpQs1UKzRt1mxpq
 rEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719301960; x=1719906760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=psxBGR4BEdSA8CxtBRYpCiDkFnYW9Y8BOVctpJ+Kmdk=;
 b=o/RHVGjNuQBbbo9bnv+QBUhWXkYCloFT7tun94hu3fc/YkdYtA5aeDfwpsHU5vWmlg
 UJlfOeeNAhpzVdvSVYNNmwE8Msmr7oDMnDD/PmdQOf/Nj6EeSnNcWuKVlhkcCL2yJ9rj
 J/Ce37Kj0kzVKx2809oyYrY0gJLEzgf8aexT7fyc6X74z9LhRgytKtyrzu5S7nQW54az
 2iL5rnxDfim6K6+w/Hid5fc/UKtNHQkMCbkM8s0aD1EIDmqpNXryNLEcrJG0kai0ttMZ
 P1EQ6q1L7zH3ba4de7ou9j1VATyK6OOurn6e+dX0G8fsDjRmDCXNmQMrjdG97CyBlzxN
 xTlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaGR1ZAPCDHnbmAykCIQ66I2+DWpm70oe3KpvtrXfPTZE/lUea5WA6oEGZ0hwTZJQcAV1i4T7MBUL50/obchjfMAhRvriLjvLdNdN0ewrt7a7BJ3IenSTfnIM=
X-Gm-Message-State: AOJu0YwN1IgFAbsWsKDvny7W+DBQvnu5XqIu0LWVD4/DlT/pkgwa7zna
 rKEkXMWKpAnaov7JJ1XVd8Fr8QWBjQOqeQloIYnDsTTglIfwQW/iGfw4yVGjJOKP/LGEFffI0if
 xnvQyhXQdoTbj8ZCCY+/kbMckXNw=
X-Google-Smtp-Source: AGHT+IHGBL7EV6Pu3DkfAF8neOju2zapgEgwAWzFGLZeRF+oPv5K0phFYaDjR1q8KVVXQgnUUkxWmhagPZQccAh0uFI=
X-Received: by 2002:a17:907:208b:b0:a6f:881a:cd52 with SMTP id
 a640c23a62f3a-a6ffe3ccd23mr634567966b.17.1719301960224; Tue, 25 Jun 2024
 00:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
 <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
 <CAFEAcA-Yda=XXspi49Z+-7bmBP-DzL2kFMg_XfNxMviHuAX18w@mail.gmail.com>
 <CADueUgS1==4gAmNmTBLZzrnRUp9z2wxkce8+TcOeoR3w_Pg-bg@mail.gmail.com>
 <CADueUgT4xDJft6On4j+oic65UcQRv_PcNSWJg-CcdBM8My3zow@mail.gmail.com>
 <CAFEAcA-TV6MKC32zd3WP5yhLABkbDrLKtP7CCZ0kB5pbV+-5Vg@mail.gmail.com>
 <76070bb3-abf6-491a-a9f3-549f615e23fd@redhat.com>
In-Reply-To: <76070bb3-abf6-491a-a9f3-549f615e23fd@redhat.com>
From: Arthur Tumanyan <arthurtumanyan@gmail.com>
Date: Tue, 25 Jun 2024 11:52:29 +0400
Message-ID: <CADueUgSoR4_WgCh4kZ0fsPsY_tq1YXQkPri5th73rK-pQqxu7Q@mail.gmail.com>
Subject: Re: How to use designware-root-port and designware-root-host devices ?
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, andrew.smirnov@gmail.com
Content-Type: multipart/alternative; boundary="00000000000099d834061bb22e0d"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=arthurtumanyan@gmail.com; helo=mail-ej1-x632.google.com
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

--00000000000099d834061bb22e0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I ported DWC PCIE part from fsl-imx7.c to my new cusotm virt machine based
on RISC-V "virt".

It looks ok so far. Now i'm wondering whether there is a "standard/ready to
use for most of cases" device tree description for the synopsis pcie host
device ?

Looking this way:
https://mjmwired.net/kernel/Documentation/devicetree/bindings/pci/designwar=
e-pcie.txt
but would be glad to hear some advices if any.

Best regards,
Arthur

On Fri, Jun 21, 2024 at 1:30=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 21/06/2024 11.16, Peter Maydell wrote:
> > On Fri, 21 Jun 2024 at 08:07, Arthur Tumanyan <arthurtumanyan@gmail.com=
>
> wrote:
> >>
> >> Hi,
> >>
> >> I just tried to run mcimx7d-sabre machine this way:
> >>
> >> ${HOME}/cosim/usr/local/bin/qemu-system-arm -M mcimx7d-sabre -m 2G \
> >> -kernel ${HOME}/cosim-arm/buildroot/output/images/uImage \
> >>          --initrd
> ${HOME}/cosim-arm/buildroot/output/images/rootfs.cpio.gz \
> >> -nographic \
> >> -net nic -net user
> >>
> >> and it just prints this and do nothing: qemu-system-arm: warning: nic
> imx.enet.1 has no peer
> >>
> >> Based on what I see in the mcimx7d-sabre.c , it configures just very
> basic things, no PCIe at all (may be I'm wrong ;) )
> >
> > The machine model in mcimx7d-sabre.c creates the SoC object
> > (TYPE_FSL_IMX7). It's the code for that in hw/arm/fsl-imx7.c
> > that creates all the SoC devices including the PCIe controller.
> > (This structure is similar to real hardware where you have a
> > board, which has one or two chips on it like RAM but most of
> > the complicated stuff is inside the one big SoC chip.)
> >
> >> Is there any idea what goes wrong here ? Maybe someone has experience
> with running this machine ?
> >
> > "No output" usually means "your guest kernel is not configured
> > correctly for this machine type", and/or possibly "you didn't
> > tell the kernel to output on the serial port".
>
> By the way, it seems like we don't even have an avocado test for that
> machine available. Peter, do you know whether there is a kernel for this
> machine available somewhere that we could use for testing?
>
>   Thomas
>
>
>

--00000000000099d834061bb22e0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div>I ported DWC PCIE part from f=
sl-imx7.c to my new cusotm virt machine based on RISC-V &quot;virt&quot;.=
=C2=A0<div><br></div><div>It looks ok so far. Now i&#39;m wondering whether=
 there is a &quot;standard/ready to use for most of cases&quot; device tree=
 description for the synopsis pcie host device ?=C2=A0</div><div><br><div>L=
ooking this way:=C2=A0<a href=3D"https://mjmwired.net/kernel/Documentation/=
devicetree/bindings/pci/designware-pcie.txt">https://mjmwired.net/kernel/Do=
cumentation/devicetree/bindings/pci/designware-pcie.txt</a> but would be gl=
ad to hear some advices if any.</div></div><div><br></div><div>Best regards=
,</div><div>Arthur</div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jun 21, 2024 at 1:30=E2=80=AFPM Thomas Huth=
 &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">On 21/06/2024 11.1=
6, Peter Maydell wrote:<br>
&gt; On Fri, 21 Jun 2024 at 08:07, Arthur Tumanyan &lt;<a href=3D"mailto:ar=
thurtumanyan@gmail.com" target=3D"_blank">arthurtumanyan@gmail.com</a>&gt; =
wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I just tried to run mcimx7d-sabre machine this way:<br>
&gt;&gt;<br>
&gt;&gt; ${HOME}/cosim/usr/local/bin/qemu-system-arm -M mcimx7d-sabre -m 2G=
 \<br>
&gt;&gt; -kernel ${HOME}/cosim-arm/buildroot/output/images/uImage \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --initrd ${HOME}/cosim-arm/build=
root/output/images/rootfs.cpio.gz \<br>
&gt;&gt; -nographic \<br>
&gt;&gt; -net nic -net user<br>
&gt;&gt;<br>
&gt;&gt; and it just prints this and do nothing: qemu-system-arm: warning: =
nic imx.enet.1 has no peer<br>
&gt;&gt;<br>
&gt;&gt; Based on what I see in the mcimx7d-sabre.c , it configures just ve=
ry basic things, no PCIe at all (may be I&#39;m wrong ;) )<br>
&gt; <br>
&gt; The machine model in mcimx7d-sabre.c creates the SoC object<br>
&gt; (TYPE_FSL_IMX7). It&#39;s the code for that in hw/arm/fsl-imx7.c<br>
&gt; that creates all the SoC devices including the PCIe controller.<br>
&gt; (This structure is similar to real hardware where you have a<br>
&gt; board, which has one or two chips on it like RAM but most of<br>
&gt; the complicated stuff is inside the one big SoC chip.)<br>
&gt; <br>
&gt;&gt; Is there any idea what goes wrong here ? Maybe someone has experie=
nce with running this machine ?<br>
&gt; <br>
&gt; &quot;No output&quot; usually means &quot;your guest kernel is not con=
figured<br>
&gt; correctly for this machine type&quot;, and/or possibly &quot;you didn&=
#39;t<br>
&gt; tell the kernel to output on the serial port&quot;.<br>
<br>
By the way, it seems like we don&#39;t even have an avocado test for that <=
br>
machine available. Peter, do you know whether there is a kernel for this <b=
r>
machine available somewhere that we could use for testing?<br>
<br>
=C2=A0 Thomas<br>
<br>
<br>
</blockquote></div>

--00000000000099d834061bb22e0d--

