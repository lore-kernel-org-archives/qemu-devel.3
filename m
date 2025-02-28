Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010FC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvvK-0001Xj-1n; Fri, 28 Feb 2025 03:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1tnvvF-0001X8-45
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:40:41 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <whendrik@google.com>)
 id 1tnvvC-0004Gt-SN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:40:40 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54843052b67so5034e87.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740732033; x=1741336833; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dD28A57sVjiWC6X48OlhUkb/GIydYN9wgk75ukfUROU=;
 b=QUYayVNx1XLAT/NxpSBnSMN8KbpfNM+7f5ISvyxPZGFmancgtAGrKd9AoWGwbLu+/+
 7ilBQLjhhnEsOxTdzHUIJ2A1opKu5R4xCfsbIrBeZjGNcRrr+s0JKrTPP/ebdqooNrRW
 1OW1yCRynE3yQ2eppJ93yc1sj1urWxtq0FiQ4VIhRzI0rHR3HdUbQcSoRMHTB9XBNHGk
 EVyXB5VeFfi0DNOGvLbCmO8EMj4gl18G174qGuEStVRVbqBzhUJ11aRfq8kezZnEki9q
 o3SpbeAhOQ62LVSDi4OAOX70oK1eRtPHZT8L4hBQktqkJHI1dtEPunRQk+WEL8snI2Ld
 eM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740732033; x=1741336833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dD28A57sVjiWC6X48OlhUkb/GIydYN9wgk75ukfUROU=;
 b=PDCmXN9ChDCI//qlfF6NTCra1nxxCx/R2xzHydnk65UrXt3MnOcHpq35mrYT3NXbVf
 h4XqYw5zlRZKspZzhnNBmKeBT0cq3RDmgpxpXLPqP1d03c+n/vj2nmMyPnkZAxWJKirK
 xTRSSxVFwUVoVbvdPIt3kb9tibSS/aYhGHSd+kJpWwAS1+ugNqgnSEiSifZ64oMmXsJm
 a2Fk69CLibEN01/7xk1pbQxEKukHWvjOF+LDp17dqvZ+OIrzWmcr2CUTMnREXAZpYoWH
 SoD2Gtp2erthVy5NHNgusYcdnKqrXknV+wJIxQ3zOUi8/fcoll4CxYXGubJ/Q9bk9fkp
 znOg==
X-Gm-Message-State: AOJu0YyibiDx43n1ZC8RhYZ209sKHqqbZy89nyMFLoH+AE0ZkkQOFK2M
 XwFyP8yS0wLoyktZTDsA50RRCgzN/DZavNcSblXhsI6/z4SF1b7AuNvg0S81oIBd8BgAJ0jxwlO
 yBSFQrSnaewAUm1dJkljfBkChgxc4siuC98qB
X-Gm-Gg: ASbGncv/0YooFjuv5ByscjtBByZCITHIE4R2FS/E6ZuWXkUvJEXab+zp5c9eq5zILnm
 QGs/7Zed67PZrpWNQ7y7o/G7WfztwepwQOEq2EOCvBXZinNRgc7eVS8HRvp9JZMqOqSfzX3Cq9g
 t5tQC7ZdGhVW60nYmItVjaZoxEDe/VYhWCFTqfRg==
X-Google-Smtp-Source: AGHT+IF5aWrQ5iua4NPryDgBXdqdZH+ZNEsPWPPRjgyZZLNMDwoPwegq66Juv1c++LkBpPidsNUXeg9DRpgbiCcwft0=
X-Received: by 2002:a05:6512:3d22:b0:543:cf0c:ed14 with SMTP id
 2adb3069b0e04-5494f233497mr99906e87.5.1740732032430; Fri, 28 Feb 2025
 00:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
 <20241213172645.2751696-2-whendrik@google.com>
 <20250220154125.00007a08@huawei.com>
In-Reply-To: <20250220154125.00007a08@huawei.com>
From: =?UTF-8?Q?Hendrik_W=C3=BCthrich?= <whendrik@google.com>
Date: Fri, 28 Feb 2025 09:40:20 +0100
X-Gm-Features: AQ5f1Jqoa3pAbYj0GPVJnrnbNC4Kx0sJZoqBwOvA5_5Zo2o2zoq6RvRJ3BYLy6U
Message-ID: <CAEX-0WuNQcH4-eNT9KRFOnb1Gubi8=ioaNfCZb0idQZwF_iYEg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] i386: Add Intel RDT device and State to config.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, peternewman@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=whendrik@google.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Feb 20, 2025 at 4:41=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 13 Dec 2024 17:26:38 +0000
> Hendrik Wuethrich <whendrik@google.com> wrote:
>
> > From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
> >
> > Change config to show RDT, add minimal code to the rdt.c module to make
> > sure things still compile.
> >
> > Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
> Hi,
>
> A few drive by comments.
>
> > ---
> >  hw/i386/Kconfig       |  4 ++
> >  hw/i386/meson.build   |  1 +
> >  hw/i386/rdt.c         | 99 +++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/i386/rdt.h | 25 +++++++++++
> >  target/i386/cpu.h     |  3 ++
> >  5 files changed, 132 insertions(+)
> >  create mode 100644 hw/i386/rdt.c
> >  create mode 100644 include/hw/i386/rdt.h
>
> > diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> > new file mode 100644
> > index 0000000000..b2203197e3
> > --- /dev/null
> > +++ b/hw/i386/rdt.c
> > @@ -0,0 +1,99 @@
> > +/*
> > + * Intel Resource Director Technology (RDT).
> > + *
> > + * Copyright 2024 Google LLC
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published by t=
he
> > + * Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> > + * for more details.
> > + */
> > +
> > +#include "hw/i386/rdt.h"
> > +#include "qemu/osdep.h" /* Needs to be included before isa.h */
> > +#include "hw/isa/isa.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qom/object.h"
> > +
> > +/* Max counts for allocation masks or CBMs. In other words, the size o=
f
> > + * respective MSRs.
> > + * L3_MASK and L3_mask are architectural limitations. THRTL_COUNT is j=
ust
> > + * the space left until the next MSR.
> > + * */
>
>
> Should match multiline comment style in qemu style guide.
>
> > +
> > +/*One instance of RDT-internal state to be shared by all cores*/
> > +struct RDTState {
> > +    ISADevice parent;
> > +
> > +    /*Max amount of RMIDs*/
>
> Spaces typically after * and before * I think are most common
> syntax for comments in qEMU
>
> > +    uint32_t rmids;
> > +
> > +    /*Per core state*/
> > +    RDTStatePerCore *rdtInstances;
> > +    RDTAllocation *allocations;
> > +
> > +    /*RDT Allocation bitmask MSRs*/
> > +    uint32_t msr_L3_ia32_mask_n[RDT_MAX_L3_MASK_COUNT];
> > +    uint32_t msr_L2_ia32_mask_n[RDT_MAX_L2_MASK_COUNT];
> > +    uint32_t ia32_L2_qos_ext_bw_thrtl_n[RDT_MAX_MBA_THRTL_COUNT];
> > +};
> > +
> > +struct RDTStateClass {
> > +};
> > +
> > +OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
> > +
> > +static Property rdt_properties[] =3D {
> > +    DEFINE_PROP_UINT32(RDT_NUM_RMID_PROP, RDTState, rmids, 256),
> > +    DEFINE_PROP_END_OF_LIST(),
>
> You'll see this in a rebase but this terminator is no longer needed
> (or defined I think)
> > +};
> > +
> > +static void rdt_init(Object *obj)
> > +{
> > +}
> > +
> > +static void rdt_finalize(Object *obj)
> > +{
> > +}
>
> Why introduce this pair as empty and as far as I can see not called?
> init is called in patch 2 so bring it in there.  I'm struggling to
> spot finalize being called.

Because the init and finalize functions are needed by the macros
representing the RDT device, and the patch does not compile
if they are removed.
>
>
> > +
> > +static void rdt_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->hotpluggable =3D false;
> > +    dc->desc =3D "RDT";
> > +    dc->user_creatable =3D true;
> > +
> > +    device_class_set_props(dc, rdt_properties);
> > +}
>
> >      int32_t node_id; /* NUMA node this CPU belongs to */
>

