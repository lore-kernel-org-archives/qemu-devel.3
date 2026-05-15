Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC20ACD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNuTV-00059c-5F; Fri, 15 May 2026 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNuTG-00053j-Q2
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNuTE-0006bQ-Gt
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778858939;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1yAB4d5XfuEr8Qmgy1UGa9u6X4dCCYWdekOF+hjMiI=;
 b=ZMroMaW/wHDkupoJBnLyH8EJdQ9XonChjrHOnzwPXbSB3QHzhbD1abgg6LPwj3n3sS5CKc
 Y4kPWllv23dQfc11El1eTOSkohUvgpVwwQvDs+f75Fv2p68+bP1ngUYJRRJEW1DVp3LNzX
 MJeJN5g4xBXuuu9nMT342uK9sutEVgY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-oTOQ6egDOdSnd2tQDnOE9Q-1; Fri, 15 May 2026 11:28:57 -0400
X-MC-Unique: oTOQ6egDOdSnd2tQDnOE9Q-1
X-Mimecast-MFC-AGG-ID: oTOQ6egDOdSnd2tQDnOE9Q_1778858936
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ae994d9aaso4964708f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778858936; x=1779463736;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1yAB4d5XfuEr8Qmgy1UGa9u6X4dCCYWdekOF+hjMiI=;
 b=sMb50YaKJ/51IhTxIxx8JKuPN52Jm/gmXwxcZN8vi87ik7D2QDZQI7rjWMFVjw6mJH
 hD3NZE+Y0UeTeqJWMFJ06dLbGzKGujdKpvGORn1xQDe3w9qTkwO8kIXyx4ortf5qbxq+
 YTSfRU07tCwErS3T1E8P/MWeZgqeKii5uD9MbdgI6G+08c1/GI0QZW2/65n8m5VGgIEV
 z28/xQqLktydU0ce4MSQ9APlVfuXJ/Yaj4DkFyuoLT4MK4TXagh1bHwryAXl73VppBPW
 t2C2emu5U6gTntHcKVNugWIWb86oIkjVEJPFDa3d8GaWQj6+xPEq7Je6e8XKlc1wH5bH
 PNkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UwOwMbyXKglf2wyCmzfNrYefWP6NjmbI3Ei1elj+0n13Wl8daixqVi50kUHFoqsCccFEZtx4pFvXO@nongnu.org
X-Gm-Message-State: AOJu0Yy82tuSE4No8HbEws1lFkSdgA7mxyKi4he/g/2U+dLMd9Sy0mD1
 ucGKp+mUy7v7CAvL7wkd46XaNMibhAQvhfcC5VF07NHhPVl+TTctDlusDRGXf2iFXlvfItNKHUy
 ynyvJuGZDXPvWpEsJBQVRvt1XO6GZ97RdYT46EORq6t624fv5im84OVnc
X-Gm-Gg: Acq92OGdCGsy1NmuYLLVj8llCnWv9KnceI5UCa1MM8+MkfCtIO+PyeLPyZ2G/+HIVzK
 5ybPC8IvjWloa8/DprEdkNFB9NZ/B4XiKwv5iIZYA475+bs6WicyulQ7khOeBTrkCkfkAFADoMt
 q6d5K14T1t9fYygsQTk3iS5mkGdyAX0vBDf30Z8Cc/tpPqHCSpU/xeoemmaHEX2hNn9JNfsVrxY
 mDLnPGWeChwi+nSYQ0DfBRe9Xdsl4XTTZV9kX1DNo6stwX9L8R6aNvvByOZuS6PPBjOraoqAcFe
 ZKXsghQNZEytF+wptsdFauSUJH7QlYZ3kWsQ3AR9MhosJwuHfib46NM+wNZEOoIEsVeeMc75csW
 VAkJ9Dnot/GUQIOt5bk/T65viQUb9EvPn+WnA9VOhb6h5wGmFH2iBsA7llqM7gzj9c40sOw==
X-Received: by 2002:a05:600c:8b18:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48fe6515983mr68579795e9.23.1778858936315; 
 Fri, 15 May 2026 08:28:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b18:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48fe6515983mr68579165e9.23.1778858935842; 
 Fri, 15 May 2026 08:28:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab7c5sm70870115e9.12.2026.05.15.08.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 08:28:55 -0700 (PDT)
Message-ID: <2a1eb06f-1293-4d6a-8354-445891ba36ec@redhat.com>
Date: Fri, 15 May 2026 17:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 05/13] target/arm: named_cpu_model: replace FIELD
 macro with IDREG_FIELD
Content-Language: en-US
To: Shaju Abraham <shaju.abraham@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 prerna.saxena@nutanix.com, jon@nutanix.com, jond@nutanix.com,
 Khushit Shah <khushit.shah@nutanix.com>
References: <20260513163356.3033159-1-shaju.abraham@nutanix.com>
 <20260513163356.3033159-6-shaju.abraham@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260513163356.3033159-6-shaju.abraham@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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



On 5/13/26 6:33 PM, Shaju Abraham wrote:
> Replace the existing FIELD() macro with the newly introduced IDREG_FIELD()
> macro to remove deduplication. All definitions for TCG remains the same.
>
> Co-authored-by: Khushit Shah <khushit.shah@nutanix.com>
> Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
> ---
>  target/arm/cpu-features.h | 232 +++-----------------------------------
>  1 file changed, 18 insertions(+), 214 deletions(-)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 4e44245a8b..782850ccec 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -50,14 +50,6 @@ FIELD(CCSIDR_EL1, LINESIZE, 0, 3)
>  FIELD(CCSIDR_EL1, ASSOCIATIVITY, 3, 10)
>  FIELD(CCSIDR_EL1, NUMSETS, 13, 15)
>  
> -FIELD(CTR_EL0,  IMINLINE, 0, 4)
> -FIELD(CTR_EL0,  L1IP, 14, 2)
> -FIELD(CTR_EL0,  DMINLINE, 16, 4)
> -FIELD(CTR_EL0,  ERG, 20, 4)
> -FIELD(CTR_EL0,  CWG, 24, 4)
> -FIELD(CTR_EL0,  IDC, 28, 1)
> -FIELD(CTR_EL0,  DIC, 29, 1)
> -FIELD(CTR_EL0,  TMINLINE, 32, 6)
>  
MIDR_EL1 is also described in 

 target/arm/cpu-idregs.h.inc 
so it could be removed I guess. Please check others

>  FIELD(MIDR_EL1, REVISION, 0, 4)
>  FIELD(MIDR_EL1, PARTNUM, 4, 12)
> @@ -189,217 +181,29 @@ FIELD(ID_PFR1, VIRTUALIZATION, 12, 4)
>  FIELD(ID_PFR1, GENTIMER, 16, 4)
>  FIELD(ID_PFR1, SEC_FRAC, 20, 4)
>  FIELD(ID_PFR1, VIRT_FRAC, 24, 4)
> -FIELD(ID_PFR1, GIC, 28, 4)
in 02/13 you seem to have a partial description of ID_PFR1 and you miss
many other fields. Any reason?

Eric
>  
>  FIELD(ID_PFR2, CSV3, 0, 4)
>  FIELD(ID_PFR2, SSBS, 4, 4)
>  FIELD(ID_PFR2, RAS_FRAC, 8, 4)
>  
> -FIELD(ID_AA64ISAR0, AES, 4, 4)
> -FIELD(ID_AA64ISAR0, SHA1, 8, 4)
> -FIELD(ID_AA64ISAR0, SHA2, 12, 4)
> -FIELD(ID_AA64ISAR0, CRC32, 16, 4)
> -FIELD(ID_AA64ISAR0, ATOMIC, 20, 4)
> -FIELD(ID_AA64ISAR0, TME, 24, 4)
> -FIELD(ID_AA64ISAR0, RDM, 28, 4)
> -FIELD(ID_AA64ISAR0, SHA3, 32, 4)
> -FIELD(ID_AA64ISAR0, SM3, 36, 4)
> -FIELD(ID_AA64ISAR0, SM4, 40, 4)
> -FIELD(ID_AA64ISAR0, DP, 44, 4)
> -FIELD(ID_AA64ISAR0, FHM, 48, 4)
> -FIELD(ID_AA64ISAR0, TS, 52, 4)
> -FIELD(ID_AA64ISAR0, TLB, 56, 4)
> -FIELD(ID_AA64ISAR0, RNDR, 60, 4)
> -
> -FIELD(ID_AA64ISAR1, DPB, 0, 4)
> -FIELD(ID_AA64ISAR1, APA, 4, 4)
> -FIELD(ID_AA64ISAR1, API, 8, 4)
> -FIELD(ID_AA64ISAR1, JSCVT, 12, 4)
> -FIELD(ID_AA64ISAR1, FCMA, 16, 4)
> -FIELD(ID_AA64ISAR1, LRCPC, 20, 4)
> -FIELD(ID_AA64ISAR1, GPA, 24, 4)
> -FIELD(ID_AA64ISAR1, GPI, 28, 4)
> -FIELD(ID_AA64ISAR1, FRINTTS, 32, 4)
> -FIELD(ID_AA64ISAR1, SB, 36, 4)
> -FIELD(ID_AA64ISAR1, SPECRES, 40, 4)
> -FIELD(ID_AA64ISAR1, BF16, 44, 4)
> -FIELD(ID_AA64ISAR1, DGH, 48, 4)
> -FIELD(ID_AA64ISAR1, I8MM, 52, 4)
> -FIELD(ID_AA64ISAR1, XS, 56, 4)
> -FIELD(ID_AA64ISAR1, LS64, 60, 4)
> -
> -FIELD(ID_AA64ISAR2, WFXT, 0, 4)
> -FIELD(ID_AA64ISAR2, RPRES, 4, 4)
> -FIELD(ID_AA64ISAR2, GPA3, 8, 4)
> -FIELD(ID_AA64ISAR2, APA3, 12, 4)
> -FIELD(ID_AA64ISAR2, MOPS, 16, 4)
> -FIELD(ID_AA64ISAR2, BC, 20, 4)
> -FIELD(ID_AA64ISAR2, PAC_FRAC, 24, 4)
> -FIELD(ID_AA64ISAR2, CLRBHB, 28, 4)
> -FIELD(ID_AA64ISAR2, SYSREG_128, 32, 4)
> -FIELD(ID_AA64ISAR2, SYSINSTR_128, 36, 4)
> -FIELD(ID_AA64ISAR2, PRFMSLC, 40, 4)
> -FIELD(ID_AA64ISAR2, RPRFM, 48, 4)
> -FIELD(ID_AA64ISAR2, CSSC, 52, 4)
> -FIELD(ID_AA64ISAR2, LUT, 56, 4)
> -FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
> -
> -FIELD(ID_AA64PFR0, EL0, 0, 4)
> -FIELD(ID_AA64PFR0, EL1, 4, 4)
> -FIELD(ID_AA64PFR0, EL2, 8, 4)
> -FIELD(ID_AA64PFR0, EL3, 12, 4)
> -FIELD(ID_AA64PFR0, FP, 16, 4)
> -FIELD(ID_AA64PFR0, ADVSIMD, 20, 4)
> -FIELD(ID_AA64PFR0, GIC, 24, 4)
> -FIELD(ID_AA64PFR0, RAS, 28, 4)
> -FIELD(ID_AA64PFR0, SVE, 32, 4)
> -FIELD(ID_AA64PFR0, SEL2, 36, 4)
> -FIELD(ID_AA64PFR0, MPAM, 40, 4)
> -FIELD(ID_AA64PFR0, AMU, 44, 4)
> -FIELD(ID_AA64PFR0, DIT, 48, 4)
> -FIELD(ID_AA64PFR0, RME, 52, 4)
> -FIELD(ID_AA64PFR0, CSV2, 56, 4)
> -FIELD(ID_AA64PFR0, CSV3, 60, 4)
> -
> -FIELD(ID_AA64PFR1, BT, 0, 4)
> -FIELD(ID_AA64PFR1, SSBS, 4, 4)
> -FIELD(ID_AA64PFR1, MTE, 8, 4)
> -FIELD(ID_AA64PFR1, RAS_FRAC, 12, 4)
> -FIELD(ID_AA64PFR1, MPAM_FRAC, 16, 4)
> -FIELD(ID_AA64PFR1, SME, 24, 4)
> -FIELD(ID_AA64PFR1, RNDR_TRAP, 28, 4)
> -FIELD(ID_AA64PFR1, CSV2_FRAC, 32, 4)
> -FIELD(ID_AA64PFR1, NMI, 36, 4)
> -FIELD(ID_AA64PFR1, MTE_FRAC, 40, 4)
> -FIELD(ID_AA64PFR1, GCS, 44, 4)
> -FIELD(ID_AA64PFR1, THE, 48, 4)
> -FIELD(ID_AA64PFR1, MTEX, 52, 4)
> -FIELD(ID_AA64PFR1, DF2, 56, 4)
> -FIELD(ID_AA64PFR1, PFAR, 60, 4)
> -
> -FIELD(ID_AA64PFR2, MTEPERM, 0, 4)
> -FIELD(ID_AA64PFR2, MTESTOREONLY, 4, 4)
> -FIELD(ID_AA64PFR2, MTEFAR, 8, 4)
> -FIELD(ID_AA64PFR2, GCIE, 12, 4)
> -FIELD(ID_AA64PFR2, FPMR, 32, 4)
> -
> -FIELD(ID_AA64MMFR0, PARANGE, 0, 4)
> -FIELD(ID_AA64MMFR0, ASIDBITS, 4, 4)
> -FIELD(ID_AA64MMFR0, BIGEND, 8, 4)
> -FIELD(ID_AA64MMFR0, SNSMEM, 12, 4)
> -FIELD(ID_AA64MMFR0, BIGENDEL0, 16, 4)
> -FIELD(ID_AA64MMFR0, TGRAN16, 20, 4)
> -FIELD(ID_AA64MMFR0, TGRAN64, 24, 4)
> -FIELD(ID_AA64MMFR0, TGRAN4, 28, 4)
> -FIELD(ID_AA64MMFR0, TGRAN16_2, 32, 4)
> -FIELD(ID_AA64MMFR0, TGRAN64_2, 36, 4)
> -FIELD(ID_AA64MMFR0, TGRAN4_2, 40, 4)
> -FIELD(ID_AA64MMFR0, EXS, 44, 4)
> -FIELD(ID_AA64MMFR0, FGT, 56, 4)
> -FIELD(ID_AA64MMFR0, ECV, 60, 4)
> -
> -FIELD(ID_AA64MMFR1, HAFDBS, 0, 4)
> -FIELD(ID_AA64MMFR1, VMIDBITS, 4, 4)
> -FIELD(ID_AA64MMFR1, VH, 8, 4)
> -FIELD(ID_AA64MMFR1, HPDS, 12, 4)
> -FIELD(ID_AA64MMFR1, LO, 16, 4)
> -FIELD(ID_AA64MMFR1, PAN, 20, 4)
> -FIELD(ID_AA64MMFR1, SPECSEI, 24, 4)
> -FIELD(ID_AA64MMFR1, XNX, 28, 4)
> -FIELD(ID_AA64MMFR1, TWED, 32, 4)
> -FIELD(ID_AA64MMFR1, ETS, 36, 4)
> -FIELD(ID_AA64MMFR1, HCX, 40, 4)
> -FIELD(ID_AA64MMFR1, AFP, 44, 4)
> -FIELD(ID_AA64MMFR1, NTLBPA, 48, 4)
> -FIELD(ID_AA64MMFR1, TIDCP1, 52, 4)
> -FIELD(ID_AA64MMFR1, CMOW, 56, 4)
> -FIELD(ID_AA64MMFR1, ECBHB, 60, 4)
> -
> -FIELD(ID_AA64MMFR2, CNP, 0, 4)
> -FIELD(ID_AA64MMFR2, UAO, 4, 4)
> -FIELD(ID_AA64MMFR2, LSM, 8, 4)
> -FIELD(ID_AA64MMFR2, IESB, 12, 4)
> -FIELD(ID_AA64MMFR2, VARANGE, 16, 4)
> -FIELD(ID_AA64MMFR2, CCIDX, 20, 4)
> -FIELD(ID_AA64MMFR2, NV, 24, 4)
> -FIELD(ID_AA64MMFR2, ST, 28, 4)
> -FIELD(ID_AA64MMFR2, AT, 32, 4)
> -FIELD(ID_AA64MMFR2, IDS, 36, 4)
> -FIELD(ID_AA64MMFR2, FWB, 40, 4)
> -FIELD(ID_AA64MMFR2, TTL, 48, 4)
> -FIELD(ID_AA64MMFR2, BBM, 52, 4)
> -FIELD(ID_AA64MMFR2, EVT, 56, 4)
> -FIELD(ID_AA64MMFR2, E0PD, 60, 4)
> -
> -FIELD(ID_AA64MMFR3, TCRX, 0, 4)
> -FIELD(ID_AA64MMFR3, SCTLRX, 4, 4)
> -FIELD(ID_AA64MMFR3, S1PIE, 8, 4)
> -FIELD(ID_AA64MMFR3, S2PIE, 12, 4)
> -FIELD(ID_AA64MMFR3, S1POE, 16, 4)
> -FIELD(ID_AA64MMFR3, S2POE, 20, 4)
> -FIELD(ID_AA64MMFR3, AIE, 24, 4)
> -FIELD(ID_AA64MMFR3, MEC, 28, 4)
> -FIELD(ID_AA64MMFR3, D128, 32, 4)
> -FIELD(ID_AA64MMFR3, D128_2, 36, 4)
> -FIELD(ID_AA64MMFR3, SNERR, 40, 4)
> -FIELD(ID_AA64MMFR3, ANERR, 44, 4)
> -FIELD(ID_AA64MMFR3, SDERR, 52, 4)
> -FIELD(ID_AA64MMFR3, ADERR, 56, 4)
> -FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
> -
> -FIELD(ID_AA64MMFR4, POPS, 0, 4)
> -FIELD(ID_AA64MMFR4, EIESB, 4, 4)
> -FIELD(ID_AA64MMFR4, ASID2, 8, 4)
> -FIELD(ID_AA64MMFR4, HACDBS, 12, 4)
> -FIELD(ID_AA64MMFR4, FGWTE3, 16, 4)
> -FIELD(ID_AA64MMFR4, NV_FRAC, 20, 4)
> -FIELD(ID_AA64MMFR4, E2H0, 24, 4)
> -FIELD(ID_AA64MMFR4, RMEGDI, 28, 4)
> -FIELD(ID_AA64MMFR4, E3DSE, 36, 4)
> -FIELD(ID_AA64MMFR4, SRMASK, 44, 4)
> -
> -FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
> -FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
> -FIELD(ID_AA64DFR0, PMUVER, 8, 4)
> -FIELD(ID_AA64DFR0, BRPS, 12, 4)
> -FIELD(ID_AA64DFR0, PMSS, 16, 4)
> -FIELD(ID_AA64DFR0, WRPS, 20, 4)
> -FIELD(ID_AA64DFR0, SEBEP, 24, 4)
> -FIELD(ID_AA64DFR0, CTX_CMPS, 28, 4)
> -FIELD(ID_AA64DFR0, PMSVER, 32, 4)
> -FIELD(ID_AA64DFR0, DOUBLELOCK, 36, 4)
> -FIELD(ID_AA64DFR0, TRACEFILT, 40, 4)
> -FIELD(ID_AA64DFR0, TRACEBUFFER, 44, 4)
> -FIELD(ID_AA64DFR0, MTPMU, 48, 4)
> -FIELD(ID_AA64DFR0, BRBE, 52, 4)
> -FIELD(ID_AA64DFR0, EXTTRCBUFF, 56, 4)
> -FIELD(ID_AA64DFR0, HPMN0, 60, 4)
> -
> -FIELD(ID_AA64ZFR0, SVEVER, 0, 4)
> -FIELD(ID_AA64ZFR0, AES, 4, 4)
> -FIELD(ID_AA64ZFR0, ELTPERM, 12, 4)
> -FIELD(ID_AA64ZFR0, BITPERM, 16, 4)
> -FIELD(ID_AA64ZFR0, BFLOAT16, 20, 4)
> -FIELD(ID_AA64ZFR0, B16B16, 24, 4)
> -FIELD(ID_AA64ZFR0, SHA3, 32, 4)
> -FIELD(ID_AA64ZFR0, SM4, 40, 4)
> -FIELD(ID_AA64ZFR0, I8MM, 44, 4)
> -FIELD(ID_AA64ZFR0, F16MM, 48, 4)
> -FIELD(ID_AA64ZFR0, F32MM, 52, 4)
> -FIELD(ID_AA64ZFR0, F64MM, 56, 4)
> -
> -FIELD(ID_AA64SMFR0, F32F32, 32, 1)
> -FIELD(ID_AA64SMFR0, BI32I32, 33, 1)
> -FIELD(ID_AA64SMFR0, B16F32, 34, 1)
> -FIELD(ID_AA64SMFR0, F16F32, 35, 1)
> -FIELD(ID_AA64SMFR0, I8I32, 36, 4)
> -FIELD(ID_AA64SMFR0, F16F16, 42, 1)
> -FIELD(ID_AA64SMFR0, B16B16, 43, 1)
> -FIELD(ID_AA64SMFR0, I16I32, 44, 4)
> -FIELD(ID_AA64SMFR0, F64F64, 48, 1)
> -FIELD(ID_AA64SMFR0, I16I64, 52, 4)
> -FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
> -FIELD(ID_AA64SMFR0, FA64, 63, 1)
> +/*
> + * Expand FIELD() declarations for every ID register field listed in
> + * cpu-idregs.h.inc .
> + */
> +#define IDREG_START(reg)
> +#define IDREG_END(reg)
> +#define IDREG_FIELD_ARCH_VAL(v, n)
> +#define IDREG_FIELD_ARCH_VAL_ANY
> +#define IDREG_FIELD_END(reg, field)
> +#define IDREG_FIELD_START(reg, field, _shift, _length, safe, defval) \
> +    FIELD(reg, field, _shift, _length)
> +#include "cpu-idregs.h.inc"
> +#undef IDREG_FIELD_START
> +#undef IDREG_FIELD_END
> +#undef IDREG_FIELD_ARCH_VAL_ANY
> +#undef IDREG_FIELD_ARCH_VAL
> +#undef IDREG_END
> +#undef IDREG_START
>  
>  FIELD(ID_DFR0, COPDBG, 0, 4)
>  FIELD(ID_DFR0, COPSDBG, 4, 4)


