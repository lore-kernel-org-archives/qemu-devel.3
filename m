Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DDDC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKMu-0006NX-Rv; Thu, 03 Jul 2025 09:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXKMs-0006MG-9G
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:52:50 -0400
Received: from smtp-out-60.livemail.co.uk ([213.171.216.60]
 helo=dkim.livemail.co.uk)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@randomman.co.uk>)
 id 1uXKMk-0005yF-IF
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:52:47 -0400
Received: from smtp.livemail.co.uk (unknown [10.44.132.83])
 by dkim.livemail.co.uk (Postfix) with ESMTPS id B849BA00D2;
 Thu,  3 Jul 2025 14:52:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=randomman.co.uk;
 s=livemail2; t=1751550757;
 bh=E15LJTjGHZP0XyS/tEeUF10rAXEIoLtg64+AjJ3rt+Y=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=b3QWZ7Bx+XTXA9qUUssYqoyAgUkny/kQm7DGWXk18+j7YocRITV3ey2HmOwz8Gqnj
 TcsX86JSLzFlH6AC6npm1I5dZ4qLm9xYVm9jEs6fuDjF4vYFzJGUj0b+8TfSsEHTYk
 EKfDWJPtHmYEn28xL/bauSUffLlRBZTy1mrxbtyg=
Received: from [172.22.54.5] (unknown [145.40.191.116])
 (Authenticated sender: roy.hopkins@randomman.co.uk)
 by smtp.livemail.co.uk (Postfix) with ESMTPSA id 3270F40261;
 Thu,  3 Jul 2025 14:52:33 +0100 (BST)
Message-ID: <b4800e3cc61e4531d96e7c4a2bb2f0841f98c98c.camel@randomman.co.uk>
Subject: Re: [PATCH v8 13/16] backends/igvm: Process initialization sections
 in IGVM file
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P .
 Berrange" <berrange@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Gerd Hoffman <kraxel@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Date: Thu, 03 Jul 2025 14:52:32 +0100
In-Reply-To: <CAK3XEhPJncqwL6V6KOhOGLHOjSy-9OQTRWyTPQBP0NsHeVxr6A@mail.gmail.com>
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
 <12d0e71fd1b37ae132f78498d497cb72b90da5d1.1749820158.git.roy.hopkins@randomman.co.uk>
 <CAK3XEhPJncqwL6V6KOhOGLHOjSy-9OQTRWyTPQBP0NsHeVxr6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
Received-SPF: pass client-ip=213.171.216.60;
 envelope-from=roy.hopkins@randomman.co.uk; helo=dkim.livemail.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 2025-06-27 at 16:58 +0530, Ani Sinha wrote:
> On Fri, Jun 13, 2025 at 8:52=E2=80=AFPM Roy Hopkins <roy.hopkins@randomma=
n.co.uk> wrote:
> >=20
> > The initialization sections in IGVM files contain configuration that
> > should be applied to the guest platform before it is started. This
> > includes guest policy and other information that can affect the securit=
y
> > level and the startup measurement of a guest.
> >=20
> > This commit introduces handling of the initialization sections during
> > processing of the IGVM file.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Gerd Hoffman <kraxel@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > =C2=A0backends/igvm.c | 21 +++++++++++++++++++++
> > =C2=A01 file changed, 21 insertions(+)
> >=20
> > diff --git a/backends/igvm.c b/backends/igvm.c
> > index 2a31021d44..ebdb4594d1 100644
> > --- a/backends/igvm.c
> > +++ b/backends/igvm.c
> > @@ -786,6 +786,27 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialG=
uestSupport *cgs,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0 header_count =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 igvm_header_count(ctx.file,=
 IGVM_HEADER_SECTION_INITIALIZATION);
> > +=C2=A0=C2=A0=C2=A0 if (header_count < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
p,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "In=
valid initialization header count in IGVM file. Error code: %X",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hea=
der_count);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup_parameters;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 for (ctx.current_header_index =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx.current_header_in=
dex < (unsigned)header_count;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx.current_header_in=
dex++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IgvmVariableHeaderType type=
 =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 igv=
m_get_header_type(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx.current_header_index);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qigvm_handler(&ctx, typ=
e, errp) < 0) {
>=20
> So the next patch, patch #14 actually defines the handler.
>=20
> @@ -92,6 +135,10 @@ static struct QIGVMHandler handlers[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qigvm_directive_environment_info },
> =C2=A0=C2=A0=C2=A0=C2=A0 { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_=
DIRECTIVE,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qigvm_directive_required_memory },
> +=C2=A0=C2=A0=C2=A0 { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIV=
E,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qigvm_directive_snp_id_block },
> +=C2=A0=C2=A0=C2=A0 { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALI=
ZATION,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qigvm_initialization_guest_policy },
> =C2=A0};
>=20
>=20
> So I think patch #14 should come before this patch in the series.
>=20

This was deliberately placed before #14 as it introduces the mechanism for =
processing
initialization sections, allowing future patches to then add sections as ne=
cessary.
Patch #14 then uses this new capability to handle guest policy. This patch =
does
compile successfully without patch #14 being applied.=20

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o cleanup_parameters;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0 /*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Contiguous pages of data with compatib=
le flags are grouped together in
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * order to reduce the number of memory r=
egions we create. Make sure the
> > --
> > 2.43.0
> >=20
>=20


