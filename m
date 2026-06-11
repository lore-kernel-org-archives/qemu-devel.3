Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D6BCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjqh-0007lU-If; Thu, 11 Jun 2026 14:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXjqg-0007jH-4h
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wXjqd-0002Vg-DP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781201386;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bw2WstwxYZHVqC05oy8JKd4Zcnu7Fyd9gY5xNtb280s=;
 b=cfE7MfGH2N7z+GT5MGo92yKPHl7f2YgbBU1HCsmDImpnP74HSQEZaZPphLlVI9JXJjKu1s
 aIQCJyjNM4fN4wmaPInm7+G+2HzdB/cjS0iUioADAkMYp8OahuO6zljHuYbvFsgsyy0+tp
 JIYRYGHUqi2KZFvhVklAsavxH4qOXXU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-weRcxJgfMOu8YhKowhqcaA-1; Thu, 11 Jun 2026 14:09:44 -0400
X-MC-Unique: weRcxJgfMOu8YhKowhqcaA-1
X-Mimecast-MFC-AGG-ID: weRcxJgfMOu8YhKowhqcaA_1781201383
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490c56e2576so606385e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201383; x=1781806183;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bw2WstwxYZHVqC05oy8JKd4Zcnu7Fyd9gY5xNtb280s=;
 b=GioxpvlUeWDzK/xKhGfGeLb4rnY8UCrpGkvMhAFY4sruKJjLUzyuuM+KLVPOdyMx0H
 2O9evU7VAt0ww/QYvV7slEAfhghYvgm6sLFCG84BOwDpOTn+pNtyo4kusHAgjLKFJ+DG
 p683nlFvgKhMkbqfNphzv+gAL3ZYJJU4N8OfVA+y84bc8ktXSGe1EFVlJAr2h/vGfnPe
 QujWjYOibO8isws+rn7ZzCiTYCh5xkiKgF4r7F35zdhMr66AwNnY9ADviFjavkEUPzBZ
 QcbIr7bm8bkaLHjXr05oh/Dzd2jWn13NgEAeGawYk8wUAx7XXTF2114Fcrg53gN7p9vq
 YwEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZV4N0k1wBjcLB6HDjzkkaungy56gtxuSKCEpzbnXDUBtwYZyPmGLqe5ANfkbvN+lDcJqz6Zv65jXL@nongnu.org
X-Gm-Message-State: AOJu0Yzr/169ocA27nPsUmzNbIOkQRtr+mlQd+J3eFH7LgAUS8JF714r
 S1BXY0IbYTva4qDHdQqjzOu0MQv+dIFNLfmgJaiXg4O44/eeimC5SN+9bjvdQej10KeMS0kq3tQ
 +u0Mi7Hta6iNXXP+J42UElAq4//ODMgaPDlJ3pj2awYk+ETSAfywzV6Pp
X-Gm-Gg: Acq92OE5PCN4D52BOD+BqgpXPC4uU291dGJoghLy4QhGLr68byJxHw3b3B0v6UU1LJo
 m6+0mjna3q1SbCH+UQ9T6EK/L5bVIaJJeacGEJnx9hUHu/n3TsFO4qNG6ab37qQfRpmg6sE4zSH
 WEmMR3oZdc6NLBpFJi1U9eMdnexhlu7rAXNbDHtLB2OkbIR9XbkcRgTvu6BNIZS97UW6M2wCnX5
 6gH8OvTGnLF43jB//pjeiA4hedDplk56DCxQXnCKohsU3xMV/PDXpIWnJq+NIjj9Lt2ph4UjzQl
 12WsdLDBFnZ6fjTVL6uRnWnY35gO5CV/bU7EFICeal6tr8T+XZXWBl7tnJBTQwBinjUrPPoxNVG
 IsxQRaWUKqGA6yGIJKlOeCOARaaw891e84zSWonGWGz6aLr5Cjevn6zuDJs+vA4qlQ7pLIw==
X-Received: by 2002:a05:600c:6208:b0:490:ae94:a7e6 with SMTP id
 5b1f17b1804b1-490e561d45amr67430345e9.24.1781201383047; 
 Thu, 11 Jun 2026 11:09:43 -0700 (PDT)
X-Received: by 2002:a05:600c:6208:b0:490:ae94:a7e6 with SMTP id
 5b1f17b1804b1-490e561d45amr67429665e9.24.1781201382558; 
 Thu, 11 Jun 2026 11:09:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b41c7sm3413515e9.1.2026.06.11.11.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 11:09:41 -0700 (PDT)
Message-ID: <528ce8c1-dcec-45bd-9a50-c4c21529f812@redhat.com>
Date: Thu, 11 Jun 2026 20:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] arm: property and value naming summary between named CPU
 models vs customizable host model
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jinqian Yang <yangjinqian1@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Sebastian Ott <sebott@redhat.com>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>
References: <B820643E-3F14-4CDA-BA6B-09C632F17B9E@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <B820643E-3F14-4CDA-BA6B-09C632F17B9E@nutanix.com>
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

Hi Khushit,

On 6/10/26 2:31 PM, Khushit Shah wrote:
> Hi everyone,
>
> Posting the summary of the differences in property/value names and types used
> in named CPU model RFCs [1] and in the customizable host model series [2].

thank you very much for the synthesis.
>
> [1]: (v1) https://lore.kernel.org/qemu-arm/20260513163356.3033159-1-shaju.abraham@nutanix.com/ 
> [1]: (v2) https://lore.kernel.org/qemu-arm/20260605083358.1320563-1-khushit.shah@nutanix.com/
> [2]: (v6)  https://lore.kernel.org/qemu-devel/20260519132905.145643-1-eric.auger@redhat.com/
>
> [2] defines all ID register field level properties, [1] also defines the 
> same field-level properties with some extra sugar.
>
> Approach for CPU Properties in [2]:
>
> Notably, [2] is simpler: a property name follows this convention:
> SYSREG_<ID_REGISTER_NAME>_<FIELD_NAME> and the property values are of type
> u64. A property for a field is added to the CPU object only if the field is
> writable. This means no extra work on the QEMU side when KVM starts
> exposing a new field as writable.
>
> So, say you want to set AES capability for the guest, then you say:
> -cpu host,SYSREG_ID_AA64ISAR0_AES=0/1/2
>
> Approach for CPU Properties in [1]:
> [1] also works on field-based properties. But uses a different convention
> for property names:
>     - for a field that maps 1:1 with ARM ARM FEAT_Xs, define the property
>       name as feat_<FieldName>, for example, ID_AA64ISAR0.AES maps cleanly
>       with FEAT_AES and FEAT_PMULL. Property names for ID_AA64ISAR0.AES,
>       will be feat_AES.
don't you want to also expose feat_PMULL too? In that case ARM ARM
specifies 2 features which are advertised by the same ID reg field. Why
would you advertise one FEAT and not the other? 

In that case the spec says:

0b0000 No AES instructions implemented.
0b0001 AESE, AESD, AESMC, and AESIMC instructions implemented.
0b0010 As for 0b0001, plus PMULL and PMULL2 instructions operating on
64-bit source elements.

FEAT_AES implements the functionality identified by the value 0b0001.
FEAT_PMULL implements the functionality identified by the value 0b0010


>     - for a field that does not cleanly map 1:1 with any ARM ARM FEATs,
>       define the property name as hw_prop_<FieldName>, for example 
>       ID_AA64MMFR0.TGRAN16, CTR_EL0.L1IP, etc., are named like
>       hw_prop_TGRAN16, hw_prop_L1IP, etc.
you may add that the feature mapping is inspired of the kernel
arch/arm64/kvm/kernel/cpufeature.c arm64_ftr_regs[]
You used it to easily identify which fields correspond to feature and
also to extract some other data which are not dealt with in the summary
(safe rule and safe value)
>
> [1] does not generate properties automatically; each property we want to
> add must be added manually.
>
> Property value types in [1]:
> - string properties: for fields which have arch-defined values.
>
>   String values are derived from the kernel's sysreg file, for example,
>   for the field ID_AA64ISAR1.LS64, the sysreg file has
>         UnsignedEnum    63:60   LS64
>                 0b0000  NI
>                 0b0001  LS64
>                 0b0010  LS64_V
>                 0b0011  LS64_ACCDATA
>                 0b0100  LS64WB
>         EndEnum
>
>  In QEMU, the value names are "off", "ls64", "ls64_v”, “ls64_accdata"
>  and "ls64wb". Which also closely match the manual:
you may add that those string values are not specified in ARM ARM. This
is the result of some human processing with possible distortion:

In that case spec says:

0b0000 No LD64B or ST64B instructions are supported.
0b0001 The LD64B and ST64B instructions are supported.
0b0010 As 0b0001, and adds the ST64BV instruction and traps.
0b0011 As 0b0010, and adds the ST64BV0 instruction, ACCDATA_EL1
register, and traps.
0b0100 As 0b0011, and adds support for atomic accesses to Write-back
Cacheable, Shareable memory using one of the following:
     • LD64B and ST64B instructions. • SIMD&FP instructions that load or
store a pair of 128-bit registers by generating 32-byte single-copy
atomic accesses.

Documentation/arch/arm64/cpu-feature-registers.rst documents the ABI for
exporting CPU/ID/feature regs. Those values are not defined there. Is
there any place where those values are documented besides sysreg?

>
>         FEAT_LS64 implements the functionality identified by 0b0001.
>         FEAT_LS64_V implements the functionality identified by 0b0010.
>         FEAT_LS64_ACCDATA implements the functionality identified by 0b0011.
>         FEAT_LS64WB implements the functionality identified by 0b0100.
>
>  In most of the cases, as seen in the Appendix, this works very well.
>
> - u64 properties: for fields which have no arch-defined values, like cache
>    size, debug registers, CPU revision, etc...
> - bool properties: for single-bit fields.
> - Fractional(string) properties: for fields like CSV2 and CSV2_FRAC that
>    collectively decide on a feature version. This helps in preventing invalid
>    configuration like CSV2=0 while CSV2_FRAC=1.
>
> The property and value names for [1] are still open to bikeshedding. I have
> left composites out of this comparison as they are a convenience, and only
> defined for named models.
>
> I have tried to keep the comparison above neutral, but Eric/Cornelia can
> add more. I see real merit in [2]'s simplicity and generalization. But
> for [1], I love a command line that looks like:
> -cpu host,feat_DP=off,feat_AES=off,feat_RAS=0.0,...
>
> instead of:
> -cpu host \
>      SYSREG_ID_AA64ISAR0_DP=0,\
>      SYSREG_ID_AA64ISAR0_AES=0,\
>      SYSREG_ID_AA64PFR0_RAS=0,\
>      SYSREG_ID_AA64PFR1_RAS_FRAC=0 
>
> I have no strong preference on this topic. The named CPU model layer is
> independent of whichever convention we choose here, so I'd like the
> community to decide which direction makes the most sense :)
>
> The Appendix below lists all currently defined properties in [1] and their
> named values.

I would like to add that in [2] we generate all the data from AARCHMRS
registers.json (machine readable spec from ARM). In earlier versions we
also used kernel sysreg as source of truth and we got the feedback from
Marc to try using the MRS instead. The introduction of string values for
some of the props break that attempt because as I explained earlier
those string values are not defined in the spec and therefore cannot be
extracted from the MRS.

Maybe we shall further look at what can be extracted from AARCHMRS
Features.json. 
>
> Warm Regards,
> Khushit
>
> Appendix:
> ==================
> all currently defined properties in [1]:
>
> feat_AES (ID_AA64ISAR0.AES): off, aes, pmull
> feat_AFP (ID_AA64MMFR1.AFP): off, on
> feat_AMU (ID_AA64PFR0.AMU): off, on, v1p1
> feat_AT (ID_AA64MMFR2.AT): off, on
> feat_ATOMIC (ID_AA64ISAR0.ATOMIC): off, on, LSE128
> feat_AdvSIMD (ID_AA64PFR0.ADVSIMD): on, fp16, off
> feat_BBM (ID_AA64MMFR2.BBM): 0, 1, 2
> feat_BC (ID_AA64ISAR2.BC): off, on
> feat_BF16 (ID_AA64ISAR1.BF16): off, on, ebf16
> feat_BIGEND (ID_AA64MMFR0.BIGEND): off, on
> feat_BIGENDEL0 (ID_AA64MMFR0.BIGENDEL0): off, on
> feat_BT (ID_AA64PFR1.BT): off, on
> feat_CLRBHB (ID_AA64ISAR2.CLRBHB): off, on
> feat_CNP (ID_AA64MMFR2.CNP): off, on
> feat_CRC32 (ID_AA64ISAR0.CRC32): off, on
> feat_CSSC (ID_AA64ISAR2.CSSC): off, on, cmpbr
> feat_CSV3 (ID_AA64PFR0.CSV3): off, on
> feat_DBG (ID_AA64DFR0.DEBUGVER): on, vhe, v8p2, v8p4, v8p8, v8p9
> feat_DF2 (ID_AA64PFR1.DF2): off, on
> feat_DGH (ID_AA64ISAR1.DGH): off, on
> feat_DIT (ID_AA64PFR0.DIT): off, on
> feat_DP (ID_AA64ISAR0.DP): off, on
> feat_DPB (ID_AA64ISAR1.DPB): off, on, dpb2
> feat_DoubleLock (ID_AA64DFR0.DOUBLELOCK): on, off
> feat_E0PD (ID_AA64MMFR2.E0PD): off, on
> feat_E2H0 (ID_AA64MMFR4.E2H0): on, ni_nv1, off
> feat_ECBHB (ID_AA64MMFR1.ECBHB): off, on
> feat_ECV (ID_AA64MMFR0.ECV): off, on, cntpoff
> feat_ETS (ID_AA64MMFR1.ETS): off, on, ets2, ets3
> feat_EVT (ID_AA64MMFR2.EVT): off, on, ttlbxs
> feat_EXS (ID_AA64MMFR0.EXS): off, on
> feat_F8CVT (ID_AA64FPFR0.F8CVT): off, on
> feat_F8DP2 (ID_AA64FPFR0.F8DP2): off, on
> feat_F8DP4 (ID_AA64FPFR0.F8DP4): off, on
> feat_F8E4M3 (ID_AA64FPFR0.F8E4M3): off, on
> feat_F8E5M2 (ID_AA64FPFR0.F8E5M2): off, on
> feat_F8FMA (ID_AA64FPFR0.F8FMA): off, on
> feat_F8MM4 (ID_AA64FPFR0.F8MM4): off, on
> feat_F8MM8 (ID_AA64FPFR0.F8MM8): off, on
> feat_FAMINMAX (ID_AA64ISAR3.FAMINMAX): off, on
> feat_FCMA (ID_AA64ISAR1.FCMA): off, on
> feat_FGT (ID_AA64MMFR0.FGT): off, on, fgt2
> feat_FHM (ID_AA64ISAR0.FHM): off, on
> feat_FP (ID_AA64PFR0.FP): on, fp16, off
> feat_FPMR (ID_AA64PFR2.FPMR): off, on
> feat_FPRCVT (ID_AA64ISAR3.FPRCVT): off, on
> feat_FRINTTS (ID_AA64ISAR1.FRINTTS): off, on
> feat_GCS (ID_AA64PFR1.GCS): off, on
> feat_HAFDBS (ID_AA64MMFR1.HAFDBS): off, af, dbm, haft, hdbss
> feat_HCX (ID_AA64MMFR1.HCX): off, on
> feat_HPDS (ID_AA64MMFR1.HPDS): off, on, hpds2
> feat_I8MM (ID_AA64ISAR1.I8MM): off, on
> feat_IESB (ID_AA64MMFR2.IESB): off, on
> feat_JSCVT (ID_AA64ISAR1.JSCVT): off, on
> feat_LO (ID_AA64MMFR1.LO): off, on
> feat_LRCPC (ID_AA64ISAR1.LRCPC): off, on, lrcpc2, lrcpc3
> feat_LS64 (ID_AA64ISAR1.LS64): off, ls64, ls64_v, ls64_accdata, ls64wb
> feat_LSFE (ID_AA64ISAR3.LSFE): off, on
> feat_LSM (ID_AA64MMFR2.LSM): off, on
> feat_LUT (ID_AA64ISAR2.LUT): off, on
> feat_MOPS (ID_AA64ISAR2.MOPS): off, on
> feat_MTE (ID_AA64PFR1.MTE): off, on, mte2, mte3
> feat_MTEFAR (ID_AA64PFR2.MTEFAR): off, on
> feat_MTESTOREONLY (ID_AA64PFR2.MTESTOREONLY): off, on
> feat_MTE_FRAC (ID_AA64PFR1.MTE_FRAC): async, off
> feat_NMI (ID_AA64PFR1.NMI): off, on
> feat_PAN (ID_AA64MMFR1.PAN): off, on, pan2, pan3
> feat_PMU (ID_AA64DFR0.PMUVER): off, on, v3p1, v3p4, v3p5, v3p7, v3p8, v3p9, imp_def
> feat_RDM (ID_AA64ISAR0.RDM): off, on
> feat_RNDR (ID_AA64ISAR0.RNDR): off, on
> feat_RPRES (ID_AA64ISAR2.RPRES): off, on
> feat_RPRFM (ID_AA64ISAR2.RPRFM): off, on
> feat_S1PIE (ID_AA64MMFR3.S1PIE): off, on
> feat_S1POE (ID_AA64MMFR3.S1POE): off, on
> feat_SB (ID_AA64ISAR1.SB): off, on
> feat_SCTLRX (ID_AA64MMFR3.SCTLRX): off, on
> feat_SEL2 (ID_AA64PFR0.SEL2): off, on
> feat_SHA1 (ID_AA64ISAR0.SHA1): off, on
> feat_SHA2 (ID_AA64ISAR0.SHA2): off, sha256, sha512
> feat_SHA3 (ID_AA64ISAR0.SHA3): off, on
> feat_SM3 (ID_AA64ISAR0.SM3): off, on
> feat_SM4 (ID_AA64ISAR0.SM4): off, on
> feat_SNSMEM (ID_AA64MMFR0.SNSMEM): off, on
> feat_SPECRES (ID_AA64ISAR1.SPECRES): off, on, cosp_rctx
> feat_SSBS (ID_AA64PFR1.SSBS): off, on, ssbs2
> feat_SVE (ID_AA64PFR0.SVE): off, on
> feat_SVE_AES (ID_AA64ZFR0.AES): off, on, pmull128, aes2
> feat_SVE_B16B16 (ID_AA64ZFR0.B16B16): off, on, bfscale
> feat_SVE_BFLOAT16 (ID_AA64ZFR0.BFLOAT16): off, on, ebf16
> feat_SVE_BITPERM (ID_AA64ZFR0.BITPERM): off, on
> feat_SVE_ELTPERM (ID_AA64ZFR0.ELTPERM): off, on
> feat_SVE_F16MM (ID_AA64ZFR0.F16MM): off, on
> feat_SVE_F32MM (ID_AA64ZFR0.F32MM): off, on
> feat_SVE_F64MM (ID_AA64ZFR0.F64MM): off, on
> feat_SVE_I8MM (ID_AA64ZFR0.I8MM): off, on
> feat_SVE_SHA3 (ID_AA64ZFR0.SHA3): off, on
> feat_SVE_SM4 (ID_AA64ZFR0.SM4): off, on
> feat_SpecSEI (ID_AA64MMFR1.SPECSEI): off, on
> feat_TCRX (ID_AA64MMFR3.TCRX): off, on
> feat_TIDCP1 (ID_AA64MMFR1.TIDCP1): off, on
> feat_TLB (ID_AA64ISAR0.TLB): off, os, range
> feat_TS (ID_AA64ISAR0.TS): off, flagm, flagm2
> feat_TTL (ID_AA64MMFR2.TTL): off, on
> feat_TWED (ID_AA64MMFR1.TWED): off, on
> feat_UAO (ID_AA64MMFR2.UAO): off, on
> feat_VH (ID_AA64MMFR1.VH): off, on
> feat_WFXT (ID_AA64ISAR2.WFXT): off, on
> feat_XNX (ID_AA64MMFR1.XNX): off, on
> feat_XS (ID_AA64ISAR1.XS): off, on
in [1] you have properties for fields which are not writable in the
kernel whereas [2] exposes a reduced set of props, only for writable
fields. 
>
> Exceptions, because feat_ELx seemed wrong:
> el0_mode (ID_AA64PFR0.EL0): aarch64, aarch32
> el1_mode (ID_AA64PFR0.EL1): aarch64, aarch32
> el2_mode (ID_AA64PFR0.EL2): off, aarch64, aarch32
> el3_mode (ID_AA64PFR0.EL3): off, aarch64, aarch32
>
> CPU identification props:
> cpu_aidr (AIDR.VAL): u64
> cpu_architecture (MIDR.ARCHITECTURE): u64
> cpu_implementer (MIDR.IMPLEMENTER): u64
> cpu_partnum (MIDR.PARTNUM): u64
> cpu_revidr (REVIDR.VAL): u64
> cpu_revision (MIDR.REVISION): u64
> cpu_variant (MIDR.VARIANT): u64
>
> Fractional:
> feat_RAS (Fractional ID_AA64PFR0.RAS, ID_AA64PFR1.RAS_FRAC):
>     0.0, 1.0, 1.1, 1.1_base, 2.0
> feat_CSV2 (Fractional ID_AA64PFR0.CSV2, ID_AA64PFR1.CSV2_FRAC):
>     0.0, 1.0, 1.1, 1.2, 2.0, 3.0
> feat_MPAM (Fractional ID_AA64PFR0.MPAM, ID_AA64PFR1.MPAM_FRAC):
>     0.0, 0.1, 1.0, 1.1
> feat_NV (Fractional ID_AA64MMFR2.NV, ID_AA64MMFR4.NV_FRAC):
>     0.0, nv2_only, 1.0, 2.0, 2.0_only, 2.1
>
> Properties for fields not cleanly mapping 1:1 to any ARM FEAT_x:
> hw_prop_APA (ID_AA64ISAR1.APA): off, pauth, epac, pauth2, fpac, fpaccombine, pauth_lr
> hw_prop_APA3 (ID_AA64ISAR2.APA3): off, pauth, epac, pauth2, fpac, fpaccombine, pauth_lr
> hw_prop_API (ID_AA64ISAR1.API): off, pauth, epac, pauth2, fpac, fpaccombine, pauth_lr
> hw_prop_CCIDX (ID_AA64MMFR2.CCIDX): 32, 64
> hw_prop_FWB (ID_AA64MMFR2.FWB): off, on
> hw_prop_GPA (ID_AA64ISAR1.GPA): off, on
> hw_prop_GPA3 (ID_AA64ISAR2.GPA3): off, on
> hw_prop_GPI (ID_AA64ISAR1.GPI): off, on
> hw_prop_IDS (ID_AA64MMFR2.IDS): 0x0, 0x18
> hw_prop_L1IP (CTR_EL0.L1IP): reserved_vpipt, reserved_aivivt, vipt, pipt
> hw_prop_PARANGE (ID_AA64MMFR0.PARANGE): 32, 36, 40, 42, 44, 48, 52, 56
> hw_prop_PMSVer (ID_AA64DFR0.PMSVER): off, on, v1p1, v1p2, v1p3, v1p4, v1p5
> hw_prop_ST (ID_AA64MMFR2.ST): 39, 48_47
> hw_prop_SVEVer (ID_AA64ZFR0.SVEVER): on, sve2, sve2p1, sve2p2
> hw_prop_TGRAN16 (ID_AA64MMFR0.TGRAN16): off, on, 52_bit
> hw_prop_TGRAN16_2 (ID_AA64MMFR0.TGRAN16_2): tgran16, off, on, 52_bit
> hw_prop_TGRAN4 (ID_AA64MMFR0.TGRAN4): on, 52_bit, off
> hw_prop_TGRAN4_2 (ID_AA64MMFR0.TGRAN4_2): tgran4, off, on, 52_bit
> hw_prop_TGRAN64 (ID_AA64MMFR0.TGRAN64): on, off
> hw_prop_TGRAN64_2 (ID_AA64MMFR0.TGRAN64_2): tgran64, off, on
> hw_prop_VARANGE (ID_AA64MMFR2.VARANGE): 48, 52
> hw_prop_VMIDBITS (ID_AA64MMFR1.VMIDBITS): 8, 16
>
> hw_prop_WRPs (ID_AA64DFR0.WRPS): u64
> hw_prop_IMInline (CTR_EL0.IMINLINE): u64
> hw_prop_IDC (CTR_EL0.IDC): u64
> hw_prop_DMInline (CTR_EL0.DMINLINE): u64
> hw_prop_DZP (DCZID_EL0.DZP): u64
> hw_prop_ERG (CTR_EL0.ERG): u64
> hw_prop_CTX_CMPs (ID_AA64DFR0.CTX_CMPS): u64
> hw_prop_CWG (CTR_EL0.CWG): u64
> hw_prop_DIC (CTR_EL0.DIC): u64
> hw_prop_ASIDBITS (ID_AA64MMFR0.ASIDBITS): 8, 16
> hw_prop_BRPS (ID_AA64DFR0.BRPS): u64
> hw_prop_BS (DCZID_EL0.BS): u64
Thanks

Eric


