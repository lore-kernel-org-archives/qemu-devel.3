Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD7FC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x240M-00058L-2B; Thu, 03 Sep 2026 05:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x240K-000584-2P
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:45:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x240I-0004ug-Ad
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:45:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68392UNs4079001
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 09:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +k1C+3dWXGoXonQkYAa92PTIcwKecSn+QWt6Xnbhe8o=; b=hi2Vggy6P699G04T
 c7LOhrCOXckgWbRrQ8PfsswYdaXCNSPjhee4QfvXajYswiKArTZ8vA14bpvkqksx
 OrCHs+u3+SHL8LKxpALm8BnBNCiHEfRnKLHJ/qYSRc3dkT3iixKd1osQTqIWu3x3
 cabOFXmaWtAwdYKA8eGK+hOOjCAS1FmEJxt4awKohWH3ElVreHuRCLD+fbg0RpMY
 KGmvwkrcR1zHOlWipJgex+BZ2QgNn8AM2OvIXK7sofdreeu2LJx8ABFFMC8Dgp0G
 1A8OVOWPyTKuF2gVpZznMPTmi+t1/SMr50kGLBykhoLIFzGqigyzd1wNHsSsUWMk
 QzIB2Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdv9df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:45:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939062ecda9so318130585a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788428704; x=1789033504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+k1C+3dWXGoXonQkYAa92PTIcwKecSn+QWt6Xnbhe8o=;
 b=aQVDTKdGXaVivwNtXh3PEAuHlQjt0KZLewXXaci77MLXXh1l8xXNNZtnKn1ZYmA8Ta
 N2zxzhd5BRxPmwQ7PImyaX3WVISINbOPlJtrv9nQEFIe/GTJBfNyz48yQCs2sQRXDnfK
 K20EkVWRJrgavsDVmFscYWJra3ZVG84hYvPMnrYn+QGBwr2Lz4R4gff+fEyHc2rigaaQ
 jtk6oXSmEMf80C5aMoKVhRn3CDywM2JryWVJx8+vmoK4Z+etI2Xljjb0brDRFVV2R+UO
 vi/2ksBDFcahYZLBipIqI1/21lCIYFCaYR3Q0z5WkiZWrFrMLFltaTASMfPpNNErR9IQ
 RifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788428704; x=1789033504;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+k1C+3dWXGoXonQkYAa92PTIcwKecSn+QWt6Xnbhe8o=;
 b=Mr3tzw5SB/HGSmv63jDQGUfMc6JPw85AexnB2HttuUx3Gz4FHud0luXKJz3SX3t59S
 udUv9NBs9vaFu3ubrj0dfMxiHGUw7bU9rlQtWp4oFXGCtZgrjgsymKpj+qbw96NSRYBE
 MjV7EhZmSV391UvIkuKLNSpHdAaMzLD7I0+qN8eTOT4Uq9wIILzudGf17/J29y4nxseI
 0S15S8KySGq7bKmf/2wN5ForomMXOdnNPAjU4OzPPp894hmhno5yHKJESzeZFjJ5LR/J
 J7P5NZL9FtuSnonKvrvjQgo55SNQyEIflvVTtCYiPpsqWz+hZ8Wx1KSeXlGc6V1MOwYS
 rOpA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfSjeJlGIYwF136sjc4VRkH7odorWS5zJHGhVQQiDJsaVJylR1R22/gbF8JgvoVCvExFUl32YP3zAH@nongnu.org
X-Gm-Message-State: AFuF++kKmlKIN+nTjFRuxN27n6cCtv6Y55rblshDBeBd4xCbryc5+oYC
 uv5hscCEG+T8lQWryx2Lbbb4z91P9jyJjMM5GWMo67uJUuWApKN1uiragP6hazHHymYTFbpQ1Aa
 FOSJC6Np7MNy5tzGdNJRvJCeQ/iYt89S0i3/m3ywIIp3H/onaHp+eHX8Y6w==
X-Gm-Gg: AYBFou0oLgfLfiP0sYvrCicCHtk2re/Qx2LKGgi7mRe6FguvZioubNtYZOVC6/Xh5Pu
 txsdFrsI+7Cx67E/u7LGCXmzUw41QSHFc4yQlhzapGDqbgWC3d+0Ozryh/2+E7IFyOVT+45/xFv
 f3hVns3X7E2CjaOEW04vQtevGDVWZPxJAqTfNtAYuj6lEWdGfZd/YP4nJhZpcp/zJRGTxhxxWhi
 +J5sb3o6f7lkNbdCdflDIveRZ/8TddndQMlKTL7icD/uMA7LOENbvd3WPN3KnZvF0zzzDFkmXi3
 Yv8WdVDZOty1HuDDUYRE8kMUXcBCJCMiJidpIOR85M0u151EYirEzTc1ECurKowiKSdZpweFm1m
 swn+35gV+jBFYMSjDXFuAnJ4edLrgiLhaTQ==
X-Received: by 2002:a05:620a:2991:b0:939:70d:c454 with SMTP id
 af79cd13be357-93960edccd6mr1127663485a.23.1788428703634; 
 Thu, 03 Sep 2026 02:45:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:939:70d:c454 with SMTP id
 af79cd13be357-93960edccd6mr1127660385a.23.1788428703236; 
 Thu, 03 Sep 2026 02:45:03 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm69131705e9.9.2026.09.03.02.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 02:45:02 -0700 (PDT)
Message-ID: <174392f4-ca6e-4f61-8b07-1601ad8be389@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 11:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/block: Add migration support for pflash_cfi02.c
Content-Language: en-US
To: Om Barkare <ombarkare123@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, kwolf@redhat.com,
 hreitz@redhat.com
References: <20260827193942.69406-1-ombarkare123@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260827193942.69406-1-ombarkare123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a9941a0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=2BWOSehmHWIufXdJGhAA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: r-Hu-O-K3yT-9JJMUT8O143wl0lG8gSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4MyBTYWx0ZWRfXwtrM3Wk/o66/
 AsoRW4i4CvWPqd1yBT9zns1AdPS45lu0XhQMb+3vxBoy9Y8q09Zdg0O/KYDGaVQXdrwF2QLa+po
 Y6T+i2b0K2/qnE7M+UvCo/byCJS0X7xol8zoJhPK9Hr7cciNiA4u+T3oIowQCmumq5cXJsolRy+
 URDbrTEjQ7U5WKksB5O9b8rb4rnZ+WOh8COEli0q5N/qG1kdxJxx+WlMfyNTWjTO4CevEH6gizR
 BSl+mvq5GCSPBHjO+OkhpTUSdCc5IUTgCDDVDzNqilHfneEVSMIK+PZW7RPkOPzBsYisSv1bRzl
 njpC5z2gV72PKQV+AlCX69T61+GghtF+lDpswP4xHERND53rCIUBpdVQ6akq0ABynrETnL7/Hs/
 oPsBwwJbOF/HpQay4gOdXjD3XtHsmsM3xsSxUYsrOwAA+egzH1qGA/aHtPejU7S1OBx2OVMJ2eh
 lt/pUFdJZdfPXzcJ5AA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4MyBTYWx0ZWRfX4MNke99yv18l
 btzSiGDdQXQZ2sjTd2GeUbcGUCIPD+Zrc98eKYyPLWgMdG2PnVL3xTT82WMhFRTJopVUlbBFm6G
 +y9W3Bm9EZTAyNJWpNZoiJpGpggZPl4=
X-Proofpoint-ORIG-GUID: r-Hu-O-K3yT-9JJMUT8O143wl0lG8gSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030083
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

On 27/8/26 21:39, Om Barkare wrote:
> From: OmBarkare <ombarkare123@gmail.com>
> 
> Device did not have migration support, which would result in its
> internal state being lost during migration or saves.
> 
> Add VMStateDescription to serialize state and set memory regions
> romd_mode to rom_mode field in post load hook
> 
> total_sectors was changed from uint32_t to int32_t to satisfy the
> VMSTATE_BITMAP macro's _field_size argument, but that is OK because
> it's a value is calculated using the size of the flash and it will
> never be large enough to overflow int32_t
> 
> The only boards using pflash_cfi02 are the sh4 r2d and
> the arm canon-a1100, musicpal and xilinx-zynq-a9
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4157
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Om Barkare <ombarkare123@gmail.com>
> ---
> Changes since v1
> - Add "bypass" to vmstate
> - Remove the vmstate subsection and add these states to the main vmstate
>    instead
> - Remove the pflash_erase_sector_needed function which was related to
>    the subsection as no longer needed
> 
>   hw/block/pflash_cfi02.c | 52 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 51 insertions(+), 1 deletion(-)

Queued, thanks!

