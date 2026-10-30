Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E25606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E7JmTwXv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XMRZo5qL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMaRy-0002jO-7k; Thu, 29 Oct 2026 20:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaRu-0002ij-4L
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:26:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMaRr-0002V3-EM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:26:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKiKO614015
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BLS6U/13+msDXX//d/eNc4iNopzMVfY5iIUy76jIxcw=; b=E7JmTwXvJQ0oe+My
 a2cIcPztLPoCH7SmihVkhD+4xrrhZeZG3Pr+fSRHoBI51Be7IB87JJFgEEpFZnq3
 z0a7JCIlE7vVoxsbC0VGT8pML1EgoXlHNFCj7HmIvd1OlCua9RhDAMB9rDDf9Fx7
 C4mpOuVUXOZEMkA0joLbVbk2KxGA9pi8YPeiUphdHcWxUC+MDdr6PRppjaQOYRW0
 DOkz7PfzbqatV2b28WmuTtASOpAfYe8T4ypWK1HXd4XRJ3pteE1COZj+c/F0EngL
 YFtim8NgONZQNnLQ/ClnpXsXwaaEosJbT1ieFPXHOvE8LCvhN4g99ailP2UxNqPg
 FEfq3w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p8fay-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:26:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c861b562eso4498466d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793319980; x=1793924780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BLS6U/13+msDXX//d/eNc4iNopzMVfY5iIUy76jIxcw=;
 b=XMRZo5qLo0inMMa+oVQakNV7Y1uSmE5GoklvYfP9iAkUhxAGc97sLYupRnpo0V57fW
 TbxExuEkUTh+TMyDrt1QNPHuSPGJ6su/cWd3X2VJIVPXd6DeKCj5zVe76NCP0JBpJ61L
 b84H8hEbx/nrL5bNQAVqy0e+OPjBJaY2yGqEnXubvQh3FoRDXE7K3SZNXdNhc2f0Gv5X
 pN9klLDAdZNOjeM4DACX8S7DdHqIRpJg95WfyOi51YiTDEtj9kt6o3eIlY3A/4MBsS9h
 PdEsKPO+3xtglos/vyQd5twa6lsA8IMAr99V3JIC5roJsnkiDpj0FgFSgcrkxPmQk3hL
 Gl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793319980; x=1793924780;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BLS6U/13+msDXX//d/eNc4iNopzMVfY5iIUy76jIxcw=;
 b=ny3IjVLkwhqUQl2m2i6bT2jZEKB/8xheee8Z8RMlLEYnNxcaMzSHAEuAkIvlfM5U1i
 fT8XMDuF+HoXDcyR5K5n0kTS/Iwg1Abna85Rtcg1qGWK9Id40yvpIkjekZRbULl6ZHid
 2oFFeIN7NlDolMxNfiAD+pc9Tpg+YKGM3jbN2L/uOC5JtcK9M/d5U+9beBfWt4nbAejj
 sEYXV4vMtKDObj1kkEwZ5H1fsNicEGmpnRxPmx9jyaEjOEIaywylRLlvmErPHcrdwZOj
 3J/7uMjapN12yZK/NQ1U6O8F6Q4vaV3ZkaL5Vf/MVCu/QtU4w0sVOejlxDCi/IdL6MCF
 UASQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz12N/t/XgIouYLvEQZ9fUhs4740SaIHAOjL9Aqxpc/Or1S5ScXjwpdR5mpb3l79JsXQcCnmbMGCxnM@nongnu.org
X-Gm-Message-State: AFq9FYIgS8d7fY1dyc4jBa8CE+a6THMUe58WEVEeOF8UvWpyBNOiK0h+
 qEaeT8klbD+hueIgXH47IbmzgctQFifWKvqgLhVAgCyukLXJqE/OLGY0PzdlFFqTcAp2Ni97MOq
 FgQnR6BOlAzCYKvnNLpF63RTX4xIm0HrNnsN9HsA0sD7lhxsBTnMJ/ANYZg==
X-Gm-Gg: AYBFou0mtYWIwdu/asFNF4ymU49zuiSHR/NaPdbY/ppznqseJTJuSs45QeIDTrz51GL
 UXXgZYjHRpphmBPyzsN3s+55yFp4ah8p2L94H51YuR/qss5uCNJykxYq2ZmL0rdu2O7O1YeE6+6
 ks601IcIldQEQHjOM/oYJdSixadakEYIx4V4HvPt0ZBzrhduMp6icnkFoaIpU1szipQwGndfcrs
 yGrjoYAfoHGwHBhRMHMdHLcB9xSVkR/iGxKQ8ieKGO4OIKkYoPt/VgCXqdr/bJJaRDARVg0JJKW
 imH2iPHcosu2iw07V5rRCRxEsXHFB2Z7beBq6r5I7/MI1YTlMWeqOEet1p0fch2CCRaP9tuk5hO
 3pRm8cair1KC3toW9j5cSbzUF07wUTKLa61DAVSbL3xF29yTUo86GK3dQnbFtJxwEyeUSgwKCYS
 fdJ+vmIhYljDd+BY3xGGmLRa1hBxVkCzv4nzal4omTKPDrCw+LwhhU
X-Received: by 2002:a05:6214:40f:b0:91c:5f4b:d2d7 with SMTP id
 6a1803df08f44-91ca4b6d8eamr9779316d6.47.1793319980050; 
 Thu, 29 Oct 2026 17:26:20 -0700 (PDT)
X-Received: by 2002:a05:6214:40f:b0:91c:5f4b:d2d7 with SMTP id
 6a1803df08f44-91ca4b6d8eamr9778886d6.47.1793319979449; 
 Thu, 29 Oct 2026 17:26:19 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7f401f5sm332996d6.19.2026.10.29.17.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:26:18 -0700 (PDT)
Message-ID: <4ab05d09-1c35-4fd7-9e84-8f7b97057685@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:26:16 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] target/hexagon: add HLX packet slot and resource
 checks
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-13-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-13-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX0bC2XrTaUaUu
 4y6qH/oKNNBOYuHf2Ao4KCKXVAnfvSRY486WcDThAudVGK7UawKT8xNOjrZtM+yfuyrN06GiwdJ
 1/cXg7K1Qrr2LshZG9xg0SOGv7dF2PYidOhgpQp+mFUm6DNYk9EP5qxkMwehvA76Awa8ilZQNnH
 vyhVkSiB2DosQJxYaZv85omf2aIAncIPLIAUxySmlxC7YAG/HuLCh2L6pRLjg70DB+iP0PMUNpk
 bSNhoXqu2X5avzoP3xTNpHRv8iycWVAdd/gULxf9Dl0GJa54y7bJcj7sJiLroSzP6YXqokLhAly
 W0upaaDeDOL43woWKiaQFintf5L7arSInoDBhiI/fJZrB0kJ/rNfycLsxTWEqgFyUVTCGLV3dFL
 6Q4DBq2u8jcjK2kLMpTuHMvv3YxF7zVIlSVqC2R8w8yHVIxvAgHHzpXDeGhTYCUFgJyNNRBHeXg
 vCvqrGop1lkb9uKLX9Q==
X-Proofpoint-GUID: rr8B4xOU8hY4bIxiQLzkUwFjKxVfzqBw
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae3e42d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=vAVFwSlfQmMQzj924bcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: rr8B4xOU8hY4bIxiQLzkUwFjKxVfzqBw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMSBTYWx0ZWRfX6pBrPCtJz4+6
 Ag6jmcfWpGM6T+Gec4tTu0NU2+bCpQGR4CaYA52D3Fd2CnRnX/6IllYUFSFJnHJ/MzWzRVkrJ7n
 Tv90mjFWaXdEtjxaII5nRHAkvnnTd5w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300001
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Add HLX slot rules and reject packets that reuse an HLX resource.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/hlx/decode_ext_hlx.c | 117 ++++++++++++++++++++++++++++
>   target/hexagon/hlx/decode_ext_hlx.h |  14 ++++
>   target/hexagon/meson.build          |   1 +
>   3 files changed, 132 insertions(+)
>   create mode 100644 target/hexagon/hlx/decode_ext_hlx.c
>   create mode 100644 target/hexagon/hlx/decode_ext_hlx.h

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

> diff --git a/target/hexagon/hlx/decode_ext_hlx.c b/target/hexagon/hlx/decode_ext_hlx.c
> new file mode 100644
> index 0000000000..cb7fc58d7d
> --- /dev/null
> +++ b/target/hexagon/hlx/decode_ext_hlx.c
> @@ -0,0 +1,117 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "decode.h"
> +#include "opcodes.h"
> +#include "insn.h"
> +#include "iclass.h"
> +#include "hlx/hlx.h"
> +#include "hlx/decode_ext_hlx.h"
> +
> +typedef struct {
> +    bool store;
> +    bool load;
> +    bool shift;
> +    bool mpy;
> +} hlx_pkt_resources_t;
> +
> +static bool check_hlx_slot_constraints(Packet *pkt, int slot, int insn_idx,
> +                                       hlx_pkt_resources_t *resources)
> +{
> +    int opcode = pkt->insn[insn_idx].opcode;
> +
> +    if (slot == 0) {
> +        if (!GET_ATTRIB(opcode, A_STORE)) {
> +            return false;
> +        }
> +        if (resources->store) {
> +            return false;
> +        }
> +        resources->store = true;
> +    } else if (slot == 1) {
> +        if (!GET_ATTRIB(opcode, A_LOAD)) {
> +            return false;
> +        }
> +        if (resources->load) {
> +            return false;
> +        }
> +        resources->load = true;
> +    } else if (slot == 2) {
> +        if (!GET_ATTRIB(opcode, A_HLX_SHIFT) &&
> +            !GET_ATTRIB(opcode, A_HLX_COMMON_ALU)) {
> +            return false;
> +        }
> +        if (resources->shift) {
> +            return false;
> +        }
> +        resources->shift = true;
> +    } else if (slot == 3) {
> +        if (!GET_ATTRIB(opcode, A_HLX_MPY) &&
> +            !GET_ATTRIB(opcode, A_HLX_COMMON_ALU)) {
> +            return false;
> +        }
> +        if (resources->mpy) {
> +            return false;
> +        }
> +        resources->mpy = true;
> +    }
> +
> +    return true;
> +}
> +
> +bool hlx_ext_decode_checks(Packet *pkt, bool disas_only)
> +{
> +    hlx_pkt_resources_t resources = {
> +        .store = false,
> +        .load = false,
> +        .shift = false,
> +        .mpy = false
> +    };
> +
> +    /* Slots are assigned only for execution. */
> +    if (disas_only) {
> +        return true;
> +    }
> +
> +    for (int i = 0; i < pkt->num_insns; i++) {
> +        if (GET_ATTRIB(pkt->insn[i].opcode, A_HLX) &&
> +            !check_hlx_slot_constraints(pkt, pkt->insn[i].slot, i,
> +                                        &resources)) {
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
> +SlotMask hlx_ext_decode_find_iclass_slots(int opcode)
> +{
> +    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT0ONLY) ||
> +        GET_ATTRIB(opcode, A_STORE)) {
> +        return SLOTS_0;
> +    }
> +    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT1ONLY) ||
> +        GET_ATTRIB(opcode, A_LOAD)) {
> +        return SLOTS_1;
> +    }
> +    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT2ONLY) ||
> +        GET_ATTRIB(opcode, A_HLX_SHIFT)) {
> +        return SLOTS_2;
> +    }
> +    if (GET_ATTRIB(opcode, A_RESTRICT_SLOT3ONLY) ||
> +        GET_ATTRIB(opcode, A_HLX_MPY)) {
> +        return SLOTS_3;
> +    }
> +    if (GET_ATTRIB(opcode, A_HLX_COMMON_ALU) ||
> +        GET_ATTRIB(opcode, A_HLX_SLOT23)) {
> +        return SLOTS_23;
> +    }
> +    if (GET_ATTRIB(opcode, A_HLX_ANY_RESOURCE)) {
> +        return SLOTS_0123;
> +    }
> +
> +    g_assert_not_reached();
> +    return SLOTS_0123;
> +}
> diff --git a/target/hexagon/hlx/decode_ext_hlx.h b/target/hexagon/hlx/decode_ext_hlx.h
> new file mode 100644
> index 0000000000..7feecff6c1
> --- /dev/null
> +++ b/target/hexagon/hlx/decode_ext_hlx.h
> @@ -0,0 +1,14 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_DECODE_EXT_HLX_H
> +#define HEXAGON_DECODE_EXT_HLX_H
> +
> +#include "insn.h"
> +
> +bool hlx_ext_decode_checks(Packet *pkt, bool disas_only);
> +SlotMask hlx_ext_decode_find_iclass_slots(int opcode);
> +
> +#endif /* HEXAGON_DECODE_EXT_HLX_H */
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index fd4983343d..f9e820286e 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -265,6 +265,7 @@ hexagon_ss.add(files(
>       'mmvec/system_ext_mmvec.c',
>       'mmvec/hvx_ieee_fp.c',
>       'mmvec/hvx_qfloat.c',
> +    'hlx/decode_ext_hlx.c',
>       'hlx_helper.c',
>       'hlx_gvec_tables.c',
>   ))

