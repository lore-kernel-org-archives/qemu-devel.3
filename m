Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F002BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 04:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwYH2-00071H-Sz; Wed, 19 Aug 2026 00:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wwYGz-00070y-Rm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:51:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wwYGx-0004Vo-9I
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 00:51:33 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lYWh3507961
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 txKH795hGKu3xmk2anV8CGiNddOTQS8nBNAzB7UPoJg=; b=LPFYBwWuZN5YmKfZ
 Q7FjJuMA6HCssZUuasRO6FvMaWonJVJ2C7/7dZfdIycehGl423Ecd7I4pgVog2qt
 MqYwRNJkC6Qv3mVx+qCn0BVrxhMjcajMILrHh9jXHhQeqby6CrT7xl3QOwkjm8mD
 bF7xtDTVdkKCFlodek247C/5rtghdf3aph8u4gO0E1JW8HSLZQF6vJsclSQ/siFt
 u4fNOPs1CKN3sjJChoxVep2wAHQEnrKxEV59B6FVmYTJB97upbANBTkeQYqf8Mhg
 QDvxF1382CZdcPCrQiBagF0v/REICkyI+eTM6wNfJZ/RuJjwhPO9cLz8Q4mwETU9
 aLpICg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm9bna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:51:29 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c38fb5d952so20638e0c.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 21:51:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787115089; cv=none;
 d=google.com; s=arc-20260327;
 b=V5emYSnso/4qGrwfcRVGWAjtRckRDCNpnbp/UrV3NpHSPS0H+xIsAchH4DpDtuu7vo
 vs9BYQ2b/gkBRdXQNln0N+Apqh24pwaVTmLRfPwVRwCTbaCKNU5cZuyP5P8yufeh04eb
 /Wdq9fRpp/vNlBm2YB9msRVUk8YE+nkm6tZ4d4aT4W9U6vPGasLEPSqKmTEpr50Ge/M9
 mFFg2hlf6UU97x2XREPrQ9bGt3CFm3oKOU0uKvUBbue7mYnG2+j3uQYFURke1pMF2XUD
 xESY2M9tLV9ldrFX9eyhUkspeZlzKUNkB1Oj85HXlmklSIjCSbxPK/wXz/LhUB70o9//
 G06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=txKH795hGKu3xmk2anV8CGiNddOTQS8nBNAzB7UPoJg=;
 fh=gpvkpv8rQAQ/0LE9kf16Tjkr3n/3eFyS2e0o/Q67Rrc=;
 b=Czr9v3yG6SY/Dg7hok5sDjwhe9z+euJG5rW72LYEJrM2ciIgAoODu83nvNdiS91u4c
 IXmyRjAj4NbhayrY94+NRzGw62dJuy5ufBGx9R0llijQu5EqGvMTmn2wWHQ9A00S9d5Y
 zYAHtPsTCpbjqQt8tkykpJ8DBRB2r3GUv8cuTDEYoKYCBRvPMJMLUyZ1hdcWiN4dZAjH
 phOQD6+E4aUunqowXR1jDJAy+hBlSuXETDCOZyK4/LWaWpgUMcUg6CiWQWeRBO9l3Xiu
 CwH/CUOEF2dVqK26UBIjSgV8uQULL6OwtslWzEe8gVv+3E8QGA6HxHlfRAw+/CASdgqB
 tndA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787115089; x=1787719889; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=txKH795hGKu3xmk2anV8CGiNddOTQS8nBNAzB7UPoJg=;
 b=Pj2arz4TzYHFh/F0oDoROWXUrz2SSZL5CwebFyUplw8uymdj0EocULG1j52pm5hBwR
 s4xNPxmmbKy2N6k0Yg4bZCCXGQA41C/0xScdkRM2zXb1EoKLa1UXyMbqHvY25WCsOQEr
 9SzerFl7mP33IOK1//xGiFGNinRMyKNysTaFp9v5j6+wmngTTM3YCE1hlSyPcBBhZc0G
 0AoV8X3lDmmB5F+Ab+g/sCVoXdrJjfsylJP/HZLKuCpbnnsdo7GzRn+ZOhdsR7WSAZyD
 UofbNQqTmxxs4aThDo6wOmSP9hWgFJr532JtmEjbODuDaNgP0gjfBvTYw7Vw3XU5f7xo
 HOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787115089; x=1787719889;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=txKH795hGKu3xmk2anV8CGiNddOTQS8nBNAzB7UPoJg=;
 b=cHD0jtDcn1hO1wQheBve4wwmfaY49L2wozmsIHQCPP3HpQLAvXL9ptx00+8d6BAL1j
 p3OEGwI4Cm4zkcGJ5JzJ3AXkPV0Qk5Om/7ENOBEfyzI5+R1kIsAUkNl6QmGev9J+fSB9
 RN4LSmDHkKft+tbZD0TBbMBVWfBakWViY2bxFpak9qtHz0OOVsm46F7wId2PXnwYS27I
 PGhCpPoyLljqXhLuXlwrRzObFksn7533x4PGaU0MyaSWm0Tb7eaL5In14bW63Ffbxf7C
 kwLaIdP+dsTFJqWqMkrbYVOMlaDznlC3rIl7Np+r8zdxGfmOyXGVyhD0RPIWSosBEkXV
 8H6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpV4sRU8StL7eD2DewGAlfGCGLWy48tYquZMzH7V1ccU6S2PlwhRlfIfzWBAo5UjQOecRB7OXW5cd7@nongnu.org
X-Gm-Message-State: AOJu0Yx8jeKryuftJdiwLg+uxGQxM/6xYhw0i9uYaleX2k5FtFgXU9sQ
 Fuv5AA2ELwmSJf/hDxcgDoF5T+vHk8KYaQtQidca71kDMlOLECfhBYVn2IrHWHaL9ZtDd9sFso/
 +qwpmQs1/9+4Ri90pYXxG69EK3kphTomhxuW4vtWdxPOGhEV5lAx1KsEHyRd/QqOWX7+5j3cY3W
 guFlfBPm6+tF2OoDOVhDHkEp04Igtzd/wz
X-Gm-Gg: AR+sD131iQPb9R1zGgNOta4KEGLrQpFKMC4w/LmM7BqyMnKyjEc0910d4QCZdGFbl9t
 +XSTyj+5Gxb5xQpcwt2WtruWZFXWi/N1HJaME/QVctMj3SQF5CV9xJnTY3Jqg9JaI+3ijS9IU7v
 /ydVkrgHURyF8pX18NsPC/MC4TP5wpWyjHzwKmJCPulbKMuvDlONtZGHJySa0=
X-Received: by 2002:a05:6102:2c15:b0:74a:b1ee:e21b with SMTP id
 ada2fe7eead31-777faba447cmr190724137.1.1787115088934; 
 Tue, 18 Aug 2026 21:51:28 -0700 (PDT)
X-Received: by 2002:a05:6102:2c15:b0:74a:b1ee:e21b with SMTP id
 ada2fe7eead31-777faba447cmr190716137.1.1787115088358; Tue, 18 Aug 2026
 21:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-10-subrahmanya.lingappa@oss.qualcomm.com>
 <CAB19ukFGinPjP+w89tm=1+0s+fFYr7PsXED08+wa-LznVS=zhg@mail.gmail.com>
In-Reply-To: <CAB19ukFGinPjP+w89tm=1+0s+fFYr7PsXED08+wa-LznVS=zhg@mail.gmail.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 10:21:17 +0530
X-Gm-Features: AcwNN1VTWZ532RvAScdHbg0Yovib3jvHqAuGerch2xo9Y3siSnbn1NrKv0oOReA
Message-ID: <CAPxK-6fzMcD7mSfatoAcX4TCmnHyfsjJH_UEgRW1vNPLwBqjZA@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] tests/qtest: cover initial RISC-V RPMI services
To: sunilvl@oss.qualcomm.com
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: g0AVb8socxjyMWKGMObkFenbD6zAmWxv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAzMyBTYWx0ZWRfX13qx2aDbYGJ5
 IOYXtYAne2WDlfKPvzmETqflU8/PtDtXydG1n6QZzeLBCf3Ltna7B6KR2lQc/c9Qd4UQ7mHClv6
 MUIOVGIJZ71RUjaIT7kwMVWV+PUQoGo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAzMyBTYWx0ZWRfX9xpfiGlpHFQm
 4oQ7OBUp1eOUPnwM5X91T3cq2l1zqx2/TuJjdHwdxuau8mZWeMANDvAb1T5bY8iuUF9ytQtgDuB
 CPuYrPcjmSum2JhUWAKt/9xm3eM4OmSDxMCpPxQCfzZDHqu/KShj52Wn+rUuMRVwg3WrYPzEhWs
 Mt3pBsVWDEKXFqFLWmw8sdRqfqVvUQQo84c+4nYi890Yog1SIF0hQNRb3rvJB82vXMeU68H3Ln6
 GGgMAgSmR9dR+YR/kO2rvz2qSHq7mgUIj9cCMr2+PVI1iWl3U3w+CcI/UoUe88SGYW+ynsKqpW5
 YvCfmXnJZ+S2YkiO8O8pBZKHBkmwjIx4YZsRCXeQ02fNXbWpgzKeaxqNPONCQ8oSgvf5k/5JXQ8
 p7dB4j4RXXm15vcz9QAzXGp9dvd7/wWpuUAbnWyQOEa1G2QwcNWKHTdkOwO6d1KqMcNL+jBlm0K
 PZF9NhBj11wOIjFdd2w==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a853651 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=Yz7Z3I83_d7m3j8O65UA:9
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: g0AVb8socxjyMWKGMObkFenbD6zAmWxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
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

On Mon, Aug 17, 2026 at 4:38=E2=80=AFPM Sunil V L <sunilvl@oss.qualcomm.com=
> wrote:
>
> On Fri, Aug 14, 2026 at 10:24=E2=80=AFAM Subrahmanya Lingappa
> <subrahmanya.lingappa@oss.qualcomm.com> wrote:
> >
> > Add qtests for the RPMI transport plus Base, system reset, HSM, and
> > system suspend service groups.
> >
> > Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.=
com>
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > ---
> >  MAINTAINERS                   |   1 +
> >  tests/qtest/meson.build       |   2 +
> >  tests/qtest/riscv-rpmi-test.c | 684 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 687 insertions(+)
> >  create mode 100644 tests/qtest/riscv-rpmi-test.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8e91a31757..6dd71c5a82 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -361,6 +361,7 @@ F: hw/riscv/
> >  F: hw/intc/riscv*
> >  F: hw/misc/riscv_rpmi*
> >  F: include/hw/misc/riscv_rpmi.h
> > +F: tests/qtest/riscv-rpmi-test.c
> >  F: include/hw/char/riscv_htif.h
> >  F: include/hw/riscv/
> >  F: common-user/host/riscv*
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 4897325d84..d54b79cbcf 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -290,6 +290,8 @@ qtests_riscv32 =3D \
> >
> >  qtests_riscv64 =3D ['riscv-csr-test'] + \
> >    (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
> > +  (config_all_devices.has_key('CONFIG_RISCV_RPMI') ?
> > +   ['riscv-rpmi-test'] : []) + \
> >    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
> >     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
> >     ['iommu-riscv-test'] : []) + \
> > diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-tes=
t.c
> > new file mode 100644
> > index 0000000000..dab723b999
> > --- /dev/null
> > +++ b/tests/qtest/riscv-rpmi-test.c
> > @@ -0,0 +1,684 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + *
> > + * QTests for RISC-V RPMI devices.
> > + *
> > + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> > + * Author:
> > + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include <glib/gstdio.h>
> > +#include "libqtest.h"
> > +#include "qobject/qdict.h"
> > +
> > +#define RPMI_SHMEM_BASE 0x10200000ULL
> > +#define RPMI_DOORBELL_BASE 0x10230000ULL
> > +#define RPMI_IMSIC_S_BASE 0x28000000ULL
> > +#define RPMI_CPPC_FASTCHAN_BASE 0x10240000ULL
> > +#define RPMI_CPPC_FASTCHAN_SIZE 0x4000
> > +#define RPMI_CPPC_FASTCHAN_FEEDBACK_OFFSET 0x2000
> > +#define RPMI_SLOT_SIZE 64
> > +
> > +#define RPMI_A2P_HEAD RPMI_SHMEM_BASE
> > +#define RPMI_A2P_TAIL (RPMI_SHMEM_BASE + RPMI_SLOT_SIZE)
> > +#define RPMI_A2P_SLOT0 (RPMI_SHMEM_BASE + 2 * RPMI_SLOT_SIZE)
> > +
> > +#define RPMI_SRVGRP_BASE 0x0001
> > +#define RPMI_SRVGRP_SYSTEM_MSI 0x0002
> > +#define RPMI_SRVGRP_SYSTEM_RESET 0x0003
> > +#define RPMI_SRVGRP_SYSTEM_SUSPEND 0x0004
> > +#define RPMI_SRVGRP_HSM 0x0005
> > +#define RPMI_SRVGRP_CPPC 0x0006
> > +#define RPMI_SRVGRP_CLOCK 0x0008
> > +#define RPMI_SRVGRP_MANAGEMENT_MODE 0x000b
> > +#define RPMI_SRVGRP_LOGGING 0x000e
> > +#define RPMI_BASE_SRV_GET_PLATFORM_INFO 0x05
> > +#define RPMI_BASE_SRV_PROBE_SERVICE_GROUP 0x06
> > +#define RPMI_SYSMSI_SRV_GET_ATTRIBUTES 0x02
> > +#define RPMI_SYSMSI_SRV_GET_MSI_ATTRIBUTES 0x03
> > +#define RPMI_SYSMSI_SRV_SET_MSI_STATE 0x04
> > +#define RPMI_SYSMSI_SRV_GET_MSI_STATE 0x05
> > +#define RPMI_SYSMSI_SRV_SET_MSI_TARGET 0x06
> > +#define RPMI_SYSMSI_SRV_GET_MSI_TARGET 0x07
> > +#define RPMI_SYSRST_SRV_GET_ATTRIBUTES 0x02
> > +#define RPMI_SYSRST_SRV_SYSTEM_RESET 0x03
> > +#define RPMI_HSM_SRV_GET_HART_STATUS 0x02
> > +#define RPMI_HSM_SRV_GET_HART_LIST 0x03
> > +#define RPMI_HSM_SRV_GET_SUSPEND_TYPES 0x04
> > +#define RPMI_HSM_SRV_GET_SUSPEND_INFO 0x05
> > +#define RPMI_HSM_SRV_HART_START 0x06
> > +#define RPMI_HSM_SRV_HART_STOP 0x07
> > +#define RPMI_HSM_SRV_HART_SUSPEND 0x08
> > +#define RPMI_SYSSUSP_SRV_GET_ATTRIBUTES 0x02
> > +#define RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND 0x03
> > +#define RPMI_CPPC_SRV_PROBE_REG 0x02
> >
> Please add only the required definitions. Not the future ones.
>
> > +#define RPMI_CPPC_SRV_READ_REG 0x03
> > +#define RPMI_CPPC_SRV_WRITE_REG 0x04
> > +#define RPMI_CPPC_SRV_GET_FAST_CHANNEL_REGION 0x05
> > +#define RPMI_CPPC_SRV_GET_FAST_CHANNEL_OFFSET 0x06
> > +#define RPMI_CPPC_SRV_GET_HART_LIST 0x07
> > +#define RPMI_CPPC_NOMINAL_PERF 0x01
> > +#define RPMI_CPPC_DESIRED_PERF 0x05
> > +#define RPMI_CPPC_COUNTER_WRAPAROUND_TIME 0x0a
> > +#define RPMI_CPPC_REFERENCE_PERF_COUNTER 0x0b
> > +#define RPMI_CPPC_DELIVERED_PERF_COUNTER 0x0c
> > +#define RPMI_CPPC_REG_LEN_64 64
> > +#define RPMI_CLK_SRV_GET_NUM_CLOCKS 0x02
> > +#define RPMI_CLK_SRV_GET_ATTRIBUTES 0x03
> > +#define RPMI_CLK_SRV_GET_SUPPORTED_RATES 0x04
> > +#define RPMI_CLK_SRV_SET_CONFIG 0x05
> > +#define RPMI_CLK_SRV_GET_CONFIG 0x06
> > +#define RPMI_CLK_SRV_SET_RATE 0x07
> > +#define RPMI_CLK_SRV_GET_RATE 0x08
> > +#define RPMI_MM_SRV_GET_ATTRIBUTES 0x02
> > +#define RPMI_MM_SRV_COMMUNICATE 0x03
> > +#define RPMI_LOGGING_SRV_SET_CONFIG 0x02
> > +#define RPMI_MSG_NORMAL_REQUEST 0x00
> > +#define RPMI_MSG_POSTED_REQUEST 0x01
> > +#define RPMI_MSG_ACKNOWLEDGEMENT 0x02
> > +#define RPMI_SYSRST_TYPE_SHUTDOWN 0x00
> > +#define RPMI_SYSRST_TYPE_COLD_REBOOT 0x01
> > +#define RPMI_SYSRST_TYPE_INVALID 0x03
> > +#define RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE 1
> > +#define RPMI_SYS_MSI_SHUTDOWN_INDEX 0
> > +#define RPMI_SYS_MSI_REBOOT_INDEX 1
> > +#define RPMI_SYS_MSI_SUSPEND_INDEX 2
> > +#define RPMI_SYS_NUM_MSI 4
> > +#define RPMI_SYSMSI_MSI_STATE_ENABLE 1
> > +#define RPMI_SYSMSI_MSI_STATE_PENDING 2
> > +#define RPMI_TOKEN 0x55aa
> > +#define RPMI_ERR_NOTSUPP 0xfffffffeU
> > +#define RPMI_ERR_INVALID_PARAM 0xfffffffdU
> > +#define RPMI_ERR_INVALID_ADDR 0xfffffffbU
> > +#define RPMI_ERR_DENIED 0xfffffffcU
> > +#define RPMI_HSM_HART_STATE_STARTED 0x00
> > +#define RPMI_HSM_HART_STATE_STOPPED 0x01
> > +#define RPMI_HSM_HART_STATE_SUSPENDED 0x04
> > +#define VIRT_RPMI_CPPC_NOMINAL_PERF 30
> > +#define VIRT_RPMI_CLOCK_COUNT 6
> > +#define VIRT_RPMI_MM_VERSION 0x10000
> > +#define VIRT_RPMI_SHMEM_SIZE 0x20000
> > +#define RPMI_MM_INPUT_OFFSET 0x3000
> > +#define RPMI_MM_OUTPUT_OFFSET 0x3800
> > +#define RPMI_MM_BUFFER_SIZE 0x400
> > +#define RPMI_MM_INPUT_BASE (RPMI_SHMEM_BASE + RPMI_MM_INPUT_OFFSET)
> > +#define RPMI_MM_OUTPUT_BASE (RPMI_SHMEM_BASE + RPMI_MM_OUTPUT_OFFSET)
> > +#define MM_EFI_COMM_HEADER_SIZE 24
> > +#define EFI_VAR_COMM_HEADER_SIZE 16
> > +#define EFI_VAR_ACCESS_NAME_OFFSET 36
> > +#define EFI_VAR_NEXT_NAME_OFFSET 24
> > +#define EFI_VAR_FN_GET_VARIABLE 1
> > +#define EFI_VAR_FN_GET_NEXT_VARIABLE_NAME 2
> > +#define EFI_VAR_FN_SET_VARIABLE 3
> > +#define EFI_SUCCESS 0ULL
> > +#define EFI_INVALID_PARAMETER 0x8000000000000002ULL
> > +#define EFI_BUFFER_TOO_SMALL 0x8000000000000005ULL
> > +#define EFI_NOT_FOUND 0x800000000000000eULL
> > +#define EFI_VARIABLE_NON_VOLATILE 0x00000001
> > +#define EFI_VARIABLE_BOOTSERVICE_ACCESS 0x00000002
> > +#define EFI_VARIABLE_RUNTIME_ACCESS 0x00000004
> > +
> > +#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + 16 * RPMI_SLOT_SIZE)
> > +#define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
> > +#define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
> > +#define RPMI_P2A_ACK_SLOT0 (RPMI_P2A_ACK_BASE + 2 * RPMI_SLOT_SIZE)
> > +
> > +static uint64_t rpmi_response_base;
> > +
> > +static uint64_t rpmi_queue_slot(uint64_t queue_base, uint32_t index)
> > +{
> > +    return queue_base + (index + 2) * RPMI_SLOT_SIZE;
> > +}
> > +
> > +static void rpmi_send_request(QTestState *qts, uint16_t service_group,
> > +                              uint8_t service_id, uint8_t request_type=
,
> > +                              const uint32_t *data, size_t data_words)
> > +{
> > +    uint32_t tail =3D qtest_readl(qts, RPMI_A2P_TAIL);
> > +    uint64_t slot =3D rpmi_queue_slot(RPMI_SHMEM_BASE, tail);
> > +    size_t i;
> > +
> > +    qtest_writew(qts, slot, service_group);
> > +    qtest_writeb(qts, slot + 2, service_id);
> > +    qtest_writeb(qts, slot + 3, request_type);
> > +    qtest_writew(qts, slot + 4, data_words * sizeof(*data));
> > +    qtest_writew(qts, slot + 6, RPMI_TOKEN);
> > +
> > +    for (i =3D 0; i < data_words; i++) {
> > +        qtest_writel(qts, slot + 8 + i * sizeof(*data), data[i]);
> > +    }
> > +
> > +    g_test_message(
> > +        "RPMI_A2P_REQ shmem=3D0x%016" PRIx64 " doorbell=3D0x%016" PRIx=
64
> > +        " group=3D0x%04x service=3D0x%02x type=3D0x%02x data_len=3D%zu=
"
> > +        " token=3D0x%04x a2p_tail=3D%u slot=3D0x%016" PRIx64,
> > +        (uint64_t)RPMI_SHMEM_BASE, (uint64_t)RPMI_DOORBELL_BASE,
> > +        service_group, service_id, request_type, data_words * sizeof(*=
data),
> > +        RPMI_TOKEN, tail, slot);
> > +
> > +    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % 16);
> > +    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
> > +}
> > +
> > +static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
> > +{
> > +    return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uin=
t32_t));
> > +}
> > +
> > +static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
> > +                            uint8_t service_id, uint16_t data_len)
> > +{
> > +    uint32_t head =3D qtest_readl(qts, RPMI_P2A_ACK_HEAD);
> > +    uint32_t tail =3D qtest_readl(qts, RPMI_P2A_ACK_TAIL);
> > +
> > +    g_assert_cmphex(tail, !=3D, head);
> > +    rpmi_response_base =3D rpmi_queue_slot(RPMI_P2A_ACK_BASE, head);
> > +    g_assert_cmphex(qtest_readw(qts, rpmi_response_base), =3D=3D, serv=
ice_group);
> > +    g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 2), =3D=3D,
> > +                    service_id);
> > +    g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 3), =3D=3D,
> > +                    RPMI_MSG_ACKNOWLEDGEMENT);
> > +    g_assert_cmphex(qtest_readw(qts, rpmi_response_base + 4), =3D=3D, =
data_len);
> > +    g_assert_cmphex(qtest_readw(qts, rpmi_response_base + 6), =3D=3D,
> > +                    RPMI_TOKEN);
> > +    g_test_message(
> > +        "RPMI_P2A_ACK shmem=3D0x%016" PRIx64
> > +        " group=3D0x%04x service=3D0x%02x type=3D0x%02x data_len=3D%u"
> > +        " token=3D0x%04x p2a_head=3D%u slot=3D0x%016" PRIx64
> > +        " status=3D0x%08x",
> > +        (uint64_t)RPMI_SHMEM_BASE, service_group, service_id,
> > +        RPMI_MSG_ACKNOWLEDGEMENT, data_len, RPMI_TOKEN, head,
> > +        rpmi_response_base,
> > +        data_len >=3D sizeof(uint32_t) ? rpmi_response_word(qts, 0) : =
0);
> > +    qtest_writel(qts, RPMI_P2A_ACK_HEAD, (head + 1) % 16);
> > +}
> > +
> > +static void rpmi_send_sysreset(QTestState *qts, uint32_t reset_type,
> > +                               uint8_t request_type)
> > +{
> > +    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
> > +                      RPMI_SYSRST_SRV_SYSTEM_RESET, request_type,
> > +                      &reset_type, 1);
> > +}
> > +
> > +static void rpmi_expect_qemu_failure(const char *extra_args,
> > +                                     const char *stderr_needle)
> > +{
> > +    g_autoptr(GError) error =3D NULL;
> > +    g_auto(GStrv) split_args =3D NULL;
> > +    g_autoptr(GPtrArray) argv =3D g_ptr_array_new();
> > +    g_autofree char *stderr_data =3D NULL;
> > +    gint wait_status;
> > +    gboolean spawned;
> > +
> > +    g_assert_true(g_shell_parse_argv(extra_args, NULL, &split_args, &e=
rror));
> > +    g_assert_no_error(error);
> > +
> > +    g_ptr_array_add(argv, (gpointer)qtest_qemu_binary(NULL));
> > +    for (char **arg =3D split_args; *arg; arg++) {
> > +        g_ptr_array_add(argv, *arg);
> > +    }
> > +    g_ptr_array_add(argv, NULL);
> > +
> > +    spawned =3D g_spawn_sync(NULL, (char **)argv->pdata, NULL,
> > +                           G_SPAWN_STDOUT_TO_DEV_NULL,
> > +                           NULL, NULL, NULL, &stderr_data,
> > +                           &wait_status, &error);
> > +    g_assert_true(spawned);
> > +    g_assert_no_error(error);
> > +    g_assert_false(g_spawn_check_exit_status(wait_status, NULL));
> > +    g_assert_nonnull(stderr_data);
> > +    g_assert_nonnull(strstr(stderr_data, stderr_needle));
> > +}
> > +
> > +static void test_rpmi_machine_realize_off(void)
> > +{
> > +    QTestState *qts;
> > +
> > +    qts =3D qtest_init("-machine virt,rpmi=3Doff");
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_rpmi_machine_rejects_too_many_harts(void)
> > +{
> > +    rpmi_expect_qemu_failure(
> > +        "-machine virt,rpmi=3Don -smp 513 -display none -S",
> > +        "max CPUs supported by machine 'virt' is 512");
> > +}
> > +
> > +static void test_rpmi_base_platform_info(void)
> > +{
> > +    static const char expected[] =3D "QEMU RISC-V virt RPMI";
> > +    QTestState *qts;
> > +    size_t i;
> > +
> > +    qts =3D qtest_init("-machine virt,rpmi=3Don");
> > +    rpmi_send_request(qts, RPMI_SRVGRP_BASE,
> > +                      RPMI_BASE_SRV_GET_PLATFORM_INFO,
> > +                      RPMI_MSG_NORMAL_REQUEST, NULL, 0);
> > +
> > +    rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
> > +                    RPMI_BASE_SRV_GET_PLATFORM_INFO,
> > +                    2 * sizeof(uint32_t) + sizeof(expected));
> > +    g_assert_cmphex(rpmi_response_word(qts, 0), =3D=3D, 0);
> > +    g_assert_cmphex(rpmi_response_word(qts, 1), =3D=3D, sizeof(expecte=
d));
> > +    for (i =3D 0; i < sizeof(expected); i++) {
> > +        g_assert_cmphex(qtest_readb(qts, RPMI_P2A_ACK_SLOT0 + 16 + i),=
 =3D=3D,
> > +                        expected[i]);
> > +    }
> > +
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
> > +                             bool present)
> > +{
> > +    rpmi_send_request(qts, RPMI_SRVGRP_BASE,
> > +                      RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
> > +                      RPMI_MSG_NORMAL_REQUEST, &service_group, 1);
> > +
> > +    rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
> > +                    RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
> > +                    2 * sizeof(uint32_t));
> > +    g_assert_cmphex(rpmi_response_word(qts, 0), =3D=3D, 0);
> > +    if (present) {
> > +        g_assert_cmphex(rpmi_response_word(qts, 1), !=3D, 0);
> > +    } else {
> > +        g_assert_cmphex(rpmi_response_word(qts, 1), =3D=3D, 0);
> > +    }
> > +}
> > +
> > +static void test_rpmi_base_probe_service_groups(void)
> > +{
> > +    QTestState *qts;
> > +
> > +    qts =3D qtest_init("-machine virt,rpmi=3Don,aia=3Daplic-imsic");
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_BASE, true);
> > +    qtest_system_reset(qts);
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_RESET, true);
> > +    qtest_system_reset(qts);
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_HSM, true);
> > +    qtest_system_reset(qts);
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_SUSPEND, true);
> > +    qtest_system_reset(qts);
> >
> IMO, it is better to add these tests along with the commit which
> enabled the feature.

  Agreed. I will keep only the definitions used by the initial RPMI virt
  services in this series and remove the future CPPC/Clock/MM/Logging/Syste=
m
  MSI definitions from this qtest patch.

>
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_CPPC, false);
> > +    qtest_system_reset(qts);
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_MSI, false);
> > +    qtest_system_reset(qts);
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_CLOCK, false);
> > +    qtest_system_reset(qts);
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_MANAGEMENT_MODE, false);
> > +    qtest_system_reset(qts);
> > +    rpmi_probe_group(qts, RPMI_SRVGRP_LOGGING, false);
> > +
> >
> Please remove these unimplemented service groups from this commit.
>
  Agreed. I will remove probes for unimplemented service groups from this
  initial qtest patch. The test will only cover the service groups implemen=
ted
  by this series: Base, System Reset, HSM, and System Suspend.

Thanks,
Subbu

> Thanks,
> Sunil

