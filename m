Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B838C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 16:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbjeA-00052g-Kf; Wed, 07 Aug 2024 12:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sbje7-00051D-K8
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:36:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sbje5-0005QQ-Le
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 12:36:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36bcc168cdaso35371f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723048576; x=1723653376; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJ8LCe1+plhUUu6H9V2WEWLNxi6HPNP2OFWpG7Ub0sI=;
 b=GVrAXroylMbl4Ia+g4Or/yIiA6DAGt7g9/GSR3ipF2eogbGMKwXZqRgAKzAi3lEasb
 K4jqFptQW5L3uWDXHe8jRDTPrrLKZ7BEQQYA88tz6TsHP5cQ7CNvrscD6DWaz9MEFza/
 Cyn9NDO0Ij9/1nqXEenQXmhrFGkhzk0Cl+8+bJLdt5iYNYLAKZtZLwzqiHiE7UJVqURm
 FwIY74hCCTKT1NYqT3r7RgO015VdVAt6NWI8lMRIPvhJmc7gaRJ/af6TL5CKoG1JYLyZ
 8i8z/0DgZFi9/4g1x4i+9rtrLXwBmAc9VAZfvZC2JGv9VYXHKqvlIK7SGzx4UFILaX9s
 dBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723048576; x=1723653376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJ8LCe1+plhUUu6H9V2WEWLNxi6HPNP2OFWpG7Ub0sI=;
 b=s22OwxYiDgm9XLiyCBqnB1zgtCf+k0PWxeFMlSApPgsIhZnXo0BqV7cwu2E5qKvKGK
 3ALwu3Wc0JxMDriuRgoaRKSwZpYdtdUGN75iahOmlBOlB9KnxLu9Bb3JVvP136wK2MV4
 IJvYE1Qkr7hmpucsDHCTIlq6b7lW5SbIXqj9OoAltLSOkWUupjsNjykTa6u0C+9MbBxs
 62wSvqsTgQNriZCgyK/FhnYECrIVBv84jo7hKkjCfqUHN8gIKSalR0RJhGtVxPbyDIOc
 7kiau06XhPSb1ibVgcM79CjaApLM65aD5HZjhRCvg7Gliz+QnMTDew8XTGsvD9lSaGsK
 YqbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMUJE+5EcMERv2bgAgtPRdc5DAvlw+lwVC6SK1yGTP2o2udMccs4NIx5m0h141aT/1gvEG/qBkdDWzUwj10joY4Z88kZY=
X-Gm-Message-State: AOJu0YxdCpkYwD0EdQImsVNqfaDHBpZqIl6vp+fShs9AIevPKlWzdP3f
 3CgYJAUOoXB5xpmx+wK+YLuBzxbex3SRzoaWtOlZbsEVZYieCEIenvZ9qe+3F+2A21Uf9EYoDyz
 /whRx0zvI64dQmj2rnKwo5HGdtxI8rulxKWqy
X-Google-Smtp-Source: AGHT+IErbkqXI8kkxAfYk+pkz/huGNKrg2+PkMX8HACm6/0OFr7t63CpGY6378rTDyo9Vjg/cL5HEWR7efHDXz4Tub0=
X-Received: by 2002:a5d:6945:0:b0:360:75b1:77fb with SMTP id
 ffacd0b85a97d-36bbc0e0c33mr14663912f8f.8.1723048575568; Wed, 07 Aug 2024
 09:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-5-tavip@google.com>
 <87sevhrbjm.fsf@draig.linaro.org>
 <CAGWr4cTPqtzEvbd5s7xfMOzid90Gje6NSTGw1qR7r=Ao0xeAcw@mail.gmail.com>
 <ea6d7058-1460-49f2-967f-666650de1cce@linaro.org>
In-Reply-To: <ea6d7058-1460-49f2-967f-666650de1cce@linaro.org>
From: Octavian Purdila <tavip@google.com>
Date: Wed, 7 Aug 2024 09:36:04 -0700
Message-ID: <CAGWr4cSUG4Yh=ynrO8A7KNiDo2RRRnc75PNMiboZOK+ts8X4Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/23] hw/arm: add SVD file for NXP i.MX RT595
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, jsnow@redhat.com, 
 crosa@redhat.com, bleal@redhat.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=tavip@google.com; helo=mail-wr1-x42d.google.com
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

On Wed, Aug 7, 2024 at 4:24=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 6/8/24 22:31, Octavian Purdila wrote:
> > On Tue, Aug 6, 2024 at 7:06=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
> >>
> >> Octavian Purdila <tavip@google.com> writes:
> >>
> >>> Picked from:
> >>>
> >>> https://github.com/nxp-mcuxpresso/mcux-soc-svd/blob/main/MIMXRT595S/M=
IMXRT595S_cm33.xml
> >>>
> >>> NOTE: the file is truncated to keep the email size reasonable. Please
> >>> use the link above and download the full file if you want to try out
> >>> the patch.
> >>>
> >>> Signed-off-by: Octavian Purdila <tavip@google.com>
> >>> ---
> >>>   hw/arm/svd/MIMXRT595S_cm33.xml | 224052
> >>> ++++++++++++++++++++++++++++++
> >>
> >> I guess one thing we need to decide is if the source XML should live i=
n
> >> the repository as the preferred method of making changes or just the
> >> translations generated by the tool.
> >>
> >
> > I think we might want to store the XML in the qemu repo, even if we
> > don't use it to generate the header files at compile time. This avoids
> > issues with the original XML moving, going away, changed in
> > incompatible ways, etc.
>
> Until now we tracked external sources with git submodules or meson
> wrap files (see commit 2019cabfee) forked into our GitLab namespace
> (https://gitlab.com/qemu-project/) at a particular commit, so if
> the external project is modified, we aren't disturbed, or have to
> adapt our source to update the submodule. Isn't it good enough?
>

Yes, this should definitely work. Thanks for pointing out the wrap
files, I'll give it a try.

> >
> > As for generating the headers at compile time, I don't have a strong
> > preference. I like it because there is slightly less work to do and it
> > avoids dealing with resolving changes on both the SVD and the
> > generated headers. For example, the initial headers are committed,
> > then some changes are done directly to the headers and then we want to
> > pick up a new SVD from the vendor to support a new hardware revision.
> >
> > There are disadvantages as well: pysvd dependency for building qemu,
> > hard to review if the vendor dumps a new version with lots of changes
> > and we want to update to it for a new hardware revision, slight
> > increase in build time.
> >
> >>>   1 file changed, 224052 insertions(+)
> >>>   create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml
> >>>
> >>> diff --git a/hw/arm/svd/MIMXRT595S_cm33.xml b/hw/arm/svd/MIMXRT595S_c=
m33.xml
> >>> new file mode 100644
> >>> index 0000000000..8943aa3555
> >>> --- /dev/null
> >>> +++ b/hw/arm/svd/MIMXRT595S_cm33.xml
> >>> @@ -0,0 +1,1725 @@
> >>> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
> >>> +<device schemaVersion=3D"1.3" xmlns:xs=3D"http://www.w3.org/2001/XML=
Schema-instance" xs:noNamespaceSchemaLocation=3D"CMSIS-SVD.xsd">
> >>> +  <vendor>nxp.com</vendor>
> >>> +  <name>MIMXRT595S_cm33</name>
> >>> +  <version>1.0</version>
> >>> +  <description>MIMXRT595SFAWC,MIMXRT595SFFOC</description>
> >>> +  <licenseText>
> >>> +Copyright 2016-2023 NXP
> >>> +SPDX-License-Identifier: BSD-3-Clause
> >>> +  </licenseText>
> >>
> >> This certainly seems compatible. XML is not the medium I personally
> >> would have chosen as a register specification language but I guess the=
re
> >> are no other alternatives?
> >>
> >
> > I agree that the choice of XML is unfortunate but I am not aware of
> > alternatives, this is what vendors will provide.
>

