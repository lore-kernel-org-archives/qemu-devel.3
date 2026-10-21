Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F58606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cv8gmu/L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWwN-0000w1-Co; Wed, 21 Oct 2026 10:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWvN-0000n0-PC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:04:13 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWvK-0000C2-SI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:04:13 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4af173320f9so421812b6e.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792591449; cv=none;
 d=google.com; s=arc-20260327;
 b=gWDQnWBH2vyvWTYkZR/3HGHJKjdF80oZsbs+jaY2+Ljeo74rH13N2uenVUJ3IQq02r
 6apfiyKjr5cQjp+9OJt4i4Bd/8kyBiulcRBwQ5xp/8I4OTFJWPJH6Hx2yftqFDQaSZ5W
 FaDc7L/VCtn4jzNovCvZNp0/Ab7GvPZWIDum5DtPyS0Fv3t+HO50iploiO8GOsJswSEw
 nMyaoEgVm7raeaZFuTfGuhOLd+sjsQsG6i9inigmeU3ELxWltBjhQLHJmuKuY1c5GJ4W
 REJZqyi3L+9HqvBegmJ9f3UfXpb8/W+wuHN5TtXAdaPa697pIfksvfFIYP06pBfU4kUb
 7lKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JVTIL++hftenRqsjL5ciRHQ2+s8TLDLX8O60pea3V8U=;
 fh=LI9aekGwGBHYPRDMpgVmM6TEkl/g4MNgSCqW5BVJNKg=;
 b=glmXyhqsNrtALpNGIQMLelQzKzoifHh/6R8eT9+PUah0OHcOrelNlkxdzY7ThZWaTH
 Y1KjWbjAYA47Tozvvx/pWPmuAULyOo/Vs0I1NThfy9n6WhqhZ6NfXyDmgc/27sUbDhqB
 fI2+eUxfp3E8kcXvB9oK8DBjGaOU2CyOaEdfZWW+Oo+3CuujaMaHYVpi7PfaXjc1CmvW
 cYClP13csf1KPapcIqroC8wuh50ziO8qaER75FahHYheTNP/0Au/Ouha5DoUOZ/nmqBB
 AA5vrLfUWFBm+AbzdSK8Js3voBP3WVVwgAZKk6O27USJc35difZb71NzY3T+cac8lPVz
 LV5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792591449; x=1793196249; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JVTIL++hftenRqsjL5ciRHQ2+s8TLDLX8O60pea3V8U=;
 b=Cv8gmu/LXBdH0mXKabiKgnfPQcYrQm9fdyWiegVnOkkYET3xonkhc4zCtd6Kiar/6b
 mdz9wGjJVGhe1XSJT8a2S7V8OPTb5+dHsUoyaGslcs4Qp9MkYa049+SGJmyRAy9LtATb
 cya/VvrNyPJUcEt9JxCuPB59XA2LawKpmHVN6F6JBu1doEJk9pB+q9w0LU+rpJlevppX
 SlMDAA0K7DfhxvTtVXnzbZmovL3sitHRIN30SDrjJY52TTCOFayqQCTa8Uuj7GVFWWeD
 EKdwOAIezA48CHaGAMakwVeNAOZ9DUjtdtnGBwuIRto40/8odpF1vdDmHcyK5XHm3lN2
 Hgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792591449; x=1793196249;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JVTIL++hftenRqsjL5ciRHQ2+s8TLDLX8O60pea3V8U=;
 b=tQ+JoEpH17BsGdztzZnin+DZe53e62F1xFMHYXeichnSDVszqPQvrcaVpbPCUphae3
 FHLaJCDYFbd3J4NRIoib3q8qr1C4mz1O0rIG6bAA5f++QUN9bi8FjzXStjsV9C+2MLNz
 Ei7+em2OuntKjMA62o3CoR558OguELlRLB6c0axrrE9sTrSeI0omaWRhvCiSt68KbKVf
 45S7DRGuBd+d9WOCWUeLOiT/llIhA7xjEEt9M1qZVm86Y/PGLxwPP3Mi5qF8R8pe4fZw
 I8mY80LaP0ndEdaZs5pYpUVf/jpDK+GA3gs699rZ1sRDzCkUFALhZdJQJSNwcN8hIFex
 YsoA==
X-Gm-Message-State: AFq9FYIdnMYndb15mYvKW962FNEfGlkbFQSEWTp6NLkBwBydAeZ6GngH
 gTJWGpkI+z2cnKRY4+CfdhjkQHluy+/bR6QXb8NN6eKXwL8401OL/qYRSDnSOkA6oGVR3NWKFQP
 eYoTRhxJRSdxO8zaMJIJdXEb7BpssvuE=
X-Gm-Gg: AYBFou25ILPch9dhIzP6GNuXu7lUxdCsn/FEHgn3c1kWjyR4km50T2Bf26ONAbP39S9
 x3HekiFeV5vet9ZgpwW79CtbbwtDd2l1IJ62Om12OUZdUAyfDnjV0nzL/4y4L7vpg5++CDfFr5h
 fHq9jIBLZviStLBHa/TuTax2oepZiLmSIxdN9to89PZu+ayZDi9CCDMJD4YdGxgA1SCZUng9bkN
 D1LLpS6Alg7stEIVNYSWvzRAJWC+xnpLqRVIWKazhiPov3obFHNIu5XenEk5GoQogwgV1F1uIQ0
 jhbwCQ9bk7MEt7Snl9Ah413XUzUR3icwXWczYexEotmZIdHknb43ZDJ5HOeJGjyjINuN90UGwLW
 EhUMtWLDW7o3mYL3c7AbMePVCLhmrCFOGtDe/poMzDJw3R9X9M2pJnf3+7oY=
X-Received: by 2002:a05:6808:5188:b0:4ea:b118:c448 with SMTP id
 5614622812f47-55350a5c565mr1505740b6e.9.1792591449026; Wed, 21 Oct 2026
 07:04:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1791803914.git.waysorrypub@gmail.com>
 <8e36ee3baff3e6abef94cda37d564aeb690b161b.1791803914.git.waysorrypub@gmail.com>
 <7a2c2a6c-7ece-7e94-7216-6918558cda74@loongson.cn>
 <3c7bb90f-7b94-5d88-4f92-1b0d99c3d0e6@loongson.cn>
 <CAECqSzWofrjJgj14DB=dQOpJP-OQ5qBPM1mwJ--FKpC=g_zVTw@mail.gmail.com>
 <8336d47b-28ab-a846-b57b-b56e483c86a9@loongson.cn>
In-Reply-To: <8336d47b-28ab-a846-b57b-b56e483c86a9@loongson.cn>
From: way sorry <waysorrypub@gmail.com>
Date: Wed, 21 Oct 2026 22:03:57 +0800
X-Gm-Features: AclHuK9Eo55PhK4sa6mhNdil2-XXbmXlJD3UsNgfLzKO7Wv9OK_IshOPidlUWRM
Message-ID: <CAECqSzXVkCKPA6QnZNyDNe+RH_cBCtRhDHLudd550AV9mpAvQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Fix clock property name typo and
 order
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, lixianglai@loongson.cn, 
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com, 
 anisinha@redhat.com
Content-Type: multipart/alternative; boundary="0000000000008c13e5065e5a38b6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=waysorrypub@gmail.com; helo=mail-oi1-x232.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000008c13e5065e5a38b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bobo,

After checking the QEMU UART source codes and Linux PNP driver, I agree
with dropping the ACPI clock property, The default 1843200 Hz clock
matches QEMU's baudbase of 115200. This also follows the x86 ISA
serial approach.

I have sent v3, which removes the UART _DSD and _CCA, adds _STA =3D 0x0f,
and updates the expected DSDT blobs. All five ACPI subtests pass.

The FDT clock property is kept, since removing it causes UART probe
failures with Linux

Thanks,
pillow

On Wed, Oct 21, 2026 at 4:40=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:

>
>
> On 2026/10/18 =E4=B8=8B=E5=8D=8810:36, way sorry wrote:
> > Hi all,
> >
> > Thanks for the comments. v2 drops `_CCA` from the UART and adds
> > `_STA =3D 0x0f`. The expected DSDT blobs have been updated, and the
> > 5 ACPI subtests pass.
> >
> > On the DT side: with Linux 7.0, removing `clock-frequency` makes all
> > 4 UARTs report `failed to get clock`, and the real driver fails to
> > probe, so we are keeping the property for now. Logs:
> >
> > [    0.702431] of_serial 1fe001e0.serial: error -ENOENT: failed to get
> clock
> > [    0.702884] of_serial 1fe001e0.serial: probe with driver of_serial
> > failed with error -2
> > [    0.703468] of_serial 1fe002e0.serial: error -ENOENT: failed to get
> clock
> > [    0.703718] of_serial 1fe002e0.serial: probe with driver of_serial
> > failed with error -2
> > [    0.704127] of_serial 1fe003e0.serial: error -ENOENT: failed to get
> clock
> > [    0.704371] of_serial 1fe003e0.serial: probe with driver of_serial
> > failed with error -2
> > [    0.704762] of_serial 1fe004e0.serial: error -ENOENT: failed to get
> clock
> > [    0.705013] of_serial 1fe004e0.serial: probe with driver of_serial
> > failed with error -2
> >
> > On the ACPI side: after removing it, all 4 UARTs still register, but
> > `base_baud` changes from 6250000 to 115200. Logs:
> >
> > With clock-frequency:
> > [    0.813488] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, base_baud =
=3D
> > 6250000) is a 16550A
> > Without clock-frequency:
> > [    0.843528] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, base_baud =
=3D
> > 115200) is a 16550A
> > [    0.844663] printk: legacy console [ttyS0] enabled
> > [    0.845209] printk: legacy bootconsole [uart0] disabled
> > [    0.869343] 00:01: ttyS1 at MMIO 0x1fe002e0 (irq =3D 21, base_baud =
=3D
> > 115200) is a 16550A
> > [    0.892556] 00:02: ttyS2 at MMIO 0x1fe003e0 (irq =3D 22, base_baud =
=3D
> > 115200) is a 16550A
> > [    0.914867] 00:03: ttyS3 at MMIO 0x1fe004e0 (irq =3D 23, base_baud =
=3D
> > 115200) is a 16550A
> >
> > The reason is that Linux provides a default clock of 1,843,200 Hz in
> > `8250_pnp.c`, which matches the current QEMU UART model:
> >
> >
> https://github.com/torvalds/linux/blob/028ef9c96e96197026887c0f0924246792=
98aae8/drivers/tty/serial/8250/8250_pnp.c
> >
> > So the property is optional under Linux ACPI, but that does not mean
> > Linux does not use it.
> >
> > So far I have only verified boot, UART registration, and console
> > output. I have not tested other kernels or full TX/RX behavior. We
> > would prefer to keep an explicit and accurate frequency description
> > rather than rely on a kernel-specific default. But keeping the
> > property does not mean keeping the current 100 MHz; the correct value
> > still needs discussion.
> so what is the suggested frequency from your side?
> >
> > Questions: what is the advantage of omitting the ACPI clock property
> > here? Is there any compatibility rationale from other guest OSes that
> > supports omitting it?
> Can you describe the detailed guest OS?  which cannot run in qemu-x86
> platform without ACPI clock property.
>
> Regards
> Bibo Mao
> >
> > Thanks,
> > pillow
> >
> > On Thu, Oct 15, 2026 at 6:03=E2=80=AFPM Bibo Mao <maobibo@loongson.cn
> > <mailto:maobibo@loongson.cn>> wrote:
> >
> >
> >
> >     On 2026/10/15 =E4=B8=8B=E5=8D=882:57, Bibo Mao wrote:
> >      >
> >      >
> >      > On 2026/10/12 =E4=B8=8B=E5=8D=887:39, pillow wrote:
> >      >> The original code had a typo in the clock preperty name, and th=
e
> >      >> property name and frequency value were in reversed order.
> >      >> According to the _DSD format rules, the property name string
> comes
> >      >> first, followed by the property value:
> >      >>
> >
> https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#data-forma=
t-definition
> >
> >      >>
> >      >>
> >      >> Signed-off-by: pillow <waysorrypub@gmail.com
> >     <mailto:waysorrypub@gmail.com>>
> >      >> ---
> >      >>   hw/loongarch/virt-acpi-build.c | 2 +-
> >      >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >      >>
> >      >> diff --git a/hw/loongarch/virt-acpi-build.c
> >      >> b/hw/loongarch/virt-acpi-build.c
> >      >> index 54965f0..4081730 100644
> >      >> --- a/hw/loongarch/virt-acpi-build.c
> >      >> +++ b/hw/loongarch/virt-acpi-build.c
> >      >> @@ -336,8 +336,8 @@ static void build_uart_device_aml(Aml
> >     *table, int
> >      >> index)
> >      >>                                     AML_SHARED, &uart_irq, 1));
> >      >>       aml_append(dev, aml_name_decl("_CRS", crs));
> >      >>       pkg0 =3D aml_package(0x2);
> >      >> +    aml_append(pkg0, aml_string("clock-frequency"));
> >      >>       aml_append(pkg0, aml_int(0x05F5E100));
> >      >> -    aml_append(pkg0, aml_string("clock-frenquency"));
> >      >>       pkg1 =3D aml_package(0x1);
> >      >>       aml_append(pkg1, pkg0);
> >      >>       pkg2 =3D aml_package(0x2);
> >      >>
> >      > Hi,
> >      >
> >      > yes, there is spelling issue with LoongArch virt machine UART ac=
pi
> >      > table. It seems that clock-frequency is not used by serial port.
> >     is it
> >      > possible to remove pkg0/pkg1/pkg2 property like ISA serial acpi
> >     table
> >      > defined in function serial_isa_build_aml()?
> >      >
> >      > Also "_CCA" property should be removed since the emulated serial
> >     port
> >      > does not support DMA, and add "_STA" property.
> >     Also maybe property clock-frequency of uart fdt table in
> >     fdt_add_uart_node() can be removed.
> >
> >     Regards
> >     Bibo Mao
> >      >
> >      > Regards
> >      > Bibo Mao
> >
>
>

--0000000000008c13e5065e5a38b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Bobo,<br><br>After checking the QEMU UART source codes =
and Linux PNP driver, I agree<div>with dropping the ACPI clock property, Th=
e default 1843200 Hz clock</div><div>matches QEMU&#39;s baudbase of 115200.=
 This also follows the x86 ISA<br>serial approach.<br><br>I have sent v3, w=
hich removes the UART _DSD and _CCA, adds _STA =3D 0x0f,</div><div>and upda=
tes the expected DSDT blobs. All five ACPI subtests pass.<br><br>The FDT cl=
ock property is kept, since removing it causes UART probe</div><div>failure=
s with Linux<br><br>Thanks,<br>pillow</div></div><br><div class=3D"gmail_qu=
ote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oc=
t 21, 2026 at 4:40=E2=80=AFPM Bibo Mao &lt;<a href=3D"mailto:maobibo@loongs=
on.cn">maobibo@loongson.cn</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><br>
<br>
On 2026/10/18 =E4=B8=8B=E5=8D=8810:36, way sorry wrote:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; Thanks for the comments. v2 drops `_CCA` from the UART and adds<br>
&gt; `_STA =3D 0x0f`. The expected DSDT blobs have been updated, and the<br=
>
&gt; 5 ACPI subtests pass.<br>
&gt; <br>
&gt; On the DT side: with Linux 7.0, removing `clock-frequency` makes all<b=
r>
&gt; 4 UARTs report `failed to get clock`, and the real driver fails to<br>
&gt; probe, so we are keeping the property for now. Logs:<br>
&gt; <br>
&gt; [ =C2=A0 =C2=A00.702431] of_serial 1fe001e0.serial: error -ENOENT: fai=
led to get clock<br>
&gt; [ =C2=A0 =C2=A00.702884] of_serial 1fe001e0.serial: probe with driver =
of_serial <br>
&gt; failed with error -2<br>
&gt; [ =C2=A0 =C2=A00.703468] of_serial 1fe002e0.serial: error -ENOENT: fai=
led to get clock<br>
&gt; [ =C2=A0 =C2=A00.703718] of_serial 1fe002e0.serial: probe with driver =
of_serial <br>
&gt; failed with error -2<br>
&gt; [ =C2=A0 =C2=A00.704127] of_serial 1fe003e0.serial: error -ENOENT: fai=
led to get clock<br>
&gt; [ =C2=A0 =C2=A00.704371] of_serial 1fe003e0.serial: probe with driver =
of_serial <br>
&gt; failed with error -2<br>
&gt; [ =C2=A0 =C2=A00.704762] of_serial 1fe004e0.serial: error -ENOENT: fai=
led to get clock<br>
&gt; [ =C2=A0 =C2=A00.705013] of_serial 1fe004e0.serial: probe with driver =
of_serial <br>
&gt; failed with error -2<br>
&gt; <br>
&gt; On the ACPI side: after removing it, all 4 UARTs still register, but<b=
r>
&gt; `base_baud` changes from 6250000 to 115200. Logs:<br>
&gt; <br>
&gt; With clock-frequency:<br>
&gt; [ =C2=A0 =C2=A00.813488] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, =
base_baud =3D <br>
&gt; 6250000) is a 16550A<br>
&gt; Without clock-frequency:<br>
&gt; [ =C2=A0 =C2=A00.843528] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq =3D 20, =
base_baud =3D <br>
&gt; 115200) is a 16550A<br>
&gt; [ =C2=A0 =C2=A00.844663] printk: legacy console [ttyS0] enabled<br>
&gt; [ =C2=A0 =C2=A00.845209] printk: legacy bootconsole [uart0] disabled<b=
r>
&gt; [ =C2=A0 =C2=A00.869343] 00:01: ttyS1 at MMIO 0x1fe002e0 (irq =3D 21, =
base_baud =3D <br>
&gt; 115200) is a 16550A<br>
&gt; [ =C2=A0 =C2=A00.892556] 00:02: ttyS2 at MMIO 0x1fe003e0 (irq =3D 22, =
base_baud =3D <br>
&gt; 115200) is a 16550A<br>
&gt; [ =C2=A0 =C2=A00.914867] 00:03: ttyS3 at MMIO 0x1fe004e0 (irq =3D 23, =
base_baud =3D <br>
&gt; 115200) is a 16550A<br>
&gt; <br>
&gt; The reason is that Linux provides a default clock of 1,843,200 Hz in<b=
r>
&gt; `8250_pnp.c`, which matches the current QEMU UART model:<br>
&gt; <br>
&gt; <a href=3D"https://github.com/torvalds/linux/blob/028ef9c96e9619702688=
7c0f092424679298aae8/drivers/tty/serial/8250/8250_pnp.c" rel=3D"noreferrer"=
 target=3D"_blank">https://github.com/torvalds/linux/blob/028ef9c96e9619702=
6887c0f092424679298aae8/drivers/tty/serial/8250/8250_pnp.c</a><br>
&gt; <br>
&gt; So the property is optional under Linux ACPI, but that does not mean<b=
r>
&gt; Linux does not use it.<br>
&gt; <br>
&gt; So far I have only verified boot, UART registration, and console<br>
&gt; output. I have not tested other kernels or full TX/RX behavior. We<br>
&gt; would prefer to keep an explicit and accurate frequency description<br=
>
&gt; rather than rely on a kernel-specific default. But keeping the<br>
&gt; property does not mean keeping the current 100 MHz; the correct value<=
br>
&gt; still needs discussion.<br>
so what is the suggested frequency from your side?<br>
&gt; <br>
&gt; Questions: what is the advantage of omitting the ACPI clock property<b=
r>
&gt; here? Is there any compatibility rationale from other guest OSes that<=
br>
&gt; supports omitting it?<br>
Can you describe the detailed guest OS?=C2=A0 which cannot run in qemu-x86 =
<br>
platform without ACPI clock property.<br>
<br>
Regards<br>
Bibo Mao<br>
&gt; <br>
&gt; Thanks,<br>
&gt; pillow<br>
&gt; <br>
&gt; On Thu, Oct 15, 2026 at 6:03=E2=80=AFPM Bibo Mao &lt;<a href=3D"mailto=
:maobibo@loongson.cn" target=3D"_blank">maobibo@loongson.cn</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:maobibo@loongson.cn" target=3D"_blank">ma=
obibo@loongson.cn</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 2026/10/15 =E4=B8=8B=E5=8D=882:57, Bibo Mao wrot=
e:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On 2026/10/12 =E4=B8=8B=E5=8D=887:39, pillow =
wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; The original code had a typo in the clock=
 preperty name, and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; property name and frequency value were in=
 reversed order.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; According to the _DSD format rules, the p=
roperty name string comes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; first, followed by the property value:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/UEFI/DSD-Guide/blob/m=
ain/src/dsd-guide.adoc#data-format-definition" rel=3D"noreferrer" target=3D=
"_blank">https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#dat=
a-format-definition</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Signed-off-by: pillow &lt;<a href=3D"mail=
to:waysorrypub@gmail.com" target=3D"_blank">waysorrypub@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:waysorrypub@gmail.com"=
 target=3D"_blank">waysorrypub@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 hw/loongarch/virt-acpi-build.c | 2=
 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0 1 file changed, 1 insertion(+), 1 =
deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; diff --git a/hw/loongarch/virt-acpi-build=
.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; b/hw/loongarch/virt-acpi-build.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; index 54965f0..4081730 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; --- a/hw/loongarch/virt-acpi-build.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +++ b/hw/loongarch/virt-acpi-build.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; @@ -336,8 +336,8 @@ static void build_uar=
t_device_aml(Aml<br>
&gt;=C2=A0 =C2=A0 =C2=A0*table, int<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 AML_SHARED, &amp;uart_irq, 1));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append=
(dev, aml_name_decl(&quot;_CRS&quot;, crs));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg0 =3D a=
ml_package(0x2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +=C2=A0=C2=A0=C2=A0 aml_append(pkg0, aml_=
string(&quot;clock-frequency&quot;));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append=
(pkg0, aml_int(0x05F5E100));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; -=C2=A0=C2=A0=C2=A0 aml_append(pkg0, aml_=
string(&quot;clock-frenquency&quot;));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg1 =3D a=
ml_package(0x1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append=
(pkg1, pkg0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pkg2 =3D a=
ml_package(0x2);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; yes, there is spelling issue with LoongArch v=
irt machine UART acpi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; table. It seems that clock-frequency is not u=
sed by serial port.<br>
&gt;=C2=A0 =C2=A0 =C2=A0is it<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; possible to remove pkg0/pkg1/pkg2 property li=
ke ISA serial acpi<br>
&gt;=C2=A0 =C2=A0 =C2=A0table<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; defined in function serial_isa_build_aml()?<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Also &quot;_CCA&quot; property should be remo=
ved since the emulated serial<br>
&gt;=C2=A0 =C2=A0 =C2=A0port<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; does not support DMA, and add &quot;_STA&quot=
; property.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Also maybe property clock-frequency of uart fdt tab=
le in<br>
&gt;=C2=A0 =C2=A0 =C2=A0fdt_add_uart_node() can be removed.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0Bibo Mao<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Regards<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Bibo Mao<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000008c13e5065e5a38b6--

