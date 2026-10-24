Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F8606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wfkg5h4X;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=btIe8wbT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKf8S-0000Kf-0r; Sat, 24 Oct 2026 13:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKf8N-0000KG-B9
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:02:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKf8L-0005Lr-T3
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:02:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0C1W2371066
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q7MH6OwiNH8N6TXYXcRsIxsAbpnXn4ygZuaFAdAir6E=; b=Wfkg5h4XdzYArrUA
 wQudJ8sNSxdrrre7nBmQ3blpEPc3QjYvEI39N1WVxDnUGnQCbvnFsq7qUkacCZfR
 ze8nykRpQNGFLLHi+gZpKFMkQonydpboEiBS7ZlCiv1FG8+aREJJCyLR9WmP7Eeh
 HibHZSxEmi8DariY2LCMiR5Ic8MQV/PhNKrhzmFUylbpPPxKTz6IKhGWZE12q/Sx
 vxu55kxzT5WgE0iDjl9dojnj1L0jv3baLJTitA/ww1Fr66D/Z1BcarC7ggj/soxY
 UKAqgaq2bc2F8mGowaQjEM5MbObWcH3NRdReiuWZcG5FtZviQ6gtIQSsvTiAxQdI
 ouMl6Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6hh8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:02:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb93c874bso536846585a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792861336; x=1793466136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q7MH6OwiNH8N6TXYXcRsIxsAbpnXn4ygZuaFAdAir6E=;
 b=btIe8wbTs2wJkAp6CuSjZG8IAKBmbi+O12LNAotFjlWQi6D3YJ2k+KxpqmlKzb2ywz
 VLMfFvMYI+B61H0hSVnxcXAioIwZfi3ZWR/FTa/TYe+rpfxkyzuIV4ZUDU3WdME6POfP
 U2sMXfm/O0EvkykXlIVjrWVbeRmnSn7V6muj4TraJsirBDonKUGhD2ifSgZm1l+Kj61K
 rVJRnztoQdGClm8eRRda/52in0u5wBdKo0Y47O2pvKN1loX79L0+J/3p3xbqUCcb/8os
 DS5TBJ5lwwp+at1BhilgJk/diA/4gVfR+lDfTqyTUG5KEX8TMUZHkLqU/UAvKto3arY1
 4DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792861336; x=1793466136;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q7MH6OwiNH8N6TXYXcRsIxsAbpnXn4ygZuaFAdAir6E=;
 b=GgZVeB7fQIoGkwsBBsjNslj3kzSbC4DC/b69OGJheoXeCM1g7RtP7debLXjgw4X+Dy
 9FnTC+Y74JqRe/I+ofmuMw3wQhZAzE8BpWE/qoJ6KHzsocCUAmnpBnCWFjXgxb71nutq
 kwROk+R8H1EnoWyVM+3Lh2PDk+V5WJzK9DW4QWA9s1IuqAb5jHFpPoHspiU+JtQkM7jT
 cS7Gah8mC9+yxcYfZ7umoKWyn7TRUn6cg8eIiqIJ+Rs8BKa7qVS2myzrIrDv2Nd32zmZ
 nXml5uNgA8wzuPfTuQoC6AElgHmrMOgOcA6uRKgCMGh9gARX+USsKBqEGnuGJ8LQc+qz
 3P3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzZbUGR/Azmz9glLgYkLZ5Yex19gky7wnfIJj5idfd/OyAhFIePnx8nfT27KqG2xpksN8d7mf3arlY@nongnu.org
X-Gm-Message-State: AFq9FYLCEvX9wlnQaPDXGYMTQHprvAfDHdW5WZnr4azQq2jjSrJQuUx1
 5hzRHYEDOI1w1M7qgypoXz0MZlqd1HkaVRuKipDM5eFUUfVLiGySGx2FcfyhRcfLBGrde/cSE+Z
 iUh9xuPCI9jwT9C2+Hwi2hJRgXn7+8ZrmYrs7+bsXnlYtQ8ZP8ZFJLyDs1JI6VJTX0Uza
X-Gm-Gg: AYBFou3Xw5MaVfc2kPe/to/U2tTd5EVv8zWGGhYEb5nvDGDSobZkNENR3RP1cNcnM3K
 wV9uAONPFS+ennmqiH+c8fXvcFrBCejxJLRT5vuJY27DQKCiF4SanEMOQuz9O6ewwzevRrtFK0+
 l76j/S7BAvKxxCra7T+na5Egd+3qifdYo+rUjj8xjQRCU9aUfSbFxZYhmqH3RkXwN0VAwCGVdkg
 nkRgdyvT8Cj1MQi6ACU1557+IgMeJtsjqXUSMW93MW9As/VAd4xxZmQajYEfFS/3Ip4hw2Opgka
 8OE/AgHjeRQqHbHiUNxbclFX8doAKtbXyCI7ZbwwBtCDULbu0OExXiNATlPIn7LcrvDSPm8o6Sh
 SASfURQ/en77fjOEY7YuuyXeq8DcGdkD8xA==
X-Received: by 2002:a05:620a:2b4e:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-940ef94271cmr294762485a.17.1792861335829; 
 Sat, 24 Oct 2026 10:02:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4e:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-940ef94271cmr294756985a.17.1792861335365; 
 Sat, 24 Oct 2026 10:02:15 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48e0sm5639163f8f.38.2026.10.24.10.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 10:02:14 -0700 (PDT)
Message-ID: <caaa3901-512c-4c31-8271-e6ec78074f5c@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 19:02:13 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] target/sparc: define crypto helpers using HELPER
 macro
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261024163249.77855-1-pierrick.bouvier@oss.qualcomm.com>
 <20261024163249.77855-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261024163249.77855-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hMX9IVDChts7ACE0Qp3ejAcLx9QASsxd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NyBTYWx0ZWRfXxP4I8Z5p68xE
 eFyd0xx6GrxU2/ofuwBdskN81HHdP5v5cXSxzbm276y3J1gCXA15s+DGfa6gKdIIWrxpYAcX/xK
 O4GlF6mTxCym9PoLpv5OeVAiAoqGYvA=
X-Proofpoint-GUID: hMX9IVDChts7ACE0Qp3ejAcLx9QASsxd
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adce498 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=x3FjeYVE26gChCL2jT8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NyBTYWx0ZWRfX9ikWw6v9ew00
 nrZBg13VqcjVFn/jTRvgb1sxRZq3imFnenYcUGm8ZLEZHhB0udSXJJ43IVpiYESx+w6etTyp7IW
 ZlZikxFilbszWbpb9tW5Lw8K80gsoBYVPgwTnYDC9wpUqTS1R89xkTatSpl77wB55qYYjB17xOy
 CC75K5Ewmq9kFAOclN8upmTkJuwjdZ1owwDEPeCg6+EQgwPpWwH5lOOjnrPKZ8vR9Rjp/uaCFg0
 XwByLkUwO0bzM+0059k3kWDyechuDccndGTzJsgu8F/91AeBKq+cU2dju7JUKsMYOSTgaQXELej
 MLpHyt/jLxMcGy+XP8DS7LRiUy4NnY5snlohNSJjKOxv34VoWh0mxCou0P8aUdWpJ4MTLJppYkZ
 hSJPRGEAxhCmsjLmhoJJp7jGZdItOJJsgR8IHH+glXhQx+Q0BmrymwrKaLrSNNPW1M0a/GNBbZ2
 2zTsNVpy4PdhrQM4Ydg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240067
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

On 24/10/26 18:32, Pierrick Bouvier wrote:
> Crypto helpers were added after the conversion of target/sparc to the
> HELPER macro. Convert them too, before helpers get prefixed with target
> base architecture.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/sparc/crypto_helper.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

