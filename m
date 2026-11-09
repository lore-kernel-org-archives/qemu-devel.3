Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B4606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zre4xtLt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQK1w-0005Pn-EX; Mon, 09 Nov 2026 02:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xQK1n-0005Oz-Vw; Mon, 09 Nov 2026 02:42:57 -0500
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xQK1j-0001ib-VX; Mon, 09 Nov 2026 02:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794210160; bh=CepK5kvyxbVxZGUf+126+FP7SZPfActg6YYj3/12Q9M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=zre4xtLtVpjYtV8xWCganFHn4IJvmF51G697BY4Ap3VWf85JMSS3KT5jaM59aVgNn
 x5OslFUQjcAfe2yDpL47LMFz9MySJqSa5ps+7tFhy5KAB1cHToLOvLjuUQpnVhZOMC
 ifrOQP6/bwoc2ohB7zA/y3Wf8G2R2azJdGT+Ubwc=
Received: from [100.125.153.207] ([139.159.170.67])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id AA5A505C; Mon, 09 Nov 2026 15:42:37 +0800
X-QQ-mid: xmsmtpt1794210157tbu1sb5kc
Message-ID: <tencent_8809C7F82B4C692913748888B7A752273308@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+vQBn5/jO+yhjZVfR/X6XRNh07M2pDU3DV/4gbnQCNobUsBQc3l
 89x4yEyQ9zOzDCon03SYmuTFQMiYpn7KhW23sdqOBQb69f2Hx18el0agFLYAR6dUYrZbkDf7un2T
 Ubufto9QEHsaP4oAvHZ4N14Y/ZyE1vhTSpeosHQIgCc7ODooIgcVOlXGVAZxYFkO2pX5d32MHf2C
 qA+46OSHjQ9qObk4vGt+od9b6BhLwRQudp2aModqzzWyb3E86P8Kkb0rzVuMBUXdJ2+oZgBibf6h
 EQEYVay7bjE6bgIzuZGliLz236Y6k1ASYg9wBjob/IjAgdGfdDlhvLIEe77naPR5Y4Sc/9Gic8a+
 vnZXP+5xfGzmHu9Uoy3k0LF9ta4X4jVA5uSl04z5Cpp2O9S2yLDK27/wiDi7UfLWqhkDATRg2b9S
 UOEf4Y+iAhG1FkTLa4r198FaQU+Pt88HZMsZAqEIYq9klloaXxlnpl5/egYkQnRSyzVT2YTqm6SE
 wp6xrLrKAu7pCsRiwAa6fy7P8Ez8N0wVwOddEC7U1fhtdPOoIKuUax62Nlj0jS+qhAWOjW289qmu
 wnkr3GSS+2qHhL2u3uHAR1gp6ACVWyfTm/HOjRAiT18vlY3TOc/CbKdn/1TMUmtsA8e/rkrBNLHC
 x9kRC9O/Y22FGhYKjsEkOdmwGpzF4/WneTW7BVl3uBsTmAlpWwPjG0IbfgKNIoRKWBdt7E/mUQiw
 ti+GrcwwSRSi6Rc0DsYvNF91N83dmful7EqauCF7LG9tawol1jtAHUilL2ZS8x+9tmDtdWwMfca2
 1zojpStOuwITtxLJvcDmBT4CDisqexjq6G2dABx8euvhGRBxioNnq4ZV8t4elLJvs3+4GKnn7bhP
 ce2dVNvzltjvnocG/hbKjvjGiSJNGBfYIV8lsdOKqqY5PK6wohwgufBdEhzT2TOIGobKFBNLAQiF
 a9UylHFP2gRUC4IzDUTH4zQ8vmEqH3+bkwJ4wkjUeZ+Gq6KS0gaV/HIOy+atd8hSU2QRMoyHkrHZ
 fLDepAIQsNDII7OaU+K6gGaHD9YxOyaIln6Pu+KgOMyhqcaPI94WZqMQSB9xtmIZa3NL+SRA==
X-QQ-XMRINFO: NI4Ajvh11aEjwDmElj6Fnga+xfKmi0/jgA==
X-OQ-MSGID: <b3aace42-b331-4dbe-9b53-115256a47c04@qq.com>
Date: Mon, 9 Nov 2026 15:42:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, anisinha@redhat.com,
 armbru@redhat.com, eblake@redhat.com, imammedo@redhat.com,
 michael.roth@amd.com, mst@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
 <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
 <27040691-e4b6-44f3-b588-cbbbee13cde2@huawei.com>
 <CAFEAcA_4xb3CBL9TTAdKMOG_ijWpt9wsveCp0R602VoFaWUH1Q@mail.gmail.com>
 <tencent_82895B2529E419B263EC95C8349389114407@qq.com>
 <CAFEAcA-amrQOM8+qnaxgWLyGNM=vp-vKV=OqqU7Qp17PRiH_KA@mail.gmail.com>
 <501bf5cc-cee1-4593-943d-505003541d41@huawei.com>
 <CAFEAcA8ffgrbh_gUK7wcZW5E8p=ZC+CC=3U23ah+nWHxOGpjrg@mail.gmail.com>
 <20261020013906.0ee141e5@jic23-hlaptop>
 <d9e9f9dc-3ac4-4455-b27a-f9a450d319bf@huawei.com>
 <20261106151424.00000fa2@oss.qualcomm.com>
Content-Language: en-US
From: Jinjie Ruan <2118537295@qq.com>
In-Reply-To: <20261106151424.00000fa2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.49; envelope-from=2118537295@qq.com;
 helo=out162-62-57-49.mail.qq.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/7 07:14, Jonathan Cameron 写道:
> 
>>
>> Hi Jonathan,
>>
>>>
>>> FWIW the much more minimal emulation that I posted years ago and
>>> which I few crumbs of in here came up at plumbers this year with
>>
>> With your foundational patch, it is very convenient to extend
>> other functionality.
>>
>>> an engineer from yet another company asking if I could look at
>>> rebasing and upstreaming because they also found it very useful.
>>
>> Glad to hear that someone else is also interested in QEMU emulation of MPAM.
>>
>>> I was trying to work out if I could fit that into my todo list
>>> or whether to ask a colleague to do it.
>>>
>>> As such I'm very pleased to see this surface a few days later!
>>> Even what I had was very useful for testing so I'm with this
>>
>> Feel the same way when developing new features or adapting test cases.
>>
>>> much extended feature set I'm not surprised to hear even more
>>> issues have shaken out.
>>>
>>> It might take me a little while to get time to look at this series
>>> but I definitely plan on doing so!
>>
>> Look forward to your review and suggestions.
> 
> I perhaps got a little carried away and decided to see how good an LLM
> was at generating test cases for this... Was a little painful but
> in the end I think helpful.
> 
> I also span a bunch of runtime options up to exercise all the optional
> properties, field widths etc.  That adds about 600 lines of code and
> 25 machine properties (assuming just memory controller, l2 and l3 caches
> + all homogeneous.)  I might clean that up and post at some point but
> it feels like an optional stage 2 on what you have here!

Hi Jonathan,

Thanks for doing this.

> 
> First up, bunch of fixes related to this.  The field access width ones
> are probably most important and then the various width and HAS_ checks.
> I haven't checked these all closely but some are obviously fine.

Will add these fix in v2, thank you!

> 
> Because it might be helpful, the test follows.  I'm not suggesting this be
> included for now anyway but might help you with v2!
> 
> Maybe long term we include a self test, but one that has had more review
> than I've given this before sharing.

Thank you! have a selftest is good to find these problems.

Best regards,
Jinjie

> 
> Easy to run with:
> 
>   QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-mpam-test --verbose
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index f4f40cacf0..15280c44a0 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -711,6 +711,37 @@ void mpam_cache_fill_info(Object *obj, MpamCacheInfo *info)
>   
>   }
>   
> +/*
> + * IHI0099 9.4: a width-reported fraction field occupies the most
> + * significant 'wd' bits of its 16-bit field; the remaining low bits are
> + * RAZ/WI. Returns a mask of the bits software is allowed to set.
> + */
> +static uint32_t mpam_fracwd_mask(uint32_t wd)
> +{
> +    if (wd >= 16) {
> +        return 0xffffu;
> +    }
> +    return ~((1u << (16 - wd)) - 1) & 0xffffu;
> +}
> +
> +/*
> + * IHI0099 9.4 (MPAMCFG_CPBM<n>/MPAMCFG_MBW_PBM<n>): bit x of register n is
> + * writable iff (n*32)+x <= wd. Returns the writable-bit mask for word
> + * 'array_offset' of such a bitmap, given the overall bitmap width 'wd'.
> + */
> +static uint32_t mpam_bitmap_mask(uint32_t wd, uint32_t array_offset)
> +{
> +    int64_t remaining = (int64_t)wd + 1 - 32 * (int64_t)array_offset;
> +
> +    if (remaining <= 0) {
> +        return 0;
> +    }
> +    if (remaining >= 32) {
> +        return 0xffffffffu;
> +    }
> +    return (1u << remaining) - 1;
> +}
> +
>   static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>                                     unsigned size)
>   {
> @@ -781,14 +812,38 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>       case A_MPAMF_MSMON_IDR:
>           return mpamf->msmon_idr;
>       case A_MPAMF_CSUMON_IDR:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CSUMON_IDR with no CSU monitor support\n");
> +            return 0;
> +        }
>           return mpamf->csumon_idr;
>       case A_MPAMF_MBWUMON_IDR:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of MBWUMON_IDR with no MBWU monitor support\n");
> +            return 0;
> +        }
>           return mpamf->mbwumon_idr;
>       case A_MSMON_CFG_MON_SEL:
>           return s->mon_sel;
>       case A_MSMON_CFG_CSU_FLT:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CSU_FLT with no CSU monitor support\n");
> +            return 0;
> +        }
>           return mpam_csu_mon(s, mpam_mon_ris(s))->flt;
>       case A_MSMON_CFG_CSU_CTL:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CSU_CTL with no CSU monitor support\n");
> +            return 0;
> +        }
>           return mpam_csu_mon(s, mpam_mon_ris(s))->ctl;
>       case A_MSMON_CSU ... (A_MSMON_CSU + 3):
>       case A_MSMON_CSU_CAPTURE ... (A_MSMON_CSU_CAPTURE + 3):
> @@ -802,12 +857,26 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>           return extract32(v, off * 8, 32 - off * 8);
>       }
>       case A_MSMON_CFG_MBWU_FLT:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of MBWU_FLT with no MBWU monitor support\n");
> +            return 0;
> +        }
>           return mpam_mbwu_mon(s, mpam_mon_ris(s))->flt;
>       case A_MSMON_CFG_MBWU_CTL:
>       {
> -        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
> -        uint32_t ctl = m->ctl;
> +        MpamMbwuMon *m;
> +        uint32_t ctl;
>   
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of MBWU_CTL with no MBWU monitor support\n");
> +            return 0;
> +        }
> +        m = mpam_mbwu_mon(s, mpam_mon_ris(s));
> +        ctl = m->ctl;
>           if (m->oflow) {
>               ctl |= R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK;
>           }
> @@ -852,11 +921,24 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>       case A_MPAMF_ERR_MSI_ATTR:
>           return mpamf->err_msi_attr;
>       case A_MPAMF_ECR:
> +        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
> +            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected read of ECR with no ESR support\n");
> +            return 0;
> +        }
>           return s->ecr;
>       case A_MPAMF_ESR:
> +        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
> +            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected read of ESR with no ESR support\n");
> +            return 0;
> +        }
>           return s->esr;
>       case A_MPAMF_ESR + 0x4:
> -        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, EXT)) {
> +        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) ||
> +            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR)) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected read of extended ESR\n");
>               return 0;
> @@ -876,33 +958,59 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>           return mpamf->cfg_intpartid[s->part_sel];
>       }
>       case A_MPAMF_MPAMCFG_CMAX:
> -        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
> +            FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, NO_CMAX)) {
>               qemu_log_mask(LOG_UNIMP,
> -                "MPAM: Unexpected read of CMAX with no CCAP support\n");
> +                "MPAM: Unexpected read of CMAX with no CMAX support\n");
>               return 0;
>           }
>           return mpamf->per_nrw_id[nrw_part_sel].cfg_cmax;
>       case A_MPAMF_MPAMCFG_CMIN:
> -        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
> +            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CMIN)) {
>               qemu_log_mask(LOG_UNIMP,
> -                "MPAM: Unexpected read of CMIN with no CCAP support\n");
> +                "MPAM: Unexpected read of CMIN with no CMIN support\n");
>               return 0;
>           }
>           return mpamf->per_nrw_id[nrw_part_sel].cfg_cmin;
>       case A_MPAMF_MPAMCFG_CASSOC:
> -        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
> +            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CASSOC)) {
>               qemu_log_mask(LOG_UNIMP,
> -                "MPAM: Unexpected read of CASSOC with no CCAP support\n");
> +                "MPAM: Unexpected read of CASSOC with no CASSOC support\n");
>               return 0;
>           }
>           return mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc;
>       case A_MPAMF_MPAMCFG_MBW_MIN:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MIN)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of MBW_MIN with no MBW_MIN support\n");
> +            return 0;
> +        }
>           return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
>       case A_MPAMF_MPAMCFG_MBW_MAX:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MAX)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of MBW_MAX with no MBW_MAX support\n");
> +            return 0;
> +        }
>           return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max;
>       case A_MPAMF_MPAMCFG_PRI:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CFG_PRI with no PRI PART support\n");
> +            return 0;
> +        }
>           return mpamf->per_nrw_id[nrw_part_sel].cfg_pri;
>       case A_MPAMF_MPAMCFG_MBW_PROP:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PROP)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of MBW_PROP with no MBW_PROP support\n");
> +            return 0;
> +        }
>           return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop;
>       case A_MPAMF_MPAMCFG_CPBM0...
>           (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
> @@ -922,9 +1030,10 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>       {
>           uint32_t array_offset;
>   
> -        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PBM)) {
>               qemu_log_mask(LOG_UNIMP,
> -                "MPAM: Unexpected read of MBW_PBM with no MBW_PART support\n");
> +                "MPAM: Unexpected read of MBW_PBM with no MBW_PBM support\n");
>               return 0;
>           }
>           array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
> @@ -1020,70 +1129,147 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>               FIELD_EX32(value, MPAMF_MPAMCFG_INTPARTID, INTPARTID);
>           return;
>       case A_MPAMF_MPAMCFG_CMAX:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
> +            FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, NO_CMAX)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CMAX when not supported\n");
> +            return;
> +        }
>           if (value & ~MPAMF_MPAMCFG_CMAX_WRITE_MASK) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
>                             MPAMF_MPAMCFG_CMAX_WRITE_MASK, value);
>           }
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value;
> +        {
> +            uint32_t wd = FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                      CMAX_WD);
> +            uint32_t valid = mpam_fracwd_mask(wd);
> +
> +            if (FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                            HAS_CMAX_SOFTLIM)) {
> +                valid |= R_MPAMF_MPAMCFG_CMAX_SOFTLIM_MASK;
> +            }
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value & valid;
> +        }
>           return;
>       case A_MPAMF_MPAMCFG_CMIN:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
> +            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CMIN)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CMIN when not supported\n");
> +            return;
> +        }
>           if (value & ~MPAMF_MPAMCFG_CMIN_WRITE_MASK) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to CMIN Mask=%x Value=%lx\n",
>                             MPAMF_MPAMCFG_CMIN_WRITE_MASK, value);
>           }
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_cmin = value;
> +        {
> +            uint32_t wd = FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                      CMAX_WD);
> +
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_cmin =
> +                value & mpam_fracwd_mask(wd);
> +        }
>           return;
>       case A_MPAMF_MPAMCFG_CASSOC:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART) ||
> +            !FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR, HAS_CASSOC)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CASSOC when not supported\n");
> +            return;
> +        }
>           if (value & ~MPAMF_MPAMCFG_CASSOC_WRITE_MASK) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to CASSOC Mask=%x Value=%lx\n",
>                             MPAMF_MPAMCFG_CASSOC_WRITE_MASK, value);
>           }
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc = value;
> +        {
> +            uint32_t wd = FIELD_EX32(mpamf->ccap_idr, MPAMF_CCAP_IDR,
> +                                      CASSOC_WD);
> +
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc =
> +                value & mpam_fracwd_mask(wd);
> +        }
>           return;
>       case A_MPAMF_MPAMCFG_MBW_MIN:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MIN)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to MBW_MIN when not supported\n");
> +            return;
> +        }
>           if (value & ~MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to MBW_MIN Mask=%x Value=%lx\n",
>                             MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK, value);
>           }
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min = value;
> +        {
> +            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD);
> +
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min =
> +                value & mpam_fracwd_mask(wd);
> +        }
>           return;
>       case A_MPAMF_MPAMCFG_MBW_MAX:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_MAX)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to MBW_MAX when not supported\n");
> +            return;
> +        }
>           if (value & ~MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to MBW_MAX Mask=%x Value=%lx\n",
>                             MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
>           }
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value;
> +        {
> +            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD);
> +            uint32_t valid = mpam_fracwd_mask(wd) |
> +                              R_MPAMF_MPAMCFG_MBW_MAX_HARDLIM_MASK;
> +
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value & valid;
> +        }
>           return;
>       case A_MPAMF_MPAMCFG_PRI:
>           if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to CFG_PRI when !HAS_PRI_PART\n");
> -        } else {
> -            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_DSPRI) &&
> -                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, DSPRI)) {
> -                qemu_log_mask(LOG_UNIMP,
> -                              "MPAM: Unexpected write to CFGP_PRI DSPRI when !HAS_DSPRI\n");
> -            }
> -            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_INTPRI) &&
> -                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, INTPRI)) {
> -                qemu_log_mask(LOG_UNIMP,
> -                              "MPAM: Unexpected write to CFGP_PRI INTPRI when !HAS_INTPRI\n");
> -            }
> +            return;
> +        }
> +        {
> +            uint32_t intpri_wd = FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                             INTPRI_WD);
> +            bool has_dspri = FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                        HAS_DSPRI);
> +            uint32_t dspri_wd = FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                            DSPRI_WD);
> +            uint32_t valid = mpam_fracwd_mask(intpri_wd) |
> +                              (has_dspri ?
> +                               (mpam_fracwd_mask(dspri_wd) << 16) : 0);
> +
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_pri = value & valid;
>           }
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_pri = value;
>           return;
>       case A_MPAMF_MPAMCFG_MBW_PROP:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PROP)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to MBW_PROP when not supported\n");
> +            return;
> +        }
>           if (value & ~MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to MBW_PROP Mask=%x Value=%lx\n",
>                             MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK, value);
>           }
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop = value;
> +        {
> +            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, BWA_WD);
> +            uint32_t valid = mpam_fracwd_mask(wd) |
> +                              R_MPAMF_MPAMCFG_MBW_PROP_EN_MASK;
> +
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop = value & valid;
> +        }
>           return;
>       case A_MPAMF_MPAMCFG_CPBM0...
>           (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
> @@ -1105,15 +1291,21 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>       {
>           uint32_t array_offset;
>   
> -        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART) ||
> +            !FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR, HAS_PBM)) {
>               qemu_log_mask(LOG_UNIMP,
> -                          "MPAM: Unexpected write to MBW_PBM when !HAS_MBW_PART\n");
> +                          "MPAM: Unexpected write to MBW_PBM when not supported\n");
>               return;
>           }
> -        /* TODO: Figure out write mask to check this stays in write bits */
>           array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
>   
> -        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
> +        {
> +            uint32_t wd = FIELD_EX32(mpamf->mbw_idr, MPAMF_MBW_IDR,
> +                                      BWPBM_WD);
> +
> +            mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] =
> +                value & mpam_bitmap_mask(wd, array_offset);
> +        }
>           return;
>       }
>       case A_MSMON_CFG_MON_SEL:
> @@ -1151,6 +1343,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>       {
>           uint32_t partid = FIELD_EX32(value, MSMON_CFG_MBWU_FLT, PARTID);
>   
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to MBWU_FLT with no MBWU monitor support\n");
> +            return;
> +        }
>           if (partid >= s->num_partid) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "MPAM: MBWU_FLT PARTID %d out of range\n", partid);
> @@ -1166,9 +1364,16 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>       }
>       case A_MSMON_CFG_MBWU_CTL:
>       {
> -        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
> +        MpamMbwuMon *m;
>   
> -        m->ctl = value;
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_MBWU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to MBWU_CTL with no MBWU monitor support\n");
> +            return;
> +        }
> +        m = mpam_mbwu_mon(s, mpam_mon_ris(s));
> +        m->ctl = value & ~0x00040f00u;
>           if (value & R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK) {
>               m->oflow = false;               /* write-one-to-clear */
>           }
> @@ -1190,6 +1395,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>       {
>           uint32_t partid = FIELD_EX32(value, MSMON_CFG_CSU_FLT, PARTID);
>   
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CSU_FLT with no CSU monitor support\n");
> +            return;
> +        }
>           if (partid >= s->num_partid) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "MPAM: CSU_FLT PARTID %d out of range\n", partid);
> @@ -1204,7 +1415,13 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>           return;
>       }
>       case A_MSMON_CFG_CSU_CTL:
> -        mpam_csu_mon(s, mpam_mon_ris(s))->ctl = value;
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MSMON) ||
> +            !FIELD_EX32(mpamf->msmon_idr, MPAMF_MSMON_IDR, MSMON_CSU)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CSU_CTL with no CSU monitor support\n");
> +            return;
> +        }
> +        mpam_csu_mon(s, mpam_mon_ris(s))->ctl = value & ~0x7ffc0000u;
>           return;
>       case A_MSMON_CSU:
>       case A_MSMON_CSU_CAPTURE:
> @@ -1220,6 +1437,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>                         offset);
>           return;
>       case A_MPAMF_ECR:
> +        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
> +            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to ECR with no ESR support\n");
> +            return;
> +        }
>           if (value & ~MPAMF_ECR_WRITE_MASK) {
>               qemu_log_mask(LOG_UNIMP,
>                             "MPAM: Unexpected write to ECR Mask=%x Value=%lx\n",
> @@ -1230,16 +1453,28 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>           mpam_msc_update_err_irq(s);
>           return;
>       case A_MPAMF_ESR:
> +        if (FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) &&
> +            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_ESR)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to ESR with no ESR support\n");
> +            return;
> +        }
>           /*
>            * Software clears an error by writing ERRCODE as zero; writing a
>            * non-zero ERRCODE activates the level error interrupt (8.2).
>            */
> -        s->esr = deposit64(s->esr, 0, 32, value);
> +        s->esr = deposit64(s->esr, 0, 32, value & ~0x70000000u);
>           mpam_msc_sync_esr_ecr(s);
>           mpam_msc_update_err_irq(s);
>           return;
>       case A_MPAMF_ESR + 0x4:
> -        s->esr = deposit64(s->esr, 32, 32, value);
> +        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, EXT) ||
> +            !FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_EXTD_ESR)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to extended ESR\n");
> +            return;
> +        }
> +        s->esr = deposit64(s->esr, 32, 32, value & ~0xfffffff0u);
>           mpam_msc_sync_esr_ecr(s);
>           mpam_msc_update_err_irq(s);
>           return;


