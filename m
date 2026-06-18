Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B4CCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9et-000436-8U; Thu, 18 Jun 2026 06:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa9eh-00041C-Hd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:07:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wa9ef-0004A1-Uz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:07:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8FPti1177670
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B5sV73HY89E3gthBCl1awOSOckzxHbC8vr4R7GgapnM=; b=lxs0GmlJhwj6E+Tv
 BC28F2nc50rYeiF6m6PFQW7nUu092ok7fbD0ZyRz3JGoKVOH93RvfF8lPZ7qnH7O
 B840EJV1gDr9DHFI3ZqRTy6UYYp22ot5gFicsSVlHlhyoDbeegouOxXnDccVgURZ
 4F+d3LC5uWOd8rAZbXM2UOm+EScBtXQ92MOf13Ldrf8KyqAmvgxwqU1VdzfpUhnM
 zDAirqMJ0/7ae2yPRPsiepIwCmWt3S04+K6u5IHdvgH+fl1+1wvZueToVvXdeLLy
 iSyAmYWwHArE8MyVcilkM0bRlDug+408oB6WnQ9In4KfzQ4OFYmQKd0u9xkYD0Qx
 z8imlA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kjy5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:07:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91598af506cso93407585a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781777242; x=1782382042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B5sV73HY89E3gthBCl1awOSOckzxHbC8vr4R7GgapnM=;
 b=O1oLAUta9ZbKVEzEYC1grLJB4eVAXROjYYPdyJBhYqoK3uqEEcqMLmWsEDuNueJ4vY
 gTiqMGlr+PxVdnXESFC5k1KBIOSyT1v5zE3jFjsqxji7MnvTp0lDhCDEX6UNmk5LX7Vn
 bHRk6MWu0bSvLjQhqYQ6e+SPOXRwTWqUvlAGy8zyNSSiez852gf1pZy/uK9F4rEqd6DQ
 hnYr/BcXAB6aY3g6NkIo9kQhJ4vAlSBYhw/wObXwgzHe+9+Omhs0jqVDtyA+/mwrXvg1
 IjGCIdmpINh8tsoYUA+QNXgrss+lFj6UV/0y5bZ8/tLuBuBnYIOefznhaH7WwYZBoZA+
 RqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781777242; x=1782382042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5sV73HY89E3gthBCl1awOSOckzxHbC8vr4R7GgapnM=;
 b=Z9JVTgewkSO6F7IPQOvDrXXG/CAXytXD7kQo9QfX5KIkQwJ2ljvBP/auhWAAhNLq9D
 vulz+CpSFmDbWiaNu9QDsK63nTXdqJF75ChII6fghTipEF4yv3ZNRgTwQUSGlDXom8KW
 Hb9RaYjBR3cNTWOd+91up+0vMGNXvAtHthr46A7mkcu8WLgev+d6tMlC5U1k8933pNHH
 TBp7Uayqw/NNXSM1BNyHsOFw+hDUiP6Uvh5z7Nt868DaGCsKouojPKyyZZyAPcfM8K9l
 NVQkm25ZxMsF2UGttoDwNLNCNWPj8NdwWFG12Y+K6G+ep6eCfGfbPWrRhmAlesqDwY2D
 kWfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Qom3q4pjKK/8t1+yqG0BN4kS741uwypYdi8xFSuvEq2YUsgsPH1Zhf307Tp0vjK0JlVPVul+53UhG@nongnu.org
X-Gm-Message-State: AOJu0Yy0ZwfOB8gyYQUrtah9bw1VGZP0owySqxobvfix1SJT6yVqQyms
 jtfTXak4uEXWw4JSs83jRLd/sqxQc70FqHRQkQ11fwBkueKxr3mUIUlhMAL7N723AsJ3gPSLSBS
 +i78J7Dsw89fzF1l9c740sAi/JyT8KlQbbr/AGhV66BzJqL4za2wq/hN2fQ==
X-Gm-Gg: AfdE7ckg0sxhYDNJ4pMH3Td++/JeC1h+Z2awjyP+WDFS910aHRP0pTU9enfaLunITY2
 yFgc/7uOZIbBB1INqwNXbXWRvANQn4Gk1/ZYsip30gD/fnifKltpjqMSMK4DmT8u36KcOAHqhHq
 j8KX/e449zUAREVPrsTZHWGAzGKuMefB9tIEWqQDDy0/DW+jXNDZOUnjy3gAjVcLA4TY6bOm2Xs
 0LiDAibi1bGmHMMLXPyahrmYtm0N8brAaPk9cIbeH33XWrcNZhEXfevKwkDSbmxpEvfZubCyXmo
 3SPMJ4kLaiGlhUKOYEyFh0Rsm1lHwg/ZrzjWHNSXcDy+6iKeixe5BUBh62AQ6qqbX2w2e4nY3Nx
 WpJWpiFocmNI+/frM/xLjba4B5u3oSmRs8SuyZF/jwmo8tcHspKrbzyQMqaLfjA==
X-Received: by 2002:a05:620a:454a:b0:914:bb8e:915c with SMTP id
 af79cd13be357-91d8b8ba1f8mr1302846985a.22.1781777241741; 
 Thu, 18 Jun 2026 03:07:21 -0700 (PDT)
X-Received: by 2002:a05:620a:454a:b0:914:bb8e:915c with SMTP id
 af79cd13be357-91d8b8ba1f8mr1302842285a.22.1781777241261; 
 Thu, 18 Jun 2026 03:07:21 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4601esm257100965e9.1.2026.06.18.03.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:07:20 -0700 (PDT)
Message-ID: <42927637-2e5b-46eb-9d25-8315cd36fda8@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/arm: use correct base address when setting CBAR
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Arnd Bergmann <arnd@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
References: <20260618093615.3793919-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618093615.3793919-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5MyBTYWx0ZWRfX12OyDvhLaiEw
 InwWpa2ROKy4I9vSHSVYdGQGJs8vRSWeCmWJyTpPzuARaGHcpVkb/D7kLTLJg1t1v0ygOsketRy
 2v9DKOZYGTVF7gX0piTkn4olXfIDoOjkrp0DngD77J1uKwB10Z1tLGDWVxk7Qx5WNDPYeHjNekA
 TV0sASVkJdHat3Gy8sZS8AR/FP45ZfvlFdzKFmR5nk91Yr8to4eR23UhADxlSuTvGrlhGJs4cPj
 Ga0/rn0fvUGgCRWxX0HaM3HWXM/7W1WPa0L3a0BHi6Q20D+BSylFdkJYSDdpQAUmwl2NmMCsGYr
 fDxqwnBRIrwgIdCARLdxGhJeKco5+9X92a1sYXhxTEFr75mKm7Hp8nPEyPzO2PLR+ZtKaGhSpnp
 UMqNpNmOWW8HGTvMkGFpksm5CemlFENHtVXdgra+bbL1bxm8+k9vXAcTOoY8ZY7TksM71ZGAvFm
 23lyJ1UbDulCMRsOd5A==
X-Proofpoint-GUID: dZ-hsaJ9Qo-YVjxN-sRS7MH6CksynB3w
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33c35a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=Sw7cnfgtHNjO5mK55CcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dZ-hsaJ9Qo-YVjxN-sRS7MH6CksynB3w
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5MyBTYWx0ZWRfX2M/p/2M3yRQf
 shwiFur4aiGfqQO1/O59WOrD4fvcj83tQXGXKtuBBJki/mHiwKDvBDOvnOioahe3KKTzWfT2825
 cHj4+3DyGTsqE//g/piVgxC/aIVnil4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180093
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

On 18/6/26 11:36, Alex BennÃ©e wrote:
> This should point at the base of the Cortex-A9 MPCore private address
> space. If it doesn't we will confuse the Linux kernel as it probes the
> SCU registers and erroneously assumes the system is a buggy Aegis SOC
> and nerf the emission of SEV instructions, deadlocking any WFE's in
> the kernel (or QEMU smpboot code).

I'm confused...

   The Configuration Base Address Register holds the physical base
   address of the memory-mapped GIC CPU interface registers.

NPCM7XX_GIC_CPU_IF_ADDR is the correct address of "the memory-mapped
GIC CPU interface", NPCM7XX_CPUP_BA is the A9MPCORE SCU MMIO address.
AFAIU the modelling looks correct.

Per your description, the Linux guest tries to access GIC_CPU_IF_ADDR
but ends up accessing SCU_ADDR? Maybe the issue is with the
arm_boot_info::gic_cpu_if_addr address we pass to the guest? Maybe
the secondary reset code is corrupted?

static const ARMInsnFixup smpboot[] = {
     { 0xe59f2028 }, /* ldr r2, gic_cpu_if */
     { 0xe59f0028 }, /* ldr r0, bootreg_addr */
     { 0xe3a01001 }, /* mov r1, #1 */
     { 0xe5821000 }, /* str r1, [r2] - set GICC_CTLR.Enable */
     { 0xe3a010ff }, /* mov r1, #0xff */
     { 0xe5821004 }, /* str r1, [r2, 4] - set GIC_PMR.Priority to 0xff */
     { 0, FIXUP_DSB },   /* dsb */
     { 0xe320f003 }, /* wfi */
     { 0xe5901000 }, /* ldr     r1, [r0] */
     { 0xe1110001 }, /* tst     r1, r1 */
     { 0x0afffffb }, /* beq     <wfi> */
     { 0xe12fff11 }, /* bx      r1 */
     { 0, FIXUP_GIC_CPU_IF }, /* gic_cpu_if: .word 0x.... */

Can you check ^^^ this value?

Maybe this code has to be updated for your WFE use case?

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@linaro.org>
> ---
>   hw/arm/npcm7xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> index c2bbcd89dbc..c27f149c04a 100644
> --- a/hw/arm/npcm7xx.c
> +++ b/hw/arm/npcm7xx.c
> @@ -492,7 +492,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>       /* CPUs */
>       for (i = 0; i < nc->num_cpus; i++) {
>           object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> -                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
> +                                NPCM7XX_CPUP_BA, &error_abort);
>           object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
>                                    &error_abort);
>   


