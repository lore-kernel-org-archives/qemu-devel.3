Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9783C5DF6A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvF7x-0005VN-Gj; Sat, 15 Aug 2026 10:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvF7u-0005V2-TH
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:12:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvF7t-0006xg-BS
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:12:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67FDMq8Y3616411
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OEjvXPDDvlrQdi9LEt0eY5+jcnjaZUT1kVhx9UrkhOA=; b=NA70zR7M7lzcgwN6
 EZ7iTnKpEyQag4CiDmeoeV3x1s242I4j3ku0HB6U/27LNW5LyhHOwLZ3ah6iu22R
 lRdFXGFKsl71AZIM93rg2AcaUQiQFcTRTg0PYbFaOPsd7EKZ6c1ZAxYcI4x2dO2S
 Wv4MvnYho04g2WXfF7yQXACI+IcY9awKfcBbUev4V6F8+oG5mhlY52TZtNGfklu9
 LtmD0sUuLt8RQjGhiU9YLUFvZ2Gn0zYsNGz/gSzEmm3eUIuv0VCluHwOibaFaM7I
 kbumTM/Br/E48Lnl9M4E8NPikRRyaA0+H3wd1jOVl+r9uK9vVrL0iPsgVrMWEhev
 AF4r6A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq14mf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 14:12:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52d827597fbso30618331cf.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786803162; x=1787407962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OEjvXPDDvlrQdi9LEt0eY5+jcnjaZUT1kVhx9UrkhOA=;
 b=G1EDr+5KnpfbkGDKexx5plP3O0FxeDFFCvLAPV70khLl2JsBLm0A98YslA4DbpTzbL
 cPEfJ2ccAL616d1SI84+8rarXkNMP30m8HrS0cjn9nYBBkDY9oCU/HjuyLhJtfE4GcUZ
 vJvcItkdZlqPNRUBXk7EQ4Gellg6EiBm4Qn2F4wl8wnynv4DW+akLOTKeaB/neo1a4fJ
 4Vbc4mq2mjhrk5snP/hBr8qiKlAIjZLzAZZeuqGtnvyL+8gGIVHwZbCeAtef2QnM7yJo
 0uvWnqipdTNaxan2HYcha8SUTx+i/xxH8/ID7CckN9Vtmt/z0MEHVCzA9wJ2rS/uhcEm
 vAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786803162; x=1787407962;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OEjvXPDDvlrQdi9LEt0eY5+jcnjaZUT1kVhx9UrkhOA=;
 b=Fm7UITBpS+5CUj53ESAxOr3g+IPZdvgtgUiLsAieDrrBkbEXFChdxomAT8LEMGIxS+
 vOAq+ApiUq+lZKhV0hDXcoLFlYTHRrEQopsF3Y7NRGGOhB6zi1gKFxGTEgHBKwJ03z3I
 alT3yyAb5TIQbutn/ucT1osU1GVAjXuZlfJXeHMHoOWKuRZ51D+HDJRAy4m7KQBDY7rB
 0v/JH0puuSH/YqgkCW7WwR49dMgJXIWLc/Qodf05HISpXahvSjNtbZgBax1qpiJ4Im26
 9g6LIpP/IDpOkHG14iLWyxIw5zBsYEjhv7yQ4In8i389/gn3g2DKnozbzs6fgisYRN+y
 mxtw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyV2fR1IPgbmxrfjS2kEQFH3ii9FN+JwPilrZIn7xVId1CFd0QhjpDxeqFTzAe1KzFmzbJ0nSBNMdt@nongnu.org
X-Gm-Message-State: AOJu0Yx6Z3AkiH7CAGtvR+V5EmtUjn8/NDriDc7LywWDsER8CzE+Auq5
 PVYrGnp6UbsmSNNC19/ASsVvl1ogmROsobfZYylXn2ltjuM2kXR4ZNKZNIqI8G/k36J326eFH1j
 8fjd9pY99r9LIj+xa8MNZfu18xjRADa7wLDybA+Dq+K67wb8rg4q/H93yEg==
X-Gm-Gg: AR+sD10xjVz9QXY4r1mFERMspBVjitc4vQjXVe5OOd1H/m/mv1HSFiU3b+VlsofxnIT
 WvSH+J1wshmBE1OfjrEhpgq0FoffvNE4B4iPcVDtItSMjIVGLu8emNsLK8m/bdpfe4JlFWU4dBM
 26to4C+Tek1LWwYI+CZvVmwTOdVEQma1zZ14eF2KG6aZRAwiC8LqeUj5cucUmlxPMl5qMSufXEB
 0t4UFMuFr1HG2B5+Fj0cX/MAOm+9wd1HOH+tk12hTL/YIuFksLqQ/j6DVgaYoWKFFZgmlz5DZ3S
 ZLPvWSrAWQW282G+byD5apNpdJ+/Ldxou1mcTABhFhng3xWxfDA2bFH+16SR2lkPkAawJGyCTLz
 04Fo/PqR35QrMudCfG/bZAtTMTnR6ssH0ZfE=
X-Received: by 2002:a05:622a:6f1a:20b0:52d:8748:c5b5 with SMTP id
 d75a77b69052e-52d8748c84amr84344921cf.33.1786803162252; 
 Sat, 15 Aug 2026 07:12:42 -0700 (PDT)
X-Received: by 2002:a05:622a:6f1a:20b0:52d:8748:c5b5 with SMTP id
 d75a77b69052e-52d8748c84amr84344621cf.33.1786803161835; 
 Sat, 15 Aug 2026 07:12:41 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d5548sm115428575e9.1.2026.08.15.07.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 07:12:40 -0700 (PDT)
Message-ID: <a3f47a3f-239c-407e-8246-5fa6f43dcebe@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 16:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hw/sd: sdhci: Use a QEMU-local no-busy IRQ quirk bit
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, qemu-block@nongnu.org
References: <20260812013619.2134092-1-bin.meng@processmission.com>
 <20260812013619.2134092-6-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812013619.2134092-6-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX6q2x9DYyd3ax
 VrqNEw59i5iUmV+ZYMK/Tk+hX2tjbHW5YGrf40XRPi89cAG1Itk/ov0y7TEVc1DeKc7FoaPYgyT
 edwm36+XVbVyisXeWGypZCFXkrrRcpuge3Rb+7J3ReHc6gUC5LHZKWqh3MJ1y1S5UzUokO1CpLW
 kuqaq4ipH8HI7kazBh8MKQWbX/Mam4POKYq+KszFjbCM7fNgEUyBwGce9lppo+BXx70ieuulLe3
 Gp8XGDpgD+ev0bf1FyGZi0UQNqvZKO4CYhn17gVl5V1QCou45a1pO6R3qjuFAM7AyDQBWdrMMO+
 tFhQdiiuONOvYPM3HI2PHujYGz+EL6hRvTw3UvVhOVCe5rq+sK9EzEGwk40JdUYzJI73brAC+k2
 IvGtYy3lr1bTzrGLUel3coAR0W0655kCPaqXhsnoAaUflNa4y7F9J05TmqUoCYZVcpMDYj6yOV8
 GclJoyetoy5I0qiVjtw==
X-Proofpoint-ORIG-GUID: ZuC9qb9cIKJJQ5MNzkSaam3OXPdwyHPS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMyBTYWx0ZWRfX1/BgQ8jLC/kq
 p0Otqf2fxwu6ZNNnPwz5gkDpUZj5bfNSFDu83F+qMnb+LLea90pPI9Vgx/nmh+8ZOw5j+K90Mwl
 ZC/Mtq9jS1NFQFtt8mrSHGBXSK7TPgw=
X-Proofpoint-GUID: ZuC9qb9cIKJJQ5MNzkSaam3OXPdwyHPS
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a8073da cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=9KAOr1GapynhhPo1vrgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150103
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

On 12/8/26 03:36, Bin Meng wrote:
> SDHCI_QUIRK_NO_BUSY_IRQ was copied from Linux with its bit number
> unchanged. The quirk mask is internal to QEMU: it is neither visible
> to guests nor part of migration state. Mirroring Linux therefore
> provides no compatibility benefit and constrains local allocations.
> 
> Move it to bit zero so QEMU can allocate SDHCI quirks sequentially in
> its own namespace.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   include/hw/sd/sdhci.h | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


