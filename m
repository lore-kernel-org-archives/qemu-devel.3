Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98493C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvvCT-0003sd-VQ; Mon, 17 Aug 2026 07:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wvvCI-0003r3-WB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:08:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wvvCG-0000Rs-6t
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 07:08:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H9dewU1533532
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=uAYwelqc9WE4DTYSHPccu1xHrR40Vuq0x7i1iv0+dFE=; b=dL
 CXuvaSppsNcH/XOwrjUUmQZguLG0jhuj9Ouz00IWkkrkS709RsjLlegfACQ2LwJO
 EmfiDuWvNYPtQldrRw5gDguPegzgywyPM5EsEFNSbcc7HAGaDMTWn1Gw4N/0B67m
 kwOwuNZ1v+yn+uErbp9TlZ2SvCALiFXzZwr6e2MlS/1m+PTkJazlP2My6hNQnxBc
 lXcx2k9VC0t46VXtr6BvczGj1MlpdLGsWPXClwma4FbEp8EnK20rfpDdEqnEzYQE
 faT4HrQjPsiepRaMCb9jzt5ViP4CmPCBDHqk/bd6YdQW3yHhnmSS4W7F2gZQuMGw
 gS/PZA333h1dl5ps0iug==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xb1gq3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:07:58 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-836ec8c3338so101736587b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786964878; cv=none;
 d=google.com; s=arc-20260327;
 b=BhT8rU7JxLaXtyBitN5uhvoSEggtplq/VQbjFfKYocNmZR77SGxU8jrPiiYdyBRxLz
 dReeDB9o3AU5HVMYGeKN+Y323yrYZ6alzabzKCPfAzxOHQ3pQ/cLQEPATcra82e5+2WM
 Eo30d2aRe5R5OgOHxGLbSfUhi+UkkO2PrXRAJEjp9YgrQ0RNcE9uL39LC/k6kyu9s8WE
 RFM7jyixjfLy36pko+7JQB1w/dEUoLxgiGB7AkC3ZsxPqVmoE+5NLYDUbrUhdoYASyBX
 RdZjbypHjoroW9idjNrRmnrHdugVo3lQbVvY2VHKxJ4Is3/eiQREmnOKZamtO4pkblJ9
 eB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=uAYwelqc9WE4DTYSHPccu1xHrR40Vuq0x7i1iv0+dFE=;
 fh=n4eXYoJv9slRuRkeiSzLossTUw9GtsS80ObD5NAf0mE=;
 b=BY0aztKQl+aGihtJVkdq+meERRh/YK+31iZzucb3OkkiUrPifS1vBAb0XH3NElmYXW
 HTlFFULz9dYTNjlpm0YOHUj2hYoY7fg43Mxqu6hz2GIm21UG0pI4d4Sksf9wkvtqXwAO
 MQt8XhiOn81d2hNBSg7hIB3N8xbY66DI3Slec7M9vtlB8J6cUWg/HNuhRGSQi3+57P4t
 ONuPbKBQxviWVXOvv5YIN0aq6sfN2NPbnCSPEjvBcPqzG8NJz/vAPh4vzTa+tCK6TTcE
 njLVx68SXnjXDTkgyMODvGxUtzL+VYQ/TW5qqIcpwjn2XF45mNwpRiwCND/sHLqM4Npz
 6UUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786964878; x=1787569678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uAYwelqc9WE4DTYSHPccu1xHrR40Vuq0x7i1iv0+dFE=;
 b=F1BhpxEEllrfI6gZ24iLc9SJIsN5PCCcYiMktapO6CONvgfrC/P36kL8HNrjhHU0Sn
 kzynquo8M8ZHwLmzLyTQj78o0m68+Fsgd+KjVpGmH0rLIPZXCsLktbRVfbU2OK4zLEAL
 X8666UBCS3NGYkebaWaUsWNI1HcTf2jSXmiFqv4umvQGDCClGcnYWVvos/65vXuoekJl
 +ER7oCGbXGTQMG8iVvJo16Lj6jx616/8+5w81n6jwq20RsguGV6KgHu3ti48v+xqXbGQ
 ldjfELdLdniXEbAHnKYSqVAEPX8c3nY2xpehyR9QIUvdgCYoaNPldqaTLrZtsH9YQuGA
 rp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964878; x=1787569678;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uAYwelqc9WE4DTYSHPccu1xHrR40Vuq0x7i1iv0+dFE=;
 b=sYWaFciN3QgGMRucBTpnpcqXeyf7LkgMnP5AHIFX2NSDlPu5jXiH6ntivz758kUL4R
 pLg3vH0DkApTxmH4sKxh59t/U/8wBINa4w4MQ1gnXhqDxxJhf/MkCNUrDJ1xVsiWug+2
 KsQJAQXWBQUp2Ff219QTRHhtb4uZi9ycYjSK4SXS2nmr6K91/kZH95KiOgiO7LA5bO7q
 9oeITGXxQy1lzuM+j99bUlSGEPObUsz0CHMb9sz8Oi98jSvUSxLpn8jo/jszumvXszwW
 xtcHUCAIEN3foKTtDdYWLuAv881zpVb7OT3p/d4LTmMTxvJ8BUPCZuufy1AEcthmwp0V
 3Z/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM8105FXYWo5yi8qeI3pBZc0N5Wzg/ExQcc5TfX/Ds5gtE5YmgV7WGQwRpXbo42dGgHbLazytb7XBB@nongnu.org
X-Gm-Message-State: AOJu0Yy28SlCSpW4SQt+/VX4KNXlGEP8/9myRyA8QOEe0ZTKOq9a0jnM
 NNyjlNjUvpECtvGwr9FTTesl7Ymf8wjvC3MbfGTXbTSvQoM0PX7RpBeFO4+UbFhm1e4PefDkbiB
 i6KFxcGLZOsEpCEMHnonFlvm8gi8mWv6Irsu9xlvjG7hROZcVZBFGwmzvcUVjIqlTk4wS+wIwyW
 +A1HOmrkFz23NA8KmIOJZYySiReu4jxpIg
X-Gm-Gg: AR+sD12tp4VQ48omT87KlJTO6dIVvkrJpJ6jiDiw3CWovzPH2S1/ncdKWu6NkNnaMmg
 dhlSOrAyLN7UfJ6yiecxdrrNWhbkR4p34JAqsr7DSKbL/gyhKzfB2DCOGDl7xd2AoONAv/VSJoh
 c+WfCENQpJyd/+ffhfAqKaHpJll1885Xr/XR4dU6ZZsrjsTANjaVT6eEFKNgc=
X-Received: by 2002:a05:690e:1914:b0:664:b1c2:88f with SMTP id
 956f58d0204a3-66c72b1bd55mr7329943d50.1.1786964877456; 
 Mon, 17 Aug 2026 04:07:57 -0700 (PDT)
X-Received: by 2002:a05:690e:1914:b0:664:b1c2:88f with SMTP id
 956f58d0204a3-66c72b1bd55mr7329882d50.1.1786964875351; Mon, 17 Aug 2026
 04:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-10-subrahmanya.lingappa@oss.qualcomm.com>
In-Reply-To: <20260814045315.3416169-10-subrahmanya.lingappa@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:37:42 +0530
X-Gm-Features: AcwNN1U640xA61aoT2IHp9Bjr9XUtxWMIprbNWx8G-Iv6MxGc6HwcxYsw6E9myc
Message-ID: <CAB19ukFGinPjP+w89tm=1+0s+fFYr7PsXED08+wa-LznVS=zhg@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] tests/qtest: cover initial RISC-V RPMI services
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Ua9hjqSN c=1 sm=1 tr=0 ts=6a82eb8e cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=Y6iMssVJfdQlGiBDL2gA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: nhHNvf46gZJ2S2s_THl0zCtNonNwy5wG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MyBTYWx0ZWRfX45Q4n0XNE5RB
 1d09fCKeER8z6IHjzwwhIAadBczJyGrvLL+OrCSvYeqh+4uq3zPRt0nlbe+wgJROZavmog1vQWU
 UsAwN3kkCDhplvMsUDd0npFoDXCewzsZK79DFkDme4HgENoEO4weExbHZth+Zu9M1u14a2C9wrM
 VWOaeZo6hAMc01UZB2j6DfPy8Gl1mWKaFyi/67NtTxRrxMwyDleLfBXuPloioy7sjNA6aHEuXyx
 kEdDJrykmK/HDcEzhFhnfZyZXI6DOSwtwWeO2pHUiv3c603t5dUZpgQ0iYx0ppN4dBdoD8gyE9f
 8yb8afQadwQtNZK7OHp/qFDhRe2YBXls1Qyco4cl1RFeaOYwtYzLMTjYU0lfaepkksypFJ4iE4f
 cwkqPJLeNeAlC3ohxKaoxWSyb7I5QvjRdRiDcT/Qi2jXOuF5bEzm/Y3MbsmXY046K094cLPFbcF
 DIAkXM/zKNUvYQZ2uTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MyBTYWx0ZWRfX5RSkLO+4/N4i
 PwOLVXzm2GpVlvsqu0qdPBuDcLYin2wYwKj/Gy61HRu0jOnge2kOgOGwiCjU7xCf7tdFAg+Xyv0
 PxQ0OCQCmMTwD498JZlYkmWTRq1NX1s=
X-Proofpoint-ORIG-GUID: nhHNvf46gZJ2S2s_THl0zCtNonNwy5wG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 14, 2026 at 10:24=E2=80=AFAM Subrahmanya Lingappa
<subrahmanya.lingappa@oss.qualcomm.com> wrote:
>
> Add qtests for the RPMI transport plus Base, system reset, HSM, and
> system suspend service groups.
>
> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.co=
m>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  MAINTAINERS                   |   1 +
>  tests/qtest/meson.build       |   2 +
>  tests/qtest/riscv-rpmi-test.c | 684 ++++++++++++++++++++++++++++++++++
>  3 files changed, 687 insertions(+)
>  create mode 100644 tests/qtest/riscv-rpmi-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e91a31757..6dd71c5a82 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -361,6 +361,7 @@ F: hw/riscv/
>  F: hw/intc/riscv*
>  F: hw/misc/riscv_rpmi*
>  F: include/hw/misc/riscv_rpmi.h
> +F: tests/qtest/riscv-rpmi-test.c
>  F: include/hw/char/riscv_htif.h
>  F: include/hw/riscv/
>  F: common-user/host/riscv*
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 4897325d84..d54b79cbcf 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -290,6 +290,8 @@ qtests_riscv32 =3D \
>
>  qtests_riscv64 =3D ['riscv-csr-test'] + \
>    (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_RISCV_RPMI') ?
> +   ['riscv-rpmi-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>     config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>     ['iommu-riscv-test'] : []) + \
> diff --git a/tests/qtest/riscv-rpmi-test.c b/tests/qtest/riscv-rpmi-test.=
c
> new file mode 100644
> index 0000000000..dab723b999
> --- /dev/null
> +++ b/tests/qtest/riscv-rpmi-test.c
> @@ -0,0 +1,684 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QTests for RISC-V RPMI devices.
> + *
> + * Copyright (c) 2026 Qualcomm Technologies, Inc.
> + * Author:
> + *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +#include "libqtest.h"
> +#include "qobject/qdict.h"
> +
> +#define RPMI_SHMEM_BASE 0x10200000ULL
> +#define RPMI_DOORBELL_BASE 0x10230000ULL
> +#define RPMI_IMSIC_S_BASE 0x28000000ULL
> +#define RPMI_CPPC_FASTCHAN_BASE 0x10240000ULL
> +#define RPMI_CPPC_FASTCHAN_SIZE 0x4000
> +#define RPMI_CPPC_FASTCHAN_FEEDBACK_OFFSET 0x2000
> +#define RPMI_SLOT_SIZE 64
> +
> +#define RPMI_A2P_HEAD RPMI_SHMEM_BASE
> +#define RPMI_A2P_TAIL (RPMI_SHMEM_BASE + RPMI_SLOT_SIZE)
> +#define RPMI_A2P_SLOT0 (RPMI_SHMEM_BASE + 2 * RPMI_SLOT_SIZE)
> +
> +#define RPMI_SRVGRP_BASE 0x0001
> +#define RPMI_SRVGRP_SYSTEM_MSI 0x0002
> +#define RPMI_SRVGRP_SYSTEM_RESET 0x0003
> +#define RPMI_SRVGRP_SYSTEM_SUSPEND 0x0004
> +#define RPMI_SRVGRP_HSM 0x0005
> +#define RPMI_SRVGRP_CPPC 0x0006
> +#define RPMI_SRVGRP_CLOCK 0x0008
> +#define RPMI_SRVGRP_MANAGEMENT_MODE 0x000b
> +#define RPMI_SRVGRP_LOGGING 0x000e
> +#define RPMI_BASE_SRV_GET_PLATFORM_INFO 0x05
> +#define RPMI_BASE_SRV_PROBE_SERVICE_GROUP 0x06
> +#define RPMI_SYSMSI_SRV_GET_ATTRIBUTES 0x02
> +#define RPMI_SYSMSI_SRV_GET_MSI_ATTRIBUTES 0x03
> +#define RPMI_SYSMSI_SRV_SET_MSI_STATE 0x04
> +#define RPMI_SYSMSI_SRV_GET_MSI_STATE 0x05
> +#define RPMI_SYSMSI_SRV_SET_MSI_TARGET 0x06
> +#define RPMI_SYSMSI_SRV_GET_MSI_TARGET 0x07
> +#define RPMI_SYSRST_SRV_GET_ATTRIBUTES 0x02
> +#define RPMI_SYSRST_SRV_SYSTEM_RESET 0x03
> +#define RPMI_HSM_SRV_GET_HART_STATUS 0x02
> +#define RPMI_HSM_SRV_GET_HART_LIST 0x03
> +#define RPMI_HSM_SRV_GET_SUSPEND_TYPES 0x04
> +#define RPMI_HSM_SRV_GET_SUSPEND_INFO 0x05
> +#define RPMI_HSM_SRV_HART_START 0x06
> +#define RPMI_HSM_SRV_HART_STOP 0x07
> +#define RPMI_HSM_SRV_HART_SUSPEND 0x08
> +#define RPMI_SYSSUSP_SRV_GET_ATTRIBUTES 0x02
> +#define RPMI_SYSSUSP_SRV_SYSTEM_SUSPEND 0x03
> +#define RPMI_CPPC_SRV_PROBE_REG 0x02
>
Please add only the required definitions. Not the future ones.

> +#define RPMI_CPPC_SRV_READ_REG 0x03
> +#define RPMI_CPPC_SRV_WRITE_REG 0x04
> +#define RPMI_CPPC_SRV_GET_FAST_CHANNEL_REGION 0x05
> +#define RPMI_CPPC_SRV_GET_FAST_CHANNEL_OFFSET 0x06
> +#define RPMI_CPPC_SRV_GET_HART_LIST 0x07
> +#define RPMI_CPPC_NOMINAL_PERF 0x01
> +#define RPMI_CPPC_DESIRED_PERF 0x05
> +#define RPMI_CPPC_COUNTER_WRAPAROUND_TIME 0x0a
> +#define RPMI_CPPC_REFERENCE_PERF_COUNTER 0x0b
> +#define RPMI_CPPC_DELIVERED_PERF_COUNTER 0x0c
> +#define RPMI_CPPC_REG_LEN_64 64
> +#define RPMI_CLK_SRV_GET_NUM_CLOCKS 0x02
> +#define RPMI_CLK_SRV_GET_ATTRIBUTES 0x03
> +#define RPMI_CLK_SRV_GET_SUPPORTED_RATES 0x04
> +#define RPMI_CLK_SRV_SET_CONFIG 0x05
> +#define RPMI_CLK_SRV_GET_CONFIG 0x06
> +#define RPMI_CLK_SRV_SET_RATE 0x07
> +#define RPMI_CLK_SRV_GET_RATE 0x08
> +#define RPMI_MM_SRV_GET_ATTRIBUTES 0x02
> +#define RPMI_MM_SRV_COMMUNICATE 0x03
> +#define RPMI_LOGGING_SRV_SET_CONFIG 0x02
> +#define RPMI_MSG_NORMAL_REQUEST 0x00
> +#define RPMI_MSG_POSTED_REQUEST 0x01
> +#define RPMI_MSG_ACKNOWLEDGEMENT 0x02
> +#define RPMI_SYSRST_TYPE_SHUTDOWN 0x00
> +#define RPMI_SYSRST_TYPE_COLD_REBOOT 0x01
> +#define RPMI_SYSRST_TYPE_INVALID 0x03
> +#define RPMI_SYSRST_ATTRS_FLAGS_RESETTYPE 1
> +#define RPMI_SYS_MSI_SHUTDOWN_INDEX 0
> +#define RPMI_SYS_MSI_REBOOT_INDEX 1
> +#define RPMI_SYS_MSI_SUSPEND_INDEX 2
> +#define RPMI_SYS_NUM_MSI 4
> +#define RPMI_SYSMSI_MSI_STATE_ENABLE 1
> +#define RPMI_SYSMSI_MSI_STATE_PENDING 2
> +#define RPMI_TOKEN 0x55aa
> +#define RPMI_ERR_NOTSUPP 0xfffffffeU
> +#define RPMI_ERR_INVALID_PARAM 0xfffffffdU
> +#define RPMI_ERR_INVALID_ADDR 0xfffffffbU
> +#define RPMI_ERR_DENIED 0xfffffffcU
> +#define RPMI_HSM_HART_STATE_STARTED 0x00
> +#define RPMI_HSM_HART_STATE_STOPPED 0x01
> +#define RPMI_HSM_HART_STATE_SUSPENDED 0x04
> +#define VIRT_RPMI_CPPC_NOMINAL_PERF 30
> +#define VIRT_RPMI_CLOCK_COUNT 6
> +#define VIRT_RPMI_MM_VERSION 0x10000
> +#define VIRT_RPMI_SHMEM_SIZE 0x20000
> +#define RPMI_MM_INPUT_OFFSET 0x3000
> +#define RPMI_MM_OUTPUT_OFFSET 0x3800
> +#define RPMI_MM_BUFFER_SIZE 0x400
> +#define RPMI_MM_INPUT_BASE (RPMI_SHMEM_BASE + RPMI_MM_INPUT_OFFSET)
> +#define RPMI_MM_OUTPUT_BASE (RPMI_SHMEM_BASE + RPMI_MM_OUTPUT_OFFSET)
> +#define MM_EFI_COMM_HEADER_SIZE 24
> +#define EFI_VAR_COMM_HEADER_SIZE 16
> +#define EFI_VAR_ACCESS_NAME_OFFSET 36
> +#define EFI_VAR_NEXT_NAME_OFFSET 24
> +#define EFI_VAR_FN_GET_VARIABLE 1
> +#define EFI_VAR_FN_GET_NEXT_VARIABLE_NAME 2
> +#define EFI_VAR_FN_SET_VARIABLE 3
> +#define EFI_SUCCESS 0ULL
> +#define EFI_INVALID_PARAMETER 0x8000000000000002ULL
> +#define EFI_BUFFER_TOO_SMALL 0x8000000000000005ULL
> +#define EFI_NOT_FOUND 0x800000000000000eULL
> +#define EFI_VARIABLE_NON_VOLATILE 0x00000001
> +#define EFI_VARIABLE_BOOTSERVICE_ACCESS 0x00000002
> +#define EFI_VARIABLE_RUNTIME_ACCESS 0x00000004
> +
> +#define RPMI_P2A_ACK_BASE (RPMI_SHMEM_BASE + 16 * RPMI_SLOT_SIZE)
> +#define RPMI_P2A_ACK_HEAD RPMI_P2A_ACK_BASE
> +#define RPMI_P2A_ACK_TAIL (RPMI_P2A_ACK_BASE + RPMI_SLOT_SIZE)
> +#define RPMI_P2A_ACK_SLOT0 (RPMI_P2A_ACK_BASE + 2 * RPMI_SLOT_SIZE)
> +
> +static uint64_t rpmi_response_base;
> +
> +static uint64_t rpmi_queue_slot(uint64_t queue_base, uint32_t index)
> +{
> +    return queue_base + (index + 2) * RPMI_SLOT_SIZE;
> +}
> +
> +static void rpmi_send_request(QTestState *qts, uint16_t service_group,
> +                              uint8_t service_id, uint8_t request_type,
> +                              const uint32_t *data, size_t data_words)
> +{
> +    uint32_t tail =3D qtest_readl(qts, RPMI_A2P_TAIL);
> +    uint64_t slot =3D rpmi_queue_slot(RPMI_SHMEM_BASE, tail);
> +    size_t i;
> +
> +    qtest_writew(qts, slot, service_group);
> +    qtest_writeb(qts, slot + 2, service_id);
> +    qtest_writeb(qts, slot + 3, request_type);
> +    qtest_writew(qts, slot + 4, data_words * sizeof(*data));
> +    qtest_writew(qts, slot + 6, RPMI_TOKEN);
> +
> +    for (i =3D 0; i < data_words; i++) {
> +        qtest_writel(qts, slot + 8 + i * sizeof(*data), data[i]);
> +    }
> +
> +    g_test_message(
> +        "RPMI_A2P_REQ shmem=3D0x%016" PRIx64 " doorbell=3D0x%016" PRIx64
> +        " group=3D0x%04x service=3D0x%02x type=3D0x%02x data_len=3D%zu"
> +        " token=3D0x%04x a2p_tail=3D%u slot=3D0x%016" PRIx64,
> +        (uint64_t)RPMI_SHMEM_BASE, (uint64_t)RPMI_DOORBELL_BASE,
> +        service_group, service_id, request_type, data_words * sizeof(*da=
ta),
> +        RPMI_TOKEN, tail, slot);
> +
> +    qtest_writel(qts, RPMI_A2P_TAIL, (tail + 1) % 16);
> +    qtest_writel(qts, RPMI_DOORBELL_BASE, 1);
> +}
> +
> +static uint32_t rpmi_response_word(QTestState *qts, unsigned int word)
> +{
> +    return qtest_readl(qts, rpmi_response_base + 8 + word * sizeof(uint3=
2_t));
> +}
> +
> +static void rpmi_expect_ack(QTestState *qts, uint16_t service_group,
> +                            uint8_t service_id, uint16_t data_len)
> +{
> +    uint32_t head =3D qtest_readl(qts, RPMI_P2A_ACK_HEAD);
> +    uint32_t tail =3D qtest_readl(qts, RPMI_P2A_ACK_TAIL);
> +
> +    g_assert_cmphex(tail, !=3D, head);
> +    rpmi_response_base =3D rpmi_queue_slot(RPMI_P2A_ACK_BASE, head);
> +    g_assert_cmphex(qtest_readw(qts, rpmi_response_base), =3D=3D, servic=
e_group);
> +    g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 2), =3D=3D,
> +                    service_id);
> +    g_assert_cmphex(qtest_readb(qts, rpmi_response_base + 3), =3D=3D,
> +                    RPMI_MSG_ACKNOWLEDGEMENT);
> +    g_assert_cmphex(qtest_readw(qts, rpmi_response_base + 4), =3D=3D, da=
ta_len);
> +    g_assert_cmphex(qtest_readw(qts, rpmi_response_base + 6), =3D=3D,
> +                    RPMI_TOKEN);
> +    g_test_message(
> +        "RPMI_P2A_ACK shmem=3D0x%016" PRIx64
> +        " group=3D0x%04x service=3D0x%02x type=3D0x%02x data_len=3D%u"
> +        " token=3D0x%04x p2a_head=3D%u slot=3D0x%016" PRIx64
> +        " status=3D0x%08x",
> +        (uint64_t)RPMI_SHMEM_BASE, service_group, service_id,
> +        RPMI_MSG_ACKNOWLEDGEMENT, data_len, RPMI_TOKEN, head,
> +        rpmi_response_base,
> +        data_len >=3D sizeof(uint32_t) ? rpmi_response_word(qts, 0) : 0)=
;
> +    qtest_writel(qts, RPMI_P2A_ACK_HEAD, (head + 1) % 16);
> +}
> +
> +static void rpmi_send_sysreset(QTestState *qts, uint32_t reset_type,
> +                               uint8_t request_type)
> +{
> +    rpmi_send_request(qts, RPMI_SRVGRP_SYSTEM_RESET,
> +                      RPMI_SYSRST_SRV_SYSTEM_RESET, request_type,
> +                      &reset_type, 1);
> +}
> +
> +static void rpmi_expect_qemu_failure(const char *extra_args,
> +                                     const char *stderr_needle)
> +{
> +    g_autoptr(GError) error =3D NULL;
> +    g_auto(GStrv) split_args =3D NULL;
> +    g_autoptr(GPtrArray) argv =3D g_ptr_array_new();
> +    g_autofree char *stderr_data =3D NULL;
> +    gint wait_status;
> +    gboolean spawned;
> +
> +    g_assert_true(g_shell_parse_argv(extra_args, NULL, &split_args, &err=
or));
> +    g_assert_no_error(error);
> +
> +    g_ptr_array_add(argv, (gpointer)qtest_qemu_binary(NULL));
> +    for (char **arg =3D split_args; *arg; arg++) {
> +        g_ptr_array_add(argv, *arg);
> +    }
> +    g_ptr_array_add(argv, NULL);
> +
> +    spawned =3D g_spawn_sync(NULL, (char **)argv->pdata, NULL,
> +                           G_SPAWN_STDOUT_TO_DEV_NULL,
> +                           NULL, NULL, NULL, &stderr_data,
> +                           &wait_status, &error);
> +    g_assert_true(spawned);
> +    g_assert_no_error(error);
> +    g_assert_false(g_spawn_check_exit_status(wait_status, NULL));
> +    g_assert_nonnull(stderr_data);
> +    g_assert_nonnull(strstr(stderr_data, stderr_needle));
> +}
> +
> +static void test_rpmi_machine_realize_off(void)
> +{
> +    QTestState *qts;
> +
> +    qts =3D qtest_init("-machine virt,rpmi=3Doff");
> +    qtest_quit(qts);
> +}
> +
> +static void test_rpmi_machine_rejects_too_many_harts(void)
> +{
> +    rpmi_expect_qemu_failure(
> +        "-machine virt,rpmi=3Don -smp 513 -display none -S",
> +        "max CPUs supported by machine 'virt' is 512");
> +}
> +
> +static void test_rpmi_base_platform_info(void)
> +{
> +    static const char expected[] =3D "QEMU RISC-V virt RPMI";
> +    QTestState *qts;
> +    size_t i;
> +
> +    qts =3D qtest_init("-machine virt,rpmi=3Don");
> +    rpmi_send_request(qts, RPMI_SRVGRP_BASE,
> +                      RPMI_BASE_SRV_GET_PLATFORM_INFO,
> +                      RPMI_MSG_NORMAL_REQUEST, NULL, 0);
> +
> +    rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
> +                    RPMI_BASE_SRV_GET_PLATFORM_INFO,
> +                    2 * sizeof(uint32_t) + sizeof(expected));
> +    g_assert_cmphex(rpmi_response_word(qts, 0), =3D=3D, 0);
> +    g_assert_cmphex(rpmi_response_word(qts, 1), =3D=3D, sizeof(expected)=
);
> +    for (i =3D 0; i < sizeof(expected); i++) {
> +        g_assert_cmphex(qtest_readb(qts, RPMI_P2A_ACK_SLOT0 + 16 + i), =
=3D=3D,
> +                        expected[i]);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void rpmi_probe_group(QTestState *qts, uint32_t service_group,
> +                             bool present)
> +{
> +    rpmi_send_request(qts, RPMI_SRVGRP_BASE,
> +                      RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
> +                      RPMI_MSG_NORMAL_REQUEST, &service_group, 1);
> +
> +    rpmi_expect_ack(qts, RPMI_SRVGRP_BASE,
> +                    RPMI_BASE_SRV_PROBE_SERVICE_GROUP,
> +                    2 * sizeof(uint32_t));
> +    g_assert_cmphex(rpmi_response_word(qts, 0), =3D=3D, 0);
> +    if (present) {
> +        g_assert_cmphex(rpmi_response_word(qts, 1), !=3D, 0);
> +    } else {
> +        g_assert_cmphex(rpmi_response_word(qts, 1), =3D=3D, 0);
> +    }
> +}
> +
> +static void test_rpmi_base_probe_service_groups(void)
> +{
> +    QTestState *qts;
> +
> +    qts =3D qtest_init("-machine virt,rpmi=3Don,aia=3Daplic-imsic");
> +    rpmi_probe_group(qts, RPMI_SRVGRP_BASE, true);
> +    qtest_system_reset(qts);
> +    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_RESET, true);
> +    qtest_system_reset(qts);
> +    rpmi_probe_group(qts, RPMI_SRVGRP_HSM, true);
> +    qtest_system_reset(qts);
> +    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_SUSPEND, true);
> +    qtest_system_reset(qts);
>
IMO, it is better to add these tests along with the commit which
enabled the feature.

> +    rpmi_probe_group(qts, RPMI_SRVGRP_CPPC, false);
> +    qtest_system_reset(qts);
> +    rpmi_probe_group(qts, RPMI_SRVGRP_SYSTEM_MSI, false);
> +    qtest_system_reset(qts);
> +    rpmi_probe_group(qts, RPMI_SRVGRP_CLOCK, false);
> +    qtest_system_reset(qts);
> +    rpmi_probe_group(qts, RPMI_SRVGRP_MANAGEMENT_MODE, false);
> +    qtest_system_reset(qts);
> +    rpmi_probe_group(qts, RPMI_SRVGRP_LOGGING, false);
> +
>
Please remove these unimplemented service groups from this commit.

Thanks,
Sunil

