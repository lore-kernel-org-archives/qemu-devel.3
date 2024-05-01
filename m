Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802BFC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 08:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s25if-0003zm-6v; Wed, 01 May 2024 04:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1s25id-0003zL-NZ
 for qemu-devel@nongnu.org; Wed, 01 May 2024 04:53:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1s25ib-0006Lh-EW
 for qemu-devel@nongnu.org; Wed, 01 May 2024 04:53:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41adf3580dbso3137055e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714553614; x=1715158414; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JcQJFLOmR7M8dbkWHELTsCUEk8OW8F2C3hE4oupDTxQ=;
 b=GeHcQc/EQuV5U6KSE9gGlKsP67mZWZHYlcv7A9kpw7l7xYCqqDe8oFafxQ6LiZeii/
 PfEPPXcJv5G/KQxVUyvGzpxrNZS6ClcCXPWrvjkBQxSevxg5cASSP/HYFHRzExFNfi78
 t4m9HM+0fhVkbNqPNtTT1ypu7lP8GQBTnZHPUvAL4BxVDuBtQKPW5EnH6Oh5ROaULqcZ
 HIlFNccafzFIO4dOX4gsQ2Dn1v3RFBVjBZqFxDFSaL0LS9fyfDIgkdEYPAfgb+oCgWMm
 Ea5fniBeo//S7UzJaDabtDQ65OpM0EzVAQ9lMMB1R6JaC6MGa/Arb668GwMVWt73MDHD
 d/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714553614; x=1715158414;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcQJFLOmR7M8dbkWHELTsCUEk8OW8F2C3hE4oupDTxQ=;
 b=h6p8QzR1bJwCUa9Jo8s/lK5VHlCJMtyEOoCbIwKnGpDHcMuGTDHa2xMrxsRKuYX70M
 ocT+IrvUaRsv+4bO4JhgwG5pDFMD7SyHrQ15NCvCIQYFEACuUZgVb/vrK9Av6jHzjLDi
 Cy0JUwzTYIepaFajpGETXh2NbLbbsWc8EiXiZ3/VqvYWHGFpegU7DnlYFTnoo7QtCjCB
 gTRQGedJ6s9SVxM7CZvwO2xmjNagVNtqUFW8/kIBYrSW6SJTcQg+Bej+n348JIPLeSTe
 NwnGjP5O8XFkatpbQoLBnx5FnhFeaful3d3LhPdI/1B5ltxxc+zPPJ+sX5VpGPeHv0Ab
 Flqg==
X-Gm-Message-State: AOJu0YxTSxYR7H9dGeBcWc2NNBNkrzAOL7boLYEdjHHV15cDwUWu32nv
 K6L6I0vDriFk3M0Bagi6Gu53lr1Yek1SFhK+P4gVvBmSdo/4SsNRAec2BkNJy1U=
X-Google-Smtp-Source: AGHT+IGFwTd0jZUjXqjpcu6+o7rYzedlP7W9fCuEdZU606uzfNaO5DEYVJ8DmnEIyc6thQrHrGnhow==
X-Received: by 2002:a05:600c:3510:b0:41b:e55c:8dc1 with SMTP id
 h16-20020a05600c351000b0041be55c8dc1mr4086334wmq.20.1714553614465; 
 Wed, 01 May 2024 01:53:34 -0700 (PDT)
Received: from [192.168.7.249] ([145.40.191.116])
 by smtp.gmail.com with ESMTPSA id
 n44-20020a05600c502c00b0041bd85cd3f2sm1523521wmr.19.2024.05.01.01.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 01:53:34 -0700 (PDT)
Message-ID: <48d1549293dda04b4dc1a7e962a3c29bef888354.camel@suse.com>
Subject: Re: [PATCH v2 01/10] meson: Add optional dependency on IGVM library
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel <jroedel@suse.com>
Date: Wed, 01 May 2024 09:53:33 +0100
In-Reply-To: <Zh6HkspE45lh8Dvu@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <0da76c3956bf776a9bbb0e18a1813b8dc5e20bf8.1712141833.git.roy.hopkins@suse.com>
 <Zh6HkspE45lh8Dvu@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::32d;
 envelope-from=roy.hopkins@suse.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 2024-04-16 at 15:13 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 03, 2024 at 12:11:32PM +0100, Roy Hopkins wrote:
> > The IGVM library allows Independent Guest Virtual Machine files to be
> > parsed and processed. IGVM files are used to configure guest memory
> > layout, initial processor state and other configuration pertaining to
> > secure virtual machines.
>=20
> Looking at the generated header file for the IGVM library, I see
> some quite bad namespace pollution. eg igvm_defs.h has:
>=20
> typedef uint64_t u64_le;
> typedef uint32_t u32_le;
>=20
> #define UINT32_FLAGS_VALUE(x) *((uint32_t*)&(x))
>=20
> #define MAKE_INVALID_IMPL(x, y) x##y
> #define MAKE_INVALID(x, y) MAKE_INVALID_IMPL(x, y)
> #define INVALID MAKE_INVALID(INVALID_, __COUNTER__)
>=20
> enum IgvmPageDataType {
> =C2=A0 NORMAL =3D 0,
> =C2=A0 SECRETS =3D 1,
> =C2=A0 CPUID_DATA =3D 2,
> =C2=A0 CPUID_XF =3D 3,
> };
>=20
> enum IgvmPlatformType {
> =C2=A0 NATIVE =3D 0,
> =C2=A0 VSM_ISOLATION =3D 1,
> =C2=A0 SEV_SNP =3D 2,
> =C2=A0 TDX =3D 3,
> };
>=20
>=20
>=20
> enum IgvmVariableHeaderType {
> =C2=A0 INVALID =3D 0,
> =C2=A0 ...
> }
>=20
> There are soo many more examples in igvm_defs.h that I won't
> list them all here.
>=20
>=20
> These are all way too generic as names to be exposing in library
> header file. We may be lucky right now that these definitions
> don't clash with anything else defined in the compilation namespace
> of the consuming application, but that's a bad bet to make long
> term.
>=20
> IMHO this really needs fixing before there's any use of this igvm
> library, since fixing it will be a backwards-incompatible change.
>=20
> Essentially everything in the header needs to have an 'IGVM/Igvm/igvm'
> prefix on it.
>=20
> With regards,
> Daniel

Daniel,

I've just submitted a patch for the IGVM C library to fix this, ensuring
everything is now uniquely identified with an IGVM_/Igvm_ prefix and fixing=
 some
of the other issues in the generated header file:
https://github.com/microsoft/igvm/pull/52

I'll update this with the changes once merged.

Thanks,
Roy

