Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF769C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwYCu-0005ug-F8; Wed, 19 Aug 2026 00:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wwYCt-0005uP-2x
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:47:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wwYCr-0003se-7a
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:47:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lcQ51954729
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 joxpXnm9S9eW96P7L0zcaqgsjWYNIV5xu0uAuzygQDE=; b=gDGwvBGq0TATfwpb
 XhsYgqUjqDUDHmvRYkzcfwkr1rP1rhr50IHHNoLCBekxBTGFcYNDWst9V51ESIlh
 wKI9wSnAWNzg2KHWZbW2uPbtNIm3PvjIayKcdebZNaKLFxQVXnLbVfVPM/ywQksa
 BFehlyerEzhXcKeCqFBZVcQsHPbkmjPs37taMyWsW3CMi2ut0xWNSk3WHuiD4M59
 pHQYpULMabq3iDXZanyV2uH/fy5XmmCVzM62gEb7iXUJrMfeWTYEqzS0mmlJ5G+a
 93H0uzgIQwVNvtNHlCsphYeaOMLI2ubuQGcSeuletQs5MjkkNZRh1NQtidI052Cn
 5rUZ4g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfk9bk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:47:15 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7386e55c63cso8439137.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787114835; cv=none;
 d=google.com; s=arc-20260327;
 b=pvd9uxtflSPskYBysuCAFw0NVKiEB4PcPWd6IqX4tWOo62OCrrtOpX9sLP7ACrgtsI
 lu0UN6IAqXXl5CrxSEMa9AJoB2ysRcp/pbDSeSn6Hq/4vk3GBiS+GvsCN5U+PP/H1+69
 uLwW3CMiD3Kz5MGWE5uPXcK3QkqVFzMSs5Sv6jSU0yn38l7CaDlikfjzTuxdvGKJn5PR
 WnIacffgi3zL2Nuybw5ZdBJuH/R2GAWk7Tenps0dBGpKu8w7UtVfwVncXQdyJyJYwlpj
 haU15sm8JNweZYsUZgkReFL+o3Z9fMwGxfYejefACw2Xr/RveEVRdjy6qtknwMG2i0ow
 0wrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=joxpXnm9S9eW96P7L0zcaqgsjWYNIV5xu0uAuzygQDE=;
 fh=bK716FSy/wVwonpvFtOB1xGk5UZ1p0IQPljqZAeUOmU=;
 b=NYsvdPlQPLU+VFa6kpO63MuNxohqRVEj7V34Jpv3h+jYTbyuQJ3q2Sc6Tv+Ix3pNPC
 Lf41Q/dC0RdZ9sZoZqMFQNuXkzdpPAIgN5/5maMefkEediF1Q7sAddfWSgcy/KHVZCyW
 6xpyt95rwLLV6DD+yuB9wH4gS+fJHTouiQJpdxdF21f4qt/V1dlLQOmGlqPPCw756WOA
 7vcaXitRhLJP5hGAfu3y76DqUCJjhH5Q8h1IwekLOnRETpmz8wHA1KtN2As1rDC9rRl6
 qAhXGX2FRkgvIRDTfoKf55jzfuRzsnAdDuMb2LUkL63PCinDUNojKjhKcjUH4AUigssE
 DnUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787114835; x=1787719635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=joxpXnm9S9eW96P7L0zcaqgsjWYNIV5xu0uAuzygQDE=;
 b=kKg4EQAfX6kqr3aVG5EFS/ouIQJo7Ny79dwHuq2I657tscMuW9gQcBh7JELrYuhWYG
 mpEEYKLz/f84+FPX+ohADOAGNLFbxxZeIKBshA+cFqejQOkrn3oHqFBLpJ8Qz/N6PEdI
 0JoOpG9bvw03v6lGKhGVUP5uXl3flKMwa1DKcvJR1nYfVea8mQ+ib0VpRFD4RGgPON1P
 7ffY0v8Y8fgSzOCtz4ifNAvzy2trqiE2LoVi2xDV6RkjbLEi1jL9d1fJfrw9Lg8DTBCy
 RzLFxD0kXKQr1tRNGu9MOm/AmGYgJ2xHgrhicconib3k9VZpWB1PZnLCeMu5Ks8gLRua
 LjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787114835; x=1787719635;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=joxpXnm9S9eW96P7L0zcaqgsjWYNIV5xu0uAuzygQDE=;
 b=J5Ss76bF4OFzJTOziaXquyw92zK0B/G7cRm+fyyegfj9OAZRiU6jBXB2ADPdacVZDp
 kvXQnzlTsfu+qitJXTPQcuL2mJV6W1RFpA2xDxd6mWxgTF9jgBUiXU1LySvbwRzlTAv+
 RY9fvG1/AKozN+Rr8SyC6uN9l3DzANIory+NI7t7A1DfILXNaa6ZaW4Y38sk5yWG2ZSc
 qBDsJsf+z/WRNUMPui/FpVSgc0cStYBPj84xaBRAV0QL00xMSQD/41hW5D69bIiw8ozg
 BiUOOCyg/ldMG2htYdUEiEXZN3AexnR4wUiNuGHs6ABK7gae9eOx4W/qj2dEw6VWGWNi
 BsCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+tJDSM+vlInoPNrBc+eb7O9mBHFgLHCJyF/SOWw91vdL/+7Kkx0Nvo0PxvxMV6nHvf9tf7P3Z1WO+@nongnu.org
X-Gm-Message-State: AOJu0YzIuBZmYr6y65xOpUp+yu83blA/x+1TyhALeHrAFpH9GxBByLQL
 BwiOAVGlY2BA+icwWpjpUTydIrkmAhkDGkYggMPgypJ6TqzO0V/IuBtzlmP3ZnbtBJKRfiGc3yd
 nn1TFL4TKn8BsD3Tu5yKlV7FJVG3KMOn4G5P9mKYV7aTxmm6U56SQMnTAR7E1709jGPuIO8ElGM
 2Jktb4JPhA1fAK+GUjF6Q7n2H7STiURh7z
X-Gm-Gg: AR+sD11bZvnDwdgdAIwIoBl54AYCF8wpdgvsmS4YSNp2I8BBSRvVe4E5t4laB423yB0
 Q3fhwGUZlfgc4Bf3CH5ZapU9rfcgiBrdGLdmn9U4hDGIOiH+aHFHppxOWrs173HAXQ8s36ofKH5
 HeIwO2jGCKm1NgJ4uAGUrvwubeslWbP+s5os4BV1IA8hskomui9tytf8GBe/w=
X-Received: by 2002:a05:6102:8024:b0:772:cccb:f7eb with SMTP id
 ada2fe7eead31-777fb1adaf4mr198054137.2.1787114835090; 
 Tue, 18 Aug 2026 21:47:15 -0700 (PDT)
X-Received: by 2002:a05:6102:8024:b0:772:cccb:f7eb with SMTP id
 ada2fe7eead31-777fb1adaf4mr198038137.2.1787114834696; Tue, 18 Aug 2026
 21:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-3-subrahmanya.lingappa@oss.qualcomm.com>
 <CAB19ukFjhg9HEbKKBH1+i8pkLnC4wEH3zGyXhHcTbBLdgFJgTQ@mail.gmail.com>
In-Reply-To: <CAB19ukFjhg9HEbKKBH1+i8pkLnC4wEH3zGyXhHcTbBLdgFJgTQ@mail.gmail.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 10:17:03 +0530
X-Gm-Features: AcwNN1U7X0_dLmtsAo2der5Hg8cBSKkJZ8SecGLKWi0I2o1YGiOshPux14ssWwc
Message-ID: <CAPxK-6doRDXNDTcfrCn0p-R_BG9zFZC+oYzEV9XNRg29x-Q7Ag@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] hw/misc: add RISC-V RPMI transport and Base
 support
To: sunilvl@oss.qualcomm.com
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=PoGjqQM3 c=1 sm=1 tr=0 ts=6a853553 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=V1jnuoLLAAAA:20 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=mJGyiu_LM0gBUnUUHQIA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzMyBTYWx0ZWRfX5Pp7WXV1feQV
 XH3zwMjfTByIeSfIFkDBeKQLU94kx1S6aECZ1+PHpEucgR1tflrg7Vlkq/YdNBZwRxJvk4OxEAK
 LUrKjBjSH7XZqfbdCiozBpcfBZdhE0yHZEr7/0Tewy52qv5LjZXFLuO9TNTrE23PKshXnzN2nb0
 rYFdDJb2gQa2psqh+h5zL0Fxvrb4hFNmhSI/uSvia5shl2ZKcadbWye+1itujYHydXBYynnI/4o
 KYiu95RFXWVLx40wqKWgVgvP07hZ/5cEjSaf7KTzQYQd109HxDAAsJ+3zTdiUsu82gw61Ly/I9f
 lzwVnpiZYyEhUcZkDXP3s/8HNCagYG6YIWUosjijzaBo1U5bXJPB6oaf9vsvlWq7qZaVVfKPtch
 4s8VEXUuPkRo9vdvmuMoFmB9nestiSgX7mOYDdnf5oySallXVINj2VYJ2nx0EYC9akGpsFJudsg
 QMSiRyiai16LqS1BqWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzMyBTYWx0ZWRfX68Qd1G3/amOY
 Lw/uEsPAhZnqCbMnXFvdZmVsv4SnZQ0A7EPeJF4m4zC4qDm7VB4urt4koY+GbHy113N7dOKee2p
 ejLMCzgCQUErTyVE5aTn/DrObiAAuzU=
X-Proofpoint-GUID: TDAh-P4TkD7V1NkZ_Zflh4rkAXEt1d-s
X-Proofpoint-ORIG-GUID: TDAh-P4TkD7V1NkZ_Zflh4rkAXEt1d-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sunil,

On Mon, Aug 17, 2026 at 12:23=E2=80=AFPM Sunil V L <sunilvl@oss.qualcomm.co=
m> wrote:
>
> On Fri, Aug 14, 2026 at 10:25=E2=80=AFAM Subrahmanya Lingappa
> <subrahmanya.lingappa@oss.qualcomm.com> wrote:
> >
> > RPMI (RISC-V Platform Management Interface) is the RISC-V non-ISA
> > platform management specification. It defines a shared-memory transport=
,
> > message protocol, and service groups for platform management.
> >
> > Add the QEMU transport backend and Base service plumbing for virt using
> > librpmi.
> >
> > This implementation targets the RISC-V Platform Management Interface
> > (RPMI) Specification v1.0 Ratified:
> >
> > https://github.com/riscv-non-isa/riscv-rpmi/releases/download/v1.0/risc=
v-rpmi.pdf
> >
> > The librpmi backend is maintained at:
> >
> > https://github.com/riscv-software-src/librpmi
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > ---
> >  MAINTAINERS                   |   2 +
> >  hw/misc/Kconfig               |   4 +
> >  hw/misc/meson.build           |   3 +
> >  hw/misc/riscv_rpmi.c          | 477 ++++++++++++++++++++++++++++++++++
> >  hw/misc/riscv_rpmi_internal.h |  24 ++
> >  include/hw/misc/riscv_rpmi.h  |  90 +++++++
> >  6 files changed, 600 insertions(+)
> >  create mode 100644 hw/misc/riscv_rpmi.c
> >  create mode 100644 hw/misc/riscv_rpmi_internal.h
> >  create mode 100644 include/hw/misc/riscv_rpmi.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 93df53d87f..8e91a31757 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -359,6 +359,8 @@ F: target/riscv/
> >  F: hw/char/riscv_htif.c
> >  F: hw/riscv/
> >  F: hw/intc/riscv*
> > +F: hw/misc/riscv_rpmi*
> > +F: include/hw/misc/riscv_rpmi.h
> >  F: include/hw/char/riscv_htif.h
> >  F: include/hw/riscv/
> >  F: common-user/host/riscv*
> > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > index 1543ee6653..998944c342 100644
> > --- a/hw/misc/Kconfig
> > +++ b/hw/misc/Kconfig
> > @@ -258,3 +258,7 @@ config XLNX_ZYNQ_DDRC
> >      bool
> >
> >  source macio/Kconfig
> > +
> > +config RISCV_RPMI
> > +    bool
> > +    depends on LIBRPMI
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 23265f6035..e7c2ebe28f 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -168,3 +168,6 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: fil=
es('sbsa_ec.c'))
> >
> >  # HPPA devices
> >  system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
> >
> NIT: A blank line here would be better.
>
> > +system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
> > +  'riscv_rpmi.c',
> > +), librpmi])
> > diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
> > new file mode 100644
> > index 0000000000..54a790fc7c
> > --- /dev/null
> > +++ b/hw/misc/riscv_rpmi.c
> > @@ -0,0 +1,477 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * RISC-V RPMI transport device.
> > + *
> > + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> > + * Author:
> > + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/log.h"
> > +#include "qemu/module.h"
> > +#include "exec/cpu-common.h"
> > +#include "hw/core/qdev-properties.h"
> > +#include "hw/misc/riscv_rpmi.h"
> > +#include "hw/misc/riscv_rpmi_internal.h"
> > +#include "migration/vmstate.h"
> > +#include "system/address-spaces.h"
> > +#include "system/runstate.h"
> > +#include "librpmi.h"
> > +#include "librpmi_env.h"
> > +
> > +void *rpmi_env_zalloc(rpmi_size_t size)
> > +{
> > +    return g_malloc0(size);
> > +}
> > +
> > +void rpmi_env_free(void *ptr)
> > +{
> > +    g_free(ptr);
> > +}
> > +
> > +void rpmi_env_writel(rpmi_uint64_t addr, rpmi_uint32_t val)
> > +{
> > +    cpu_physical_memory_write(addr, &val, sizeof(val));
> > +}
> >
> These cpu_physical_memory_*() interfaces are renamed, right?
>

  Thanks, fixed. I added the blank line in hw/misc/meson.build and replaced
  the old cpu_physical_memory_*() calls with physical_memory_read/write()
  in the latest version.

Thanks,


> Thanks,
> Sunil

