Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2490BC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 19:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpAAg-00021Q-PB; Wed, 29 Jul 2026 15:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpAAe-00020N-RT
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:42:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpAAd-0000OK-41
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 15:42:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TJefaA2812719
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 19:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lBgIEj0kclPJpD1FhKtp72cnKCz4zIHtoQ+OEfzDjwQ=; b=Bp8kFo06YtsbzOQj
 PRHfG0WzY7A4gTv7UoiSjFQtMigJViWycfb5NRP1T6WLqZnOzGyXSy9j/jJRAtPm
 EuGtnXltG2o10UzNSM/rOznxpaCFB7pctT41yvePTKnOTVnCnJDxuKDLc8uGI6pW
 3gQiSbsIVj1YUi74YpkBIu7RzsggO1aK9U5D/hkeuqB+ojTXrgtEn+sGmq/6dikH
 9PWVLc8FjRMfA2iPDVT/EpwumfkvAU3+Tr+pw1X2jg3BttBnNMywEucA+2X5J76/
 iUIFrDj7lNNUG6qP0PodvylI7D35Owb7W194p26rMFqK7ATzPN14Ie/LDqAM37Kr
 Lb496A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqqvk805x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 19:42:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso1543613a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 12:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785354142; x=1785958942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lBgIEj0kclPJpD1FhKtp72cnKCz4zIHtoQ+OEfzDjwQ=;
 b=NfdljmUuQPd3u4NmAGBAik3t2RLMRBZsOPKe3KuGNf2cxDF7lO9pT4cj8hwvQKxBF9
 fIXzv6G7xqi37xwB648O7ivARK7NKI3FRu48ZsRLHmJueFKJZXsMC71iNgVo3ysZfA1c
 SyyKvA3vsTeroyd/SWGVaKuuIl+ABt3EZMniiawGyq8tOapgRscBaP7CeEryxGulu+eP
 YhheJurskaVCzoriX5St4VezevoRkCTfsy3xr0UlxAjdPOWHBFHzbok5kiaHnz6MCZsI
 gPrwYG+1yBZDwGapq83gxMHfoQBMbArpjft54XfdST5miz0QLDLGaueLycoSM3uKuipw
 4YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785354142; x=1785958942;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lBgIEj0kclPJpD1FhKtp72cnKCz4zIHtoQ+OEfzDjwQ=;
 b=V/0tVTDHu4tNOESegRD0EHCnii3d5D0N0KzdckPPiVBFnjzKlW9uP8+LjN2PHytDly
 nJVkCI5KgNzowZUa2XP3dFPvFrlHvWfuJb2sPpaThn5haZPdvq54rRKEef+zF+74ioUB
 CKuLbHtJTWNsaqREaxuxEWMKiODaCJ1FvScHxuuJax19aju2xxMBGNe5L3dhBO8szg/m
 n1S6HgOr3XDDrKCvOkm/dTrKV9kaAno7k3I5IdORr/8zNdGJVqVCJRd3yDs3YBmTDnDw
 MnfJf8P4vMmaDjl01uGa3dFAYDpAtfIlHWPJb0G3/IuMHgwXoAY9isNooceOs/daQz44
 km4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQBXkZwLeQ/N+823qsMfdluczrU2a89xUsPcf7GlV0hBVEGYdRouN/1222KutuLgahZWpQWj5M2H3E@nongnu.org
X-Gm-Message-State: AOJu0Yx7BXgnsu6uZwtNhCpmFY3As3Pn4+ShXuWjXJ41qA+MqHE8XoLJ
 HwXzi1/ka0Lg5sHTLGvEtjlJtqIm2b6Hy83RrvV+Gr5KDMKBpj6O5tje68p4wgEL5iXoMb9gyMi
 cS8tolSqAfSILjJNVPpQTAb+VtuEfVAxYJFx6wlI59HWXRylROo6Qd1A4hQ==
X-Gm-Gg: AR+sD138kcrSmFlhzkd9ozIRmdHV1J8hG0rDRAOAJu0gTvw9nT5vGcwFPWahFLnaVQy
 RIkzqf4rcXRCbF7Jh9omWvzT6p54UvdV5rxFhxoZj6gnan+1KfN1KVHDDESwFrLxsCx1G7tJnVJ
 cxsyR2ST/IuOcp6mtoIvC66rxiS5aPxbg12W7q0NwG79skahmybo324psoRsK/cKAn29Cj0AI97
 3kezOjEO7pkmhByf+fRVYWPoFhVowbe4nqAtJYp7fNUGTU1Dy2SWPEwacm+Qm2B3spL/D9Iel93
 AABOgM6L77CnTkgGu/y3GJanrnk4fFku1XHGx6Wobjl0qKrYkK5d2zGTU2wX5Oay0zQAK5ljwNW
 H9ir8PXmK6SZpgAPCa328QPcXeW31CBeMshxS04tg+l0OfiNoDhzcqOBDaTUJ5jAddx/V
X-Received: by 2002:a17:90b:4d88:b0:38e:5dc:af03 with SMTP id
 98e67ed59e1d1-38f994ae434mr149104a91.40.1785354142485; 
 Wed, 29 Jul 2026 12:42:22 -0700 (PDT)
X-Received: by 2002:a17:90b:4d88:b0:38e:5dc:af03 with SMTP id
 98e67ed59e1d1-38f994ae434mr149077a91.40.1785354142048; 
 Wed, 29 Jul 2026 12:42:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e72735084sm11904332c88.12.2026.07.29.12.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 12:42:21 -0700 (PDT)
Message-ID: <50616d09-9bac-4542-9b76-282538c381b1@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 12:42:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1] linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, deller@gmx.de, qemu-stable@nongnu.org
References: <20260729191711.71217-1-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729191711.71217-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MSBTYWx0ZWRfX2BUD6lpkuPSc
 JpdTZMFRwZyFuwBmAyoe5G4JGN2rZksF56OsmbPgyutmz3Oa6667+q91WIMftL/4FBEtgcCgmi4
 4spYQECpz9We/pYgTbGhTGEGPiFEh+E=
X-Authority-Analysis: v=2.4 cv=aKvAb79m c=1 sm=1 tr=0 ts=6a6a579f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=3BbPAglyjGhWIxXnjVwA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6qqH30edmloccLAszM9T8_7qFIOSGjE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MSBTYWx0ZWRfX5mcDRDneSO6w
 1rYj/yaPp/Nnq5wLVBVx/IhG0qqKr4JsyOb33+SHbF0d54HTlg168vfGCPD04phKE1AlEucStEh
 czU11olCEp61HwiVKSuAKLGJrYoyri/m6FkNnCK/KFJAddI5/x9YfU83XWOgoOSXXQR4PNFCfwh
 dtVzos1N1skQuiuuletYrtoAYo1UZZfUFeGwvVXsZAtC1z0N6RwENtaSNkgMZN36hrHkE1GFBQt
 dh4px6OvZh4u7qQ9huSHp/+GjbiEiBir5/GJ0xNwk9RdfxWIrn2puRNk+5HfKXDFHtnvjyhZS4/
 Lyke8+hdT4uDzzvECRWNAqSvCpxxBQqpX1oYVuAUwsOgaqlA+MaWcj/Lr+2LNwjDzrS6XZRCSaN
 iOQF+0gD/d/fJ4lRMsksR7Xtp5CZi3tbU8umOzV/YZVKwLSXkRNCb6V6W7cyYHGMOXfJj+/DFsC
 fqUmnt4VlR0K7cFY9kQ==
X-Proofpoint-ORIG-GUID: 6qqH30edmloccLAszM9T8_7qFIOSGjE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/29/2026 12:17 PM, Richard Henderson wrote:
> The token is not computed via TARGET_PAGE_SIZE, but via a fixed 12-bit field.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ad1afe433fa ("linux-user/aarch64: Implement map_shadow_stack syscall")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4106
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

