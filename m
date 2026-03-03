Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F165CE67A8F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 07:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxK91-0002SO-UM; Tue, 03 Mar 2026 02:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxK90-0002S0-9Y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:26:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxK8y-0002Z5-GM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 02:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772522771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vAotZgq8kUYS63eBht0WFqtOWiOtkdXwT12b4eKQIhE=;
 b=BTsUQsUlmN3+6DBeZkeNodFPsv9iNInYHGCSbtNQNu5VASgin8K5W0wez6eWaorP04Iuo5
 cT76T4jxC6MBJ2d2+S+oiEVVTZHuz+UpQiQQDGCW/YEe3wY1NQNp1DKY/vM2CiR4Jp8Hg0
 9+mFBdVcemftrORuyBZsfKP/wrfJLwk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-1yz5QrttMIi0-X0hJet4xw-1; Tue, 03 Mar 2026 02:26:09 -0500
X-MC-Unique: 1yz5QrttMIi0-X0hJet4xw-1
X-Mimecast-MFC-AGG-ID: 1yz5QrttMIi0-X0hJet4xw_1772522769
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48372facfedso45385295e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 23:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772522768; x=1773127568;
 h=content-transfer-encoding:in-reply-to:references:reply-to:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAotZgq8kUYS63eBht0WFqtOWiOtkdXwT12b4eKQIhE=;
 b=AAUw/vqDizrYac+NlheQugkPYaUTgobR3gzovllYOgVOkotikPNgqJiCFU4JlwSmlA
 yxnmcSu0tDJfPTt8Dkr6NrYVlBB/ATpzNoxKcCH52QVT4ognelyHZD/SsfBGotZTZcwG
 FPj1vFdZPADMSVFie8LImA1x6GFGS9ja7tJMRFc4uVwYatK7LYmZWKnhEMlyE3Q2860K
 /yXdEk2lCer7Z/+s3wjeoKdQDejGcK8lrm1Q2d9hfSahsbzlwUk0FNDtvMRp1YvmAWmv
 4U8dIDQgNrH1tcjAJIClMhwaBZmFG7SSTql82mqD0e/TdjCZYQJR50D47OVZJy/GJJDq
 z3xw==
X-Gm-Message-State: AOJu0YxEbloVyNgMPeLZTX05u5PMYTEw1C1kKAAUGTuu92rYJucbYFkp
 VYxKv7g2T8WJuDUD2WQLGxmnorSoqy/maBnTrcJQBuPcozRAACYxg/0fdZyJcsW1W8JP15/vySq
 aGyx9hj/0Y5mrg+Oidu4Z0xX+c1UHWX/bfyiPsMKDkdYLfcEIfRRmH/ije3TZ5gvD
X-Gm-Gg: ATEYQzw6eJidYameyq0YsuHgN6gnKsK8EB6PTFwaAOdKuFfISaDMQhTikXEU2WG1d9U
 fR7blbjtG2szBOKiJYcAcOcIQnk5j2SxTNxK4U6lbhcZWAcWpCNvm0BY+tDVmPp4VvBBKI9O0V5
 LdB6+/ip7z1/01+JbmYsdzRGK8ja2PBxvOKXJqaGF/kOtW66V8lRH3k2e70iiLxNbSSBQuXfspt
 4zzJPz7GEMLI2YyiS9mcT/frWCkApnp04F29iwTVoRbz7TF2kF0FSMXJynUKDLBAITwpyEy70IE
 AgVyz5NJiOOTUT2QSZcluQaT+xykBwYp/0aX5Z+OlYuUzJQX+owH+j7/AEKaqwbN8fFUbU9Wo5a
 5M631bPJ/5vivoYRI1NHWri3Kdqid0tRM5QWm1YrZ7NpSlxu3hyXrSrj3I6qMecKpVhzecw==
X-Received: by 2002:a05:600c:444f:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-48513a56293mr16452005e9.4.1772522768359; 
 Mon, 02 Mar 2026 23:26:08 -0800 (PST)
X-Received: by 2002:a05:600c:444f:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-48513a56293mr16451565e9.4.1772522767835; 
 Mon, 02 Mar 2026 23:26:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485135b5db1sm8800075e9.20.2026.03.02.23.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 23:26:07 -0800 (PST)
Message-ID: <436d5125-1118-48ba-a935-a7879daadd25@redhat.com>
Date: Tue, 3 Mar 2026 08:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 06/31] hw/arm/smmuv3: Track SEC_SID in configs and events
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
 <20260221100250.2976287-7-tangtao1634@phytium.com.cn>
 <ab60bb69-e3d9-461d-a353-e5dc2161d644@redhat.com>
In-Reply-To: <ab60bb69-e3d9-461d-a353-e5dc2161d644@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Reply-to:  eric.auger@redhat.com
X-ACL-Warn: ,  Eric Auger <eric.auger@redhat.com>
From:  Eric Auger via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/2/26 5:13 PM, Eric Auger wrote:
> Hi Tao,
> 
> On 2/21/26 11:02 AM, Tao Tang wrote:
>> Cache the SEC_SID inside SMMUTransCfg to keep configuration lookups
>> tied to the correct register bank.
>>
>> Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
>> and event logs always show which security interface emitted the record.
>> To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
>> identified as soon as an event record is built.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3-internal.h     |  1 +
>>  hw/arm/smmuv3.c              | 20 +++++++++++++-------
>>  hw/arm/trace-events          |  2 +-
>>  include/hw/arm/smmu-common.h |  1 +
>>  4 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 866d62257e3..a1071f7b689 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -274,6 +274,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
>>  
>>  /*  Encode an event record */
>>  typedef struct SMMUEventInfo {
>> +    SMMUSecSID sec_sid;
>>      SMMUEventType type;
>>      uint32_t sid;
>>      bool recorded;
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 2c107724e77..3438adcecd2 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -148,9 +148,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
>>      return MEMTX_OK;
>>  }
>>  
>> -static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>> +static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>> +                                       Evt *evt)
>>  {
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>      SMMUQueue *q = &bank->eventq;
>>      MemTxResult r;
>> @@ -178,7 +178,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>  {
>>      Evt evt = {};
>>      MemTxResult r;
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>> +    SMMUSecSID sec_sid = info->sec_sid;
>> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
>>  
>>      if (!smmuv3_eventq_enabled(s, sec_sid)) {
>>          return;
>> @@ -258,8 +259,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>          g_assert_not_reached();
>>      }
>>  
>> -    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
>> -    r = smmuv3_write_eventq(s, &evt);
>> +    trace_smmuv3_record_event(sec_sid, smmu_event_string(info->type),
>> +                              info->sid);
>> +    r = smmuv3_write_eventq(s, sec_sid, &evt);
>>      if (r != MEMTX_OK) {
>>          smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
>>      }
>> @@ -917,6 +919,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
>>                              100 * sdev->cfg_cache_hits /
>>                              (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
>>          cfg = g_new0(SMMUTransCfg, 1);
>> +        cfg->sec_sid = SMMU_SEC_SID_NS;
>>  
>>          if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
>>              g_hash_table_insert(bc->configs, sdev, cfg);
>> @@ -1074,7 +1077,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>      SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>>                             .sid = sid,
>> -                           .inval_ste_allowed = false};
>> +                           .inval_ste_allowed = false,
>> +                           .sec_sid = sec_sid};
>>      SMMUTranslationStatus status;
>>      SMMUTransCfg *cfg = NULL;
>>      IOMMUTLBEntry entry = {
>> @@ -1176,7 +1180,9 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>                                 uint64_t num_pages, int stage)
>>  {
>>      SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>> -    SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
>> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>> +    SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>> +                               .inval_ste_allowed = true};
>>      SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
>>      IOMMUTLBEvent event;
>>      uint8_t granule;
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index 8135c0c7344..9c2cc131ab4 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -40,7 +40,7 @@ smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>>  smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>>  smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
>>  smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
>> -smmuv3_record_event(const char *type, uint32_t sid) "%s sid=0x%x"
>> +smmuv3_record_event(int sec_sid, const char *type, uint32_t sid) "sec_sid=%d %s sid=0x%x"
>>  smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
>>  smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
>>  smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 6ea40f6b074..ae1489717fe 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -107,6 +107,7 @@ typedef struct SMMUS2Cfg {
>>  typedef struct SMMUTransCfg {
>>      /* Shared fields between stage-1 and stage-2. */
>>      SMMUStage stage;           /* translation stage */
>> +    SMMUSecSID sec_sid;        /* cached sec sid */
> I am now wondering if sec_sid shall be part of the TransCfg as this is
> never decoded from STE/CD, sin't it.

Having slept over it, caching sed_id here indicates whether the secure
stream table was used for decoding. So that can be considered as a
result of the config decode process.

a minor comment though, I think I would prefer having cfg->sec_sid
populated in smmuv3_decode_config as the other cfg fields. Meaning I
would rather add sed_sid to smmuv3_decode_config signature.

Thanks

Eric

> 
> Eric
>>      bool disabled;             /* smmu is disabled */
>>      bool bypassed;             /* translation is bypassed */
>>      bool aborted;              /* translation is aborted */
> 


