Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6A110F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYdP-0002oy-Ok; Wed, 08 Apr 2026 15:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1wAYAq-00018f-D7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1wAYAn-0004nc-Ac
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638HwC6G061698
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 19:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=J0yraWY/D9vkQEYAFOL3Rt7B
 +6xkHx05sadTAR1N3CQ=; b=dkaGbfzandcyQkvl6/rRLTdNNTfUtxWtFkbXsVzJ
 nSEXs4INOV4wlDL0seBR6ZCMFlCF5gLg5yI6lglY5yeMpfxmssJwRwVoNwzZ5aMj
 Vw1rZESft5zbYMThBz2kUYazjSj5g2BXkaFqu1EhLlbrQeWOrRH4cZ+apt9UaVvI
 GvB22VVF/sBU6R7hyBq+s4qBFKdoV4FRGP/bj8HMJ8EZky4aBXpr9Yczdo49px9n
 AWU32gFmCf65BHVfwWVHjDbHzyE7iB0d0gZCQciaO69CJWdITmM4asQgMokTSO9Q
 /ayLSAkIZg+V5skrhEPraR5v7/eS/Y3YqvRJ4qIZU3PsGA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dduvv08bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 19:02:37 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-65079af1ee9so117832d50.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 12:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775674956; cv=none;
 d=google.com; s=arc-20240605;
 b=FXkvQdnUE70TntZ83aRlo/KrA7fYfWR2U5L9lmuvuYH73XFAdigg9ULBkNnO6yP459
 LBU631P6Id4AByTX1PkQZSzyHCmwGYgjAw6zUFT87xRXe04AY83ZJ1uZbjKEQ3QPkRw2
 dup4jhdHv/4t43df6ncpnSYzMR4q+So01ZrMZs8tG1GuSK1IDTaseOHR6iZfzevOGDDf
 XH0uJI1BA/kRHoIhG3XwF02vNBjNv4olBMt1XuCRsPYjnJTlfU78waaNOEq1RelqeBLd
 fDSiHmh3lI9XSWOlRA4Pku2xLK21skXOoc3XHIO85F0+bW8ax5urcuUCpcWqT8X/O28n
 CLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J0yraWY/D9vkQEYAFOL3Rt7B+6xkHx05sadTAR1N3CQ=;
 fh=hrlMg29Dqn6pZO5ltCwNC0ASvPhL/YIcIIfblWuU/Ss=;
 b=SinuBNCVfMz/i3FRKDrwuyGo3Xfq3/JsnljtSFKA7+HbDwa79EDpTLzSxE51BMQRvN
 3Y9RA1XofV6gp92RbV9rYW0zlQGDAVRNRgq8LeJqiOVb5dJ4aiUuB9kusIk4OCaAMc/7
 5iya5sqPqH2AV4dgiPahtnsnlBh6Eo7xsuJDcBk16/QqQArMBDHfrJ4iWjrXOaR3Dp2I
 9NDbRb0C5YRzfpC9eZP8cES35/ZgrnmU1al61HZSRbP8GQdGWmnCCGNi4Ju7EKTPEx4t
 m9z4rskJA6A8VQIdx1PfqyTVVm0Ab4s5XW4kLbAlqk9Ubp6Zjl40xiFdmAF1OdncR8Z4
 RpCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775674956; x=1776279756; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J0yraWY/D9vkQEYAFOL3Rt7B+6xkHx05sadTAR1N3CQ=;
 b=MGq+ROJXeJt58m7zhBti4RJKS2af2rhoDr5ulVh1OJftbqW+mhgTJEwOImMNQVG5Cj
 j0VHF0sG7MRHjpyz4C6ftW366btVCNqMqosQHgIQbZdOlRRHjiXy/yKRnStG1prt2SWA
 huUEEg3Pg9dYENTk4hA3d7fV1KrQz5Cw6uCLFHgGT7STjvrn0PSiiIIgBCVjOgal4zF2
 UDz/67ZpahgqlcIsFkY/U404sILfXYvIcblzsb19OtOOeGtWD6IoEYlWSDvoDxu2gHP8
 +n+3mb1Q+bCHsshE6as6xsq5XKkjRTs4zMIW9LTMFH1ZA0q0e0Ep0akaX99FXf7T1oru
 wSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775674956; x=1776279756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0yraWY/D9vkQEYAFOL3Rt7B+6xkHx05sadTAR1N3CQ=;
 b=sXJrw/2hEdVIvvq3+SLBgeYGQlTyBPsb8q/2TBFZO9+IMlFOJu9WjQrMKdzZIpRdce
 e+XvBMl/zLS3UyllTAqFk02iQXFoAo63E+dLIsQaTS9bxtfi+jZaLBAb8rH8DFiIazKb
 8+DT7wAsuqGLdpRPGIckwcU0CRxcPPNC57Aw96/SKiiLD0Z8LsnI9+E38MCN18AuYQ89
 PhJhaHQa85o7LrMWvad4IBHgGuRcr1OjLDhPuDqZ6RtZq/lQDHVDOSXYD4/KmvCIjgeN
 axixkQ3u5NY7kE5wS0ZRyFME0MnQjbYeEOluXW8AKfUxkDfVVZdhp6ZpW3/fmwB2rEZE
 AYug==
X-Gm-Message-State: AOJu0YziqIGP15oFHniyZpO+nHOWgYr8lgKStUkv2gPtgq1jF2feICMm
 HkYeJRb+9r2Axa/YQFxxUqNeh+WkoDshtybAL+WyIbsiYpZRm8OBv8JEcza791aKOqb8t4tEFpA
 e03EHl93NCAY1c8NHZEQVNj9/3jMigU9c1SgLPI85JgjNolpli8ehshB/H3ULuKfJad/Sepo9xY
 PibaIk97DQS9wYtbMWnd1I8fDmPxZIQW5/
X-Gm-Gg: AeBDiesP/buSPYRHVv98/j1xLL2ezd8DjI+9dla4MjZmAsnnRTd+XOdVw21gPwHA0xH
 tVCYwU1w9eF0vZo64gzm8+HlFCzK0/kpnX6OU1B+ffQQu63rW0ESAoTLJ5pYsF5rcqNBf+hekP4
 itg34nuzOqgtiGL/A5oFbfoe0vZHVb6TotklVlUWaqY5HLoEMkyvIP6LB5q7WZQKDgqfJ5vyi9T
 yhx55Y=
X-Received: by 2002:a53:c709:0:b0:64d:5638:f068 with SMTP id
 956f58d0204a3-650488888f0mr15043682d50.58.1775674956332; 
 Wed, 08 Apr 2026 12:02:36 -0700 (PDT)
X-Received: by 2002:a53:c709:0:b0:64d:5638:f068 with SMTP id
 956f58d0204a3-650488888f0mr15043628d50.58.1775674955834; Wed, 08 Apr 2026
 12:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
 <20260408042149.1902796-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260408042149.1902796-2-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 14:02:24 -0500
X-Gm-Features: AQROBzBE6Dc-zbE5XQpXTZilpkNWIZ98TnS6YJj4Q_txbMBQ19iKcGA5_OCIMjQ
Message-ID: <CAJpW4SV7gC_0i5VLzDdFJDWcjF0rYR1-0bD1X7oL3vAVJ1yXVA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] hw/hexagon: Add globalreg model
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000fad185064ef78adc"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE3NyBTYWx0ZWRfX16MWzSLeN6ca
 emftJUDoGjaYfkj7MWajQHbmoKgTNv5bw5rFA9rXEnoDFSlOkePOA2SfHbHVu4flYIJMEdpr5Pp
 M1F/MGIyx+ktbA4MX8pMzAqbWV8tLEPs3ud2O/uxIZ/DhPcmyi/zsIgypTC7Ws8+nkFXi5qTfiP
 G60smUpgc8gWtLL3r/6VNZGEc8CT+pP8G37kAf3lz7haEoPXRVfjinxDVBHrPUM91jX4x8/eZX5
 tEALyJZS+fn8uDqcWN+wsm63jfJVZPcSffgYbVsiGeNZtALMeg4ojXUeL18N7kETG64g0lQdjC+
 P8A/kbWWWvhVOkZVd05bRk4J1RDTl/CmTYSvSknfFNPQfJ9dT3QXc6OdnCceUtBKm62MyrFNww7
 qMGAX3YkSd//lrDhGME9lajn8ciEyBj+DbghHQDDYhbdY0KioK3/t+IPH0aYBSAr/SxbzEbgELH
 p/IGDDWx0T6rdH8UaQA==
X-Authority-Analysis: v=2.4 cv=DrxmPm/+ c=1 sm=1 tr=0 ts=69d6a64d cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=le11EiixPpdv-oWBPhwA:9 a=QEXdDO2ut3YA:10
 a=ego90-qjEEHtmwbnlnoA:9 a=BvluhdU0U9l3ixQJ:21 a=lqcHg5cX4UMA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-ORIG-GUID: 8iDYZFPp0dT3QjZptJTDlAV-EO8fL3Bu
X-Proofpoint-GUID: 8iDYZFPp0dT3QjZptJTDlAV-EO8fL3Bu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080177
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sid.manning@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Apr 2026 15:32:16 -0400
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

--000000000000fad185064ef78adc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 11:21=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> Some of the system registers are shared among all threads
> in the core.  This object contains the representation and
> interface to the system registers.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon_globalreg.h |  56 ++++++
>  hw/hexagon/hexagon_globalreg.c         | 245 +++++++++++++++++++++++++
>  2 files changed, 301 insertions(+)
>  create mode 100644 include/hw/hexagon/hexagon_globalreg.h
>  create mode 100644 hw/hexagon/hexagon_globalreg.c
>
> diff --git a/include/hw/hexagon/hexagon_globalreg.h
> b/include/hw/hexagon/hexagon_globalreg.h
> new file mode 100644
> index 00000000000..c9e72f30b0a
> --- /dev/null
> +++ b/include/hw/hexagon/hexagon_globalreg.h
> @@ -0,0 +1,56 @@
> +/*
> + * Hexagon Global Registers QOM Object
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_GLOBALREG_H
> +#define HEXAGON_GLOBALREG_H
> +
> +#include "hw/core/qdev.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "target/hexagon/cpu.h"
> +
> +#define TYPE_HEXAGON_GLOBALREG "hexagon-globalreg"
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalRegState, HEXAGON_GLOBALREG)
> +
> +struct HexagonGlobalRegState {
> +    SysBusDevice parent_obj;
> +
> +    /* Array of system registers */
> +    uint32_t regs[NUM_SREGS];
> +
> +    /* Global performance cycle counter base */
> +    uint64_t g_pcycle_base;
> +
> +    /* Properties for global register reset values */
> +    uint32_t boot_evb;           /* Boot Exception Vector Base
> (HEX_SREG_EVB) */
> +    uint64_t config_table_addr;  /* Configuration table base */
> +    uint32_t dsp_rev;           /* DSP revision register (HEX_SREG_REV) =
*/
> +
> +    /* ISDB properties */
> +    bool isdben_etm_enable;     /* ISDB ETM enable bit */
> +    bool isdben_dfd_enable;     /* ISDB DFD enable bit */
> +    bool isdben_trusted;        /* ISDB trusted mode bit */
> +    bool isdben_secure;         /* ISDB secure mode bit */
> +};
> +
> +/* Public interface functions */
> +uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,
> +                                uint32_t htid);
> +void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,
> +                             uint32_t value, uint32_t htid);
> +uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s,
> uint32_t reg,
> +                                        uint32_t value);
> +void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t
> reg,
> +                                    uint32_t value);
> +void hexagon_globalreg_reset(HexagonGlobalRegState *s);
> +
> +/* Global performance cycle counter access */
> +uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s);
> +void hexagon_globalreg_set_pcycle_base(HexagonGlobalRegState *s,
> +                                       uint64_t value);
> +
> +#endif /* HEXAGON_GLOBALREG_H */
> diff --git a/hw/hexagon/hexagon_globalreg.c
> b/hw/hexagon/hexagon_globalreg.c
> new file mode 100644
> index 00000000000..634d3b169fd
> --- /dev/null
> +++ b/hw/hexagon/hexagon_globalreg.c
> @@ -0,0 +1,245 @@
> +/*
> + * Hexagon Global Registers
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/hexagon/hexagon.h"
> +#include "hw/hexagon/hexagon_globalreg.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/resettable.h"
> +#include "migration/vmstate.h"
> +#include "qom/object.h"
> +#include "target/hexagon/cpu.h"
> +#include "target/hexagon/hex_regs.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +
> +#define IMMUTABLE (~0)
> +#define INVALID_REG_VAL 0xdeadbeef
> +
> +/* Global system register mutability masks */
> +static const uint32_t global_sreg_immut_masks[NUM_SREGS] =3D {
> +    [HEX_SREG_EVB] =3D 0x000000ff,
> +    [HEX_SREG_MODECTL] =3D IMMUTABLE,
> +    [HEX_SREG_SYSCFG] =3D 0x80001c00,
> +    [HEX_SREG_IPENDAD] =3D IMMUTABLE,
> +    [HEX_SREG_VID] =3D 0xfc00fc00,
> +    [HEX_SREG_VID1] =3D 0xfc00fc00,
> +    [HEX_SREG_BESTWAIT] =3D 0xfffffe00,
> +    [HEX_SREG_IAHL] =3D 0x00000000,
> +    [HEX_SREG_SCHEDCFG] =3D 0xfffffee0,
> +    [HEX_SREG_CFGBASE] =3D IMMUTABLE,
> +    [HEX_SREG_DIAG] =3D 0x00000000,
> +    [HEX_SREG_REV] =3D IMMUTABLE,
> +    [HEX_SREG_ISDBST] =3D IMMUTABLE,
> +    [HEX_SREG_ISDBCFG0] =3D 0xe0000000,
> +    [HEX_SREG_BRKPTPC0] =3D 0x00000003,
> +    [HEX_SREG_BRKPTCFG0] =3D 0xfc007000,
> +    [HEX_SREG_BRKPTPC1] =3D 0x00000003,
> +    [HEX_SREG_BRKPTCFG1] =3D 0xfc007000,
> +    [HEX_SREG_ISDBMBXIN] =3D IMMUTABLE,
> +    [HEX_SREG_ISDBMBXOUT] =3D 0x00000000,
> +    [HEX_SREG_ISDBEN] =3D 0xfffffffe,
> +    [HEX_SREG_TIMERLO] =3D IMMUTABLE,
> +    [HEX_SREG_TIMERHI] =3D IMMUTABLE,
> +};
> +
> +static void hexagon_globalreg_init(Object *obj)
> +{
> +    HexagonGlobalRegState *s =3D HEXAGON_GLOBALREG(obj);
> +
> +    memset(s->regs, 0, sizeof(uint32_t) * NUM_SREGS);
> +}
> +
> +static inline uint32_t apply_write_mask(uint32_t new_val, uint32_t
> cur_val,
> +                                        uint32_t reg_mask)
> +{
> +    if (reg_mask) {
> +        return (new_val & ~reg_mask) | (cur_val & reg_mask);
> +    }
> +    return new_val;
> +}
> +
> +uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,
> +                                uint32_t htid)
> +{
> +    uint32_t value;
> +
> +    g_assert(reg < NUM_SREGS);
> +    g_assert(reg >=3D HEX_SREG_GLB_START);
> +    g_assert(s);
> +
> +    value =3D s->regs[reg];
> +
> +    return value;
> +}
> +
> +void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,
> +                             uint32_t value, uint32_t htid)
> +{
> +    g_assert(s);
> +    g_assert(reg < NUM_SREGS);
> +    g_assert(reg >=3D HEX_SREG_GLB_START);
> +    s->regs[reg] =3D value;
> +}
> +
> +uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s,
> uint32_t reg,
> +                                        uint32_t value)
> +{
> +    uint32_t reg_mask;
> +
> +    g_assert(s);
> +    g_assert(reg < NUM_SREGS);
> +    g_assert(reg >=3D HEX_SREG_GLB_START);
> +    reg_mask =3D global_sreg_immut_masks[reg];
> +    return reg_mask =3D=3D IMMUTABLE ?
> +            s->regs[reg] :
> +            apply_write_mask(value, s->regs[reg], reg_mask);
> +}
> +
> +void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t
> reg,
> +                                    uint32_t value)
> +{
> +    g_assert(s);
> +    s->regs[reg] =3D hexagon_globalreg_masked_value(s, reg, value);
> +}
> +
> +uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s)
> +{
> +    g_assert(s);
> +    return s->g_pcycle_base;
> +}
> +
> +void hexagon_globalreg_set_pcycle_base(HexagonGlobalRegState *s,
> +                                       uint64_t value)
> +{
> +    g_assert(s);
> +    s->g_pcycle_base =3D value;
> +}
> +
> +static void do_hexagon_globalreg_reset(HexagonGlobalRegState *s)
> +{
> +    uint32_t isdben_val =3D 0;
> +
> +    g_assert(s);
> +    memset(s->regs, 0, sizeof(uint32_t) * NUM_SREGS);
> +
> +    s->g_pcycle_base =3D 0;
> +
> +    s->regs[HEX_SREG_EVB] =3D s->boot_evb;
> +    s->regs[HEX_SREG_CFGBASE] =3D
> HEXAGON_CFG_ADDR_BASE(s->config_table_addr);
> +    s->regs[HEX_SREG_REV] =3D s->dsp_rev;
> +
> +    if (s->isdben_etm_enable) {
> +        isdben_val |=3D (1 << 0);  /* ETM enable bit */
> +    }
> +    if (s->isdben_dfd_enable) {
> +        isdben_val |=3D (1 << 1);  /* DFD enable bit */
> +    }
> +    if (s->isdben_trusted) {
> +        isdben_val |=3D (1 << 2);  /* Trusted bit */
> +    }
> +    if (s->isdben_secure) {
> +        isdben_val |=3D (1 << 3);  /* Secure bit */
> +    }
> +    s->regs[HEX_SREG_ISDBEN] =3D isdben_val;
> +    s->regs[HEX_SREG_MODECTL] =3D 0x1;
> +
> +    /*
> +     * These register indices are placeholders in these arrays
> +     * and their actual values are synthesized from state elsewhere.
> +     * We can initialize these with invalid values so that if we
> +     * mistakenly generate reads, they will look obviously wrong.
> +     */
> +    s->regs[HEX_SREG_PCYCLELO] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PCYCLEHI] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_TIMERLO] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_TIMERHI] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT0] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT1] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT2] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT3] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT4] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT5] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT6] =3D INVALID_REG_VAL;
> +    s->regs[HEX_SREG_PMUCNT7] =3D INVALID_REG_VAL;
> +}
> +
> +static void hexagon_globalreg_realize(DeviceState *dev, Error **errp)
> +{
> +}
>
This could be removed and the reference to it below in dc->realize.
Otherwise LGTM.
Reviewed by: sid.manning@oss.qualcomm.com

> +
> +void hexagon_globalreg_reset(HexagonGlobalRegState *s)
> +{
> +    do_hexagon_globalreg_reset(s);
> +}
> +
> +static void hexagon_globalreg_reset_hold(Object *obj, ResetType type)
> +{
> +    HexagonGlobalRegState *s =3D HEXAGON_GLOBALREG(obj);
> +    do_hexagon_globalreg_reset(s);
> +}
> +
> +static const VMStateDescription vmstate_hexagon_globalreg =3D {
> +    .name =3D "hexagon_globalreg",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]){
> +        VMSTATE_UINT32_ARRAY(regs, HexagonGlobalRegState, NUM_SREGS),
> +        VMSTATE_UINT64(g_pcycle_base, HexagonGlobalRegState),
> +        VMSTATE_UINT32(boot_evb, HexagonGlobalRegState),
> +        VMSTATE_UINT64(config_table_addr, HexagonGlobalRegState),
> +        VMSTATE_UINT32(dsp_rev, HexagonGlobalRegState),
> +        VMSTATE_BOOL(isdben_etm_enable, HexagonGlobalRegState),
> +        VMSTATE_BOOL(isdben_dfd_enable, HexagonGlobalRegState),
> +        VMSTATE_BOOL(isdben_trusted, HexagonGlobalRegState),
> +        VMSTATE_BOOL(isdben_secure, HexagonGlobalRegState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const Property hexagon_globalreg_properties[] =3D {
> +    DEFINE_PROP_UINT32("boot-evb", HexagonGlobalRegState, boot_evb, 0x0)=
,
> +    DEFINE_PROP_UINT64("config-table-addr", HexagonGlobalRegState,
> +                       config_table_addr, 0xffffffffULL),
> +    DEFINE_PROP_UINT32("dsp-rev", HexagonGlobalRegState, dsp_rev, 0),
> +    DEFINE_PROP_BOOL("isdben-etm-enable", HexagonGlobalRegState,
> +                     isdben_etm_enable, false),
> +    DEFINE_PROP_BOOL("isdben-dfd-enable", HexagonGlobalRegState,
> +                     isdben_dfd_enable, false),
> +    DEFINE_PROP_BOOL("isdben-trusted", HexagonGlobalRegState,
> +                     isdben_trusted, false),
> +    DEFINE_PROP_BOOL("isdben-secure", HexagonGlobalRegState,
> +                     isdben_secure, false),
> +};
> +
> +static void hexagon_globalreg_class_init(ObjectClass *klass, const void
> *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    dc->realize =3D hexagon_globalreg_realize;
> +    rc->phases.hold =3D hexagon_globalreg_reset_hold;
> +    dc->vmsd =3D &vmstate_hexagon_globalreg;
> +    dc->user_creatable =3D false;
> +    device_class_set_props(dc, hexagon_globalreg_properties);
> +}
> +
> +static const TypeInfo hexagon_globalreg_info =3D {
> +    .name =3D TYPE_HEXAGON_GLOBALREG,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(HexagonGlobalRegState),
> +    .instance_init =3D hexagon_globalreg_init,
> +    .class_init =3D hexagon_globalreg_class_init,
> +};
> +
> +static void hexagon_globalreg_register_types(void)
> +{
> +    type_register_static(&hexagon_globalreg_info);
> +}
> +
> +type_init(hexagon_globalreg_register_types)
> --
> 2.34.1
>
>

--000000000000fad185064ef78adc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 7, =
2026 at 11:21=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Some of the system registers are sha=
red among all threads<br>
in the core.=C2=A0 This object contains the representation and<br>
interface to the system registers.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0include/hw/hexagon/hexagon_globalreg.h |=C2=A0 56 ++++++<br>
=C2=A0hw/hexagon/hexagon_globalreg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 245=
 +++++++++++++++++++++++++<br>
=C2=A02 files changed, 301 insertions(+)<br>
=C2=A0create mode 100644 include/hw/hexagon/hexagon_globalreg.h<br>
=C2=A0create mode 100644 hw/hexagon/hexagon_globalreg.c<br>
<br>
diff --git a/include/hw/hexagon/hexagon_globalreg.h b/include/hw/hexagon/he=
xagon_globalreg.h<br>
new file mode 100644<br>
index 00000000000..c9e72f30b0a<br>
--- /dev/null<br>
+++ b/include/hw/hexagon/hexagon_globalreg.h<br>
@@ -0,0 +1,56 @@<br>
+/*<br>
+ * Hexagon Global Registers QOM Object<br>
+ *<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HEXAGON_GLOBALREG_H<br>
+#define HEXAGON_GLOBALREG_H<br>
+<br>
+#include &quot;hw/core/qdev.h&quot;<br>
+#include &quot;hw/core/sysbus.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;target/hexagon/cpu.h&quot;<br>
+<br>
+#define TYPE_HEXAGON_GLOBALREG &quot;hexagon-globalreg&quot;<br>
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalRegState, HEXAGON_GLOBALREG)<br>
+<br>
+struct HexagonGlobalRegState {<br>
+=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 /* Array of system registers */<br>
+=C2=A0 =C2=A0 uint32_t regs[NUM_SREGS];<br>
+<br>
+=C2=A0 =C2=A0 /* Global performance cycle counter base */<br>
+=C2=A0 =C2=A0 uint64_t g_pcycle_base;<br>
+<br>
+=C2=A0 =C2=A0 /* Properties for global register reset values */<br>
+=C2=A0 =C2=A0 uint32_t boot_evb;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* Boot Exception Vector Base (HEX_SREG_EVB) */<br>
+=C2=A0 =C2=A0 uint64_t config_table_addr;=C2=A0 /* Configuration table bas=
e */<br>
+=C2=A0 =C2=A0 uint32_t dsp_rev;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 DSP revision register (HEX_SREG_REV) */<br>
+<br>
+=C2=A0 =C2=A0 /* ISDB properties */<br>
+=C2=A0 =C2=A0 bool isdben_etm_enable;=C2=A0 =C2=A0 =C2=A0/* ISDB ETM enabl=
e bit */<br>
+=C2=A0 =C2=A0 bool isdben_dfd_enable;=C2=A0 =C2=A0 =C2=A0/* ISDB DFD enabl=
e bit */<br>
+=C2=A0 =C2=A0 bool isdben_trusted;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ISDB trus=
ted mode bit */<br>
+=C2=A0 =C2=A0 bool isdben_secure;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ISDB=
 secure mode bit */<br>
+};<br>
+<br>
+/* Public interface functions */<br>
+uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t htid);<br>
+void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t value, uint32_t htid);<br>
+uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s, uint32_t=
 reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 value);<br>
+void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t reg=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t value);<br>
+void hexagon_globalreg_reset(HexagonGlobalRegState *s);<br>
+<br>
+/* Global performance cycle counter access */<br>
+uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s);<br>
+void hexagon_globalreg_set_pcycle_base(HexagonGlobalRegState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t =
value);<br>
+<br>
+#endif /* HEXAGON_GLOBALREG_H */<br>
diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.=
c<br>
new file mode 100644<br>
index 00000000000..634d3b169fd<br>
--- /dev/null<br>
+++ b/hw/hexagon/hexagon_globalreg.c<br>
@@ -0,0 +1,245 @@<br>
+/*<br>
+ * Hexagon Global Registers<br>
+ *<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/hexagon/hexagon.h&quot;<br>
+#include &quot;hw/hexagon/hexagon_globalreg.h&quot;<br>
+#include &quot;hw/core/qdev-properties.h&quot;<br>
+#include &quot;hw/core/sysbus.h&quot;<br>
+#include &quot;hw/core/resettable.h&quot;<br>
+#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;target/hexagon/cpu.h&quot;<br>
+#include &quot;target/hexagon/hex_regs.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+<br>
+#define IMMUTABLE (~0)<br>
+#define INVALID_REG_VAL 0xdeadbeef<br>
+<br>
+/* Global system register mutability masks */<br>
+static const uint32_t global_sreg_immut_masks[NUM_SREGS] =3D {<br>
+=C2=A0 =C2=A0 [HEX_SREG_EVB] =3D 0x000000ff,<br>
+=C2=A0 =C2=A0 [HEX_SREG_MODECTL] =3D IMMUTABLE,<br>
+=C2=A0 =C2=A0 [HEX_SREG_SYSCFG] =3D 0x80001c00,<br>
+=C2=A0 =C2=A0 [HEX_SREG_IPENDAD] =3D IMMUTABLE,<br>
+=C2=A0 =C2=A0 [HEX_SREG_VID] =3D 0xfc00fc00,<br>
+=C2=A0 =C2=A0 [HEX_SREG_VID1] =3D 0xfc00fc00,<br>
+=C2=A0 =C2=A0 [HEX_SREG_BESTWAIT] =3D 0xfffffe00,<br>
+=C2=A0 =C2=A0 [HEX_SREG_IAHL] =3D 0x00000000,<br>
+=C2=A0 =C2=A0 [HEX_SREG_SCHEDCFG] =3D 0xfffffee0,<br>
+=C2=A0 =C2=A0 [HEX_SREG_CFGBASE] =3D IMMUTABLE,<br>
+=C2=A0 =C2=A0 [HEX_SREG_DIAG] =3D 0x00000000,<br>
+=C2=A0 =C2=A0 [HEX_SREG_REV] =3D IMMUTABLE,<br>
+=C2=A0 =C2=A0 [HEX_SREG_ISDBST] =3D IMMUTABLE,<br>
+=C2=A0 =C2=A0 [HEX_SREG_ISDBCFG0] =3D 0xe0000000,<br>
+=C2=A0 =C2=A0 [HEX_SREG_BRKPTPC0] =3D 0x00000003,<br>
+=C2=A0 =C2=A0 [HEX_SREG_BRKPTCFG0] =3D 0xfc007000,<br>
+=C2=A0 =C2=A0 [HEX_SREG_BRKPTPC1] =3D 0x00000003,<br>
+=C2=A0 =C2=A0 [HEX_SREG_BRKPTCFG1] =3D 0xfc007000,<br>
+=C2=A0 =C2=A0 [HEX_SREG_ISDBMBXIN] =3D IMMUTABLE,<br>
+=C2=A0 =C2=A0 [HEX_SREG_ISDBMBXOUT] =3D 0x00000000,<br>
+=C2=A0 =C2=A0 [HEX_SREG_ISDBEN] =3D 0xfffffffe,<br>
+=C2=A0 =C2=A0 [HEX_SREG_TIMERLO] =3D IMMUTABLE,<br>
+=C2=A0 =C2=A0 [HEX_SREG_TIMERHI] =3D IMMUTABLE,<br>
+};<br>
+<br>
+static void hexagon_globalreg_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 HexagonGlobalRegState *s =3D HEXAGON_GLOBALREG(obj);<br>
+<br>
+=C2=A0 =C2=A0 memset(s-&gt;regs, 0, sizeof(uint32_t) * NUM_SREGS);<br>
+}<br>
+<br>
+static inline uint32_t apply_write_mask(uint32_t new_val, uint32_t cur_val=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 reg_mask)<br>
+{<br>
+=C2=A0 =C2=A0 if (reg_mask) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (new_val &amp; ~reg_mask) | (cur_val &a=
mp; reg_mask);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return new_val;<br>
+}<br>
+<br>
+uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t htid)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t value;<br>
+<br>
+=C2=A0 =C2=A0 g_assert(reg &lt; NUM_SREGS);<br>
+=C2=A0 =C2=A0 g_assert(reg &gt;=3D HEX_SREG_GLB_START);<br>
+=C2=A0 =C2=A0 g_assert(s);<br>
+<br>
+=C2=A0 =C2=A0 value =3D s-&gt;regs[reg];<br>
+<br>
+=C2=A0 =C2=A0 return value;<br>
+}<br>
+<br>
+void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t value, uint32_t htid)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(s);<br>
+=C2=A0 =C2=A0 g_assert(reg &lt; NUM_SREGS);<br>
+=C2=A0 =C2=A0 g_assert(reg &gt;=3D HEX_SREG_GLB_START);<br>
+=C2=A0 =C2=A0 s-&gt;regs[reg] =3D value;<br>
+}<br>
+<br>
+uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s, uint32_t=
 reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t=
 value)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t reg_mask;<br>
+<br>
+=C2=A0 =C2=A0 g_assert(s);<br>
+=C2=A0 =C2=A0 g_assert(reg &lt; NUM_SREGS);<br>
+=C2=A0 =C2=A0 g_assert(reg &gt;=3D HEX_SREG_GLB_START);<br>
+=C2=A0 =C2=A0 reg_mask =3D global_sreg_immut_masks[reg];<br>
+=C2=A0 =C2=A0 return reg_mask =3D=3D IMMUTABLE ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[reg] :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apply_write_mask(value, s-&gt;re=
gs[reg], reg_mask);<br>
+}<br>
+<br>
+void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t reg=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t value)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(s);<br>
+=C2=A0 =C2=A0 s-&gt;regs[reg] =3D hexagon_globalreg_masked_value(s, reg, v=
alue);<br>
+}<br>
+<br>
+uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(s);<br>
+=C2=A0 =C2=A0 return s-&gt;g_pcycle_base;<br>
+}<br>
+<br>
+void hexagon_globalreg_set_pcycle_base(HexagonGlobalRegState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t =
value)<br>
+{<br>
+=C2=A0 =C2=A0 g_assert(s);<br>
+=C2=A0 =C2=A0 s-&gt;g_pcycle_base =3D value;<br>
+}<br>
+<br>
+static void do_hexagon_globalreg_reset(HexagonGlobalRegState *s)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t isdben_val =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 g_assert(s);<br>
+=C2=A0 =C2=A0 memset(s-&gt;regs, 0, sizeof(uint32_t) * NUM_SREGS);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;g_pcycle_base =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_EVB] =3D s-&gt;boot_evb;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_CFGBASE] =3D HEXAGON_CFG_ADDR_BASE(s-&gt=
;config_table_addr);<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_REV] =3D s-&gt;dsp_rev;<br>
+<br>
+=C2=A0 =C2=A0 if (s-&gt;isdben_etm_enable) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 isdben_val |=3D (1 &lt;&lt; 0);=C2=A0 /* ETM e=
nable bit */<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (s-&gt;isdben_dfd_enable) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 isdben_val |=3D (1 &lt;&lt; 1);=C2=A0 /* DFD e=
nable bit */<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (s-&gt;isdben_trusted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 isdben_val |=3D (1 &lt;&lt; 2);=C2=A0 /* Trust=
ed bit */<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (s-&gt;isdben_secure) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 isdben_val |=3D (1 &lt;&lt; 3);=C2=A0 /* Secur=
e bit */<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_ISDBEN] =3D isdben_val;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_MODECTL] =3D 0x1;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* These register indices are placeholders in these arr=
ays<br>
+=C2=A0 =C2=A0 =C2=A0* and their actual values are synthesized from state e=
lsewhere.<br>
+=C2=A0 =C2=A0 =C2=A0* We can initialize these with invalid values so that =
if we<br>
+=C2=A0 =C2=A0 =C2=A0* mistakenly generate reads, they will look obviously =
wrong.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PCYCLELO] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PCYCLEHI] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_TIMERLO] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_TIMERHI] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT0] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT1] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT2] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT3] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT4] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT5] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT6] =3D INVALID_REG_VAL;<br>
+=C2=A0 =C2=A0 s-&gt;regs[HEX_SREG_PMUCNT7] =3D INVALID_REG_VAL;<br>
+}<br>
+<br>
+static void hexagon_globalreg_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+}<br></blockquote><div><span style=3D"font-size:11pt">This could be remove=
d and the reference to it below in dc-&gt;realize.=C2=A0 Otherwise LGTM.</s=
pan></div><div>Reviewed by: <a href=3D"mailto:sid.manning@oss.qualcomm.com"=
>sid.manning@oss.qualcomm.com</a>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+<br>
+void hexagon_globalreg_reset(HexagonGlobalRegState *s)<br>
+{<br>
+=C2=A0 =C2=A0 do_hexagon_globalreg_reset(s);<br>
+}<br>
+<br>
+static void hexagon_globalreg_reset_hold(Object *obj, ResetType type)<br>
+{<br>
+=C2=A0 =C2=A0 HexagonGlobalRegState *s =3D HEXAGON_GLOBALREG(obj);<br>
+=C2=A0 =C2=A0 do_hexagon_globalreg_reset(s);<br>
+}<br>
+<br>
+static const VMStateDescription vmstate_hexagon_globalreg =3D {<br>
+=C2=A0 =C2=A0 .name =3D &quot;hexagon_globalreg&quot;,<br>
+=C2=A0 =C2=A0 .version_id =3D 1,<br>
+=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
+=C2=A0 =C2=A0 .fields =3D (const VMStateField[]){<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, HexagonGlobalRegSta=
te, NUM_SREGS),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(g_pcycle_base, HexagonGlobalReg=
State),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(boot_evb, HexagonGlobalRegState=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(config_table_addr, HexagonGloba=
lRegState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(dsp_rev, HexagonGlobalRegState)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(isdben_etm_enable, HexagonGlobalR=
egState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(isdben_dfd_enable, HexagonGlobalR=
egState),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(isdben_trusted, HexagonGlobalRegS=
tate),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(isdben_secure, HexagonGlobalRegSt=
ate),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
+=C2=A0 =C2=A0 }<br>
+};<br>
+<br>
+static const Property hexagon_globalreg_properties[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;boot-evb&quot;, HexagonGlobalRegSta=
te, boot_evb, 0x0),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT64(&quot;config-table-addr&quot;, HexagonGlo=
balRegState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0config_table_addr, 0xffffffffULL),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;dsp-rev&quot;, HexagonGlobalRegStat=
e, dsp_rev, 0),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;isdben-etm-enable&quot;, HexagonGloba=
lRegState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0isdben_etm_enable, false),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;isdben-dfd-enable&quot;, HexagonGloba=
lRegState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0isdben_dfd_enable, false),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;isdben-trusted&quot;, HexagonGlobalRe=
gState,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0isdben_trusted, false),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;isdben-secure&quot;, HexagonGlobalReg=
State,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0isdben_secure, false),<br>
+};<br>
+<br>
+static void hexagon_globalreg_class_init(ObjectClass *klass, const void *d=
ata)<br>
+{<br>
+=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>
+<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D hexagon_globalreg_realize;<br>
+=C2=A0 =C2=A0 rc-&gt;phases.hold =3D hexagon_globalreg_reset_hold;<br>
+=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;vmstate_hexagon_globalreg;<br>
+=C2=A0 =C2=A0 dc-&gt;user_creatable =3D false;<br>
+=C2=A0 =C2=A0 device_class_set_props(dc, hexagon_globalreg_properties);<br=
>
+}<br>
+<br>
+static const TypeInfo hexagon_globalreg_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_HEXAGON_GLOBALREG,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(HexagonGlobalRegState),<br>
+=C2=A0 =C2=A0 .instance_init =3D hexagon_globalreg_init,<br>
+=C2=A0 =C2=A0 .class_init =3D hexagon_globalreg_class_init,<br>
+};<br>
+<br>
+static void hexagon_globalreg_register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;hexagon_globalreg_info);<br>
+}<br>
+<br>
+type_init(hexagon_globalreg_register_types)<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000fad185064ef78adc--

