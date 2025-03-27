Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D557C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txm6C-0001GK-Mf; Thu, 27 Mar 2025 08:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1txm69-0001G0-Gs
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1txm67-0004ba-Dd
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743077554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfubVpgqXGRI9eYlcuGKHQOk0qdzRxhF/TXCN7Equwo=;
 b=X11wRqEG7SDzuLiMm7reMi3TYb8fLVOHrhHprn4EfzbDADz96JAqI0Mqb0zPxpTokLdr3u
 T49d96YuzT6C4vg7y521RJ7zHIN5tCMjyus8jjHL0KLwEj4n3p/3W8OmU3ubSm2caD7M97
 p5Av21W2ZRvsghBbZEjv7mspxKbMbuE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-kSg3w0bSNbi1R54peJoqxg-1; Thu, 27 Mar 2025 08:12:33 -0400
X-MC-Unique: kSg3w0bSNbi1R54peJoqxg-1
X-Mimecast-MFC-AGG-ID: kSg3w0bSNbi1R54peJoqxg_1743077552
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so97406566b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 05:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743077552; x=1743682352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfubVpgqXGRI9eYlcuGKHQOk0qdzRxhF/TXCN7Equwo=;
 b=iJcGDd+jZ67y/lEXcyM6GGKm2eSjGpGn68Q0YfZUYRPAtNQK97YNqjzIhOFYznQHxg
 RZYLfM12OATgxwF+cZutC/sQyS/nk8fGxSvZ00Ki4qUKao9egIv+A1uFygFg5Qqy4l4r
 CZ1+XcAb9IvIavC/QQsMYfrIqVkmzr5ZTQItmOmB2cNKWSJB7nrTjHv+HmtXOK66kAOS
 ZprXCL1riq8TOhvsnxitkUcdY4EiUE7j1GuM0K65inWJh0uPTE4uurpz6P3fGv17BCJ4
 9ZlDqWvazP3G9d0XMiq2bx1IGvPYfh/a29fsXr56axIcWGzwj5J4csKAHxRiJAXDRERY
 Z5vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwL53tkF4tjc3SZJ9g6vzf+wHMhSBSu8mtOnaCgq8jtwM/+krO1cAYv9wTIk7S5ozUjhptH+IZvdhg@nongnu.org
X-Gm-Message-State: AOJu0Yz1bYbmhD591m1qd1kQxrUROHnTL/Mmko7oIH8ou58NfRsranfr
 nb9rGLOlDDVZ7GknHwTSpF2WKJBuR0ft1oCS010p6naqnZlSvX0zTJAAry/hX0ot4FvCNQwk6TL
 aK2z/cGB1HOCc98eqOHVh9Xhm9rtkIkcGg0N3VAnm4ilJz6w7LcYgnbfjzT3prEtnbALOdYGi7X
 sPUbKCOPBCouzI1eAxBlwVavbWkNE=
X-Gm-Gg: ASbGncupAQ3jOQMxYzRExxRuhcdoVYTEZ5f5DMw+V0g4SLbzi/HfPSvSn6R7ReF6T/7
 /aMZfEIiPrT9A/IbahG0wYI3KTMaVjcm8WqhQ6FpqOZwngkjh5UanKeOpXp9+F68gS4hnUdlA
X-Received: by 2002:a17:906:c148:b0:ac3:f0b7:6ad3 with SMTP id
 a640c23a62f3a-ac6fb0fd638mr311990066b.40.1743077551543; 
 Thu, 27 Mar 2025 05:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHzjle6VYrmWZwvVnuRGZu759JTXsrL+XYCKKiOuBoJDeCM3Lp8Uj4xVK6h3Eg7tVQcwGSVax2W0JLdQ5dRvA=
X-Received: by 2002:a17:906:c148:b0:ac3:f0b7:6ad3 with SMTP id
 a640c23a62f3a-ac6fb0fd638mr311985966b.40.1743077551005; Thu, 27 Mar 2025
 05:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
 <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
 <53jhridwtejsuy4qojjr66rcjdebnyarwke4bs3m3w2afmqhe6@pab5zfyo46fx>
 <4f6a21a9-746e-45ac-88c7-dc0204480a86@amazon.com>
 <kmqzqeaatk3iyrpl4tvfxtfv6gefyusxpyxtz5bollw7jlp3wk@5c4zawrzehwq>
 <d79cff63-324f-4624-aef3-b6570cdb23e2@amazon.com>
 <rtbmlitus6unzibiatblquot2bthx4dmozbxgcbovisial6qar@konful7gzrsz>
 <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
In-Reply-To: <6d815066-9977-4683-a2d5-871dda3e5369@amazon.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 27 Mar 2025 17:42:18 +0530
X-Gm-Features: AQ5f1Joe91tPCIqSX_4Ey6DMexNoY_T0WUsk6aIehWOA7g7lNxDr0Uy_HsdQfyE
Message-ID: <CAK3XEhNMGYmLU0JBxN87B8S58NKfw8K7edy-1Rt=XWZydvTKEQ@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Alexander Graf <graf@amazon.com>
Cc: Gerd Hoffman <kraxel@redhat.com>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Mar 26, 2025 at 8:52=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
>
> On 26.03.25 13:27, Gerd Hoffman wrote:
> >    Hi,
> >
> >> The problem is that add-ons are
> >>
> >>    1) Separate binaries. So you need to match multiple files.
> >>    2) In this case, get generated out of the vendor (RH)'s control in =
a
> >> one-off fashion.
> >>
> >> I don't think "signing" is the correct way to address the latter. It's
> >> rather hashing. But I agree with you that it could (should?) be hashin=
g at
> >> the PE loader level similar or identical to Secure Boot rather than a
> >> separate hashing mechanism.
> > Secure boot offers signing and hashing.  You can add both signing
> > certificates and authenticode hashes to 'db'.
> >
> >>> Not sure I understand the point you are trying to raise.  Add-ons
> >>> signatures are checked too.
> >> 2 points here here:
> >>
> >>    1) With add-ons, there are multiple binaries. We can't only pass a =
single
> >> one.
> > Sure.  You'll go need some container, say a cpio archive, but that is
> > something vmfwupdate loader and loaded firmware have to agree on and no=
t
> > something we have to worry about too much for the vmfwupdate interface
> > design.
> >
> >>    2) The security posture of the system may be different between 2 va=
lidly
> >> signed images. Think of Daniel's example of verbose kernel output. May=
be I
> >> consider verbose kernel output already inacceptable, while RH thinks i=
t's an
> >> ok posture to have. The user needs to have the chance to differentiate
> >> between a system booted with or without verbose kernel output.
> > You easily get that by looking at the vTPM measurements.  So not sure
> > what you are asking for, do you want be able to also do that without a
> > vTPM?
>
>
> All of this should work without vTPMs. Why add complexity when you don't
> need it? The industry is already struggling to deal with TPMs alone.
> There are way too many potential holes in a solution where you first
> have to reason about the integrity of your TPM before you can trust it.
> All of the vTPM in SEV-SNP talk is a house of cards I'm happy to push
> (blow to keep the analogy?) against as hard as I can.
>
>
> >
> >>>> So we need some equivalent of a hash page.
> >>> Ok.  So two opaque blobs, one which is measured into the launch
> >>> measurement and one which is not?  That gives you the option to pass
> >>> around hashes (or any other data) and leave a trace in the launch
> >>> measurement should you need that.
> >> Yes, I think you want to have one or multiple pages with what effectiv=
ely is
> >> a db append variable update blob.
> > Makes sense to me.
> >
> >> Or even a full variable store blob.
> > Hmm, not sure.  I'd rather go for passing efi signature database
> > appendix, probably for both allow ('db') and deny ('dbx').  That is
> > going to work better I think, variable store format is an
> > firmware-internal implementation detail I'd avoid encoding that in
> > some interface.
> >
> >> The IGVM should dictate the physical location of that blob so that you
> >> can precalculate the launch digest with the blob included.
> > Hmm, right.  Physical location matters for the launch measurement, so
> > adding opaque_measured_addr to struct vmfwupdate isn't going to work
> > very well.
> >
> >> Ukify.py then generates the blob along with the FUKI.
> > Doesn't fly from a distro point of view.  The UKI is signed, so RH ship=
s
> > that and the customer can't modify it to update the blob, say with some
> > additional hashes for 'db'.
>
>
> I don't follow. Is RH going to ship a UKI or a FUKI? And if RH ships the
> UKI, ukify could still take a UKI as input and generate a FUKI based on
> it, no? During that process, it would generate a db which gets put at a
> fixed location in RAM so the (RH provided) firmware picks it up and
> validates the UKI it loads is exactly that one UKI.
>
> We can extend that with an additional signature flow, where the ukify
> generated db contains a signature for the UKI instead. But I would
> generally advise against optimizing for certificate based flows until
> revocation is sorted out. And since revocation requires a new dbx in
> this scheme and that means a different launch digest per revocation, you
> may as well just directly only use hashes.
>
>
> > Effectively we need something roughly equivalent to shim's MokList.  Th=
e
> > distro ships a default configuration (like the cert compiled into the
> > shim binary) which works fine for most people.  For IGVM that would be =
a
> > default efi variable store compiled into the firmware binary.
>
>
> This only makes sense in a world where RH ships an SVSM and that's all
> you want to attest. But that's a different flow from what we describe
> here. To actually get workload attestation, you need to include your
> rootfs in the attestation. And the only entity that can do that is the
> end customer. And they will typically do that through something like
> dm-verity or fs-verity and a hash provided on the kernel command line.
>
>
> >
> > If you need additional stuff (like the signer cert for the nvidia
> > driver) there must be some way to add hashes and certificates to db/dbx=
.
> >
> > Does it make sense to simply move the firmware update sections from the
> > main UKI to an add-on?  That would allow customers to easily use their
> > own if they wish, without breaking the RH signature on the UKI.
>
>
> I'm still not convinced "RH signature" is a useful marker at execution
> time of confidential workloads. It may be an interesting one at assembly
> time, but after that we're folding everything into a single launch
> digest anyway, for good reasons.
>
>
> >
> >> I agree, from a vmfwupdate point of view, we would basically have an I=
GVM.
> >> The IGVM describes 2 special page (ranges?): One for the CPUID special=
 page,
> >> one for the variable store seed. To precalculate the launch digest you=
 would
> >> need the firmware IGVM, and the seed blob.
> > Guess we'll have to update the IGVM format spec for that, so we have
> > page types for 'db' and 'dbx'.  With that it should be possible to load
> > the igvm, find + update the pages + write it out again.  Then wrap it
> > into an UKI add-on + copy to ESP.
> >
> > RH default igvm/add-on would simply have empty 'db' and 'dbx' pages.
> >
> > Looks workable to me.
>
>
> I would personally consider the "RH binary adds RH signature into binary
> by default" a backdoor, but that's you call :).
>
> I agree with the plan to amend the IGVM spec with the UEFI variable
> update page. I don't think it should be "db" and "dbx" pages. It should
> be a more generic. In fact, why not make it a loader UEFI (PE) binary?
> The binary installs the db/dbx updates and chain loads the actual
> payload UKIs using a file format that's private between the loader
> binary and the sd-boot stub.
>
>
> >
> >> All unauthenticated data, such as locations of the UKI and its add-ons=
 gets
> >> passed as parameter to the firmware IGVM.
> > i.e. have a IGVM parameter for opaque_addr + opaque_size instead of
> > placing this in the vmfwupdate struct?
>
>
> It would be a pretty natural fit for it, no?
>
>
> >
> > take care,
> >    Gerd
> >
> > PS: in Berlin tomorrow?
>
>
> Yup, let's sync up! :)

Unfortunately I won't be there. Vitaly will be. So you three can sync
along with anyone else who is there. We should have a call after for
those who are not lucky to be attending.


