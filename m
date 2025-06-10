Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F28DC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 09:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOuwL-0002Kf-8w; Tue, 10 Jun 2025 05:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uOuwK-0002KJ-3P
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 05:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uOuwG-00068b-25
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 05:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749546392;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCNGUdt79UT3hUTrwvrn/b51y7GF2PbbICDInXcjiVY=;
 b=aL2ErXQ/KN+uPvnC0p341H/2SSW12wtJ20q13FzdGz4lLnhb1y4ccxjYV1becr7ffF/fgo
 EOzE80/nYEwaacQg3v8jHVyUGntKWMWNo5teqcGpu7pERgrQrZJ4pirw9b9aqI9ZOyvFvX
 1aZtOfPotUfMaEN0fDE6GYcZgMhHLrU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-erSc1inmPAC61JrDYIsmUQ-1; Tue, 10 Jun 2025 05:06:31 -0400
X-MC-Unique: erSc1inmPAC61JrDYIsmUQ-1
X-Mimecast-MFC-AGG-ID: erSc1inmPAC61JrDYIsmUQ_1749546390
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1856so2116649f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 02:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749546390; x=1750151190;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JCNGUdt79UT3hUTrwvrn/b51y7GF2PbbICDInXcjiVY=;
 b=LRE9zHuL3CPq782BpyKQjZ64IlJkz/JFDEAR6FiehxuZnMFJVI67a3O9d4JqeddADZ
 GU3CcWvHyy8tc11jtigjjo4CrscclZvIzW6A5P5YFc43ZBCyNor9ia4pDTGobthR5Aif
 IpU2ERf133DVrmIlE2KUfq19zXwdh4i/VOUHs+zTHqOxCzDsoldtpfuV4RElN2VMUs/p
 9PLb3Gz6u8fyk0y5Wxy0k5xeCkxpOcp6eLkVdn+nWqHb0xe53IPSZ+WycFHWssClVX45
 hhtmjDUVO3XDEDQ7yjJoVio4a0PVb4VKvPNghgrDtmozZOmHz3sMdg0TiJ9DxJQhxZmM
 3Evw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMghT85R3APMI8h5epYdaQ8qfY63/bgTl837WkI1V7JOLqnLpHuDIpuiyXz/cvf1QWIVF468RXmf7K@nongnu.org
X-Gm-Message-State: AOJu0YxQNCVNYSkdbgc/gQVDOWyblZoCobLhMovwo1vivL+v1stMetpx
 5jUI5BoDQ9U6NGldshjAWugDpkN+zeST2Yp5VdiMhbXYEYL6m9IfGFii/tjy1rCCyUxF1/BsCkF
 5Sfl3wrBkwEtDhH0F7GjwrJwh70PGjyVZ6EwGKU5G3dDXCY7p3flOz8bW
X-Gm-Gg: ASbGnctYGu+dCqFQS8TtIkXLQcSlZDLztvGwq3k1QzTNuyPB+DwLYS/OlzzMRYucpg3
 IBLSXOzf6eIF2iglfl2aNKBijtiNcU3ydv0TNfRO5P+AMAsn0bO4YjNgJzkfiWa1yCcSOfcx27s
 MLLVuQuwXaruGE7ZcpCsiqDDzInOyUDyqXx4quWKA2YSSgIRSFN79mEneqxFD0W3IBYvjLpUDx7
 pdZ8IEfsph2paMLXXSQv7e67wjX28w+4MhH2fGlK49utdiidEOY9Bc0msHuv307bdr/b0ky9p5M
 CFJDpnOwIXyA84RkmU1k0IlEK55y6EtCCKldxeQvcjfT/UEFtKQ48Oupyrmhz9xwRpd+wA==
X-Received: by 2002:a05:6000:3106:b0:3a4:e6d7:6160 with SMTP id
 ffacd0b85a97d-3a531684405mr11632877f8f.6.1749546389663; 
 Tue, 10 Jun 2025 02:06:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrQ8cruOnnMTNOrwqz1zSQ1wyk/+5Xzf+bScn9n1qP8nlcCHznggmAdM/8pGH9H7I5hUUsVQ==
X-Received: by 2002:a05:6000:3106:b0:3a4:e6d7:6160 with SMTP id
 ffacd0b85a97d-3a531684405mr11632844f8f.6.1749546389205; 
 Tue, 10 Jun 2025 02:06:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464f20sm11746155f8f.98.2025.06.10.02.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 02:06:28 -0700 (PDT)
Message-ID: <865a5ec1-f445-45a0-8464-52374355e0a1@redhat.com>
Date: Tue, 10 Jun 2025 11:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Implement ID_AA64PFR2_EL1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
References: <20250609104146.1547437-1-peter.maydell@linaro.org>
 <20250609104146.1547437-3-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250609104146.1547437-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 6/9/25 12:41 PM, Peter Maydell wrote:
> Currently we define the ID_AA64PFR2_EL1 encoding as reserved (with
> the required RAZ behaviour for unassigned system registers in the ID
> register encoding space).  Newer architecture versions start to
> define fields in this ID register, so define the appropriate
> constants and implement it as an ID register backed by a field in
> cpu->isar.  Since none of our CPUs set that isar field to non-zero,
> there is no behavioural change here (other than the name exposed to
> the user via the gdbstub), but this paves the way for implementing
> the new features that use fields in this register.
>
> The fields here are the ones documented in rev L.a of the Arm ARM.

this conflicts with

[PATCH v7 00/14] arm: rework id register storage <https://lore.kernel.org/all/87ikl99oxg.fsf@redhat.com/#r>

on which Connie recently pinged and which sounded mostly ready, except of course if you have objections.

Thanks

Eric

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu-features.h | 5 +++++
>  target/arm/cpu.h          | 1 +
>  target/arm/helper.c       | 6 ++++--
>  target/arm/hvf/hvf.c      | 2 ++
>  target/arm/kvm.c          | 2 ++
>  5 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index db80ea1cc67..a8a94ee9d96 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -275,6 +275,11 @@ FIELD(ID_AA64PFR1, MTEX, 52, 4)
>  FIELD(ID_AA64PFR1, DF2, 56, 4)
>  FIELD(ID_AA64PFR1, PFAR, 60, 4)
>  
> +FIELD(ID_AA64PFR2, MTEPERM, 0, 4)
> +FIELD(ID_AA64PFR2, MTESTOREONLY, 4, 4)
> +FIELD(ID_AA64PFR2, MTEFAR, 8, 4)
> +FIELD(ID_AA64PFR2, FPMR, 32, 4)
> +
>  FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
>  FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
>  FIELD(ID_AA64MMFR0, BIGEND, 8, 4)
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9364d221744..93e055e34fd 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1031,6 +1031,7 @@ struct ArchCPU {
>          uint64_t id_aa64isar2;
>          uint64_t id_aa64pfr0;
>          uint64_t id_aa64pfr1;
> +        uint64_t id_aa64pfr2;
>          uint64_t id_aa64mmfr0;
>          uint64_t id_aa64mmfr1;
>          uint64_t id_aa64mmfr2;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 76312102879..31b667b7e05 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7927,11 +7927,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_aa64_tid3,
>                .resetvalue = cpu->isar.id_aa64pfr1},
> -            { .name = "ID_AA64PFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
> +            { .name = "ID_AA64PFR2_EL1", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 2,
>                .access = PL1_R, .type = ARM_CP_CONST,
>                .accessfn = access_aa64_tid3,
> -              .resetvalue = 0 },
> +              .resetvalue = cpu->isar.id_aa64pfr2 },
>              { .name = "ID_AA64PFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 3,
>                .access = PL1_R, .type = ARM_CP_CONST,
> @@ -8179,6 +8179,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                                 R_ID_AA64PFR1_SSBS_MASK |
>                                 R_ID_AA64PFR1_MTE_MASK |
>                                 R_ID_AA64PFR1_SME_MASK },
> +            { .name = "ID_AA64PFR2_EL1",
> +              .exported_bits = 0 },
>              { .name = "ID_AA64PFR*_EL1_RESERVED",
>                .is_glob = true },
>              { .name = "ID_AA64ZFR0_EL1",
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 42258cc2d88..b4f2b743901 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -493,6 +493,7 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
>      { HV_SYS_REG_ID_AA64PFR0_EL1, HVF_SYSREG(0, 4, 3, 0, 0) },
>  #endif
>      { HV_SYS_REG_ID_AA64PFR1_EL1, HVF_SYSREG(0, 4, 3, 0, 1) },
> +    /* Add ID_AA64PFR2_EL1 here when HVF supports it */
>      { HV_SYS_REG_ID_AA64DFR0_EL1, HVF_SYSREG(0, 5, 3, 0, 0) },
>      { HV_SYS_REG_ID_AA64DFR1_EL1, HVF_SYSREG(0, 5, 3, 0, 1) },
>      { HV_SYS_REG_ID_AA64ISAR0_EL1, HVF_SYSREG(0, 6, 3, 0, 0) },
> @@ -864,6 +865,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      } regs[] = {
>          { HV_SYS_REG_ID_AA64PFR0_EL1, &host_isar.id_aa64pfr0 },
>          { HV_SYS_REG_ID_AA64PFR1_EL1, &host_isar.id_aa64pfr1 },
> +        /* Add ID_AA64PFR2_EL1 here when HVF supports it */
>          { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.id_aa64dfr0 },
>          { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
>          { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.id_aa64isar0 },
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 74fda8b8090..915fc04e54e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -292,6 +292,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      } else {
>          err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr1,
>                                ARM64_SYS_REG(3, 0, 0, 4, 1));
> +        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr2,
> +                              ARM64_SYS_REG(3, 0, 0, 4, 2));
>          err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64smfr0,
>                                ARM64_SYS_REG(3, 0, 0, 4, 5));
>          err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr0,


