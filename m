Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6037FC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0XS-0007jQ-IC; Tue, 12 Mar 2024 07:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rk0XQ-0007iS-7p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:43:20 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1rk0XK-0004E2-8L
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:43:19 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so79719991fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710243791; x=1710848591; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gpo0abP48NJTZIYqIeoLjEcfZQuQVs83kwlsrD+w7Wc=;
 b=MtKq/RbpWBqvAjqLl5Hiu5wKifgGsYuibTkFMpIxWD3JclGz3CE2RZdXdY7zzOxYgu
 WpQGNtgHIubhLcBad8dk6kFUbf8l/Mwpe7z8MYZalySmlcWp06Nf3dZmO5e4sgV042qp
 xRtBWO+KnEjW677rHCnzw17XRO2S3YbR8qbFJAKGG4+mPCIvHwIwB/mzopxxNzFps3g8
 57/DxSgg4g657Bjdtaz6KA5Nf2wtk1L0WtKsz17inwls3z4VzIWVq9onkpxkx4bLyqTm
 SgExINHLkcXWodrxMTq5KjOi6Q0dbULVWQrST46KcvugzbCwQxpVtfYw1inukXvI9q80
 OHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710243791; x=1710848591;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gpo0abP48NJTZIYqIeoLjEcfZQuQVs83kwlsrD+w7Wc=;
 b=HJEcA1VNT7G+07v8sieh57n9LG9gEj2jFcpgbAKlxv81UVoSI/fSzPuDlXEZe/yqJO
 aYlalefsPlpf+onbPekAXdpAh83H/CAy9oBEiziI7Ds42CT6lOcRMU6oSo70rtJW/9DG
 /7SclkJ+wkcIIPLF+KOlI4Qxu+oItgLs9+ZEdDQPsPD7+GIVV3MQGWE7E61LT8XIAKKB
 9IzrfDehopZvPLGQ+X9WJF1O7ECSHpy3GI7h2/5BzCIeXDud2O4JInywYJnXZGYaFRhX
 aa0y2t9tGol0/KECsedvnxN47e8SG/U+YEm+2M7jZqr/dyos5hy87IFbs9S3SC4PDZ6X
 or1w==
X-Gm-Message-State: AOJu0YyYQiXCTTmmpkUHaQGcNBVAKCq/B+fKht6TMd6HPTTO61ziyosn
 48/vcRggY77Y9stq4Y3qMWEzi85/hQPiuQO0EFS/0cGUUuQea2LCoIS9jIQk/Yg=
X-Google-Smtp-Source: AGHT+IFWfXaAIZd3ouD6Rma6Q6WGVEwG1MFBykI7O3TlflDAsCo2iwc+5AD7ysAC6Pp/F/+ZSNPVfQ==
X-Received: by 2002:a2e:bea2:0:b0:2d3:352a:518d with SMTP id
 a34-20020a2ebea2000000b002d3352a518dmr159941ljr.10.1710243791332; 
 Tue, 12 Mar 2024 04:43:11 -0700 (PDT)
Received: from [192.168.7.188]
 (cpc81487-lanc8-2-0-cust139.3-3.cable.virginm.net. [81.110.179.140])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c510400b00412cbe4f41bsm19164479wms.4.2024.03.12.04.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:43:11 -0700 (PDT)
Message-ID: <5a9c727bce71669bb60077a36ad171dddb31417f.camel@suse.com>
Subject: Re: [PATCH 3/9] backends/confidential-guest-support: Add functions
 to support IGVM
From: Roy Hopkins <roy.hopkins@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo
 Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,  =?ISO-8859-1?Q?J=F6rg?= Roedel
 <jroedel@suse.com>
Date: Tue, 12 Mar 2024 11:43:10 +0000
In-Reply-To: <ZeIEX8v7828JcXte@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <0d5af28ab63f6e4e4089b8b5a11b9fc9c941986f.1709044754.git.roy.hopkins@suse.com>
 <ZeIEX8v7828JcXte@redhat.com>
Autocrypt: addr=roy.hopkins@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::232;
 envelope-from=roy.hopkins@suse.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 2024-03-01 at 16:37 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 27, 2024 at 02:50:09PM +0000, Roy Hopkins wrote:
> > In preparation for supporting the processing of IGVM files to configure
> > guests, this adds a set of functions to ConfidentialGuestSupport
> > allowing configuration of secure virtual machines that can be
> > implemented for each supported isolation platform type such as Intel TD=
X
> > or AMD SEV-SNP. These functions will be called by IGVM processing code
> > in subsequent patches.
> >=20
> > This commit provides a default implementation of the functions that
> > either perform no action or generate a warning or error when they are
> > called. Targets that support ConfidentalGuestSupport should override
> > these implementations.
> >=20
> > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > ---
> > =C2=A0backends/confidential-guest-support.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2=
6 ++++++++
> > =C2=A0include/exec/confidential-guest-support.h | 76 ++++++++++++++++++=
+++++
> > =C2=A02 files changed, 102 insertions(+)
> >=20
> > diff --git a/backends/confidential-guest-support.c b/backends/confident=
ial-
> > guest-support.c
> > index da436fb736..42628be8d7 100644
> > --- a/backends/confidential-guest-support.c
> > +++ b/backends/confidential-guest-support.c
> > @@ -14,6 +14,7 @@
> > =C2=A0#include "qemu/osdep.h"
> > =C2=A0
> > =C2=A0#include "exec/confidential-guest-support.h"
> > +#include "qemu/error-report.h"
> > =C2=A0
> > =C2=A0OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 confidential_guest_support,
> > @@ -45,8 +46,33 @@ static void
> > confidential_guest_support_class_init(ObjectClass *oc, void *data)
> > =C2=A0#endif
> > =C2=A0}
> > =C2=A0
> > +static int check_support(ConfidentialGuestPlatformType platform,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint16_t platform_version, uint8_t highest_vtl,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint64_t shared_gpa_boundary)
> > +{
> > +=C2=A0=C2=A0=C2=A0 /* Default: no support. */
> > +=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConfidentialGuestPageType =
memory_type,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t cpu_index)
> > +{
> > +=C2=A0=C2=A0=C2=A0 warn_report("Confidential guest memory not supporte=
d");
> > +=C2=A0=C2=A0=C2=A0 return -1;
> > +}
> > +
> > +static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntr=
y
> > *entry)
> > +{
> > +=C2=A0=C2=A0=C2=A0 return 1;
> > +}
>=20
> IIUC, all these can reports errors, and as such I think
> they should have an 'Error **errp' parameter, so we can
> report precise errors in these methods, rather than
> less useful generic errors in the caller.
>=20
> The above 'warn_report' ought to be an error too, since
> it is returning an failure code (-1)

Yes, that makes sense. I've made a comprehensive rework of the error handli=
ng in
the patch series which addresses this and your suggestions in the other pat=
ches
regarding error handling. I'll submit these as a V2.

>=20
> > +
> > =C2=A0static void confidential_guest_support_init(Object *obj)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0 ConfidentialGuestSupport *cgs =3D CONFIDENTIAL_GUES=
T_SUPPORT(obj);
> > +=C2=A0=C2=A0=C2=A0 cgs->check_support =3D check_support;
> > +=C2=A0=C2=A0=C2=A0 cgs->set_guest_state =3D set_guest_state;
> > +=C2=A0=C2=A0=C2=A0 cgs->get_mem_map_entry =3D get_mem_map_entry;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void confidential_guest_support_finalize(Object *obj)
> > diff --git a/include/exec/confidential-guest-support.h
> > b/include/exec/confidential-guest-support.h
> > index b08ad8de4d..c43a1a32f1 100644
> > --- a/include/exec/confidential-guest-support.h
> > +++ b/include/exec/confidential-guest-support.h
> > @@ -21,10 +21,46 @@
> > =C2=A0#ifndef CONFIG_USER_ONLY
> > =C2=A0
> > =C2=A0#include "qom/object.h"
> > +#include "exec/hwaddr.h"
> > +
> > +#if defined(CONFIG_IGVM)
> > +#include "igvm/igvm.h"
> > +#endif
> > =C2=A0
> > =C2=A0#define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-suppo=
rt"
> > =C2=A0OBJECT_DECLARE_SIMPLE_TYPE(ConfidentialGuestSupport,
> > CONFIDENTIAL_GUEST_SUPPORT)
> > =C2=A0
> > +typedef enum ConfidentialGuestPlatformType {
> > +=C2=A0=C2=A0=C2=A0 CGS_PLATFORM_SEV,
> > +=C2=A0=C2=A0=C2=A0 CGS_PLATFORM_SEV_ES,
> > +=C2=A0=C2=A0=C2=A0 CGS_PLATFORM_SEV_SNP,
> > +=C2=A0=C2=A0=C2=A0 CGS_PLATFORM_TDX,
>=20
> QEMU only has support for SEV & SEV_ES today. We should leave the
> others until we actually get an impl of SEV-SNP/TDX in QEMU that
> supports those platforms.

Ok. I'll remove the currently unsupported platforms.

>=20
> > +} ConfidentialGuestPlatformType;
> > +
> > +typedef enum ConfidentialGuestMemoryType {
> > +=C2=A0=C2=A0=C2=A0 CGS_MEM_RAM,
> > +=C2=A0=C2=A0=C2=A0 CGS_MEM_RESERVED,
> > +=C2=A0=C2=A0=C2=A0 CGS_MEM_ACPI,
> > +=C2=A0=C2=A0=C2=A0 CGS_MEM_NVS,
> > +=C2=A0=C2=A0=C2=A0 CGS_MEM_UNUSABLE,
> > +} ConfidentialGuestMemoryType;
> > +
> > +typedef struct ConfidentialGuestMemoryMapEntry {
> > +=C2=A0=C2=A0=C2=A0 uint64_t gpa;
> > +=C2=A0=C2=A0=C2=A0 uint64_t size;
> > +=C2=A0=C2=A0=C2=A0 ConfidentialGuestMemoryType type;
> > +} ConfidentialGuestMemoryMapEntry;
> > +
> > +typedef enum ConfidentialGuestPageType {
> > +=C2=A0=C2=A0=C2=A0 CGS_PAGE_TYPE_NORMAL,
> > +=C2=A0=C2=A0=C2=A0 CGS_PAGE_TYPE_VMSA,
> > +=C2=A0=C2=A0=C2=A0 CGS_PAGE_TYPE_ZERO,
> > +=C2=A0=C2=A0=C2=A0 CGS_PAGE_TYPE_UNMEASURED,
> > +=C2=A0=C2=A0=C2=A0 CGS_PAGE_TYPE_SECRETS,
> > +=C2=A0=C2=A0=C2=A0 CGS_PAGE_TYPE_CPUID,
> > +=C2=A0=C2=A0=C2=A0 CGS_PAGE_TYPE_REQUIRED_MEMORY,
> > +} ConfidentialGuestPageType;
> > +
> > =C2=A0struct ConfidentialGuestSupport {
> > =C2=A0=C2=A0=C2=A0=C2=A0 Object parent;
> > =C2=A0
> > @@ -60,6 +96,46 @@ struct ConfidentialGuestSupport {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0 char *igvm_filename;
> > =C2=A0#endif
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * The following virtual methods need to be im=
plemented by systems that
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * support confidential guests that can be con=
figured with IGVM and are
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * used during processing of the IGVM file wit=
h process_igvm().
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Check for to see if this confidential guest=
 supports a particular
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * platform or configuration
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 int (*check_support)(ConfidentialGuestPlatformType =
platform,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint16_t platform_version, uint8_t highest_vtl,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint64_t shared_gpa_boundary);
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Configure part of the state of a guest for =
a particular set of data,
> > page
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * type and gpa. This can be used for example =
to pre-populate and
> > measure
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * guest memory contents, define private range=
s or set the initial CPU
> > state
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * for one or more CPUs.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * If memory_type is CGS_PAGE_TYPE_VMSA then p=
tr points to the initial
> > CPU
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * context for a virtual CPU. The format of th=
e data depends on the
> > type of
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * confidential virtual machine. For example, =
for SEV-ES ptr will point
> > to a
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * vmcb_save_area structure that should be cop=
ied into guest memory at
> > the
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * address specified in gpa. The cpu_index par=
ameter contains the index
> > of
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * the CPU the VMSA applies to.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, ui=
nt64_t len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConfidentialGuestPageType =
memory_type,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint16_t cpu_index);
> > +
> > +=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Iterate the system memory map, getting the =
entry with the given
> > index
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * that can be populated into guest memory.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> > +=C2=A0=C2=A0=C2=A0=C2=A0 * Returns 1 if the index is out of range.
> > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0 int (*get_mem_map_entry)(int index,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ConfidentialGuestMemoryMapEntry *entry);
> > =C2=A0};
> > =C2=A0
> > =C2=A0typedef struct ConfidentialGuestSupportClass {
> > --=20
> > 2.43.0
> >=20
> >=20
>=20
> With regards,
> Daniel


