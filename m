Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F97C61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 00:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1v7N-0002ZY-FD; Wed, 02 Sep 2026 20:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1v7M-0002ZF-04
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 20:15:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1v7K-00083q-7g
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 20:15:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682NHuQR2348409
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 00:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ihIYbwk9MLemaviwg136qnzZ070iXCIt5GZ5ewBPZjE=; b=GFvFdtFFFAR4uVf2
 y27ZvO2p0YmUzxn48yav1mf0g1kdb7HOQiy1BY+eMQ7gfKMgBags2q7zpTbEhmpo
 gJBA1FKaXuSqgml26auhG5O1nw2BxSgfxwUGO3Us1mn8M+XmzBk2vPXjDpjJyjgV
 ZE6lNr3SToQkbBa/CAVKVpeMwiGHyEwCDTSP7ybdICUX4wv6Mf2owwEmVs+hGjNU
 Dyxk9uTYfA6UqCWeJRWSABdxnxpXvLlnTrgBrELi+zD6sD1usZ3pFEP7Mywr9XfH
 byYD14hLpSyxLDxF6oBjaDHU7igp/v+PvvC/TJgwMdkd2OG5/U2j5mC7E2jZT0eV
 KGHf4g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4tq40-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 00:15:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53001b668a6so40850091cf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788394544; x=1788999344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ihIYbwk9MLemaviwg136qnzZ070iXCIt5GZ5ewBPZjE=;
 b=Op1m90yA/vTYKYBlQlVfhfMCTPjlhsZ0W7hwdtYyWc3UUjhoKgL3r3jXfPG0P5XRQ9
 iz47GqLs81Uokgol+vqHgLDecdgJx/ofIdUpHgJlfS7iFT+Y6km29UDeGhZmDxHWBMSm
 8yqivOukzFBUoFTwZ9sjeJwGJatcJS8R4/5mgoasgp3WqLXsKlPprwlzlFy2IzHwSb15
 lUT5P0SQGDGBnTIx5kCzHPOLaJg7/LKmnlTUG0/1jSnB3V+yYR6Q34yb/9X9pmieK8T/
 kxWmMM5aCxgU55adIoNXn9DyV3Fu80mO+DSZWBj2VFGTOUOqHTumFMlKWK2DgJwkk2jS
 m58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788394544; x=1788999344;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ihIYbwk9MLemaviwg136qnzZ070iXCIt5GZ5ewBPZjE=;
 b=V5ekNoyvhf2lB1GUJr8n8JSSfHCdCFT8KML36Sq0u3lteWut6xreJg+FbxjZZeyvi6
 2415MB9go5i5pmAHawrSfjFsM+gy24IiMeNK/LNwZafLGWbBE+VopxSNp9AM9QbPy04i
 wI/bMXBa3I2OsCp4y2BlIj9MM6eysdtN+RGg3NlbSn5mGwF4bYX7DHaA+1aZnBTHz/1E
 r8I2miC6cJct1Z3PyPQInMBDu13VkqncLVmiVh1URuKDhvrqg7Kc2fp432OqLB0xawLn
 y9I1majYf7TUQ2b7bqTSM6AAojL0fNI2IjJSOY8ubkliZ1axKpX1+KOxtcsbPtObd+Wz
 4TCg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXPqA9jdOIuP801EhwpWrqjDK1au06BlsgHoKU+Gu446QUGy/8ZCIxuuaqDDTyaR1m9tNTFaBgIkki@nongnu.org
X-Gm-Message-State: AFuF++nHvKyYN9S1q3XVScMb2k3cegn1ZKC/K/1tizTZUVbLwyHQWPzu
 sOF44ISGevXtw1wWEH/6e3LRl4PCNyNK4fyB9ZyrwoJlVfLywb9sK+ihcD3EVx6sOgnYrVsWNyK
 Lp0h/e40v/sCTMkS6/gGgntQt4or79JfUA65cctvGvdf0KnF3O4TEQkLNEw==
X-Gm-Gg: AYBFou0rSJLYNCFHNcM0rznbfwjjHyZH5RFBEtlWNUL5xYUXUWlfy5ltGt+xm6V050g
 dRRvm05MfJfPDUkb3g2MvALYZnkLzpk7BY+rsQYp9i2U/xeZuYCI7Gr9tQj4G72kv1IXQ3YiFAc
 pc3mgfSj5R9pWRsIHvmUYkt0XbTjVFpDqER1DrWx8wTy+9EO9nZtl39QmVz9kQfViB6TZIAC+XV
 72Kt74Ndnaz+drZNXzjishXjF43GVdT713av+mzrAUuWl7Y+vTJPMgNJDOMfQoWdIUnFAT7rr7P
 nkWRoCF+70I70jorhxIAXo5e3x4WNOGT3/G0+m3CboHHq4YDqWLLWdjYpTzIdr4rFF5EuanECgX
 bO5lqRYBV+hcVD0NxkdmNW947ADC9eGWo6OhjYpP96Cr4hQ2rjsw6DK/HgwkBvCnRaOaSUQ1q+Z
 TQfJOz
X-Received: by 2002:a05:622a:4014:b0:530:3387:8cf4 with SMTP id
 d75a77b69052e-53036d17a25mr116480841cf.31.1788394544385; 
 Wed, 02 Sep 2026 17:15:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4014:b0:530:3387:8cf4 with SMTP id
 d75a77b69052e-53036d17a25mr116478051cf.31.1788394542019; 
 Wed, 02 Sep 2026 17:15:42 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9ef0e9b1sm30747006d6.43.2026.09.02.17.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 17:15:40 -0700 (PDT)
Message-ID: <64ef65dc-fae0-44e5-ad96-c806e0a6d8d5@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 19:15:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] target/hexagon: Move to do_interrupt() (BQL
 acquired internally)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-9-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260902152044.31291-9-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAwMCBTYWx0ZWRfX5k00rSpxqbrZ
 7mHjP6FTV/q7jR1t48cnE8E82NinYGwJ3xuGONVpkCBRPX+jrIYyrFmLRnYGijAxA9NRnQduM5O
 5SCKDZ8THFZDZFXReVSR+wlMiwvCv7R7qyFxf/w/m7bD/UfCiBW1uahaoxZ5i3sD3HlgKJowLxQ
 nf7VXCVUgUZDgmz2pzpPn9MZaOydaD3rqQHcwVJoWJYLma7CkP6C40Bh4tkcAHYpon9AVnSC47k
 MVzgNTiByfYlwZIR3E2M49HBtgQvjOzoQUvGd4aPv0xbn78cS8aCQbhMaEDqB3rMIc3IpKS3Rjn
 emNewtYWRedKBb9fX1Cm15cQp+uC3AdD/Gpn+IIOocZqrqkSpqiLPl/oIp9ARNFzIugcckzUtq1
 H4RerYwi/TDQ06N+m2c1oYgMHE6v5gc2f8prfI+XPuEz++Ycj1U3AG6sZZL20xLpBrpwGmB3wf0
 xi75V0IfExv2sGjLfjA==
X-Proofpoint-ORIG-GUID: 17QtcLpgl-Iv2WtOPUs5i991kJfunB_m
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a98bc31 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GUtW-XfJRLY4ZrtkAG8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 17QtcLpgl-Iv2WtOPUs5i991kJfunB_m
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAwMCBTYWx0ZWRfXw/KJKsHL4y2J
 +A4gu5rgXRAL/3Oa3UuXuMsXZI+1T5sjSCXdJD4yjccOTT+aHia+wng46TtDaZuTeTLXl6hvKPw
 249lpCWExsyOHjIF9588zl7e4KJ6r4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_06,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030000
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/2/2026 10:20 AM, Philippe Mathieu-Daudé wrote:
> hexagon_cpu_do_interrupt() already acquires the BQL internally,
> so register it as do_interrupt() instead of do_interrupt_locked().
> This reflects the actual locking model used by the target.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> ---
>   target/hexagon/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index b5dcbfc99db..7067e5b70f7 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -769,7 +769,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
>       .tlb_fill = hexagon_tlb_fill,
>       .do_unaligned_access = hexagon_cpu_do_unaligned_access,
>       .cpu_exec_halt = hexagon_cpu_has_work,
> -    .do_interrupt_locked = hexagon_cpu_do_interrupt,
> +    .do_interrupt = hexagon_cpu_do_interrupt,
>   #endif /* !CONFIG_USER_ONLY */
>   };
>   

