Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF9FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 10:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxlvD-0008HV-HP; Fri, 19 Apr 2024 06:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rxlvB-0008H1-UW
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:56:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rxlv9-0007MV-NV
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:56:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41699bbfb91so51505e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 03:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713524200; x=1714129000; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vn6JiMl4zrHUKjgNBj59H2lkepqikhr5ZPOEGsYcT9A=;
 b=qDA8TEgEUG0LS+LFTHgD1jwuIFjmIKB3AEv4bRGux3MyVC0G4V2KTC9c4rHskjkhQ2
 b0JMQgLvW7yIHsH53stDDHIpYt1zP0/E7+xg3ejDFxW05ZzgPcd+DwZ8j5SYB43DgTId
 C46FS3vyS4p0CWIEVmueLa7H42KwRv+IPPaQUiMtZwMSjMARN3bPNpc75b3B0N7XyQ/2
 aLoJUx6I47eatMWvRcjzX/RIxUCfoywqR5VskKNi5UaSRxRLOQtZCMRTGuqdARr5Un3s
 I7aIo/R4xw+f7MA3h4J/+AKGOfHWs7UYGFnaJdDOIAMtMpHILxZyLCvy7CO3hAdgQaHs
 aRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713524200; x=1714129000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn6JiMl4zrHUKjgNBj59H2lkepqikhr5ZPOEGsYcT9A=;
 b=xVK+i1ep5ihTciKzsWOwsCJqKaJG6r+CYsjqesn5NXx6L2Sq8NTWvx4hN92dkN50E7
 F1ColJra9+zod2/fJY/JycEOMbDRBro7mw0VAAl6M1VGkA4wVY/Pq3+xQmcSRRGW4ksG
 RD6vX9GIldYnw3R7uvLJz0ptAM54Z5SWo8JqQkOH/fPyLv7X2v4QVOe59LNY4MhK6Bpu
 SJ9OVK85+iaJroypSHv4gAjwYNioiFRgUPI5HuCxJvhxtS4gLqsleUiJbXAeZMZJFNP1
 2usKad1xr9T2ARI4Sq5r9rw7HficZgdtjDlmkw4Z0mliChh18k+d7tVk6PVXmU502PEX
 CSsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8dpJWxrjYG4zpHIOGnxeNTwmlp5pzqlxgFCUyw5l499RwBQAjs1zJnAgnVcQlBdpnhGMWuphPuDp+4efNRqHHizv1Mbc=
X-Gm-Message-State: AOJu0YyKbkJMmhbxih51BeTFbuRp6eOy4VvPtsiRrZQF7gL5UQzHYkRa
 vQQZHuH2prtNq3ItR2UUFhazeSVlpAKhClzTh/sOTD75XcFfSiigT7naXb2fEA==
X-Google-Smtp-Source: AGHT+IEExGVRPnQLjJi4jYbVSqdpM5by59bS570RPwLR/+HBg1+MV6yVt4BanzsSyCObw6kyO8eq7g==
X-Received: by 2002:a05:600c:1d13:b0:418:5aaa:7db1 with SMTP id
 l19-20020a05600c1d1300b004185aaa7db1mr127384wms.1.1713524200382; 
 Fri, 19 Apr 2024 03:56:40 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 f18-20020adff592000000b00343a0e2375esm4114611wro.27.2024.04.19.03.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 03:56:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:56:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v2 07/13] hw/arm/smmu: Support nesting in the rest of
 commands
Message-ID: <ZiJN5AG4lgOU8Mg4@google.com>
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-8-smostafa@google.com>
 <cfb5e002-26d4-437a-91d5-7c2eb49a75b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb5e002-26d4-437a-91d5-7c2eb49a75b6@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Eric,

On Thu, Apr 18, 2024 at 04:48:39PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/8/24 16:08, Mostafa Saleh wrote:
> > Some commands need rework for nesting, as they used to assume S1
> > and S2 are mutually exclusive:
> >
> > - CMD_TLBI_NH_ASID: Consider VMID if stage-2 is supported
> > - CMD_TLBI_NH_ALL: Consider VMID if stage-2 is supported, otherwise
> >   invalidate everything, this required a new vmid invalidation
> >   function for stage-1 only (ASID >= 0)
> >
> > Also, rework trace events to reflect the new implementation.
> 
> This does not apply for me. Could you share a branch or respin?

Oh, Sorry about that. I will address the previous comments and respin.

Thanks,
Mostafa

> 
> Thank you in advance
> 
> Eric
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c         | 36 +++++++++++++++++++++++++++++-------
> >  hw/arm/smmuv3.c              | 31 +++++++++++++++++++++++++++++--
> >  hw/arm/trace-events          |  6 ++++--
> >  include/hw/arm/smmu-common.h |  3 ++-
> >  4 files changed, 64 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 8b9e59b24b..b1cf1303c6 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -148,13 +148,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
> >      g_hash_table_remove_all(s->iotlb);
> >  }
> >  
> > -static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> > -                                         gpointer user_data)
> > +static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
> > +                                              gpointer user_data)
> >  {
> > -    int asid = *(int *)user_data;
> > +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
> >      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> >  
> > -    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
> > +    return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
> > +           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
> >  }
> >  
> >  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
> > @@ -166,6 +167,16 @@ static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
> >      return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
> >  }
> >  
> > +static gboolean smmu_hash_remove_by_vmid_s1(gpointer key, gpointer value,
> > +                                            gpointer user_data)
> > +{
> > +    int vmid = *(int *)user_data;
> > +    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> > +
> > +    return (SMMU_IOTLB_VMID(*iotlb_key) == vmid) &&
> > +           (SMMU_IOTLB_ASID(*iotlb_key) >= 0);
> > +}
> > +
> >  static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
> >                                                gpointer user_data)
> >  {
> > @@ -259,10 +270,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> >                                  &info);
> >  }
> >  
> > -void smmu_iotlb_inv_asid(SMMUState *s, int asid)
> > +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
> >  {
> > -    trace_smmu_iotlb_inv_asid(asid);
> > -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
> > +    SMMUIOTLBPageInvInfo info = {
> > +        .asid = asid,
> > +        .vmid = vmid,
> > +    };
> > +
> > +    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
> > +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
> >  }
> >  
> >  inline void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> > @@ -271,6 +287,12 @@ inline void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> >      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
> >  }
> >  
> > +inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
> > +{
> > +    trace_smmu_iotlb_inv_vmid_s1(vmid);
> > +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
> > +}
> > +
> >  /* VMSAv8-64 Translation */
> >  
> >  /**
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 17bbd43c13..ece647b8bf 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -1280,25 +1280,52 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >          case SMMU_CMD_TLBI_NH_ASID:
> >          {
> >              int asid = CMD_ASID(&cmd);
> > +            int vmid = -1;
> >  
> >              if (!STAGE1_SUPPORTED(s)) {
> >                  cmd_error = SMMU_CERROR_ILL;
> >                  break;
> >              }
> >  
> > +            /*
> > +             * VMID is only matched when stage 2 is supported for the Security
> > +             * state corresponding to the command queue that the command was
> > +             * issued in.
> > +             * QEMU ignores the field by setting to -1, similarly to what STE
> > +             * decoding does. And invalidation commands ignore VMID < 0.
> > +             */
> > +            if (STAGE2_SUPPORTED(s)) {
> > +                vmid = CMD_VMID(&cmd);
> > +            }
> > +
> >              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
> >              smmu_inv_notifiers_all(&s->smmu_state);
> > -            smmu_iotlb_inv_asid(bs, asid);
> > +            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
> >              break;
> >          }
> >          case SMMU_CMD_TLBI_NH_ALL:
> > +        {
> > +            int vmid = -1;
> > +
> >              if (!STAGE1_SUPPORTED(s)) {
> >                  cmd_error = SMMU_CERROR_ILL;
> >                  break;
> >              }
> > +
> > +            /*
> > +             * If stage-2 is supported, invalidate for this VMID only, otherwise
> > +             * invalidate the whole thing, see SMMU_CMD_TLBI_NH_ASID()
> > +             */
> > +            if (STAGE2_SUPPORTED(s)) {
> > +                vmid = CMD_VMID(&cmd);
> > +                trace_smmuv3_cmdq_tlbi_nh(vmid);
> > +                smmu_iotlb_inv_vmid_s1(bs, vmid);
> > +                break;
> > +            }
> >              QEMU_FALLTHROUGH;
> > +        }
> >          case SMMU_CMD_TLBI_NSNH_ALL:
> > -            trace_smmuv3_cmdq_tlbi_nh();
> > +            trace_smmuv3_cmdq_tlbi_nsnh();
> >              smmu_inv_notifiers_all(&s->smmu_state);
> >              smmu_iotlb_inv_all(bs);
> >              break;
> > diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> > index f5c361d96e..2556f4721a 100644
> > --- a/hw/arm/trace-events
> > +++ b/hw/arm/trace-events
> > @@ -11,8 +11,9 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
> >  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
> >  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
> >  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> > -smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
> > +smmu_iotlb_inv_asid_vmid(int asid, uint16_t vmid) "IOTLB invalidate asid=%d vmid=%d"
> >  smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
> > +smmu_iotlb_inv_vmid_s1(uint16_t vmid) "IOTLB invalidate vmid=%d"
> >  smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> >  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> >  smmu_iotlb_lookup_hit(int asid, uint16_t vmid, uint64_t addr, uint64_t mask, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" mask=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > @@ -47,7 +48,8 @@ smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
> >  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> >  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> >  smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> > -smmuv3_cmdq_tlbi_nh(void) ""
> > +smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
> > +smmuv3_cmdq_tlbi_nsnh(void) ""
> >  smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
> >  smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
> >  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index df166d8477..67db30e85b 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -226,8 +226,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> >  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> >                                  uint8_t tg, uint8_t level);
> >  void smmu_iotlb_inv_all(SMMUState *s);
> > -void smmu_iotlb_inv_asid(SMMUState *s, int asid);
> > +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
> >  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> > +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
> >  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
> >  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> 

