Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82187CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgwe-0005jP-Sa; Thu, 28 May 2026 16:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSgwM-0005a0-39
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:02:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSgwK-0004Yu-3q
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:02:49 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SIOhKF1539603
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4eI9gnPWG9DM41h1xfBXInqv5w4fnSikRn0GV5tjdCg=; b=akYjiOOiUoqFXHtw
 3BH6I0D2qO5P0Pedz6LxZQTqFQFfZpTLYVX+mXNNbkWoWCi000zUAuaZ/q+0E8Ar
 8JYv+nQuHx3ksJkmTqF8cYWNtBxnPa25Sqg0PgieZ1QvOf4gIsVPNCNdDzZFQAqE
 PJDC239vqM5uociN1vDulwigmmKLh6S5PjoYZO3/KgULySn6iee0g//+dmDYIYtX
 TsuMu9jxPGAAVAcbME9qG9MVIJ7AAVmKiNjY5l8OuFW6j+GKiCd1lRPqECH1LHbk
 yEMwhkG3ieP/Ke8vGW+afsxdw2ZFqGKGi41adblyaBKkPkOw/4aOuMXvt0XmCcbI
 z4pbwA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety50crb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 20:02:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e4636205so133853eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779998566; x=1780603366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4eI9gnPWG9DM41h1xfBXInqv5w4fnSikRn0GV5tjdCg=;
 b=UvIUWQgc2un5JSL25ST7oELd8qaaFZpFPUPA4tu6FyXPZnnlrgTn8xy8tLmvC6iAhV
 eUJDn86DQd5FBd20pzn6zF5MFCiA84c2nbtad52JzEv5WWDBfFJZYMaTnV/C0/pmALtS
 5N/2RJmuzwLZ0Sc2GmXeOF4Ns4BRvv5HKJhGvHBdt+IAUN6mQb88CtxS5/1SoBhR9sxL
 NIAmiL7WKGGGkdvigt12H0haQxQJZcUTBGcJeqbV5e5GnDianRJTITZmE4CwDDRfCuEJ
 ElKPly7cRBQCbRrnMUBdoZUvzcDwlWgRUN4EzRz9fUZuvjQ1Q3bWODyeMO+X+ZO92P9d
 XTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998566; x=1780603366;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4eI9gnPWG9DM41h1xfBXInqv5w4fnSikRn0GV5tjdCg=;
 b=XqXFzG0bpofCki8hqxftOfx4wUKkAQfNFGAbdOBP0w4YmQ7BPlHtGq6BdILUWnbdyP
 v28HlTUU1e//8uDFksZXvjftRYdrxudX4aP1wfnR0/jE4HXeCkEtk8mDoNQxiT6rLhQp
 ZHjmFrK2sAH37zC6Vbi3kjmnMVDmsJhwrriqGVokutCwV+b9eTjBtb8Xxf11cmzOwJSR
 mdKeW+xLeGh9f6vSdODcYJ0Xb7lhZpYWonGS6f5aY7JQ7oMYLpRCLXQtmaCdKJlaE7NG
 JZaS5JrjRmaH1QP6axBVvoPgR6R4QBeGkLWN33i6gwb//MYP4oCgtOI8SoKL38kx4rNV
 YE8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZcNMWIK3bBwz5xJNoHDlsN2k1LR+q+KJIPKovOIKZ9MTjkk4L1cB1Ja4Qcx4SB6ddXLlHV+003Oei@nongnu.org
X-Gm-Message-State: AOJu0Yx1w0T9BhmQloZT70EJUWoXWERN1CTGqBJBp+Pr+obxElMYzixz
 cRT0UlUuE5cZeJw57Q0PesTWA63w3IXaGrxg1Qg5uQbhnAW98GIZR1DXxPJQfb08RWpf2TjZbGy
 Hq4qLMnA5Gnty3TJgWbZaHByEj7/Sop+M4AXCVnYB7HWfUl3pMDtjUDuReA==
X-Gm-Gg: Acq92OFyG0JZjV7GNGntWa/VX+DDFX9f9bIs11PkMyaz+FlgRvfREXX8AHmYG3mNoBC
 4P+VvwSFmpZQ/9qatTegCI7Hy6kM6Bo33xhEWsyKKCc6rgKHy9NOigQgfNSTrooYwATHxk6waOt
 rW/iUmFRQhvo/4oJaueJpzJKC2IpPIzHZgGlIdNiVlg1/VALrkRxSkGw3/9d81IFjndjEeQDhiW
 wqivqL4qGv5TpYhK2ZWGC9OPU68gk6EV39n2VDZm2zWkgSdD99c3/ed5O+krdf33N/0W2b8NDTV
 +lxUbOQAo6yeERn79LU8m2J4JqtnsaugM3TbrorCYBPNxaKyjwNjZo/KmQvw3cQk6t6PdZ1LWFP
 cYGtfCOPri080yln8hoZCAoFMQXE1zHu3osxqFxbddWIIHtfngEvoKJCjN6bbq5FXJaf7
X-Received: by 2002:a05:6214:4a09:b0:8ca:279b:e554 with SMTP id
 6a1803df08f44-8cce216dacdmr10328506d6.29.1779998539097; 
 Thu, 28 May 2026 13:02:19 -0700 (PDT)
X-Received: by 2002:a05:6214:4a09:b0:8ca:279b:e554 with SMTP id
 6a1803df08f44-8cce216dacdmr10278796d6.29.1779998465273; 
 Thu, 28 May 2026 13:01:05 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccdd72f995sm17133146d6.36.2026.05.28.13.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 13:01:04 -0700 (PDT)
Message-ID: <200e1664-a690-4fe7-bda3-074da046e311@oss.qualcomm.com>
Date: Thu, 28 May 2026 17:01:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/12] target/riscv: Assert PTE.N/PBMT bits are not
 expected on RV32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-4-philmd@linaro.org>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIwMiBTYWx0ZWRfX54E6zF3JkJlv
 0rP8LQkGpuWyF72HBVzD+5VoSPtlbHpIQ104SDVgi94kkTpJaOkZCWWPgsGy5DjMEuKf7SKTbIV
 IefuvY/rVBROphCSH2wNrPKtN/Bkci1T7wG4pjTKxWVUrJavQ+uVBnvwOkUIpbt/4ClQoEZWa20
 cmFVZ8wELJqW99XHD7rHq+eh77lUPZKTiSvPh0C+2icRkUilepLmemPEeLE+yTDBCmbYEXbb0s7
 tlF9SQNRUybOY1wz7O83waGsNFt5BFv2NzmGQwFX76+KSBLkdyo6l9MPKkPZYQmBCzjDYMxAep7
 oNYZlPU4MTn9TJlLcNE3MM4D5ElyoQFTQ47jfuziSFqoFHSHrcZJ5dLHw8EOOwp3kZNuGdyxPmo
 csjD6h36n12wJZ6SlwpTCAGEInz80xRLKCXlMBgB3+MiwAnER+gwuwH3sJACtWS15RlfZwpfOK5
 ZimzoUBnGsPfdHcl1ZQ==
X-Proofpoint-GUID: PXpWsUlRr6SUFED10X-0AOYvVU6mOtbE
X-Authority-Analysis: v=2.4 cv=WaM8rUhX c=1 sm=1 tr=0 ts=6a189f66 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=xx_OMfGYl5v5CrJEQtIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PXpWsUlRr6SUFED10X-0AOYvVU6mOtbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280202
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 5/27/2026 5:13 PM, Philippe Mathieu-Daudé wrote:
> PTE_N and PTE_PBMT are undefined on RV64, assert we are not
> under RV32.
> 

I didn't find this info in the RV priv ISA.  Can you please quote the
except it in the commit msg?

Maybe you meant "undefined on RV32"?


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/cpu_helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 17305e1bb75..f86bfdb32e7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1490,6 +1490,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>           return TRANSLATE_FAIL;
>       }
>       if (!pbmte && (pte & PTE_PBMT)) {
> +        assert(riscv_cpu_sxl(env) != MXL_RV32);


What I understood from the RV priv ISA w.r.t PTE_PMBT is that it doesn't
have much to do with SXLEN/riscv_cpu_sxl().  PTE_PBMT is a bits 62|61 field
that determine override mem attributes when we have the 'svpbmt' extension
enabled.  'svpbmt' is dependent on satp_mode sv39 or greater, which happens
to be riscv64 only.

I didn't see any restrictions of SXLEN=32 in the 'svpbmt' chapter in the
RISC-V ISA, e.g. PTE_PMBT set to a non-zero val and SXLEN=32 seems to be
a valid combo - a riscv64 target running sv39+ can use svpbmt to override
PTE properties in a SXLEN=32 context.

Now, PTE_PBMT is not writable when MXLEN=32 (i.e. riscv_cpu_mxl() == MXL_RV32),
and maybe this is what you're trying to do.  In this case the assert might
be justifiable, although we just landed a recent fix in Alistair's tree
that disables svpbmt for riscv32 entirely, and this also means that
PTE_PBMT won't ever be set.  But if the assert (with MXL, not SXL) would give
some sort of guarantee aside from the bit being set, by all means go ahead.


>           /* Reserved without Svpbmt. */
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
>                         "and Svpbmt extension is disabled: "
> @@ -1643,6 +1644,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       target_ulong vpn = addr >> PGSHIFT;
>   
>       if (riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> +        assert(riscv_cpu_sxl(env) != MXL_RV32);


All the stuff I said above happens to be applicable for PTE_N.  This is a bit
that indicates if the PTE represents a "naturally aligned power-of-2" range,
or NAPOT range, and this is specified by another extension called 'svnapot'.
This extension is also sv39+ exclusive, which means riscv64 exclusive, and it
doesn't seem to have any restrictions with SXLEN=32.


Thanks,
Daniel

>           napot_bits = ctzl(ppn) + 1;
>           if ((i != (levels - 1)) || (napot_bits != 4)) {
>               return TRANSLATE_FAIL;


