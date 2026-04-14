Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A28F9D0EF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 19:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCjWo-0001XA-K1; Tue, 14 Apr 2026 15:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wCjWm-0001Wg-SK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:34:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wCjWj-0003tC-Nd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:34:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EGBlie1778940
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 19:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f/RTA0EhVEFuSMh1iWoW3YxV+jiHPW5ybFu+2oyD55U=; b=jzUkqAxU6resR2rd
 vHdN+ls/f85bNPh13Ze0B7MFIQm9mWM4qZQAowY6YsKsEWQ4T6Y5Mqt5gZ7g9HMs
 rNxUpYzOeXN/JK0TnlXVUJx5U+FambVjKsndnJ6L1QlKmJlLSbQSlHc2wncFia4S
 RzWk+onXX1kO8N/Cf4OEBZgEsbLumPupgz2Mv1fL8Du5Gcq85r4fLPShH9kPvRdh
 ObkzruVeXKKOFjs8H0PIfJj1VuoG9RKOBFG7MsGK9mOLhejDX/bZO5NsZ18xPZjh
 wV4M0K2bby79ivIvsdG1PFf3f/wwFjON/yveMVsVHW8ee1OL2KLaP2CWwTfUmPEA
 fhdJNA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrw00qhj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 19:34:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8aca3b7b536so76550526d6.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776195261; x=1776800061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/RTA0EhVEFuSMh1iWoW3YxV+jiHPW5ybFu+2oyD55U=;
 b=H5ZyhlM8sF1oqNBfcXwh/cprdVkCnKHpMm8eCSt2ptQ3fInsL1xuTBAbWVR436V3uW
 mEWd13vLuqYPiw73Aft2W9U+FGxKab+sZ7LO0yabKvSRd5djFibQmxHq/ZA3DwVx9FfL
 ZFly+ZQkJJtH/PMyt57DuVkqqdKGkbXIOemJJvaovDyvIt9jYezRriVbGRv5nLzuE73J
 iLMe3nzI4lh4elwLLjRDhOWdg98EO6bXe4uWy6PP/HoqdJHqQ1gjFBQ2NEQ8DobM3khg
 sEpT6VrB2FrqGIAhPV6tTbzuclkGGFwc2Ytub20Fm5/gH8UmyKItXgnaKRME2s/YmrN9
 K/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776195261; x=1776800061;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f/RTA0EhVEFuSMh1iWoW3YxV+jiHPW5ybFu+2oyD55U=;
 b=IqfoOoYGIZTEpNcUdu/c2Vr4qT0qN88nRAylzYVsXp6IF144F9aXDWmIibqMGR3/Ia
 ObCAA/z48UbNGBFNHHz5oS6IeCsdbeqzz8HbwaXVk/ZbthKz0S6stpdjPB764egYxLu0
 8k3JOUNHhCfHYC9Liubb1JRzt9Yq7bIpLhoS5PXISda39PXPS+kr4roiSzqnii2oZicl
 Cv8gojfutmvlN6AYk0D7XIT8Jx076hesKtNHoyJb/8R5KtkjKK5QCqRZmsIh+6DVM1lF
 91rddvrk4vruDrdgcb1NSuerzy2ovQ5AnMM1+b+wQlT/PdNCh8dqnA5L37iK7AKlZ9O+
 woPA==
X-Gm-Message-State: AOJu0Yyp5I7rNaR2e9W4YVwY/91yoRSHO1MwFYWdIReVg5Nhq3Lxamnz
 29vGlAT9h702Nh8stes4doOpyDZUmOEUS8+kmI/G0yQkGH+hw2ybjI4jMahwV9icM8UoWWXtkKz
 NdmOIqcOD8bwyj5f35LRGD28E/RbGyKM3hI4cUF2JW2sJHcYK9OeWZUTXrw==
X-Gm-Gg: AeBDiesbpScenoIysd/SRMZvY2SFDEgjJVzCD0oN1Tu+L58uwGwxgow9WOWMT0RO7KP
 nSdjE7Wj8APHIiDLgFVyjfxY9RxoBy2FYnlNfdY3rF+/RbzuMetIvUgRoL0lcCqjwl7yB574xL7
 SbWwerneueaZOPKckKyrzsiyNENhvxdzZ6hn0N4xKOnedsV5WScEDwtZIIfJq+yy/75IPOjanZR
 H15AeBkkPs34S/uK0LmC31xQFum5D1/lYI4Hl3YeVoOEeN52X35bsancQCYuWnCEg7vTqSaI9/j
 /3SOW5234BR2u3+L4LgnfApqYBND39/kryJPzgMJi6ktGhE/uy0zuHLHJf/bpeBm9SXyQ5823HL
 tQC5xeXyoJ2nb/OktRBersWsgZ+2RWVuQWJ7i7Q+9Nbz1uRCOkXqxIlASWegOefHgiHQ=
X-Received: by 2002:a05:6214:2b86:b0:8ae:6264:53bf with SMTP id
 6a1803df08f44-8ae62645694mr48091736d6.52.1776195261123; 
 Tue, 14 Apr 2026 12:34:21 -0700 (PDT)
X-Received: by 2002:a05:6214:2b86:b0:8ae:6264:53bf with SMTP id
 6a1803df08f44-8ae62645694mr48091056d6.52.1776195260590; 
 Tue, 14 Apr 2026 12:34:20 -0700 (PDT)
Received: from [192.168.68.100] ([187.10.234.35])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84c4acd5sm123702326d6.23.2026.04.14.12.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 12:34:20 -0700 (PDT)
Message-ID: <e4ff407d-fb4c-4fe1-ad02-dd6242419b49@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 16:34:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/data/acpi: Update SPCR golden-ref for RISC-V virt
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, tangtao1634@phytium.com.cn
References: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4MHKYJKZ2Br9IMmv5CUQnrF1huCm-wS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE4MiBTYWx0ZWRfXzA5P92sl5ERY
 3it6jmg3zNLxJOCV9GaB6lHTBnyEYKWNd7c8FeUd9CBetQVWX1hFaioFgs+BewmOCIK89Zm6hC1
 ht05ISbwttSdBtdhSVdMhOHI+dU0p+ufyuSf9XxvP1I2cyMrlf91MqQyv356JIumX8uvKERnpc8
 9KuumoTGlYRoWLaSDGuwp1eE+Vvm9KDmjRWDlev8xmv6oKf4EIxg4i5/kz4HkC8Tcnt0zusEHMD
 /cS4lzDICHSXaW6cqESAdlMmgAxA8FfvUmiE6wrdYezyRlofHGLEMVEJTk+TAOkhgciv2ynQi6B
 bkpwVei+FPuPqStudIzkzriyouce4uTkwZKDpC6l23GTkjeUBITdcpDQ1tPp4AQxlInfmN4KdBS
 XdXU5OKG/pHlcQtD/U2Ew1c49VDVaoC+L+xoiCMwA27BMiMX8qaPC6k05RdviAkULrCFpFQViX3
 iiD58UIzD2ErbamHTkA==
X-Proofpoint-ORIG-GUID: 4MHKYJKZ2Br9IMmv5CUQnrF1huCm-wS0
X-Authority-Analysis: v=2.4 cv=YMGvDxGx c=1 sm=1 tr=0 ts=69de96be cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=oVRcNo5O0Zbo5d60hn4F5w==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=fgrLqfBXAAAA:8 a=EUspDBNiAAAA:8
 a=phTcdrftAHWE3h-k6CMA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=_Ge82aPy-h_wFa7gWU4u:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140182
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/11/2026 10:25 PM, Chao Liu wrote:
> Update the expected SPCR binary to match the corrected field
> sequence after the Terminal Type and Language fields were swapped
> back to their proper order.
> 
> This fixes the qtest-riscv64/bios-tables-test CI failure:
>    https://gitlab.com/TaoTang/qemu/-/jobs/13879552268
> 
> Fixes: 977c6fefcd04 ("hw/acpi: correct field sequence in SPCR table")
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
>   1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
> index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
> GIT binary patch
> delta 10
> Rcma!wnqbGo%rMbG3IGpM0&@TW
> 
> delta 10
> Rcma!wnqbGoz&z1G3IGpJ0&@TW
> 


