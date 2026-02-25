Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C0FFD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMB3-0003Js-OL; Wed, 25 Feb 2026 16:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMAv-0003Ix-Nw
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:12:08 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMAt-000818-RD
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:12:05 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2aaecf9c325so592985ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772053922; x=1772658722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dE2UOssavDaWeN/O3JXD0RA/MqDYfwMfAcQVcdKvAwk=;
 b=ljfxOp2ZXQfrt+cIocdkaP5c+DsMUxvE5eTs5l7MIa+Rjjb11iybktUfuIbrobYTnn
 MgMx8Bklm++5QVkXhXMYnE6btEK/TWoa1ZvyeaDtJv8fzzuICZpZbDqp/0huxSCvUlBF
 BxFK1VenZNUloMJl7UIpyaUoG+gf4dUxPANX+DT4yij6Fwy5RDmpoAUcXdSl83jCRJwU
 KMw6xGaNtt5+B58TaVevxxj+uyP4jRe0oEq/QxciBgqLivW5KqrLLZuBa51MS1yZa9cL
 US4A4kjYe8JQuGjr4WGxXNmE59KyKbYpvHAD4VonXNRSnsXEOJ12cCMgEGXxrQ58OBpU
 quzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053922; x=1772658722;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dE2UOssavDaWeN/O3JXD0RA/MqDYfwMfAcQVcdKvAwk=;
 b=wyk0QJ3w5851JY+Ar0MlU/WQDDNF/aBE7ycaZkT97s0GQRzvjKpD6uKdYbTjijUC7q
 8k7RNGxCPY2AE7RiTljC/BLSB34H6p2N62u5nE+VtIgaeAuIJ3ROzkLbbqdlR1OmEkNR
 n+27DsqdlfX4kc3boZIVIrw7meEjSRHtqHq2aOaei0LgYpdZpKIuXBywwp3LDoyP4dJS
 qQrCRK039vDuCjdxzZPSfwJYIRySxMQEgN+nffbHOljvAKWtZUiKz1YN2Pt5bxKM3GhM
 V46sl7oPnMliQoDlr9bbcNmx1CfOxeLrcLiITZcJDJ3IUuQggHu78vgln/y04HsAF4zX
 HiEg==
X-Gm-Message-State: AOJu0YwIBLkpGeTAYqfxCahHWkB7mMjfuu9GeMY4VcNYJdmcDaL65Cqr
 oGizVPTTBSetkv4VQd0uOFZMBsW4873bdmgvETlZlrNFvwZ3fEmBrGUu021klFPyjI4=
X-Gm-Gg: ATEYQzwLeY69q4HwGd/FYBKkIOHF5P/9cwbroIaFiOG+K5DCqPdK4tLTD0ckIspYy85
 7tJ24n+UqWO2zf/z4sYaKvjpdjr0FERhxzPIYxcF5ddIY8Bv/ti0nMZrwibCpTd9XP6c6e0gUhJ
 c9hYac1IBjdp9Xh05iZG34qrJWsDa9Gm5aWdZl3OlsH3HNemNCUTsf3cNMqfJfmY48Tt3gNAMhh
 cve+XKDJ7N+k7FbvXxiEzFC1SXAEWjgYPnRYu26sVshdpUDnscMnTKFLmSEaDtb3flpWKIf++pC
 TC5l9uV0iR/EwPAtGW2tCHgS2wJeesZqEYxiEyzTQ13qBEPZZTe25Opnh38ZoGwFcHtOZSZj+7Z
 IIl/FurLchmwoOl5HF9JaFEZIrgsrwFebTIG0c+aKj5hwhVXJIqj+V6k/eMHg06c2FYgKo9Fsr1
 gjKrS5XjlpgN4yAUIB2ndoYw88kLBu02LuNHDDcOHDkGRN5ULg6qN1T6HNXTlMCiuZEgVc
X-Received: by 2002:a17:903:2ecd:b0:2aa:f43d:7c4c with SMTP id
 d9443c01a7336-2adf78d7941mr3717695ad.9.1772053921957; 
 Wed, 25 Feb 2026 13:12:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6d1ba9sm1333105ad.76.2026.02.25.13.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:12:01 -0800 (PST)
Message-ID: <06a09b82-f63f-49d8-9997-69516cb768d6@linaro.org>
Date: Wed, 25 Feb 2026 13:12:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 14/31] hw/arm/smmu-common: Implement secure state
 handling in ptw
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
 <20260221101649.2993830-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101649.2993830-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x642.google.com
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

On 2/21/26 2:16 AM, Tao Tang wrote:
> Enhance the page table walker to correctly handle secure and non-secure
> memory accesses. This change introduces logic to select the appropriate
> address space and enforce architectural security policies during walks.
> 
> The page table walker now correctly processes Secure Stage 1
> translations. Key changes include:
> 
> - The get_pte function now uses the security context to fetch table
> entries from either the Secure or Non-secure address space.
> 
> - The stage 1 walker tracks the security state, respecting the NSCFG
> and NSTable attributes. It correctly handles the hierarchical security
> model: if a table descriptor in a secure walk has NSTable=1, all
> subsequent lookups for that walk are forced into the Non-secure space.
> This is a one-way transition, as specified by the architecture.
> 
> - The final TLB entry is tagged with the correct output address space,
> ensuring proper memory isolation.
> 
> Note: We do not yet support secure stage 2 translations. So ns_as member
> in SMMUTransCfg is used to cache non-secure AS instead of refactoring
> smmu_ptw_64_s2 to pass SMMUState context.
>

Does it requires so much refactor it's better to keep it as a field in 
cfg instead?

> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmu-common.c | 50 ++++++++++++++++++++++++++++++++++++++++----
>   hw/arm/smmuv3.c      |  1 +
>   2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index a732303b28b..84e71df6767 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -406,15 +406,16 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>   /**
>    * get_pte - Get the content of a page table entry located at
>    * @base_addr[@index]
> + * @as: AddressSpace to read from
>    */
>   static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
> -                   SMMUPTWEventInfo *info)
> +                   SMMUPTWEventInfo *info, AddressSpace *as, MemTxAttrs attrs)
>   {
>       int ret;
>       dma_addr_t addr = baseaddr + index * sizeof(*pte);
>   
>       /* TODO: guarantee 64-bit single-copy atomicity */
> -    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
> +    ret = ldq_le_dma(as, addr, pte, attrs);
>   
>       if (ret != MEMTX_OK) {
>           info->type = SMMU_PTW_ERR_WALK_EABT;
> @@ -538,6 +539,9 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>       SMMUStage stage = cfg->stage;
>       SMMUTransTableInfo *tt = select_tt(cfg, iova);
>       uint8_t level, granule_sz, inputsize, stride;
> +    int nscfg, current_ns, new_nstable;
> +    bool sid_is_ns = cfg->sec_sid == SMMU_SEC_SID_NS;
> +    bool forced_ns = false;  /* Once true, NSTable is ignored */
>   
>       if (!tt || tt->disabled) {
>           info->type = SMMU_PTW_ERR_TRANSLATION;
> @@ -552,6 +556,8 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>   
>       baseaddr = extract64(tt->ttb, 0, cfg->oas);
>       baseaddr &= ~indexmask;
> +    nscfg = tt->nscfg;
> +    forced_ns = sid_is_ns || nscfg;
>   
>       while (level < VMSA_LEVELS) {
>           uint64_t subpage_size = 1ULL << level_shift(level, granule_sz);
> @@ -560,8 +566,17 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>           uint64_t pte, gpa;
>           dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>           uint8_t ap;
> +        AddressSpace *pte_as;
> +        MemTxAttrs pte_attrs;
>   
> -        if (get_pte(baseaddr, offset, &pte, info)) {
> +        /*
> +         * Start in NS for Non-secure streams or CD.NSCFGx == 1.
> +         * Once walk is in NS, NSTable is ignored on subsequent levels.
> +         */
> +        current_ns = forced_ns || nscfg;
> +        pte_as = current_ns ? &bs->memory_as : &bs->secure_memory_as;
> +        pte_attrs = current_ns ? MEMTXATTRS_UNSPECIFIED : cfg->txattrs;
> +        if (get_pte(baseaddr, offset, &pte, info, pte_as, pte_attrs)) {
>                   goto error;
>           }
>           trace_smmu_ptw_level(stage, level, iova, subpage_size,
> @@ -586,6 +601,23 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>                       goto error;
>                   }
>               }
> +
> +            /*
> +             * NSTable can switch the walk to NS only while the current walk
> +             * level is Secure. Once switched to NS, NSTable is ignored according
> +             * to hierarchical control of Secure/Non-secure accesses:
> +             * (IHI 0070G.b)13.4.1 Stage 1 page permissions and
> +             * (DDI 0487H.a)D8.4.2 Control of Secure or Non-secure memory access
> +             */
> +            if (!forced_ns) {
> +                new_nstable = PTE_NSTABLE(pte);
> +                if (new_nstable) {
> +                    forced_ns = true;
> +                    nscfg = 1;
> +                } else {
> +                    nscfg = 0;
> +                }
> +            }
>               level++;
>               continue;
>           } else if (is_page_pte(pte, level)) {
> @@ -628,6 +660,13 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>               goto error;
>           }
>   
> +        if (current_ns) {
> +            tlbe->sec_sid = SMMU_SEC_SID_NS;
> +        } else {
> +            tlbe->sec_sid = PTE_NS(pte) ? SMMU_SEC_SID_NS : SMMU_SEC_SID_S;
> +        }
> +        tlbe->entry.target_as = (tlbe->sec_sid == SMMU_SEC_SID_S)
> +                                ? &bs->secure_memory_as : &bs->memory_as;

Having SMMUState passed there would allow to reuse smmu_get_address_space.

>           tlbe->entry.translated_addr = gpa;
>           tlbe->entry.iova = iova & ~mask;
>           tlbe->entry.addr_mask = mask;
> @@ -697,7 +736,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>           dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
>           uint8_t s2ap;
>   
> -        if (get_pte(baseaddr, offset, &pte, info)) {
> +        if (get_pte(baseaddr, offset, &pte, info, cfg->ns_as,
> +                    MEMTXATTRS_UNSPECIFIED)) {
>                   goto error;
>           }
>           trace_smmu_ptw_level(stage, level, ipa, subpage_size,
> @@ -750,6 +790,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>               goto error_ipa;
>           }
>   
> +        tlbe->sec_sid = SMMU_SEC_SID_NS;
> +        tlbe->entry.target_as = cfg->ns_as;
>           tlbe->entry.translated_addr = gpa;
>           tlbe->entry.iova = ipa & ~mask;
>           tlbe->entry.addr_mask = mask;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b8f2fae9a1d..504161ce06d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1147,6 +1147,7 @@ epilogue:
>       switch (status) {
>       case SMMU_TRANS_SUCCESS:
>           entry.perm = cached_entry->entry.perm;
> +        entry.target_as = cached_entry->entry.target_as;
>           entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>           entry.addr_mask = cached_entry->entry.addr_mask;
>           trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,

Overall looks good, and my remarks above are more suggestions than 
blocking comments.

