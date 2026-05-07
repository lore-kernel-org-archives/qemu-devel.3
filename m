Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A72ACD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKolW-0002DF-IT; Wed, 06 May 2026 22:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wKolM-0002CV-Jr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:46:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wKolE-0002zR-Nf
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:46:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646MNHhL3309065
 for <qemu-devel@nongnu.org>; Thu, 7 May 2026 02:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HJvi4hlaTygnDdHW8ahJticKFF5AZYu388W3EaZzwOg=; b=LFVSmkISvDWsN1aA
 vAQ1fvFZjOsZKK2Zp47vkUJKyMBEXkBeRBxl3NdTETjMLKpHhfHqf3wRmNfGgG4B
 ubCLqSeplH8Nbox1G+Pd4waCg29IicWhei7E9M4dkH4mMOvOfYovYDASOm4t+Cqm
 mCCkhZ376uVMiQhZpuywHC6aWDDek4gWFAdba7yIdQm0FcvKlmHzjz6Re6+S5LxS
 DJkn0vJw0M1gP0FW1B6LnrXoYviAySpc7D/xEq5X5RKLsE6RLOM/3wia6qsA9Eqk
 HFcMQk3lWyEu9AT8camYpYaqnei6Vw4glr98wNnCHdpjU5nVC6lPh16DUliRFpAi
 2VHjKQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e078sjba2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 02:46:42 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b52bb3ff88so37957586d6.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778122002; x=1778726802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HJvi4hlaTygnDdHW8ahJticKFF5AZYu388W3EaZzwOg=;
 b=kIUot3tWV928iMKI6f/CpmzVXmpkU6gU4GDCEsD79ZeC+GEDUYIX59NsB/Fxpscgdw
 s5DHI2tBuxLh+2+jPkD9kDXQ6fgmiVaNOwMMkcWrpj8wMFeO4TuKdLFE+70SyREVyPMj
 y1q7eJra7lqZMPuXp6gzXc/gWcE3RIalZZY7jlXSwNjxLCSgwzqqwd7Vjova8ldfq8kF
 CS9ES5YwY8b0zdd5lXUvpJWLKT7nr/9Dld3Xz+/IVGLO4Dx0Jc9x7aRQlgdm36K179Eq
 jyo8RhJRkpfMMDL0bSZmgqXa/534L2h9Vh5uoKoCBPBEP4/hAMSyYYDj/n890bP+h771
 +8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778122002; x=1778726802;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJvi4hlaTygnDdHW8ahJticKFF5AZYu388W3EaZzwOg=;
 b=nvlZoOIRdXy2ZGP5xmXc+sZzX8UAUyOg9sadA9/1gP8GI93KuvoEO65Qx0P30uPlLt
 fNNy+5p1PggpyBXz9vUrmR2t0K5mUgYmMcjUARPHXdAdzARqovzhimdsQ6gr+xr05xXy
 q8x4At/7xcgNfod92T8TluVRuCoRTVKI4ga9IAuhktEolxU6ix2fI+ShukacsJg/WhIE
 JfBjZv2IluCX9VG74qCwAVArm6yYZuEfwMUxDh144pmza+epmLo6cUp9wrnxSDQw023y
 S2bLpr1ogNXHQt3YCIkr0WFQRDWXDgZPvRaxMGPoPsksQAwbZu39U+Th7vvewTrC9x2D
 AAkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9B6JYdli20U5uMpamw8GDPVWoWDLjUoc+nb31dD225T6SCkqPI8LL20M418kx3S0V+ZSakKS7NAXwp@nongnu.org
X-Gm-Message-State: AOJu0YwiQ5KStK0DJ0NEGCON8cSDxhuXL2H52VMf01u/u73CcjkVltZP
 B61KdmWyeyvmonQrVtoCfURLvybu7FXLptmuJaaq9fwPRLb0y7fGpa7KO0DPjJNske+MaqRouph
 I8JKfjpPquYxUgW/rP7Uqcu96m5FB7nDIE3Y3xaRrgg8GVncl6wF0tcjosg==
X-Gm-Gg: AeBDiesBQzsFVrV0TVZkv3YRO+oovCqzb096UikoT/comNuEkgwmUocRPjj9+VUwW2U
 zNxn3jQfh1N1SX5CtyXY5ciuNtD8sUPArerGZT6WX9IdTD/+zpAraxUyr2txfRfixd0jLanPHhR
 alwInfG+Ee2LlAxmolx9MEB6HhBNDoA6I37r2xKL5aRgXUCvUykOdQVakFWlp1wkAOoKXLS2Fhs
 R32YMQzzHS7tTCLLoHWy1HTgtoWF2K3IlkRAkgBDDrGlb5NGl8+MFCDCdbyR5ZJh2flSjsy+bS2
 5ML4LGdpgujwlThqPpPI82nLRi15FXpcnz+DH+rjakfrDN0P7Sgtgv+P8ACU/GZG587OxgAlvko
 nniJSP9mnVpaCyMCemYNlMXPCHd1f8p8/yRoGii7RGgKugDZOgnUwtPv6JiTe6v5XHNUycQ==
X-Received: by 2002:ad4:5ce5:0:b0:8ac:b4f8:ba0c with SMTP id
 6a1803df08f44-8be18ee670amr821026d6.6.1778122001713; 
 Wed, 06 May 2026 19:46:41 -0700 (PDT)
X-Received: by 2002:ad4:5ce5:0:b0:8ac:b4f8:ba0c with SMTP id
 6a1803df08f44-8be18ee670amr820696d6.6.1778122001176; 
 Wed, 06 May 2026 19:46:41 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.237.136])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53cd84d65sm197458716d6.39.2026.05.06.19.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 19:46:40 -0700 (PDT)
Message-ID: <0daf8491-4677-4b42-84c9-b08107158c61@oss.qualcomm.com>
Date: Wed, 6 May 2026 23:46:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Maintain OpenSBI Firmware
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260506234243.1873782-1-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260506234243.1873782-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Lc8MLDfi c=1 sm=1 tr=0 ts=69fbfd12 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IZaa5BNpKBTNMhuJoHisKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8
 a=69wJf7TsAAAA:8 a=kWfdA63fzzvNSafTmaAA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=xVlTc564ipvMDusKsbsT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAyNSBTYWx0ZWRfX4GwbxPBdFf9R
 K5sh2oCLtdPw1FM4US2RtOubfRnLTNbZZ49M7wTU8Voun4jpHPIF4b95YLd+ful90hmoGn9xf9C
 rcs3D+Fu7RlLmeEZJbTvS6r/v5VB4FwgDG74wIf2zt7ysD+1x0/iAoAFrywDUaeRp6zfDCRNlSW
 UXexEM/JcUe+auEMt03toWvIY/YjFLR7ue/LOYdBfOap5TEkwWg3dHPHc3zUyMwZg3YHFCM0ao+
 OR1FNl+q75fDgWxTQVyLtPRTKDEnolxn/F2SDJiMZiBW5PtzcMj2ZdTb9+4gYGieryZgN1s9QTn
 Ez8RWDwFTlL6vMXxFo9KNxP6OyJnabYVF2AdCvXlARhA02CJvxFdu25MM72szSwN+3V6RyU0HPI
 359C0mmug4q0wGJil3a7lteL+u3ROH+93UEx4kyfoAIbfXpiZU1xRLWUigzfP7JOjYAIFk4D4mT
 RZUzplu5B/vxu8zHUXw==
X-Proofpoint-ORIG-GUID: RlyxuZxt10n7u3dQeUf_biLCcRuTqyhi
X-Proofpoint-GUID: RlyxuZxt10n7u3dQeUf_biLCcRuTqyhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070025
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 5/6/2026 8:42 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Mark the OpenSBI Firmware as maintained by me (Alistair Francis) and add
> Daniel Henrique Barboza as a reviewer.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


And speaking about OpenSBI I believe you might've missed this one:

"[PATCH] roms/opensbi: Update to v1.8.1"
https://lore.kernel.org/qemu-devel/20260108160825.171794-1-daniel.barboza@oss.qualcomm.com/


Let me know if you want me to re-send.  Cheers,

Daniel


>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3d645953..cf91b9f9f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4044,6 +4044,8 @@ S: Supported
>   F: hw/i386/amd_iommu*
>   
>   OpenSBI Firmware
> +M: Alistair Francis <Alistair.Francis@wdc.com>
> +R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>   L: qemu-riscv@nongnu.org
>   S: Supported
>   F: pc-bios/opensbi-*


