Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA470CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwtC-0007z2-Sr; Tue, 23 Jun 2026 04:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwtB-0007yu-UW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:53:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwtA-0007Uk-Ap
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:53:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N8UuZ53243384
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K2OMQo8If3YZKH8ORuyPn+GMLiltDBzMAkUijrVrSfE=; b=dNRS+BcwCRwevEoa
 LJMM8aIph9/vg4o1J1yBnjoE8/N3yhXjo+YC7TPmF9Qcn6v1eqPEDHu3pCoADBOI
 b7hUbztMDhw4oHZ/iCQLcLZ1Dv3S7vNSKDGbriNq0Vc0+Hgn4Zx0v8slMpuJ6O3M
 jXAoJyXly/mAdhIxNADRo9L+YBTvt72/gIhX3mYU/pA/JB9KOy+dawWPWIgDJumx
 VdQQGCxXCahQhz28rxcSPUZU6F7N+2RUI3NSnX59HYIuoXFZV8Un2hGNb3DCJyzv
 VMdb73GrQP2lXezzgevOon3DIRo+/5EKuW0oF1yhzDa0fM7/QsR1TtNYbKzDTtkF
 4Jtz1g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppyg2e4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:53:46 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e006608708so18352786d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782204825; x=1782809625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K2OMQo8If3YZKH8ORuyPn+GMLiltDBzMAkUijrVrSfE=;
 b=WsjdcCH6U7MGSigeWHA0WZOLPHFdnEPB1Y3JjZ1AFDMOxqR0nNUV4KQv8uRyXUxQmk
 IWZ5LB+Ii9NsZPUiWKElzvpFL2QY7sLZr7GlOnwNW8NTCa6OJRyu//REMC4FT5eVjKn+
 gZsn4DErpuvnX8pggg8kYwsAzaLnGrWKAebABjZQwuwUt4Op4obCdlJJtVgefPR8JKM4
 o5ZQ/bRHk89s8kLOADlY4pagWdLnDpAnY1OX6thdwYQVo100hF744kCxw/MHRmlvD92M
 9fLMRjbtP+Qm37oeKIcKfdyjZ3BOARLZ7J3fTdW4ux/pntyKHy+Ft2RhjbEk5d7hgXBZ
 ah0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204825; x=1782809625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2OMQo8If3YZKH8ORuyPn+GMLiltDBzMAkUijrVrSfE=;
 b=V+b8PhJE/koR7KoBXNXVPhcMB8vAtIasD+MW0f1r4afPHDr2vwxXWK1i4+jZLHU2aI
 2R7W9/wxcqfTuWJE7Jf7yy5ubrjDngu9b48gXgh4XGwl0g/2mjPVODkQRnpsUvc+nI4t
 vXpEHOf4Abbghmew3b+btYYMiVC2i8dYxj43W2GLAbeFdaMnX/ULqjO4Djzo3ynQmm+G
 KT1sIz25U/WAFKPtNpZlAXg0z2hUmXassZ33z3Babu/Q/vkPQsrv4I3WPyzBYc8MK9P+
 HbsOWdkBsmdAAeBVQorOHhdzOrlmul3YFrso6j9QqPEB39hlQ4nFhEsIGk0bczymK09a
 BFkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xe5PP64oSBFDZPFIGa00IaQr2NQOvGS8lZ+yRz0q6e+gopC/AOpFJ6s5kb6x+aw9hyAOQry2vMayI@nongnu.org
X-Gm-Message-State: AOJu0Yy3j8C1N04mQkcky97p53AFs2cs4u/1DZIuTuL8pKNEYJbaBQBy
 LVQy2NC6sLWxejxsVs9+SONhkRShj3yrXpmWNcDJxnMGzmHCN/QLoOmnQ7q1Y2WMxJ3xmxBBUAZ
 curdp1MPt019VclhkKaUbLzJorVr9UGOORnFowLHd72du0i4dMyfrrpbmbw==
X-Gm-Gg: AfdE7clzh3FXXv3EzaGqIxh+oLJ0BOvppqVEpIcAg03TbCmK+bOJD3y8Y7Trgsn762B
 9G5rUiArothsQyBH8WuQOWOp/bJnXkdS/B5qr6wqng+SGYPSynKLvjQ39En4KYQCgO0OINxsBPQ
 CuBYClpha4nmB9Q3tc1XaTdq7u8Hlc5V4RJP/hlosx6ioIxukW6XRWdKZjwiVG9DkWTO7oajpgC
 pn2E7z/3fefo436LrCzlSmDgLOibQYhzhrftR6Fn5p2WlBVfcAqCZSuY8tFy7FOScDSzhYPBR6d
 +uB8lDAap370VddYh5aWKcfbcMlZIydqBJkjAo4GYHWmjfPiw3u6u+Si2qht3s/PrWgI9zuKBMb
 NjJn7vhHa30UOep9T3WJVjh11hxO6dlpFWnr/xiJVSdkH/4ZveU650ojGnR2tWQ==
X-Received: by 2002:a05:620a:f14:b0:915:9da9:b541 with SMTP id
 af79cd13be357-926000c3d92mr471179685a.10.1782204825168; 
 Tue, 23 Jun 2026 01:53:45 -0700 (PDT)
X-Received: by 2002:a05:620a:f14:b0:915:9da9:b541 with SMTP id
 af79cd13be357-926000c3d92mr471177885a.10.1782204824722; 
 Tue, 23 Jun 2026 01:53:44 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b84eda2sm4350549a12.9.2026.06.23.01.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:53:44 -0700 (PDT)
Message-ID: <26e48a07-ac1c-48ba-ac04-c6bffb61f272@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] igb: Define TRL registers and core state
Content-Language: en-US
To: Josh Hilke <jrhilke@google.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>
References: <20260622-igb-trl-v7-0-abb960e767ac@google.com>
 <20260622-igb-trl-v7-1-abb960e767ac@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622-igb-trl-v7-1-abb960e767ac@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX7mkN7vYGbh/0
 K9WSyfZyRnueatGi635dCcxVLuSl3l0yrxRbNgAARgkxJsb9cm0zSpAFLwX5v/MPVRNZzVCpBT4
 I5fTZhz4LHdsakSdIw3r6B64J3e4lsoepgpvQpZfhKLyG2l1MS8ijMEkVAhT53nwEjfAZL3aqsL
 gLSQEE+ErWY+S0t+9F8hPGpzoC6AJp6/pxv+BNxNNGQZzENnu7L2WTok0ph8n/tkYwaq+OP+J5F
 /4Gg7wVlkXOtv8g2gCKv8Lo0vwwynuobn9FI1qM0qECnLb7zJILmdr6A4RwzdoZkY46pMz8SsF+
 wusSP9YPU0GOIKeYFzXWG+lv6uTljXlzWcnxvuI+tb3EtdJShGxTCNXVhQ+Rr2HCCSWkWZrtU8X
 wiOMHpIlE911eFGJ9pCJ30pyVFNJagIB0FVzejnESkwDhuQPSswddRSC9wlqOjqsnOCgpXJyODW
 8ZF48k9+4Zw+GAc6Czw==
X-Proofpoint-GUID: G6h0voYzQAYwAJwnNXQyM0Ph9KO1tlwC
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3a499a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=PCIpQW2aIidO-x-PTncA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MSBTYWx0ZWRfX1GxxG+4JSjlO
 06FfH6P0Kfb0IJz5gcxReHw4d382oV1JYUzqZq4M3v8NnHB6s19ChnZVwKPhG7FaWS5gY8O+mbc
 yRegAcEqRxe3FRFTyse2x3G4G4wqFB8=
X-Proofpoint-ORIG-GUID: G6h0voYzQAYwAJwnNXQyM0Ph9KO1tlwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 21:05, Josh Hilke wrote:
> Introduce register offsets and bitmask constants for the Transmit Rate
> Limiter (TRL). Add the IGBTrlQueue structure and corresponding fields to
> IGBCore to track TRL state (timers, throttling status, and target rates)
> per queue. Initialize and free these timers during the device
> realize/uninit lifecycle, and reset them on device reset.
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> ---
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.c   | 41 +++++++++++++++++++++++++++++++++++++++++
>   hw/net/igb_core.h   | 12 ++++++++++++
>   hw/net/igb_regs.h   |  5 +++++
>   4 files changed, 59 insertions(+)


> diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
> index 4dc4c31..4c31e4b 100644
> --- a/hw/net/igb_regs.h
> +++ b/hw/net/igb_regs.h
> @@ -718,4 +718,9 @@ static inline uint8_t igb_ivar_entry_tx(uint8_t i)
>       return i < 8 ? i * 4 + 1 : (i - 8) * 4 + 3;
>   }
>   
> +/* Transmit Rate Limiting */
> +#define E1000_TRLDQSEL 0x03604
> +#define E1000_TRLRC 0x036B0
> +#define E1000_TRLRC_RS_ENA BIT(31)

I haven't checked the datasheet for these values, but for the rest
of modelling:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


