Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356D9C2BA18
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDor-0004WW-0d; Mon, 17 Jun 2024 10:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDop-0004Vl-BD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:58:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDon-0001q0-8G
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:58:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-422954bbe29so99845e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718636328; x=1719241128; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oRKD9la71bCcL7Zd98GHxaANLe1GlvshOPxL6fs3iCs=;
 b=3mvOlZ5PnZPB/sZcd4/F9d/oqsNcKdYOij5B9eCqOIPJ2K1MPNhW+4Q+uWxwdMqwdh
 Z+HYar9ekH0EgCXT+v32QZzSxAMuGs261X0dzTSDhhxONwvJabRA/DqimsLljGvGur1T
 qUSOzLl+bF/b65ygJ6l5ehRAWegUwIPiVi/ZV6XA9AyT2Y2l4oaDC/kBp6hFkO7va3DJ
 lbZJOI6jDEPgCZdcjS79UVOZPhhyzSb+o6iLkgBAoCVKlwYEA/ggUVI34RwYV3bsj28/
 Or/jzqKpbpy3oXlHMqA+VIrfwSYVqFBrK2nu/28je2Q4ruMg7/FzX8nHB8no8XfMGtMJ
 Ki8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718636328; x=1719241128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRKD9la71bCcL7Zd98GHxaANLe1GlvshOPxL6fs3iCs=;
 b=wA4MEKioL1pA7n0m4x/WBdx4jDBmP98NiJ5aQZmvCXgZSfAUQ0QsddyRsY+FtUWM6B
 S8LsmKVgr30zKXhRXBcqfrWLC43bxqT2tkc5lh+g0FWe/qPjXFBiYG2gfELoJaPXTqWe
 ild1lur/baLFZUz4i1nusnAfoM1GZoZzJqkCCjBuNKllQxK6LZ6jjDMbZ8/aLK5196xW
 FQViZgKqm9jdeWqL7ubga87LE0o3QyeZmc0+trHZ8CW3HP15ycO3tlUAfuoZtbNl5seM
 8urOAsa+JwDrIjlPvlC9ejvhGv2BvA29884xOYP91+xqEB31LAfATvoN+x51RGLctC8M
 B4Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4kqM7saTvISdbBadwBuYOim8jI5U4rHn6fuXfS3hqeJBq7yOv4iiusH+X50uruG5STCeutqHnS1XhwHV43ZAFJiBPUwc=
X-Gm-Message-State: AOJu0Yz1qAzCPErMldJ35xEwMaM6I2Xau0PgI4vjoI1VeHWoqO/LEVm+
 UTaBpqhGZEA/PmuNbwkROJ6jnjf/8MnJn+w9pMKVi9eNO2xxNHFZyNxctdyNXw==
X-Google-Smtp-Source: AGHT+IGEmSs0H4hyEkUzif4/i7DAQOkklB/i9jz409G9y9k3JaBtWxckp4dpBODT2hAMMyCppO4RNg==
X-Received: by 2002:a05:600c:500f:b0:41b:4c6a:de7a with SMTP id
 5b1f17b1804b1-423b668a734mr3475565e9.3.1718636327446; 
 Mon, 17 Jun 2024 07:58:47 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c883sm12117069f8f.29.2024.06.17.07.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:58:46 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:58:42 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 12/18] hw/arm/smmu: Support nesting in the rest of
 commands
Message-ID: <ZnBPIibjKcjktnb1@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-13-smostafa@google.com>
 <27ca2ea6-94b6-4839-b127-6ac6bc1c7808@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ca2ea6-94b6-4839-b127-6ac6bc1c7808@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
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

On Mon, May 20, 2024 at 12:24:22PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > Some commands need rework for nesting, as they used to assume S1
> > and S2 are mutually exclusive:
> >
> > - CMD_TLBI_NH_ASID: Consider VMID if stage-2 is supported
> > - CMD_TLBI_NH_ALL: Consider VMID if stage-2 is supported, otherwise
> >   invalidate everything, this required a new vmid invalidation
> >   function for stage-1 only (ASID >= 0)
> >
> > Also, rework trace events to reflect the new implementation.
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
> > index fa2460cf64..3ed0be05ef 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -147,13 +147,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
> >      g_hash_table_remove_all(s->iotlb);
> >  }
> >  
> > -static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> > -                                         gpointer user_data)
> > +static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
> > +                                              gpointer user_data)
> Can't you introduce
> 
> smmu_hash_remove_by_asid_vmid() separately and replace the smmu_iotlb_inv_asid() call in SMMU_CMD_TLBI_NH_ASID.
> Then you could focus on "if stage2 is supported" enhancements in this patch.
> 

Sure, will do.

Thanks,
Mostafa
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
> > @@ -165,6 +166,16 @@ static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
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
> > @@ -258,10 +269,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
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
> >  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> > @@ -270,6 +286,12 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
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
> > index 82d918d9b5..e0fd494646 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -1303,25 +1303,52 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
> > index 7d9c1703da..593cc571da 100644
> > --- a/hw/arm/trace-events
> > +++ b/hw/arm/trace-events
> > @@ -11,8 +11,9 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
> >  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
> >  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
> >  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> > -smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=%d"
> > +smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
> >  smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
> > +smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
> >  smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> >  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> >  smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > @@ -47,7 +48,8 @@ smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
> >  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> >  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> >  smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> > -smmuv3_cmdq_tlbi_nh(void) ""
> > +smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
> > +smmuv3_cmdq_tlbi_nsnh(void) ""
> >  smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
> >  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
> >  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index de032fdfd1..361e639630 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -212,8 +212,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
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
> Otherwise looks good to me
> 
> Eric
> 

