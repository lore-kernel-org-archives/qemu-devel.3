Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607E3E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqvY-00018L-Rp; Mon, 09 Dec 2024 22:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tKqvS-00017h-HJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 22:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tKqvP-0005F5-7h
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 22:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733801317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4Bnkfn7sdD12Md5SZFmC3/Jsf5SsyJK3oxXwysvJDc=;
 b=IgZ78jaC/Iu+RvrOgKZKT6Sr/aVPIh4+QkNKUNGT1arhMY7N+0ME/Az+j6kZIfojn/gL2P
 0Pa+kVlaKDKKcirKswU76bTwfY0rhKI04NcbLX6ttuIlvSu9EGEkYzI7xryqwidrPqGVyc
 yCGY/yao5znb2BP78Yx/CRy3cxlC5SE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-pkkwH1jNN3mLWUU6ZEMVYg-1; Mon, 09 Dec 2024 22:28:36 -0500
X-MC-Unique: pkkwH1jNN3mLWUU6ZEMVYg-1
X-Mimecast-MFC-AGG-ID: pkkwH1jNN3mLWUU6ZEMVYg
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa634496f58so46766766b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 19:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733801312; x=1734406112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4Bnkfn7sdD12Md5SZFmC3/Jsf5SsyJK3oxXwysvJDc=;
 b=TGSSOa+tAAvt+JB1JyAMEBVONly7wBcGESfNR1st3UC3W+HMmNFoVfPMblVQlWadp7
 jw9+bXPAIMRLwtdwSk4WmgBCfEOxXdA3+rgVs8VovmvXt+r2u9S2LlkWpSaxFbuxNJM/
 RlVf77+fyTN40QqdAiH1XBMnsOKwBnP6BHn9YuxNRneI/2E7dGa1GSyf8d/KFj0FCt/5
 KJe2aQ1CWO2Yy7t81JJp7mbS6Je+JB84InlWkiMlJ8B0dXAxCkvRn2rmadB2qhPYmoN5
 IxRoI0s4ovvrfpnvXyCR1kDiutEpkkWbYWs4Jl5/ZWbHLO/+Ln+44AHcQTe7LN/wqQWT
 8sOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/nPJ2pCd+foOcv+hEs/UsN/l4aoKcNAXgZI3yJXUAd0s/r952LQb5WE5i/hSBFvRS3zEuA++LwoMN@nongnu.org
X-Gm-Message-State: AOJu0YxUw4jKtJvzUpw5vF9PuB1RgiPYi2edvQV0Zzdr2xozSdiYln04
 zo3/fVla76NESQW009aOoyaCaScxCsnl+GrcoKPeLAiD03R0Rc67y+vUI+vdCZvZNo3Rmijj50K
 LWBQEsLPO3D9qmC3LniblreHbEBsh5vBSBFF2QAO+KEvgc9Zuyrc89qGe+EgHuvG0tc1GU+PdJ6
 dVrZAJ71dqmnoBxxarBujt0ntUDys=
X-Gm-Gg: ASbGncsoepIsIg9l2rkzvxYSycaXL1KwvUsOkbJZ84EYhT667dbuuSYDxwdoXiXHq0C
 8awXIcgAoSvAPDZtqPHOLpADgI2SixykqMQ==
X-Received: by 2002:a17:906:3ca1:b0:aa6:2bba:a1f9 with SMTP id
 a640c23a62f3a-aa63a37b460mr1167352166b.59.1733801312453; 
 Mon, 09 Dec 2024 19:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK4Iok0xv11CszESo+z1HldxDLg5Ut/NYVaZrucS7SNT4C0rKN8yxjrToqvRftnoea/tBA11HVR5ycq6eKGIo=
X-Received: by 2002:a17:906:3ca1:b0:aa6:2bba:a1f9 with SMTP id
 a640c23a62f3a-aa63a37b460mr1167350266b.59.1733801311862; Mon, 09 Dec 2024
 19:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20241129091654.38062-1-anisinha@redhat.com>
 <646b00af-3726-42bf-bac7-f2658de5caa5@linaro.org>
 <6104E4C8-C41C-4EDD-9F54-320AF6DAE6A2@redhat.com>
In-Reply-To: <6104E4C8-C41C-4EDD-9F54-320AF6DAE6A2@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 10 Dec 2024 08:58:20 +0530
Message-ID: <CAK3XEhNpHnb+MO3O0EEM65q8j4sBxXz0HbAvPYWSH26qxc-oig@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg interface
 support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 2, 2024 at 1:17=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wrot=
e:
>
>
>
> > On 29 Nov 2024, at 3:42=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org> wrote:
> >
> > On 29/11/24 10:16, Ani Sinha wrote:
> >> VM firmware update is a mechanism where the virtual machines can use t=
heir
> >> preferred and trusted firmware image in their execution environment wi=
thout
> >> having to depend on a untrusted party to provide the firmware bundle. =
This is
> >> particularly useful for confidential virtual machines that are deploye=
d in the
> >> cloud where the tenant and the cloud provider are two different entiti=
es. In
> >> this scenario, virtual machines can bring their own trusted firmware i=
mage
> >> bundled as a part of their filesystem (using UKIs for example[1]) and =
then use
> >> this hypervisor interface to update to their trusted firmware image. T=
his also
> >> allows the guests to have a consistent measurements on the firmware im=
age.
> >> This change introduces basic support for the fw-cfg based hypervisor i=
nterface
> >> and the corresponding device. The change also includes the
> >> specification document for this interface. The interface is made gener=
ic
> >> enough so that guests are free to use their own ABI to pass required
> >> information between initial and trusted execution contexts (where they=
 are
> >> running their own trusted firmware image) without the hypervisor getti=
ng
> >> involved in between. In subsequent patches, we will introduce other mi=
nimal
> >> changes on the hypervisor that are required to make the mechanism work=
.
> >> [1] See systemd pull requests https://github.com/systemd/systemd/pull/=
35091
> >> and https://github.com/systemd/systemd/pull/35281 for some discussions=
 on
> >> how we can bundle firmware image within an UKI.
> >> CC: Alex Graf <graf@amazon.com>
> >> CC: Paolo Bonzini <pbonzini@redhat.com>
> >> CC: Gerd Hoffman <kraxel@redhat.com>
> >> CC: Igor Mammedov <imammedo@redhat.com>
> >> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>

I know we are in code freeze but I would appreciate any more feedback
on this patch so that when the freeze lifts, we may merge it.

> >> ---
> >>  MAINTAINERS                  |   9 +++
> >>  docs/specs/index.rst         |   1 +
> >>  docs/specs/vmfwupdate.rst    | 109 +++++++++++++++++++++++++
> >>  hw/misc/meson.build          |   2 +
> >>  hw/misc/vmfwupdate.c         | 152 ++++++++++++++++++++++++++++++++++=
+
> >>  include/hw/misc/vmfwupdate.h | 103 ++++++++++++++++++++++++
> >>  6 files changed, 376 insertions(+)
> >>  create mode 100644 docs/specs/vmfwupdate.rst
> >>  create mode 100644 hw/misc/vmfwupdate.c
> >>  create mode 100644 include/hw/misc/vmfwupdate.h
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 095420f8b0..cd4135fb5b 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2531,6 +2531,15 @@ F: include/hw/acpi/vmgenid.h
> >>  F: docs/specs/vmgenid.rst
> >>  F: tests/qtest/vmgenid-test.c
> >>  +VM Firmware Update
> >> +M: Ani Sinha <anisinha@redhat.com>
> >> +M: Alex Graf <graf@amazon.com>
> >> +M: Paolo Bonzini <pbonzini@redhat.com>
> >> +S: Maintained
> >> +F: hw/misc/vmfwupdate.c
> >> +F: include/hw/misc/vmfwupdate.h
> >> +F: docs/specs/vmfwupdate.rst
> >> +
> >>  LED
> >>  M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >>  S: Maintained
> >> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> >> index ff5a1f03da..cbda7e0398 100644
> >> --- a/docs/specs/index.rst
> >> +++ b/docs/specs/index.rst
> >> @@ -34,6 +34,7 @@ guest hardware that is specific to QEMU.
> >>     virt-ctlr
> >>     vmcoreinfo
> >>     vmgenid
> >> +   vmfwupdate
> >>     rapl-msr
> >>     rocker
> >>     riscv-iommu
> >> diff --git a/docs/specs/vmfwupdate.rst b/docs/specs/vmfwupdate.rst
> >> new file mode 100644
> >> index 0000000000..3a36ca14c7
> >> --- /dev/null
> >> +++ b/docs/specs/vmfwupdate.rst
> >> @@ -0,0 +1,109 @@
> >> +VMFWUPDATE INTERFACE SPECIFICATION
> >> +##################################
> >> +
> >> +Introduction
> >> +************
> >> +
> >> +``Vmfwupdate`` is an extension to ``fw-cfg`` that allows guests to re=
place early boot
> >> +code in their virtual machine. Through a combination of vmfwupdate an=
d
> >> +hypervisor stack knowledge, guests can deterministically replace the =
launch
> >> +payload for guests. This is useful for environments like SEV-SNP wher=
e the
> >> +launch payload becomes the launch digest. Guests can use vmfwupdate t=
o provide
> >> +a measured, full guest payload (BIOS image, kernel, initramfs, kernel
> >> +command line) to the virtual machine which enables them to easily rea=
son about
> >> +integrity of the resulting system.
> >> +For more information, please see the `KVM Forum 2024 presentation <KV=
MFORUM_>`__
> >> +about this work from the authors [1]_.
> >> +
> >> +
> >> +.. _KVMFORUM: https://www.youtube.com/watch?v=3DVCMBxU6tAto
> >> +
> >> +Base Requirements
> >> +*****************
> >> +
> >> +#. **fw-cfg**:
> >> +     The target system must provide a ``fw-cfg`` interface. For x86 b=
ased
> >> +     environments, this ``fw-cfg`` interface must be accessible throu=
gh PIO ports
> >> +     0x510 and 0x511. The ``fw-cfg`` interface does not need to be an=
nounced as part
> >> +     of system device tables such as DSDT. The ``fw-cfg`` interface m=
ust support the
> >> +     DMA interface. It may only support the DMA interface for write o=
perations.
> >> +
> >> +#. **BIOS region**:
> >> +     The hypervisor must provide a BIOS region which may be
> >> +     statically sized. Through vmfwupdate, the guest is able to atomi=
cally replace
> >> +     its contents. The BIOS region must be mapped as read-write memor=
y. In a
> >> +     SEV-SNP environment, the BIOS region must be mapped as private m=
emory at
> >> +     launch time.
> >> +
> >> +Fw-cfg Files
> >> +************
> >> +
> >> +Guests drive vmfwupdate through special ``fw-cfg`` files that control=
 its flow
> >> +followed by a standard system reset operation. When vmfwupdate is ava=
ilable,
> >> +it provides the following ``fw-cfg`` files:
> >> +
> >> +* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitm=
ap of additional
> >> +  capabilities the interface supports. List of available capabilities=
:
> >> +
> >> +     ``VMFWUPDATE_CAP_BIOS_RESIZE        0x0000000000000001``
> >> +
> >> +* ``vmfwupdate/bios-size`` (``u32``) - Little Endian encoded size of =
the BIOS region.
> >> +  Read-only by default. Optionally Read-write if ``vmfwupdate/cap`` c=
ontains
> >> +  ``VMFWUPDATE_CAP_BIOS_RESIZE``. On write, the BIOS region may resiz=
e. Guests are
> >> +  required to read the value after writing and compare it with the re=
quested size
> >> +  to determine whether the resize was successful. Note, x86 BIOS regi=
ons always
> >> +  start at 4GiB - bios-size.
> >> +
> >> +* ``vmfwupdate/opaque`` (``1024 bytes``) - A 1KiB buffer that survive=
s the BIOS replacement
> >> +  flow. Can be used by the guest to propagate guest physical addresse=
s of payloads
> >> +  to its BIOS stage. It=E2=80=99s recommended to make the new BIOS cl=
ear this file on boot
> >> +  if it exists. Contents of this file are under control by the hyperv=
isor. In an
> >> +  environment that considers the hypervisor outside of its trust boun=
dary, guests
> >> +  are advised to validate its contents before consumption.
> >> +
> >> +* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface i=
s disabled.
> >> +  Returns 0 for enabled, 1 for disabled. Writing any value disables i=
t. Writing is
> >> +  only allowed if the value is 0. When the interface is disabled, the=
 replace file
> >> +  is ignored on reset. This value resets to 0 on system reset.
> >> +
> >> +* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded =
guest physical address
> >> +  at the beginning of the replacement BIOS region. The provided paylo=
ad must reside
> >> +  in shared memory. 0 on system reset.
> >> +
> >> +
> >> +Triggering the Firmware Update
> >> +******************************
> >> +
> >> +To initiate the firmware update process, the guest issues a standard =
system reset
> >> +operation through any of the means implemented by the machine model.
> >> +
> >> +On reset, the hypervisor evaluates whether ``vmfwupdate/disable`` is =
``1``. If it is, it ignores
> >> +any other vmfwupdate values and performs a standard system reset.
> >> +
> >> +If ``vmfwupdate/disable`` is ``0``, the hypervisor checks if bios-add=
r is ``0``. If it is, it
> >> +performs a standard system reset.
> >> +
> >> +If ``vmfwupdate/bios-addr`` is ``non-0``, the hypervisor replaces the=
 contents of the system=E2=80=99s
> >> +BIOS region with the guest physically contiguous ``vmfwupdate/bios-si=
ze`` sized payload at the
> >> +guest physical address address vmfwupdate/bios-addr.
> >> +
> >> +As part of the reset operation, all existing guest shared memory as w=
ell as the
> >> +``vmfwupdate/opaque`` file are preserved. CPU and device state are re=
set to the default
> >> +hypervisor specific reset states. In SEV-SNP environments, the reset =
causes recreation
> >> +of the VM context which triggers a fresh measurement of the replaced =
BIOS region and
> >> +reset CPU state. The guest always resumes operation in the highest pr=
ivileged mode
> >> +available to it (VMPL0 in SEV-SNP).
> >> +
> >> +Closing Remarks
> >> +***************
> >> +The handover protocol (format of the ``vmwupdate/opaque`` file etc.) =
will be implemented by
> >> +the firmware loader and firmware image, both provided by the guest.  =
The hypervisor does
> >> +not need to know these details, so it is not included in this specifi=
cation.
> >> +
> >> +
> >> +
> >> +Footnotes:
> >> +^^^^^^^^^^
> >> +.. [1] Original author of the specification: *Alex Graf <graf@amazon.=
com>*,
> >> +       converted to re-structured-text (rst format) and slightly edit=
ed
> >> +       by *Ani Sinha <anisinha@redhat.com>*.
> >> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> >> index d02d96e403..4c5bdb0de2 100644
> >> --- a/hw/misc/meson.build
> >> +++ b/hw/misc/meson.build
> >> @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: f=
iles('mac_via.c'))
> >>  specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c=
', 'mips_cpc.c'))
> >>  specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c')=
)
> >>  +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmfwupdat=
e.c'))
> >> +
> >>  system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
> >>    # HPPA devices
> >> diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> >> new file mode 100644
> >> index 0000000000..39fac68cbe
> >> --- /dev/null
> >> +++ b/hw/misc/vmfwupdate.c
> >> @@ -0,0 +1,152 @@
> >> +/*
> >> + * Guest driven VM boot component update device
> >> + * For details and specification, please look at docs/specs/vmfwupdat=
e.rst.
> >> + *
> >> + * Copyright (C) 2024 Red Hat, Inc.
> >> + *
> >> + * Authors: Ani Sinha <anisinha@redhat.com>
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
> >> + * See the COPYING file in the top-level directory.
> >> + *
> >> + */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "qapi/error.h"
> >> +#include "qemu/module.h"
> >> +#include "sysemu/reset.h"
> >> +#include "hw/nvram/fw_cfg.h"
> >> +#include "hw/i386/pc.h"
> >> +#include "hw/qdev-properties.h"
> >> +#include "hw/misc/vmfwupdate.h"
> >> +#include "qemu/error-report.h"
> >> +
> >> +static void fw_update_reset(void *dev)
> >> +{
> >> +    /* a NOOP at present */
> >> +    return;
> >> +}
> >> +
> >> +
> >> +static uint64_t get_max_fw_size(void)
> >> +{
> >> +    Object *m_obj =3D qdev_get_machine();
> >> +    PCMachineState *pcms =3D PC_MACHINE(m_obj);
> >> +
> >> +    if (pcms) {
> >> +        return pcms->max_fw_size;
> >> +    } else {
> >> +        return 0;
> >
> > Isn't it a configuration error?
>
> It isn=E2=80=99t if we do not expose VMFWUPDATE_CAP_BIOS_RESIZE capabilit=
y to other machines. I will fix this in v2.
> Also I am not sure what is the consistent way to get this value for non-p=
c machines.
>
> >
> >> +    }
> >> +}
> >> +
> >> +static void fw_blob_write(void *dev, off_t offset, size_t len)
> >> +{
> >> +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
> >> +
> >> +    /*
> >> +     * in order to change the bios size, appropriate capability
> >> +       must be enabled
> >> +    */
> >> +    if (s->fw_blob.bios_size &&
> >> +        !(s->capability & VMFWUPDATE_CAP_BIOS_RESIZE)) {
> >> +        warn_report("vmfwupdate: VMFWUPDATE_CAP_BIOS_RESIZE not enabl=
ed");
> >> +        return;
> >> +    }
> >> +
> >> +    s->plat_bios_size =3D s->fw_blob.bios_size;
> >> +
> >> +    return;
> >> +}
> >> +
> >> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
> >> +    FWCfgState *fw_cfg =3D fw_cfg_find();
> >> +
> >> +    /* multiple devices are not supported */
> >> +    if (!vmfwupdate_find()) {
> >> +        error_setg(errp, "at most one %s device is permitted",
> >> +                   TYPE_VMFWUPDATE);
> >> +        return;
> >> +    }
> >> +
> >> +    /* fw_cfg with DMA support is necessary to support this device */
> >> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
> >> +        error_setg(errp, "%s device requires fw_cfg",
> >> +                   TYPE_VMFWUPDATE);
> >> +        return;
> >> +    }
> >> +
> >> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
> >> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
> >> +
> >> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
> >> +                             NULL, NULL, s,
> >> +                             &s->opaque_blobs,
> >> +                             sizeof(s->opaque_blobs),
> >> +                             false);
> >> +
> >> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
> >> +                             NULL, fw_blob_write, s,
> >> +                             &s->fw_blob,
> >> +                             sizeof(s->fw_blob),
> >> +                             false);
> >> +
> >> +    /*
> >> +     * Add global capability fw_cfg file. This will be used by the gu=
est to
> >> +     * check capability of the hypervisor.
> >> +     */
> >> +    s->capability =3D cpu_to_le16(CAP_VMFWUPD_MASK | VMFWUPDATE_CAP_E=
DKROM);
> >> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
> >> +                    &s->capability, sizeof(s->capability));
> >> +
> >> +    s->plat_bios_size =3D get_max_fw_size();
> >> +    /* size of bios region for the platform - read only by the guest =
*/
> >> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
> >> +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
> >> +    /*
> >> +     * add fw cfg control file to disable the hypervisor interface.
> >> +     */
> >> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
> >> +                             NULL, NULL, s,
> >> +                             &s->disable,
> >> +                             sizeof(s->disable),
> >> +                             false);
> >> +    /*
> >> +     * This device requires to register a global reset because it is
> >> +     * not plugged to a bus (which, as its QOM parent, would reset it=
).
> >> +     */
> >> +    qemu_register_reset(fw_update_reset, dev);
> >> +}
> >> +
> >> +static Property vmfwupdate_properties[] =3D {
> >> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
> >> +    DEFINE_PROP_END_OF_LIST(),
> >> +};
> >> +
> >> +static void vmfwupdate_device_class_init(ObjectClass *klass, void *da=
ta)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +
> >> +    /* we are not interested in migration - so no need to populate dc=
->vmsd */
> >> +    dc->desc =3D "VM firmware blob update device";
> >> +    dc->realize =3D vmfwupdate_realize;
> >> +    dc->hotpluggable =3D false;
> >> +    device_class_set_props(dc, vmfwupdate_properties);
> >> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >> +}
> >> +
> >> +static const TypeInfo vmfwupdate_device_info =3D {
> >> +    .name          =3D TYPE_VMFWUPDATE,
> >> +    .parent        =3D TYPE_DEVICE,
> >> +    .instance_size =3D sizeof(VMFwUpdateState),
> >> +    .class_init    =3D vmfwupdate_device_class_init,
> >> +};
> >> +
> >> +static void vmfwupdate_register_types(void)
> >> +{
> >> +    type_register_static(&vmfwupdate_device_info);
> >> +}
> >> +
> >> +type_init(vmfwupdate_register_types);
> >> diff --git a/include/hw/misc/vmfwupdate.h b/include/hw/misc/vmfwupdate=
.h
> >> new file mode 100644
> >> index 0000000000..e9229d807b
> >> --- /dev/null
> >> +++ b/include/hw/misc/vmfwupdate.h
> >> @@ -0,0 +1,103 @@
> >> +/*
> >> + * Guest driven VM boot component update device
> >> + * For details and specification, please look at docs/specs/vmfwupdat=
e.rst.
> >> + *
> >> + * Copyright (C) 2024 Red Hat, Inc.
> >> + *
> >> + * Authors: Ani Sinha <anisinha@redhat.com>
> >> + *
> >> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
> >> + * See the COPYING file in the top-level directory.
> >> + *
> >> + */
> >> +#ifndef VMFWUPDATE_H
> >> +#define VMFWUPDATE_H
> >> +
> >> +#include "hw/qdev-core.h"
> >> +#include "qom/object.h"
> >> +#include "qemu/units.h"
> >> +
> >> +#define TYPE_VMFWUPDATE "vmfwupdate"
> >> +
> >> +#define VMFWUPDCAPMSK  0xffff /* least significant 16 capability bits=
 */
> >> +
> >> +#define VMFWUPDATE_CAP_EDKROM 0x08 /* bit 4 represents support for ED=
KROM */
> >> +#define VMFWUPDATE_CAP_BIOS_RESIZE 0x04 /* guests may resize bios reg=
ion */
> >> +#define CAP_VMFWUPD_MASK 0x80
> >> +
> >> +#define VMFWUPDATE_OPAQUE_SIZE (1024 * MiB)
> >> +
> >> +/* fw_cfg file definitions */
> >> +#define FILE_VMFWUPDATE_OBLOB "etc/vmfwupdate/opaque-blob"
> >> +#define FILE_VMFWUPDATE_FWBLOB "etc/vmfwupdate/fw-blob"
> >> +#define FILE_VMFWUPDATE_CAP "etc/vmfwupdate/cap"
> >> +#define FILE_VMFWUPDATE_BIOS_SIZE "etc/vmfwupdate/bios-size"
> >> +#define FILE_VMFWUPDATE_CONTROL "etc/vmfwupdate/disable"
> >> +
> >> +/*
> >> + * Address and length of the guest provided firmware blob.
> >> + * The blob itself is passed using the guest shared memory to QEMU.
> >> + * This is then copied to the guest private memeory in the secure vm
> >> + * by the hypervisor.
> >> + */
> >> +typedef struct {
> >> +    uint32_t bios_size; /*
> >> +                         * this is used by the guest to update plat_b=
ios_size
> >> +                         * when VMFWUPDATE_CAP_BIOS_RESIZE is set.
> >> +                         */
> >> +    uint64_t bios_paddr; /*
> >> +                          * starting gpa where the blob is in shared =
guest
> >> +                          * memory. Cleared upon system reset.
> >> +                          */
> >> +} VMFwUpdateFwBlob;
> >> +
> >> +typedef struct VMFwUpdateState {
> >> +    DeviceState parent_obj;
> >> +
> >> +    /*
> >> +     * capabilities - 64 bits.
> >> +     * Little endian format.
> >> +     */
> >> +    uint64_t capability;
> >> +
> >> +    /*
> >> +     * size of the bios region - architecture dependent.
> >> +     * Read-only by the guest unless VMFWUPDATE_CAP_BIOS_RESIZE
> >> +     * capability is set.
> >> +     */
> >> +    uint32_t plat_bios_size;
> >> +
> >> +    /*
> >> +     * disable - disables the interface when non-zero value is writte=
n to it.
> >> +     * Writing 0 to this file enables the interface.
> >> +     */
> >> +    uint8_t disable;
> >> +
> >> +    /*
> >> +     * The first stage boot uses this opaque blob to convey to the ne=
xt stage
> >> +     * where the next stage components are loaded. The exact structur=
e and
> >> +     * number of entries are unknown to the hypervisor and the hyperv=
isor
> >> +     * does not touch this memory or do any validations.
> >> +     * The contents of this memory needs to be validated by the guest=
 and
> >> +     * must be ABI compatible between the first and second stages.
> >> +     */
> >> +    unsigned char opaque_blobs[VMFWUPDATE_OPAQUE_SIZE];
> >> +
> >> +    /*
> >> +     * firmware blob addresses and sizes. These are moved to guest
> >> +     * private memory.
> >> +     */
> >> +    VMFwUpdateFwBlob fw_blob;
> >> +} VMFwUpdateState;
> >> +
> >> +OBJECT_DECLARE_SIMPLE_TYPE(VMFwUpdateState, VMFWUPDATE);
> >> +
> >> +/* returns NULL unless there is exactly one device */
> >> +static inline VMFwUpdateState *vmfwupdate_find(void)
> >> +{
> >> +    Object *o =3D object_resolve_path_type("", TYPE_VMFWUPDATE, NULL)=
;
> >> +
> >> +    return o ? VMFWUPDATE(o) : NULL;
> >> +}
> >> +
> >> +#endif
>
>


