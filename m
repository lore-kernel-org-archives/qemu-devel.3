Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF064C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 22:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scYIM-0007iz-MJ; Fri, 09 Aug 2024 18:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1scYIL-0007i4-CW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 18:41:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1scYIJ-0007wt-5U
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 18:41:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368440b073bso1517526f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723243268; x=1723848068; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bUgArTUxkUr/gdGActB6xpXbU7KtEufqpylBuW/nwaQ=;
 b=21BGy3WElfnk7rYy79Y8JL2Y26KFrvSapFiCzNMLerVli+yd5NKyGUFanZknoa/sE9
 NwbiCEkKPCQb/pBj1Cl2JGOCoocYBmkYccjG1lyt5fT44vEAi7TlQZ4u0z5NpAGpA+C6
 AkxgjiD1MFd+c+neHdyzpuLD2zY4xxxZ1bfgOUc8E0uPe5SrizTdXB6wsJWwe8KJ+xnx
 oh/wS1luFFVKHOe9RYYZcm/7RiVDCFv84WAjb2zpKCm3l8g9S+YFMPPjCS/adaekxuni
 6vpPLVBhh3ZBtbJ/LJCrHuueZJDyD8/OtQymYvhQF7mx4/xZMOw6nq1YOvhXBoDQtHpY
 Okqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723243268; x=1723848068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bUgArTUxkUr/gdGActB6xpXbU7KtEufqpylBuW/nwaQ=;
 b=Ys5lkVK1JsmW6pWjTFhc/qt6v/AjKGS9r2HP/yhwGSKvqXgSjKES5AXGr4yQNz0uvr
 6un4j6DiGeGdsDKOG7U9RZqvxPT4K/lau0uEoHLoMSDxRAqBYcYVevlUsE+Gfe+9gd8k
 5ux3JaDNixZWhvooeO7ojH9VeQErelSwAMocHCLdzjqDPMt8qAbeeygqEaqmO8g3U2uO
 AlEyuN4zJS/daaa79ioTjMYRaEs8vrcYafZGZo4wqdpGg101ux7L1qLmuW7zgW1/T4Vj
 IQdxSzBEdRdAEByYN/z/Y0TsoJrExLKNzb11OxJ6DL9UPGSowGAAXTAWa5O8T/Q+0Qe6
 RptA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj/1r8B8SfU+3luLk1EC/sNavZ+/bRHOHOe2qGTOG3WDhAaTI2JsNGfz8mdjcLCr32s/KlqihXa85sQ47Cvw6/tH+uZn0=
X-Gm-Message-State: AOJu0YyqaCszulfogDgPnosy8QfBjdH28lQQfIbjWaG1SY90xoQ6Qein
 AoecBh9F8fIyMb6RFqFHd6BttPFQcS8o19m7OLWNt05TUBynDDs0XXniRaKAWnabII9AZ5oB5b/
 Z+BsSMFD/s7xk2xVNpw9SCKnCZiiFyvlvTmWs
X-Google-Smtp-Source: AGHT+IF5oEe3RjKF12yqz6+lvsGPXAuFpNInmch4ARUIyceiSNT9zLtiGPOfixPsb8rHZhyspY3R5lT3sfMDHNcps4o=
X-Received: by 2002:adf:eeca:0:b0:366:f455:e7c1 with SMTP id
 ffacd0b85a97d-36d6a226689mr2265059f8f.27.1723243268124; Fri, 09 Aug 2024
 15:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-5-tavip@google.com>
 <87sevhrbjm.fsf@draig.linaro.org>
 <CAGWr4cTPqtzEvbd5s7xfMOzid90Gje6NSTGw1qR7r=Ao0xeAcw@mail.gmail.com>
 <ZrXdyEIFLulMN-gE@redhat.com>
In-Reply-To: <ZrXdyEIFLulMN-gE@redhat.com>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 9 Aug 2024 15:40:57 -0700
Message-ID: <CAGWr4cTj2uZakF9bkjGFR1PMvyPirvNz-vwWo+oD72YwkDXA2g@mail.gmail.com>
Subject: Re: [RFC PATCH 04/23] hw/arm: add SVD file for NXP i.MX RT595
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 peter.maydell@linaro.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, thuth@redhat.com, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, 
 bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=tavip@google.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 9, 2024 at 2:13=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Tue, Aug 06, 2024 at 01:31:51PM -0700, Octavian Purdila wrote:
> > On Tue, Aug 6, 2024 at 7:06=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
> > >
> > > Octavian Purdila <tavip@google.com> writes:
> > >
> > > > Picked from:
> > > >
> > > > https://github.com/nxp-mcuxpresso/mcux-soc-svd/blob/main/MIMXRT595S=
/MIMXRT595S_cm33.xml
> > > >
> > > > NOTE: the file is truncated to keep the email size reasonable. Plea=
se
> > > > use the link above and download the full file if you want to try ou=
t
> > > > the patch.
>
> "the file is truncated" wins understatement of the week.
>
> The full XML file that would need to be in QEMU git for this is 8.6 MB in
> size.
>
> The overall generated headers that we get from it are ~16k lines,
> or ~0.5 MB
>
> $ wc -l build/hw/arm/svd/*.h
>    135 build/hw/arm/svd/flexcomm.h
>   1227 build/hw/arm/svd/flexcomm_i2c.h
>   1161 build/hw/arm/svd/flexcomm_spi.h
>   1231 build/hw/arm/svd/flexcomm_usart.h
>   2243 build/hw/arm/svd/flexspi.h
>   3100 build/hw/arm/svd/rt500_clkctl0.h
>   4022 build/hw/arm/svd/rt500_clkctl1.h
>     64 build/hw/arm/svd/rt500.h
>   1073 build/hw/arm/svd/rt500_rstctl0.h
>   1697 build/hw/arm/svd/rt500_rstctl1.h
>  15953 total
>
> $ wc -c build/hw/arm/svd/*.h
>   4349 build/hw/arm/svd/flexcomm.h
>  51135 build/hw/arm/svd/flexcomm_i2c.h
>  43822 build/hw/arm/svd/flexcomm_spi.h
>  46331 build/hw/arm/svd/flexcomm_usart.h
>  89224 build/hw/arm/svd/flexspi.h
> 113952 build/hw/arm/svd/rt500_clkctl0.h
> 141885 build/hw/arm/svd/rt500_clkctl1.h
>   1881 build/hw/arm/svd/rt500.h
>  38881 build/hw/arm/svd/rt500_rstctl0.h
>  61449 build/hw/arm/svd/rt500_rstctl1.h
> 592909 total
>
>
>
> > > >
> > > > Signed-off-by: Octavian Purdila <tavip@google.com>
> > > > ---
> > > >  hw/arm/svd/MIMXRT595S_cm33.xml | 224052
> > > > ++++++++++++++++++++++++++++++
> > >
> > > I guess one thing we need to decide is if the source XML should live =
in
> > > the repository as the preferred method of making changes or just the
> > > translations generated by the tool.
> > >
> >
> > I think we might want to store the XML in the qemu repo, even if we
> > don't use it to generate the header files at compile time. This avoids
> > issues with the original XML moving, going away, changed in
> > incompatible ways, etc.
> >
> > As for generating the headers at compile time, I don't have a strong
> > preference. I like it because there is slightly less work to do and it
> > avoids dealing with resolving changes on both the SVD and the
> > generated headers. For example, the initial headers are committed,
> > then some changes are done directly to the headers and then we want to
> > pick up a new SVD from the vendor to support a new hardware revision.
>
> IIUC the structs/enums/etc are defining guest ABI. So if we want to
> preserve guest ABI for these devices across QEMU releases, we don't
> want the generated output to be arbitrarily changing. If there are
> different revisions of a device, we might need separate structs for
> each maintained in parallel.
>

I think we can review changes to prevent ABI breakages both for XML
and generated headers - unless we use meson git-wrap submodules.

>
>
> >
> > There are disadvantages as well: pysvd dependency for building qemu,
> > hard to review if the vendor dumps a new version with lots of changes
> > and we want to update to it for a new hardware revision, slight
> > increase in build time.
> >
> > > >  1 file changed, 224052 insertions(+)
> > > >  create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml
> > > >
> > > > diff --git a/hw/arm/svd/MIMXRT595S_cm33.xml b/hw/arm/svd/MIMXRT595S=
_cm33.xml
> > > > new file mode 100644
> > > > index 0000000000..8943aa3555
> > > > --- /dev/null
> > > > +++ b/hw/arm/svd/MIMXRT595S_cm33.xml
> > > > @@ -0,0 +1,1725 @@
> > > > +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > > > +<device schemaVersion=3D"1.3" xmlns:xs=3D"http://www.w3.org/2001/X=
MLSchema-instance" xs:noNamespaceSchemaLocation=3D"CMSIS-SVD.xsd">
> > > > +  <vendor>nxp.com</vendor>
> > > > +  <name>MIMXRT595S_cm33</name>
> > > > +  <version>1.0</version>
> > > > +  <description>MIMXRT595SFAWC,MIMXRT595SFFOC</description>
> > > > +  <licenseText>
> > > > +Copyright 2016-2023 NXP
> > > > +SPDX-License-Identifier: BSD-3-Clause
> > > > +  </licenseText>
> > >
> > > This certainly seems compatible. XML is not the medium I personally
> > > would have chosen as a register specification language but I guess th=
ere
> > > are no other alternatives?
> > >
> >
> > I agree that the choice of XML is unfortunate but I am not aware of
> > alternatives, this is what vendors will provide.
>
> Given the size of the XML I'm inclined to say that we should just be
> committing the generated header files to qemu.git
>

Fine with me. I think we can also reconsider later with minimal effort
if this gets widely used and there is lots of churn.

Peter, what do you think?

> Then add https://github.com/nxp-mcuxpresso/mcux-soc-svd as a git
> submodule, and provide some meson rules for triggering re-generation
> that are off-by-default.
>

Sounds good. I was thinking of adding mcux-soc-svd as a meson
subproject via git-wrap as suggested by Philippe.



> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

