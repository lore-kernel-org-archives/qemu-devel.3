Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BC0C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqsi-0003gi-D2; Sun, 27 Sep 2026 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqsL-0003VW-6C
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:33:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqsJ-0002EN-Fg
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:33:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNI8fZ2091533
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=UTtAKWFGdXj9zVzE
 T9+S7lGk4MZ2xjhHFqUAa4BDq81c5OZ4XhCX2hUTTC7A6HHu9ROsWhFRkbIypgWW
 V6IyOn4N3dF/n4eHh4Pser09eNdSUZmDR7h+xMm4N8sDQIF7W4Q6C9Oo7QmHNysA
 QBOAf2L7yigFRIcuZS7Cmu11DUYAL0Z6PjKFHRmQrPzPdfQ3kMVBN77iyEDwUHdt
 a61ebZRzrLEaan7piEPhCb6p0n1ghK1ktpKiDymfV3lhwa8fqnmIGPzJE8ea2GSE
 LJAfHE6udKTckDW4MFtE1gxL6l2goYoMuRzD9SZgxllBK9nhGpFuAo4fMOis934K
 vqo23g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx50sbc1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:33:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso440733985a.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523188; x=1791127988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=Y5SgvXKD6RYLkASxCHOqjn9lmpx8NcmJVTL3mtu30QRxGLXK7cP1heFghwmt95vNRX
 uv+9y0sRM760z/ygVw/tTInNaCWBdIkF6B0Dt2zXoYmKdKIogT0sloqpuEW2paXX0rcc
 NhrvFzpmAvxldntJWl5HX0NVBdYH/sQiaBznCMkv00bn5yYuxaRDkA0B4P/d6e6p0rBN
 OaVdaWHo5PWnAGCtahdplsXBvwmLUeHCzeJmXwdcXlVLqfnBh6HOm4oWN4Eh8IOBKG/3
 WEX2ymgzyu4PMxGadZ6byIUDmUd5gafN8MHc7JHDQ4QvbMOcul6X4FgtayZQ3XbEc61l
 bB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523188; x=1791127988;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=mCWY72uH4DDaPWsXwy/IKdbwduxYKEg/Z+NZxWt3gI4Rdg3y6cuo/29x7h+kzD77+h
 2lYUc2JSaX+Gc92ktsdddTtTLsqiUyrofXeUD6XfZUzpYEmuHcVKlK9E/Ylw1AmUEtcq
 GR+qY8ZT6oi0YSQJPcMKu0Qllc1HUVCkQyyWfhPKp+Kf/+BtjkGpr/RRt3sdrv9qaBiq
 twkHIloCVTeXRYbEwVxddYIlZVDkJCWplQFRsy7WiVYK/wygOOBqgj4HcxPgOAn8M2V1
 EEVMP8dLis6Yev8NkZlYPeSHMEo+EuztQx/ylIxi+LvUIqnZ5LvE5vQQg49nIUMF6p3E
 zCUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2+XkuoW6eJpjMV4Ms9E/jX/5K9OvCJa0j/m9r+kU5lJ+236Ur7vvJjd+DagpR0agSs1ous0S0HPP4@nongnu.org
X-Gm-Message-State: AFuF++nPsWRbUTsrbkOc7TjO/wCVQ86kMh2B6HlVD7ZjOflx8zt8QE19
 nRU9hdVvIEzSJpxjWBklZQOrrW9Ex3HXfM1hBVN8hied6KNCzIqYPJe72kZAfZeCUcHKCJN+kMa
 wYoebbXQOI4YnyimEIq2UVtLaz6eTghxRcz419u+juJwVV7A/G3UpnhMhZLGbC7PR+g==
X-Gm-Gg: AYBFou0OppFb3dHfcyPaaeGpz3DP0JQ7cohX9A3kxLD5vTbYxz2pooOLr6XdZLe7RPQ
 mDKCQK03+BuhsHlvWBbUEVtVJi5RDpGD3Jq+MC9NHbOO4kIqR4vF1/oDJll65tofho+TIBUsaRN
 8DyzuAawe33zysJ54M7LkyK7sl82xZofRxUjUFnzwnSEeI/hGbqstx2Poq6ZoV0RjwxrXkXxOG8
 GYLW9ePHjnN54B3PZGY4koabHXzUPgqIqgB8ucYGjwhCFh8z75rkmgT4Hkvmaoewza+r7FYhNNu
 fj6ig5r2DZobuGyxwwOukpQBR4H9xxan7sF0dXP7uEome4Gc3L6sMUl+r9uSCkDUUosp9KcUbGH
 gAQvrFvOVCnAxFB+F94UKl0emK4zV0QTlxw==
X-Received: by 2002:a05:620a:3f85:b0:93b:e82b:a584 with SMTP id
 af79cd13be357-93c43ca65f3mr1614580685a.35.1790523188307; 
 Sun, 27 Sep 2026 08:33:08 -0700 (PDT)
X-Received: by 2002:a05:620a:3f85:b0:93b:e82b:a584 with SMTP id
 af79cd13be357-93c43ca65f3mr1614576385a.35.1790523187833; 
 Sun, 27 Sep 2026 08:33:07 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00179c729sm105600255e9.15.2026.09.27.08.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:33:07 -0700 (PDT)
Message-ID: <261c1627-ffe2-430c-980c-3afabc6aaa39@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 018/101] tcg: Generic expansion of tcg_gen_and_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXx6KXVoblZXvK
 Zq/cBgqtDJ1WWYACUZpKF3fUlgg/BfecI4ODBjDbLSJZcAM07AYRu4A6SAWdp8wICBwdS83e9Sd
 7IAEEhQMWC5bAkg1AjelNy7tLznKyRg=
X-Proofpoint-ORIG-GUID: Ean_DhIJLr7YJrdicarXeTSl-RNBRCSz
X-Authority-Analysis: v=2.4 cv=WuK+otfv c=1 sm=1 tr=0 ts=6ab93735 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX0GSqmL0PzzDJ
 y/WSFvXU0g5dBqLSqp3Ueh6JAUYEfFCZVoa/dXUqVJjDIf3I3X/KQ1nKDyHop9MoP2xUH05N5AU
 kOV/Bv/JfY0kWQuqBMbr7Io+BNdCGI6qoNpOxXd2xjLhtCDey/R2tbkCoXyI7GI5WmlRFAxp8rD
 +QxBiS9QV0iHqP19EzBep+0pu6Uacv7ER7nNWHjR6bVWrnBhr/mfj43pLgSXXDeYFlZ9m4LUAP6
 gAWUVwOycDjjgEJ/Md9fvFUPlxI9NrIsakaq+i1zL/zjH1HSrq78JPFaEI4pP9PuTkbHv1o13SM
 5B0wB1BbLRSArmFcSOZnmb2xIDShbP9yWC3nct9YNIu3U7YzUjIVS2TdmYAB3zNSDclCJCzlnp0
 dR00r8YoMepfLywPCMxG4w3YdzgvLeDU4Dfe1IuefcY/L7Ew896W2b+u6BxIpAAC9Fcyp/i5a/q
 rc9lZFOt3/Eywpf0AUQ==
X-Proofpoint-GUID: Ean_DhIJLr7YJrdicarXeTSl-RNBRCSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
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
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

