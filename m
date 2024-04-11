Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6DFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruyM3-0003QQ-WD; Thu, 11 Apr 2024 13:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruyLz-0003Q9-0c
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruyLx-0008Rs-3K
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712857008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIjk4c/fhszzcZMfpPvu4kpyLOz8FnjlJrXNssLnszo=;
 b=C8HphV/pp9denQ3C9w7jj8vMycsAoHog8fZL+BUPWYPxOM4TlhQkwtyOd7AnRLR/UNiTtg
 1lWt6nKlsATTYQLfEEtOk2gD41wyr9L/f+zVMyy9obBuk++b+wliFYQgVpc/IUGJsZ6rV1
 T5qkyMaFyezBTp76vTJko+spNsLvVc0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-O6ZLInP3PpGVa5ZfEWnD8A-1; Thu, 11 Apr 2024 13:36:43 -0400
X-MC-Unique: O6ZLInP3PpGVa5ZfEWnD8A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-346c08df987so64157f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 10:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712856961; x=1713461761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIjk4c/fhszzcZMfpPvu4kpyLOz8FnjlJrXNssLnszo=;
 b=imLDFMOrUf/mKrI9VSIGtrqsrX8kp75Cm21jbfXZwZMWmwq5E1ZG3ZvaORG/sUnZwH
 eAdkxfDQ7YKNvZbGUjOy8h4+Sa7FtOed0YBOICilIoEH45l4z1E6gRHIz84nDopYTBEU
 09nAQaiJCCVw1GEq4NbmbuZDUiPjrqVYMMYetOvagj/Mbk/AWHUovPbwbPcWKXtmdHsS
 FwYgv/YfDMkXQ5kycKdjFwcuiekrgzyfZSiEFLXU9FfpCsQRjxcY5Ncla/MfB+9t2WRy
 CFTEVnA+oCihgOOhkQK4J6BEHxVqcmAYN0xwjd0XlWhqbwKX1ic9FHWlVN3vxgpcu7GL
 V2eQ==
X-Gm-Message-State: AOJu0YxYm9hKrJyY6f1MltXx8fv5w2n4p+6fMPjNPpe8DIde0X3QoT6v
 g6raT8CT1r1qEHEQ9CovMzOzyiRC6lMTwiCMAJ+A+2qwfDxx5ns+rLpZV+Lw3gkGf9/Btsn8LEo
 8tCvDrDhUhKjo2OTd/w28Dr5wG+E3Y13phfi/yF2YA0eQOntmcdjLgf0SRzlDoa4paj0AmmRwZb
 JiOZMWzauGBYzuVIpoAl38O79x5D8=
X-Received: by 2002:a5d:4e0e:0:b0:342:d5ac:c712 with SMTP id
 p14-20020a5d4e0e000000b00342d5acc712mr357865wrt.7.1712856961651; 
 Thu, 11 Apr 2024 10:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH7zr7ewwqQvkgoFs4I1YGBqw7RyH4tb4i7r/FkTNp3vbt7t8CroLWOTHf82u+iLBZS0JoMV+Ji4RpTKtTANg=
X-Received: by 2002:a5d:4e0e:0:b0:342:d5ac:c712 with SMTP id
 p14-20020a5d4e0e000000b00342d5acc712mr357846wrt.7.1712856961295; Thu, 11 Apr
 2024 10:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240409230743.962513-1-michael.roth@amd.com>
In-Reply-To: <20240409230743.962513-1-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 19:35:49 +0200
Message-ID: <CABgObfYZTocoZJ9PHgfZYZg2k8cwNtmbciOs_HwBpGmsZ-wbJg@mail.gmail.com>
Subject: Re: [PATCH for-9.1 v1 0/3] Add SEV/SEV-ES machine compat options for
 KVM_SEV_INIT2
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Tom Lendacky <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, 
 Larry Dewey <Larry.Dewey@amd.com>, Roy Hopkins <roy.hopkins@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 10, 2024 at 1:08=E2=80=AFAM Michael Roth <michael.roth@amd.com>=
 wrote:
>
> These patches are also available at:
>
>   https://github.com/amdese/qemu/commits/sev-init-legacy-v1
>
> and are based on top Paolo's qemu-coco-queue branch containing the
> following patches:

A more complete version of patch 2 was already on the list, so I
queued 1 and 3 to qemu-coco-queue.

Thanks!

Paolo

>
>   [PATCH for-9.1 00/26] x86, kvm: common confidential computing subset
>   https://lore.kernel.org/all/20240322181116.1228416-1-pbonzini@redhat.co=
m/T/
>
> Overview
> --------
>
> With the following patches applied from qemu-coco-queue:
>
>   https://lore.kernel.org/all/20240319140000.1014247-1-pbonzini@redhat.co=
m/
>
> QEMU version 9.1+ will begin automatically making use of the new
> KVM_SEV_INIT2 API for initializing SEV and SEV-ES (and eventually, SEV-SN=
P)
> guests verses the older KVM_SEV_INIT/KVM_SEV_ES_INIT interfaces.
>
> However, the older interfaces would silently avoid sync'ing FPU/XSAVE sta=
te
> set by QEMU to each vCPU's VMSA prior to encryption. With KVM_SEV_INIT2,
> this state will now be synced into the VMSA, resulting in measurements
> changes and, theoretically, behaviorial changes, though the latter are
> unlikely to be seen in practice. The specific VMSA changes are documented
> in the section below for reference.
>
> This series implements machine compatibility options for SEV/SEV-ES so th=
at
> only VMs created with QEMU 9.1+ will make use of KVM_SEV_INIT2 so that VM=
SA
> differences can be accounted for beforehand, and older machine types will
> continue using the older interfaces to avoid unexpected measurement
> changes.
>
> Specific VMSA changes
> ---------------------
>
> With KVM_SEV_INIT2, rather than 0, QEMU/KVM will instead begin setting th=
e
> following fields in the VMSA before measurement/encryption:
>
>   VMSA byte offset [1032:1033] =3D 80 1f (MXCSR, Multimedia Control Statu=
s
>                                         Register)
>   VMSA byte offset [1040:1041] =3D 7f 03 (FCW, FPU/x86 Control Word)
>
> Setting FCW (FPU/x86 Control Word) to 0x37f is consistent with 11.5.7 of
> APM Volume 2. MXCSR reset state is not defined for XSAVE, but QEMU's 0x1f=
80
> value is consistent with machine reset state documented in APM Volume 2
> 4.2.2. As such, it is reasonable to begin including these in the VMSA
> measurement calculations.
>
> NOTE: section 11.5.7 also documents that FTW should be all 1's, whereas
>       QEMU currently sets all zeroes. Should that be changed as part of
>       this, or are there other reasons for setting 0?
>
> Thanks,
>
> Mike
>
> ----------------------------------------------------------------
> Michael Roth (3):
>       i386/sev: Add 'legacy-vm-type' parameter for SEV guest objects
>       hw/i386: Add 9.1 machine types for i440fx/q35
>       hw/i386/sev: Use legacy SEV VM types for older machine types
>
>  hw/i386/pc.c         |  5 +++++
>  hw/i386/pc_piix.c    | 13 ++++++++++++-
>  hw/i386/pc_q35.c     | 12 +++++++++++-
>  include/hw/i386/pc.h |  3 +++
>  qapi/qom.json        | 11 ++++++++++-
>  target/i386/sev.c    | 19 ++++++++++++++++++-
>  6 files changed, 59 insertions(+), 4 deletions(-)
>
>
>


