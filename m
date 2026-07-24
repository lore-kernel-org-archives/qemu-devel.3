Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BFCC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn990-0005p5-Ml; Fri, 24 Jul 2026 02:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn98y-0005nl-NR
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:12:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn98x-0008Um-4F
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:12:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4si0Q1897288
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A2PNz2bctcF/nczpThgOenbN0KRlAGYYgmumFzBLg0I=; b=XEkVMIUAcxqkqmAv
 U61fN/ITn1kxIU8aqoxHA3l5zyIUc4ZwXxSzstfbscDlGp+tdNABO5P61OAzPnpL
 jtsiyTYKeorBwbjngGP8UWqhD7S2oGCwXpw/rsmMoQ4YMvEQha8eo1DMju1rqBaD
 bQ8YibvD05Vv+jakrQ0LFvJkRLCDfgZ9krS6erHeFIEOy8MvdQzzM1GRwlXG4s9V
 4coK/3cvD7g8GDYP4tYgaduG+SSq7IuyzPF+fGmchORDMHM3QNag1oehm8QCOIma
 VOd+Cy9OdCUT1egX7REkXJ4MSbAuiBx9tNBEPFs8RhyoJHArGgcRYzeR0YC6onyv
 8GXVtg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm1em87pf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:12:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso1197821cf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784873540; x=1785478340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A2PNz2bctcF/nczpThgOenbN0KRlAGYYgmumFzBLg0I=;
 b=anrOEdrfmCvCxNC7klOcaKY3p+Twfcuc+eOV1NtHzGEVjDsiyMni2j+1lYFA+jLRtP
 VwKGRB6F+wybXAjE+/XncvYiz1ZsCsFfFUE+fFWB2yE+RyYaZI4cIDCIe6EuRnemwPje
 TCIhOwvH6EFWRwmFURTqgmTDQuC4W8xyUTXGPxh8wgQTRL7TwGmGC6R5WPO8jwbbTvsa
 irE7XA/Bgl3Q7brcCeunmqujJnzpivdnoW9wcSxj7Bl+eB68Y85ccntShKUSz7czgzmI
 IwbbuSD0n8utGSU+MGF89oHHuxsfbIUJ2HxSkbwRARakMpfCwt4OfEOlAqRit1wlTUK6
 psew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784873540; x=1785478340;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A2PNz2bctcF/nczpThgOenbN0KRlAGYYgmumFzBLg0I=;
 b=rBIgw7kU7MCGmpnV88FeXu/G19PN4imIipEYvYKroaBstwdE4KbXGp8RjA0QTxJRka
 vyxhYsmlF9LgCE8MoCko9YIjY2z7Wup/r1LlS6wqKZI/iHvsZj/AKAihanS/4rC5euAu
 96Y4wcA4kvvo3No9MFUXnkZba5qnECRFnbNGGturZVTjWaLDPFtnx4apcrX2n1nl8ozP
 qIvt4mzeb/lcwuxSVm6qA015oNZqCuZ1tRcO87hwVwi4xQCoeDWH8L/AD2HW2u4/zg24
 W8KGOe729OD3E8NPUBWuXgo/jWo10Oehr2jKStG1uNvRQncy4hQyMqVfzrl6jgvCJKGX
 SybQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDZ7WaF0yp3c1JRaYG1AQk1hODI9hsnfBwQEGTh/qntF0S/ZaT2hs0mGcAUcsQ5pNVUPmqE0zHYwVx@nongnu.org
X-Gm-Message-State: AOJu0YwLp2oQ779sSMy24CBhSwJZoyJEkLHpj2qTjCVC5N81vRwO+qPh
 2nOWi2O3H4Orp8YMxMKzsnWINQ6eyGnnsUTqWXIMxLMOPwbV73h80/9Tw/obs4ArMD4REscd0BO
 6UisUTDNb4669FO3sUhYG3hm+JauJG3ZBRESEVsMsSd8L5S2+j0sQyx2Puw==
X-Gm-Gg: AR+sD119vsghK8h6MXXp2rgRP73F1u40X6BM+oI2hytKobFGqB1wwrGTsTIX/KP7Jw4
 zhp6gPqS3PvAME9SzLfCuqPTaAOEtXAJg/Kg4IsYOACXI2h+Z3EVQ4+plrWP/wt4h6vvhgel31N
 sQ/Orga1kXiKNSyCjBFg4Foo1fm8gfT/vwZ7dRQnSg1hw5jIC2sXyxZdeGK566khtoM6U9KW5xP
 It65P1SQP1Bq6KoxmCjI3KTKVpQ/7dIFROKu23jPb2QVywNC4G8FizxsiWLwjFOrQMMGraLQHVg
 wns7IlFbyZo/f8AI99RAJewtn1xTqpsPQasa3ex4bqtyvkBnMtIecx3n01vERUYI9gn/Ekv5e6l
 omLJQ+JDJXtpdd+EZHTfX39DBPps=
X-Received: by 2002:a05:622a:3ce:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-5283de5a0cemr55352611cf.34.1784873539905; 
 Thu, 23 Jul 2026 23:12:19 -0700 (PDT)
X-Received: by 2002:a05:622a:3ce:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-5283de5a0cemr55352041cf.34.1784873538142; 
 Thu, 23 Jul 2026 23:12:18 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm21352498f8f.24.2026.07.23.23.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:12:17 -0700 (PDT)
Message-ID: <df841256-596a-4582-9401-46e7d7b7969d@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/27] target-info-qom: implement new machine filtering
 per target
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-14-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724000948.234657-14-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfXzwqF2RPfv6K2
 6RdCm6GL+D1YJItBnJgMXfqh5W77BIjGvvvrzyFdGiBA5aje6GedJRJmd4hNQoZ1AcaT60P45PL
 +U7oWQC/Kj34c+3W5TUL+Z6ND8QtFSw=
X-Authority-Analysis: v=2.4 cv=BIODalQG c=1 sm=1 tr=0 ts=6a630245 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: PGsiFvxZrJ_9qAD23mnvtiMKXpSGJYVa
X-Proofpoint-GUID: PGsiFvxZrJ_9qAD23mnvtiMKXpSGJYVa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfX01/8LNHOVI+l
 rvIPU+kdKMOcHRwCN7RCg+H4udSFoJLACORZky/j8/MdzIqY+vqhpBwMq37DdF3s7FsZbHj9pTb
 74VtzDz+cxw9C54YaR1owlZlNH+/lBDHfhWjUSgO8CPvofWgfIkZKbGT2jMQSa0XvcXf1xhr+AX
 x/swWgGamE9DtAmK59HP0zK+ydGCJnSGOLSgARC1wmQfsXgsan9BVV1/Q19XLRYvt0OLSFmXn6r
 qaAurEvAruwmtS3fPMusrvB3fpbN5SO0kaX2Iqnch2f2SQtjhJhA4V6ptCpAIZnwAZsWOFPmZ51
 GjPp6X1X53oYHF4vCKbquRXpUFLqGj0LBlVJVW5DDgCchcygiII/f+ck19csKy+fic6iY4x4AiX
 oaCiTlZgpkYw2QC2eXsyzrGsvPacOiBhXOphXU6Sdxp9DoIsaaVsuBzorAAqNRQsTqe8w9NixBG
 ZVSzHWoYoxMujPHmBpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240054
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

On 24/7/26 02:09, Pierrick Bouvier wrote:
> Now we tagged and implemented TYPE_TARGET_SPECIFIC for all boards, we
> can implement the new filtering mechanic. We update all locations
> querying list of machines accordingly.
> 
> We make sure that all machines implementing TYPE_TARGET_SPECIFIC have
> is_available overriden.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/core/machine-qmp-cmds.c     |  3 ++-
>   include/qemu/target-info-qom.h |  7 +++++++
>   monitor/qemu-config-qmp.c      |  4 ++--
>   system/vl.c                    |  5 ++---
>   target-info-qom.c              | 31 +++++++++++++++++++++++++++++++
>   5 files changed, 44 insertions(+), 6 deletions(-)


> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
> index 83eb537333b..9f175bed057 100644
> --- a/include/qemu/target-info-qom.h
> +++ b/include/qemu/target-info-qom.h
> @@ -42,4 +42,11 @@ OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
>   
>   void target_info_qom_set_target(void);
>   
> +/**
> + * get_machine_types_available:
> + *
> + * Returns: Machine classes available for the selected target.
> + */
> +GSList *get_machine_types_available(void);

machine_get_available_types(), otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


