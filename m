Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12527C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqg4-0008HF-DB; Sun, 27 Sep 2026 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqg1-0008Dd-OZ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:20:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqg0-0000AG-8L
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:20:29 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68RAC1q83506648
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bwtry498YHeZsRovxAraBCM84oYlbKbTHhVNARyggbc=; b=VyUtZIQELrDLl6bV
 Brt+7uG+Ef6lXWWULznT7fsqxvA4q83V0IRSO8DK24IZdFmI6NWluPmeuR+MU2Ap
 H/bOan7ZjHQJfnPS4HApT9R7EAn2zCTVVzX3LKna7k6J/eCnsoz8c6w/c/jqoA9n
 ggi8jd2H/39U1HdTBMqsEzd7bx2UV4ra11h6l0QOkux38cra/f029vPJSv/VPONv
 T2HnEPjA72soquH50WYhaSecgwRzIrhOO7GOuSJeDVEfpzwvwY89JrJeuyG+hDwK
 Ia0xRRwXOFXtHn+m+Eeauq23bPpg0srvU4iYwZLrruIywNW2iFkW+klwhvxgj3ji
 6aDgaw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfug7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:20:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so592106585a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790522425; x=1791127225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bwtry498YHeZsRovxAraBCM84oYlbKbTHhVNARyggbc=;
 b=P4h1er/IT7vD+ODjc47jCyvxrXN7mrSiM7yYuNQjTHMVzPHrTfMfI4/BUv8dgwn5p+
 vmcpInGcDQP79BhjsMAX5CmuaqUD7mc9Q8XSDKaD5dlDcQmwHEW39Zns9QjmSenBW2Yg
 ppIUu+cJtJ61XgKnjqLuGJG91CDm34LOv2xVhEW7mfVF5W0DP0bFKpJDsb+gx3ck/sd9
 9mwoSCgFFG/Kxh0R9jItthp3DD+st8SrBO3EBAeGX3poiWu8kEyYbhUvPB9RNhvNxQpi
 zs/hGBN4FnxkuAfN6LuWXvmV0DjGo0WobyfSAXyCIK1Jw18TTTJik+3vBCgJtx7XkEDO
 Ce4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522425; x=1791127225;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bwtry498YHeZsRovxAraBCM84oYlbKbTHhVNARyggbc=;
 b=WV0j6ijHBa9xJnLsAh703Gw/WFNr9YqjLjrPhfkDAJ8T319jkrCDQ30SN9HsTTfgmj
 o2TQAPc77Wxj3I1SkXrcudNkQHsLZ1Wblb5rGH7iczat2CqEFp/OIaA5CFgPra63apWl
 zpnIYdyUaf5sJhpVTXz7u16X5OXUftyRQyreMXB20vP/rJ2NKJodbG9afCfI2dsucsOE
 a0ZY856gjgTpMhImIscQoeVhONsmqbkSO2PB7mA2SSPymusTI18WBYmZH5NsfmN1oZzV
 3WAwAonsYUpZ9wAEw00OenQT2fMfB0TFXUfTn8zJtWb+BpjmLvAdmffUvc4SIu8wMfxu
 8/jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9tzcPh39dBWrkL4h0UEV+br0ib472LvN/zCMsRgflx1q10eiYYRRPGGwx2SFBuufVUfHw7Ke740F7@nongnu.org
X-Gm-Message-State: AFuF++k+hXqBwRbmycxfEy0xEMdTsyL55nffPqBbrrtFwOOnVh1MjmJ2
 FG0ukCbyUpVz/Gr6E5jRn0/a70sTQ/Eqs2oETSX8fSiyXAoj4Eb/QxAtWhHtbA5IxETEyA63S20
 4t+Tpubl4RLC9VgQr3iXitnSgRPTsQurTw92Evz0b6J+iGzLfrdCrkLQn4A==
X-Gm-Gg: AYBFou1L5StWmLQRGfgagY5XeCzdyL0bNpXI7OAoLVPSJxbNSXuUOzbsPTsVOy6svMm
 24Qb4RXXFd1AVtUxFvgMIPx3XfBzhes4fy9TrJ40JnnrpE2/uw5XHF4cYTVoOL2Ib/UKmXTCHGx
 WjOhIlEsxHa7VZIVFwnaAkK5yVGtBmvA5G3R49Y/mlm/gzncUqoTFSZBXI4XunDaln3kwX7Eo9Q
 mA6DuZ/BYgZQyrLglK5vKAqhZ621O7yzTJzrfx4IlIF6rHgUcXpDy6ZUmFPXKgbikN1WlH3ZE16
 hbvqzuU9vn6UVjhoQc8+e57x7ZIayWTDqDEKLj2jzwE/4NNKB2ulUqXD5QMOC0fd5gRaIEqM0SC
 nt3/G+Xd6N0YIPGKSHugvefOHtYBX89PgJg==
X-Received: by 2002:a05:620a:6887:b0:93b:c58c:d3be with SMTP id
 af79cd13be357-93c43d7be0amr1568533785a.37.1790522425160; 
 Sun, 27 Sep 2026 08:20:25 -0700 (PDT)
X-Received: by 2002:a05:620a:6887:b0:93b:c58c:d3be with SMTP id
 af79cd13be357-93c43d7be0amr1568526685a.37.1790522424612; 
 Sun, 27 Sep 2026 08:20:24 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a84205esm20644557f8f.37.2026.09.27.08.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:20:24 -0700 (PDT)
Message-ID: <ba766d57-9617-4064-82f2-a353652133e4@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 011/101] tcg: Generic expansion of tcg_gen_discard_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-12-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX85c+DQoO44I7
 FLB3ugunvzDXLgFt1ilWUJstP4mB+qWqP784eJCaH2UavjittxDcxdaBP81cjJ990JMbWDOPLDk
 IhRsqhb/6PHRF2NnwVk1dh1r5oq/DH4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX2PTErHGmFvwu
 EejDSlDOzdozAReRfFSC48p4RfnIVKP2FOhix1YU0rBIr4MxHL9aAKeseDKJaiV+U8WP+hKt6pv
 efzo//BW+TYVNV7C5oLdanioR3EsJm8h7G/GR8/8DeF8mjprLvHuiyZnvqV56dAlcr2i2715KxS
 D/K4zrqzPB9nvfqKZrh5qf/oFumtCSRhNOC5JNRx5QH2Nakgdfs48b4vRl8YU/zR4KReqrtQ0V7
 DgPtLoKhHArJSqJAc24j3FrQ1QCN1u0pO5/+TSe5O6JDEsd3WU8sltcnafo1DxNkzpj1fd33YhC
 5INrjfePVzvup9SVTnRZQa74ExKCo8I+MviqfaP4KCC6FbT4N+z/3Dy27nMJb1Di0E0e84ftdCO
 L7pbduPSwjDIZXQq8Eu6/Q/8+FFuVQustbwpKJJqFdknYscgHtoGu7wyqhMdf8YvpdHWMsP4W9b
 U54vu6O1pQUm75cQA1g==
X-Proofpoint-GUID: 3mXDpzilEio1ap2OPZ5CZDjM27wKgubM
X-Proofpoint-ORIG-GUID: 3mXDpzilEio1ap2OPZ5CZDjM27wKgubM
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab9343a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  6 +++---
>   tcg/tcg-internal.h           |  3 +++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>   4 files changed, 17 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

