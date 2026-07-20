Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBBBC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljU4-0002jP-8V; Mon, 20 Jul 2026 04:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljTf-0002hK-Hl
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:35:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wljTc-0002sI-9z
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:35:53 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7YEfp2043814
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EoSPOA+ZJNMwVNUGh69obVgrg11VnI1X24eVgPMkaX4=; b=j0SmpGS6p5E+hHi1
 LXfY50kDpSAz+ju6E8Uvgr86P0mXp7C2RLrl6YtDPhftveY4W7z68pmtVn30vR6y
 riV2m9I8z4sUGygHuHIBHIDMfNMQjFO32I6CxvJ1Yo+bdwPejgGrozM9JtN1lMOJ
 ptgiKaFBdeHZeiy5TqZOwrqzllV8B2ginWmP/qmo9SmoFE4CUK4zYkYxC1vFOenm
 QeKdBMZA4CwGCZypEqR0zBsQgyBHAGTbASHMzcQ6N1LJVphtkO/oemqf198DjDe4
 zkcJSYV0QZB0OacN0FPLZw7FvbuOx8KA+qYigYIU/XLN6a2R3NLOQOKRM/INjSQm
 9ZOp8g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcg7ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:35:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso189717541cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784536549; x=1785141349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EoSPOA+ZJNMwVNUGh69obVgrg11VnI1X24eVgPMkaX4=;
 b=FkK7VOa4n7O/VRxZCAvLZv8Ts4OBhlLFeV2p4qlWlObdgIHGV0godVavyAHg0KSbXu
 ddxuxkcAbxwsE1VnWuPaBJAFztUp1p165diQJO530wk48Q9WZtTPfhwKoLh9QjC0Bvd6
 Elelhy4pcYz9P/Yf49RRYzHkVpM2+95ncC0/7YL4t2mvV07fkgrBKiVXpZoWl+1nx5qH
 v882/fUYtb5mw5sNZPryWYon5nuEL1/XGisWIaaiDx5lGVX9l0MGdBfe0zSLDAMoEhsp
 POzZB4ZnitnIvVEcOj6nbNPKtrmgka4yeBVK60DWoARgIaa9bOJYjWGJ116mZF0MTK7X
 U9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536549; x=1785141349;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EoSPOA+ZJNMwVNUGh69obVgrg11VnI1X24eVgPMkaX4=;
 b=X4gyAkcRIWmV63fDz66PYAzF+enWKUAli78DJNJ5+NZy5lF/L7g8gGvU4CVfNL5jAV
 2MTkJdL1SKbxLpm5EqaZasmX0c+mjUcQ8JochEzsQZTQQYNu+pj2MyuHtA83xJJOLSEb
 Atqk8Bk4C+luiuRRncqY/QXrsnPX7UrA6pS3/sh3eDLMkkCevPsIiEHqHImftB8GmPWw
 YYmfJSJ559O73/35iVO0YqgB2c6CIBMREuf9PgVoPGcmVuL4XoRlHM91Fmvv3gP9SgWB
 gn/5znayyJZ7NaFAPDrBP+0QGCknbACCDkhfi9EkYSHQNOUYoSC6IGb3fem6fMjSbb3N
 L3Sg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMFpdmP7dX4viYIhGvd9LbbGKQJeuF9fBg5EXXWUdtrpr6UhUsPjz1A5oUx/Tj9F1/DjeC5EbaU0Gv@nongnu.org
X-Gm-Message-State: AOJu0YxgvohW9StefWCq/nRl77NrOUovyWmFzczXKqjgd6/s1vTOpzzU
 yQn7iskTkfIQorgN5Td/6zW7XAxR/IwkpstVCtrRidKJJ8uq0eq6Fz20S+njnvzFYP3sIb/HJtK
 A2xBYvd79eivc1TItNulNfgFjk+AkCTHS417/xO2i6FU0eNf7qpc2SYfwr6fLT65zdQ==
X-Gm-Gg: AfdE7cnFPd9hHFbGSRVoXIeI6vzgexQDpwTWNTkAWO+2LvvXkEmkHLgpinGyrKg+UJX
 3QYh83biimZsbMC7MYULe0CR/8Y30NvZGiOybBu57/erGgaJmWI+V1YJn0TM5+YFf5HDXKL7CKL
 qfMWlVnKyXMiXdD7Y6QWwwvLg+d7+Lxp5dFt0GA12SYirKrTDGbgsIAtyj+fqkruFV3U+sjaTUa
 ATiQknNCt/TXxxM8Bf39eNmF3UHtHkL+TRJXTAIZox7GNmkyYVI+AQMMR27oSV7myMGbkElRAcB
 P5/qOW8Y476xkx841Bq3cpX264rYDPlkDGURucorhhpAW0FvL6rPu3bbSEeAh79lpT/en6FWlf8
 vt4UEhLAmb/UoefT2xUpMgNZy3kbdBAtCyrcDwFNCx3Us1PAPVgc=
X-Received: by 2002:ac8:594f:0:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-5213e28e183mr129316161cf.48.1784536549627; 
 Mon, 20 Jul 2026 01:35:49 -0700 (PDT)
X-Received: by 2002:ac8:594f:0:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-5213e28e183mr129316031cf.48.1784536549218; 
 Mon, 20 Jul 2026 01:35:49 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954aa1a231sm158979545e9.1.2026.07.20.01.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:35:47 -0700 (PDT)
Message-ID: <d714d068-874f-44e1-bdc5-0529188af176@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] target/arm: Split out helpers for creating MTEDESC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260717232306.378988-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4xnLulPxtHdy4cOVJ-n_ZxaxbxW2sj1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NCBTYWx0ZWRfX70B4RX5zzoRG
 RWHMmK+D9eM1ArzXeM6JcVDpmqI5cTEWiFhxNt52bT+SwARqA3w2xcTi8yfpVSRy0tA6CS6oUx8
 Kl2WC1jZLnJJqo/TljYHpD7b7XGQh9g8ERrZk+ZAe1hFErpSICUidYOx3LbFMiqpmDcgVlUWuqZ
 mGVMJZx0opUPcTdlrRSv/vlBXWLYjyhyWi/6njXjpKlO12/9AKThBeeAsZ2VNY9Wc126OFfBg3R
 axXwWCEPz1rKgkCLT+Zir8OqRKZfjaTXgo3O4mxA0iZuxBR4wbq3v5Oq6iIV7iihM5PK0LQjSvD
 eFTxekVeIhI3svN8M5Pq/BO/1kKKtYDLjWQSJt/aaZyzjduHRoFtQH8Bafgrc4A0srOpW0q/g97
 8R5QCGODwU4oPjrPxIZDVsUS+ljV+Bf21DArc83QgY1HKlMMzaZ9Kh3BWhOX1V7QHkBB68HEmBH
 yYKPDdJEv+V+KO/hxug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NCBTYWx0ZWRfX3bZKhnNXcugM
 /8KHG7BHDmrZiYzRG1dU6Sojm5/Puxh1OA8MPr9gowAlMlk7aJnN/lTSEsgp8lKB4RKBvOoRTYX
 dojWjk66BJNC8nZmuBxBzrgjgYeIjto=
X-Proofpoint-GUID: 4xnLulPxtHdy4cOVJ-n_ZxaxbxW2sj1l
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5ddde6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ItOpnQ4zye2zdj60azcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200094
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

On 18/7/26 01:23, Richard Henderson wrote:
> Assert that align and size values fit in their fields.
> This results in more fields being filled than some
> helpers actually use, but uniformity is for the best.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 123 ++++++++++++++++-----------------
>   1 file changed, 58 insertions(+), 65 deletions(-)


> +static TCGv_i32 gen_mtedesc_xas(DisasContext *s, bool write, int idx,
> +                                unsigned align, unsigned size)
> +{
> +    int desc = 0;
> +
> +    desc = FIELD_DP32(desc, MTEDESC, MIDX, idx);
> +    desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
> +    desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
> +    desc = FIELD_DP32(desc, MTEDESC, WRITE, write);
> +    desc = FIELD_DP32(desc, MTEDESC, ALIGN, align);
> +    desc = FIELD_DP32(desc, MTEDESC, MTX, s->mtx);
> +    desc = FIELD_DP32(desc, MTEDESC, SIZEM1, size - 1);
> +
> +    assert(FIELD_EX32(desc, MTEDESC, ALIGN) == align);
> +    assert(FIELD_EX32(desc, MTEDESC, SIZEM1) == size - 1);

Why assert? This can't happen...

Otherwise, nice cleanup:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +
> +    return tcg_constant_i32(desc);
> +}

