Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DDDC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmH9S-0002Ml-9e; Tue, 21 Jul 2026 16:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmH9Q-0002M7-PF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:33:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmH9O-0005Qd-Iw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 16:33:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2cmk2186851
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WTduVf+d6sfntwbgCnJ5EgITtoorsoGoBWCWwp5ncyc=; b=IEf1jOYnMRw/QkF+
 3YuLbRV1NfI2CUefGIfJCN02QM0uOf5Tyx+Y2KHSPoIlc0GYhendeBdTINLNhN4i
 zFUGXfIFr+R4j5HUAu+sl50vyPcYrdARtg8jZohUODBdmlDsxBG2h1R413smGw3U
 wpobarzJNdObRnxz0SSQ4YzU2PIG9727BpvirfWW5IKwmZe7wTbuJEw6B+Ua6AJP
 57exZMbXFJVgEKoOnKiFXKo+JXu5P/bC7xxVVybyPWmQOwwQNqg/Xsm6aypvXCbH
 p6MBSRbwUss+DL7dfwW2r4lrFvPBwNJxz2wUI+7pwO2727miriAvlQHnjDhdPIOB
 PvTA9Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9aea5ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 20:33:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c075c1e25so168074131cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784665992; x=1785270792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WTduVf+d6sfntwbgCnJ5EgITtoorsoGoBWCWwp5ncyc=;
 b=JH+yqONjn73/MF+Qx5at9iHsC5FyjUZ9Z5s6dI+9PsEUXU9jOvZfsrUMPwzfmp6a+o
 eiGVQxZ9F4eonXFP4J/nF65ymqrrzdulOH4re9TEClgbNzjF4Hurfv+KvrNWU2Fpfd68
 yvnyLpJi97nApzj9uhUe40rGZv/6SWsdtJeMy7Q2LNOS41ELksNl/NXyYUAbaSnunkhM
 JwQWSO/g3b350zd4Esqg2Ohc0VG3jBj/HacmIExallRXREhGEdc+jm8ohcJKQn1L7gvK
 DbwPJ7oaNmQY1wTQ4olgEVG+wAbGC+CWRChNQNcWiZJVCnfiGtNeUG1uZDZ+8ESOwT6L
 FyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784665992; x=1785270792;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WTduVf+d6sfntwbgCnJ5EgITtoorsoGoBWCWwp5ncyc=;
 b=L8R+OU2OOPJ+qBZjU9Rp1wXorlIDx302TRq8+LVLzby1yJBIBKELm3l+IQYcySVI7p
 5defPF3KdpiYvpljS03j7QyFXL8bLFO4txrcOPXGx0zVoDLSBSnYMyk8RB139wWB8y6O
 tgzdaYoMS3jLsMHZGIsM9VV4iB3qWMrvgK5sgqM+Xx7lrgJk5M1jCSrn8Qz+FNjpaLYw
 0AcUKMF07PhFR26M30lBXlaZPIKXj7DpN2a+4W80tKmVCrxTE0zK0YStSuMX7QGxIexY
 3tZ+xH5qVgV/OBI9bAXFXWOjjM44ZUxxLJ+pcS1LBmop0QkR/ahMnWTtkoJY/xGPgahI
 4hBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKf4SO89c92qx5XKDPdYAJt6Np/s/10D5RVNyN3iNtqqi2g54oBZuzoVqiu+d+1FKJWs8ikwP6Yhyo@nongnu.org
X-Gm-Message-State: AOJu0YyIr6zIS7Cfw0GnNSfHLasdV1ZkHtzZViGW2eJPDIAmYPWbugpo
 TZ6f60aUi+qzr2qfqszSOwUT5uA7WoIzkg0Ck1LNrCWOPWFEi3JK3wtgPALzEVl4Lj8mH5IiYlQ
 Xr0rmmCLhfp9uuDVSOr2SkLnVw9S1NYdst34CjwSjFShw7BFQ80lAgivMPQ==
X-Gm-Gg: AfdE7ckG8XkCPyPjKpwLJ8U72A7jlQa9jKyVr1+vDPSenXmEdAo+Ct+w8km9m0nhGo1
 NXChmA3wqwTZ688laxGELqh5Tszh+iLknhw2aLWpN+N2Kli7R6O9f8S4i8W8S8zqjrLKItMjEra
 P8x7Suvd/XXFwEwx5EB+Woyu/1L2gUf7XsOrfWG5H0aD6F+BRp7U4S6AdtdpfBDi7aWg6Z2Up+W
 a5XnKp5FuhK77rHVUC4hFsdzDPKniTmYy/WVL2s5dqU4r3ZL1uw9Qe1xnijKLMBn7x0AxnnLmmu
 0luKQ5H9whsNviOfVawKcRfiNRQiPhxNLxGg56xInBu6iYGCJWRyM2EIErLYMR2zVcBStq+QdRI
 Eo4jjQSwv7wvoka8SdO3r+KHv56zc5wGhbXM6iFh9Xp5QQPPovDc=
X-Received: by 2002:a05:622a:118e:b0:517:8069:8b07 with SMTP id
 d75a77b69052e-5213c9e34a8mr187967431cf.29.1784665991598; 
 Tue, 21 Jul 2026 13:33:11 -0700 (PDT)
X-Received: by 2002:a05:622a:118e:b0:517:8069:8b07 with SMTP id
 d75a77b69052e-5213c9e34a8mr187967181cf.29.1784665991145; 
 Tue, 21 Jul 2026 13:33:11 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b021fa6sm4739345e9.2.2026.07.21.13.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 13:33:10 -0700 (PDT)
Message-ID: <fab54e23-36d6-4011-a03e-0ada1c7c43d5@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 22:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/timer: Add QCT QTimer device model
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 matheus.bernardino@oss.qualcomm.com,
 Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?Q?Tobias_R=C3=B6hmel?= <quic_trohmel@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Thomas Marceron <tmarcero@qti.qualcomm.com>,
 Mahmoud Kamel <mkamel@qti.qualcomm.com>
References: <20260718013241.1550124-1-brian.cain@oss.qualcomm.com>
 <20260718013241.1550124-2-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260718013241.1550124-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Qv60i8C0MElQ4Wmejf8KI4ZWA0ZcFpqX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIxMyBTYWx0ZWRfX2ry0Sq1E+Uo7
 GOgsH77wAQxuDgtnDND3hFr4H9vB3X1dx4sslfw44S+fGXTkHooSMGTKhR/3qT6M2wL761akob0
 pdk6/ZmWfD6FCWn6s+jE2U5zDmK3Lsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIxMyBTYWx0ZWRfXw482KFWh7qSo
 vjOE/acvvcYwqPpawMOCeF/CbZrw0Ryhq1/AN6of6ZrDoBCf6MpV40W1LqyR4hlZXpHiipZ8IYL
 cIrE8C4yOfPNKnu7i/xvyfaOrjCnRkEKRlWTBYtKbRhCQhsE+SQXpg0ezH5hSjLgK4a9CONcy1a
 WfoxKqW7jAfFyxd34BHUmPmLOym6zeYsvXLQ9wZhFA0a5s3I/TYH8MAoBYpKKY8QnSuetJqHIrJ
 1pXPz4EfJzdDjydkHaxGqu2OueeQrixGBZT55ahVybUZMyttkVkV6THCRQatv4Wg9w9OAkO0wnj
 W7fc+rJGOTFf9+rDOnBg4EUSP8vZZ4zH0jueBXnVGam2J/ot0WjBpJ4X/LE+a/N7Bv/IndBKd2w
 O1xFs4Y27oZXRq5EeVz7ucifYNeSPEsr8HK+dG/5RokgL6MlYx//2cbOvwPG3aO/w0XmRapD2sI
 MYoGfYzbVvo1bi+FDeA==
X-Proofpoint-GUID: Qv60i8C0MElQ4Wmejf8KI4ZWA0ZcFpqX
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a5fd788 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=1cGLs3X8AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=CioRZDZX_C_aO4N-QMEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=d8ghUycwObenwynNfMyN:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210213
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Brian,

On 18/7/26 03:32, Brian Cain wrote:
> Implement the QCT QTimer generic timer device used by Hexagon DSP
> systems.
> 
> Co-authored-by: Damien Hedde <damien.hedde@greensocs.com>
> Co-authored-by: Tobias Röhmel <quic_trohmel@quicinc.com>
> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> Co-authored-by: Thomas Marceron <tmarcero@qti.qualcomm.com>
> Co-authored-by: Mahmoud Kamel <mkamel@qti.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                   |   2 +
>   include/hw/timer/qct-qtimer.h |  78 +++++
>   hw/timer/qct-qtimer.c         | 613 ++++++++++++++++++++++++++++++++++
>   hw/timer/Kconfig              |   3 +
>   hw/timer/meson.build          |   2 +
>   hw/timer/trace-events         |   5 +
>   6 files changed, 703 insertions(+)
>   create mode 100644 include/hw/timer/qct-qtimer.h
>   create mode 100644 hw/timer/qct-qtimer.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5df21aa12d..2c73705c727 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -253,6 +253,8 @@ F: target/hexagon/
>   F: hw/intc/hex-l2vic.c
>   F: include/hw/intc/hex-l2vic.h
>   F: tests/qtest/l2vic-test.c
> +F: hw/timer/qct-qtimer.c
> +F: include/hw/timer/qct-qtimer.h
>   X: target/hexagon/idef-parser/
>   X: target/hexagon/gen_idef_parser_funcs.py
>   F: linux-user/hexagon/
> diff --git a/include/hw/timer/qct-qtimer.h b/include/hw/timer/qct-qtimer.h
> new file mode 100644
> index 00000000000..d2ef9447b26
> --- /dev/null
> +++ b/include/hw/timer/qct-qtimer.h
> @@ -0,0 +1,78 @@
> +/*
> + * Qualcomm QCT QTimer
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_TIMER_QCT_QTIMER_H
> +#define HW_TIMER_QCT_QTIMER_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_QCT_QTIMER "qct-qtimer"
> +
> +#define QCT_QTIMER_TIMER_FRAME_ELTS (16)
> +#define QCT_QTIMER_TIMER_VIEW_ELTS (2)
> +
> +#define QCT_QTIMER_AC_CNTFRQ (0x000)
> +#define QCT_QTIMER_AC_CNTSR (0x004)
> +#define QCT_QTIMER_AC_CNTTID_0 (0x08)
> +#define QCT_QTIMER_AC_CNTACR_START (0x40)
> +#define QCT_QTIMER_AC_CNTACR_END (0x5c)
> +#define QCT_QTIMER_AC_CNTTID_1 (0x108)
> +#define QCT_QTIMER_AC_CNTACR_RWPT (1 << 5) /* R/W of CNTP_* regs */
> +#define QCT_QTIMER_AC_CNTACR_RWVT (1 << 4) /* R/W of CNTV_* regs */
> +#define QCT_QTIMER_AC_CNTACR_RVOFF (1 << 3) /* R/W of CNTVOFF register */
> +#define QCT_QTIMER_AC_CNTACR_RFRQ (1 << 2) /* R/W of CNTFRQ register */
> +#define QCT_QTIMER_AC_CNTACR_RPVCT (1 << 1) /* R/W of CNTVCT register */
> +#define QCT_QTIMER_AC_CNTACR_RPCT (1 << 0) /* R/W of CNTPCT register */
> +#define QCT_QTIMER_VERSION (0x0fd0)
> +
> +#define QCT_QTIMER_CNTPCT_LO (0x000)
> +#define QCT_QTIMER_CNTPCT_HI (0x004)
> +#define QCT_QTIMER_CNT_FREQ (0x010)
> +#define QCT_QTIMER_CNTPL0ACR (0x014)
> +#define QCT_QTIMER_CNTPL0ACR_PL0CTEN (1 << 9)
> +#define QCT_QTIMER_CNTPL0ACR_PL0TVEN (1 << 8)
> +#define QCT_QTIMER_CNTPL0ACR_PL0VCTEN (1 << 1)
> +#define QCT_QTIMER_CNTPL0ACR_PL0PCTEN (1 << 0)
> +#define QCT_QTIMER_CNTP_CVAL_LO (0x020)
> +#define QCT_QTIMER_CNTP_CVAL_HI (0x024)
> +#define QCT_QTIMER_CNT_MASK 0x00ffffffffffffffULL
> +#define QCT_QTIMER_CNT_HI_BITS 24
> +#define QCT_QTIMER_CNTP_TVAL (0x028)
> +#define QCT_QTIMER_CNTP_CTL (0x02c)
> +#define QCT_QTIMER_CNTP_CTL_ENABLE (1 << 0)
> +#define QCT_QTIMER_CNTP_CTL_INTEN (1 << 1)
> +#define QCT_QTIMER_CNTP_CTL_ISTAT (1 << 2)

The register related definitions aren't consumed outside of the
implementation, so no need to expose them, they could be moved
to the single place using them, the source file.

> +
> +/* QTimer interface for external access from hexagon_globalreg */
> +#define TYPE_QCT_QTIMER_INTERFACE "qct-qtimer-if"
> +
> +typedef struct QctQtimerInterface QctQtimerInterface;
> +
> +typedef struct QctQtimerInterfaceClass {
> +    InterfaceClass parent_class;
> +
> +    /* Read the live physical counter, backing HEX_SREG_TIMERLO/TIMERHI */
> +    uint32_t (*get_timer_lo)(QctQtimerInterface *qtimer);

const qtimer

> +    uint32_t (*get_timer_hi)(QctQtimerInterface *qtimer);

const qtimer

> +} QctQtimerInterfaceClass;


> diff --git a/hw/timer/qct-qtimer.c b/hw/timer/qct-qtimer.c
> new file mode 100644
> index 00000000000..fd56a7118b1
> --- /dev/null
> +++ b/hw/timer/qct-qtimer.c
> @@ -0,0 +1,613 @@


> +static const MemoryRegionOps qct_qtimer_ac_ops = {
> +    .read = qct_qtimer_ac_read,
> +    .write = qct_qtimer_ac_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },

Missing .impl = {4, 4}

> +};


> +static const Property qct_qtimer_properties[] = {
> +    DEFINE_PROP_UINT32("freq", QCTQtimerState, freq, QTIMER_DEFAULT_FREQ_HZ),

"freq-hz", freq_hz if possible.

> +    DEFINE_PROP_UINT32("freq-scale", QCTQtimerState, freq_scale, 1),
> +    DEFINE_PROP_UINT32("nr_frames", QCTQtimerState, nr_frames, 2),
> +    DEFINE_PROP_UINT32("nr_views", QCTQtimerState, nr_views, 1),
> +    DEFINE_PROP_UINT32("frame_stride", QCTQtimerState, frame_stride, 0x1000),
> +    DEFINE_PROP_UINT32("cnttid_0", QCTQtimerState, cnttid_0, 0x11),
> +    DEFINE_PROP_UINT32("cnttid_1", QCTQtimerState, cnttid_1, 0x0),
> +};
> +
> +static void qct_qtimer_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    device_class_set_props(dc, qct_qtimer_properties);
> +    dc->realize = qct_qtimer_realize;

Missing unrealize.

> +    dc->vmsd = &vmstate_qct_qtimer;
> +    rc->phases.hold = qct_qtimer_reset_hold;
> +}


> +static void qct_qtimer_register_types(void)
> +{
> +    type_register_static(&qct_qtimer_interface_info);
> +    type_register_static(&qct_qtimer_info);
> +}
> +
> +type_init(qct_qtimer_register_types)

Prefer DEFINE_TYPES.

Regards,

Phil.

