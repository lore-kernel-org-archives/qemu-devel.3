Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7E606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VFRu2a1o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L/hgo+GE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWPE-0000ck-KF; Wed, 21 Oct 2026 09:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJWOs-0000c2-Hn
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:30:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJWOp-0005ce-JO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:30:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBgBAa325206
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AOkNIUVz6ybIrreibIUjY7c9aneWxQCupj+hRu4OBuo=; b=VFRu2a1oA2963uPJ
 aQFuTSek83sP37yU+3XrSr7GlecIPh4vTI2HuOioKHAx+Zx3G/sY4sNJVPV6gcEl
 gjDTan+Uw7QyJ3kU53wJvRo9nylsE+SOcfNftzpmReDHj74Rbm0q/o7KKM08MWRy
 5jM7dCgoA46RKJnwfyjHlfBoPfh9HHfM+r9qkMLzoIuCQTGM1CmrTkTLFEKhb6q7
 hvxL3PtvP5Z/jTe2lL59KaBotbh8al/I0a/EemZfheFvAeLdaS8fK4YAMdXjVDz3
 P+k02HSwB30ngxwKdofll2SxrNQUCmKe+l/ru41QMElSI7fOCsGW5NOlo4YmF2aw
 XEAZ+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v45vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:30:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ca9b53afaso244090485a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792589432; x=1793194232; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AOkNIUVz6ybIrreibIUjY7c9aneWxQCupj+hRu4OBuo=;
 b=L/hgo+GEIIEg4IOhkHcJrdzEJE9pPpoEhh/EB0Q1eqLUy3y/m9cJQgTsMCYo13Bi9+
 kPiXg+BcBMW5RsveSHrQAzomU3XbECkahBleNy8U1nNpOj5jrP/c15IgQIUN950LNCej
 UnbYmCaVV8sf+7M0v7+NnDeEBPKlDwXKB6HmNbwijbh1aZ+Ra8/WSJF5PCLknBZq8Pt7
 dGB9UM74wHu5IqMT9pasRni904IxuIU3wr3UfcEpUFWpFyP1o1ebnwiTaPZ3TKIMTBIj
 17Ehdn+rYjThGMe4hG1ftt64V9PKZ05bRdizUpOzOqeEDw5P+Eslg9Aq/E5x53EuTbdB
 Bs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792589432; x=1793194232;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AOkNIUVz6ybIrreibIUjY7c9aneWxQCupj+hRu4OBuo=;
 b=FBmnsRJqTIZJEgM5dMMClv0aRaH7SlPLF/6DAMyasbZ4AQid++6ZQ18lUlSVeD23Jj
 TrsTAy5x35YREu7i/x7LdkKJqfiEhjBUM/+tDUZz4GcOzNacpFC4PU0oOU00L83dFW+P
 eLoqeumsXsDevcDOXlYEgklg1ORHelJ5z883P3J621ywEcAVJ71hPjF6f7QfmUcXAAYc
 K84UDfSyCFECuOWgjqu+dFR3UG9H17RbDN6SXWZ6ldLImXxgDvYi44+f7IALx2jDxmNw
 EjXc0uCP1enxRVRjKKuViwUYNoJXfi8l+LupEYcbpaqV6VJd77E3u46bypGMhSGwjLHh
 ZpPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5NgREQCo4FVHdQLy6wy73Xcgf/DzFKqwhtpugkleT4DQkokwnGCEngztFg2ibjLgzmIkJnXJnO5HG@nongnu.org
X-Gm-Message-State: AFq9FYLaPhF4z5ZvhmINEKfdojEV5/y40Ndhh6/aSCrdSrKM1OZAxIjv
 KRWxCI7MC3US3LiYy2cwm2bLBTlmKMwOfDWASzngNhJwWSmWiqRidDDaZnZAo77PTiWZMfFvYh7
 YgdKyosOAqp8RcftK/e17ssGjn3jWN3LAt171gph2CoTrnwF2o7Rdqq8puQ==
X-Gm-Gg: AYBFou38paxkPvxqOK4OZ8Ju3IBaVYJ5QK5yXVF1iIFRLT4EAWXzBhwtbIEOXBIPvfu
 7WXJArfPHJPDFal/srcC6nSnNDAu4qRb8yC+/u91lGd6v1fFZMyht0yEHG/doEWEdCBbRtRyz4V
 O8CpHTtRt0n9W7YDTg1MxcOYjTeXgwtYPFxrFO+IP32kKQSupeQYxiq5LQqbE/Hxs1GOBGnmRTg
 KF1wmj42qJbgudWPeB3hJZ5ig8GJMGVw+064MbpE5e7eOLy8ZO2og0HUyG26bi1m5iPMuLYm5c7
 3BfYgXRst5HVx6IpVO/mNS7aK4dYbjtBENCwODqh7T8Zv72CevhbVqNmeZImZ51WNw/+K2H5mB6
 uJ4L9Xu1WiTlHMQpS7LoiNb8wHqcLbYtZ1+CSAEg2bDMjdZGCbolD4e2oGUEUQ0NibcmJ16s5
X-Received: by 2002:a05:620a:31a6:b0:93f:5445:c661 with SMTP id
 af79cd13be357-93f57f461a1mr435427185a.57.1792589431972; 
 Wed, 21 Oct 2026 06:30:31 -0700 (PDT)
X-Received: by 2002:a05:620a:31a6:b0:93f:5445:c661 with SMTP id
 af79cd13be357-93f57f461a1mr435408685a.57.1792589430405; 
 Wed, 21 Oct 2026 06:30:30 -0700 (PDT)
Received: from [192.168.68.101] (200-204-190-237.dsl.telesp.net.br.
 [200.204.190.237]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa1222d55sm522913e87.58.2026.10.21.06.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 06:30:28 -0700 (PDT)
Message-ID: <7c1727e0-719f-4c7b-a230-07b2541eca26@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:30:22 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 2/3] hw/intc/riscv_aplic: Add in-kernel aplic
 save and restore function
To: liu.xuemei1@zte.com.cn, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, peterx@redhat.com, farosas@suse.de,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260602143128977LnqA8GEd2vXmjtApOWdAI@zte.com.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260602143128977LnqA8GEd2vXmjtApOWdAI@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MyBTYWx0ZWRfX0F/rDX7nghQG
 way/5HNIGwMo9Yf70dfKH5l1PJ0WR8Q/GGwyywpxRNI2d2gH/u1unaRuEbBOnBHWFyeY6BFsTti
 ygzn8OEE6K2nxQe3uZ1/ANVcLHAo3JM=
X-Proofpoint-ORIG-GUID: 9nmaHhmEEHYJo38zCjWT2RS700GrSss3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MyBTYWx0ZWRfXzClpGk/ch25U
 JLuGfp4i06lxluENETwPkAZSHyZ0tzieQ052tDowhTmiiDpyrcu9ub2waTjH9uvuEPT49WNKuuI
 qiuVwX1cHi9OYrH5wGvQY6IPae9tKsxYrGlRgL1IShNtRe7SrpxE5YVdG5uiZYHFoDn0045aVYO
 BsPibQxtkehtzTjdzvOWVhJ52FcORZMkCNV3v/hhfkoMkTt7Tn8a0ivSGEr52Ip9m4RDnkquFP7
 rzBUMHtcVnhHA5Z3kunExIADThQ6l1KaQq/devRSpTdXTKXyWxVElGWDFxGtcLs1oRQIiTO5p2n
 M8Cu3GKjdnyZbmsUtLQChcHp04Yfm0WMz2y7Ft9JCNKCMFedlJliSFLhyp/OXrIQWx+7u9ECANn
 2K77zlt2svwzQOaaD8mBMCzdkWLoCLxVnNlncvh3rAINlksH9n+NAupcTPlMyJzniPxxs7V8rnV
 ZbzudIZV7LytARCZJkg==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad8be78 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=1RTuLK3dAAAA:8 a=lqKrqN7X4LlDukFb2gAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: 9nmaHhmEEHYJo38zCjWT2RS700GrSss3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210053
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Sorry for taking this long to give a review.  Now:

On 6/2/2026 3:31 AM, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Add save and restore function if riscv_use_emulated_aplic return
> false, it is to get and set APLIC irqchip state from KVM kernel.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>   hw/intc/riscv_aplic.c         | 190 +++++++++++++++++++++++++++++-----
>   include/hw/intc/riscv_aplic.h |   4 +
>   2 files changed, 168 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 0f61b67fc5..f544733954 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -975,9 +975,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           }
> 
>           aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
> -        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
>           aplic->state = g_new0(uint32_t, aplic->num_irqs);
> -        aplic->target = g_new0(uint32_t, aplic->num_irqs);
>           aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
>           aplic->iforce = g_new0(uint32_t, aplic->num_harts);
>           aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
> @@ -989,8 +987,16 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           if (kvm_enabled()) {
>               aplic->kvm_splitmode = true;
>           }
> +    } else {
> +        aplic->nr_words = BITS_TO_U32S(aplic->num_irqs);
> +        aplic->setip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->clrip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->setie = g_new0(uint32_t, aplic->nr_words);
>       }
> 
> +    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
> +    aplic->target = g_new0(uint32_t, aplic->num_irqs);
> +
>       /*
>        * Only root APLICs have hardware IRQ lines. All non-root APLICs
>        * have IRQ lines delegated by their parent APLIC.
> @@ -1016,47 +1022,179 @@ static const Property riscv_aplic_properties[] = {
>       DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>   };
> 
> -static bool riscv_aplic_state_needed(void *opaque)
> +static bool riscv_aplic_emul_state_needed(void *opaque)
>   {
>       RISCVAPLICState *aplic = opaque;
> 
>       return riscv_use_emulated_aplic(aplic->msimode);
>   }
> 
> +static const VMStateDescription vmstate_riscv_aplic_emul = {
> +    .name = "riscv_aplic_emul",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_aplic_emul_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +                              num_irqs, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> +        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool riscv_aplic_in_kernel_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    return !riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
> +static int riscv_aplic_in_kernel_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIP_BASE + i * 4,
> +                                     aplic->setip + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_CLRIP_BASE + i * 4,
> +                                     aplic->clrip + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIE_BASE + i * 4,
> +                                     aplic->setie + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_in_kernel_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIP_BASE + i * 4,
> +                                     aplic->setip + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_CLRIP_BASE + i * 4,
> +                                     aplic->clrip + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIE_BASE + i * 4,
> +                                     aplic->setie + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_riscv_aplic_in_kernel = {
> +    .name = "riscv_aplic_in_kernel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_aplic_in_kernel_state_needed,
> +    .pre_save = riscv_aplic_in_kernel_pre_save,
> +    .post_load = riscv_aplic_in_kernel_post_load,
> +    .fields = (const VMStateField[]) {
> +            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, false);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, true);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +


These pre_load and post_load functions will fail to build in a non RISC-V host:

ntc_riscv_aplic.c.o -MF libqemu-riscv64-softmmu.a.p/hw_intc_riscv_aplic.c.o.d -o libqemu-riscv64-softmmu.a.p/hw_intc_riscv_aplic.c.o -c ../hw/intc/riscv_aplic.c
../hw/intc/riscv_aplic.c: In function ‘riscv_aplic_in_kernel_pre_save’:
../hw/intc/riscv_aplic.c:1077:38: error: ‘KVM_DEV_RISCV_AIA_GRP_APLIC’ undeclared (first use in this function)
  1077 |             kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/intc/riscv_aplic.c:1077:38: note: each undeclared identifier is reported only once for each function it appears in
../hw/intc/riscv_aplic.c: In function ‘riscv_aplic_in_kernel_post_load’:
../hw/intc/riscv_aplic.c:1098:38: error: ‘KVM_DEV_RISCV_AIA_GRP_APLIC’ undeclared (first use in this function)
  1098 |             kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/intc/riscv_aplic.c: In function ‘riscv_aplic_pre_save’:
../hw/intc/riscv_aplic.c:1139:34: error: ‘KVM_DEV_RISCV_AIA_GRP_APLIC’ undeclared (first use in this function)
  1139 |         kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/intc/riscv_aplic.c: In function ‘riscv_aplic_post_load’:
../hw/intc/riscv_aplic.c:1162:34: error: ‘KVM_DEV_RISCV_AIA_GRP_APLIC’ undeclared (first use in this function)
  1162 |         kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
[1984/2912] Generating docs/QEMU manual with a custom command


This happens because the riscv_aplic controller is also used by TCG and in a
TCG build we don't have any visibility of these KVM regs.

Note that we had changes in how TCG files are organized to be able to support
builds with --disable-tcg.  I believe your patches happened to be sent in the
middle of this transition and this is why it's not building in current master.

We need to gate this code using IFDEFs and providing stubs when we do not
have KVM enabled in the build.  What we're looking for is something like this
diff:


diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 891b09640a..0ec8ab590a 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -1068,6 +1068,7 @@ static bool riscv_aplic_in_kernel_state_needed(void *opaque)
      return !riscv_use_emulated_aplic(aplic->msimode);
  }

+#ifdef CONFIG_KVM
  static int riscv_aplic_in_kernel_pre_save(void *opaque)
  {
      RISCVAPLICState *aplic = opaque;
@@ -1109,6 +1110,16 @@ static int riscv_aplic_in_kernel_post_load(void *opaque, int version_id)

      return 0;
  }
+#else
+static int riscv_aplic_in_kernel_pre_save(void *opaque)
+{
+    return 0;
+}
+static int riscv_aplic_in_kernel_post_load(void *opaque, int version_id)
+{
+    return 0;
+}
+#endif


But even then we'll need to make sure that this will keep working with --disable-tcg
builds.  I suggest testing these changes with --disable-tcg to see if everything is
working as it should.


Phil, let me know if there's a better way of handling KVM specific code in this
controller.  I tried to use (kvm_enabled()) to filter out the KVM specific parts
but it refused to build.  I think it has to do with the fact that these are callback
functions and the compiler isn't able to ellide the KVM bits away.

Thanks,
Daniel

>   static const VMStateDescription vmstate_riscv_aplic = {
>       .name = "riscv_aplic",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> -    .needed = riscv_aplic_state_needed,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
> +    .pre_save = riscv_aplic_pre_save,
> +    .post_load = riscv_aplic_post_load,
>       .fields = (const VMStateField[]) {
>               VMSTATE_UINT32(domaincfg, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
>               VMSTATE_UINT32(genmsi, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> -            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
> -                                  num_irqs, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
>               VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
>               VMSTATE_END_OF_LIST()
> -        }
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_riscv_aplic_emul,
> +        &vmstate_riscv_aplic_in_kernel,
> +        NULL
> +    }
>   };
> 
>   static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> index c7a4d4ad01..1976bea68c 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -53,6 +53,9 @@ struct RISCVAPLICState {
>       uint32_t *idelivery;
>       uint32_t *iforce;
>       uint32_t *ithreshold;
> +    uint32_t *setip;
> +    uint32_t *clrip;
> +    uint32_t *setie;
> 
>       /* topology */
>   #define QEMU_APLIC_MAX_CHILDREN        16
> @@ -66,6 +69,7 @@ struct RISCVAPLICState {
>       uint32_t num_harts;
>       uint32_t iprio_mask;
>       uint32_t num_irqs;
> +    uint32_t nr_words;
>       bool msimode;
>       bool mmode;
> 


