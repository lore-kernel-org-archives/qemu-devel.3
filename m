Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB70F1076386
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7yvW-0006IX-HK; Wed, 01 Apr 2026 13:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7yvT-0006GW-D9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:00:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7yvR-0007XZ-Ei
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775062815;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKmnO7IGigbhy+//7jRYvCwsmOFKaHL7foYYOImkLKI=;
 b=O6HMi/2lC9TIRdEkg3mKkEq4azEvPD1RZdGe+dolXdYavrrM0wERBWtQ0Oqhu/pRXAzapG
 XeMgkWJKfP9A5WP4QbjdtJvtbLcjnLSEHl3HTmMoApDu179Fq5cf7piuA2M/Jd8VClU9uL
 sMfml7la1u272UHrkR5M12EOrH5ft1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-f5IjnSoGODOflWH3TmLA3g-1; Wed, 01 Apr 2026 13:00:14 -0400
X-MC-Unique: f5IjnSoGODOflWH3TmLA3g-1
X-Mimecast-MFC-AGG-ID: f5IjnSoGODOflWH3TmLA3g_1775062813
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-485c45885e6so57844745e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 10:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775062813; x=1775667613;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKmnO7IGigbhy+//7jRYvCwsmOFKaHL7foYYOImkLKI=;
 b=EnPFJa74y/77wOMlO7XxDoumc4xf5GNziHM3V6exr6e5n2iJM0Z2B7uLWUzgaMaZAQ
 2PpUOnnlPvCZZk+AxnFyipfkuSI4oXTFAqDl8Dc/nxnBRVVmFDx6n6fc991yvNGuSLNs
 nusxSW9qhflqgjLp4+2E6NYuUkvQ73khkadl4LPca1//VoYs4E1d7+iQFxx6i9yDSuZr
 zv9FcQRiJ4KZ+sHPeabyP+uieKkg/l+27e6wVgc7JtnR3tj4jwlLRVZQUBe2aAQowuSA
 s92PMBNCuTxSjqjYIGXiPGUAS3Fz9UA+x02MJIRVNTxJ+FOfqMmPJD6/EvSOe6LWkF37
 UE9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyxf/O3aHGECNx/+yCTBk/dCLkBInFm3NuFB9vH53JIYL+I0K7nedHSZMlEY0ueMdY0GkwHdjC9Ryd@nongnu.org
X-Gm-Message-State: AOJu0YyLWGgj/R7Bo/7AhTnY/vNIRyKgyN57Q7JHYDUG4/gt85+Sqqvh
 S0trNxGoS2e+YCayLhQ+wHJWegBxdzoVbMVChIWDoa+yvX3oz3WOt/iUuYPGpyci43Ptr5GQ88X
 fcHqLWalVMHupY9dEOxZN6dkcbcYC9Ng8e7dWXwz8qMWVbWVjZi4Vi/a3
X-Gm-Gg: ATEYQzxmgUe9HGcHH01evkI2dQmZuasFHIfmq621YgQNYV7Wh2seSBI1muB8drFezZ6
 G/KvFfo7abVhUjqR3Q7Zi0zL39FgsC7vlFETyr8ZPT06EQrs07U7BzMXV79QiA4TzrP1ZPXuc1p
 VOxPe2uen68/rbfEbKJuo2ZkckNusXFpWo+DNwnQVwwTuAVxdBoBHxrA5EIrUCeey9wWA8V8TTN
 Scea4JvURi7p08NrzASfSfFRWnypNfrixSKCXyiC1S742tqE89B3JBz6Zid0KZTC9DlEPlBsaDk
 wooLu/V1IVZC8mvTWWKrlRSimMMlmiXKn2u3XgW2sAz75slXpOcQn4VONGe+1dKXyQOPt04v7r5
 udSjBfNJCKC9l+gM5wQwuCRGzAmWlz2vTylSJjG5MMskDi4LnbDgWLYmt+ymS4n83C8Krzg==
X-Received: by 2002:a05:600c:4744:b0:486:fc95:1a91 with SMTP id
 5b1f17b1804b1-488835881a1mr68973235e9.12.1775062813173; 
 Wed, 01 Apr 2026 10:00:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:486:fc95:1a91 with SMTP id
 5b1f17b1804b1-488835881a1mr68972725e9.12.1775062812680; 
 Wed, 01 Apr 2026 10:00:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm26672325e9.0.2026.04.01.10.00.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 10:00:12 -0700 (PDT)
Message-ID: <ece352d8-d819-4562-b6d6-f761898a3bbf@redhat.com>
Date: Wed, 1 Apr 2026 19:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm/kvm: get demuxed ID registers from kvm
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Ott <sebott@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
References: <20260204133229.297061-1-cohuck@redhat.com>
 <20260204133229.297061-4-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260204133229.297061-4-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2/4/26 2:32 PM, Cornelia Huck wrote:
> We now have the infrastructure in place to get and save demuxed ID
Here we only get their values? What about the save?
> registers from kvm. Use it to get the values that kvm emulates for
> CCSIDR_EL1.
>
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/kvm.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0828e8b87bac..9ed51969f075 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -243,6 +243,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
>      return ret;
>  }
>  
> +static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
> +                                  ARMIDRegisterIdx index, int subindex)
> +{
> +
> +    struct kvm_one_reg one_reg = {
> +        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
> +    };
> +    ARMIDRegisterDemuxIdx demux_index;
> +
> +    switch (index) {
> +    case CCSIDR_EL1_IDX:
> +        if (subindex < 14) {
> +            one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
> +        } else {
> +            return -EINVAL;
> +        }
> +        demux_index = CCSIDR_EL1_DEMUX_IDX;
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +    one_reg.addr = (uintptr_t)&ahcf->isar.idregs_demux[demux_index][subindex];
> +
> +    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
> +
> +}
> +
>  static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>  {
>      /* Identify the feature bits corresponding to the host CPU, and
> @@ -256,6 +283,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      bool pmu_supported = false;
>      uint64_t features = 0;
>      int err;
> +    int i;
>  
>      /*
>       * target = -1 informs kvm_arm_create_scratch_host_vcpu()
> @@ -416,6 +444,11 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>               */
>              err |= get_host_cpu_reg(fd, ahcf, ID_AA64ZFR0_EL1_IDX);
>          }
> +        /* grab demuxed registers */
> +        for (i = 0; i < 14; i++) {
> +            /* KVM only allows 0..13 */
where is it documented? Maybe add a comment or justification in the
commit msg. Use a define?
> +            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
> +        }
>      }
>  
>      kvm_arm_destroy_scratch_host_vcpu(fdarray);
Thanks

Eric


