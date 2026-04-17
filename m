Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C748F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgQj-0003eP-Fn; Fri, 17 Apr 2026 06:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wDgQg-0003dO-R9
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wDgQd-0003jy-MV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776421682;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYq8bQvFtWbNZOMLNispktNnkq9gxWfBHipo4BG3gMw=;
 b=G/kr4yJyWzVTpJSBofH0uEwJVVqQbOXNMF7hPp9Wo3utjdg0VL7t1cMpyblhQKSTSkgAaQ
 wh7HY4SQk9mjdu3ZtMeZjywvGUQJ60uRUQu0mwqtWlVGgzHoKEafwXBOtG3jFxP/Cqw/HT
 4Dw21nzuOpNW6ZIVGo9IOl5EzcRCFj4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-kmzqVmuJOlKd9x6egZUlWQ-1; Fri, 17 Apr 2026 06:28:00 -0400
X-MC-Unique: kmzqVmuJOlKd9x6egZUlWQ-1
X-Mimecast-MFC-AGG-ID: kmzqVmuJOlKd9x6egZUlWQ_1776421680
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7c6d58c8so900793f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776421680; x=1777026480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYq8bQvFtWbNZOMLNispktNnkq9gxWfBHipo4BG3gMw=;
 b=MyVByd7mVqen0MXsBZw82ZhuViNtAPH+rDAlIvy112aEnPcyT26racKiY5bx+JwiZk
 dZmn17i88A0pR0h+Tg6yxB1604gYxatHL7SR/atQVAgHmEIi4Pn81HGohelBMb5j0CVf
 Uzg+Lxjgsq1JEq3z5dT1e5a/9e/B9zufpk7O7dtbN6GXcvht6//GHjXhl6GB4J4n5bAT
 vut046jK/9g6WdDfF8xx93/CqpIWF92UGovgBVZQnQgvlRrHLoI2SP86kXsaicqRY2Dd
 yUVgw7rquSebaHN+/nVEUukwJfN9oJGB25jUNnAQ2VB6AFrolO3/JzaOoc1w+keRVkkL
 VFAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IzDfeZKuPPwRFF7SJqgAHDwo8BOkiqCUCz6X10mHOulAM8Ukf9bNAzESdHoB0i1FnM/75McEwd9Uj@nongnu.org
X-Gm-Message-State: AOJu0Yyd+RuiNNHp1VrdhRzrWIyNy6K6jziHiCDhEsleBoREd1tZK5en
 AzmowTgBG+pFWv9wElJro2AGpobgMq42r5vEzBXAee3J1FAeq6LYwM+8NDiYYmSNERgAka3jdas
 fxzMRCVl3MTPZlFipLgSeUa0zf67QVQknR3qV6WYZqJwuyyGOQS5ohBCf
X-Gm-Gg: AeBDietrxAPdAbYqWIofARDQRmak+NvNVQMIjCcA31U5XTj4RTIuhWhlrFKu6PMWmeL
 l8cmC5Yw71xXVvW+dmm9z+IayFuSvhr6pTDlpcsDRDWWBNnnAf8Df8gtmZNDT4HZwDJ3ivjdRfr
 ZaR81nyyJxvbANOpZfwQbO++yi8f5nqhvbCYbupvH3miafOvHSaWH9NiZA6ugqis3lAyzxPNEMI
 +IqpwiMjzd1tvwFGODcsusl68lu3qsWytURusJHNNGGMRsGsQPxbCcXij0jNlLQGwZRaCHqSrzK
 19qnV1R3CpXPqx1FjmVmZMnxMvFUDJOJ6ebS13TsB/J+yuTp6fYM80fC6KGlkrao4Iyzln8f8np
 npfCvASbTADR8iIrnfaVsB54lEW6kCbWi79+FiEioLztCLVBvsy0U4C0ToXRVeknoPUx6CsL1yg
 /lmHAt
X-Received: by 2002:a05:600c:a411:b0:488:bfc3:ef3 with SMTP id
 5b1f17b1804b1-488fb6e6f1fmr26415165e9.0.1776421679567; 
 Fri, 17 Apr 2026 03:27:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a411:b0:488:bfc3:ef3 with SMTP id
 5b1f17b1804b1-488fb6e6f1fmr26414735e9.0.1776421679087; 
 Fri, 17 Apr 2026 03:27:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc140c82sm31627945e9.12.2026.04.17.03.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 03:27:58 -0700 (PDT)
Message-ID: <9639e97f-7ac3-45a2-87de-3228f534b248@redhat.com>
Date: Fri, 17 Apr 2026 12:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] target/arm/cpu64: Define cpreg migration tolerance
 for KVM_REG_ARM_VENDOR_HYP_BMAP_2
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20260306150302.203112-1-eric.auger@redhat.com>
 <20260306150302.203112-5-eric.auger@redhat.com>
 <CAFEAcA_Vd8Uw+Ptdbt+MhYVejcxfcQLGVS_nkJiaACTtftuepg@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_Vd8Uw+Ptdbt+MhYVejcxfcQLGVS_nkJiaACTtftuepg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 4/10/26 2:22 PM, Peter Maydell wrote:
> On Fri, 6 Mar 2026 at 15:03, Eric Auger <eric.auger@redhat.com> wrote:
>> KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
>> from v6.15 onwards. Backward migration from a >= v6.15 to an older
>> kernel would fail without cpreg migration tolerance definition
>> for this register.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  target/arm/cpu64.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 4cfddc6e8c0..abc6b78ef7d 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -833,6 +833,14 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
>>                                       0, 0, ToleranceNotOnBothEnds);
>>      arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
>>                                       0, 0, ToleranceNotOnBothEnds);
>> +
>> +    /*
>> +     * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
>> +     * from v6.15 onwards. Backward migration from a >= v6.15 to an older
>> +     * kernel would fail without cpreg migration tolerance definition
>> +     */
>> +    arm_register_cpreg_mig_tolerance(cpu, KVM_REG_ARM_FW_FEAT_BMAP_REG(3),
>> +                                     0, 0, ToleranceNotOnBothEnds);
>>  }
> If I understand the intention of this pseudoregister correctly, it's
> for userspace control of what firmware features KVM exposes to the
> guest. In that regard it's a bit like the KVM_REG_ARM_PSCI_VERSION
correct. 
> register, and as with that register I don't think the right
> approach is "disregard any differences on migration". If we
> exposed firmware feature X to the guest on the source then we
> need to also expose it to the guest on the destination, because
> it might be relying on it, and we shouldn't permit migration to
> a destination kernel that can't implement X.
Effectively if the source enabled those BMAP_2 features and we migrate
to a dest that does not support those services, it looks wrong.
>
> But I'm also not entirely sure what the nature of the mismatch
> here is: https://docs.kernel.org/virt/kvm/arm/fw-pseudo-registers.html
> says both
> "By default, these registers are set with the upper limit of the
> features that are supported"
> but also that for the BMAP_2 bits that
> "This is reset to 0".
Looking at kernel's arch/arm64/kvm/hypercalls.c

void kvm_arm_init_hypercalls(struct kvm *kvm)
{
        struct kvm_smccc_features *smccc_feat = &kvm->arch.smccc_feat;

        smccc_feat->std_bmap = KVM_ARM_SMCCC_STD_FEATURES;
        smccc_feat->std_hyp_bmap = KVM_ARM_SMCCC_STD_HYP_FEATURES;
        smccc_feat->vendor_hyp_bmap = KVM_ARM_SMCCC_VENDOR_HYP_FEATURES;

        mt_init(&kvm->arch.smccc_filter);
}

so effectively the reset value is 0 for smccc_feat->vendor_hyp_bmap_2
(BMAP_2) while for original BMAP it is set to 
#define KVM_ARM_SMCCC_VENDOR_HYP_FEATURES                       \
        GENMASK(KVM_REG_ARM_VENDOR_HYP_BMAP_BIT_COUNT - 1, 0)

So the right version is: 

"This is reset to 0"


>
> So does the register reset to 0 such that all we need to handle
> is "allow a source without the register as if it is zero, and
> allow a source with the register even if the destination doesn't
> have the register as long as the value is zero" ? Or is the
Yes that looks the right statement: 
- allow a source without the register as if it is zero
- allow a source with the register even if the destination doesn't have
the register as long as the value is zero This would require another
type of MigTolerance then.
My previous reasoning was that qemu currently does not mangle with
BMAP_2 settings yet,
this will come with Shameer's series: 

[RFC PATCH RESEND 0/4] hw/arm/virt: Add support for Target
Implementation CPUs <https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/#r>
https://lore.kernel.org/qemu-devel/20250801074730.28329-1-shameerkolothum@gmail.com/#r

But I agree this is not future proof.

Thank you for the detailed review!

Eric


> "reset to 0" bit wrong, and in fact the kernel defaults to
> these bits being set, so we need something like the handling
> of kvm-psci-version where the user can suppress the features
> they need to give a "lowest common denominator" among the
> kernels they want to migrate between ?
>
> thanks
> -- PMM
>


