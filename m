Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F137CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcmY-00031G-Rq; Fri, 21 Nov 2025 20:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vMbaU-0002EN-4N
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vMbaG-0005VA-Sj
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzFobMVJyhBRmur9FruIDbmEkqTBfCm6pgRHaFZ+3G0=;
 b=IZbvA9n9nAUedAD3SDb3bKbqxe6rMrygUE08MwRPtwG7/JDCqgs3ZpCBrSxe7KhGv+CMl2
 w7lxqkNx9U8uYUhlhGT0UYU24XVC5dXHyV/X8iGghSexbFJzVx18Gc8w2OypxFCxVm37Ky
 nhi7encZ6w5nLuYon++D8yD6owvRito=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597--fQbIDecOtSdifQdcIAg_w-1; Fri, 21 Nov 2025 08:13:59 -0500
X-MC-Unique: -fQbIDecOtSdifQdcIAg_w-1
X-Mimecast-MFC-AGG-ID: -fQbIDecOtSdifQdcIAg_w_1763730838
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a60a23adso13599775e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 05:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763730838; x=1764335638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzFobMVJyhBRmur9FruIDbmEkqTBfCm6pgRHaFZ+3G0=;
 b=kKUsjgJdAKdeyq3G5LBgbDIX/9F+KQKYv50VHDtxFUpKRWolgtFgJ5slTNI9AkWZ4v
 LF9OmjQkYisNSGyMNK1qj/lgeAGeCiBnl7j9NPF2nHNT6cH7QaEc6UJQx4lO6vKu2NTH
 aB/S3Og23POvQ5kv18zakRPrYT6IB4eyPt5GQgv6e2GYEkdVz+b8JiaSB7lZ9ICP4gyI
 o6NE1oocTWiGh3XMPpVnXAvpWmtQsgH1ShJJZ6BDEEoZ+O4gWihUJeudZlzVApmJe5PQ
 mrUAH3V6aASQM9fHcqPQsk1QHPsDBiMz1oWgoIAF69czJgbM6p5Pg+g+IGG9zzDu3G3f
 E7JA==
X-Gm-Message-State: AOJu0Yy/cTTNL/kGqpsK45PzvjHuFqnfCqtR2pdus5uvcOG/YFDtaLWe
 V7tX/YcGECTWDXJjjMXThGYgSU77paDH0GFcOqwiy19DmElkMXYoVHuZ82pTvF3fE7Ggh33+1mU
 b4srj5EVj5VplIwWGsKwtSxW71ldkUNs7fuPOqad/A0bkkZoAcsqxDPJ/
X-Gm-Gg: ASbGncuxrzykoEFU65Cg+GbhfzukLDWQ4SK9qPC0EFw6r5hg4p7iVplyNxEKZb1I0eB
 ia6u/fiNEX3j/Xmip7u9mjReEJ9O3MsVhTV1myWevDmQs19hzA90o01KcmA7vp1DXS3QHwlPuS9
 mt4+kSbcRwHszvK21B1rTwxnbaV9T1rkUYlourbLxq9XOkIyw3L5kcUyoJBL22YJjiRYED2KEiC
 8qDf6IoOVfglI99XPWcEzeFc35YcKFXPgRincl+lltQmZZ53fKm91hp80FmXRy8aBwBsRBYGulb
 YRAAMehT98o9xB7B89nrBHxUpM5ryrDYsZCsHGZF3T9E21JldgstZ/iwRnIL1/fxZvkpFmLmGOU
 Jd/f3LiVCD7eQuapR1mACwJCXQ3eeIxJG486zt2RAwCoqwFhBonYLLdS2gw==
X-Received: by 2002:a05:600c:3553:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-477c0170782mr21639465e9.8.1763730838132; 
 Fri, 21 Nov 2025 05:13:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR0aAO5to1fWMNaufn5kLIe/sQzUAYgZkQQBAhUpH8uGlxn0fHAFNU/j/19ByAepZdnHJiaA==
X-Received: by 2002:a05:600c:3553:b0:477:7a78:3016 with SMTP id
 5b1f17b1804b1-477c0170782mr21639245e9.8.1763730837710; 
 Fri, 21 Nov 2025 05:13:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477c0d85360sm33313175e9.15.2025.11.21.05.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 05:13:57 -0800 (PST)
Message-ID: <3097d58e-3793-4434-8beb-2e4f4c52f772@redhat.com>
Date: Fri, 21 Nov 2025 14:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 06/21] hw/arm/smmuv3: Thread SEC_SID through helper APIs
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
 <20251012150701.4127034-7-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012150701.4127034-7-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
> Extend the register and queue helper routines to accept an explicit
> SEC_SID argument instead of hard-coding the non-secure bank.
>
> All existing callers are updated to pass SMMU_SEC_SID_NS, so the
> behavior remains identical. This prepares the code for handling
> additional security state banks in the future. So Non-secure state
> is the only state bank supported for now.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-internal.h | 21 +++++++++------------
>  hw/arm/smmuv3.c          | 15 ++++++++-------
>  2 files changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 858bc206a2..af0e0b32b3 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -246,9 +246,8 @@ REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
>  REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
>  REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
>  
> -static inline int smmu_enabled(SMMUv3State *s)
> +static inline int smmu_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->cr[0], CR0, SMMUEN);
>  }
> @@ -276,16 +275,16 @@ static inline uint32_t smmuv3_idreg(int regoffset)
>      return smmuv3_ids[regoffset / 4];
>  }
>  
> -static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_eventq_irq_enabled(SMMUv3State *s,
> +                                             SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
>  }
>  
> -static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s,
> +                                             SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->irq_ctrl, IRQ_CTRL, GERROR_IRQEN);
>  }
> @@ -330,23 +329,21 @@ static inline void queue_cons_incr(SMMUQueue *q)
>      q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
>  }
>  
> -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->cr[0], CR0, CMDQEN);
>  }
>  
> -static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
> +static inline bool smmuv3_eventq_enabled(SMMUv3State *s, SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      return FIELD_EX32(bank->cr[0], CR0, EVENTQEN);
>  }
>  
> -static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
> +static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type,
> +                                       SMMUSecSID sec_sid)
>  {
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>      bank->cmdq.cons = FIELD_DP32(bank->cmdq.cons, CMDQ_CONS, ERR, err_type);
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9c085ac678..6d05bb1310 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -57,7 +57,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>  
>      switch (irq) {
>      case SMMU_IRQ_EVTQ:
> -        pulse = smmuv3_eventq_irq_enabled(s);
> +        pulse = smmuv3_eventq_irq_enabled(s, sec_sid);
>          break;
>      case SMMU_IRQ_PRIQ:
>          qemu_log_mask(LOG_UNIMP, "PRI not yet supported\n");
> @@ -77,7 +77,7 @@ static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>          bank->gerror ^= new_gerrors;
>          trace_smmuv3_write_gerror(new_gerrors, bank->gerror);
>  
> -        pulse = smmuv3_gerror_irq_enabled(s);
> +        pulse = smmuv3_gerror_irq_enabled(s, sec_sid);
>          break;
>      }
>      }
> @@ -153,7 +153,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>      SMMUQueue *q = &bank->eventq;
>      MemTxResult r;
>  
> -    if (!smmuv3_eventq_enabled(s)) {
> +    if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return MEMTX_ERROR;
>      }
>  
> @@ -176,8 +176,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>  {
>      Evt evt = {};
>      MemTxResult r;
> +    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>  
> -    if (!smmuv3_eventq_enabled(s)) {
> +    if (!smmuv3_eventq_enabled(s, sec_sid)) {
>          return;
>      }
>  
> @@ -1070,7 +1071,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>  
>      qemu_mutex_lock(&s->mutex);
>  
> -    if (!smmu_enabled(s)) {
> +    if (!smmu_enabled(s, sec_sid)) {
>          if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
>              status = SMMU_TRANS_ABORT;
>          } else {
> @@ -1300,7 +1301,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>      SMMUQueue *q = &bank->cmdq;
>      SMMUCommandType type = 0;
>  
> -    if (!smmuv3_cmdq_enabled(s)) {
> +    if (!smmuv3_cmdq_enabled(s, sec_sid)) {
>          return 0;
>      }
>      /*
> @@ -1513,7 +1514,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>  
>      if (cmd_error) {
>          trace_smmuv3_cmdq_consume_error(smmu_cmd_string(type), cmd_error);
> -        smmu_write_cmdq_err(s, cmd_error);
> +        smmu_write_cmdq_err(s, cmd_error, sec_sid);
>          smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
>      }
>  


