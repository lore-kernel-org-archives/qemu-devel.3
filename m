Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266BBCFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQyK-0008Be-C8; Tue, 02 Dec 2025 09:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQQyI-0008BC-Ee
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQQyG-0005Jy-Mi
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764684191;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmAywFg5ob8yJaPp56th2ynm7QeQBFxUD7GChojgsWg=;
 b=LUXj+Wt+Wc2MGRGsFt7HfiAR69AJat4kOKa8wui14wZtKRKzojCbZX1oVXDdWpkzo2Kvwo
 IhNSEP6MkeVHLISBTO1hBWWhN/6c4LLVtQ/GcD4FHpn+n7Krt0LmyZslAtvZwBQyVIp76+
 Crhoi7DqdU2SJtolnxbzzZEDu49ywGc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-w7bkPDI0P0OP46Rf071Y7A-1; Tue, 02 Dec 2025 09:03:10 -0500
X-MC-Unique: w7bkPDI0P0OP46Rf071Y7A-1
X-Mimecast-MFC-AGG-ID: w7bkPDI0P0OP46Rf071Y7A_1764684189
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b22d590227so608918085a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764684189; x=1765288989;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmAywFg5ob8yJaPp56th2ynm7QeQBFxUD7GChojgsWg=;
 b=OrEbZ40xCh0Wk52rpVLVHP21X8F7EvDhf9BGzSgb+AdQNQ3uOYgNcqbPJJCHi0dP7O
 hvBdKtHKTKBSiiJaKrTZaiRB3wWBsXN5mrpS95dR4dvRc+bla2ou4DlqbkPaVYfE5+Ud
 3EgMibyD8AfSzGsIS7N3EMbbf+prZ5UGbpLdxgdDNWMK4c/2bglQp09asQ2eMq9hU0DC
 NqGoPmiSx+cMulwo8OL6zbf2p/p/EnQ9osYTB+lji3Vr7rrA8zJrJy5U9dvMn2eciDVF
 i391i0und7LlPGZg5p0GzckG75QT6JWEKRuNZ4Dip4ab731zJ7eoovx75Ex11Q9AVRXD
 h42g==
X-Gm-Message-State: AOJu0Yws3tqmYtvULa+vgurV5D4ayz5bLnubWM6WZEAnKU8DLUHbMk3o
 oF3ZVGSe9/XVYmTx8ZyuvFfa8H85wxVujkQ/wUa03Uh7tcZ+6SWJIwNm3KwWIZJFFbWOciv7dqQ
 Kecd9vwsRNK8Dh04HAvPBpL31DOC0CKV+KIh+KED0CHCYBQiS0ZQ/BkuL
X-Gm-Gg: ASbGncv6oyQQ8Q/GK3iNjc3vBhMOp96b1/SJcuWRB/jBa1g/yQfaSu8SsjtpHXiTT0c
 x9SiyEZ7CThusDK1SHoB3XAoQy1HSl7lN8++SNyx0YOjMlWtf8y2mBzbUYSzmVmpEkYENFtcxxG
 KEJJjS4sGf7sTYo1p8zMbVlLfRu4dY8hZuBoJubj5GUBuhurFy8RwGGmFwvHlZR6QrS1jD7iLiz
 C/TxnylMs3KZF2rMZfq4bxjO0ligITjkgSiq7fbfD6Uts3WpIpXFaQVJPmp0Xdt8d9HffK4bDGx
 PQ0ZQLk4u+Yf60m7xi5xdAcmZBcmn5aeNXNcU3Z1HHfeYzJMs/FiOg0XnO8/Ps8SNFCHeUHqLt3
 8Y9YE4wpIHOOzAezVrQsdMKJwSpNlSHR5c/XYpKO27JQq9iQLrn75E7064Q==
X-Received: by 2002:ac8:7f42:0:b0:4ed:e5c1:797 with SMTP id
 d75a77b69052e-4efbd8f4e45mr419967171cf.23.1764684188100; 
 Tue, 02 Dec 2025 06:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhHS60lM6NUhNZ0nx6l97qAS0PdI/uUyQe9V8o1j/Wbpx5yvth3LE9Fa4s9WX3TxUI4IDQlQ==
X-Received: by 2002:ac8:7f42:0:b0:4ed:e5c1:797 with SMTP id
 d75a77b69052e-4efbd8f4e45mr419964791cf.23.1764684185878; 
 Tue, 02 Dec 2025 06:03:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efd2fbc481sm95103951cf.10.2025.12.02.06.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 06:03:05 -0800 (PST)
Message-ID: <096dabf7-3ae3-4739-86f5-d3c76a96432a@redhat.com>
Date: Tue, 2 Dec 2025 15:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 09/21] hw/arm/smmuv3: Plumb transaction attributes into
 config helpers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-10-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012150701.4127034-10-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/12/25 5:06 PM, Tao Tang wrote:
> As a preliminary step towards a multi-security-state configuration
> cache, introduce MemTxAttrs and AddressSpace * members to the
> SMMUTransCfg struct. The goal is to cache these attributes so that
> internal DMA calls (dma_memory_read/write) can use them directly.
>
> To facilitate this, hw/arm/arm-security.h is now included in
> smmu-common.h. This is a notable change, as it marks the first time
> these Arm CPU-specific security space definitions are used outside of
> cpu.h, making them more generally available for device models.
>
> The decode helpers (smmu_get_ste, smmu_get_cd, smmu_find_ste,
> smmuv3_get_config) are updated to use these new attributes for memory
> accesses. This ensures that reads of SMMU structures from memory, such
> as the Stream Table, use the correct security context.
>
> For now, the configuration cache lookup key remains unchanged and is
> still based solely on the SMMUDevice pointer. The new attributes are
> populated during a cache miss in smmuv3_get_config.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 19 ++++++++++++++++++
>  hw/arm/smmuv3.c              | 38 ++++++++++++++++++++++--------------
>  include/hw/arm/smmu-common.h |  6 ++++++
>  3 files changed, 48 insertions(+), 15 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 24db448683..82308f0e33 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,25 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
> +{
> +    switch (sec_sid) {
> +    case SMMU_SEC_SID_S:
> +        return ARMSS_Secure;
> +    case SMMU_SEC_SID_NS:
> +    default:
> +        return ARMSS_NonSecure;
> +    }
> +}
> +
> +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid)
> +{
> +    return (MemTxAttrs) {
> +        .secure = sec_sid > SMMU_SEC_SID_NS ? 1 : 0,
> +        .space = smmu_get_security_space(sec_sid),
> +    };
> +}
> +
>  /* Global state for secure address space availability */
>  bool arm_secure_as_available;
>  
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index a87ae36e8b..351bbf1ae9 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -333,14 +333,13 @@ static void smmuv3_init_regs(SMMUv3State *s)
>  }
>  
>  static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> -                        SMMUEventInfo *event)
> +                        SMMUEventInfo *event, SMMUTransCfg *cfg)
>  {
>      int ret, i;
>  
>      trace_smmuv3_get_ste(addr);
>      /* TODO: guarantee 64-bit single-copy atomicity */
> -    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf), cfg->txattrs);
>      if (ret != MEMTX_OK) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
> @@ -385,8 +384,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>      }
>  
>      /* TODO: guarantee 64-bit single-copy atomicity */
> -    ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(cfg->as, addr, buf, sizeof(*buf), cfg->txattrs);
>      if (ret != MEMTX_OK) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
> @@ -639,18 +637,19 @@ bad_ste:
>   * @sid: stream ID
>   * @ste: returned stream table entry
>   * @event: handle to an event info
> + * @cfg: translation configuration cache
>   *
>   * Supports linear and 2-level stream table
>   * Return 0 on success, -EINVAL otherwise
>   */
>  static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> -                         SMMUEventInfo *event)
> +                         SMMUEventInfo *event, SMMUTransCfg *cfg)
>  {
>      dma_addr_t addr, strtab_base;
>      uint32_t log2size;
>      int strtab_size_shift;
>      int ret;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> +    SMMUSecSID sec_sid = cfg->sec_sid;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>  
>      trace_smmuv3_find_ste(sid, bank->features, bank->sid_split);
> @@ -678,8 +677,8 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>          l2_ste_offset = sid & ((1 << bank->sid_split) - 1);
>          l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
>          /* TODO: guarantee 64-bit single-copy atomicity */
> -        ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
> -                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
> +        ret = dma_memory_read(cfg->as, l1ptr, &l1std, sizeof(l1std),
> +                              cfg->txattrs);
>          if (ret != MEMTX_OK) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
> @@ -721,7 +720,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>          addr = strtab_base + sid * sizeof(*ste);
>      }
>  
> -    if (smmu_get_ste(s, addr, ste, event)) {
> +    if (smmu_get_ste(s, addr, ste, event, cfg)) {
>          return -EINVAL;
>      }
>  
> @@ -850,7 +849,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>      /* ASID defaults to -1 (if s1 is not supported). */
>      cfg->asid = -1;
>  
> -    ret = smmu_find_ste(s, sid, &ste, event);
> +    ret = smmu_find_ste(s, sid, &ste, event, cfg);
>      if (ret) {
>          return ret;
>      }
> @@ -884,7 +883,8 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>   * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
>   * by the SMMUDevice handle.
>   */
> -static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
> +static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
> +                                       SMMUSecSID sec_sid)
>  {
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
> @@ -904,7 +904,15 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>                              100 * sdev->cfg_cache_hits /
>                              (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
>          cfg = g_new0(SMMUTransCfg, 1);
> -        cfg->sec_sid = SMMU_SEC_SID_NS;
> +        cfg->sec_sid = sec_sid;
> +        cfg->txattrs = smmu_get_txattrs(sec_sid);
> +        cfg->as = smmu_get_address_space(sec_sid);
> +        if (!cfg->as) {
> +            /* Can't get AddressSpace, free cfg and return. */
> +            g_free(cfg);
> +            cfg = NULL;
> +            return cfg;
don't you want to report an error in that case. Which type?
> +        }
>  
>          if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
>              g_hash_table_insert(bc->configs, sdev, cfg);
> @@ -1086,7 +1094,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto epilogue;
>      }
>  
> -    cfg = smmuv3_get_config(sdev, &event);
> +    cfg = smmuv3_get_config(sdev, &event, sec_sid);
>      if (!cfg) {
>          status = SMMU_TRANS_ERROR;
>          goto epilogue;
> @@ -1168,7 +1176,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>      SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>                                 .inval_ste_allowed = true};
> -    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
> +    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
>      IOMMUTLBEvent event;
>      uint8_t granule;
>  
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index d54558f94b..c17c7db6e5 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -22,6 +22,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/pci/pci.h"
>  #include "qom/object.h"
> +#include "hw/arm/arm-security.h"
>  
>  #define SMMU_PCI_BUS_MAX                    256
>  #define SMMU_PCI_DEVFN_MAX                  256
> @@ -47,6 +48,9 @@ typedef enum SMMUSecSID {
>      SMMU_SEC_SID_NUM,
>  } SMMUSecSID;
>  
> +MemTxAttrs smmu_get_txattrs(SMMUSecSID sec_sid);
> +ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid);
> +
>  extern AddressSpace __attribute__((weak)) arm_secure_address_space;
>  extern bool arm_secure_as_available;
>  void smmu_enable_secure_address_space(void);
> @@ -150,6 +154,8 @@ typedef struct SMMUTransCfg {
>      SMMUTransTableInfo tt[2];
>      /* Used by stage-2 only. */
>      struct SMMUS2Cfg s2cfg;
> +    MemTxAttrs txattrs;        /* cached transaction attributes */
> +    AddressSpace *as;          /* cached address space */
>  } SMMUTransCfg;
>  
>  typedef struct SMMUDevice {
Besides looks good to me

Eric


