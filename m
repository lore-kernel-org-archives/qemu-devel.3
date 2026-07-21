Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FAFC44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBzw-0007R8-3a; Tue, 21 Jul 2026 11:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmBzu-0007Qm-C5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wmBzq-0003eK-EK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:03:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDfqlT1590965
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T84x51uK20w0O7i+kJUlrVHkK18s8acVJXdB1OJkOOs=; b=R1IyPzfiu2xx59Uf
 85U5dbcuXorU9wUG1VjjzU0wLQXFvn0IvBnJ3ssFakAO5pfgx1B2b3aoQDMHcFPM
 02hnnFEJyEsiiMPgM+ZwcDl1zGS+85gehdvQWs9V3i62ip/Kpd8kW3iTLxOeU2Kw
 5DqfdFc6AToSDDeFTSx6P4CyCCC7P0DMoYvGOA8dja5tHsiUUpUjhAMD2JxKduW7
 ACJnxFfJlIDZhHO0NmlDuR/Lmlvzz8r1yxfphNGh/l+miOzQMSp4M8Nx1tPAa1+O
 lwoXlJ5UEhohkpZo9OGoVN5K4SFrmoNLdTKvl3hKa4sgYSScLiI9DJALDjMfZ2UG
 1bRjqw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj0as3dsm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 15:02:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so1455228a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784646179; x=1785250979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T84x51uK20w0O7i+kJUlrVHkK18s8acVJXdB1OJkOOs=;
 b=XRmkIPK7d56CFk1rAZU+Nzfr38horpv8phCiItIGXhl6RQ2axaF3POSKw+H76p+Ngs
 s9wbr3LsnD+2RdHvuADCBBAsQur2p8Xqw9Aw7pden9ZIrFv94rxDm2sX5AkemV1pfliR
 DqgzJ7+hDsHWUkVBKBDItUEfHMWfWFM8sXlo7GZp7onZw57JBx3lYkYriFDJPwvungUs
 0Bf4oZtX4BNrhA/4fWQ0wiUlLNMCfJCqMKI8CMhs8m4o6I77iRqHEOaFdzb1NasDWxK7
 CElrnwl093jaAAuDE3oGO57K5qIUiMmTy4qhlQ0iC0IvrTGkfmyAPinZNrO3I6Xc/3Vh
 rLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784646179; x=1785250979;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T84x51uK20w0O7i+kJUlrVHkK18s8acVJXdB1OJkOOs=;
 b=nkdUEsNxROi7AEKJYx2RFenhtQ+ahPSTdw+wbDhptVAoSZbFkI5/aV7HziHtP2dJm7
 4TCLO2Rd28Q9FeTAnhNKeMnY8uqknD28XJbJix8zHJP5yjQ5SBLvslVDUj3k2C+nE9Qz
 /XE2VT+Wu3O0irW3VtLCjXism5RNQ71w+9FRlemmSj50WgRAbnCAFt2PeIRrxDnxz3m9
 2RuTwHjlkaxaSiVDmROtAzLSTXTg8p2JynVKpndgtxN7Z7ALd+yCtzzD6pexyrddB4u3
 xyFaPzEV7/ayp294Z01hdAiryN/BQcPQZPwbP5xRYA9gigD3BHYGqkBlKky4cxiV2huP
 8KNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaweZ8AbWL4kI4/tMFwWc61ZqUUkULCvmX8yNyoTOsm8HNRTLRIJQ0pztgVO3pHV2ZdFCycJbruzNg@nongnu.org
X-Gm-Message-State: AOJu0YwMEVa0VfvIzOVv2u5xjOfZynCSBoYMiJM78rVEfwccoky41/0z
 zA/8kisPCZteiGGP3/mGtQ+YhEmDiseCj1BTRW4U7ZGPaCRMxpCn0obNhiTLMvUv08/STChl+Qo
 MyGOICFHi2x4hJ8iMZNbjnxc6rqVzTzipLU4GICFyy4Hgx0HutMLYGNMaTA==
X-Gm-Gg: AfdE7cmXRmQMKrEBxnXOHC4wq+fxM4lDHVLLz7jLfSwh2lfxPOUn3NblVIABntjnhGk
 4bGoSkrRVl548v6o6ECTK+eNF6cwy0/ah7wNIOw4pG1qV5ox52zXMb3SvEq11LQAFsEN/1ad1f7
 EDvWODKaIWDJQJWYyNUClZg1swDt/Nmzjg6O+pY4an+Ni0+FFoSfSP/ECRYUVq5bjEnUrdoKqH3
 jXuLqQHq6IQrvKco/3/oZcTtmu2pO8UV1Db75e4NnAxLO2lxEb261Or3sXM9IJxYiXDX+mOpwv7
 r7OB/2ZGcS/9xQ3mxKHX6532g3fUyN5TGEYPv+Qz7ZpCN8elILr3V/3HtaHjRV0QkZz85AsoSxg
 YULZOWOYmUjS5MtR7MpZhNiv1l+eeyX8dqOvxUlEK5dfW4+LRPiMELBZ3F32Fjs4Ovww2
X-Received: by 2002:a05:6a20:9397:b0:3c3:9aff:7a5f with SMTP id
 adf61e73a8af0-3c3ad8ecd8dmr20169471637.43.1784646178573; 
 Tue, 21 Jul 2026 08:02:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:9397:b0:3c3:9aff:7a5f with SMTP id
 adf61e73a8af0-3c3ad8ecd8dmr20169384637.43.1784646177620; 
 Tue, 21 Jul 2026 08:02:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bbaf6sm43823770eec.17.2026.07.21.08.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:02:56 -0700 (PDT)
Message-ID: <1d51b475-f8ba-4f00-8120-732e7731e8fd@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 08:02:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/timer: Add QCT QTimer device model
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 matheus.bernardino@oss.qualcomm.com,
 Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?Q?Tobias_R=C3=B6hmel?= <quic_trohmel@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Thomas Marceron <tmarcero@qti.qualcomm.com>,
 Mahmoud Kamel <mkamel@qti.qualcomm.com>
References: <20260718013241.1550124-1-brian.cain@oss.qualcomm.com>
 <20260718013241.1550124-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260718013241.1550124-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1OSBTYWx0ZWRfX+mMPt6iasaop
 6SaEPZFAom0Bo2IFoZQf8x08fTr0GInge4MOI2xMVMCLYRh8wltHKqKExJ8wfgj587Z7PSa0dB4
 V5pUgbYJoLqVwTOTxNwXbQVWk/yAa4hYvLPRnjdGbd2dfsSlYH/0kKU5vW2nQ8cOZ7bFhYmJ+30
 nhphnNObBBOxlFg64L/3ZqWDeJIVPGDpLwO8e920f+cwaoYzqT1XYLty1S1447smOg8Xq3IKCZ8
 8y6Oh//M6FclqleRN5VlP2FG0LIB0dmEaj7jBed1r/y0R38j/9Dbpepd/3uGNPqBu4gwZjoHxMk
 wXNvMQPDrb+6QXW7kAvP2lc9ZBLx+pA+QHaH1f7Sj7qdmD7GzcE1hHdD/SQjsI/DjNDRayNNA8X
 lxfOeboHPGKV2HSv+t/3PuoCwD8y16tU8/lgRUK7G6dupRbL45Zi2hr0Civqah/Lyzthj2nU2xq
 k2nFrXyO3fyivFlQKBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1OSBTYWx0ZWRfX2QistnzVtuhV
 WnQH3GqoEGeCnWEX2tW+AVDn5a8dQNqOAbvNKlhRUVHAbOrapkQRChSxPuXPIbO5SGODuqbZ5Tc
 slaP274c99vg9qh2MVUJq8B3P9twqok=
X-Authority-Analysis: v=2.4 cv=DoFmPm/+ c=1 sm=1 tr=0 ts=6a5f8a23 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=1cGLs3X8AAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=hdWk2wh1_L2mtIxOn0oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=d8ghUycwObenwynNfMyN:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LYwyBtgLvz_dG63Qwft1u6lBQsZ7_fTy
X-Proofpoint-ORIG-GUID: LYwyBtgLvz_dG63Qwft1u6lBQsZ7_fTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/17/2026 6:32 PM, Brian Cain wrote:
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
>  MAINTAINERS                   |   2 +
>  include/hw/timer/qct-qtimer.h |  78 +++++
>  hw/timer/qct-qtimer.c         | 613 ++++++++++++++++++++++++++++++++++
>  hw/timer/Kconfig              |   3 +
>  hw/timer/meson.build          |   2 +
>  hw/timer/trace-events         |   5 +
>  6 files changed, 703 insertions(+)
>  create mode 100644 include/hw/timer/qct-qtimer.h
>  create mode 100644 hw/timer/qct-qtimer.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5df21aa12d..2c73705c727 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -253,6 +253,8 @@ F: target/hexagon/
>  F: hw/intc/hex-l2vic.c
>  F: include/hw/intc/hex-l2vic.h
>  F: tests/qtest/l2vic-test.c
> +F: hw/timer/qct-qtimer.c
> +F: include/hw/timer/qct-qtimer.h
>  X: target/hexagon/idef-parser/
>  X: target/hexagon/gen_idef_parser_funcs.py
>  F: linux-user/hexagon/
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
> +    uint32_t (*get_timer_hi)(QctQtimerInterface *qtimer);
> +} QctQtimerInterfaceClass;
> +
> +DECLARE_OBJ_CHECKERS(QctQtimerInterface, QctQtimerInterfaceClass,
> +                     QCT_QTIMER_INTERFACE, TYPE_QCT_QTIMER_INTERFACE);
> +
> +static inline uint32_t qct_qtimer_get_timer_lo(QctQtimerInterface *qtimer)
> +{
> +    QctQtimerInterfaceClass *k = QCT_QTIMER_INTERFACE_GET_CLASS(qtimer);
> +    return k->get_timer_lo(qtimer);
> +}
> +
> +static inline uint32_t qct_qtimer_get_timer_hi(QctQtimerInterface *qtimer)
> +{
> +    QctQtimerInterfaceClass *k = QCT_QTIMER_INTERFACE_GET_CLASS(qtimer);
> +    return k->get_timer_hi(qtimer);
> +}
> +
> +#endif /* HW_TIMER_QCT_QTIMER_H */
> diff --git a/hw/timer/qct-qtimer.c b/hw/timer/qct-qtimer.c
> new file mode 100644
> index 00000000000..fd56a7118b1
> --- /dev/null
> +++ b/hw/timer/qct-qtimer.c
> @@ -0,0 +1,613 @@
> +/*
> + * Qualcomm QCT QTimer
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/timer/qct-qtimer.h"
> +#include "migration/vmstate.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/timer.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +#define QTIMER_MEM_SIZE_BYTES 0x1000
> +#define QTIMER_DEFAULT_FREQ_HZ 19200000ULL
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(QCTQtimerState, QCT_QTIMER)
> +
> +typedef struct QCTHextimerState {
> +    QCTQtimerState *qtimer;
> +    QEMUTimer *timer;       /* one-shot deadline timer */
> +    int64_t offset_ns;      /* QEMU_CLOCK_VIRTUAL ns at which cntpct == 0 */
> +    uint64_t cntval;        /* 64-bit physical timer compare value */
> +    uint32_t control;
> +    uint32_t cnt_ctrl;
> +    uint32_t cntpl0acr;
> +    uint32_t freq;
> +    uint32_t int_level;
> +    qemu_irq irq;
> +} QCTHextimerState;
> +
> +struct QCTQtimerState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    MemoryRegion view_iomem;
> +    uint32_t secure;
> +    QCTHextimerState timer[QCT_QTIMER_TIMER_FRAME_ELTS];
> +    uint32_t freq;
> +    uint32_t nr_frames;
> +    uint32_t nr_views;
> +    uint32_t frame_stride;
> +    uint32_t cnttid_0;
> +    uint32_t cnttid_1;
> +    uint32_t freq_scale;
> +};
> +
> +/*
> + * QTimer version register:
> + *
> + *    3                   2                   1
> + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + * | Major |         Minor         |           Step                |
> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> + */
> +#define QCT_QTIMER_VERSION_VALUE 0x20020000
> +
> +/* Counter value derived on-demand from QEMU_CLOCK_VIRTUAL. */
> +static uint64_t hex_timer_now(QCTHextimerState *s)
> +{
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    uint32_t scaler;
> +    uint64_t scaled_elapsed;
> +
> +    if (now <= s->offset_ns) {
> +        return 0;
> +    }
> +    scaler = MAX(s->qtimer->freq_scale, 1u);
> +    scaled_elapsed = (uint64_t)(now - s->offset_ns) / scaler;
> +    return muldiv64(scaled_elapsed, s->freq, NANOSECONDS_PER_SECOND) &
> +           QCT_QTIMER_CNT_MASK;
> +}
> +
> +/* Arm (or disarm) the one-shot deadline timer. */
> +static void hex_timer_rearm(QCTHextimerState *s)
> +{
> +    uint32_t scaler;
> +    uint64_t base_ns;
> +    int64_t deadline_ns;
> +
> +    if (!(s->control & QCT_QTIMER_CNTP_CTL_ENABLE)) {
> +        timer_del(s->timer);
> +        return;
> +    }
> +
> +    scaler = MAX(s->qtimer->freq_scale, 1u);
> +    base_ns = muldiv64(s->cntval, NANOSECONDS_PER_SECOND, s->freq);
> +    if (base_ns >
> +        ((uint64_t)INT64_MAX - (uint64_t)s->offset_ns - 1) / scaler) {
> +        timer_del(s->timer);
> +        return;
> +    }
> +    /*
> +     * muldiv64() truncates, so the computed deadline can land up to 1 ns
> +     * before the true cntval crossing. Add 1 ns so hex_timer_now() is
> +     * guaranteed to be >= cntval when the QEMUTimer fires; without this,
> +     * hex_timer_tick() would re-arm at the same deadline and loop.
> +     */
> +    deadline_ns = s->offset_ns + (int64_t)(base_ns * scaler) + 1;
> +    timer_mod(s->timer, deadline_ns);
> +}
> +
> +static void hex_timer_update(QCTHextimerState *s)
> +{
> +    int level = s->int_level &&
> +                (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) &&
> +                !(s->control & QCT_QTIMER_CNTP_CTL_INTEN);
> +
> +    trace_qtimer_interrupt();
> +    qemu_set_irq(s->irq, level);
> +}
> +
> +/*
> + * Access-control (AC) region: offsets below 0x1000, gates CNTFRQ/CNTSR/
> + * CNTTID/CNTACR per frame plus the shared VERSION register.
> + */
> +static uint64_t qct_qtimer_ac_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    QCTQtimerState *s = opaque;
> +    uint32_t frame;
> +
> +    switch (offset) {
> +    case QCT_QTIMER_AC_CNTFRQ:
> +        return s->freq;
> +    case QCT_QTIMER_AC_CNTSR:
> +        return s->secure;
> +    case QCT_QTIMER_AC_CNTTID_0:
> +        return s->cnttid_0;
> +    case QCT_QTIMER_AC_CNTTID_1:
> +        return s->cnttid_1;
> +    case QCT_QTIMER_AC_CNTACR_START ... QCT_QTIMER_AC_CNTACR_END:
> +        frame = (offset - QCT_QTIMER_AC_CNTACR_START) / 4;
> +        if (frame >= s->nr_frames) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad CNTACR offset 0x%x\n",
> +                          __func__, (int)offset);
> +            return 0;
> +        }
> +        return s->timer[frame].cnt_ctrl;
> +    case QCT_QTIMER_VERSION:
> +        return QCT_QTIMER_VERSION_VALUE;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
> +                      (int)offset);
> +        return 0;
> +    }
> +}
> +
> +static void qct_qtimer_ac_write(void *opaque, hwaddr offset, uint64_t value,
> +                                unsigned size)
> +{
> +    QCTQtimerState *s = opaque;
> +    uint32_t frame;
> +
> +    switch (offset) {
> +    case QCT_QTIMER_AC_CNTFRQ:
> +        s->freq = value;
> +        return;
> +    case QCT_QTIMER_AC_CNTSR:
> +        if (value > 0xff) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad CNTSR value 0x%x\n",
> +                          __func__, (int)value);
> +            return;
> +        }
> +        s->secure = value;
> +        return;
> +    case QCT_QTIMER_AC_CNTACR_START ... QCT_QTIMER_AC_CNTACR_END:
> +        frame = (offset - QCT_QTIMER_AC_CNTACR_START) / 4;
> +        if (frame >= s->nr_frames) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad CNTACR offset 0x%x\n",
> +                          __func__, (int)offset);
> +            return;
> +        }
> +        s->timer[frame].cnt_ctrl = value;
> +        return;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
> +                      (int)offset);
> +        return;
> +    }
> +}
> +
> +static const MemoryRegionOps qct_qtimer_ac_ops = {
> +    .read = qct_qtimer_ac_read,
> +    .write = qct_qtimer_ac_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +/*
> + * View region: a flat array of (frame, view) slots, each frame_stride
> + * bytes wide, holding the per-frame CNTPCT/CNTP_CVAL/CNTP_TVAL/CNTP_CTL
> + * register set.
> + */
> +static QCTHextimerState *qct_qtimer_demux(QCTQtimerState *s, hwaddr offset,
> +                                          uint32_t *reg_offset,
> +                                          uint32_t *view)
> +{
> +    uint32_t stride = s->frame_stride;
> +    uint32_t stride_shift = ctz32(stride);
> +    uint32_t slot_nr = (offset & (0xf * stride)) >> stride_shift;

Instead of hardcoded 0xf * stride, should we refer to
QCT_QTIMER_TIMER_FRAME_ELTS instead?

> +    uint32_t frame = slot_nr / s->nr_views;
> +
> +    *reg_offset = offset & (stride - 1);
> +    *view = slot_nr % s->nr_views;
> +    if (frame >= s->nr_frames) {
> +        return NULL;
> +    }
> +    return &s->timer[frame];
> +}
> +
> +/* Frames 8+ share cnttid_1; each frame's second view is gated by a bit. */
> +static bool qct_qtimer_view_visible(QCTQtimerState *s, uint32_t frame,
> +                                    uint32_t view)
> +{
> +    uint32_t cnttid = frame < 8 ? s->cnttid_0 : s->cnttid_1;
> +    uint32_t frame_idx = frame < 8 ? frame : frame - 8;
> +
> +    return !view || (cnttid & (0x4 << (frame_idx * 4)));
> +}
> +
> +static MemTxResult hex_timer_read(void *opaque, hwaddr offset, uint64_t *data,
> +                                  unsigned size, MemTxAttrs attrs)
> +{
> +    QCTQtimerState *qs = opaque;
> +    uint32_t reg_offset;
> +    uint32_t view;
> +    QCTHextimerState *s = qct_qtimer_demux(qs, offset, &reg_offset, &view);
> +    uint32_t frame;
> +
> +    if (!s) {
> +        *data = 0;
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +    frame = s - qs->timer;
> +
> +    trace_qtimer_read(offset);
> +
> +    if (!qct_qtimer_view_visible(qs, frame, view)) {
> +        *data = 0;
> +        return MEMTX_OK;
> +    }
> +
> +    switch (reg_offset) {
> +    case QCT_QTIMER_CNT_FREQ:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RFRQ)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & (QCT_QTIMER_CNTPL0ACR_PL0PCTEN |
> +                                      QCT_QTIMER_CNTPL0ACR_PL0VCTEN))) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        *data = s->freq;
> +        return MEMTX_OK;
> +    case QCT_QTIMER_CNTP_CVAL_LO:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        *data = extract64(s->cntval, 0, 32);
> +        return MEMTX_OK;
> +    case QCT_QTIMER_CNTP_CVAL_HI:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        /* HI half is 24-bit per TRM; bits [31:24] are reserved. */
> +        *data = extract64(s->cntval, 32, QCT_QTIMER_CNT_HI_BITS);
> +        return MEMTX_OK;
> +    case QCT_QTIMER_CNTPCT_LO:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RPCT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0PCTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        *data = extract64(hex_timer_now(s), 0, 32);
> +        return MEMTX_OK;
> +    case QCT_QTIMER_CNTPCT_HI:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RPCT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0PCTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        *data = extract64(hex_timer_now(s), 32, QCT_QTIMER_CNT_HI_BITS);
> +        return MEMTX_OK;
> +    case QCT_QTIMER_CNTP_TVAL:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        *data = (uint32_t)(int32_t)(int64_t)(s->cntval - hex_timer_now(s));
> +        return MEMTX_OK;
> +    case QCT_QTIMER_CNTP_CTL:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        /*
> +         * CNTP_CTL: bit 0 EN, bit 1 IMASK, bit 2 ISTAT (interrupt
> +         * pending). ISTAT tracks int_level and is read-only.
> +         */
> +        *data = s->control | ((s->int_level & 0x1) << 2);
> +        return MEMTX_OK;
> +    case QCT_QTIMER_CNTPL0ACR:
> +        *data = view ? 0 : s->cntpl0acr;
> +        return MEMTX_OK;
> +    case QCT_QTIMER_VERSION:
> +        *data = QCT_QTIMER_VERSION_VALUE;
> +        return MEMTX_OK;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
> +                      (int)offset);
> +        *data = 0;
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +}
> +
> +static MemTxResult hex_timer_write(void *opaque, hwaddr offset,
> +                                   uint64_t value, unsigned size,
> +                                   MemTxAttrs attrs)
> +{
> +    QCTQtimerState *qs = opaque;
> +    uint32_t reg_offset;
> +    uint32_t view;
> +    QCTHextimerState *s = qct_qtimer_demux(qs, offset, &reg_offset, &view);
> +    uint32_t frame;
> +
> +    if (!s) {
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +    frame = s - qs->timer;
> +
> +    trace_qtimer_write(offset, value);
> +
> +    if (!qct_qtimer_view_visible(qs, frame, view)) {
> +        return MEMTX_OK;
> +    }
> +
> +    switch (reg_offset) {
> +    case QCT_QTIMER_CNTP_CVAL_LO:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        s->int_level = 0;
> +        s->cntval = deposit64(s->cntval, 0, 32, value);
> +        hex_timer_rearm(s);
> +        break;
> +    case QCT_QTIMER_CNTP_CVAL_HI:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        s->int_level = 0;
> +        /* HI half is 24-bit per TRM; bits [31:24] are reserved. */
> +        s->cntval = deposit64(s->cntval, 32, QCT_QTIMER_CNT_HI_BITS, value) &
> +                    QCT_QTIMER_CNT_MASK;
> +        hex_timer_rearm(s);
> +        break;
> +    case QCT_QTIMER_CNTP_CTL:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        /* ISTAT (bit 2) is read-only; keep SW writes from polluting it. */
> +        s->control = value & ~QCT_QTIMER_CNTP_CTL_ISTAT;
> +        hex_timer_rearm(s);
> +        break;
> +    case QCT_QTIMER_CNTP_TVAL:
> +        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        /* TVAL write: CVAL = CNTPCT + TVAL (TVAL is signed 32-bit). */
> +        s->int_level = 0;
> +        s->cntval = (hex_timer_now(s) + (int64_t)(int32_t)value) &
> +                    QCT_QTIMER_CNT_MASK;
> +        hex_timer_rearm(s);
> +        break;
> +    case QCT_QTIMER_CNTPL0ACR:
> +        if (!view) {
> +            s->cntpl0acr = value;
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%x\n", __func__,
> +                      (int)offset);
> +        return MEMTX_ACCESS_ERROR;
> +    }
> +    hex_timer_update(s);
> +    return MEMTX_OK;
> +}
> +
> +static void hex_timer_tick(void *opaque)
> +{
> +    QCTHextimerState *s = opaque;
> +    uint64_t now = hex_timer_now(s);
> +    uint64_t diff56 = (now - s->cntval) & QCT_QTIMER_CNT_MASK;
> +    int64_t signed_diff = (int64_t)(diff56 << 8) >> 8;
> +
> +    if (signed_diff >= 0) {
> +        s->int_level = 1;
> +        hex_timer_update(s);
> +    } else {
> +        hex_timer_rearm(s);
> +    }
> +}
> +
> +static const MemoryRegionOps hex_timer_ops = {
> +    .read_with_attrs = hex_timer_read,
> +    .write_with_attrs = hex_timer_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +        .unaligned = false,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static const VMStateDescription vmstate_qct_hextimer = {
> +    .name = "qct-hextimer",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(control, QCTHextimerState),
> +        VMSTATE_UINT32(cnt_ctrl, QCTHextimerState),
> +        VMSTATE_INT64(offset_ns, QCTHextimerState),
> +        VMSTATE_UINT64(cntval, QCTHextimerState),
> +        VMSTATE_UINT32(cntpl0acr, QCTHextimerState),
> +        VMSTATE_UINT32(int_level, QCTHextimerState),
> +        VMSTATE_TIMER_PTR(timer, QCTHextimerState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_qct_qtimer = {
> +    .name = "qct-qtimer",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(timer, QCTQtimerState, QCT_QTIMER_TIMER_FRAME_ELTS,
> +                             1, vmstate_qct_hextimer, QCTHextimerState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void qct_qtimer_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    QCTQtimerState *s = QCT_QTIMER(dev);
> +    unsigned int i;
> +
> +    if (s->nr_frames > QCT_QTIMER_TIMER_FRAME_ELTS) {
> +        error_setg(errp, "nr_frames too high");
> +        return;
> +    }
> +    if (s->nr_views > QCT_QTIMER_TIMER_VIEW_ELTS) {
> +        error_setg(errp, "nr_views too high");
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &qct_qtimer_ac_ops, s,
> +                          "qct-qtimer-ac", QTIMER_MEM_SIZE_BYTES);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +    memory_region_init_io(&s->view_iomem, OBJECT(s), &hex_timer_ops, s,
> +                          "qct-qtimer-view",
> +                          (uint64_t)s->frame_stride * s->nr_frames *
> +                          s->nr_views);
> +    sysbus_init_mmio(sbd, &s->view_iomem);
> +
> +    for (i = 0; i < s->nr_frames; i++) {
> +        QCTHextimerState *t = &s->timer[i];
> +
> +        t->qtimer = s;
> +        t->freq = QTIMER_DEFAULT_FREQ_HZ;

It seems like this property has a default set to this value, so we
should not need to set it explicitly. Also, it prevents overriding it.

> +        s->secure |= (1 << i);
> +
> +        sysbus_init_irq(sbd, &t->irq);
> +        t->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, hex_timer_tick, t);
> +    }
> +}
> +
> +static void qct_qtimer_reset_hold(Object *obj, ResetType type)
> +{
> +    QCTQtimerState *s = QCT_QTIMER(obj);
> +    unsigned int i;
> +
> +    for (i = 0; i < s->nr_frames; i++) {
> +        QCTHextimerState *t = &s->timer[i];
> +
> +        /*
> +         * Per TRM: CTL = 0 (EN=0, IMASK=0, ISTAT=0), CVAL = 0 so that
> +         * TVAL (= CVAL - CNTPCT) also reads 0 at reset. The QEMUTimer is
> +         * only armed when SW sets CTL.EN=1, so cntval=0 does not cause a
> +         * spurious fire before SW programs the compare value.
> +         */
> +        t->control = 0;
> +        t->cnt_ctrl = QCT_QTIMER_AC_CNTACR_RWPT | QCT_QTIMER_AC_CNTACR_RWVT |
> +                      QCT_QTIMER_AC_CNTACR_RVOFF | QCT_QTIMER_AC_CNTACR_RFRQ |
> +                      QCT_QTIMER_AC_CNTACR_RPVCT | QCT_QTIMER_AC_CNTACR_RPCT;
> +        t->cntval = 0;
> +        t->int_level = 0;
> +        t->offset_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        timer_del(t->timer);
> +    }
> +}
> +
> +static const Property qct_qtimer_properties[] = {
> +    DEFINE_PROP_UINT32("freq", QCTQtimerState, freq, QTIMER_DEFAULT_FREQ_HZ),
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
> +    dc->vmsd = &vmstate_qct_qtimer;
> +    rc->phases.hold = qct_qtimer_reset_hold;
> +}
> +
> +/* QTimer interface implementation, backing HEX_SREG_TIMERLO/TIMERHI */
> +static uint32_t qct_qtimer_get_timer_lo_impl(QctQtimerInterface *obj)
> +{
> +    QCTQtimerState *s = QCT_QTIMER(obj);
> +
> +    return s->nr_frames > 0 ? extract64(hex_timer_now(&s->timer[0]), 0, 32)
> +                            : 0;
> +}
> +
> +static uint32_t qct_qtimer_get_timer_hi_impl(QctQtimerInterface *obj)
> +{
> +    QCTQtimerState *s = QCT_QTIMER(obj);
> +
> +    return s->nr_frames > 0 ? extract64(hex_timer_now(&s->timer[0]), 32, 32)
> +                            : 0;
> +}
> +
> +static void qct_qtimer_interface_class_init(ObjectClass *klass,
> +                                            const void *data)
> +{
> +    QctQtimerInterfaceClass *k = QCT_QTIMER_INTERFACE_CLASS(klass);
> +
> +    k->get_timer_lo = qct_qtimer_get_timer_lo_impl;
> +    k->get_timer_hi = qct_qtimer_get_timer_hi_impl;
> +}
> +
> +static const TypeInfo qct_qtimer_interface_info = {
> +    .name = TYPE_QCT_QTIMER_INTERFACE,
> +    .parent = TYPE_INTERFACE,
> +    .class_size = sizeof(QctQtimerInterfaceClass),
> +    .class_init = qct_qtimer_interface_class_init,
> +};
> +
> +static const TypeInfo qct_qtimer_info = {
> +    .name = TYPE_QCT_QTIMER,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(QCTQtimerState),
> +    .class_init = qct_qtimer_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_QCT_QTIMER_INTERFACE },
> +        { }
> +    },
> +};
> +
> +static void qct_qtimer_register_types(void)
> +{
> +    type_register_static(&qct_qtimer_interface_info);
> +    type_register_static(&qct_qtimer_info);
> +}
> +
> +type_init(qct_qtimer_register_types)
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index b3d823ce2c3..e1b751a54a7 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -65,3 +65,6 @@ config STELLARIS_GPTM
>  
>  config AVR_TIMER16
>      bool
> +
> +config HEX_QTIMER
> +    bool
> diff --git a/hw/timer/meson.build b/hw/timer/meson.build
> index 201b5d8316d..0e8326b0492 100644
> --- a/hw/timer/meson.build
> +++ b/hw/timer/meson.build
> @@ -34,3 +34,5 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
>  
>  system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
> +
> +specific_ss.add(when: 'CONFIG_HEX_QTIMER', if_true: files('qct-qtimer.c'))
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 634ba1da27a..636310f8caa 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -128,3 +128,8 @@ imx_epit_get_freq(uint32_t freq) "ptimer frequency is %u"
>  imx_epit_read(const char *name, uint32_t value) "(%s) = 0x%08x"
>  imx_epit_write(const char *name, uint64_t value) "(%s, value = 0x%08" PRIx64 ")"
>  imx_epit_cmp(uint32_t sr) "sr was %d"
> +
> +# qct-qtimer.c
> +qtimer_interrupt(void) "qtimer interrupt line updated"
> +qtimer_read(uint64_t offset) "offset 0x%" PRIx64
> +qtimer_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64


