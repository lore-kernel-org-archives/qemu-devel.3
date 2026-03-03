Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BBAE67A8A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxKMv-0004W1-Aj; Tue, 03 Mar 2026 02:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxKMt-0004VH-Il
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxKMq-0004GZ-VY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772523631;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wGxRlD3+PVZaXZoy2n5crXWuNwlFbF+wvIK+s5he4Y=;
 b=JW4V1pbti44ujfW2CtgQC4m4Ht6lQFA9OzV2bopYKVQ5l0xFqAJSib9IqWf2c4WXwh3Sy5
 Qaf0ZP3lB5WyuUoJj+UyhaXrlAg3X8lyXWIPuhwY42gGkb7AJ5Gg8+4RhX5GmonTiADdH0
 aR0vzIht5xAkyxWpZKd1NN3Cw8z0vyg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-IeNDPF8oPAWQEoptSromrA-1; Tue, 03 Mar 2026 02:40:30 -0500
X-MC-Unique: IeNDPF8oPAWQEoptSromrA-1
X-Mimecast-MFC-AGG-ID: IeNDPF8oPAWQEoptSromrA_1772523629
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439b5511d5aso1508106f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 23:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772523629; x=1773128429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wGxRlD3+PVZaXZoy2n5crXWuNwlFbF+wvIK+s5he4Y=;
 b=Vb+/pJb6SdH2e+PF+tFtbbnuQIfuHeGIDqYY0zqB6viPUF1mgC/SMffSXLaxn2rquf
 IL3ZNCfF5fNoICrGlip0dTP+so07isvVu75vk4QnLzDgUdv8/Foe26Lw7eyFPfj/IsZp
 0OlfZyElGoxrQYrwK/sm1OO9DEChfkghP+IqcJIIQ8ny17Ds/f+K6iaQ3XokNrd817fz
 BAgJ0SjkCYAMIklOkwsKutxfCo1Owr3tR684REfesCS0uZp6uXj+thvOQ8/MxwYLeh37
 LB0f/7O3YhSOaxbIObZ/8JfogFM3WsLUoLFRwYgYKMa+dkoj0jvcRV13E32oejlCJj3Z
 j5eQ==
X-Gm-Message-State: AOJu0YyrcoRTyposU1cHrZNZhqT1tyGCxPpPaFz6m9J3qD5JDZ/kQs45
 8yQzdXM0yKDZwdMwTIEdlefbQKbfmGYtcqwZ1xbfXB7coUG0G4/dsG/55cI+VONpj+rgf3ld2iA
 UcXpp6z+MRQwjYkHuezBl9eS6CdslUlictm3t9r+GJf3siVMZhAZfCCDZ
X-Gm-Gg: ATEYQzxxgUiNqPGTa8ihfF4p3Jd53yWTCmpvVJ0ZzJCFYy5Kca5w1Lc/h/bbevaiWIb
 apd3JHYNg+CZ+fd8NVDWI8Th8x7jUAqivK84hiMsNUVBeFo387eeOVjU6+NZAFFGj8USI2zqqDW
 w8ackClvMzmLJSZeKemnTLruQsAlpF3MmPrv/MiVfSOeNshE84EVZjZx3I0t8koa3SX+/zbdvt9
 x2K6/CafARn1DvEVk7qZa9OkRCd3es8B5Wo6g/J2CEvkAwz/X49PlrsI5vooUHGBo8T2CBrNS6W
 OvmguhVFVTuo/Izby7nTDJBYzCjYdzyO9+rFgX9QV0wc5v34E8wXWbxxURMyLxlAN7AIF2V3ENZ
 HHV7r2ZmPw8+lnOHJtQQ8qsfpKa6/Ea66SK44/QOnC3XcuNCQO2otXaLhn2p8vlxs2JJbVg==
X-Received: by 2002:a05:6000:2c0a:b0:439:b6d6:71f with SMTP id
 ffacd0b85a97d-439b6d60ab4mr10547294f8f.52.1772523629113; 
 Mon, 02 Mar 2026 23:40:29 -0800 (PST)
X-Received: by 2002:a05:6000:2c0a:b0:439:b6d6:71f with SMTP id
 ffacd0b85a97d-439b6d60ab4mr10547228f8f.52.1772523628477; 
 Mon, 02 Mar 2026 23:40:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439abded86esm22512562f8f.6.2026.03.02.23.40.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 23:40:28 -0800 (PST)
Message-ID: <72026588-1db3-48a1-af99-e5e2aca69058@redhat.com>
Date: Tue, 3 Mar 2026 08:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 15/31] hw/arm/smmuv3: Tag IOTLB cache keys with SEC_SID
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101657.2994097-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221101657.2994097-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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



On 2/21/26 11:16 AM, Tao Tang wrote:
> To prevent aliasing between secure and non-secure translations for the
> same address space, the IOTLB lookup key must incorporate the security
> state of the transaction.
>
> This commit:
> - expands SMMUIOTLBKey with SEC_SID field for cache key differentiation
> - extends SMMUIOTLBPageInvInfo with SEC_SID for invalidation filtering
> - updates all IOTLB invalidation helpers (smmu_iotlb_inv_iova,
>   smmu_iotlb_inv_ipa, smmu_iotlb_inv_asid_vmid, smmu_iotlb_inv_vmid,
>   smmu_iotlb_inv_vmid_s1) to accept and filter by SEC_SID
> - plumbs SEC_SID through smmuv3_range_inval for TLB invalidation
> - enhances trace events to include SEC_SID for better debugging
>
> This ensures that secure and non-secure TLB entries are treated as
> distinct entities within the cache, preventing TLB pollution between
> different worlds.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmu-common.c         | 80 ++++++++++++++++++++++++------------
>  hw/arm/smmu-internal.h       |  2 +
>  hw/arm/smmuv3.c              | 36 ++++++++--------
>  hw/arm/trace-events          | 12 +++---
>  include/hw/arm/smmu-common.h | 16 +++++---
>  5 files changed, 92 insertions(+), 54 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 84e71df6767..bb43430cc3b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -95,7 +95,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
>  
>      /* Jenkins hash */
>      a = b = c = JHASH_INITVAL + sizeof(*key);
> -    a += key->asid + key->vmid + key->level + key->tg;
> +    a += key->asid + key->vmid + key->level + key->tg + key->sec_sid;
>      b += extract64(key->iova, 0, 32);
>      c += extract64(key->iova, 32, 32);
>  
> @@ -111,14 +111,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>  
>      return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
>             (k1->level == k2->level) && (k1->tg == k2->tg) &&
> -           (k1->vmid == k2->vmid);
> +           (k1->vmid == k2->vmid) && (k1->sec_sid == k2->sec_sid);
>  }
>  
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> -                                uint8_t tg, uint8_t level)
> +                                uint8_t tg, uint8_t level,
> +                                SMMUSecSID sec_sid)
>  {
>      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
> -                        .tg = tg, .level = level};
> +                        .tg = tg, .level = level, .sec_sid = sec_sid};
>  
>      return key;
>  }
> @@ -140,7 +141,7 @@ static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
>          SMMUIOTLBKey key;
>  
>          key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
> -                                 iova & ~mask, tg, level);
> +                                 iova & ~mask, tg, level, cfg->sec_sid);
>          entry = g_hash_table_lookup(bs->iotlb, &key);
>          if (entry) {
>              break;
> @@ -204,7 +205,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>      }
>  
>      *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> -                              tg, new->level);
> +                              tg, new->level, cfg->sec_sid);
>      trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
>                              tg, new->level);
Please update all tracepoints with the additional sec_sid. See also
trace_smmu_iotlb_lookup_hit/miss

One question, the spec says in "TLB tagging, VMIDs, ASIDs and
participation in boradcats TLB maintenance" that cached trasnlations are
tagged with 
"A translation regime, given by the STE’s StreamWorld and derived in
part from STE.STRW"

Can you confirm this matches our sec_sid?

Thanks

Eric
>      g_hash_table_insert(bs->iotlb, key, new);
> @@ -223,26 +224,29 @@ static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
>      return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
> -           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
> +           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
> +           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
>  }
>  
>  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>                                           gpointer user_data)
>  {
> -    int vmid = *(int *)user_data;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
> -    return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
> +    return (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
> +           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
>  }
>  
>  static gboolean smmu_hash_remove_by_vmid_s1(gpointer key, gpointer value,
>                                              gpointer user_data)
>  {
> -    int vmid = *(int *)user_data;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
> -    return (SMMU_IOTLB_VMID(*iotlb_key) == vmid) &&
> -           (SMMU_IOTLB_ASID(*iotlb_key) >= 0);
> +    return (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid) &&
> +           (SMMU_IOTLB_ASID(*iotlb_key) >= 0) &&
> +           (SMMU_IOTLB_SEC_SID(*iotlb_key) == info->sec_sid);
>  }
>  
>  static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
> @@ -259,6 +263,9 @@ static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
>      if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
>          return false;
>      }
> +    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
> +        return false;
> +    }
>      return ((info->iova & ~entry->addr_mask) == entry->iova) ||
>             ((entry->iova & ~info->mask) == info->iova);
>  }
> @@ -278,6 +285,9 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
>      if (info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
>          return false;
>      }
> +    if (info->sec_sid != SMMU_IOTLB_SEC_SID(iotlb_key)) {
> +        return false;
> +    }
>      return ((info->iova & ~entry->addr_mask) == entry->iova) ||
>             ((entry->iova & ~info->mask) == info->iova);
>  }
> @@ -323,13 +333,15 @@ void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
>  }
>  
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl)
> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> +                         SMMUSecSID sec_sid)
>  {
>      /* if tg is not set we use 4KB range invalidation */
>      uint8_t granule = tg ? tg * 2 + 10 : 12;
>  
>      if (ttl && (num_pages == 1) && (asid >= 0)) {
> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova,
> +                                              tg, ttl, sec_sid);
>  
>          if (g_hash_table_remove(s->iotlb, &key)) {
>              return;
> @@ -343,7 +355,8 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>      SMMUIOTLBPageInvInfo info = {
>          .asid = asid, .iova = iova,
>          .vmid = vmid,
> -        .mask = (num_pages * 1 << granule) - 1};
> +        .mask = (num_pages * 1 << granule) - 1,
> +        .sec_sid = sec_sid};
>  
>      g_hash_table_foreach_remove(s->iotlb,
>                                  smmu_hash_remove_by_asid_vmid_iova,
> @@ -355,13 +368,15 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>   * in Stage-1 invalidation ASID = -1, means don't care.
>   */
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> -                        uint64_t num_pages, uint8_t ttl)
> +                        uint64_t num_pages, uint8_t ttl,
> +                        SMMUSecSID sec_sid)
>  {
>      uint8_t granule = tg ? tg * 2 + 10 : 12;
>      int asid = -1;
>  
>     if (ttl && (num_pages == 1)) {
> -        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa, tg, ttl);
> +        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, ipa,
> +                                              tg, ttl, sec_sid);
>  
>          if (g_hash_table_remove(s->iotlb, &key)) {
>              return;
> @@ -371,34 +386,47 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>      SMMUIOTLBPageInvInfo info = {
>          .iova = ipa,
>          .vmid = vmid,
> -        .mask = (num_pages << granule) - 1};
> +        .mask = (num_pages << granule) - 1,
> +        .sec_sid = sec_sid};
>  
>      g_hash_table_foreach_remove(s->iotlb,
>                                  smmu_hash_remove_by_vmid_ipa,
>                                  &info);
>  }
>  
> -void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
> +                              SMMUSecSID sec_sid)
>  {
>      SMMUIOTLBPageInvInfo info = {
>          .asid = asid,
>          .vmid = vmid,
> +        .sec_sid = sec_sid,
>      };
>  
> -    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
> +    trace_smmu_iotlb_inv_asid_vmid(sec_sid, asid, vmid);
>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
>  }
>  
> -void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid)
>  {
> -    trace_smmu_iotlb_inv_vmid(vmid);
> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
> +    SMMUIOTLBPageInvInfo info = {
> +        .vmid = vmid,
> +        .sec_sid = sec_sid,
> +    };
> +
> +    trace_smmu_iotlb_inv_vmid(sec_sid, vmid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &info);
>  }
>  
> -void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid, SMMUSecSID sec_sid)
>  {
> -    trace_smmu_iotlb_inv_vmid_s1(vmid);
> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
> +    SMMUIOTLBPageInvInfo info = {
> +        .vmid = vmid,
> +        .sec_sid = sec_sid,
> +    };
> +
> +    trace_smmu_iotlb_inv_vmid_s1(sec_sid, vmid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &info);
>  }
>  
>  /* VMSAv8-64 Translation */
> diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
> index a0454f720da..5ddd0372d5b 100644
> --- a/hw/arm/smmu-internal.h
> +++ b/hw/arm/smmu-internal.h
> @@ -145,12 +145,14 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
>  
>  #define SMMU_IOTLB_ASID(key) ((key).asid)
>  #define SMMU_IOTLB_VMID(key) ((key).vmid)
> +#define SMMU_IOTLB_SEC_SID(key) ((key).sec_sid)
>  
>  typedef struct SMMUIOTLBPageInvInfo {
>      int asid;
>      int vmid;
>      uint64_t iova;
>      uint64_t mask;
> +    SMMUSecSID sec_sid;
>  } SMMUIOTLBPageInvInfo;
>  
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 504161ce06d..4a4de719a7c 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1279,7 +1279,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>      }
>  }
>  
> -static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
> +static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
> +                               SMMUSecSID sec_sid)
>  {
>      dma_addr_t end, addr = CMD_ADDR(cmd);
>      uint8_t type = CMD_TYPE(cmd);
> @@ -1304,12 +1305,13 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>      }
>  
>      if (!tg) {
> -        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
> +        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
> +                                 tg, 1, ttl, leaf, stage);
>          smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>          if (stage == SMMU_STAGE_1) {
> -            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
>          } else {
> -            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl);
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, 1, ttl, sec_sid);
>          }
>          return;
>      }
> @@ -1326,13 +1328,15 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
>          uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
>  
>          num_pages = (mask + 1) >> granule;
> -        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
> -                                 ttl, leaf, stage);
> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
> +        trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
> +                                 num_pages, ttl, leaf, stage);
> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
> +                                  num_pages, stage);
>          if (stage == SMMU_STAGE_1) {
> -            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
> +            smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
> +                                num_pages, ttl, sec_sid);
>          } else {
> -            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl);
> +            smmu_iotlb_inv_ipa(s, vmid, addr, tg, num_pages, ttl, sec_sid);
>          }
>          addr += mask + 1;
>      }
> @@ -1474,9 +1478,9 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>                  vmid = CMD_VMID(&cmd);
>              }
>  
> -            trace_smmuv3_cmdq_tlbi_nh_asid(asid);
> +            trace_smmuv3_cmdq_tlbi_nh_asid(sec_sid, asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
> +            smmu_iotlb_inv_asid_vmid(bs, asid, vmid, sec_sid);
>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
> @@ -1498,8 +1502,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               */
>              if (STAGE2_SUPPORTED(s)) {
>                  vmid = CMD_VMID(&cmd);
> -                trace_smmuv3_cmdq_tlbi_nh(vmid);
> -                smmu_iotlb_inv_vmid_s1(bs, vmid);
> +                trace_smmuv3_cmdq_tlbi_nh(sec_sid, vmid);
> +                smmu_iotlb_inv_vmid_s1(bs, vmid, sec_sid);
>                  break;
>              }
>              QEMU_FALLTHROUGH;
> @@ -1519,7 +1523,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, SMMU_SEC_SID_NS);
>              if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
> @@ -1536,7 +1540,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>  
>              trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_vmid(bs, vmid);
> +            smmu_iotlb_inv_vmid(bs, vmid, SMMU_SEC_SID_NS);
>              break;
>          }
>          case SMMU_CMD_TLBI_S2_IPA:
> @@ -1548,7 +1552,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               * As currently only either s1 or s2 are supported
>               * we can reuse same function for s2.
>               */
> -            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
> +            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, SMMU_SEC_SID_NS);
>              break;
>          case SMMU_CMD_ATC_INV:
>          {
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 9c2cc131ab4..4e360b3c0d3 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -18,9 +18,9 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
>  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
>  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> -smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
> -smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
> -smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
> +smmu_iotlb_inv_asid_vmid(int sec_sid, int asid, int vmid) "IOTLB invalidate sec_sid=%d asid=%d vmid=%d"
> +smmu_iotlb_inv_vmid(int sec_sid, int vmid) "IOTLB invalidate sec_sid=%d vmid=%d"
> +smmu_iotlb_inv_vmid_s1(int sec_sid, int vmid) "IOTLB invalidate S1 sec_sid=%d vmid=%d"
>  smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
>  smmu_configs_inv_sid_range(uint32_t start, uint32_t end) "Config cache INV SID range from 0x%x to 0x%x"
>  smmu_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> @@ -56,10 +56,10 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
>  smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
>  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
> -smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> -smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
> +smmuv3_range_inval(int sec_sid, int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "sec_sid=%d vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> +smmuv3_cmdq_tlbi_nh(int sec_sid, int vmid) "sec_sid=%d vmid=%d"
>  smmuv3_cmdq_tlbi_nsnh(void) ""
> -smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
> +smmuv3_cmdq_tlbi_nh_asid(int sec_sid, int asid) "sec_sid=%d asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index b0a02e12fe6..7d1d0936921 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -162,6 +162,7 @@ typedef struct SMMUIOTLBKey {
>      int vmid;
>      uint8_t tg;
>      uint8_t level;
> +    SMMUSecSID sec_sid;
>  } SMMUIOTLBKey;
>  
>  typedef struct SMMUConfigKey {
> @@ -256,16 +257,19 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>                                  SMMUTransTableInfo *tt, hwaddr iova);
>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> -                                uint8_t tg, uint8_t level);
> +                                uint8_t tg, uint8_t level, SMMUSecSID sec_sid);
>  SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_all(SMMUState *s);
> -void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
> -void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> -void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid,
> +                              SMMUSecSID sec_sid);
> +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid, SMMUSecSID sec_sid);
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
> -                         uint8_t tg, uint64_t num_pages, uint8_t ttl);
> +                         uint8_t tg, uint64_t num_pages, uint8_t ttl,
> +                         SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> -                        uint64_t num_pages, uint8_t ttl);
> +                        uint64_t num_pages, uint8_t ttl,
> +                        SMMUSecSID sec_sid);
>  void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
>  void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */


