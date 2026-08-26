Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCCDC61DC7
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHAL-0004OI-Ev; Wed, 26 Aug 2026 13:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHAF-0004Nl-Dg
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:11:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHAD-0007KR-O3
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:11:51 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGuotA424862
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/usUm+l9xZtNjzYYU/j6OeqVACmC1dJNC0YmYQ+5yM=; b=UWzFLGrW3uoizgYN
 XJqlYxB7iWm1Uc/rV2lWshZg95h5SeeiseUYimu+6qNZemjO0ctq3ESit8rzbluo
 duaCKWTYeOL5QFuG6T2hi1a5Egy8YZSD1pIcaMIrj7/SO50L7ctzLOToUJZXpMqw
 ZBOyjWMAScCuM9zyef6QIi3Jwtb8lb7Gj22NvXrPbrXTmyWn5ZzBhzRluqMx6H4a
 upLcki6bLXpgSCYyqH9ptyb1Mwi2AhQhGApJcpIqwSske9vkSBMXJ4cqm77bhqH1
 SoCo6KL3LY2Ax9p4N6StMtIVPf8p8dp19k3t8slIS+zd/2QGrzRgJaA35HbOArk6
 x59oiA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9wmqstha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:11:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso9520791cf.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787764306; x=1788369106; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g/usUm+l9xZtNjzYYU/j6OeqVACmC1dJNC0YmYQ+5yM=;
 b=bslTbfb/a6BUDxZ6ciapj0Ks3cvuwCGSSUyEOr++oWGUFiH4AmRG4tosT5/Jolzgg3
 Sze8p1XiPtFpzsq86jnatwqw4Bwuy2qfYgwI30FFboJm0RbTUN8gj7IrzwzUYFpACSBw
 +ed8zHwux/XDWFN/dVJ2EfhxqGp3xAh0SpgylMRjIB4DRiv1V8m6WnJXq8jP0in916M8
 0ZIhuH1IpTh2vu97O/YBo9gvdPjlno1cX8LuU8LEgd/0yhmtD00eZl07R4RsV0WVrbTz
 9gXPnw61aGfZhg+b+DOpFxfVGGiKBDYfIR+2i19MZcidIO+WOGP7bLJhqmxvzAZZECNt
 BNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764306; x=1788369106;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g/usUm+l9xZtNjzYYU/j6OeqVACmC1dJNC0YmYQ+5yM=;
 b=Em1ePCZCPsGcvaoE+H8qnzPX+rl5bnEn60B2G6pnOjpZ1rUjlIUQ5yVR5rP4Tby4/i
 /Fyr9nsX1sYwAvd5q3hDKoCQiqbtARHk6i7WeXw2e6gxamAqRyh1E7BeqN6y83Bb8tOC
 TJn4JLax37IQkkzgRjEa9e+F4xN2k5KcmY5i3UtTK+CI4De7YLsB/HzApip0xuaNjqrn
 pPOTVosTkGATfAD/sDEkCgz9IIFWiohtOpzQd7iikLBlfr8aoHdaS2AucwJgRZtiSslk
 FS8mwoBKnJyAXWC6Ow+OHdvsCDcr0Y3FUQRRqpx6OAIRtJYNCHkkKAN0qNOcymHfoDBz
 5xhg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq93xlx4BQzVFnsVLpfM8swKTojg2vMm35zZZNKw2f1l6zV9o8HY4g0dRP8IDBc1n0qmvNqFOk2s+X/@nongnu.org
X-Gm-Message-State: AFuF++nGfOmJcYlzvZht1buTXv05nQ0/T26Phbec863cnTRVIBIqcLnf
 5g6FyETvzgRPHyvynqgdNTSN4la7RBPYB81WiKamTjYlIgIIO3HzsFo5izInNKdoKlc7QfQvK9N
 Eljoo/00U7rESHj8r6xHci6a4naXJuoBjBBb3xNHWHhZlBoloR/X9iUdZ0w==
X-Gm-Gg: AR+sD11m9f6y+P33lmyiuEHPm+sl6cRc0OeVkKnLtDC3n2rRm3LHEkvrOSICpWVJx+X
 cfnp5+DbRNezkdT0fcKcWWXfokOwfJb6B1zl1GJsZl2Mq2eYzQj3x/KbfAxMZVhhxMU6P8HzEMt
 SLAO/Y0gyoGg/iOs1d/UVOiioOZxTNMHtxt07KTRWjnL/T2hakF3+j8fqksdvLQ2+Jqws487epK
 dmuXblk7c/iI4I6G35mIlYVOzQIYClhlSU2kkx+ecEEAvVcuP1hbP/Hbb6UUHavcPX1SllnZNdB
 s7RYK3sCD/pjw1xk0PFotzz+O6ZexBFLkFY/kaSdiOGgZWUxf/q2OI5xcRcluQvI846b0i3ft9X
 QCgtVD4SIvfGHzjLJfSfiKxZbPLE5TSopUE9tYVftURHH
X-Received: by 2002:a05:622a:c01:b0:528:38b1:b547 with SMTP id
 d75a77b69052e-52e4221337amr84725151cf.8.1787764306110; 
 Wed, 26 Aug 2026 10:11:46 -0700 (PDT)
X-Received: by 2002:a05:622a:c01:b0:528:38b1:b547 with SMTP id
 d75a77b69052e-52e4221337amr84724541cf.8.1787764305620; 
 Wed, 26 Aug 2026 10:11:45 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88af72sm688634566b.36.2026.08.26.10.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:11:44 -0700 (PDT)
Message-ID: <14682410-06bb-42d4-8cc2-d7e86789bdd7@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] hw/riscv/fdt_common, virt.c: add
 create_fdt_imsic()
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
 <20260826164814.44335-6-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826164814.44335-6-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX0exk3twpvHNB
 90JiN2OtKV87G8MViL1RE91c08FHOraQevyuOsCnkOeUVgYczY0fWwzgtEbhJXs8nASKm7eDyYU
 Fp4XyimqOY1MQm7of+G56Ui4OirLrfM=
X-Proofpoint-ORIG-GUID: PDgzFuIDSity3_y8T1TJxe2-9GDVV_Cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0NCBTYWx0ZWRfX1r7bwqeNBXc6
 YEslAHWDck2/qyE4mOXSHhYdDo247O+CfC3WQ4xRiahijn09TldEQdo6S6wftEhGfOglkZWr9wI
 g7s2oTVneO7IaT5fJTCBmI5oWsgNf3oAW7SL9JwuySN8hlLD5Fv7ubiLvYDtVz6tUzild+PXRNW
 w9ecxAu0OAHgKbSHvmsLuAs2xm1FFCGBoERQ+O+ibbVW1+2xH8URYPhVVFN3X4BPN6D0+ilrHeY
 vMwywmVBjGqjszQiVQAB+c5ht1Vtc7kYpfQY1KIMKj2rt7qzO87ZL9CkMJLNO11Wa8ICEQPtrJT
 Lr2dtfL3GIG344jyOj0R/ZLXgbjItlafD2gOK2v02BLg89XeWuZTj/Wv6rW3sLyqk18JsUNpTbQ
 f+s37J4CURDWrmc9lWKaAWf/jEGqDY1wXVT2I/sKCdQ8MQedaYhJ5vSXt1HIpbX6XNQ6B+NxQnr
 LqKCnKdNj0AHWtSqE/A==
X-Authority-Analysis: v=2.4 cv=T9S8ifKQ c=1 sm=1 tr=0 ts=6a8f1e53 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KXNGmyrVeMmtdv23PNgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: PDgzFuIDSity3_y8T1TJxe2-9GDVV_Cd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260144
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

On 26/8/26 18:48, Daniel Henrique Barboza wrote:
> The FDT related to interrupt controllers should definitely be put into
> helpers, even if only 'virt' benefits from it, due to the amount of code
> that is relieved from the board alone.  We'll start with 'imsic'.
> 
> For this endeavor we're going to use a helper struct that will carry all
> the extra FDT arguments in a human format.  The alternative would be to
> add 8 more function arguments, on top of 4 phandle arguments that we're
> passing around in all these controllers, and that's not only a poor
> reading experience but it's quite error prone too.
> 
> We do not want to crowd the fdt-helper with non-FDT logic, hence we're
> handling the !kvm_enabled() cond in virt.c using the imsic_m_base
> argument.  This is a pattern that we'll fall back on in the next
> patches too.
> 
> No FDT changes made.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   hw/riscv/fdt-common.c         |  94 ++++++++++++++++++++++++++++++
>   hw/riscv/virt.c               | 104 ++++------------------------------
>   include/hw/riscv/fdt-common.h |  22 +++++++
>   3 files changed, 128 insertions(+), 92 deletions(-)


> @@ -583,8 +492,19 @@ static void create_fdt_sockets(RISCVVirtState *s,
>       }
>   
>       if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
> -        create_fdt_imsic(s, phandle, intc_phandles,
> +        IMSICFdtProps props = {
> +            .soc = &s->soc,

New line please.

> .socket_count = riscv_socket_count(ms),
> +            .smp_cpus = ms->smp.cpus,
> +            .imsic_m_base = !kvm_enabled() ? s->memmap[VIRT_IMSIC_M].base : 0,
> +            .imsic_s_base = s->memmap[VIRT_IMSIC_S].base,
> +            .imsic_group_max_size = VIRT_IMSIC_GROUP_MAX_SIZE,
> +            .irqchip_num_msis = VIRT_IRQCHIP_NUM_MSIS,
> +            .aia_guests = s->aia_guests
> +        };
> +
> +        create_fdt_imsic(ms->fdt, &props, phandle, intc_phandles,
>                            &msi_m_phandle, &msi_s_phandle);
> +
>           *msi_pcie_phandle = msi_s_phandle;
>       }


