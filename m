Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C47CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGSH-0003p6-QL; Wed, 27 May 2026 11:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGSE-0003m1-QV
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGSD-0006cn-42
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779896756;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9muSlnmiwd2mhBLAgro+7z3m7qZ5WDxt0cKhMmUlN+E=;
 b=HDl2qtVjFhfWXaL10UqystNmUW7aH8CO3PAnpbUppq49MI8cLFN4roVTuJeYLxTmldx2b/
 ytnTaygm9jp8LujPAaj4CjbU41X6nUyBADu5YhJF2n4OBADCOBQMPFkUKGYl4HwgWkNo2S
 EPk9A6fvNtPIQ3zCJZYwghlPvuYrjWc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-sktSE2gyOLqHCUgXtzwuJQ-1; Wed, 27 May 2026 11:45:53 -0400
X-MC-Unique: sktSE2gyOLqHCUgXtzwuJQ-1
X-Mimecast-MFC-AGG-ID: sktSE2gyOLqHCUgXtzwuJQ_1779896752
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4903dcb32f8so51869585e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896752; x=1780501552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9muSlnmiwd2mhBLAgro+7z3m7qZ5WDxt0cKhMmUlN+E=;
 b=oAxZzRST4b9DVwkd6HaoJpQlsSjYsY7WseADPTin7mUYzHheKz67f0FMwxS8hvTx00
 m5GXt/rjFUd5sve9wOuYuozwgtjA3glwlRckMXhWtwMXfsMZPcW5OSAY4YhwDFVyj7YP
 1Zqy6oJsJW5GH8KN+OUNMzph4iOdaKnDIAUbJ4aBzF+vkdFIY1bu+Hoi0ji6QyiemXnr
 z2R2VRndzikQXXNeCvXz6LvTnm1LRLEyGnZarETWIxmAnD5zLx3L4yVzAQ7YSV47zw3y
 H2pJvnEyM3R0l3PnTXLKx5ay5aG33W94xQK7EVeKZd2PMVCLw3vP1eVk3mSoAcp04RSS
 wWxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4BW2peUueqfCOCHriJbDY9B1073ak+KooOHy6iht7exi2KRpLIPv2u8Jv+6sBpLMYprI1xZ5cTciI@nongnu.org
X-Gm-Message-State: AOJu0YwgYZog/aOfmCjlnETkdwmA/xsK2hdZOxuXpLiHyPcX7sgzx5c4
 ENUkTkxtl74kWAp2BE4JOBNphQdwtNGGcDN2cIK7zRmzMtr6xLEY0/oPQ63Sw2GWCRq/5jFbSHI
 8zE3G6A3MSukf6kkW+26rc4H7sJIqbr2em+4356moC7bcMYF0yTS/YHMq
X-Gm-Gg: Acq92OHABYEVnk/z+wyRnpNJh3lyDw/GYiuyu8h0pop/azWrSlUpkntDJYBQilZucYd
 EDrteYcZOBXay9vDBco6rnZpLtzw8ORSIsRPnArS63Xhpirbpcq6T+MTvwO0rnsnGFTgr2/a8z7
 bovTVqAX4FcU6Rdbt/VKD2LBNBIWxiLxACCjm1kUjS/sw03kbt24msu8Vtm2SRWNkw2nCLkLGo1
 VMpCjUuqqqPOQTFv36cNYfK7l24e7gSnI5EGGSMfsvvmGrdL/KHETYmmuTv9IGGX2A9g3dSn9Yy
 +NehEkkcdyfmv4F1p+Lh//mzcvwZPA94fL14Pgrc2ZK7Hl91tIHq4fv/8Aw1g7m14mhN6ibLG2l
 Gu5Ro6uvvHJknAaA9klG9r2e3g4CaOL2xFvmcVMEvrsQV47uIXmYVugQl24ys6fY5ht+VrFdEo0
 dZE06Q
X-Received: by 2002:a05:600c:4ecc:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-490428db91cmr360447635e9.26.1779896752302; 
 Wed, 27 May 2026 08:45:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-490428db91cmr360446945e9.26.1779896751891; 
 Wed, 27 May 2026 08:45:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908097a320sm27674265e9.3.2026.05.27.08.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:45:51 -0700 (PDT)
Message-ID: <80fa5157-2376-4010-88b2-deb6ab50f87f@redhat.com>
Date: Wed, 27 May 2026 17:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-16-eric.auger@redhat.com>
 <E5402D74-AE00-4088-801C-C87A749E17C9@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <E5402D74-AE00-4088-801C-C87A749E17C9@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/27/26 4:46 PM, Khushit Shah wrote:
>
>> On 19 May 2026, at 6:57 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>>
>> KVM currently reports some bits as writable whereas they are
>> RES0 or RAZ. This is detected because the code attempts to
>> match those bits against a named field and this later does not
>> exist in target/arm/cpu-idregs.h.inc.
>>
>> Let's silence warnings until those bits get fixed in the kernel.
>>
>> This was observed with v7.1-rc4 kernel.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> target/arm/kvm.c | 23 +++++++++++++++++++----
>> 1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 6373a66bbd..1688cc2106 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -405,6 +405,19 @@ static void get_sysreg_prop(Object *obj, Visitor *v,
>>     trace_get_sysreg_prop(name, value);
>> }
>>
>> +static bool ignore_unnamed_writable_field(ARM64SysReg *reg, int i)
>> +{
>> +    if ((!strcmp(reg->name, "ID_ISAR0_EL1") && i >= 28 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_ISAR5_EL1") && i >= 20 && i <= 23) || /* RES0 */
>> +        (!strcmp(reg->name, "MVFR2_EL1") && i >= 8 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_PFR2_EL1") && i >= 12 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_MMFR5_EL1") && i >= 8 && i <= 31) || /* RES0 */
>> +        (!strcmp(reg->name, "ID_AA64FPFR0_EL1") && i >= 2 && i <= 7)) { /* RAZ */
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> /*
>>  * decode_idreg_writemap: Generate props for writable fields
>>  *
>> @@ -426,10 +439,12 @@ decode_idreg_writemap(Object *obj, int index, uint64_t map, ARM64SysReg *reg)
>>         uint64_t mask;
>>
>>         if (!field) {
>> -            warn_report("%s bit %d of %s is writable but no named field "
>> -                        "in target/arm/cpu-idregs.h.inc",
>> -                        __func__, i, reg->name);
>> -            warn_report("%s is target/arm/cpu-idregs.h.inc?", __func__);
>> +            if (!ignore_unnamed_writable_field(reg, i)) {
>> +                warn_report("%s bit %d of %s is writable but no named field "
>> +                            "in target/arm/cpu-idregs.h.inc",
>> +                            __func__, i, reg->name);
>> +                warn_report("%s is target/arm/cpu-idregs.h.inc?", __func__);
>> +            }
>>             map =  map & ~BIT_ULL(i);
>>             i = ctz64(map);
>>             continue;
>> — 
> This is why I feel the generated cpu-idregs.h.inc should also have information of
> RES0/1 fields as in our RFC. These fields will obviously have only one architecturally
> valid value, hence we will never allow user to write something else.
The good thing is it allowed to detect that kind of kernel inconsistency ;-)

RES fields are not defined either in target/arm/cpu-features.h and since
they are not meant to be touched, it was not that obvious to add them.

What would it change anyway, if we detect we have a writable field
matching a RESx field, I guess we would continue raising a warning, no?

Thanks

Eric

 
>
> Warm Regards,
> Khushit


