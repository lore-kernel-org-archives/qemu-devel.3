Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF45CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5uW-0000ch-Kj; Mon, 15 Jun 2026 07:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5uU-0000Zh-SR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:55:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ5uT-0007RM-A3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:55:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAoPMr3885701
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hu70N4SBODulejlwkPLWQIUY/OZNAOuwCFqDKKbFmOM=; b=XJcHzaGAohFYuP6r
 20WpnqR5jbwq+K+TbD8QtmdFgiC2qW9Im4jc3lIYClloN5xhXCDgkOhslPbn5ZpP
 ZLWjDsuKr38ZY5h+JVbkYm6TcfwYhNTEIZpNz1l79YmnMs9R0g+WzD3eMyn6GDiI
 NQ2EyO4zKsGXHTjBjsIY1eiZsOJrBsYo7lIJstqB6EEaXlnR9ESVTgLT87igO52l
 MCiurjIyXsbBM+O79Idt/1ZrFIi0PaUedscGbAKBMNhlCkBW/sb3fj/mqOOsqoSb
 btgWzxha6PsIhwLyu6Xy9JXLwVyyzRs+SQmFOnk2CP+s88GAGs9u1FrTiaCwh7R9
 s6gNmQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjrgvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:55:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-918622c3c7bso460212685a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781524518; x=1782129318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hu70N4SBODulejlwkPLWQIUY/OZNAOuwCFqDKKbFmOM=;
 b=Tvq5pv+/M0CCIRCarDdMZJ+3eQPBhuAiIlb05rLiEh8GnnK2lgAhIPSvnTRVHpnJnW
 FSyEmoX6b46tz1viL4qrtuSeey0NVIUGt2EGT3HlM9QrdqkDgsb/DXDiWJlTriKzkQQI
 W2/ohR+6hKc4EkHoh16TNI4SG9p3KEJQXaqqqm6i4mWi/JaecN37X7TiUtibu+Vh4AdI
 /r3DcBIO1IOS5qBAuASlVC77ofFLxHfl4jAbuuoGYBpyxAgQZkszKMoPwGPSjyepBiPu
 r15LuK3QIFRHcFj0J8+57qYxv4RHhrT1dnCUQS+tHRPejja5pzwWT36dPQEVRtDbhsEX
 yOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524518; x=1782129318;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hu70N4SBODulejlwkPLWQIUY/OZNAOuwCFqDKKbFmOM=;
 b=cgxDtBzYP9sSr1cLIqj2H7D+oA/nBFHYS/QY362OQmQU3Iiny0rf8YaxpgDgqPZksu
 1iOkrx8dg8tBJcxZjmMyFg12t122Grfl6bidIBwuvgrBVRda6JL7kDlTRUKNaNDVTg/Y
 YL0xbSNZZX15s72haaIbvnFdIlA8vqB4qdvFGPEd2sXTWlT96bo6FKf8hQC7mprxc819
 sKRWp6h4LHuJuK4JGjwPbWNtEU73dhFUNiCq5XcQGk5LDVxgOEoVtLTF/IQUNzy7VBdU
 ZcJYvm/TbU7x6zgM8ZCHR6oNg+cnerz6wpxK7WNUNooYhkbBchyiu29+dHVWMzNCE8wQ
 vY5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TlCVEgTLDueb2q4zi/Xlb55CjAdRF9z/x99WoAFgS2akWyjZcmTphHGaL7NguewUdcMabQbpNHx3J@nongnu.org
X-Gm-Message-State: AOJu0YzgsPPPFJtnmUuoRBRzFXgv9eln+2GQNYKQGiGAPKaJOfOq4DC0
 MLtg/lZbW/7NUpBFa2bcERiTDNFX7zSnaa7vlXK6oCmmlHVXicikrCqWBmp4r6kqN/Tli5tTDtw
 ZkNoc2iOP+/VgXGxDiDngVfPC17g1EZ0/YYT/2TyGKnQqAiIai1Jz4BczXqpCIr3c+Q==
X-Gm-Gg: Acq92OHPBYAxWgxc6PICd2JbiCUgI5eT0VT0+mWsolqy59g91Jo7leQsZPGHG079jvo
 lQeGR0jdxJoXWqgWKIPqkI/bTDaX9vAemLGJrDHpCXovBbhsEdGd/tarByQ7Llp5+g/GzIsmJ7e
 OuAtqjpVWmJmOLcDlH7VO5lFpURiPkESl1e9kqLBtcCX2ssE4QjqgKrb3JctKnMuJivi3+kbfHM
 Ze/HaLoiE57Mt5ZQTqzSbJmoxxjzFl7CDQ1sghExMwAFN657GeBRIiU9Spu++EohZGMDue0dDoP
 rRXgftLzLlO0xFgwMfuM2I9RXHKcIQjmF69Tgi1M3w6quxuk0b9q6qDkK+gEVO3IXK7z9C4/OK3
 DQCQRXETB8yF+LqXmveEBW+TFFs1gFrokOW8K5wBRZHxQ6PH9N0Qu8g+zeFVXRtN84UmustEF
X-Received: by 2002:a05:620a:6c0c:b0:915:9984:5781 with SMTP id
 af79cd13be357-917f196806bmr1664291885a.51.1781524518351; 
 Mon, 15 Jun 2026 04:55:18 -0700 (PDT)
X-Received: by 2002:a05:620a:6c0c:b0:915:9984:5781 with SMTP id
 af79cd13be357-917f196806bmr1664286585a.51.1781524517916; 
 Mon, 15 Jun 2026 04:55:17 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb4420854sm461090266b.7.2026.06.15.04.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 04:55:17 -0700 (PDT)
Message-ID: <20f2547c-7787-4fc7-b372-4b93a9a64728@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/arm: GICv5 cpuif: Tag ICC_PPI_PRIORITYR<n>
 regs as ARM_CP_NO_RAW
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
 <20260615105029.2898872-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615105029.2898872-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX0j37cBNjrisP
 koCu0/mD0/dQyp+sNWDRjCSe1p3TgYpizCrnflF2R0hgVtgpkqTVJjaUGiRcPpRDgyE682g9W6J
 PIQ7pRqq1au/jGW2nCdDB2hPfY6B0qiEAs7purF1OWHe2OBeCr99xs/Fye7Xjq64tfb8+BE4/j8
 D5gckLHONVGSrpKE/9OMMoiLbuPDVkbJBK041t2z94LwlOjB9PYjc6ERRPiITshNrMzSGZVRjQ3
 vQKsKdnza6gICFtmSqcB5Fz4BXL8/5Cq8OHjUatfFfOF383ecNDscvnqAGIaMOjIZXuburB/h0k
 6C3+p1hGcGfaFB1l2DyoA3u//VFHuwsNZb8oUTdYlosLgmXT+ijsFFnSQ31PXnO16NG8dUNNFJe
 GLaKVZ1xAabtm09eDkIH+XV5iqDJQhf8B+58EdveI3oAzsxHDgVtZ6UrHKgTST39FovoAXVxScd
 bq+Xx7iIGux9kjwqM4w==
X-Proofpoint-ORIG-GUID: H6lh_duXYUBOAR56xuaiAjveC9UJ1VwJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyNiBTYWx0ZWRfX8anmTTWuBHlu
 4eKzYJ914I6Um4ZkAzTG0aNnnhOkgUoX0M24V/iubO52lSHIhycNBKpzuMTbrn+cFxNdoh5DXjd
 mB/QXy89WHQH/EwEMufA2jwYICS/qwk=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a2fe827 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=h4B_N9_jLeHJ1tJJC-YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: H6lh_duXYUBOAR56xuaiAjveC9UJ1VwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150126
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

On 15/6/26 12:50, Peter Maydell wrote:
> The GICv5 system registers are all tagged with ARM_CP_NO_RAW, because
> we don't want them to use the standard mechanisms for migration or
> KVM state synchronization.  (GICv5 handling of both migration and KVM
> support is a "will be implemented later" feature.) We missed this tag
> on the ICC_PPI_PRIORITYR<n>_EL1 registers; add it.
> 
> Fixes: ef540c1d301 ("target/arm: GICv5 cpuif: Implement PPI priority registers")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

