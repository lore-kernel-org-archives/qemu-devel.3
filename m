Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B87C10F6FD9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 16:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7yic-0001GB-UZ; Wed, 01 Apr 2026 12:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7yiI-0001FM-LQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 12:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w7yiF-0005Gy-6v
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 12:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775061997;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDcBfFCeMJMlHrzmtFKj8WNYNxpqRHmVAOOpqNzOaSs=;
 b=figdQByQTn/dPx0qRZwNttvfGg249r/gyaUupvhS7oK3FsAi5YqSKVsoGGy7sv3c3ylWYU
 3jKBOvkXYIdsFL6afi+1bJOBPs8jd/z7m9NajQW4d8QUNjKNk3sK1QBZdkWO10ze0lhqNq
 QbV0bXpBX4H0wVBM3NCT+C3AX6EF/gg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-dIUR8s9tNXGbiqKS99_tSA-1; Wed, 01 Apr 2026 12:46:35 -0400
X-MC-Unique: dIUR8s9tNXGbiqKS99_tSA-1
X-Mimecast-MFC-AGG-ID: dIUR8s9tNXGbiqKS99_tSA_1775061993
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d1ceb2ddfso310683f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 09:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775061993; x=1775666793;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDcBfFCeMJMlHrzmtFKj8WNYNxpqRHmVAOOpqNzOaSs=;
 b=eI3TFqIEPPkvB5RABWWQKCkz4wg23lERP0ZDBZQTSav9wZgJ3JqOl+lLSUbdcSlT6S
 KcXfjaOI8MjQH/yNTa8LsJPNzH+DN2wAYyihs1z58hPLUCkv3FAH+gURRyReQ3mqAq+/
 V1EgqqzlnGqgr+LFoAsbiAdmBcps/ebE/QD9t338xEbHJd7xMF9kur2JfWPxp51GlhKc
 rPdDMc6tXxPi8Blvw5nOlUA7Ih7z5HMe3NiENNLdRAtnJxD0mILO+QDJi8eK1TkEMG/U
 vKKITybstF0FqUXAZ2q3ljjHZjlIfQipNG9RMk6g5UA91GuM0B0CH84nQYGvElECi7lw
 VO8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8JTBi0m8MHMnSVAcq+q9pubwgcErD6mGAFFWAjtp98ycAdmuLJ9JqxDvTmJc9Nk3g6pvq1QzLI07t@nongnu.org
X-Gm-Message-State: AOJu0YyeM7T0wkCAkD3RPpLtSzIYvq3p6Xue1/Mto4IHjhaGRRRSxmQq
 9X7OciT89Fp91zLLBqsZaMAc9h/yVeI4lz0RroV0WYSsc+CSyvPUb5zfkyqySSMAjg9pIwxlJy1
 8BonwG12PUq30DAdxxnO7eA8Wh8ybGTThpt624D+ZeYcw5PEPdZPbgzbx
X-Gm-Gg: ATEYQzwdbyPgH6/P7SI2uSXyR+4Gn0qcjenSXE2WAR6oNc+Ptv4hXNdU1VELW71BnHV
 a0uI68zZGoK7YQKaUUZlL/WDuTN1QP7C6pYssTKC2fzV43iCSJRxnZyaeXL+Hb2W/fXvu/b8zth
 hFkTQlPk4CqE2rF8A8bC2VbJkFTfd3VSE01dkfOYY1Io31tcIsKw7g1oxJEEmerKgHT5qn/Loe5
 oFjt+TDiajALZh/rhZ7t0sGZ/iVdjP3YwUpa2SD5TNQosb9dI5W3TT/FvBDIfhwQtM4T6N+fD3a
 YpuaRXQo6b1nVw46yREXR6wg1Ww+sjKtGhAIIFWF524iLAyww+TyPoQSXc8kNHP7lRwvWweFg9D
 G7bkDzO5N5/DP7gTET4x0lk6xgudZf+Gb1pY1pgXBT49D5INLumEKAuNa5MvfygmqN4v61Q==
X-Received: by 2002:a05:6000:184f:b0:43c:f793:f1b0 with SMTP id
 ffacd0b85a97d-43d150f704fmr8444957f8f.40.1775061992914; 
 Wed, 01 Apr 2026 09:46:32 -0700 (PDT)
X-Received: by 2002:a05:6000:184f:b0:43c:f793:f1b0 with SMTP id
 ffacd0b85a97d-43d150f704fmr8444894f8f.40.1775061992283; 
 Wed, 01 Apr 2026 09:46:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d282esm1162543f8f.18.2026.04.01.09.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 09:46:31 -0700 (PDT)
Message-ID: <93e01647-de7e-4c8e-adb0-7c0bda3f656e@redhat.com>
Date: Wed, 1 Apr 2026 18:46:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm: handle CCSIDR_EL1 as a demuxed register
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Ott <sebott@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
References: <20260204133229.297061-1-cohuck@redhat.com>
 <20260204133229.297061-3-cohuck@redhat.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260204133229.297061-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Hi Connie,

On 2/4/26 2:32 PM, Cornelia Huck wrote:
> Move handling of CCSIDR_EL1 over to the new *_IDREG_DEMUX
> infrastructure.
>
> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/intc/armv7m_nvic.c        |  2 +-
>  target/arm/cpu-sysregs.h     |  1 +
>  target/arm/cpu-sysregs.h.inc |  1 +
>  target/arm/cpu.h             |  6 ----
>  target/arm/cpu64.c           | 12 ++++----
>  target/arm/helper.c          |  2 +-
>  target/arm/tcg/cpu32.c       | 32 +++++++++----------
>  target/arm/tcg/cpu64.c       | 60 ++++++++++++++++++------------------
>  8 files changed, 56 insertions(+), 60 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 28b34e99446f..271d16692910 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1337,7 +1337,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>      case 0xd80: /* CSSIDR */
>      {
>          int idx = cpu->env.v7m.csselr[attrs.secure] & R_V7M_CSSELR_INDEX_MASK;
> -        return cpu->ccsidr[idx];
> +        return GET_IDREG_DEMUX(&cpu->isar, CCSIDR, idx);
>      }
>      case 0xd84: /* CSSELR */
>          return cpu->env.v7m.csselr[attrs.secure];
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> index 911f54bc8a4f..ec04174d4a99 100644
> --- a/target/arm/cpu-sysregs.h
> +++ b/target/arm/cpu-sysregs.h
> @@ -37,6 +37,7 @@ typedef enum ARMSysRegs {
>  
>  /* ID registers that vary based upon another register */
>  typedef enum ARMIDRegisterDemuxIdx {
> +    CCSIDR_EL1_DEMUX_IDX,
>      NUM_ID_DEMUX_IDX,
>  } ARMIDRegisterDemuxIdx;
>  
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 3d1ed40f0439..ed466ffb7318 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -37,6 +37,7 @@ DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
>  DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
>  DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
>  DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
> +DEF(CCSIDR_EL1, 3, 1, 0, 0, 0)
Currently, in [PATCH 0/3] Generate target/arm/cpu-sysregs.h.inc from
AARCHMRS Registers.json
and especially [PATCH 1/3] scripts: introduce
scripts/update-aarch64-sysreg-code.py
(https://lore.kernel.org/all/20251208163751.611186-4-eric.auger@redhat.com/)


CCSIDR_EL1 is not automatically generated. 

as target/arm/cpu-sysregs.h.inc should be eventually automatically generated, shouldn't we put this definition somewhere else or do we expect to also automatically generate this demux idreg?


>  DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>  DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
>  DEF(CTR_EL0, 3, 3, 0, 0, 1)
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f9d51c0fc187..b26922ea4298 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1113,10 +1113,6 @@ struct ArchCPU {
>      uint64_t pmceid0;
>      uint64_t pmceid1;
>      uint64_t mp_affinity; /* MP ID without feature bits */
> -    /* The elements of this array are the CCSIDR values for each cache,
> -     * in the order L1DCache, L1ICache, L2DCache, L2ICache, etc.
> -     */
> -    uint64_t ccsidr[16];
>      uint64_t reset_cbar;
>      uint32_t reset_auxcr;
>      bool reset_hivecs;
> @@ -2107,8 +2103,6 @@ FIELD(MFAR, FPA, 12, 40)
>  FIELD(MFAR, NSE, 62, 1)
>  FIELD(MFAR, NS, 63, 1)
>  
> -QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
> -
>  /* If adding a feature bit which corresponds to a Linux ELF
>   * HWCAP bit, remember to update the feature-bit-to-hwcap
>   * mapping in linux-user/elfload.c:get_elf_hwcap().
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4dfc03973e17..798769a42bd3 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -684,11 +684,11 @@ static void aarch64_a57_initfn(Object *obj)
>      cpu->isar.reset_pmcr_el0 = 0x41013000;
>      SET_IDREG(isar, CLIDR, 0x0a200023);
>      /* 32KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
>      /* 48KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2));
>      /* 2048KB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7));
>      set_dczid_bs(cpu, 4); /* 64 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
> @@ -746,11 +746,11 @@ static void aarch64_a53_initfn(Object *obj)
>      cpu->isar.reset_pmcr_el0 = 0x41033000;
>      SET_IDREG(isar, CLIDR, 0x0a200023);
>      /* 32KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
>      /* 32KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2));
>      /* 1024KB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7));
>      set_dczid_bs(cpu, 4); /* 64 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e86ceb130ce9..f1c771461589 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -875,7 +875,7 @@ static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      uint32_t index = A32_BANKED_REG_GET(env, csselr,
>                                          ri->secure & ARM_CP_SECSTATE_S);
>  
> -    return cpu->ccsidr[index];
> +    return GET_IDREG_DEMUX(&cpu->isar, CCSIDR, index);
>  }
>  
>  static void csselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 0b0bc96bac22..75b627f609f5 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -372,9 +372,9 @@ static void cortex_a8_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR4, 0x00111142);
>      cpu->isar.dbgdidr = 0x15141000;
>      SET_IDREG(isar, CLIDR, (1 << 27) | (2 << 24) | 3);
> -    cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
> -    cpu->ccsidr[1] = 0x2007e01a; /* 16k L1 icache. */
> -    cpu->ccsidr[2] = 0xf0000000; /* No L2 icache. */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, 0xe007e01a); /* 16k L1 dcache. */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, 0x2007e01a); /* 16k L1 icache. */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, 0xf0000000); /* No L2 icache. */
>      cpu->reset_auxcr = 2;
>      cpu->isar.reset_pmcr_el0 = 0x41002000;
>      define_arm_cp_regs(cpu, cortexa8_cp_reginfo);
> @@ -448,8 +448,8 @@ static void cortex_a9_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR4, 0x00111142);
>      cpu->isar.dbgdidr = 0x35141000;
>      SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 3);
> -    cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
> -    cpu->ccsidr[1] = 0x200fe019; /* 16k L1 icache. */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, 0xe00fe019); /* 16k L1 dcache. */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, 0x200fe019); /* 16k L1 icache. */
>      cpu->isar.reset_pmcr_el0 = 0x41093000;
>      define_arm_cp_regs(cpu, cortexa9_cp_reginfo);
>  }
> @@ -520,9 +520,9 @@ static void cortex_a7_initfn(Object *obj)
>      cpu->isar.dbgdevid = 0x01110f13;
>      cpu->isar.dbgdevid1 = 0x1;
>      SET_IDREG(isar, CLIDR, 0x0a200023);
> -    cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
> -    cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
> -    cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, 0x701fe00a); /* 32K L1 dcache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, 0x201fe00a); /* 32K L1 icache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, 0x711fe07a); /* 4096K L2 unified cache */
>      cpu->isar.reset_pmcr_el0 = 0x41072000;
>      define_arm_cp_regs(cpu, cortexa15_cp_reginfo); /* Same as A15 */
>  }
> @@ -568,9 +568,9 @@ static void cortex_a15_initfn(Object *obj)
>      cpu->isar.dbgdevid = 0x01110f13;
>      cpu->isar.dbgdevid1 = 0x0;
>      SET_IDREG(isar, CLIDR, 0x0a200023);
> -    cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
> -    cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
> -    cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, 0x701fe00a); /* 32K L1 dcache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, 0x201fe00a); /* 32K L1 icache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, 0x711fe07a); /* 4096K L2 unified cache */
>      cpu->isar.reset_pmcr_el0 = 0x410F3000;
>      define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
>  }
> @@ -759,8 +759,8 @@ static void cortex_r52_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR5, 0x00010001);
>      cpu->isar.dbgdidr = 0x77168000;
>      SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 0x3);
> -    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
> -    cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, 0x700fe01a); /* 32KB L1 dcache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, 0x201fe00a); /* 32KB L1 icache */
>  
>      cpu->pmsav7_dregion = 16;
>      cpu->pmsav8r_hdregion = 16;
> @@ -853,9 +853,9 @@ static void arm_max_initfn(Object *obj)
>      SET_IDREG(isar, ID_ISAR6, 0);
>      cpu->isar.reset_pmcr_el0 = 0x41013000;
>      SET_IDREG(isar, CLIDR, 0x0a200023);
> -    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
> -    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
> -    cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, 0x701fe00a); /* 32KB L1 dcache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, 0x201fe012); /* 48KB L1 icache */
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, 0x70ffe07a); /* 2048KB L2 cache */
>      define_cortex_a72_a57_a53_cp_reginfo(cpu);
>  
>      aa32_max_features(cpu);
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index fa80e48d2beb..3634af5dabf5 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -82,11 +82,11 @@ static void aarch64_a35_initfn(Object *obj)
>  
>      /* From B2.29 Cache ID registers */
>      /* 32KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
>      /* 32KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2));
>      /* 512KB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7));
>  
>      /* From B3.5 VGIC Type register */
>      cpu->gic_num_lrs = 4;
> @@ -250,11 +250,11 @@ static void aarch64_a55_initfn(Object *obj)
>  
>      /* From B2.23 CCSIDR_EL1 */
>      /* 32KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
>      /* 32KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2));
>      /* 512KB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7));
>  
>      /* From B2.96 SCTLR_EL3 */
>      cpu->reset_sctlr = 0x30c50838;
> @@ -320,11 +320,11 @@ static void aarch64_a72_initfn(Object *obj)
>      cpu->isar.reset_pmcr_el0 = 0x41023000;
>      SET_IDREG(isar, CLIDR, 0x0a200023);
>      /* 32KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
>      /* 48KB L1 dcache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2));
>      /* 1MB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7));
>      set_dczid_bs(cpu, 4); /* 64 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
> @@ -383,11 +383,11 @@ static void aarch64_a76_initfn(Object *obj)
>  
>      /* From B2.18 CCSIDR_EL1 */
>      /* 64KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
>      /* 64KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
>      /* 512KB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7));
>  
>      /* From B2.93 SCTLR_EL3 */
>      cpu->reset_sctlr = 0x30c50838;
> @@ -455,11 +455,11 @@ static void aarch64_a78ae_initfn(Object *obj)
>  
>      /* From 3.2.33 CCSIDR_EL1 */
>      /* 64KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
>      /* 64KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
>      /* 512KB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7));
>  
>      /* From 3.2.118 SCTLR_EL3 */
>      cpu->reset_sctlr = 0x30c50838;
> @@ -512,11 +512,11 @@ static void aarch64_a64fx_initfn(Object *obj)
>      SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
>      SET_IDREG(isar, CLIDR, 0x0000000080000023);
>      /* 64KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7));
>      /* 64KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2));
>      /* 8MB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7));
>      set_dczid_bs(cpu, 6); /* 256 bytes */
>      cpu->gic_num_lrs = 4;
>      cpu->gic_vpribits = 5;
> @@ -704,11 +704,11 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
>  
>      /* From B2.23 CCSIDR_EL1 */
>      /* 64KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
>      /* 64KB L1 icache */
> -    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
>      /* 1MB L2 dcache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7));
>  
>      /* From B2.98 SCTLR_EL3 */
>      cpu->reset_sctlr = 0x30c50838;
> @@ -792,11 +792,11 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
>       * L3: No L3 (this matches the CLIDR_EL1 value).
>       */
>      /* 64KB L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
>      /* 64KB L1 icache */
> -    cpu->ccsidr[1] = cpu->ccsidr[0];
> +    COPY_IDREG_DEMUX(isar, CCSIDR, 0, 1);
nit: maybe we don't need a COPY but do get + set, if it is just used in
this file. Or if we keep copy maybe use the memcpy convention?

Eric
>      /* 1MB L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 1 * MiB, 0);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 1 * MiB, 0));
>  
>      /* From 3.2.115 SCTLR_EL3 */
>      cpu->reset_sctlr = 0x30c50838;
> @@ -1034,11 +1034,11 @@ static void aarch64_a710_initfn(Object *obj)
>       * L2: 8-way set associative 64 byte line size, total either 256K or 512K.
>       */
>      /* L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
>      /* L1 icache */
> -    cpu->ccsidr[1] = cpu->ccsidr[0];
> +    COPY_IDREG_DEMUX(isar, CCSIDR, 0, 1);
>      /* L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0));
>  
>      /* FIXME: Not documented -- copied from neoverse-v1 */
>      cpu->reset_sctlr = 0x30c50838;
> @@ -1136,11 +1136,11 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
>       * L2: 8-way set associative 64 byte line size, total either 512K or 1024K.
>       */
>      /* L1 dcache */
> -    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
>      /* L1 icache */
> -    cpu->ccsidr[1] = cpu->ccsidr[0];
> +    COPY_IDREG_DEMUX(isar, CCSIDR, 0, 1);
>      /* L2 cache */
> -    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
> +    SET_IDREG_DEMUX(isar, CCSIDR, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0));
>      /* FIXME: Not documented -- copied from neoverse-v1 */
>      cpu->reset_sctlr = 0x30c50838;
>  


