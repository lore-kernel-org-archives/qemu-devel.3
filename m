Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B555DCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 18:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL3uM-0001r6-Su; Thu, 07 May 2026 14:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wL3uJ-0001qL-3Q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 14:57:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wL3uH-0002qz-BB
 for qemu-devel@nongnu.org; Thu, 07 May 2026 14:57:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647GWxKs026493
 for <qemu-devel@nongnu.org>; Thu, 7 May 2026 18:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BwA9O7oOBLBGXGmJQ8hzfjPV
 VzWmEYzZEr7D6zH52n4=; b=RKrztfgghl3flq573yf6CTjInmG2QZxy57QxrumN
 jTm7qCsvoZfn0NU5CkTLt6s9VA43ThcS2jQqM9aa1ZLrnkCcWKCIEstQFlqAfVDi
 2BB6AlMdRjYS2esElSpC5M/ODmPEr4JuoYIn/RDo9gmCsG39Yt271OH6ugcjArSn
 MxFAkfLMQ7ohV51mehWwYSAUb3yI3RjgVYOWt+3olEXjwq8Mlsw0X0xfr+yL8LYw
 /eRGm5Y70T0LFYUq8JqmRhVbi1j0vVkdpz84fndVZL2LcndH50BlgT6MogOf93nk
 KgBQL7VIUpUecUbI93ggPV3a8yz91xMHl6fNmMnbh02g8A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t3gta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 18:57:05 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12dc3d81736so1405694c88.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778180225; x=1778785025; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BwA9O7oOBLBGXGmJQ8hzfjPVVzWmEYzZEr7D6zH52n4=;
 b=WtituRB5FAc7UOjYbCiNty7I6P7qb3ChIpleMAtiz5n+mIo22tSyFhUewDvjWyT0HC
 57Zmy7OC+QxcAYR3onhuIhmH7rEKV40RURXOH+3EKG2at70D7zOwFr6CxTRYTtxSIZCU
 XF5F9OVggmWWuF1twoAwVmcJNe/3YYUYkbrGiftERHOPUuwfRcWFDhjkVgqUQ8XiV4If
 mII9xhSyeNYornAy7q010PpzL4a5bd9dAWgk+oobi0u5T2sh6oCuvOT93ukDHlFOOyXw
 p58tv0DIbuQifiF3zbPm/A/W19Yj7pub0UybWHoeP03ejnmZ17qjPNyK89Lk3+oKEh+q
 ZeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778180225; x=1778785025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BwA9O7oOBLBGXGmJQ8hzfjPVVzWmEYzZEr7D6zH52n4=;
 b=kaJKlA6ARsG6fW0hcmTQ75LfjUQI8w14A1AIE8GFHQiOnOxyTcN3fTxFyJTu986uxT
 14ct0sTaZ6IO/q/6InLzqEVW6a4MBBw8njOhDp3zPuyze60DkcAf0x4IN9+bOtxW48Iz
 wCJCxIqx27QS59qTaDmeTx5/rQVbbtdT+eNmcIkoJ2WRsX3rKn7M1F8eWd4BsgSiV3ck
 /i+IBmklA7X3LbrCCfUejV4GWGcc2YYP5YcMDyW+lvGzn+zZFZ+5pkDkwUM+bKF7Z81K
 S7JoIO0jtuGAYVVOQZo3wY1LQTsY1eeIdV6N48qVWBxH7ngYNW8TCQ/WNzpaFdmhAPzA
 5qjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96LE/ojeQjx+GeTpJmVBFHm+b7x6VhNbKwDPWqSF2XnnxiPoXSNnUE5BqeRaRAc6Usd51N3KMROGgQ@nongnu.org
X-Gm-Message-State: AOJu0YzrOU4tyvKj/OuAlLL7/es7nDNmInS9E9uW4cPc2DM7gsrDXfvf
 AGojbCRFhcv3rRxNj2fkotCr7S67lm7alDg4gjNtGelXJeaj3x+CgCPJ2JLWGfe/i9lVwVU2rxY
 QobRxQf0et2hUrBYajnsOw1nQbDZNJgStWZ8iC8FQvKlYqRIgWpv9byiPpw==
X-Gm-Gg: AeBDietxztVWDqGUHGILoY6QZNL4d5K7gXbCtFm53dCiIgHBYRSkDrWY/eGNaZ51uoP
 EzANeMYh5H51xCXQW+EBm0Wg5l46FxgG0VcXpuhOJu3pDwLNjT5l0Rti93OUZPfmxh+RlDfM8rL
 5/+MFCRSJc3IBZuMpEpqi0V5tlUz4wRofPHBPtTIyay9ZA5e7DmzfhDdXuHHaxMrwJcdKVTIAhF
 Wdbq/LM47VI7d4kjPlx+p2Qizboiyj+/wIx+Y0M2XV91T0Qo1HM0wb0Lf9Obw5MmtvLmmcKtNf6
 aWXSIcJ4b3UBdfSoFjDssuhrKTknE694hBZB8fRsPlcf5a8JlsweDvInAHSmvkZTDuC6dB84GVf
 HfOhHMlgHyvzqYg3PO+Rdx0qI0CMZFh8=
X-Received: by 2002:a05:7022:ead2:b0:128:ca83:5aa3 with SMTP id
 a92af1059eb24-131967d7ba7mr4832894c88.1.1778180224484; 
 Thu, 07 May 2026 11:57:04 -0700 (PDT)
X-Received: by 2002:a05:7022:ead2:b0:128:ca83:5aa3 with SMTP id
 a92af1059eb24-131967d7ba7mr4832875c88.1.1778180223914; 
 Thu, 07 May 2026 11:57:03 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1326c620538sm221536c88.11.2026.05.07.11.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 11:57:03 -0700 (PDT)
Date: Thu, 7 May 2026 13:57:02 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v5 6/9] target/riscv: tt-ascalon: Enable Svadu by
 removing Svade
Message-ID: <dic5owmgvmaoqhiinu3v6kcdyakwt6kj4ryfw5vm446w3pv6mj@77kcjokjpnem>
References: <20260507043838.45652-1-npiggin@gmail.com>
 <20260507043838.45652-7-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507043838.45652-7-npiggin@gmail.com>
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fce081 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=5fg1JsN7CA_7JDasm0EA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: P4vKWIgvZOewSn6B1NeJRSi4oB4WOxek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE5MSBTYWx0ZWRfX5hnRplCh/d+t
 7M9iSgym0TZrnP/TcpUynD+NMuqZnngXI/nUpoArkaOgNufOnhn74QOmS2rW2fnGRLQpZgQvspj
 EGZMnMEglZGVhv1WpWNY9R5VLaufnNe0Kc3jimpaffj+LV+iVcV7zz28tWCQlpzi/7Kd5v3Hh7l
 ikoin5idrBGaVGcyY8ptCRoabrZN8jhTHTJJv5YMCBuPLJ10Fw7f0X/xeVciqywW+R6Ytx5ZTDU
 ly2PSmQbYrxJzl5bpNV31ZXjGoQ5LNBs1NxbQAtTcBi6kbc8vlHL9a8bAA5VIowAQr+Y2DbbEI1
 8lJkOstUEVq/0+uSPGhPTJY7WaL5akGI7vKrrTXl027tXyiY+6X4YrqQ+NZwpdXnuFc6tfwdK21
 ds0U6FKDWgo/9EcyVy8MaWAw1z+vMPnvujD4Jn7Zp8gbknZSThwOqRBbwEzEXVvRo86uTPBWZS8
 UwtObh4QoTvDsBiRwQw==
X-Proofpoint-GUID: P4vKWIgvZOewSn6B1NeJRSi4oB4WOxek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070191
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, May 07, 2026 at 02:38:34PM +1000, Nicholas Piggin wrote:
> Ascalon supports Svadu (hardware A/D bit updates).
> 
> QEMU makes Svadu and Svade mutually exclusive, remove Svade so
> Ascalon comes up with Svadu working.

Hi Nicholas,

Svadu and Svade aren't mutually exclusive, you can see the expected
behaviors for the pair in the commit message of commit 70d22fd92c3b
("target/riscv: Gate hardware A/D PTE bit updating"). Does the
Ascalon support Svade? If so, then it's probably best to enable both
and leave it to Linux to enable Svadu with SBI FWFT
SBI_FWFT_PTE_AD_HW_UPDATING in order to maximize the amount of
software supported. But, unfortunately Linux doesn't yet support the
checking for and enabling of SBI_FWFT_PTE_AD_HW_UPDATING. We still
need kernel patches for that.

Thanks,
drew

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 69649462dd..97e3567264 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3204,7 +3204,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>          .cfg.ext_ssaia = true,
>          .cfg.ext_sscofpmf = true,
>          .cfg.ext_sstc = true,
> -        .cfg.ext_svade = true,
>          .cfg.ext_svinval = true,
>          .cfg.ext_svnapot = true,
>          .cfg.ext_svpbmt = true,
> -- 
> 2.53.0
> 
> 

