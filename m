Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AE3C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzzwu-0007uG-LG; Fri, 28 Aug 2026 13:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzzwq-0007tz-6Y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:01:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzzwo-0002Ow-Dw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:00:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SGK44u3310227
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 17:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TL/BG/MYwltrNZlgDX0CFVkaGxm9u+tfoFMlN0nioHM=; b=Eh6CP/aVGaiVVsxG
 naagbh1dGUs70lvjDkg/hf+kdw/eezvalMkSfNkdT7y8ZxmM9fGFgaXEWq8o0arB
 kZFXjqDMWdf4Ibhk+9XN+BhSbPFkmRtZbdQsoBbPvyurFm6xT2XDxhBYx0JwiukB
 cpgisnL5m3+Uvtnvlu7bSux11pggYMNo1W8TTBU0azo2Nxx0lLewjpKjUuC60nzt
 eK/grjvBbyw5I2ZzawvlkG04/hqLURO+o4EM5ZFGt/NbGNGFwthLin1nidrUt2r/
 cJGFm7Kl+YShEOHOW9RMZQA+SGPghFtr5hwBqMJu3YADOk2VupwxtKlVPxDrn0PX
 898rUg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs2udq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 17:00:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52f64c48bf2so25199401cf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787936456; x=1788541256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TL/BG/MYwltrNZlgDX0CFVkaGxm9u+tfoFMlN0nioHM=;
 b=C2VC9BpnijOVgn2gDtFtbMSvW8mGHJXaDkwWjofrs6jHnk0DgC8LBtcsE2oNPAg/pY
 1nAgXkmBhD83npZNNZ6JaT/tZFQ1x+dBJmRwb9wPc200Pmu6DHE/MtzJcgIHkNp2b+OQ
 i+WH8q250vcNDw+872IF09E0DtTBxEwICNNBHjkyh4dR3N46MCT+JHjnIBvbJ9zmB2pa
 b0+FkWlInxM262cPwSQdh4kyf9lpszROiQ54kMBERF0lQtd4UmPt4aPpXt920kx1SNcW
 QqJwfRUnP7Zp4DctP90gvHp4B0cl28ChIVuHJKlarrSOoo+JJX6NC5A4qYzU8gTntr4p
 iHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787936456; x=1788541256;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TL/BG/MYwltrNZlgDX0CFVkaGxm9u+tfoFMlN0nioHM=;
 b=IYNtpeBRQAPqi/z4Aju0zYejvm3mIA+9d1i0InhPuUPOkdYQZVH17DidcnB6gj9Bdc
 Knj9qqZpoKiG0H9RohmlS908GO5izSB5DC2/SFNtwOJsKcgLfLrFt3Hj3TZt+TiYm5R0
 z0mt1w/H1NM4Vu1KP6xF2DfICfRJ3om4gyCYNikg4kVOhLubp7M7yFzWKDZTN76M0QyZ
 lx4FbVzqy63+TczEcZy3HOa0npMbj0qJg64V2UnznClayqhzbT8uc7MHVqiTxIbqAUx4
 SxsY1AYY88eiLE68Lbk96o7KP0keHNKtXwJh2RBnOi3p00RnS7Udp8UeqPYHv8AKz9zu
 s5mg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqen5iGrm999JA/dc21aDKljJDI1bmiUx4F+REu8SU2NZTD2ysG8WBys8L8S+wJiNllVmAws1NWWz4R@nongnu.org
X-Gm-Message-State: AFuF++kEe/ja26bYVd9DKKzURn+HRLiYkmrk/8QNEIUBjg4uGkvOy19F
 uVgM6ISsQCxjN7p73WIz/0staucER/3vQZB3P2ODDbbfaMzkUvE6bZsNNFkw+YsL2J0K/e1M+PU
 fmh3PWQSnpe0ULxgt6pZ4KGyruBmC9vbANLukQtFNaXkzz+Tfrje2R+Kuyg==
X-Gm-Gg: AR+sD11n8fhbhlyyQl1AJKaS39Comko7b/FKgwkxFN9hXohntsnVcDAA0WCXE5Qaadl
 pfWOONr6PimdVy7N2l/oPL3Xz94zzbpvdjBQ45WtH1IliqmSu7yC8r+/j3arMC1qpWj9Hx2rFhe
 hx6CZ/V/+fWV9veGQi1ZloNyqMJauLXGA5IlSp0Vy/gm4qikyuaIeFnmTQK35Z2Vrisv52V5viQ
 lYJFg3dJyx6FEj0LryoqYj1CuFVdlT47s7YGuY5GRy4HYSYIUAfCvIys0d1FT7CWo0tNNnehKGS
 SYMbxVesiAFDZz0SFeKiHemLtfOXK8fvp29KhWY+fJKKAIp2JiOi13Z3lcLDZXELYjrVpbWyssT
 jwP0jNaECQKtE03rsVNzm8YSAd/BG/A98UQ==
X-Received: by 2002:a05:622a:e14f:10b0:52f:e60e:70ca with SMTP id
 d75a77b69052e-52fe60e75b0mr34039661cf.29.1787936455826; 
 Fri, 28 Aug 2026 10:00:55 -0700 (PDT)
X-Received: by 2002:a05:622a:e14f:10b0:52f:e60e:70ca with SMTP id
 d75a77b69052e-52fe60e75b0mr34038441cf.29.1787936455254; 
 Fri, 28 Aug 2026 10:00:55 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f3asm5264579f8f.3.2026.08.28.10.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 10:00:54 -0700 (PDT)
Message-ID: <ebe27967-4926-4c03-b729-cb3987022b9f@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 19:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] hw/intc/sifive_plic: Take a MemoryRegion for the
 created device
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826220528.54516-6-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826220528.54516-6-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a91bec8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=khLHThV_XYJXy2OzJpEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE0NyBTYWx0ZWRfX32IwNSJOSFye
 7NUE6bPAwSCGFdbZYYEjx64drxlwALxw6MfBMEY/LFEkTfswvUYf9TUtkMJUK7fAYSMBQtFA0Rc
 RB9fHRGnVd0WMktrz5rGYtMnIj0rF5z7/NxVIsKE+OGfc4zBs2HfWeBmZ1ImjnQTV19Hr+lH/Xh
 Xeg7GVhPlFm/2Icxas0MCH9QCkYSXsPMu0WH+IQXcYwjS3RZtq0MBqA/bTk7zMInVzgitExWeqt
 apK7trfjPgWeRHBfU2nXuqWXAHXljNbvFPw8x0Py4VhvHpLtXs7XngZ/55aYjIxBtRqhul3dVRN
 LvOikFmyNObgyUefyAVZDGcQbldFvZTUa33XRK//aciM05AuMPGWMAc1Louvy+uH1HFNkfiuo56
 IJlVQTd6K6hSAfMiv1dzmkHJOeI4oFl55KszCGWWOXRnCQJhyFi44bws2Kc0KkWAF0m7KQF22Eh
 NZssved7Jn8W6ep1Rsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE0NyBTYWx0ZWRfX2uxlTBvg47ti
 uq6sLmappm2WbtL0+Wwn8BO6Hn/iVDJJ1ps13inugsNtDRMDMMESjexwiQe644TCLoanBn2n9Oo
 xrqbs0X8AYt+K4ijiQ+pYguQdEvIuyw=
X-Proofpoint-GUID: BgAx1IbAt9GH2hx56kQaIotC_UQcvNjS
X-Proofpoint-ORIG-GUID: BgAx1IbAt9GH2hx56kQaIotC_UQcvNjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280147
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

On 27/8/26 00:05, Joel Stanley wrote:
> sifive_plic_create() maps the device it creates into system_memory,
> which prevents its use by SoCs that map devices into their own memory
> container.

Correct. We'll need more of these refactor cleanups.
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Add a MemoryRegion parameter and map the device into it instead of
> calling sysbus_mmio_map(). All callers pass system_memory, so there is
> no change in behaviour.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   include/hw/intc/sifive_plic.h | 3 ++-
>   hw/intc/sifive_plic.c         | 6 ++++--
>   hw/riscv/k230.c               | 3 ++-
>   hw/riscv/microchip_pfsoc.c    | 3 ++-
>   hw/riscv/shakti_c.c           | 3 ++-
>   hw/riscv/sifive_e.c           | 2 +-
>   hw/riscv/sifive_u.c           | 3 ++-
>   hw/riscv/virt.c               | 1 +
>   8 files changed, 16 insertions(+), 8 deletions(-)


