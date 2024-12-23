Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4185E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 17:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmMr-0007uh-LW; Mon, 23 Dec 2024 12:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPmMq-0007uE-3P; Mon, 23 Dec 2024 12:37:20 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tPmMo-0004GA-Dg; Mon, 23 Dec 2024 12:37:19 -0500
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-725dbdf380aso3551424b3a.3; 
 Mon, 23 Dec 2024 09:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734975436; x=1735580236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aViMPEtqSCkHN24Voc43NZdUDQBuwUJLMZFwdM7irQ=;
 b=uNd35/ptaWtoxrVzxg7cqi7pdGmkNauy7WJJN+yylPWX178HZ5lGNuJoTNJ+I38Hbc
 09rYd31uxya387IOtytED2NeHTtRi8Q0tj0uNR5Lcq5wRWVuHfRYa3QPWmNtBw91kZDH
 p3QI3ZDQWyTi8mDCJyEs9NBQ6RkljVHJ9SaXD3W6F24ho3/lILQ9S8XhwLEzipBgOE1/
 U4CED3tGISGWuiwHpOzBuFEE0lAA1iT5ux7nBcblabOgnFaP9Bc3CgyozmobbLgB02di
 PvaPfpYIfDNRrGM6tUAA2/EWIWmlcm7tHyGwebspYopl4OR5Wmj+zxYtl4Il9gZwdAKJ
 HJ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZPFUx7HMhW558+EtV3E+PlDGaMuQfAd33ftCKo/3xxr4Uv5vWcJGJXHDnAvHmu2dnh0MB9nTIzvMf2Q==@nongnu.org,
 AJvYcCX5irCznh2h4M1u63R2rEoY0Q0ktP8e3+UL2lFRr7L+o6d2zdMxAbqIojqGR0YA6Qr1fVA4mODqAA==@nongnu.org
X-Gm-Message-State: AOJu0YzmamOzeKjHbueZfKqg5V/ngBiW6wAH3lfdU6tvhSLvNjTtoEhq
 01Poumc+8AelhEC5bobx84Dext3wvKFh0bpRR3d5aN8pa2rVYbVclAdwaA==
X-Gm-Gg: ASbGncvBBEbPaWCCnLHr48Ip0LVe/VWxZFA+xvm7atflWlISq1CUp4IQ3gdyhK05vlP
 srOQVbVvFhGjVr7DjgIr8JIwmSxMyjgWAxBv+p1DcVbTZrO3e13vx/1CoEu4VGKWYJ22BSI+A2R
 F8PYAIRDyC41mX+GUCVFHmbv9k6/S9+ZLeWRQbSm4zmONnxUvi0vrlQgkcHtjZPdWKYuvl0+1/R
 9t8X6Ao5Y3sHPexPhdokQgm+CDg32vsI39x0J4BrO4gYCw/xg7Shjr2ohh9/5EVtvaOy9s4wTOB
 +auFGa+u
X-Google-Smtp-Source: AGHT+IE6mPX2xlZjaM3D6HSc19UQFow7RtYRrTB88Lc26Bwz/DoBmj/4O2h4EmqXhHfmMpHKCa2dEg==
X-Received: by 2002:a05:6a20:7f8b:b0:1e0:dc06:4f4d with SMTP id
 adf61e73a8af0-1e5e04958f8mr20886101637.19.1734975436069; 
 Mon, 23 Dec 2024 09:37:16 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com.
 [209.85.216.42]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842b181b62asm7481078a12.18.2024.12.23.09.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2024 09:37:15 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so3208583a91.2; 
 Mon, 23 Dec 2024 09:37:15 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ql2U/NffkoYnCP02TrTax8t3Do2qbNRkXsnV/4CZ24K0NYCIB8GEJnUG5Y1Y8lhetAzpbE3Kz9MoHA==@nongnu.org,
 AJvYcCWDpduzWbpI3ogWayR6v0Mb/Z7j5qeNOHPd90FtuQUtUIHLyTSuq7umXm3n0juc8MMgBRnhw3LeNA==@nongnu.org
X-Received: by 2002:a17:90b:2dcc:b0:2f1:3355:4a8f with SMTP id
 98e67ed59e1d1-2f452dfcd32mr20180652a91.4.1734975435309; Mon, 23 Dec 2024
 09:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20241223040945.82871-1-j@getutm.app>
 <20241223040945.82871-3-j@getutm.app>
 <CAGCz3vvojZHDdB33OSKH4RY2w6vo+hBTCywSZFWRCX9mTsnijw@mail.gmail.com>
In-Reply-To: <CAGCz3vvojZHDdB33OSKH4RY2w6vo+hBTCywSZFWRCX9mTsnijw@mail.gmail.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 23 Dec 2024 09:37:04 -0800
X-Gmail-Original-Message-ID: <CA+E+eSC7Apq4f7+YmJ_+aiNZHAiwCm2LnK4kGb0-2FggLxC1Ng@mail.gmail.com>
Message-ID: <CA+E+eSC7Apq4f7+YmJ_+aiNZHAiwCm2LnK4kGb0-2FggLxC1Ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] hvf: arm: disable unavailable features on older macOS
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, 
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.179; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f179.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.165, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I think it is acceptable policy to not test against older macOS
versions, although I want to point out that a significant population
of macOS users are still on macOS 11-13. It is bad practice to just
crash when a function is not found. This is why the compiler throws a
warning asking you to explicitly add availability guards. If we were
to ever treat warnings more strictly, this would be an issue. If we
consider older hosts unsupported, we can just test these changes on
newer macOS, confirm that it doesn't cause any regression, and make no
promises on what happens on older macOS.

On Mon, Dec 23, 2024 at 3:31=E2=80=AFAM Phil Dennis-Jordan <lists@philjorda=
n.eu> wrote:
>
> QEMU has a policy of only supporting macOS host versions for 2 years, see=
 docs/about/build-platforms.rst. So you'll probably not be able to get this=
 upstreamed as only macOS 14 and 15 are now supported. (I'm not a great fan=
 of this policy personally, but I guess it makes CI etc easier to handle.)
>
> On Mon, 23 Dec 2024 at 05:11, Joelle van Dyne <j@getutm.app> wrote:
>>
>> IPA size queries were introduced in macOS 13. When QEMU is built targeti=
ng
>> a lower version, the compile will fail. If targeting a higher version an=
d
>> the binary is executed on an older version, QEMU will crash. This will
>> restore the behaviour before IPA max size querying was added which means
>> VMs with 64+ GB of RAM will not work if running on < macOS 13.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>> ---
>>  target/arm/hvf/hvf.c | 55 ++++++++++++++++++++++++++++----------------
>>  1 file changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 0afd96018e..da60476dbc 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -897,7 +897,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPU=
Features *ahcf)
>>      r |=3D hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
>>      r |=3D hv_vcpu_destroy(fd);
>>
>> -    clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
>> +    if (__builtin_available(macOS 13.0, *)) {
>> +        clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0)=
;
>> +    }
>>
>>      ahcf->isar =3D host_isar;
>>
>> @@ -923,26 +925,34 @@ static bool hvf_arm_get_host_cpu_features(ARMHostC=
PUFeatures *ahcf)
>>
>>  uint32_t hvf_arm_get_default_ipa_bit_size(void)
>>  {
>> -    uint32_t default_ipa_size;
>> -    hv_return_t ret =3D hv_vm_config_get_default_ipa_size(&default_ipa_=
size);
>> -    assert_hvf_ok(ret);
>> +    if (__builtin_available(macOS 13.0, *)) {
>> +        uint32_t default_ipa_size;
>> +        hv_return_t ret =3D hv_vm_config_get_default_ipa_size(&default_=
ipa_size);
>> +        assert_hvf_ok(ret);
>>
>> -    return default_ipa_size;
>> +        return default_ipa_size;
>> +    } else {
>> +        return 0;
>> +    }
>>  }
>>
>>  uint32_t hvf_arm_get_max_ipa_bit_size(void)
>>  {
>> -    uint32_t max_ipa_size;
>> -    hv_return_t ret =3D hv_vm_config_get_max_ipa_size(&max_ipa_size);
>> -    assert_hvf_ok(ret);
>> +    if (__builtin_available(macOS 13.0, *)) {
>> +        uint32_t max_ipa_size;
>> +        hv_return_t ret =3D hv_vm_config_get_max_ipa_size(&max_ipa_size=
);
>> +        assert_hvf_ok(ret);
>>
>> -    /*
>> -     * We clamp any IPA size we want to back the VM with to a valid PAR=
ange
>> -     * value so the guest doesn't try and map memory outside of the val=
id range.
>> -     * This logic just clamps the passed in IPA bit size to the first v=
alid
>> -     * PARange value <=3D to it.
>> -     */
>> -    return round_down_to_parange_bit_size(max_ipa_size);
>> +        /*
>> +         * We clamp any IPA size we want to back the VM with to a valid=
 PARange
>> +         * value so the guest doesn't try and map memory outside of the=
 valid
>> +         * range. This logic just clamps the passed in IPA bit size to =
the first
>> +         * valid PARange value <=3D to it.
>> +         */
>> +        return round_down_to_parange_bit_size(max_ipa_size);
>> +    } else {
>> +        return 0;
>> +    }
>>  }
>>
>>  void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
>> @@ -973,13 +983,18 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>>  hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
>>  {
>>      hv_return_t ret;
>> -    hv_vm_config_t config =3D hv_vm_config_create();
>> +    hv_vm_config_t config;
>>
>> -    ret =3D hv_vm_config_set_ipa_size(config, pa_range);
>> -    if (ret !=3D HV_SUCCESS) {
>> -        goto cleanup;
>> +    if (__builtin_available(macOS 13.0, *)) {
>> +        config =3D hv_vm_config_create();
>> +        ret =3D hv_vm_config_set_ipa_size(config, pa_range);
>> +        if (ret !=3D HV_SUCCESS) {
>> +            goto cleanup;
>> +        }
>> +        chosen_ipa_bit_size =3D pa_range;
>> +    } else {
>> +        config =3D NULL;
>>      }
>> -    chosen_ipa_bit_size =3D pa_range;
>>
>>      ret =3D hv_vm_create(config);
>>
>> --
>> 2.41.0
>>
>>

