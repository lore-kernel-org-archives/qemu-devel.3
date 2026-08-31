Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E84C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0tzt-0003Yx-3s; Mon, 31 Aug 2026 00:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tzr-0003YX-E4
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:51:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0tzp-0005le-QA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 00:51:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V1bgvm1582940
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ks6gPB38tWYNshE9M1Td2V1DgBWyE0arixbHMFZI9mY=; b=aOTjxuTmhsXYIuLf
 kyGErcXLPL93W5Yfpq5jyQgsc9hUHI03Hqw+czxsy53axoKbFuANCk9oRBlauzhG
 WRrKBM6kDdgU6ACmqGcq7hm8VxJkp+tDZgHatV490EWOu7Rw98li7hU+TLkLl0Hj
 ki8DppSenjIOSS9it5HfZXd6IGrFXDPcOM3kOO0CYLyR+zcZ2eeDh8WaAsVPgSwf
 X3bOBonJcoGDiaoKA6GgPVXBi38hJG87+UCBUpkYEagpsmNxxyWQq5jNEymDiBcA
 iNiiRJxspnQHi5P8gnubjGi7QVYlrosGamkKIeYRXyoz//vCNcmwVpcu+ng44ZlB
 fCmJ+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6mh9w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:51:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9375d92d8cdso547462185a.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788151908; x=1788756708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ks6gPB38tWYNshE9M1Td2V1DgBWyE0arixbHMFZI9mY=;
 b=cXQ3SarRK3pn8NAZRXKVmPjLDfn9AtSg9yCOkQ7OfWBnYsoIaI7yuQRGgjVYfTEvvx
 XJXibFMsew9ps0NL/fCQ88erkWofwauhtApJXopDEvjHt/dYEH9BZ7FkJV69oSd7mym9
 dlRBMAKoVG9YXtgxA1QaF5ImhQ2M+K8tziF2Zm3SL9FUQYIKUo97xomIo8yad6IkN+wM
 IJcJLy9PPvBVFUcS1kc5bo3Xw9vP7qtj9Is56Ifx+Q3pHdSsG9KaLk3JH3JmA8/884Dr
 e6nIL7kiXtEJGJ1gHlWTZ9P5jUN0ZPnEfSahHBfdM5l9xHqPCOEVHJhrfEN9BCSOTP9c
 5feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788151908; x=1788756708;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ks6gPB38tWYNshE9M1Td2V1DgBWyE0arixbHMFZI9mY=;
 b=nMnlaPQbsZkXN4Zou7zBeOEUKAMr8oq217oulCFN/UNCOvggWfElxUu2q43XQHW5Uh
 QaY5BMKfv3iV6fTJZHrftpqtCclY50IFhMGAnf9YH21qDE3UTwDfkJVxhHvCojiyf3rF
 T3hegSyCQJ/YftRMBJsdyKCJqAib7SPiMoBzSvBvWt/ecJ2wqBmNtiRIeei/5OSOQhT8
 Zhvi9/kkRVEo6Wlfbe3o6sk9TSgoQ+bj+jeMF2TjFDotpL13wQ7kyXWGt/A9Ukh/ZULf
 +WNYnGak84Fz6nv39iNCZTHO8jmrn+J2imUFq0E690SlWepJx34Qd9SILH/D4FMYobar
 OvEw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo8Iv04MAld+9IGaVMCSrkiqM5sLlHtDnAxxrpFuelTKF7EqhHmFwbhoIGxkYSS2q2CEiPCtXTqZ53@nongnu.org
X-Gm-Message-State: AFuF++nNandeljZZ5cNU6vGscGg/I4Tp7HGFbzeGQ3pEadEXXJuZpLPw
 lp7Li5RfvljMNuwUjSIjBueikTHxdOT3meE5uzi98D9/GYbG0x5zpVy+3YRJMYmrYcU3qI1NvPp
 pI6NS3VNVU/MrEtjcwJwWclZI0AQHLciIHk5F8jh9cuy5IfC53c3OwBFuLA==
X-Gm-Gg: AR+sD12Y+z6sApsd/nv+haFnxMj44QHmMkbaswnuEYpJXiy/g22r22Ip0Fw0Nkzeooz
 Guz6DfOCCK13fC2pPuZFuojndvzu53NnZHpAMXeiOZNKYU9dSKYcpDzJyS1AwZ/y2377iAat6Lc
 FHDboblE+ynGARGTqdsXXQtrG2zpnSWGKeVRxBeDHtL7WdnNKOJ43GpefEpBKX+NfvX3+a36WzV
 igzljUiw9pzz1+yGMQxuUB5GvniocuWBZvvQG5RKOtOsT0CQZZkxfREgf3KFkdlqxVz+b5g6Mze
 Cty/l0KhSltDCBvnsCa2T+UTymhyqNjBo8lyHieLCtQhoaWTQSshfs7Zlt1HATjPRrQfE6NkQUJ
 Zg2ID/JkXZ8a5D8i/OwaHZjCM6IJ6ExVRnQ==
X-Received: by 2002:a05:620a:2987:b0:939:744:b5a3 with SMTP id
 af79cd13be357-93913930089mr2590955385a.29.1788151907732; 
 Sun, 30 Aug 2026 21:51:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:939:744:b5a3 with SMTP id
 af79cd13be357-93913930089mr2590953985a.29.1788151907374; 
 Sun, 30 Aug 2026 21:51:47 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48436b69537sm9997321f8f.26.2026.08.30.21.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 21:51:46 -0700 (PDT)
Message-ID: <7878aaf7-e12c-4237-88dd-880bf4589d31@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] tcg: Add INDEX_op_lea
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828224451.1564072-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: T-VKrcJRA5QJVI0zh1lfEN7asgXAGYoQ
X-Proofpoint-GUID: T-VKrcJRA5QJVI0zh1lfEN7asgXAGYoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfXySLRSug0S/hC
 umgCs5NuTuqv0QgI26dSMawzr5Aw+AUo9JRxB/MxJtB1We+eg05r5W7eFM9R6xBfnXezh4NYPqC
 2aRCbtPoYfWTChq5tMKsVp86pL2b5IbKm4vT0MA7ly7Pv0vZcPD0dG9nqQ4gn9hMYRIYgbosG+b
 CA+94XXnbO2uT/AxqrOWs2fc7CsTeXlAWXS8hPa4zQy6z53Kh6jRnuzxL2dv16N9B8Cd5chevl8
 DmN26NG3Rbg0HYiGvuj1dGtR3kGPgn/Fjqieukr2L8Qd0KXIVXFwYo6vyibr+aYnvvsiV70d1a3
 QcPImjHtuK2K2bJvGrvQvkkm6mSJQGOjpBjWLkHFZIkFT+PS+HlE2WVdFhVHLLDRfWv9dfkNyuP
 7TBNI5RrqjUFjzJLTFUGUmIenL4lVx9LXnzoUjDUApc8ZZ/c0sJWd1liBArfySb1I//9zm43KVT
 IK67sU8PbaXABCLGN5w==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a950864 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MCBTYWx0ZWRfX21e5QGwC40Rd
 hbSHjs0+nkPR2pK+IyfHPxW+cxySRRtHdaByCelSFuNyCGPVMpc/CP4R/ejjF3leUWjbXWtTJiy
 3JUal+tRrR9N3d53PAAPvTEyWmbrz4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310040
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

On 29/8/26 00:44, Richard Henderson wrote:
> Add an opcode for compound address formation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            |  1 +
>   tcg/aarch64/tcg-target-has.h     |  3 +++
>   tcg/loongarch64/tcg-target-has.h |  3 +++
>   tcg/ppc64/tcg-target-has.h       |  3 +++
>   tcg/riscv64/tcg-target-has.h     |  3 +++
>   tcg/s390x/tcg-target-has.h       |  3 +++
>   tcg/sparc64/tcg-target-has.h     |  3 +++
>   tcg/tci/tcg-target-has.h         |  3 +++
>   tcg/x86_64/tcg-target-has.h      |  3 +++
>   tcg/tcg.c                        | 22 ++++++++++++++++++++++
>   docs/devel/tcg-ops.rst           |  4 ++++
>   tcg/aarch64/tcg-target.c.inc     |  4 ++++
>   tcg/loongarch64/tcg-target.c.inc |  4 ++++
>   tcg/ppc64/tcg-target.c.inc       |  3 +++
>   tcg/riscv64/tcg-target.c.inc     |  3 +++
>   tcg/s390x/tcg-target.c.inc       |  3 +++
>   tcg/sparc64/tcg-target.c.inc     |  3 +++
>   tcg/tci/tcg-target.c.inc         |  4 ++++
>   tcg/x86_64/tcg-target.c.inc      |  4 ++++
>   19 files changed, 79 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

