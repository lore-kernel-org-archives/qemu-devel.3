Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1D4C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6WW4-0001yR-8w; Mon, 13 May 2024 10:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WVf-0001Qk-GG
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:18:42 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6WVU-0000ES-VW
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:18:35 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so1123468566b.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715609903; x=1716214703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TQM590j3dctif6jajx67XHShxbVfw6YJRZD2H0Og3pY=;
 b=RD7ADhi05nMvR/wcHzYsIq4N5vTDyq3yQBVDm/j8Bms7ICSqpiuotJX6PvPkA8exiH
 kFr8S6akAfe0lMXX6rFgMIxqM72Q5p4sqnS2VRxaXt9SzreR4wpDkleuqwFjRlBeLN5Q
 PMY+1jwHomfe4APi6wrEkzKQ24CBUKFME7KKSPWtmQgYQ4FQXdkseN4J7QkW1aUaWY50
 15jCsapeJBp3vNv6WBR0uKkl8rcB0uu/x9T3xty2+k+VSuk6HYDf8PeF7eBkrrxCXXkr
 Oje/GWN2U3YuFOOfF4hVGWRhyVBbgXuXUqDlTYi9e7yN2oQuF/Aqlho1nyk1t5FHc2SP
 RP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715609903; x=1716214703;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TQM590j3dctif6jajx67XHShxbVfw6YJRZD2H0Og3pY=;
 b=LbpKCFjEA0d1CAWqj9ZqmFFo04+IE2Yo4644+M5YwThu3ibMzARH8alqWTQfhaeufz
 x21C8E3Pq3JOG/VH8UTzQ/j+tSVPNinTy3x2B8pLUZ2hRytbVi1aubCgnkdWtdBi/s//
 MmuEeffHTviqj6HkVFMoPKVFQoTZ+TK8OR1QGEW759moJJeMuACOKElGook71D9P6nbx
 Fv0XiOQp8wJl42w1/HOxPRoKJIzBR2a4dr3n+U0GJ0S+X108ZMuQD0TDAiMyYAkXR6hX
 xtnLGiGWQqhAtypWSmIPP2dcQxFktB3mbI9GHuU8Ro6t2gMG+NpH8L8umLygiQFKAXc6
 4rCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRJ9xZrqEAFuWkuHCj/JB++U3lWWbor+BgJXLCLu/3hzuAO/q+49tzTkRs1t9PmlYPtq6iWIs+pmTQ3Xm2vRaTpIKZG+U=
X-Gm-Message-State: AOJu0Yyp4pfUppcGvgtrDj/POeviZ8x82Meg1vfBeLox0UPNok1u+Uu1
 IR0KsI1vK/GAbYFklxw752Uu0io8chv1lURSs0nNe25udwCyBBChNmG8Cc/sVc2ZijaaJIX6sQU
 vh64=
X-Google-Smtp-Source: AGHT+IEiIM+ifZ4m6IMdqGGxFWY2O2N4wQZDUfWr/zsvnlo24HOXb9rPAbB0ly/+kamkEZH4LYtyAA==
X-Received: by 2002:a17:906:aeca:b0:a59:9af5:2c97 with SMTP id
 a640c23a62f3a-a5a2d5c8c6bmr690112266b.25.1715609902744; 
 Mon, 13 May 2024 07:18:22 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c81b4sm603036466b.113.2024.05.13.07.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:18:22 -0700 (PDT)
Message-ID: <b147d430-35d6-48af-8989-fa9e08bcecc4@linaro.org>
Date: Mon, 13 May 2024 16:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/33] plugins: Use DisasContextBase for
 qemu_plugin_insn_haddr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-14-richard.henderson@linaro.org>
Content-Language: en-US
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc'ing Pierrick & Alex on this last one :)

On 25/4/24 01:31, Richard Henderson wrote:
> We can delay the computation of haddr until the plugin
> actually requests it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/plugin.h  |  4 ----
>   accel/tcg/plugin-gen.c | 20 --------------------
>   plugins/api.c          | 25 ++++++++++++++++++++++++-
>   3 files changed, 24 insertions(+), 25 deletions(-)
> 
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 03081be543..3db0e75d16 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -98,7 +98,6 @@ struct qemu_plugin_dyn_cb {
>   /* Internal context for instrumenting an instruction */
>   struct qemu_plugin_insn {
>       uint64_t vaddr;
> -    void *haddr;
>       GArray *insn_cbs;
>       GArray *mem_cbs;
>       uint8_t len;
> @@ -119,9 +118,6 @@ struct qemu_plugin_tb {
>       GPtrArray *insns;
>       size_t n;
>       uint64_t vaddr;
> -    uint64_t vaddr2;
> -    void *haddr1;
> -    void *haddr2;
>   
>       /* if set, the TB calls helpers that might access guest memory */
>       bool mem_helper;
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index a4656859c6..b036773d3c 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -319,9 +319,6 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
>           ret = true;
>   
>           ptb->vaddr = db->pc_first;
> -        ptb->vaddr2 = -1;
> -        ptb->haddr1 = db->host_addr[0];
> -        ptb->haddr2 = NULL;
>           ptb->mem_helper = false;
>   
>           tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
> @@ -363,23 +360,6 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
>       pc = db->pc_next;
>       insn->vaddr = pc;
>   
> -    /*
> -     * Detect page crossing to get the new host address.
> -     * Note that we skip this when haddr1 == NULL, e.g. when we're
> -     * fetching instructions from a region not backed by RAM.
> -     */
> -    if (ptb->haddr1 == NULL) {
> -        insn->haddr = NULL;
> -    } else if (is_same_page(db, db->pc_next)) {
> -        insn->haddr = ptb->haddr1 + pc - ptb->vaddr;
> -    } else {
> -        if (ptb->vaddr2 == -1) {
> -            ptb->vaddr2 = TARGET_PAGE_ALIGN(db->pc_first);
> -            get_page_addr_code_hostp(cpu_env(cpu), ptb->vaddr2, &ptb->haddr2);
> -        }
> -        insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
> -    }
> -
>       tcg_gen_plugin_cb(PLUGIN_GEN_FROM_INSN);
>   }
>   
> diff --git a/plugins/api.c b/plugins/api.c
> index 39895a1cb1..4b6690c7d6 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -242,7 +242,30 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
>   
>   void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
>   {
> -    return insn->haddr;
> +    const DisasContextBase *db = tcg_ctx->plugin_db;
> +    vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
> +
> +    if (db->fake_insn) {
> +        return NULL;
> +    }
> +
> +    /*
> +     * ??? The return value is not intended for use of host memory,
> +     * but as a proxy for address space and physical address.
> +     * Thus we are only interested in the first byte and do not
> +     * care about spanning pages.
> +     */
> +    if (insn->vaddr <= page0_last) {
> +        if (db->host_addr[0] == NULL) {
> +            return NULL;
> +        }
> +        return db->host_addr[0] + insn->vaddr - db->pc_first;
> +    } else {
> +        if (db->host_addr[1] == NULL) {
> +            return NULL;
> +        }
> +        return db->host_addr[1] + insn->vaddr - (page0_last + 1);
> +    }
>   }
>   
>   char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)


