Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2944DC5518F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqpm1-0005Gz-VB; Mon, 03 Aug 2026 06:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqpm0-0005Gj-HL
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:19:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqplz-00088B-1p
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 06:19:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6736SxgA3759351
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 10:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nxPo2BuaXVzqaB9vO3VO3O4kRVmkDfvQcuockQ/hQK0=; b=cv3N9EGfSQxXjMZN
 Yh0XTRZweydcja2GjNoOGMFM4w66shPd4LqXh4iqzgjRgzKx28RlI6dxggAJLo1P
 JkJS1frlQYzhezS+gVkeBqoV0jfugphJzrvPCKN8A+plR4MiPPY4dZZE6lyhe5/7
 ME/Wz4OLFCl7xhQvaucRZ+uqgWbVQgRWMfXbQnMQOHCXkFIsQ8xyBM0dANvv68Qh
 PIdd6p+1vuVjoO76mUK0KTmPFXUiMvaAJDwrXDgi1hy2TL6Ks5Rsv8o09cU6iisn
 cgmLMBnMkSJz0wKEAA4OnX7nv7BTBtoXT5cN2idatl9bif4zjkwJoEu2sAtd/dXm
 gbSGEA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrns08r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 10:19:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso57919481cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785752392; x=1786357192; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nxPo2BuaXVzqaB9vO3VO3O4kRVmkDfvQcuockQ/hQK0=;
 b=iXsF076tqGaRmy6l4WqNDD8np5T0Byp+RcVgsM/YZ4VHl+Jg4CT/S8TojR16kdVtTv
 1J4oS6rH3wlI/LM2zQDBVqAh3RZt/x9l7lnxLPUgjbVVvSLnuUxiqaMmZpUvSGbgzv05
 91FGviiOc62ePoOS9+h002coN/MJzNC3fpofiWbJmOeC4Ard5/EpARXY3Sfqu7KtHpKA
 2QiwkL2kxK/iErI1Re6GNJmnvfT4qtsRDQY5rQvkSslA4JJWOEMTQRL7RSo25A10esDr
 JO9dryyUMDm1WCdgIveTpzxM1dUJzAA9nYUNpSlj2hCVdPMJ2SmwHQKBBoW3JqGRGoXk
 ukzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785752392; x=1786357192;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nxPo2BuaXVzqaB9vO3VO3O4kRVmkDfvQcuockQ/hQK0=;
 b=WziRL70B7RN1ooLKL4bglPalz7fC4a2WW+ttJ/iHa/QaQH0Npj0CaUq2SoHerIvXok
 06lYnmu7hrrZH9J3Fm/A1FaCRxEXK6at+QN/r755DdfYwoIliranB1uSj6Ev+tBNXPwB
 4qClWIKyhyutww21rzeEdlf+MeGTCFKxmhHq2K1ljpWecKcVCNx0VWxtme3W5cC9LSh1
 wVBH77ss1I3rUZGMHmVqPiciOjE1KSyDNEOcSNTGyGJwVe+/Pt7Av3DNHPeGf4xjoPhS
 TkHpcAbvYL6lZU8gd88BldFbVMLNzrYJqNAHMO+Gz3ffEqfUl9GohrqlQJKuoqC2GG7L
 Zfug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4pMYiyGK6xYqKTcUrTFaN8AAeZPoLqMRkE/fTdOyNhmBQAA4RmNJpKW+H+cFrOw340+kSiDnrRTfn@nongnu.org
X-Gm-Message-State: AOJu0YxmPtfeZoad5YeaA8TqAlI0Nj4OhBKWz8sJpp5bgcVKMP7sZb6S
 5km75++CoF+jFe8jUrDLW+ZpO2t6vgkD8ViFoEu8aT8ETVa4g+/8wxUc6RoDD0U6bBQPOnW9eXP
 GnXM6JBzUDaoqXFyKngQ5LeMzAzGHKZOIsYX2c/0P0/i1dm42Xp98ZBcQ5w==
X-Gm-Gg: AR+sD114lmoLYp8lpeCtWz5gWW1g1sLtK0ZX1rl5/kxPxuJzVBlnL9COGxRBgvifRqc
 aBPFIfZosyTYZ8nIlzCBFUfAdzp4MwX3F5H3btQuG6RV3tT5uv0jLApMWkXBF9/gixpFmXyBuZ0
 koVLlKdOZNSDrWe88UTu8p6UOd61LeCLwbmnRqPgrOEQfcDoOncaMmnS9Aa7+Gq2CsBmZ6DbYYm
 SSpNrWkHhItJj1pAbRF5H1+jv63L3tKc41cWNMS2prP5Th7Z9K0LgLb4RLa132LCYAp779Aklnn
 x1g6RHp/ekG5T6lOikCE6gjnS3398rVyf93DM9EgPK7qElVkYDiM3s1qa1Kj+Ay+Ib6c+Mr04HT
 sA6cKGAKlerjYT9K6JTeX83fN3uhTGWMB3LjaPR/0f1hfElEp7FI=
X-Received: by 2002:a05:622a:1353:b0:526:d595:c7fa with SMTP id
 d75a77b69052e-52b56791b0emr186753621cf.31.1785752392221; 
 Mon, 03 Aug 2026 03:19:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:526:d595:c7fa with SMTP id
 d75a77b69052e-52b56791b0emr186753281cf.31.1785752391682; 
 Mon, 03 Aug 2026 03:19:51 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4068fb7sm32821457f8f.0.2026.08.03.03.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 03:19:51 -0700 (PDT)
Message-ID: <e4f816ba-1f3a-48f2-8018-7bb38cb5914a@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 12:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] scripts/qapi: pull c_name and lstrip from
 camel_to_upper to caller
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-4-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724130044.1369843-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX6wIiS7RnjDbb
 s1NAEeWLnisM8pzEhc/vTaknWsv3xQc7vIAnlBzHXMKKzGMjqkmcn/qBkhN/BwTP7/c31BQvYGE
 0WMOklPt4ZL6xlrcdi43wgl7L1FphyI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX5v9tJCTlwDLX
 HPpa8D3sfLxwkmUQR5LiXXsBliW/8kVa6KcFdJFH8WaFOFgDa6jxmEq78S8911xFamtt/m2laCX
 X3Y7tz6l1WfMXBcVjBYWkZ9FotE89ZuLrC9PDUMnqQMnzzoJAHQgNWzO8V0BQiXvZSfkeMtEmjK
 XbHo/WJPJQD5l2d9dnlFx7rGicfCprpPMAxDKEb4B2sqQSE2Wr4LhEYHGmYyJZUn7az2YTykI5m
 tmYAWYhPjNFCpy4qk9Db2I+Xl+7wvryx+sKftj1QzexdIqvzHQkhJX5lIjE8z6l5tz9xDyIbqh1
 eAM1DFB59/WCKKyf6z4Bmi5HkQNrFX5scTGfoM7plM8wzz8R51mfeNiCwvghJZlq7cQwuM6W7SB
 gxa/29zQdC3o+J4UWX57vmimPb3hgBZufeiKnybYqZmTvS+IZ990KhGQ8drBYdiMg25X0lqI+qs
 2SR+/p0TtKc8eN5fh3g==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a706b49 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: PQPvYGnbAUoPvfOuwB-3azfDrbfkTM-_
X-Proofpoint-ORIG-GUID: PQPvYGnbAUoPvfOuwB-3azfDrbfkTM-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030092
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

On 24/7/26 15:00, Paolo Bonzini wrote:
> Allow using camel_to_upper for other languages too.
> 
> In particular, the lstrip() is needed to avoid reserved C identifiers,
> for example:
> 
>      typedef enum __org_qemu_x_Enum {
>          __ORG_QEMU_X_ENUM___ORG_QEMU_X_VALUE,
>          __ORG_QEMU_X_ENUM__MAX,
>      } __org_qemu_x_Enum;
> 
> Insulate Rust from this, since underscores have a different meaning
> in Rust (though only for the sake of warnings).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   scripts/qapi/common.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

