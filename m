Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD1AC77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 15:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVAtC-0006dp-O3; Fri, 27 Jun 2025 11:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uVAt5-0006dA-S5
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uVAt1-0000oI-Fo
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751037666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idp2zCBDw8wYxtmgXKK2lGhlSAoKLwJ9F2rpmIF0feE=;
 b=XYtkW3t71NM48Am8jLxA7xPPlA/Pl1hCXcQNfFQuYgoaISlKO5Jz5nHs8BLBdYGyYhdz8F
 Mzs6rDRPccI/JsaQCfz0ApX49DO/G78J5/HSQlM/Vcwm4hqw0Bf8SG3+887iIRipvX6D1N
 0/JM1XBH5raLZKqlKqof3DI7FcLOsnc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-IzmYsAZJOlKpZ2HH4XZgaw-1; Fri, 27 Jun 2025 11:21:02 -0400
X-MC-Unique: IzmYsAZJOlKpZ2HH4XZgaw-1
X-Mimecast-MFC-AGG-ID: IzmYsAZJOlKpZ2HH4XZgaw_1751037661
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae0d76b4f84so173138566b.3
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 08:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751037661; x=1751642461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idp2zCBDw8wYxtmgXKK2lGhlSAoKLwJ9F2rpmIF0feE=;
 b=nJCBkNAgN16J/UmqvZw7SvryUiZSfEgIHPog+g7cO5YMClC6molsh3etaJ+VNcH5QL
 4XPUqk/2gBKHfJFNASrNFLllIdLSorLEXApdKsKfR11e5H+V+baPjDRrMyJCMwj42B3M
 k933RXGd3EXU+CztZdhP9bvDImZ6e3CM7SZti59wWEo92NJrq8qYzcWvSjw+CQo6aLqH
 ZB046EK9qxqJdEjuGxqjEMd2PNkWufxUhqU1lckehXUrGOa5+ZQk2CllThATbbHmROHf
 Sugh4f8h1uvBDPFvfdqxBXnOGiv+H19hcw3jeFJQ8SP0ayHycumzwDpzF6VeVjNJcjBD
 5KRA==
X-Gm-Message-State: AOJu0Yw4MYaVdmlXqTKD62Tnvkzxx4llEmryKKUj9M0XtNZfQYJNpNgl
 C38eQLm2S3LbXeN54WStIvPabk/H4AqpiBL5oX+Mwy4nryYceIZVCBdrckPm/vUjYBzUxablQxp
 kF1u5d1rmkErOy42/7xfoxsQevJvQYe3QsxUu73Rn809r/G5XPf/+TnTY5Rf59GrtFDfIlyk4RF
 jtdtjXvBdOcNdJhcOWvomAzpOMwuMgdnc=
X-Gm-Gg: ASbGncu+zciTjebigCHL6kvB3YWpcQL625UZWIuFegh5P+GLEhhlX8llgrJNxEh3zVM
 no958csyF0J/m3W96JqiPsN3XTj2eEG4g4r6aObKTWyMqjDU/1xofgNmzXOjbQkBjq7PytdiRp/
 0bOXfW
X-Received: by 2002:a17:906:ef07:b0:ae0:a590:bc64 with SMTP id
 a640c23a62f3a-ae34fdc37e1mr360872566b.18.1751037660623; 
 Fri, 27 Jun 2025 08:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGglEyPQzWKhR17NJkv2RUwL/kSW+ZeH2gEgDiMI/X9pAhqUmHS/OBaTBqAcZzIK6FQeXS4EpWlC+t5sqzbCsc=
X-Received: by 2002:a17:906:ef07:b0:ae0:a590:bc64 with SMTP id
 a640c23a62f3a-ae34fdc37e1mr360867966b.18.1751037660154; Fri, 27 Jun 2025
 08:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
In-Reply-To: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
From: Ani Sinha <anisinha@redhat.com>
Date: Fri, 27 Jun 2025 20:50:47 +0530
X-Gm-Features: Ac12FXz451u3LcqmLyaIbTGcQfYwJZPDWpg_UnVKuCsLW8S0g3EV0PpfTK-nwh0
Message-ID: <CAK3XEhO10vxTOknX16KpJhFxU_FN9H6XecPEBYb7hMA6V9qzdA@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Introduce support for IGVM files
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Gerd Hoffman <kraxel@redhat.com>, 
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 13, 2025 at 7:06=E2=80=AFPM Roy Hopkins <roy.hopkins@randomman.=
co.uk> wrote:
>
> Here is v8 of the set of patches to add support for IGVM files to QEMU. T=
his is
> based on commit d9ce74873a6a5a7c504379857461e4ae64fcf0cd of qemu.
>
> The previous version of this patch series [1] has only received a few com=
ments
> which are now addressed in this new version. Additionally, the series has
> benefited from additional reviews and testing from the community. Therefo=
re I
> am hoping that this will be the final version and rebase of this patch se=
ries.
>
> Suggestions have been received for adding support for setting CPU initial=
 state
> for non-confidential guests (Gerd) and for reorganization of the confiden=
tial-
> guest support modules (dhildenb). These suggestions have not been
> implemented in this version of the patch series, but I will look to imple=
ment
> them in a future patch series.
>
> The only functional change in this version is to fix an issue in patch 16=
/16
> where the pre-parsing of the IGVM file caused an error after rebasing.
> Additionally, commit metadata, version numbers and documentation changes =
have
> been made, as suggested in review comments.
>
> As always, thanks to those that have been following along, reviewing and =
testing
> this series. This v8 patch series is also available on github: [2]
>
> For testing IGVM support in QEMU you need to generate an IGVM file that i=
s
> configured for the platform you want to launch. You can use the `buildigv=
m`
> test tool [3] to allow generation of IGVM files for all currently support=
ed
> platforms. Patch 11/17 contains information on how to generate an IGVM fi=
le
> using this tool.
>
> Changes in v8:
>
> * Fix an issue found after rebasing where the pre-parsing of the IGVM fil=
e
>   caused an error.
> * Update version numbers for IGVM support to 10.1
> * Minor changes to documentation.
> * Add metadata to relevant commits.
>

Other than the comments I already posted ...

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> Patch summary:
>
> 1-11: Add support and documentation for processing IGVM files for SEV, SE=
V-ES,
> SEV-SNP and native platforms.
>
> 12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file.
>
> 16: Add pre-processing of IGVM file to support synchronization of 'SEV_FE=
ATURES'
> from IGVM VMSA to KVM.
>
> [1] Link to v7:
> https://lists.gnu.org/archive/html/qemu-devel/2025-02/msg05714.html
>
> [2] v8 patches also available here:
> https://github.com/roy-hopkins/qemu/tree/igvm_master_v8
>
> [3] `buildigvm` tool v0.2.0
> https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0
>
> Roy Hopkins (16):
>   meson: Add optional dependency on IGVM library
>   backends/confidential-guest-support: Add functions to support IGVM
>   backends/igvm: Add IGVM loader and configuration
>   hw/i386: Add igvm-cfg object and processing for IGVM files
>   i386/pc_sysfw: Ensure sysfw flash configuration does not conflict with
>     IGVM
>   sev: Update launch_update_data functions to use Error handling
>   target/i386: Allow setting of R_LDTR and R_TR with
>     cpu_x86_load_seg_cache()
>   i386/sev: Refactor setting of reset vector and initial CPU state
>   i386/sev: Implement ConfidentialGuestSupport functions for SEV
>   docs/system: Add documentation on support for IGVM
>   docs/interop/firmware.json: Add igvm to FirmwareDevice
>   backends/confidential-guest-support: Add set_guest_policy() function
>   backends/igvm: Process initialization sections in IGVM file
>   backends/igvm: Handle policy for SEV guests
>   i386/sev: Add implementation of CGS set_guest_policy()
>   sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2
>
>  backends/confidential-guest-support.c       |  43 +
>  backends/igvm-cfg.c                         |  51 +
>  backends/igvm.c                             | 977 ++++++++++++++++++++
>  backends/igvm.h                             |  22 +
>  backends/meson.build                        |   5 +
>  docs/interop/firmware.json                  |  30 +-
>  docs/system/i386/amd-memory-encryption.rst  |   2 +
>  docs/system/igvm.rst                        | 173 ++++
>  docs/system/index.rst                       |   1 +
>  hw/i386/pc.c                                |  12 +
>  hw/i386/pc_piix.c                           |  10 +
>  hw/i386/pc_q35.c                            |  10 +
>  hw/i386/pc_sysfw.c                          |  31 +-
>  include/hw/i386/x86.h                       |   3 +
>  include/system/confidential-guest-support.h |  88 ++
>  include/system/igvm-cfg.h                   |  49 +
>  meson.build                                 |   8 +
>  meson_options.txt                           |   2 +
>  qapi/qom.json                               |  17 +
>  qemu-options.hx                             |  28 +
>  scripts/meson-buildoptions.sh               |   3 +
>  target/i386/cpu.h                           |   9 +-
>  target/i386/sev.c                           | 851 +++++++++++++++--
>  target/i386/sev.h                           | 124 +++
>  24 files changed, 2465 insertions(+), 84 deletions(-)
>  create mode 100644 backends/igvm-cfg.c
>  create mode 100644 backends/igvm.c
>  create mode 100644 backends/igvm.h
>  create mode 100644 docs/system/igvm.rst
>  create mode 100644 include/system/igvm-cfg.h
>
> --
> 2.43.0
>


