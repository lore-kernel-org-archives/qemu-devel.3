Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67ACCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 21:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMXqe-0006Ec-KH; Mon, 11 May 2026 17:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wMXqU-0006DL-TE
 for qemu-devel@nongnu.org; Mon, 11 May 2026 17:07:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wMXqS-0002Hf-3c
 for qemu-devel@nongnu.org; Mon, 11 May 2026 17:07:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7TDF868141
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bwQECDQ0yVLCK072h5Y8guHZwZ94T+3iT4RDRyPV+aM=; b=QCpdisJh27voQsfq
 s8j4CJSJBi0cmByI9N+ZYdsn15dkVty5Ayjfgmt2SkQVMYtpHVzbKNS6SEdhmXMf
 QqtY4wZMje/SYeYZ1+4FjvHY0CXoM9E8TcU3oAV+UIMJu1Tl7vnE7qJqpWxR5neb
 0Sh+9CoqLpRYM8Al4wtRkhO5F43EL+dsa9G+hVGHx0VAfTGdfmR5kRPhrwPLCZQh
 WBK94t85xWzWF0naCaKxQul70IhF7OD1xJpmSS4AHxn6qF9X8g2oc9pkXQ2DLuuA
 zPfzWVY6+CGTQjXAMRBNmI1H3w6BFh+KuXXG5YiE/ly6LERnUYcczJwoNjDvr/Nf
 R4J30Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv286aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:07:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ef62078ee7so6325448eec.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778533637; x=1779138437; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bwQECDQ0yVLCK072h5Y8guHZwZ94T+3iT4RDRyPV+aM=;
 b=GIwenBYAFXJiyVaRshZR+PgSzD/i68GHiGr8gTMCSin0zV7YQPACSvjx8L9+vfijdc
 +u7eAMIXs0vSB5+5h6TkYr1dKGkgGGGN/Hu945Q/sFgU9bGuLEo1mSBJymMKw1lhNfNm
 S/+V/8VsUYURCzpx4zSZc32emlJYS8DOSAsisOkku2EiDApvY0tNvnuDUmAQWvVitV6G
 /HeXYtJamNUWHCw9Rj8VJUAODD9/lp7ynikwCoUuqADQTy1cXzmfvVJJG5zzRWPLIN7U
 jWx5mLgfX7vK5zQ7RSmkAz4m2EhC66ZllMQt3e1WYXEyCV7xoMtiQx9yFPlnbLTTAGzu
 THeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778533637; x=1779138437;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bwQECDQ0yVLCK072h5Y8guHZwZ94T+3iT4RDRyPV+aM=;
 b=rEDhgsBRAFuElwIFMjwaNZAZ43OC/uoOCh6btAfH80t77ok4+4xvJ2ZzC5nGEgSQRw
 OQXfNmRdoCXWympuG0vISPYaSfnpH4g3Cs7Sc5TmmFsP8bot5R1ab2OUoXquxvAHSyNE
 iz113KjF4pdndvKCJfhv6+aJqVRmPT+Ikvl35++tHoxA33gYK5TKZ4+zVyQw4/v+eiFs
 esbzBfujS7zmkuT+MyVXW7eN82fQa/I4mpynwgwl3LgnKTVLDWTGd4RpdO96dtzeldIG
 5nEFHjOb+BzLqK5medTyYy/MaF5S4Ppt/30nn7WwvyCUXQT6zUnYgSSCcpcaqZpuR0gd
 0Mrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Yd405BfLAdJIbEYO1m/B9rnrOtWSTLIUD9UUNughUcNSDqAE13bY2+B+d6hpgYyzw4XUOLcHykMFd@nongnu.org
X-Gm-Message-State: AOJu0YxwudQifpF1Cei3GAit7l1ZsPUGdG+qgPOGakk/KDEhZvxamUCh
 hCvzBRBMEg8gzO4+TuLL+WmjSjxLRcVvWO5VderHH16so8R8ZB+lwL9Us1CxTRvXwBPzKQa/vX0
 Hjz+QyoDA3MpPSMCHtgQmvtnl26LyfX3rqYH4RdK3CPUfT1IgCp7RDZ0fTA==
X-Gm-Gg: Acq92OGOv1ocpUWPkgpou4ustrytLmo3JZDajZ7k2aDX8JX3tpek1aalWi3AE14Ozkg
 JQO8Kbh8NQ7tJ5EvbCHk8P55E4VeKI5vQODc4/vkt8ZSZaxrJCbGLb1PPtRRdsETZyZEBIj/ENe
 zXe0UKuzO3NcOjaXd9HCuFPdGdA4A5n7plPzG4G4XwA85mU3kmTFhIhNP75m0Lcuc78+JL6NQzO
 5yJyq+Iv8IdsZfaNjhR7Ab9z2DgFUFxA32119KYaCjrkVLiRAnXfdOE2hAD0RukNla0R5sml6rP
 fZHRvgRisNydVFEPHvdkT+xIbRGLFAb6OvYiEOHId6B8KFvVlRyqgMyXrWTwj8+IBkJwpUoHFgT
 DipzIlcqGzihWwrX0cOvviJ7Z6aX6/EPYMNpRzfEQ8A==
X-Received: by 2002:a05:7022:e14:b0:132:5d96:3e48 with SMTP id
 a92af1059eb24-133452ac9ffmr185972c88.38.1778533636955; 
 Mon, 11 May 2026 14:07:16 -0700 (PDT)
X-Received: by 2002:a05:7022:e14:b0:132:5d96:3e48 with SMTP id
 a92af1059eb24-133452ac9ffmr185943c88.38.1778533636244; 
 Mon, 11 May 2026 14:07:16 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm20332452c88.15.2026.05.11.14.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 14:07:15 -0700 (PDT)
Date: Mon, 11 May 2026 16:07:14 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
Message-ID: <7srjvclfyeoh56ofulv74vajeb2xx6abtnupmsofjzooljw4jl@mifjgm6kzhfh>
References: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
 <h6bbn25obwet4wvv5u4pjtdsndqjsywzsh5kojpv34ow73p5b7@vqnlfxfwbaqv>
 <CAH2o1u6XGcfXrAqREzAFQfi7uX3vStEjWKUdutESPgJdzhbKdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2o1u6XGcfXrAqREzAFQfi7uX3vStEjWKUdutESPgJdzhbKdA@mail.gmail.com>
X-Proofpoint-GUID: 00KpjwHRWD_WQI8jrzVnsKgCiRX-yYVk
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a024506 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=f-PZU8siZNvP0ST5edwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 00KpjwHRWD_WQI8jrzVnsKgCiRX-yYVk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIyNCBTYWx0ZWRfX82uRW/Wy1Ic0
 VvhhDelU1Sjem1fYoFOIlpByD9nWCWUg898bsXXxZJfVtl5gnK8plRgVuORDhmKqUAmFq2Hqga3
 RldxFfBOe8EDwjubwDtKLDE1YqGpVMO+/h80+Wta302wqljTKFkCY07IRjHf3iZzfZHTBYaz0bF
 QVZ+vsZ8jrzgAfO87uu/ofA5hO0LbT10j7HqDHZ5U+9hNWfVJwKAtIw+KDdG5147tZi4qtJe2wS
 mhIQq+DLzh9EcKHWXPpXWe1yTJ6RmeOVRfzRWOc6eZqpv0FxXj9s7T2/D7KsD5Ye1CZ5WrJdoTk
 jPvq4z1n0caShMWh49xxE/u4GADj2m1n/FejiXzdGsJbAWa2ceXNmfHuIA+4kPHIPGOzEDFaN9q
 IM3IwaZvNQSa+ZhMFjBxDZDDnaIvMeSFsz8deCk1+qagHF7Iz/zRVTTOxtkjnIuJ3a/h6wHv+zw
 cLLH+BqbLeR9Y6D/Mgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 10:20:32AM -0700, Tomasz Jeznach wrote:
> Hi Drew,
> 
> On Fri, May 8, 2026 at 2:29 PM Andrew Jones
> <andrew.jones@oss.qualcomm.com> wrote:
> >
> > On Fri, May 08, 2026 at 03:51:29PM -0500, Andrew Jones wrote:
> > > The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
> > > storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
> > > model wasn't checking PTE_N and therefore was using the raw (NAPOT-
> > > encoded) PPN directly in the physical address, yielding an address
> > > 32 KB above the correct base.
> > >
> > > Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
> > > the Svnapot handling already present in target/riscv/cpu_helper.c:
> > >
> > >   napot_bits  = ctz64(ppn) + 1          /* 4 for 64KB */
> > >   napot_mask  = (1 << napot_bits) - 1   /* 0xF */
> > >   phys_base   = PPN_PHYS(ppn & ~napot_mask)
> > >   page_offset = addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))
> > >
> > > The spec only defines napot_bits == 4 (64KB); any other value is
> > > treated as a reserved encoding.
> > >
> > > This is a fix, rather than new feature support, because the spec
> > > says "IOMMU implementations must support the Svnapot standard
> > > extension for NAPOT Translation Contiguity."
> > >
> > > Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> > > Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> >
> > I should have added
> >
> > Cc: qemu-stable@nongnu.org
> >
> > because as soon as [1] is merged into Linux Linux will no longer boot
> > on any QEMU build without this patch.
> >
> > [1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.qualcomm.com/
> >
> > Thanks,
> > drew
> >
> > > ---
> > >  hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 40 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > > index 25a356d1d366..eb09cc974812 100644
> > > --- a/hw/riscv/riscv-iommu.c
> > > +++ b/hw/riscv/riscv-iommu.c
> > > @@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> > >      return true;
> > >  }
> > >
> > > +/* Returns the NAPOT page mask, or 0 for reserved encodings. */
> > > +static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
> > > +{
> > > +    int napot_bits = ctz64(ppn) + 1;
> > > +    hwaddr napot_mask, page_mask;
> > > +
> > > +    /* The spec only defines 64KB (napot_bits == 4) */
> > > +    if (napot_bits != 4) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    napot_mask = (1ULL << napot_bits) - 1;
> > > +    page_mask = PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
> > > +
> > > +    *out = PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
> > > +
> > > +    return page_mask;
> > > +}
> > > +
> > >  /*
> > >   * RISCV IOMMU Address Translation Lookup - Page Table Walk
> > >   *
> > > @@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> > >          } else {
> > >              /* Leaf PTE, translation completed. */
> > >              sc[pass].step = sc[pass].levels;
> > > -            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> > > -            /* Update address mask based on smallest translation granularity */
> > > -            iotlb->addr_mask &= (1ULL << va_skip) - 1;
> > > +
> > > +            if (pte & PTE_N) {
> 
> Would it be worth checking PTE_N only on the last level page table
> entry (sc[pass].step == sc[pass].levels at the start of the block)?
>

Hi Tomasz,

I don't think we need it since we can't get here with non-zero napot bits
on a superpage due to the "Misaligned PPN" check above. And, if we get
past that and PTE_N is erroneously set, then we'll break from the loop
when riscv_iommu_napot_page_mask() returns zero, allowing us to fault on
the bad napot entry.

Thanks,
drew

