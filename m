Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F7FFEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvz09-0003wV-0F; Fri, 27 Feb 2026 09:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz04-0003sE-6v
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:39:28 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1vvz01-0006zf-BH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:39:27 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806b0963a9so72505e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772203163; x=1772807963; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V0KbNi2ejJzRRKYM6gfypxQI3IJ4KfiigCVnzXy8L10=;
 b=S6J+wxqs6Gojn/qlDai7S73SOba3AV8YeMQ4RWYOIO5vyrm8qsStkUXoGyKH+bpj6F
 0v/LjPPkjG8cSF12j1xWcRGAm3pYPh5coqCoffTsOEUh4T+GTZud45mqaxdKI8nwNGeV
 3R6QSTocKJdKhVozNxRqR5arDRdcFjFDNPY2xMMn+zN4nia+wD0QtqUcwKXRzqzUR3qN
 y8Hb5n60Ky/cf6HQfK2zbLmXufSIbipQXsikMl/xz9LN5BdampIgap3w62Kl2tPqU2Jg
 UsuOStpAlfO5Ccm6ew6h1K3e5WLXBu39NHVPyCnk2sEbZ3ta+DZzsmzBrXlOE0QNdzqh
 xgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772203163; x=1772807963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0KbNi2ejJzRRKYM6gfypxQI3IJ4KfiigCVnzXy8L10=;
 b=j7r6i4wxZFuQ53oERb0Ujatct+vG9j66DOm2zvr7pTmMN/OTP5RzPh4dM7szu2474E
 F8KzMuVROhM0LVvNRqBk550hDJRK97zFZBN53P0Oq6nSpsXZJEe9LZCOyNFT7NusdQFS
 Yut3HE/hT9U8OhLYEtMdJeGaxz+rwUJjK69iDabcFy3F1TB5WeF2rNawlHN378yppmW0
 371GY+J8pAJXDyalUNMo3g3aewCn90jp2Je1iGSu8c+3tsVFxYrSo64J1d5u134iSMg4
 J1Lul5c4jjJ1sLotMktkdfaJbi5Xnr4PUhS4QOj3hDCHoBhFo4GvCmtnpak2GLjVbMG3
 tpBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd5hnJXgBTVP3jzbhpd5MdpkDq2tubVnAFUJdQyhixKyL+fTyB+pqKi4K4uN9MNh2ZJrqMhcTQpJ6r@nongnu.org
X-Gm-Message-State: AOJu0Yxo7CjDZ4I72tsHchBzmqVbgMXsF54snGFGtnoZBeBeA2zL3P6J
 o26t8w1p+lxakLW41oYR0B2NyPbeV3mySefeVT2l1oE+ryl3Ey/Bh4Y1c1jpE9APVA==
X-Gm-Gg: ATEYQzznVXVVj1d8PqbRuG5yukan8Yb/Pe07QadNZV8hzwx8eUHT8R0zKosbsZuddTt
 eiG8INy9agklIC8sMpVjojKCjJh85PIwilepSvuuTqRf3/E/nKUvIswi21EJAO6UuEpW+zVxgsl
 pLzanQZxM/Z1ds/eWrOkMQM+2VzuZhpZ2UXEPhtdduhafk2gmpLLLQbXSpQgO5H0jA69hiIYo9s
 UETEn516zaT4mWYUxcTO/DFiNYDdVrXoVU4/lmG79lUDk1O81pzUCPWmaz796JpXvAF6M9DZ/yD
 xA1/OJT175VWyQshZlZKIhHmytFDwgouq+xHBkj4VTXMsCmZUI0TkQzdfRSMxGwihpie9lVheGk
 8qe99K94EmrNeHz57EPrvH7C78zdP6ZpJoRb+lFdin2R2N3IK3E+BZW0eY6yHwfboKiOoudhDTm
 q1jvqNEIyMFPeBN9f0ElOBbNP+ydAoHKu8+imE9GUPx3mCQYKY2v1/yGAaC7vIK9+c
X-Received: by 2002:a05:600c:1591:b0:483:6f85:b16e with SMTP id
 5b1f17b1804b1-483c39ce73cmr1555795e9.3.1772203162876; 
 Fri, 27 Feb 2026 06:39:22 -0800 (PST)
Received: from google.com (206.56.155.104.bc.googleusercontent.com.
 [104.155.56.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c76b250sm7673750f8f.34.2026.02.27.06.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:39:22 -0800 (PST)
Date: Fri, 27 Feb 2026 14:39:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [RFC v4 06/31] hw/arm/smmuv3: Track SEC_SID in configs and events
Message-ID: <aaGsltcRyTu7j1tU@google.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-7-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221100250.2976287-7-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=smostafa@google.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 21, 2026 at 06:02:25PM +0800, Tao Tang wrote:
> Cache the SEC_SID inside SMMUTransCfg to keep configuration lookups
> tied to the correct register bank.
> 
> Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
> and event logs always show which security interface emitted the record.
> To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
> identified as soon as an event record is built.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3-internal.h     |  1 +
>  hw/arm/smmuv3.c              | 20 +++++++++++++-------
>  hw/arm/trace-events          |  2 +-
>  include/hw/arm/smmu-common.h |  1 +
>  4 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 866d62257e3..a1071f7b689 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -274,6 +274,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
>  
>  /*  Encode an event record */
>  typedef struct SMMUEventInfo {
> +    SMMUSecSID sec_sid;
>      SMMUEventType type;
>      uint32_t sid;
>      bool recorded;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2c107724e77..3438adcecd2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -148,9 +148,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
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
> @@ -178,7 +178,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>  {
>      Evt evt = {};
>      MemTxResult r;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
> +    SMMUSecSID sec_sid = info->sec_sid;
> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);

What does this defend against?

Thanks,
Mostafa

>  
>      if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return;
> @@ -258,8 +259,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
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
> @@ -917,6 +919,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>                              100 * sdev->cfg_cache_hits /
>                              (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
>          cfg = g_new0(SMMUTransCfg, 1);
> +        cfg->sec_sid = SMMU_SEC_SID_NS;
>  
>          if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
>              g_hash_table_insert(bc->configs, sdev, cfg);
> @@ -1074,7 +1077,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>                             .sid = sid,
> -                           .inval_ste_allowed = false};
> +                           .inval_ste_allowed = false,
> +                           .sec_sid = sec_sid};
>      SMMUTranslationStatus status;
>      SMMUTransCfg *cfg = NULL;
>      IOMMUTLBEntry entry = {
> @@ -1176,7 +1180,9 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
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
> index 8135c0c7344..9c2cc131ab4 100644
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
> index 6ea40f6b074..ae1489717fe 100644
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
> -- 
> 2.34.1
> 

