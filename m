Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43063FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMXs-0001WZ-OR; Wed, 25 Feb 2026 16:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMXr-0001WG-AW
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:35:47 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMXo-0003uQ-IZ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:35:47 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-82728e5680cso110182b3a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772055343; x=1772660143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hOzICRapbOplueK/4veAe4j39aue6V4txqHPlXgsH+U=;
 b=c87BUVP41Zl7rW6PcA6nf5wZHa2srAFXBMPIXzGqYXwEFcQbdwItwBatF8l6Vp8B6n
 BBbbcrPGWBHH/eCE53ossxFjOBE5lYaiW2pGf0XjeL+IB6eHMlwCPTx78DaKIurJZPJo
 aucWNqlNqP3USHHc9MBWyI8UOy7hf7DLkLIxfndX1V9TtCm+D1incFJQypGTx4j4NVd0
 RjliCvHbJVaKgDF5K1CuTl0U1YzZllv8/wijOxNVAZ9sZg7dhSKtRM+xPG3VRiHEdj9j
 ppqQz64nAqASpeK+3D1XYdSfLPH5Y10yatCgicoTUUHRfllNg29xU7rkmCYefRZLCZFM
 mznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772055343; x=1772660143;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOzICRapbOplueK/4veAe4j39aue6V4txqHPlXgsH+U=;
 b=U2JgdZGiHvllDB/cUtqdoccPLbb+jWXNpskRxu93KKMvq7J4HmQF6XTbGCobM0pbiE
 xNBU7gs/M8ttu3tOFG4stYt/uJJITdJgNMEDDa/vw+XEUnGYW6GsOKQhGJWPt7Hxz2wa
 WQu8muMnPJEtTemnfpYeyIcGWvWdE7ge0lPcNPRk1NFKnI90wBewOip2u1XjdnD5eGXh
 19zM4wWIdvsfxv9/8vty0JtLAi8v7WvOWVu10aJu87a9LSIDiRUEhkVNljB6Ab7h8JOH
 obT7iz1Kio0mqGmN8BFFwETOm/uut8s9GSVUBqZrykknX0Abs0n70vNuMWfdKqS5WOF3
 Cl8g==
X-Gm-Message-State: AOJu0YxLago1SndEJID1jki8vIqYS/dDkgmxXIlpw7/JXsTMQNFbCILs
 CZ/SrzaL4qDO3lcjaeHVr2Y4D6ayWuZ0uilLwJarA/8bBuf/JB3vV19ZCsfsDaNooHI=
X-Gm-Gg: ATEYQzyYDrICEMCbkagS7taqgYRpAqZjHwvJ5vJjZCKqB6KUXwm32CNNNzSv5jm4l4b
 Iermoyh0kepck2R0J+QL7IpjPwLz86/Pldmm9+lskK3v6hlnaUPvDGuDc3h9tnq9VJBOiuZH8c0
 uyEtJHDIIMeYImI/l21Tky/pPIBojnhGmuVkvs/WyVbIhBykI36cEkCJDIRAhqjWi01hyE/pFPu
 hCJKt/E6P4xmrGf0vUszKGoQuIEUqrEQsqoepyHswUwgUCHbsZAQkLRVzN3Y/Vmb1hlpY/ttrd3
 3wObs+W/qtIami/AKQ2bpEZcpVX7m/I3gpxWLvi/qC/yOD666mW7DhZnMdAlCva9w28PZfzepfe
 csqm6F5tA4509RNQhV+yjlByLwSQE7DjIBxomszvsDCg/HgvwxZ8azlBNSoeVz99gZe0/9lCw6J
 /BAeW8PxWdCwNVfQEKtlyc2Ki6B9dUmwljNkvLKkE81dElFFyVUfir4cP4ZNK9WAvlQwik
X-Received: by 2002:a05:6a00:a20d:b0:7f1:7b2a:ab5b with SMTP id
 d2e1a72fcca58-826da90aef0mr11087255b3a.27.1772055342762; 
 Wed, 25 Feb 2026 13:35:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d87e4csm215302b3a.15.2026.02.25.13.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:35:42 -0800 (PST)
Message-ID: <abd0c0ff-f454-40c2-afbf-1c90ec466329@linaro.org>
Date: Wed, 25 Feb 2026 13:35:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 17/31] hw/arm/smmuv3: Pass sec_sid into cmdq consume path
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101714.2994490-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101714.2994490-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/21/26 2:17 AM, Tao Tang wrote:
> Make smmuv3_cmdq_consume() security-state aware by passing sec_sid
> from smmu_writel() call sites (CR0/GERRORN/CMDQ_PROD paths), instead
> of hardcoding non-secure state. The related AddressSpace and MemTxAttrs
> are also obtained based on sec_sid.
> 
> Also move CMD_SSEC legality checking to a single early check before
> command dispatch: secure commands are rejected on non-secure queues
> (including future Realm queue) with CERROR_ILL. This removes duplicated
> per-command checks in CFGI handlers.
>

Sounds great!

> Finally, extend cmdq trace output with sec_sid so command processing
> can be correlated with the correct security bank.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c     | 50 ++++++++++++++++++++++-----------------------
>   hw/arm/trace-events |  2 +-
>   2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e33a7babd1c..b2559e80f24 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -111,14 +111,14 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>       trace_smmuv3_write_gerrorn(toggled & pending, bank->gerrorn);
>   }
>   
> -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
> +                                     AddressSpace *as, MemTxAttrs attrs)
>   {
>       dma_addr_t addr = Q_CONS_ENTRY(q);
>       MemTxResult ret;
>       int i;
>   
> -    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(as, addr, cmd, sizeof(Cmd), attrs);
>       if (ret != MEMTX_OK) {
>           return ret;
>       }
> @@ -1346,14 +1346,17 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>       }
>   }
>   
> -static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
> +static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp, SMMUSecSID sec_sid)
>   {
>       SMMUState *bs = ARM_SMMU(s);
>       SMMUCmdError cmd_error = SMMU_CERROR_NONE;
> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>       SMMUQueue *q = &bank->cmdq;
>       SMMUCommandType type = 0;
> +    MemTxAttrs attrs = smmu_get_txattrs(sec_sid);
> +    AddressSpace *as = smmu_get_address_space(bs, sec_sid);
> +    /* Secure AddressSpace must be available, assert if not. */
> +    g_assert(as);
>

This will be automatically be handled if we check in smmu_base_realize 
that secure smmu support should be available, as mentioned on one of the 
previous patch.

>       if (!smmuv3_cmdq_enabled(s, sec_sid)) {
>           return 0;
> @@ -1369,18 +1372,30 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>           uint32_t pending = bank->gerror ^ bank->gerrorn;
>           Cmd cmd;
>   
> -        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
> +        trace_smmuv3_cmdq_consume(sec_sid, Q_PROD(q), Q_CONS(q),
>                                     Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>   
>           if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>               break;
>           }
>   
> -        if (queue_read(q, &cmd) != MEMTX_OK) {
> +        if (queue_read(q, &cmd, as, attrs) != MEMTX_OK) {
>               cmd_error = SMMU_CERROR_ABT;
>               break;
>           }
>   
> +        /*
> +         * Secure Command on Non-secure Command queue, including Realm Command
> +         * queue, is not allowed. CERROR_ILL will be raised according to
> +         * (IHI 0070G.b) 4.1.6 Common command fields, Page 168.
> +         */
> +        if (CMD_SSEC(&cmd)) {
> +            if (sec_sid != SMMU_SEC_SID_S) {
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
> +        }
> +
>           type = CMD_TYPE(&cmd);
>   
>           trace_smmuv3_cmdq_opcode(smmu_cmd_string(type));
> @@ -1400,11 +1415,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               uint32_t sid = CMD_SID(&cmd);
>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>   
> -            if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> -            }
> -
>               if (!sdev) {
>                   break;
>               }
> @@ -1424,11 +1434,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               uint8_t range = CMD_STE_RANGE(&cmd);
>               SMMUSIDRange sid_range;
>   
> -            if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> -            }
> -
>               mask = (1ULL << (range + 1)) - 1;
>               sid_range.start = sid & ~mask;
>               sid_range.end = sid_range.start + mask;
> @@ -1447,11 +1452,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>               uint32_t sid = CMD_SID(&cmd);
>               SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>   
> -            if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> -            }
> -
>               if (!sdev) {
>                   break;
>               }
> @@ -1666,7 +1666,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>           bank->cr[0] = data;
>           bank->cr0ack = data & ~SMMU_CR0_RESERVED;
>           /* in case the command queue has been enabled */
> -        smmuv3_cmdq_consume(s, &local_err);
> +        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>           break;
>       case A_CR1:
>           bank->cr[1] = data;
> @@ -1683,7 +1683,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>            * By acknowledging the CMDQ_ERR, SW may notify cmds can
>            * be processed again
>            */
> -        smmuv3_cmdq_consume(s, &local_err);
> +        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>           break;
>       case A_GERROR_IRQ_CFG0: /* 64b */
>           bank->gerror_irq_cfg0 = deposit64(bank->gerror_irq_cfg0, 0, 32, data);
> @@ -1733,7 +1733,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>           break;
>       case A_CMDQ_PROD:
>           bank->cmdq.prod = data;
> -        smmuv3_cmdq_consume(s, &local_err);
> +        smmuv3_cmdq_consume(s, &local_err, reg_sec_sid);
>           break;
>       case A_CMDQ_CONS:
>           bank->cmdq.cons = data;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 4e360b3c0d3..ca8485c96af 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -35,7 +35,7 @@ smmuv3_trigger_irq(int irq) "irq=%d"
>   smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new GERROR=0x%x"
>   smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new GERRORN=0x%x"
>   smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
> -smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
> +smmuv3_cmdq_consume(int sec_sid, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "sec_sid=%d prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>   smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>   smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>   smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


