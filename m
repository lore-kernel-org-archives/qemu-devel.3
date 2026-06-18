Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F03CCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAJz-0003QE-KZ; Thu, 18 Jun 2026 06:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waAJy-0003Pz-O8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:50:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waAJw-0004lS-IB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:50:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8FSR4975845
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D2c2QCRLRKFixyGBVD8SSuMzduqCIpkMMeg5pN2ivbk=; b=QErSsThyJ+dNM/Oo
 oH0a534BLz8oXZ/hhQ1+9JYzDE78vpmuIRSqDVS+bOvW5cG2gh1Ks1rWTHzqcFxD
 X6Oc3eYsvWGWoo+xe1Q8EIErOT171uKoG0lzl1//VquB7/i7LJjEhvZJnvabwdBL
 TWBe1i9p01TOqlSilNuWan4/TVD44Rj/Zrpq1HHrhb+X4aWljLt3yrpZXdm2Mdps
 O5CbOQfQA6PD2yRw5OXLXoCZMlwaePTF89vp4InGx2mUVCy70nGXL31DIbKCrb2P
 HSh7QXP5muf4smPvjxNsQZKfwy9d8j0e2OFoUY4qruPAx2brM1NYUgUcMXV020GB
 UyBA/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc2ttj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 10:50:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9159bc52211so157150585a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779802; x=1782384602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D2c2QCRLRKFixyGBVD8SSuMzduqCIpkMMeg5pN2ivbk=;
 b=RGCx+QHLiRKoelXSXefui+VsfV/8V36z0ifYSgviA20xJ1NOCzUyfxNGCPQ26VxCo+
 QfTqX9O08xpj922L4rG0T8BzgQPKl+YfUeyfDC/Y/oGcIgJyTnPN61WpZUemraD5xNz0
 S/0AknwKyIHTWInhnG0CXoXXRxBRkyk+EJDEN9wKPpdG153YNyLzxY4eUxROVG79w1FM
 QcQQ/6ITwLDdjk1LPpClwf1CvvyweOzmIUp21agSD+NRdurRQkb52K0+RBE2XugdJQSS
 NYlZM8bwhQtcaE2pyj50Naz6B0KYKAf/HxJwlcIWt6etVz56OMXAG4SaY0PsDAgiVgkD
 L57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779802; x=1782384602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2c2QCRLRKFixyGBVD8SSuMzduqCIpkMMeg5pN2ivbk=;
 b=l0iorBYBxS+yv+NyOIJ7reRnQKj4ZP6JD83Rwk0NfAdvykWn85O3Z83F4K9PztCXsH
 2AER78xFkrlAW0GCNobU2vPC5cLcVxjZW1QlKzayleVhK2clFl+GRblr3hPMkcKrH50K
 JkVGVUiS6CLM2I0yknUpHusZoMY4wcsErM2WUGUGctQTynvE4Z3skcaQmbgwmXC1rbBs
 46MQ6527po/8SEgitmHQqNPWyajrlrxrYedEnp1PeVvuGPFlilGr6M51dhuAn24KnVUn
 Hctu6k2FMKLuvU2FxV6sS1SuHMntCyRckvu8/UlVjibhlYv5FybYe2QaYB4+VGbyxq0S
 d8KA==
X-Gm-Message-State: AOJu0YzS9zsarnmcGuLeWn4UmmqSPjogW7l9+4TcixUmMOseXhcf3ONv
 6AXleIfUqz0sLNQeQYQUMspwHJ5e+u1mZ1BiLSj2aLJ0bCZO2RYPVal0KL2ZdE4DtrQsWf3xMBR
 KsFHjdu+LDVr0mMN05YB2WP3jXj26KI4eHRl82laV9KaOvmVcUI6QGAsEMQ==
X-Gm-Gg: Acq92OEQF7s7+G+5q48cSFlGX0cgnZTYTZs+SIQvVqFyiXW5ZGU9/PKku93+wuPaaTv
 +VK4nSLzGNnlTf5Hu044JLnWY3bDANDnrFL7KZ6QBWA868ozlGMPRsMrYVDvv53CF6NGmxYQ641
 Bo2u8spGedAyaJ5RGtVQrirdJdJVTpiVlg/7tq8zXMQoC4Uo7V/QIHvZPpfFdkwF8WnFyWsPR//
 ORmxAtGPbwpH6inES4TfzVvldU8rpQ51fJgPjSU9g4UjIdNogIigGB6UkZpxjNZU/JeI9U9bNKh
 FK9/0TGTQG/Vv/KJJsphSEeghJOZ1I0yXnifZ5m+7Oau/qrTVu0lh5rulATZQZEqgAHjJvza4i6
 dkQgXNxZqf1cTqvxbjc5FfXsEilEr9biwu20coBIei6f15a1FBsZ6YkFP3UDVdQ==
X-Received: by 2002:a05:620a:199c:b0:915:673a:617b with SMTP id
 af79cd13be357-91f2711865emr477997085a.24.1781779801729; 
 Thu, 18 Jun 2026 03:50:01 -0700 (PDT)
X-Received: by 2002:a05:620a:199c:b0:915:673a:617b with SMTP id
 af79cd13be357-91f2711865emr477992185a.24.1781779801300; 
 Thu, 18 Jun 2026 03:50:01 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c4240sm56854962f8f.27.2026.06.18.03.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:50:00 -0700 (PDT)
Message-ID: <be94d200-e1a2-441c-9d36-cb3a370b9576@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 12:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/arm: use correct base address when setting CBAR
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Arnd Bergmann <arnd@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
References: <20260618093615.3793919-1-alex.bennee@linaro.org>
 <42927637-2e5b-46eb-9d25-8315cd36fda8@oss.qualcomm.com>
 <87pl1ogmmf.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <87pl1ogmmf.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a33cd5a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ExKqf3VzcCyPesANViQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6HTlXh404eOFCc8x0SCSDfp4Z5RGBsB8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEwMCBTYWx0ZWRfX2fwQ3ErNvQX7
 3GueVz8YaioFX+koKEQK5c2lcirzpCsly8EeeV/Y6ZUHGc82XL2+QCZZQCEhglQPVK5uoo9Zwd8
 8fgZfOGp7XpcJFZ8HH6ImyNF2+GAJrI=
X-Proofpoint-ORIG-GUID: 6HTlXh404eOFCc8x0SCSDfp4Z5RGBsB8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEwMCBTYWx0ZWRfX/iQ0wOcATz9+
 oU63O9OjZS+7XsLHnHk+VRggbD1W0FHUguBM7l8sLKpFhVNrrMijXOAhwyJFRpFtZQATZK+Llf6
 eqIvP8kNU2W8col/Pt2wd3Y6tV2+C953gqH3Ek1zb5AiPBsBFB2O90bO+K7iPap1ePAIEMuk6N2
 CmU+i/YiSqeoUxqX6Almfb6SuXM5oUwebr5dY7L2sf/uAKNE7aAENxOAWHkQoUcde29zWdCoVy+
 dVQfhUzUYhqVAhGV43mhvIoLrGRvWbMeRKupLABYHnLCOhi/NDVvrKAIZOkoVWmQ86kAH/qTtg8
 aO2D/7AcGmeIXat3/PVK4HxubFv+DiJPv2d+j49IoIEi7XSPvsI4p+/4GoajbCJLtYrv0x0Cy/n
 CdtMIlqi+10Gq6yZYnHlB8/3hOU1mD2ZSNN914TPHaAz5PcGgq8om1RnrNEr88PoA0nWXqhAFmu
 Wgi0so3dr4J4RmNVypQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180100
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

On 18/6/26 12:37, Alex BennÃ©e wrote:
> Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> 
>> On 18/6/26 11:36, Alex BennÃ©e wrote:
>>> This should point at the base of the Cortex-A9 MPCore private address
>>> space. If it doesn't we will confuse the Linux kernel as it probes the
>>> SCU registers and erroneously assumes the system is a buggy Aegis SOC
>>> and nerf the emission of SEV instructions, deadlocking any WFE's in
>>> the kernel (or QEMU smpboot code).
>>
>> I'm confused...
>>
>>    The Configuration Base Address Register holds the physical base
>>    address of the memory-mapped GIC CPU interface registers.
> 
> For which CPU? These are cortex-a9's not a57's and the behaviour is
> IMPDEF.
> 
> See:
> 
>    https://developer.arm.com/documentation/ddi0407/i/introduction/private-memory-region

Indeed. I'll let Nuvoton folks confirm that then.

> 
>>
>> NPCM7XX_GIC_CPU_IF_ADDR is the correct address of "the memory-mapped
>> GIC CPU interface", NPCM7XX_CPUP_BA is the A9MPCORE SCU MMIO address.
>> AFAIU the modelling looks correct.
>>
>> Per your description, the Linux guest tries to access GIC_CPU_IF_ADDR
>> but ends up accessing SCU_ADDR? Maybe the issue is with the
>> arm_boot_info::gic_cpu_if_addr address we pass to the guest? Maybe
>> the secondary reset code is corrupted?
>>
>> static const ARMInsnFixup smpboot[] = {
>>      { 0xe59f2028 }, /* ldr r2, gic_cpu_if */
>>      { 0xe59f0028 }, /* ldr r0, bootreg_addr */
>>      { 0xe3a01001 }, /* mov r1, #1 */
>>      { 0xe5821000 }, /* str r1, [r2] - set GICC_CTLR.Enable */
>>      { 0xe3a010ff }, /* mov r1, #0xff */
>>      { 0xe5821004 }, /* str r1, [r2, 4] - set GIC_PMR.Priority to 0xff */
>>      { 0, FIXUP_DSB },   /* dsb */
>>      { 0xe320f003 }, /* wfi */
>>      { 0xe5901000 }, /* ldr     r1, [r0] */
>>      { 0xe1110001 }, /* tst     r1, r1 */
>>      { 0x0afffffb }, /* beq     <wfi> */
>>      { 0xe12fff11 }, /* bx      r1 */
>>      { 0, FIXUP_GIC_CPU_IF }, /* gic_cpu_if: .word 0x.... */
>>
>> Can you check ^^^ this value?
> 
> I don't think we use this for npcm7xx:

Oh I missed the specific smpboot[].

> 
>    static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
>                                             const struct arm_boot_info *info)
>    {
>        /*
>         * The default smpboot stub halts the secondary CPU with a 'wfi'
>         * instruction, but the arch/arm/mach-npcm/platsmp.c in the Linux kernel
>         * does not send an IPI to wake it up, so the second CPU fails to boot. So
>         * we need to provide our own smpboot stub that can not use 'wfi', it has
>         * to spin the secondary CPU until the first CPU writes to the SCRPAD reg.
>         */
>        uint32_t smpboot[] = {
>            0xe59f2018,     /* ldr r2, bootreg_addr */
>            0xe3a00000,     /* mov r0, #0 */
>            0xe5820000,     /* str r0, [r2] */
>            0xe320f002,     /* wfe */
>            0xe5921000,     /* ldr r1, [r2] */
>            0xe1110001,     /* tst r1, r1 */
>            0x0afffffb,     /* beq <wfe> */
>            0xe12fff11,     /* bx r1 */
>            NPCM7XX_SMP_BOOTREG_ADDR,
>        };
>        int i;
> 
>        for (i = 0; i < ARRAY_SIZE(smpboot); i++) {
>            smpboot[i] = tswap32(smpboot[i]);
>        }
> 
>        rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot),
>                           NPCM7XX_SMP_LOADER_START);
>    }
> 
> 
>>
>> Maybe this code has to be updated for your WFE use case?
> 
> In earlier attempts I did drop the wfe in favour of a NOP until I
> figured out why the SEV's were not flowing.
> 
>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Suggested-by: Arnd Bergmann <arnd@linaro.org>
>>> ---
>>>    hw/arm/npcm7xx.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
>>> index c2bbcd89dbc..c27f149c04a 100644
>>> --- a/hw/arm/npcm7xx.c
>>> +++ b/hw/arm/npcm7xx.c
>>> @@ -492,7 +492,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
>>>        /* CPUs */
>>>        for (i = 0; i < nc->num_cpus; i++) {
>>>            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
>>> -                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
>>> +                                NPCM7XX_CPUP_BA, &error_abort);
>>>            object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
>>>                                     &error_abort);
>>>    
> 


