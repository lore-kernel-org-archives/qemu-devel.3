Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E6C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxyq-0003Yy-GZ; Wed, 20 Mar 2024 11:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rmxyo-0003YL-MV
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:35:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rmxym-00049x-2g
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710948945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncwlsCc0iSoSYgVPNgzSGOoPf7MOE0YxEDftcziW/+U=;
 b=gjDovo4SWUKfXyYu3rIyl59Jzkzx58cVM1kFdGK4i87bROZuGqRwn5DtVYt1jDyD6ZHl/i
 JTwYGI76s12dvPKx++t9J9Ar6DjXHEfBBjqWh9waKrr2MYknPLFlxr36o9Mr9KAW7/TfFi
 X0kJ3QStLIqSwEbT02R7aym0LV01//U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-pwVCp3SDNbWZfnucyi6bsw-1; Wed, 20 Mar 2024 11:35:43 -0400
X-MC-Unique: pwVCp3SDNbWZfnucyi6bsw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1dddb2b6892so59690555ad.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710948942; x=1711553742;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncwlsCc0iSoSYgVPNgzSGOoPf7MOE0YxEDftcziW/+U=;
 b=OuHCVgVx0lhDSxz0vosMSliKuCihO3Pw3prgr4KTS+4ZHFRnqaI9vEYmU3d9bnl78o
 RKOpUwmzl0ax5d/D8OkJT1ghZvCeGflYfqxuDVqQdw7doot9T+0oqVRRHMyXW67B4XlX
 N2EoJCTXNR3seQymSgdKMnqCsdVi3io/C1cA0ZhWxspbQ4ASad459CrwrPZg30fXhYWk
 26mEJQU2MLHUNTJMV708VBCvCYiUwa4P0wZSasaTI7Gb8vlxomC40oUVqPUtnd9jtfMO
 HMHX05APtwFXJRwErKbvbu+eK5dekRn0iC08oEv9zI4zxKkP8bmkYhKbsaB1eW6zFK4i
 ms6Q==
X-Gm-Message-State: AOJu0YwK3e+kWl6D1XUXsh7h7XFiDH3uIcBMuzOQzX5TrElA46fBJgHI
 oprqNL3XTIIlIjm2PIBwwGGMvH2qBYI4f0+VxOvhEXzx+nB5mz81ySXJbTX2EJA7NizGk1GJ/rY
 XmDx/LE8JUiIvGiACRiDazPNbTcHZ0A8u0qUyKoBJkbk7nDYFGQKV
X-Received: by 2002:a17:902:e542:b0:1e0:2685:8fbe with SMTP id
 n2-20020a170902e54200b001e026858fbemr11306600plf.4.1710948942241; 
 Wed, 20 Mar 2024 08:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkx8oct9iJAEFOTbhBciWs7zBqHWi0I9+fRnByKnkXC3MLg6MUV1DkGpA62Yu83UZqj0m+vg==
X-Received: by 2002:a17:902:e542:b0:1e0:2685:8fbe with SMTP id
 n2-20020a170902e54200b001e026858fbemr11306556plf.4.1710948941698; 
 Wed, 20 Mar 2024 08:35:41 -0700 (PDT)
Received: from smtpclient.apple ([203.212.247.153])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a170903230900b001dda64281a9sm6886580plh.85.2024.03.20.08.35.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Mar 2024 08:35:41 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH 0/9] Introduce support for IGVM files
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <cover.1709044754.git.roy.hopkins@suse.com>
Date: Wed, 20 Mar 2024 21:05:24 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?J=C3=B6rg_Roedel?= <jroedel@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5152161-F0F5-4C76-A8DE-A7858B71C3D6@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
To: Roy Hopkins <roy.hopkins@suse.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 27 Feb 2024, at 20:20, Roy Hopkins <roy.hopkins@suse.com> wrote:
>=20
> Hi everyone,
>=20
> This initial patch series submission adds the capability to configure
> confidential guests using files that conform to the Independent Guest =
Virtual
> Machine (IGVM) file format. The series is based on the master branch =
commit
> 1b330da. Alternatively, the series is available here:
> https://github.com/roy-hopkins/qemu/tree/igvm_master_v1
>=20
> I look forward to welcoming your comments!
>=20
> Why do we need Independent Guest Virtual Machine (IGVM) files?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> IGVM files describe, using a set of directives, the memory layout and =
initial
> configuration of a guest that supports isolation technologies such as =
AMD
> SEV-SNP and Intel TDX. By encapsulating all of this information in a =
single
> configuration file and applying the directives in the order they are =
specified
> when the guest is initialized, it becomes straightforward to =
pre-calculate the
> cryptographic measurement of the guest initial state, thus aiding in =
remote
> attestation processes.
>=20
> IGVM files can also be used to configure non-standard guest memory =
layouts,
> payloads or startup configurations. A good example of this is to use =
IGVM to
> deploy and configure an SVSM module in the guest which supports =
running at
> multiple VMPLs. The SVSM can be configured to start directly into =
32-bit or
> 64-bit code. This patch series was developed with this purpose in mind =
to
> support the COCONUT-SVSM project:
> https://github.com/coconut-svsm/svsm
>=20
> More information and background on the IGVM file format can be found =
on the
> project page at:
> https://github.com/microsoft/igvm
>=20
> What this patch series introduces
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This series adds a build-time configuration option (--enable-igvm) to =
add
> support for launching a guest using an IGVM file. It extends the =
current
> ConfidentialGuestSupport object to allow an IGVM filename to be =
specified.
>=20
> The directives in the IGVM file are parsed and the confidential guest =
is
> configured through new virtual methods added to the =
ConfidentialGuestSupport
> object. These virtual functions have been implemented for AMD SEV and =
AMD
> SEV-ES.
>=20
> Many of the IGVM directives require capabilities that are not =
supported in SEV
> and SEV-ES, so support for IGVM directives will need to be considered =
when
> support for SEV-SNP, TDX or other technologies is introduced to QEMU. =
Any
> directive that is not currently supported results in an error report.
>=20
> Dependencies
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In order to enable IGVM support, you will need the IGVM library =
installed.
> Instructions on building and installing it can be found here:
> https://github.com/microsoft/igvm/tree/main/igvm_c
>=20
> As mentioned above, this series was developed as part of the effort =
for
> COCONUT-SVSM. COCONUT-SVSM requires support for AMD SEV-SNP which is =
not
> available in current QEMU. Therefore this series has also been applied =
on top of
> the AMD SEV-SNP branch =
(https://github.com/AMDESE/qemu/tree/snp-v3-wip). You can
> find that version of the series here:
> https://github.com/roy-hopkins/qemu/commits/snp-v3-wip-igvm_v2/
>=20
> Generating IGVM files
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> To try this out you will need to generate an IGVM file that is =
compatible with
> the SEV platform you are testing on. I've created a tool that can =
create a
> simple IGVM file that packages an OVMF binary for AMD SEV or AMD =
SEV-ES. The
> tool is available here:
> https://github.com/roy-hopkins/buildigvm
>=20
> I have tested this on an AMD EPYC Genoa system configured to support =
SEV. Both
> SEV and SEV-ES have been tested using IGVM files generated using the =
buildigvm
> tool. The SEV-SNP alternative patch set has also been tested using =
COCONUT-SVSM.

Could you please also CC me in this patchset please? Thanks.

>=20
> Roy Hopkins (9):
>  meson: Add optional dependency on IGVM library
>  backends/confidential-guest-support: Add IGVM file parameter
>  backends/confidential-guest-support: Add functions to support IGVM
>  backends/igvm: Implement parsing and processing of IGVM files
>  i386/pc: Process IGVM file during PC initialization if present
>  i386/pc: Skip initialization of system FW when using IGVM
>  i386/sev: Refactor setting of reset vector and initial CPU state
>  i386/sev: Implement ConfidentialGuestSupport functions for SEV
>  docs/system: Add documentation on support for IGVM
>=20
> backends/confidential-guest-support.c     |  69 +++
> backends/igvm.c                           | 718 ++++++++++++++++++++++
> backends/meson.build                      |   4 +
> docs/system/igvm.rst                      |  58 ++
> docs/system/index.rst                     |   1 +
> hw/i386/pc.c                              |  12 +-
> hw/i386/pc_piix.c                         |   4 +
> hw/i386/pc_q35.c                          |   4 +
> include/exec/confidential-guest-support.h | 107 ++++
> include/exec/igvm.h                       |  35 ++
> meson.build                               |   8 +
> meson_options.txt                         |   2 +
> qapi/qom.json                             |  13 +
> qemu-options.hx                           |   8 +-
> scripts/meson-buildoptions.sh             |   3 +
> target/i386/sev.c                         | 365 ++++++++++-
> target/i386/sev.h                         | 110 ++++
> 17 files changed, 1489 insertions(+), 32 deletions(-)
> create mode 100644 backends/igvm.c
> create mode 100644 docs/system/igvm.rst
> create mode 100644 include/exec/igvm.h
>=20
> --
> 2.43.0
>=20
>=20
>=20


