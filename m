Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0390CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 11:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQOCb-0001tH-0M; Tue, 02 Dec 2025 06:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQOCY-0001rP-G1
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vQOCW-0002xu-3H
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764673542;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDlBVicT8IcRINwNs453/NqnuA5DJjUHTiKCrCsFqCE=;
 b=QrHhTVeIvoALX0KU7lb4jrU9K3ygTWW8TXzoAZ40ddvy8Sc6WJV8zGcXnkhXyHV6TcO8gy
 pjB4e5BpNkdm/IXJVvAdYX8+OPEuHHaWPlPrUlcv5GJyMKyslJPM+E4x8uEtG3yQW4HLu6
 DuKrq56kMCp7vIXYQtPi8dmcK82Mma0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-PpN5dyvbN76b6dcV6YYCKg-1; Tue, 02 Dec 2025 06:05:40 -0500
X-MC-Unique: PpN5dyvbN76b6dcV6YYCKg-1
X-Mimecast-MFC-AGG-ID: PpN5dyvbN76b6dcV6YYCKg_1764673540
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b29b4864b7so1190038185a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 03:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764673540; x=1765278340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDlBVicT8IcRINwNs453/NqnuA5DJjUHTiKCrCsFqCE=;
 b=gW/qcS8eGpLwXRNyfDmzg+mTifOlQ4bxppxPKJ+lMcV2SUkgfx7LLb4xQA1iXZUXg5
 MIp4ddRrzZYG2syPTt6nZw1XUZL4dBoNAkBIEjnCuhmhHovSVcDiFqbYfcTvD3aOGxqA
 Wf7YMWgzr5PHB9fgq97WvYPHWcQYrYJ6Gr0XFdeO8ocBApeMssF7y9E/JmR9lCvbZTd8
 bLBHro0m7iK4HKjtkxdpnpIe8CixbbrXUY442kGhpafleXr8nMOAqnUV8+U/KYEC2xmQ
 kkmgbUZ6jztrsAh3g8C4zLfKOiWM9VZScVjmf0swCBGW9bZgOjqRsmM+1ReS8Lrjcsiz
 27DA==
X-Gm-Message-State: AOJu0Yy+stIASYNcTa8vqwUrr+SAOpp4PmOOxRbxixRBYQI4glqFa4Bf
 o81oOx/TXYIsFKT9ZvRWK8vJp0wQ0deXXpFu4C9uXCMOjYLsperg++bsYXm0IwHWl6x5ek8SoHK
 47mRtyTswRu/XDQVxiZx++O5hPWdaFgEScPSWzoDtH7lagLmcfTxAoWp2
X-Gm-Gg: ASbGncsvv1bWwyIIIomd/FSxgONgR7iRd6QWpyQigC6x5S8C9jp8euKkXkFS2mI9wvE
 OO06vfDuQLKPCbGft5hNIpa9+DpnBX252Qqb7bNeyXdSymYYI5iDEJyPoyZtS4K+a+FcTW4HIka
 cJA36SEzkGgzhT55xeuC4rIcQPKnf76h4lTzCV/AYjDKWHhWZ80e61rLMmn7S9vNlw23nSCkCQy
 3rfeho7BYHSsLq18eGRnYt891ggtm9/7fSSpL5Cugq4f2Y7cJ0UjnR3w4dRpfU7DiA1esczZOEC
 oMj1UtX5FIu6UVzOqEjc2tEHoNz60aAmnj9PAZepJyQYrWmvLMwXjKq87qJcykE8RTdScKkhLbB
 QXcIJJlmv/DOfdV68k8KP95laUpx6n5iTk9jiIWbtSJchsHUgQA2Q6dENNg==
X-Received: by 2002:ad4:5caf:0:b0:882:4901:e959 with SMTP id
 6a1803df08f44-8863b076c00mr466343186d6.60.1764673540189; 
 Tue, 02 Dec 2025 03:05:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr+J0H8C6cfuEbB9V5yIckQXiifc4QaL24q+zxzYwx9NFoAhjH95+mTqxLN2RNBqLvHTo7dg==
X-Received: by 2002:ad4:5caf:0:b0:882:4901:e959 with SMTP id
 6a1803df08f44-8863b076c00mr466342536d6.60.1764673539753; 
 Tue, 02 Dec 2025 03:05:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e6088sm103014076d6.21.2025.12.02.03.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 03:05:39 -0800 (PST)
Message-ID: <8c9dc342-46ff-412b-aaf1-cdd34a079b4c@redhat.com>
Date: Tue, 2 Dec 2025 12:05:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 07/21] hw/arm/smmuv3: Track SEC_SID in configs and events
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
 <20251012150701.4127034-8-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012150701.4127034-8-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Cache the SEC_SID inside SMMUTransCfg to keep configuration lookups
> tied to the correct register bank.
>
> Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
> and event logs always show which security interface emitted the record.
> To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
> identified as soon as an event record is built.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3-internal.h     |  1 +
>  hw/arm/smmuv3.c              | 22 +++++++++++++++-------
>  hw/arm/trace-events          |  2 +-
>  include/hw/arm/smmu-common.h |  1 +
>  4 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index af0e0b32b3..99fdbcf3f5 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -512,6 +512,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
>  
>  /*  Encode an event record */
>  typedef struct SMMUEventInfo {
> +    SMMUSecSID sec_sid;
>      SMMUEventType type;
>      uint32_t sid;
>      bool recorded;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6d05bb1310..a87ae36e8b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -146,9 +146,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
>      return MEMTX_OK;
>  }
>  
> -static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
> +static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
> +                                       Evt *evt)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      SMMUQueue *q = &bank->eventq;
>      MemTxResult r;
> @@ -176,7 +176,10 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>  {
>      Evt evt = {};
>      MemTxResult r;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> +    SMMUSecSID sec_sid = info->sec_sid;
> +    if (sec_sid >= SMMU_SEC_SID_NUM) {
> +        g_assert_not_reached();
simply use g_assert(cond)
> +    }
>  
>      if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return;
> @@ -256,8 +259,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>          g_assert_not_reached();
>      }
>  
> -    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
> -    r = smmuv3_write_eventq(s, &evt);
> +    trace_smmuv3_record_event(sec_sid, smmu_event_string(info->type),
> +                              info->sid);
> +    r = smmuv3_write_eventq(s, sec_sid, &evt);
>      if (r != MEMTX_OK) {
>          smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
>      }
> @@ -900,6 +904,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>                              100 * sdev->cfg_cache_hits /
>                              (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
>          cfg = g_new0(SMMUTransCfg, 1);
> +        cfg->sec_sid = SMMU_SEC_SID_NS;
>  
>          if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
>              g_hash_table_insert(bc->configs, sdev, cfg);
> @@ -1057,7 +1062,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>                             .sid = sid,
> -                           .inval_ste_allowed = false};
> +                           .inval_ste_allowed = false,
> +                           .sec_sid = sec_sid};
>      SMMUTranslationStatus status;
>      SMMUTransCfg *cfg = NULL;
>      IOMMUTLBEntry entry = {
> @@ -1159,7 +1165,9 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>                                 uint64_t num_pages, int stage)
>  {
>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
> -    SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> +    SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
> +                               .inval_ste_allowed = true};
>      SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
>      IOMMUTLBEvent event;
>      uint8_t granule;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index f3386bd7ae..96ebd1b11b 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -40,7 +40,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>  smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>  smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
>  smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
> -smmuv3_record_event(const char *type, uint32_t sid) "%s sid=0x%x"
> +smmuv3_record_event(int sec_sid, const char *type, uint32_t sid) "sec_sid=%d %s sid=0x%x"
>  smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
>  smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
>  smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 2dd6cfa895..b0dae18a62 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -107,6 +107,7 @@ typedef struct SMMUS2Cfg {
>  typedef struct SMMUTransCfg {
>      /* Shared fields between stage-1 and stage-2. */
>      SMMUStage stage;           /* translation stage */
> +    SMMUSecSID sec_sid;        /* cached sec sid */
>      bool disabled;             /* smmu is disabled */
>      bool bypassed;             /* translation is bypassed */
>      bool aborted;              /* translation is aborted */
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric



