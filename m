Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54870C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDlm-0001u9-F5; Mon, 17 Jun 2024 10:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDll-0001tu-Jm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:55:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDlj-0001Qy-Bk
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:55:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4216d9952d2so115555e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718636136; x=1719240936; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YW8LPdrw//MdeQil/DozMxJbu8Hmu55sYoSzVF76hVA=;
 b=fnUInwb/5nZMVDtxLUknHKWqyErjUtqtztigvJFaNPMFVpeaLlt8unL8Bv49XDyQNw
 HjxvwyL2yK2Z1CpXeFhvPoDSvXDJSJNJFnzzrjUsbdHUX5W5FJKkvG3yKTg3JqhA9TS9
 2nM5Dijh55SeBPRcQZN3PV8/A5Cl3ZlJ6Cgb73R1zmhchob0jVt/JNijJdNk4mUWElpc
 Qx8WJR3UvAjrhikzoQY29QPHo+hG4DWlDz122KI5o3gV8wvxUo4oyLlIgom2uxaVByZ3
 HoGTqaI9nLYPloX3ikJXCxpDL92P2W/rsnW0TPgl7kDxEIon8cepzfEpnC/K9a2Zl/u+
 HGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718636136; x=1719240936;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YW8LPdrw//MdeQil/DozMxJbu8Hmu55sYoSzVF76hVA=;
 b=Ai7ramzsiUO46zlSWkXTgHbobVOb1r23KtW65cZWzoV+gY9TFl+whZNXOIaeBujPro
 CxI8Y4bMWiEgsKtjgiVrA+/hFzSx08uzPQwjjLBD+SOGaOiVN8p5nhEkVkkL4jQdcUOW
 WCtyUgXCK+E2bnqT3OVdsEvZQxQGSaDBG5sPBaiVrRyJwL36ERZryRoiOOgLIKd3iGsa
 PCU2iQrheTTXVOuMZV1pa1bMbVIuQ3uEjYWVJ92EBwIklOew3Q0EItUrkk9SGF/6Ttz9
 xoMTdDq565safg1apn0zeksEW5RPCQGlsKjiUQl7JPjB7x/gutDCD2bO1JJzRZL+v4TE
 jr5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoXTMWqrRuia07v8H6ShGuoBxiDdK2Zl/T98D350kO4VMZVFtD50zXBwDg41/6bpfF1wVi49O1aLBCmItX9ukrG4BTdws=
X-Gm-Message-State: AOJu0Yw4FHK5QINL/lYV/QHugdXQuAfO/+OIecTHTFEIUaCMHtytxDDG
 jRysAC5t/hBupw98xaDeDm1283L1tRIZeoXmqfVpeUTrEFcJ70Tpn2bkVETLFw==
X-Google-Smtp-Source: AGHT+IFXzmOtwaD5F2r7tIXTXTMYDoLPmdgX02huuLQ5xw3CYNo9vYHY3+sGEtltIxPD8lJmIykM0w==
X-Received: by 2002:a05:600c:3d0d:b0:422:ffac:f8c0 with SMTP id
 5b1f17b1804b1-423b669a19bmr3492795e9.7.1718636136170; 
 Mon, 17 Jun 2024 07:55:36 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602feb0sm158291435e9.20.2024.06.17.07.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:55:34 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:55:30 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 06/18] hw/arm/smmu: Consolidate ASID and VMID types
Message-ID: <ZnBOYvlm-bnbQMjV@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-7-smostafa@google.com>
 <195e906c-d263-4736-91aa-69274fa85180@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <195e906c-d263-4736-91aa-69274fa85180@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=smostafa@google.com; helo=mail-wm1-x330.google.com
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

Sorry no updates for a while, I have been away for some time,
but I am now back to working on this.

On Wed, May 15, 2024 at 02:41:42PM +0200, Eric Auger wrote:
> Hi Mostafa,
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > ASID and VMID used to be uint16_t in the translation config, however,
> > in other contexts they can be int as -1 in case of TLB invalidation,
> other contexts = TLB invalidation, right?

Yes, although I was thinking this can be used for global entries lookup also
in case we would support it in the future.

Thanks,
Mostafa
> > to represent all(don’t care).
> add space bewteen all and (.
> > When stage-2 was added asid was set to -1 in stage-2 and vmid to -1
> > in stage-1 configs. However, that meant they were set as (65536),
> > this was not an issue as nesting was not supported and no
> > commands/lookup targets both.
> s/targets/uses
> >
> > With nesting, it’s critical to get this right as translation must be
> > tagged correctly with ASID/VMID, and with ASID=-1 meaning stage-2.
> > Represent ASID/VMID everywhere as int.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c         | 10 +++++-----
> >  hw/arm/smmuv3.c              |  4 ++--
> >  hw/arm/trace-events          | 18 +++++++++---------
> >  include/hw/arm/smmu-common.h | 14 +++++++-------
> >  4 files changed, 23 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index d94db6b34f..21982621c0 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -57,7 +57,7 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
> >             (k1->vmid == k2->vmid);
> >  }
> >  
> > -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> > +SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> >                                  uint8_t tg, uint8_t level)
> >  {
> >      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
> > @@ -130,7 +130,7 @@ void smmu_iotlb_inv_all(SMMUState *s)
> >  static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> >                                           gpointer user_data)
> >  {
> > -    uint16_t asid = *(uint16_t *)user_data;
> > +    int asid = *(int *)user_data;
> >      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> >  
> >      return SMMU_IOTLB_ASID(*iotlb_key) == asid;
> > @@ -139,7 +139,7 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> >  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
> >                                           gpointer user_data)
> >  {
> > -    uint16_t vmid = *(uint16_t *)user_data;
> > +    int vmid = *(int *)user_data;
> >      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> >  
> >      return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
> > @@ -191,13 +191,13 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >                                  &info);
> >  }
> >  
> > -void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
> > +void smmu_iotlb_inv_asid(SMMUState *s, int asid)
> >  {
> >      trace_smmu_iotlb_inv_asid(asid);
> >      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
> >  }
> >  
> > -void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
> > +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> >  {
> >      trace_smmu_iotlb_inv_vmid(vmid);
> >      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index f98c157221..cc61708160 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -1243,7 +1243,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >          }
> >          case SMMU_CMD_TLBI_NH_ASID:
> >          {
> > -            uint16_t asid = CMD_ASID(&cmd);
> > +            int asid = CMD_ASID(&cmd);
> >  
> >              if (!STAGE1_SUPPORTED(s)) {
> >                  cmd_error = SMMU_CERROR_ILL;
> > @@ -1276,7 +1276,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >              break;
> >          case SMMU_CMD_TLBI_S12_VMALL:
> >          {
> > -            uint16_t vmid = CMD_VMID(&cmd);
> > +            int vmid = CMD_VMID(&cmd);
> >  
> >              if (!STAGE2_SUPPORTED(s)) {
> >                  cmd_error = SMMU_CERROR_ILL;
> > diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> > index cc12924a84..09ccd39548 100644
> > --- a/hw/arm/trace-events
> > +++ b/hw/arm/trace-events
> > @@ -11,13 +11,13 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
> >  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
> >  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
> >  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> > -smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
> > -smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
> > -smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> > +smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=%d"
> > +smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
> > +smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> >  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> > -smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > -smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > -smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
> > +smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > +smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > +smmu_iotlb_insert(int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
> >  
> >  # smmuv3.c
> >  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
> > @@ -48,12 +48,12 @@ smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t p
> >  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> >  smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
> >  smmuv3_cmdq_tlbi_nh(void) ""
> > -smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
> > -smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
> > +smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
> > +smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
> >  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> >  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
> >  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> > -smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
> > +smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
> >  
> >  # strongarm.c
> >  strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index 5944735632..96eb017e50 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -84,7 +84,7 @@ typedef struct SMMUS2Cfg {
> >      bool record_faults;     /* Record fault events (S2R) */
> >      uint8_t granule_sz;     /* Granule page shift (based on S2TG) */
> >      uint8_t eff_ps;         /* Effective PA output range (based on S2PS) */
> > -    uint16_t vmid;          /* Virtual Machine ID (S2VMID) */
> > +    int vmid;               /* Virtual Machine ID (S2VMID) */
> >      uint64_t vttb;          /* Address of translation table base (S2TTB) */
> >  } SMMUS2Cfg;
> >  
> > @@ -108,7 +108,7 @@ typedef struct SMMUTransCfg {
> >      uint64_t ttb;              /* TT base address */
> >      uint8_t oas;               /* output address width */
> >      uint8_t tbi;               /* Top Byte Ignore */
> > -    uint16_t asid;
> > +    int asid;
> >      SMMUTransTableInfo tt[2];
> >      /* Used by stage-2 only. */
> >      struct SMMUS2Cfg s2cfg;
> > @@ -132,8 +132,8 @@ typedef struct SMMUPciBus {
> >  
> >  typedef struct SMMUIOTLBKey {
> >      uint64_t iova;
> > -    uint16_t asid;
> > -    uint16_t vmid;
> > +    int asid;
> > +    int vmid;
> >      uint8_t tg;
> >      uint8_t level;
> >  } SMMUIOTLBKey;
> > @@ -205,11 +205,11 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
> >  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> >                                  SMMUTransTableInfo *tt, hwaddr iova);
> >  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> > -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> > +SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> >                                  uint8_t tg, uint8_t level);
> >  void smmu_iotlb_inv_all(SMMUState *s);
> > -void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
> > -void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
> > +void smmu_iotlb_inv_asid(SMMUState *s, int asid);
> > +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> >  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> >                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
> >  
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Eric
> 

