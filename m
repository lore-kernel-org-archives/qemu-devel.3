Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0960DE9B37E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 16:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx6XM-0001j2-Ln; Mon, 02 Mar 2026 11:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6XK-0001ij-Nm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 11:54:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6XI-0004vb-SN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 11:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772470463;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLMDIEDZUbyVfEwyPH54dgchLAbl2qfz2wqS6nEjH1Y=;
 b=VLMItXyeXz9A3DVfaPb37os5tBr2Ht9xRF8mZN6QQznYNC647VOImGQBK0QKy2kLREdLFp
 OuM2z7gEANFSoQy5HC+2IvIwbR2rt84XI7xjIozhlmVez3579viHHnCzXPWeVUoF7I9P00
 BwrWrK/Go97ShOTgHENDHmrsBZCj1Jw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-1wnLAMo3MKCedwKbq4lwcA-1; Mon, 02 Mar 2026 11:54:22 -0500
X-MC-Unique: 1wnLAMo3MKCedwKbq4lwcA-1
X-Mimecast-MFC-AGG-ID: 1wnLAMo3MKCedwKbq4lwcA_1772470461
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b4e653d2so1140047f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 08:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772470461; x=1773075261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLMDIEDZUbyVfEwyPH54dgchLAbl2qfz2wqS6nEjH1Y=;
 b=VoGdtLsxZO3+9RLs4COmnOwggoJD/rmPXCe4nfjET0ezEGGLoOQmM+/5UFFoEVxrEM
 3SrxYqcy/zBF1EQfBfOf9VucEFbjV3Vqw9AT5E45AWdjrDMOs20vNfE0Ob8qaAMEItvH
 bj1dODdT87cCQBBXxi3E5eI+FHO61MCEEwt45j/IWtnWJRWDkU/bafHaohy7yPzV5NpP
 qQMV8HvI30P7iN5wNylgxY4V3zrBZpZMP08Kbw2Ka7Pi7oOwJL2LDhRWd+YsztHX46Cu
 2P7s8X9PXob9PM+v8f6ArY76zkpgH/2QFlBL7Pc+IdYn4dbwqyedYva19nuRDrPZEFc2
 Gffg==
X-Gm-Message-State: AOJu0YxbMj2h+Sc/QcQwFBzutNqoI2HvaR1ysv6cdUsBZ/xuE6HQkweB
 tFkwCR+2aDf24QSi1y+Zaklv5t5vtMMc2Jv4rDuIRjYuRoOZDRdUEBW50HR/1WD1BBLryqYpIEl
 6Wpym8g7teo6fCxWJww3T+0eaN3GJLsgcZtzQozuY/4zEJTiRRUvCpXOv
X-Gm-Gg: ATEYQzx/VA6fjaRBFJmWdCScONVpanV8TtY9XeYBNxbsHnuxtF+QTMJxb3AZJHhsJxN
 acbhtlcqYonduIwegzfnYBHJgIpoLsUVVOq4vitJrci0VqPxgLuQZtLCKli78XPxm20E8zuh/Qb
 4m3RSXlMITNaFX0RfPH8rVR3sUYz38gUlFPEkPOSqySPG3uAwf+T8yaz2Vf6NYX0sU13r7eCgQl
 OVGTqeN5bk53IiFeUqspbmGbx37lYjWHOZ1w4IqDucsJQP33SyINtZOQOEgUbqT89kFM/J6/bNu
 EAXRMleeIPa8x8dwGmuQ32fUuU3j7lXtrX0HkU3WpbFh5V9NHHfSzi5IhYABS+LAZctBZDDE77K
 oPJEsUlhPSs0s/jOmgl2/1qaaANgClOYAwvjjJQM/lzLEJ/+koREXKCc1DGA+OsH8M23cKw==
X-Received: by 2002:adf:f404:0:b0:439:a706:7dbb with SMTP id
 ffacd0b85a97d-439a7067e80mr11793671f8f.25.1772470460927; 
 Mon, 02 Mar 2026 08:54:20 -0800 (PST)
X-Received: by 2002:adf:f404:0:b0:439:a706:7dbb with SMTP id
 ffacd0b85a97d-439a7067e80mr11793629f8f.25.1772470460380; 
 Mon, 02 Mar 2026 08:54:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55df68dsm10209323f8f.26.2026.03.02.08.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 08:54:19 -0800 (PST)
Message-ID: <395c0640-c3bc-4f3e-9898-052fdbe68195@redhat.com>
Date: Mon, 2 Mar 2026 17:54:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 10/31] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
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
 <20260221101437.2990803-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221101437.2990803-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Tao,

On 2/21/26 11:14 AM, Tao Tang wrote:
> Adapt the configuration cache to support multiple security states by
> introducing a composite key, SMMUConfigKey. This key combines the
> SMMUDevice with SEC_SID, preventing aliasing between Secure and
> Non-secure configurations for the same device, also the future Realm and
> Root configurations.

Looking at 27/31, the sec_sid of a device looks rather static, set by a
property. However here you mention risk of aliasing between non secure
and secure for a given sdev

Please could you clarify?

Thanks

Eric
>
> The cache lookup, insertion, and invalidation mechanisms are updated
> to use this new keying infrastructure. This change is critical for
> ensuring correct translation when a device is active in more than one
> security world.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/a9a840a6-c65f-4352-9a49-ddd1b5483f43@redhat.com/
> ---
>  hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
>  hw/arm/smmuv3.c              | 13 +++++++----
>  include/hw/arm/smmu-common.h |  7 ++++++
>  3 files changed, 58 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index b320aec8c60..a732303b28b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -30,6 +30,26 @@
>  #include "hw/arm/smmu-common.h"
>  #include "smmu-internal.h"
>  
> +/* Configuration Cache Management */
> +static guint smmu_config_key_hash(gconstpointer key)
> +{
> +    const SMMUConfigKey *k = key;
> +    return g_direct_hash(k->sdev) ^ (guint)k->sec_sid;
> +}
> +
> +static gboolean smmu_config_key_equal(gconstpointer a, gconstpointer b)
> +{
> +    const SMMUConfigKey *ka = a;
> +    const SMMUConfigKey *kb = b;
> +    return ka->sdev == kb->sdev && ka->sec_sid == kb->sec_sid;
> +}
> +
> +SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid)
> +{
> +    SMMUConfigKey key = {.sdev = sdev, .sec_sid = sec_sid};
> +    return key;
> +}
> +
>  ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
>  {
>      switch (sec_sid) {
> @@ -265,7 +285,8 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
>  static gboolean
>  smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
>  {
> -    SMMUDevice *sdev = (SMMUDevice *)key;
> +    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
> +    SMMUDevice *sdev = config_key->sdev;
>      uint32_t sid = smmu_get_sid(sdev);
>      SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
>  
> @@ -283,6 +304,24 @@ void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
>                                  &sid_range);
>  }
>  
> +static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
> +    SMMUDevice *target = (SMMUDevice *)user_data;
> +
> +    if (config_key->sdev != target) {
> +        return false;
> +    }
> +    trace_smmu_config_cache_inv(smmu_get_sid(target));
> +    return true;
> +}
> +
> +void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
> +{
> +    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
> +}
> +
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl)
>  {
> @@ -978,7 +1017,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
> +    s->configs = g_hash_table_new_full(smmu_config_key_hash,
> +                                       smmu_config_key_equal,
> +                                       g_free, g_free);
>      s->iotlb = g_hash_table_new_full(smmu_iotlb_key_hash, smmu_iotlb_key_equal,
>                                       g_free, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index d011357253e..aa1a95a0093 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -904,10 +904,11 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>   *
>   * @sdev: SMMUDevice handle
>   * @event: output event info
> + * @sec_sid: StreamID Security state
>   *
>   * The configuration cache contains data resulting from both STE and CD
>   * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
> - * by the SMMUDevice handle.
> + * by a composite key of the SMMUDevice and the sec_sid.
>   */
>  static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>                                         SMMUSecSID sec_sid)
> @@ -915,8 +916,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
>      SMMUTransCfg *cfg;
> +    SMMUConfigKey lookup_key = smmu_get_config_key(sdev, sec_sid);
>  
> -    cfg = g_hash_table_lookup(bc->configs, sdev);
> +    cfg = g_hash_table_lookup(bc->configs, &lookup_key);
>      if (cfg) {
>          sdev->cfg_cache_hits++;
>          trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
> @@ -940,7 +942,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
>          g_assert(cfg->as && cfg->ns_as);
>  
>          if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
> -            g_hash_table_insert(bc->configs, sdev, cfg);
> +            SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
> +            *persistent_key = lookup_key;
> +            g_hash_table_insert(bc->configs, persistent_key, cfg);
>          } else {
>              g_free(cfg);
>              cfg = NULL;
> @@ -954,8 +958,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
>      SMMUv3State *s = sdev->smmu;
>      SMMUState *bc = &s->smmu_state;
>  
> -    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
> -    g_hash_table_remove(bc->configs, sdev);
> +    smmu_configs_inv_sdev(bc, sdev);
>  }
>  
>  /* Do translation with TLB lookup. */
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 7944e8d1b64..9e44c9f7710 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -162,6 +162,11 @@ typedef struct SMMUIOTLBKey {
>      uint8_t level;
>  } SMMUIOTLBKey;
>  
> +typedef struct SMMUConfigKey {
> +    SMMUDevice *sdev;
> +    SMMUSecSID sec_sid;
> +} SMMUConfigKey;
> +
>  typedef struct SMMUSIDRange {
>      uint32_t start;
>      uint32_t end;
> @@ -250,6 +255,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level);
> +SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
>  void smmu_iotlb_inv_all(SMMUState *s);
>  void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> @@ -259,6 +265,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>                          uint64_t num_pages, uint8_t ttl);
>  void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
> +void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
>  /* Unmap the range of all the notifiers registered to any IOMMU mr */
>  void smmu_inv_notifiers_all(SMMUState *s);
>  


