Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8826AC52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 20:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbQqp-00030V-T7; Tue, 06 Aug 2024 16:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sbQqm-0002zV-Bh
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:32:08 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sbQqk-0006da-0k
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 16:32:07 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ef248ab2aeso17133271fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722976323; x=1723581123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4cVX+vdtRbjKRnJ8k+xGFwZU4CJUyuoBcJvY/3P8diM=;
 b=XbG9XQ0rsVJW3Db43B0TMxPGCjpioUopQ0U1NxxlJfdL50XVAJq7PrxgmzRnqoZp1Q
 CN7bKSwCbfMaCl6vNq5B2gk37f4f60R5IcFuNTV13Esw2mfnovIVGh2SKZvlVobDrfOX
 23Tb2EsFMVH58507LYvBpT1l+s+zBnh6FKVkFb7BYmgGmow+lAcm9mZ8YavoTRO/kBKZ
 RSW0GAOfd0LT2xBIwPTZKxEgZpiFmD8wBPEgGT9XNObvLnZ0nqSMoN/3R/u4rq3tfGpG
 OLTwHpxcI/e4zcHB4AwwAWTrWxBrhUro5DMdrAkvjAe5nbRWUwenZ5AhdG8V04gVGh/I
 /h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722976323; x=1723581123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4cVX+vdtRbjKRnJ8k+xGFwZU4CJUyuoBcJvY/3P8diM=;
 b=urgyFQMEqb2uJ8D/Ubolf3ZKW1Eyft9HIjGB/adFuI66oIMlFtq3MgmwveolZvH9l2
 M2JtsRmryj1Ez+yHDrFXSfzwk9P6n3IdzcjyvLgMplDcXBpYGsva8P0HJhHtOiAfMp2C
 Q6p0eisNL/C2xDR3fx2ZFannW3B6eyxgAOifP+2CTz4R4WS9HoJ1CNhhpqriGNCCfWm4
 XwicGdmVSV40o6dfrf+PXb8b4xTgfvogOJl+LHLSnNqrGHNN3k/QmkYllTPZubhrCGGh
 fZf5V04cSA/vlynYeAusLjU5HbvimkXpS4JfouhIJ6yAAN7IpkNcoMfHA8C3682xtRzo
 3P+g==
X-Gm-Message-State: AOJu0YyA8EJV68FveKxuUxGRrA5d+4sw8Gnz1iKQ1rMHvIHp6mR/VCzS
 n7dPkNj+rFJjyNJ+sCmpcwp+qIq0yDiOX0ETn8uCfD/gjobCFaimLVCui8nhBWXx7sWnyhFpB8g
 ZKHebQUgGGv0N5eYguFAk7qBGXlIdUpXSJHe3
X-Google-Smtp-Source: AGHT+IGnaA2iJo21TLuQQMRpw/lGKh4VDKXnI1LoFE9yLK0XuGW7Sg5g1oyL4c4KmcXrnnQfkU3+DiiAw2g09qKmb34=
X-Received: by 2002:a2e:b790:0:b0:2ef:2c3c:512a with SMTP id
 38308e7fff4ca-2f15ab5cce3mr134231271fa.42.1722976322307; Tue, 06 Aug 2024
 13:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-5-tavip@google.com>
 <87sevhrbjm.fsf@draig.linaro.org>
In-Reply-To: <87sevhrbjm.fsf@draig.linaro.org>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 6 Aug 2024 13:31:51 -0700
Message-ID: <CAGWr4cTPqtzEvbd5s7xfMOzid90Gje6NSTGw1qR7r=Ao0xeAcw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/23] hw/arm: add SVD file for NXP i.MX RT595
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=tavip@google.com; helo=mail-lj1-x236.google.com
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

On Tue, Aug 6, 2024 at 7:06=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> Octavian Purdila <tavip@google.com> writes:
>
> > Picked from:
> >
> > https://github.com/nxp-mcuxpresso/mcux-soc-svd/blob/main/MIMXRT595S/MIM=
XRT595S_cm33.xml
> >
> > NOTE: the file is truncated to keep the email size reasonable. Please
> > use the link above and download the full file if you want to try out
> > the patch.
> >
> > Signed-off-by: Octavian Purdila <tavip@google.com>
> > ---
> >  hw/arm/svd/MIMXRT595S_cm33.xml | 224052
> > ++++++++++++++++++++++++++++++
>
> I guess one thing we need to decide is if the source XML should live in
> the repository as the preferred method of making changes or just the
> translations generated by the tool.
>

I think we might want to store the XML in the qemu repo, even if we
don't use it to generate the header files at compile time. This avoids
issues with the original XML moving, going away, changed in
incompatible ways, etc.

As for generating the headers at compile time, I don't have a strong
preference. I like it because there is slightly less work to do and it
avoids dealing with resolving changes on both the SVD and the
generated headers. For example, the initial headers are committed,
then some changes are done directly to the headers and then we want to
pick up a new SVD from the vendor to support a new hardware revision.

There are disadvantages as well: pysvd dependency for building qemu,
hard to review if the vendor dumps a new version with lots of changes
and we want to update to it for a new hardware revision, slight
increase in build time.

> >  1 file changed, 224052 insertions(+)
> >  create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml
> >
> > diff --git a/hw/arm/svd/MIMXRT595S_cm33.xml b/hw/arm/svd/MIMXRT595S_cm3=
3.xml
> > new file mode 100644
> > index 0000000000..8943aa3555
> > --- /dev/null
> > +++ b/hw/arm/svd/MIMXRT595S_cm33.xml
> > @@ -0,0 +1,1725 @@
> > +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> > +<device schemaVersion=3D"1.3" xmlns:xs=3D"http://www.w3.org/2001/XMLSc=
hema-instance" xs:noNamespaceSchemaLocation=3D"CMSIS-SVD.xsd">
> > +  <vendor>nxp.com</vendor>
> > +  <name>MIMXRT595S_cm33</name>
> > +  <version>1.0</version>
> > +  <description>MIMXRT595SFAWC,MIMXRT595SFFOC</description>
> > +  <licenseText>
> > +Copyright 2016-2023 NXP
> > +SPDX-License-Identifier: BSD-3-Clause
> > +  </licenseText>
>
> This certainly seems compatible. XML is not the medium I personally
> would have chosen as a register specification language but I guess there
> are no other alternatives?
>

I agree that the choice of XML is unfortunate but I am not aware of
alternatives, this is what vendors will provide.

