Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E59FC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 18:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6aEU-0003JM-FC; Mon, 13 May 2024 14:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s6aEC-0003IA-BI
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:16:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s6aE7-0008N0-K5
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:16:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ee42b97b32so37546005ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715624200; x=1716229000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IyfEN31ifLD4bI2m0rA2lacVq0HAqkLdbqYZAXv5wPk=;
 b=sMo1Td8Dq4N1WcnKWmNi3vLpM8Fv67ddfR8EGUycNOlGrU1Unsr5IHCz27dq+qRqY+
 2z23yH+mPYPSF4dXKLbbl/7ZVh8rTH8h69i77V4yZ2GTkMdo+Yzl3yEyiyZ6jLk4vxxc
 zedCHOsphyb6UYs848xFHiTUh+YK1g9rnV2h+KFq2NvFK1TaNDaBBQ2/gRspNSq0aRqX
 o6CEUtHs5gy/yXTun6WGIex3XTuC40QdWUQjk/fFOwRLNOsmv9XeiXgzqKTZKoJ9aRnN
 STUTX8dvtq+jDL2zGx4VEDUzscg8A4wKFsNGp8CCV4frvePZC18pf5fY4mrLt8VYjXHe
 IaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715624200; x=1716229000;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IyfEN31ifLD4bI2m0rA2lacVq0HAqkLdbqYZAXv5wPk=;
 b=wXbYi9zTOqBY3LWr/cjblQK5o+IAVXtOFQpxXKF+u3SCJ7kdb+KmfoMoMAyYphkmlM
 4iHyVlL5gy4FDE2TVv3Q9TV13IwxSi4wM5XJtOK0ufeErKqqOMoinTmBUpE2zyHZ5Zmc
 auBh2hdbPVfkqNXI/Oa8cTMFNb/3QEBpf69b0aGkapDf7gMUQTEwQ/Yza0eInou4Ma0G
 wMBReiWU8JRObj9iEAn+WHVQc0jqNjt/hRNkvKOEatAZEm7R0owVZW/5s+piY4NG0EOe
 0UIeTkOJAP2lYtFjAiaXc2G3yhRi8rVvO3/r4mz+gQmZ/ZZbEpYJITeg4RXwRupIxyA1
 mpzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9L6g+mT5ep5xe4KX7Kv6OuzfPn89zQWK9rmLSEJ9i6uTl+Q2iDughuk0p9mU4R33Faea/eKLlSwEjqPS1hcrXdKX0DKU=
X-Gm-Message-State: AOJu0Yx8p2txIVAqNI8KtFKltEiHc7Oe7Iv0isWsc/yHztjrWlAc5KiF
 8ITAnv6fAheEmqwuFCJxS4+eSdkrVoHj9ZL08+CSF4TYEE2XURHeg+a1pchkgG4=
X-Google-Smtp-Source: AGHT+IHXyzOyt7cr+cnMnVrfqbL2wVBUV6i9msSvZVWsY3ScM1D/w7oVtwKvH1KOlbehhgG21EUNrg==
X-Received: by 2002:a17:903:22c1:b0:1ee:b490:2855 with SMTP id
 d9443c01a7336-1ef43d18600mr144093885ad.25.1715624199999; 
 Mon, 13 May 2024 11:16:39 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::ecd0? ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31229sm82085515ad.138.2024.05.13.11.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 11:16:39 -0700 (PDT)
Message-ID: <93475b5b-10ee-4d7a-9736-c838143bc8e4@linaro.org>
Date: Mon, 13 May 2024 11:16:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/33] plugins: Use DisasContextBase for
 qemu_plugin_insn_haddr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240424233131.988727-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/24/24 16:31, Richard Henderson wrote:
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

