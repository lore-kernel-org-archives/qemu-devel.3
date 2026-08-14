Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A808C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wusNu-0004IB-FI; Fri, 14 Aug 2026 09:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wusNt-0004Hy-3r
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wusNr-0001B2-DH
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786715742;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKdhtw1m8sht7rTZzs87WSL5+4JwGR90fU7k6i0EFcI=;
 b=XUhoCA17c+i7oThWE6EDBaq3Bw/5l5JIfyAr1R94YaOEPCqwtryIs2vG791RYfDBnf+EBj
 zQoh9Hr1OJpZkkRUqkCtcRiVwsmB5/kcJEzBGMoIay4WPHE8jFtlvkneQ5d7pJBNWCtSYz
 GLSwoBdi5iAVarFC65pZ0/jmXVP6Dng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-EXguio_qN3io8B9ysrpPIw-1; Fri, 14 Aug 2026 09:55:40 -0400
X-MC-Unique: EXguio_qN3io8B9ysrpPIw-1
X-Mimecast-MFC-AGG-ID: EXguio_qN3io8B9ysrpPIw_1786715739
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-492488f8583so8703545e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715739; x=1787320539;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gKdhtw1m8sht7rTZzs87WSL5+4JwGR90fU7k6i0EFcI=;
 b=cosA90IuXc44P8iluA7X4CYO90Sx2kFwnk8ORHcqGFeNB/4VjQhUdBU79czH5CB9OI
 GcoHRkAaUtbFtYJ/mUi29nTu1Kin2xcPeRD5NCebufGA28hLWBtYhCRMK3qrZ2blkMqM
 esXi4gdnn2PHNiG7CrdTWyWTmqPkgMDQaNRka76atu+HVKnICMC8U4AS7X0ZDTnh5TEF
 PqO8QsPG7pbvOGAxwqOe2HG9uld3+juOtDneyvFNb42+6YyBlrKVqpq+E2CCdgUUvCiV
 d779jdzCyKtzD0ZAwiVH7nht+J1YL/iLzjj/98ShBuANTqCFOOn82F4I6MXAS1pb5hF2
 XIRQ==
X-Gm-Message-State: AOJu0Yz/Yqqvf+NHM4yVlWQ97YyNm9QcphTRDUGyfsCEogS128RhraPa
 vZdZcxK0JmIO9n+NRtiatX0WHUhl2WyhTI2w08SJYtbEf0bidxFqA1D/u3BcFEtJh35pSH1OIJ2
 4UqP8lpg781DDNaD5LRiJy1uw6UKnVkCQAfAGHO13KuCqN5UFw0gkQiN2
X-Gm-Gg: AR+sD105ecOF1FmasoNIHs7akHlsKI88jI/OWImS6o1JxWRZIFO/exiLMfO8X84uxXA
 HGtwVg7/CeR39mivDsywhzcF/1M2z9JBPGDR/bhyhJrTQ0BC8H9eIsDlpH3SkiSWM6rh7FkFJK7
 F9rjEKmWCmda3tnxJsmJxLzuvw4y/1uFmoyQ0GznAkzliAsu/Rkh9umRMVHJEb8tLEJqmxl66cv
 zxD31BtcsNo1pGal5FwC2s7bnLBqYLFSJuoywZCrkGT0SZmO+fwbScl/Y/QFpIMR0aOfhbEpDL+
 NAdRPJu8ziIb1wkNcriJ2ulQXIZKU9yH0Sb3NDpVb1NYJ3yeavV66NfFcvFC3MMc/fpV1TfYql+
 hPDi0PBW9ypK1ioqSmKMrQwP8jaAhUur1dzSerNztsLmYoO+R
X-Received: by 2002:a05:600c:4708:b0:495:6396:8b67 with SMTP id
 5b1f17b1804b1-499879419bdmr66202915e9.4.1786715739202; 
 Fri, 14 Aug 2026 06:55:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:495:6396:8b67 with SMTP id
 5b1f17b1804b1-499879419bdmr66202295e9.4.1786715738779; 
 Fri, 14 Aug 2026 06:55:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998bc827f1sm9878195e9.6.2026.08.14.06.55.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 06:55:38 -0700 (PDT)
Message-ID: <d77fc9f7-3057-4dc0-b29e-dc7bdfa0d5a2@redhat.com>
Date: Fri, 14 Aug 2026 15:55:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/19] target/arm/kvm: handle special ID registers
 cases when reading from KVM
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-8-khushit.shah@nutanix.com>
 <134decf2-a084-4cba-8536-a59ecbd6b420@redhat.com>
 <34D1F8A9-C40F-4BA4-80F8-FC611EBCC732@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <34D1F8A9-C40F-4BA4-80F8-FC611EBCC732@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/3/26 5:52 PM, Khushit Shah wrote:
>
>> On 22 Jul 2026, at 6:02 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Hi Khushit,
>>
>> On 7/16/26 11:38 PM, Khushit Shah wrote:
>>> The generic KVM_GET_ONE_REG loop cannot correctly read a handful of
>>> ID registers, so specially handle those:
>>>
>>> - DCZID_EL0: No fine grain trap exists, hence not tracked by KVM.
>>>  It is EL0-readable and untrapped, so read it directly with MRS.
>>>
>>> - CCSIDR_EL1/CCSIDR2_EL1: not plain ID registers, their value is
>>>  selected by CSSELR_EL1. KVM only exposes them via the DEMUX API
>>>  (KVM_REG_ARM_DEMUX_ID_CCSIDR), so there is no single value to read
>>>  here. Skip them.
>>>
>>> - SMIDR_EL1: KVM does not support SME, so there is no meaningful host
>>>  value. Skip it.
>>>
>>> - GMID_EL1: not in KVM's sys_reg_descs[] and, being an EL1 register,
>>>  cannot be read from userspace via MRS either. The guest reads the
>>>  raw host value; this is a genuine miss when MTE is enabled.
>>>
>>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>>> ---
>>> target/arm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
>>> 1 file changed, 44 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>> index 42ff731f6e..6974e5c551 100644
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -311,15 +311,50 @@ static int get_host_cpu_idregs(int fd, ARMHostCPUFeatures *ahcf)
>>>         int ret;
>>>
>>>         reg = &ahcf->isar.idregs[i];
>>> -        ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
>>> -        if (ret) {
>>> -            if (errno == ENOENT) {
>>> -                warn_report("%s error reading value of host %s register "
>>> -                                "(ENOENT)", __func__, sysregdesc->name);
>>> -            } else {
>>> -                error_report("%s error reading value of host %s register"
>>> -                            " (%m)", __func__, sysregdesc->name);
>>> -                err = ret;
>>> +        switch (i) {
>>> +        case DCZID_EL0_IDX:
>>> +            /*
>>> +             * DCZID_EL0 is not in KVM's sys_reg_descs[], so
>>> +             * KVM_GET_ONE_REG will fail. Read it directly from
>>> +             * hardware since KVM doesn't trap guest reads of it.
>>> +             */
>>> +            asm volatile("mrs %0, DCZID_EL0" : "=r" (*reg));
>>> +            break;
>>> +        case CCSIDR_EL1_IDX:
>>> +        case CCSIDR2_EL1_IDX:
>>> +            /*
>>> +             * CCSIDR_EL1 is not a plain ID register: the value it
>>> +             * returns is selected by CSSELR_EL1, so there is no single
>>> +             * value to capture here. It is exposed to userspace only via
>>> +             * the DEMUX API (KVM_REG_ARM_DEMUX_ID_CCSIDR), indexed by
>>> +             * CSSELR. Skip reading it here as there is no meaningful host
>>> +             * value to read.
>>> +             */
>> I think you should rely on prerequisite
>> [PATCH v4 3/3] arm/kvm: get demuxed ID registers from kvm
> Currently I am just skipping those as anyway KVM exposes a very
> barebone Cache topology.
>
> Agreed on using DEMUX regs, in case we want to support exopsing some other
> “config”.
>
> Also on this point, I don’t know if CCSIDR_EL1/CCSIDR2_EL1 should
> be part of idregs[], we already have a ccsidr[], maybe this can be fixed
> in your series.

OK i will investigate this.

Thanks

Eric
>
>>> +            break;
>>> +        case SMIDR_EL1_IDX:
>>> +            /*
>>> +             * As SME is not yet supported by KVM, ignore reading SMIDR_EL1
>>> +             */
>>> +             break;
>>> +        case GMID_EL1_IDX:
>>> +            /*
>>> +             * GMID_EL1 is not in KVM's sys_reg_descs[] and guest reads
>>> +             * the raw host value. But as it is an EL1 register, we cannot
>>> +             * read it directly. This is a genuine miss when MTE is
>>> +             * enabled for the guest.
>>> +             */
>>> +            break;
>>> +        default:
>>> +            ret = read_sys_reg64(fd, reg, idregs_sysreg_to_kvm_reg(sysreg));
>>> +            if (ret) {
>>> +                if (errno == ENOENT) {
>>> +                    warn_report("%s error reading value of host %s register "
>>> +                                    "(ENOENT)", __func__, sysregdesc->name);
>> trace point
> Noted.
>
> Warm Regards,
> Khushit
>>> +                } else {
>>> +                    error_report("%s error reading value of host %s register"
>>> +                                " (%m)", __func__, sysregdesc->name);
>>> +                    err = ret;
>>> +                }
>>>             }
>>>         }
>>>         trace_get_host_cpu_idregs(sysregdesc->name, *reg);
>> Thanks
>>
>> Eric
>


