Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D162D10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXeo-00054e-BY; Wed, 08 Apr 2026 14:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXee-00053I-8B
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:29:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAE5T-00012r-K6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:35:57 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J7Bkw263875
 for <qemu-devel@nongnu.org>; Tue, 7 Apr 2026 21:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uD3ApUnI3hw9iYGuVfmIaIrhxggqUFxZL559Rp9BhAY=; b=iw/XKtTPU1tgzFvy
 HRe6fbM7PJHDWE1opoPIBqnu/UYmIqV42oGCQsn8d3TNu92jbKnZ+C3dTbCgYMX3
 XlsiwpYEMK1/XgBtVRkdpBGfeOQ3u8xWqqFfnN4p3zJ11MjNDSCTwQDyQDCX560/
 md8zcVyVOnFd9WkQDDGQrjVA9exAGyMhljGLypMaUd2DuMkFWFc2W71hAWHmV5ny
 FOh4aJuz6CdOjS7wPL84crfczf09sv8+F1VxqAoiKi14L8RhjZujjgN+FuprM3rN
 EYKPSPCanHjK2nhlVBzxrUw9GCe3P3RZ959xUBALQRnXGS7EpsmO5Xh0kJPQ7YHM
 bWpZ8Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7t20djw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:35:52 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c20a91932so2195889c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:35:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775597751; cv=none;
 d=google.com; s=arc-20240605;
 b=KSYitdqYKjNgCqBxbGTcH6BgcR2CXFDY6qBcyrZtJhPn0o3hl+s59zwlH7JNMwEbPF
 7amumOhP/ncex0/THEcZV7d89Q+fAjJyGrXZzM16kFypB69EGv8SUaUaKJUPmmyP50cf
 +ElQcL1l/M7UziirLD923zgMyh1Bapt4IK3MTzHEB1u6BiEsRSxs9PT7x9V2gmuGkSf/
 Jv/8rDGRGXyoYlf9eVCqmdn2bR+CTA2Sh0NVXTueByQsstJ9uH7O5Ux0t9nB0cZvar3e
 STlmb9+XWygBPXDlVfRAIybV5iK/sDVQlQwjvX8hyxlbEfk38tMsIeNBlnngL+piTItn
 cK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uD3ApUnI3hw9iYGuVfmIaIrhxggqUFxZL559Rp9BhAY=;
 fh=rS2nDwKDt4KjCcoLbfirdIFsUpx1rRdzn3zLrnYLpWM=;
 b=P4Qqs3zTKItlVQoqFWdluo3t1qoooYJLUmpx5DF7+sjuv1ghfMOOyPPnKEXFXeKhcR
 LwVIcZNOzlq7eqRggNcew9jKldvO06L404WThkD27mfdqtHmsPWmq69EDLkbcp19xZA2
 DztH+sjYxHTo9En/W257ahLTvF7/euOMu9aTwEnR0ax6r5gpUk+2DO3N9qO4dP+JSHEL
 e1DmYSylnY5ot6/UP718f2k05cQi5Qu2rSjcgpsEBAzTCscYcDJd97QXNszAq6MJCB1z
 Uy+EnJCm6uL0UvjwejTHN5eS6AxkcSKCV5jAGDS6OdmYwTK82TgwCLx0KbeKCGR8DT+L
 zlEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775597751; x=1776202551; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uD3ApUnI3hw9iYGuVfmIaIrhxggqUFxZL559Rp9BhAY=;
 b=BibRO30Vg724WjoGtHbYbBVvSTiLiRzF4QtBa0v+4COnX3kf80QA++rz12/W9iISkh
 VP+c7csTm7zQAzCHo7UuzEvczxZGS7gR2eca/rW3RTgexndoXuZgu8J2+6krPT2HeauH
 wwio0ey001CCObAnMDNNAGap2tEIMhRnX8pH8wSjz7XE+wEHOyXkxwRXRDbWSYYxBK7s
 v5vnLaC0FPklXfoUdlrUhjTkqhNIrtAB5vy1gY6NoVXo/b+SzGkyJbB7R/WCtyPW6ABt
 aDU+5QrfH9k/TIZtjR7/19Pinji39Kuf6BJLvztekt232nkcaBVqvEGsxSnKw+sZqc9g
 4sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775597751; x=1776202551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uD3ApUnI3hw9iYGuVfmIaIrhxggqUFxZL559Rp9BhAY=;
 b=HLW6zbPmCymc7GnY2qpfYY7kJGcGkOUYmgKtFFpqJ9ACf9cQSJZnLnMWttzu+n8ura
 iFDECGKI8jXfAqww2nf6+gYSuUkodta8FpVmW5F39TPfEwoZTRzsNw2elbAvk49cJPzU
 NN/qphdKthStjY88TzVlnolQJG97VQdJiCF0WyZ8G1XMrMtd4PjShl5Hp/cIpcRvjA1E
 TfhcPCdDhULdwQJ3wQP5qfvwODU1Xu8BKfATu27qrtu5Ql+PRjaw9mprljxxu3DiXd+i
 zKYgntv8vJNK9lx2TKxXZO6e3/QFJvZIuDv5or9oX3plngNmfTBnRzmLVZa0oMhPReef
 02QQ==
X-Gm-Message-State: AOJu0YxiHkfYaxUxe7BWC6OV0fxeJ459USz+Ysb/qLV8Kz+aHDTZO9bs
 Nwun4FC25Q8fAPEzrwf20qS3XMVFccWChyGzih+fwVAE2lW/F4xNVmANh/+/0EZ0nLAZ/XfyW1l
 qCchxiEK0cFNo//puQ/dZBYvhoyrsJUmMO7G39MbTs9ezyqr0jltF65pnJPhlI2EutbicFRvjfu
 1w2MuQuCtspUW+5y+UyTHvPq4axVu22dIS
X-Gm-Gg: AeBDies/BnS0IsQvbgMuBCLqVDKB5clwVWf4LkIiAASdUQ7D8GW4jcL4SDsDlcm2OYG
 k77HMvzLsFx8m2OxF3gbcO/5ED3ktZ8+tOSAeW5huB4d1V0ZYwedUfU8JmVlpbjFJCCY3jf1HEy
 mtsKHwNcJDL8yo2tuZ6wBjZg8K5vq6wnKxcsN+WTjChFZdRkpSHF/bEFIYKnItBd7A+y8+NVwrz
 4+rbE0=
X-Received: by 2002:a05:7022:423:b0:11d:f89d:85a0 with SMTP id
 a92af1059eb24-12bfb75f0bbmr9557637c88.27.1775597751282; 
 Tue, 07 Apr 2026 14:35:51 -0700 (PDT)
X-Received: by 2002:a05:7022:423:b0:11d:f89d:85a0 with SMTP id
 a92af1059eb24-12bfb75f0bbmr9557614c88.27.1775597750738; Tue, 07 Apr 2026
 14:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-2-brian.cain@oss.qualcomm.com>
 <CAATN3Nq0Z0KKMGiryVg-hXJY7ogaVA+kvSrcMNt-qyC6iCFjng@mail.gmail.com>
In-Reply-To: <CAATN3Nq0Z0KKMGiryVg-hXJY7ogaVA+kvSrcMNt-qyC6iCFjng@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 16:35:33 -0500
X-Gm-Features: AQROBzD6rbS6OpciXU0tKJitgQwQOqmPLgEDQ6ESgyejQ0rRXUUCtyudRUBsumw
Message-ID: <CAEqNhNYi46jdwKLHV7DQAE3YJn4=tFNayZh=poZqXjO6zx6D0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] hw/hexagon: Add globalreg model
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=De0nbPtW c=1 sm=1 tr=0 ts=69d578b8 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ESscMMdrerS4ZbMRSc4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE5NyBTYWx0ZWRfX5O1tBPIVvSNV
 wnTVsr4xCsjEuVQyf6V4mbcPVQrtO3IuJ4QkJQNHWPdjMnZax1Lko3Jyvg2T6ojU3DSHwpIi6pL
 F5a11/i2q/FqjekIVX6wGoaKHf3Mj66LWBYW8YxiL3JNnoRdNm6c+ucmeUXgUuXQdc88dLBJd+b
 QNMi5aO9A7ci0+x0RDwkpyGl9Kp9hdbw62gUTvNT55Yl8/a/ItpiYx4Ech8Geet6UE0XUO1V0Lh
 nXVqpYYOPC59IvrCM9JTuRCLtPLIb7GwYtJId7PJ02WCkWzDQ3jDAqzQ8YIsNrqJf6Jaw78rk39
 BuJkTsjSLXJVOIEymyAhMo2z0efJAKEoeLxd9mX6NVwwHkO4UT3F4T44SqkwlcW+qglLLbOmXpN
 9gQga/AAEQvT2z8qRjUQBT94qLnjLCoXdLCRGWlL5bY1Xdgdk+Vzxz2m7Cr3a8LHqJB//BBWUof
 bnJsx8lBcTa33B8amJg==
X-Proofpoint-ORIG-GUID: PDSLdlqIHTn5uwEK6WKvknaGY9ruvAMZ
X-Proofpoint-GUID: PDSLdlqIHTn5uwEK6WKvknaGY9ruvAMZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 16, 2026 at 12:58=E2=80=AFPM Taylor Simpson
<ltaylorsimpson@gmail.com> wrote:
>
>
>
> On Tue, Mar 10, 2026 at 10:20=E2=80=AFPM Brian Cain <brian.cain@oss.qualc=
omm.com> wrote:
>>
>> Some of the system registers are shared among all threads
>> in the core.  This object contains the representation and
>> interface to the system registers.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>  include/hw/hexagon/hexagon_globalreg.h |  56 ++++++
>>  hw/hexagon/hexagon_globalreg.c         | 240 +++++++++++++++++++++++++
>>  2 files changed, 296 insertions(+)
>>  create mode 100644 include/hw/hexagon/hexagon_globalreg.h
>>  create mode 100644 hw/hexagon/hexagon_globalreg.c
>>
>> diff --git a/include/hw/hexagon/hexagon_globalreg.h b/include/hw/hexagon=
/hexagon_globalreg.h
>> new file mode 100644
>> index 00000000000..c9e72f30b0a
>> --- /dev/null
>> +++ b/include/hw/hexagon/hexagon_globalreg.h
>> @@ -0,0 +1,56 @@
>> +/*
>> + * Hexagon Global Registers QOM Object
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HEXAGON_GLOBALREG_H
>> +#define HEXAGON_GLOBALREG_H
>> +
>> +#include "hw/core/qdev.h"
>> +#include "hw/core/sysbus.h"
>> +#include "qom/object.h"
>> +#include "target/hexagon/cpu.h"
>> +
>> +#define TYPE_HEXAGON_GLOBALREG "hexagon-globalreg"
>> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalRegState, HEXAGON_GLOBALREG)
>> +
>> +struct HexagonGlobalRegState {
>> +    SysBusDevice parent_obj;
>> +
>> +    /* Array of system registers */
>> +    uint32_t regs[NUM_SREGS];
>> +
>> +    /* Global performance cycle counter base */
>> +    uint64_t g_pcycle_base;
>> +
>> +    /* Properties for global register reset values */
>> +    uint32_t boot_evb;           /* Boot Exception Vector Base (HEX_SRE=
G_EVB) */
>> +    uint64_t config_table_addr;  /* Configuration table base */
>> +    uint32_t dsp_rev;           /* DSP revision register (HEX_SREG_REV)=
 */
>> +
>> +    /* ISDB properties */
>> +    bool isdben_etm_enable;     /* ISDB ETM enable bit */
>> +    bool isdben_dfd_enable;     /* ISDB DFD enable bit */
>> +    bool isdben_trusted;        /* ISDB trusted mode bit */
>> +    bool isdben_secure;         /* ISDB secure mode bit */
>
>
> Should the TLB entries go in here also?

No, the TLB entries are a property of the TLB device, not the global regist=
ers.

>> +};
>> +
>> +/* Public interface functions */
>> +uint32_t hexagon_globalreg_read(HexagonGlobalRegState *s, uint32_t reg,
>> +                                uint32_t htid);
>
>
> Why is htid needed?

It's not strictly needed - it was Phil's suggestion to make it easier
to follow.  We can omit it if preferred:

https://lore.kernel.org/qemu-devel/124c48b0-eea0-413f-a1dc-1ede32a7092c@lin=
aro.org/


>> +void hexagon_globalreg_write(HexagonGlobalRegState *s, uint32_t reg,
>> +                             uint32_t value, uint32_t htid);
>
>
> Ditto
>
>>
>> +uint32_t hexagon_globalreg_masked_value(HexagonGlobalRegState *s, uint3=
2_t reg,
>> +                                        uint32_t value);
>> +void hexagon_globalreg_write_masked(HexagonGlobalRegState *s, uint32_t =
reg,
>> +                                    uint32_t value);
>> +void hexagon_globalreg_reset(HexagonGlobalRegState *s);
>> +
>> +/* Global performance cycle counter access */
>> +uint64_t hexagon_globalreg_get_pcycle_base(HexagonGlobalRegState *s);
>> +void hexagon_globalreg_set_pcycle_base(HexagonGlobalRegState *s,
>> +                                       uint64_t value);
>> +
>> +#endif /* HEXAGON_GLOBALREG_H */
>> diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalr=
eg.c
>> new file mode 100644
>> index 00000000000..5187b91dcae
>> --- /dev/null
>> +++ b/hw/hexagon/hexagon_globalreg.c
>> @@ -0,0 +1,240 @@
>> +static void hexagon_globalreg_init(Object *obj)
>> +{
>> +    HexagonGlobalRegState *s =3D HEXAGON_GLOBALREG(obj);
>> +
>> +    memset(s->regs, 0, sizeof(uint32_t) * NUM_SREGS);
>
>
> Should we memset the whole thing?

I don't think so: I believe that this would corrupt the parent fields
of the QEMU object model.

>>
>> +}
>>

