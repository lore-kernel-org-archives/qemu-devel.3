Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A1606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJ9JwxiM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VDrb3h+8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv5q-0005LZ-3L; Mon, 19 Oct 2026 17:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv5l-0005L2-5E
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:40:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv5j-0007TL-E4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:40:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZOkE3963934
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QbY+JHyj+BMf4iPkC4oRGSBga1ZDFqTFpjk/+sMB4Ac=; b=mJ9JwxiMgs1sTZso
 xOkI/p9q/YUXJUb4M8JIzDFkpNnyrtblHcFQ/J/mTKorKSrTjggaxiofV3W3RtUt
 C1lWnycvVgYkoPwpXgVmIvE3iw2lC8ot42Gp8rpElaCxzpE7XA0vrQf25oT+nL8z
 R17foGjgqPaoYXAaQDMMS98sat5MYj8pRCFqdSdPk9WY2Kb1FE/dy5gJGzvW7nxV
 FoW3nyR0z+w6JUbZAm3bMCJ2tU8FnEqIJ2O2d4t9aneaqnWBb7xoZtVUsxSVeIGB
 RtHPrrRzsbsgmcSh07u68dYvYeVw867abDkzmlx9Fgb/z/K03D+5ZVZOrGaVCfCD
 fuqW9g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xbd0x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:40:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso7731307eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792446021; x=1793050821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QbY+JHyj+BMf4iPkC4oRGSBga1ZDFqTFpjk/+sMB4Ac=;
 b=VDrb3h+89optqdm7mSi6uLb7U4yLDRBzvFvmu1g1pSKhVqXNrazG6EI81jATL1Lj0f
 SXqct8CaTppP07efl22PivIK/5hCyOE7Op1IOtvIHHTy1HsnHxGCmMTtYHSW9ov8tuJ1
 DrPG0PdLmoiZqLqfSNm8aFBS/VmsVxDpD4UvI2y45Hf4/9Bz2tY3YJAwjtc8pQ0icaDv
 GwY/fRB4ZmatohaCHFUz5Luxk0WaMXqX0kub7B1/mIlaJ491OBCKVzk7msw6B3N3EdF/
 K9tK3nbvXeMU7U+V42rqfSEi3SJssAnsyzMAVvUyOUQ8tYRFU1dmrciBFXFuxT2oQ55A
 bpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792446021; x=1793050821;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QbY+JHyj+BMf4iPkC4oRGSBga1ZDFqTFpjk/+sMB4Ac=;
 b=SpB7xUOGI+8gj2JsRezIVYu/OAENGWQ40qVKYUoa7gTn2hi9FM1DxFtlyLU4mptdFr
 AufF9u0ZpR8o/TDmGy6vI/vbPsM9Ls9eZ7mw5BlKH/24mdqxuyFYasapKNxe7fFRRN8N
 Httni0RG8esaeiTZIzJLDp3Xe9HURAi+Si7eb32IqLr7wWtoQhVfJ/NmL5qUQRK4I3PV
 nNiSBM5PQ62wFJ/ydjFX6VObA8HQFc/2jrvMpxFfUcpW1vxPRI3q0X9oP/NE26gi+Hy7
 mRvysOg6dbjTvBI7a9YUZxpQ8K0vzeJiwVOtdczrT5VbmHKF01/GzSMFW6QLoAWLbVUR
 bA1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByOIPjz5caQ7CPipstRWgUieJOZ8RiLy/t8sRGcVymxzYgpzuushzA1qOxr4ovk0ihD7W05Wi6JAOCB@nongnu.org
X-Gm-Message-State: AFq9FYLml7wGL8zcE6EDnCcKmdwF0oRdgRAGehEH7UF3F/PvCOZl5Hwj
 3UGGo6g2MoUfVLrEksPc7l7g3CcAQUj15l46Rlif8kCGDEwOGWFmcoaetI9Cm8pgOvW6GufepXW
 p708gXm1ceRwAAgti+vVQ1GkpCMozDINXPQ7qA/b+MWB2cC/3vjNhvaH06Q==
X-Gm-Gg: AYBFou1JAwwFPf7Sg5AoAy1N7lRihTgOd7HT2yU8/4yI1GgppUbeb6KBaMm4lJ6nBoI
 0+zk/WkZfHv+pVN6qpR4WwqhFhX5vhyzIfJd3VWhaxjE/JVEGmItPK27d0p3hpVhosyNlbTFX8X
 SNCTyU3gdEcOxnaNCVX8h9WaypULYzArVesmSTESD0IgcCdqp/B1WQ61z3vGg7tTXktBlYw6jja
 u6JKs860//vVyhm+5hDK5vPLbZukXZAzJITeKIoBuRIUrT5J4K5hDIFxKl5iWynfVG7fXkznnd6
 W/+ZU3rLJVB+urQWXSThHTZzcCMrH/bSupGEuvqxsTKfbvVJjgp1GOCj2lwQtmYjqbKLHdctggR
 yWQn4Wpr2M94iS6CdUPSSSGaO0kFaEfEtFne8R/7kLEXEvUwkDElee0NhaIt0fvmk+HwEiA==
X-Received: by 2002:a05:7022:f210:b0:181:ccdd:ed2a with SMTP id
 a92af1059eb24-185149152demr16045035c88.43.1792446020854; 
 Mon, 19 Oct 2026 14:40:20 -0700 (PDT)
X-Received: by 2002:a05:7022:f210:b0:181:ccdd:ed2a with SMTP id
 a92af1059eb24-185149152demr16044980c88.43.1792446020188; 
 Mon, 19 Oct 2026 14:40:20 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831919fc14sm39361941c88.6.2026.10.19.14.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:40:19 -0700 (PDT)
Message-ID: <4aea7e0d-3b7a-4b93-94ec-6c34608f1bc0@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:40:18 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] hw/hexagon: let a machine place its DDR
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019055245.1457795-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QmX06s-tliYHoDN17pbO4d8QRCGJz6ge
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX4Yo3rzCeO2HM
 Ihnsz61KveKrTqONhAw23AvFQTyWnrD+YjmnB/IHOSPUGFKyqhXFSt6I7gL2wQU9Db/NicNSVgb
 Vx8LAVw29HcFnyrYIufeURbOEv+Th+w=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad68e45 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=N6munM_sqa6qoa9lUOcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: QmX06s-tliYHoDN17pbO4d8QRCGJz6ge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX9Upp+eNiD2uK
 9eX/5GYasoqnr0RAxTqtAJenpZQfdaV9MVUooBUPEoHt0k02BiR9tE+CH5ACgwcO0ndzy5+wnin
 Cn+PkDdhYbLZkNO7dYKXdWF+RlfFRACIvEzKUhkfxtIyIYH20cfrd9ozZbU6W4GgsY6QGos4WdH
 nSRPbGGfftqG1SeCfXNjkx358zDxTRMog6zJCZ3F7aUwM01u845AuK6EK190gnvZJg/GIuXOMDW
 AUeH8IWI2ATN02lIEM2tz1PiIxtzxnyz90Ll5y9pH16H0YuDsIOp1Y5CYChsHcKfqrGLBOSGAH3
 dIQAz4BX5ATNNSSZXwmPt7e70npZD8hwAe1iT9DC2Uj0/smKSD5Yh7P7vLcDat9Qf4qKDkSBqtQ
 fEIoz7xkpOIH5J3yJb4KC7BX9ONbG+4Nz8L0OiOWcpBWjnWV8e6pOfZsMIQ7kanXfi+u15thqgy
 N/gaAi429TmAMxJFd0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190086
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/18/2026 10:52 PM, Brian Cain wrote:
> hex_subsys_create() always maps the main DDR at address 0.  This is appropriate
> for hexagon-sim-style machines, but real SoCs map it elsewhere.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h | 2 ++
>  hw/hexagon/hex-subsys.c      | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

