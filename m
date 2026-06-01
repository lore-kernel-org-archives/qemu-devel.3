Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADA5CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 19:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU8JO-0003hZ-31; Mon, 01 Jun 2026 15:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8JL-0003ft-R7
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:28:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU8JK-0007eU-EG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 15:28:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651HjWIg3129399
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 19:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZICaGbQ1xXYW5gmK4PCiQZy7IEg/k+vZSFiahJT7ZlA=; b=HrVVW0wEJdvDu5j8
 B0F6X2VVyH5cB/0jFJqOiW+fQ0n3XOtXdTRBEcsHCy/AJ/t4uKPaMdfD62Q00eK3
 hUZ3iiT3jBBovkg8kQPPSt+2J9+Cnfu8cP1g9zdWqVenZxYhxN9zmwXqsSoUEaqo
 WoWqorQRaeS2eaPisj3UkT3vczbzWj6mtwrnTJqCotWA5qYkNp072AgjhyvSYxKw
 GzaAQCQQTEbwKdbWVg8xL/siYjyaxEAomyBQumD+IJLV2v/CDkfPa81aTu+2AUCs
 OD1zMEwcsJg/qHWHq2YGUOoieu+FX3WmoR6dNDzKXpmomUc8i+avhGKacf4PgeCI
 iAFZfQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh90125nw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 19:28:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso3066463eec.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780342106; x=1780946906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZICaGbQ1xXYW5gmK4PCiQZy7IEg/k+vZSFiahJT7ZlA=;
 b=YQAa+bw0YyGs/20oYuOSEOAZTgmVZtLXX9XY16ovjfGLGPs/XmGejvyNR2YuDU6r+F
 At4dLuqObRM/DrUhulZ3KpQSyAh8Rx3GhXVuPx7+O4bX/Hxpi7jg8PXFlhjE7+D8REC+
 rREu1kJG5ulI15HbvTCym8kpN0qn+3wf/ExKmwlA7QqU4QTENNfcKWn+oef3clLqyv+f
 j0qqHdxdi46LzjUCh9GFNoHPWqaGLMlIdgqsPSOXL/DcMPyd7keerqJOFPZrwQjGTFQm
 3ZNWCEiEIVBLGDO2vktFj5k5TRHF5/HMg6SCAxPWRTdY0MCS4GEiLhPemtlIKVDIiJfX
 Wgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780342106; x=1780946906;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZICaGbQ1xXYW5gmK4PCiQZy7IEg/k+vZSFiahJT7ZlA=;
 b=EBjyCxEx+X7b7GvjvbnLEGLVIeNSa/zqTN6d6sofQTCamKjMjlN2wAEUoyRXJK8qny
 vCXW8HjNaGdtegTWrix4+rPLv8vIVdkpM0YoQZ9zzaXL4/xzSJhLQEZfpUwlZG+pc8qP
 6Re/y1x+jb8FTsIvvT9KFXrtGAdAWAVr7oZAd5qCJ0TKE/cI7uEhwfEO9p0cwbAA1vqX
 GPYZLbCXEtyuo1IcDvsaz7pKB6mbDvyhQkJqMtU+bjP+d46fQcAgKpo9LgWgPyEK+/GK
 ObtE8AKthLq5N7GsXnPpRTzXSGEdN0RtXgf6t0qLqwEgN+qF71JcsJCtzr3ozbOp25QO
 MPgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+twbhBC1YLQ7eiPY3LPuvFi0W5zmkLBwNkL8KiEjggr+zlr3uzkYaST/Ztq5LN9ZUDhrPAiEUz5Ypm@nongnu.org
X-Gm-Message-State: AOJu0YyLHWzGnmFTpyAxNDKffAFtuzmyry9qQJ/dQv2Pv+9Pcs29EYcs
 /P6dNyXVtJYllexobtT2UE1YYmoXL8qg6rV2w47N8wXqzksGR+pLeNyWuHH14cmES7SAmpRZvku
 q3ALgY4X9dF/DogYX/+DAEod9EQgwEne8kAzkOxRIQ3aRVn9QEv+NeWR7IQ==
X-Gm-Gg: Acq92OE0bxB1cjpCCXacPKypH+pPotFjjW80JGcdiCQVe55jbiT4yEhBCO+uayjb/ZX
 VimYbrTP6DO8W9w+ri3/66Z1M/gkWtDOP9EkiUu9NP4gBxDmtFfnitoqODFFEuCEdtsnxdXN6wI
 8fUB4sKxlwOG7MYPLOMDL8R3dFu1koXrffenUUrHeMnC33AcVp0LIyRn8UUHZte+OuYZ+FKRflD
 134x2stoQS78nvbxyKLWpv2exKfHFsg64mv8eqenEPD/rVqrGe4r1BOnZO+/4d+x4bR8F0f2LEr
 A4mnvOunkUC2bMmzlr6nsLuZzA2Us8+CnA5ZD+73RyIhgeyPBaTpqszCVtDwEO775Y4Mv4tUfUQ
 nz2K71CLaOVuifkM+MbyqxomhNq0mZ/gL2NZaazA+4mqjI41En1pwd5klUUi+fKzR23MGHkXCiD
 E/Za0Eyw8jO0Z2rKeQYPO7CBtZ
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-304fa69c7ffmr5962883eec.34.1780342106396; 
 Mon, 01 Jun 2026 12:28:26 -0700 (PDT)
X-Received: by 2002:a05:7301:6a18:b0:2ed:e15:c926 with SMTP id
 5a478bee46e88-304fa69c7ffmr5962867eec.34.1780342105918; 
 Mon, 01 Jun 2026 12:28:25 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed30fffesm9286783eec.11.2026.06.01.12.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 12:28:24 -0700 (PDT)
Message-ID: <567632f9-df40-466f-97e0-9f226fb1015d@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:28:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] hw/hexagon: Define hexagon "virt" machine
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
 <20260529215937.610229-9-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529215937.610229-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H6nrBeYi c=1 sm=1 tr=0 ts=6a1ddd5b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=AuOHkskKoJLKeBqF2LYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: YMDM3H0T9dRYhJeIWLJ7Bu8kzBYXjY2G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE5MCBTYWx0ZWRfX5FOPGrUzOmiu
 PQVzxNGUSBffQdLbQ748otlBH9M2kzk7NDBVogEA0y3XhAq8Iwe8PErw1rw1kF156YDBHo69MVM
 mJ1Aro0jCwG8yW1YLcpzmVEurRFSVqjwWSvU5jtjWhWYEp9eTC81l3v+2jE1QMNoQPZuBD84YMQ
 FnVkXd/NeOw2yGUa4m4rPMTReJfyV7eZB//7CDklacztaMVqwSrhZ1QXspNP0z2SArvOMqx4Ren
 v+/RN7OkJ/nfxefcfuqPIDdo3gcciWWS4PsJEkDXjKPBf6/TMDvyZLI51pYAoa5zAD6UVysY8RG
 gnCxF6Igoo0LQDmMQZmiOxv4y+y+wSZNY5ZrAbr7hwXLvlLg0BV4VHFzSZ1vCk4BgefK4AwBAks
 1v4fZK2usL1NE+7e33bAgHQjQWz6uCRQw0JjJBN8jgI+fGS22rAvFcfBIOgKt/Bu6om8cwo5AQn
 e77bAzt3iU2A9zfWuMA==
X-Proofpoint-GUID: YMDM3H0T9dRYhJeIWLJ7Bu8kzBYXjY2G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010190
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/29/2026 2:59 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/devices/hexagon-softmmu/default.mak |   1 +
>  configs/targets/hexagon-softmmu.mak         |   1 +
>  include/hw/hexagon/virt.h                   |  31 ++
>  hw/hexagon/virt.c                           | 463 ++++++++++++++++++++
>  hw/hexagon/Kconfig                          |  10 +
>  hw/hexagon/meson.build                      |   1 +
>  tests/qemu-iotests/testenv.py               |   1 +
>  7 files changed, 508 insertions(+)
>  create mode 100644 include/hw/hexagon/virt.h
>  create mode 100644 hw/hexagon/virt.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

