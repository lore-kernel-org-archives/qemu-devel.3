Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A533C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 03:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYHVa-0008SZ-F3; Sun, 28 Jul 2024 23:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYHVX-0008Qg-Uo
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:57:11 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYHVV-0004nH-QH
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 23:57:11 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so652424a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 20:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722225428; x=1722830228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P/+MCnl6h55pbqx+x5H5fRPOTZ2yJHCToPyc1fDBrXo=;
 b=rwh5L8hkQkGf0mlWxtwuQAhlfNnWvCcuhu/KzofHGj5EqBCEcRVqPJOJMMnkfSIF8c
 eEpWBYYkt5xQDsd4DntASrXYICAR5AS7DDMLtYKB0u2G7YHGhBs+Oi/H9lNOMCgkaWw6
 FnqQZQfX8ChVcifpbojIU6+um428B8IGdgxPJtah1m9POQma2C692emd1M885gsVAxn3
 8gx/cH81358EX9P10voIuoUekkcJlKJCLPBYcVrbR4XmhacQY0j04gKoG1VTOeU1jZ6A
 4x7MwslpyCevzBFBQgwVJMziLdiPsfj22N/t+aFYYJSl1/3zhqH3CTG3XBIZi/P60jB7
 v7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722225428; x=1722830228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P/+MCnl6h55pbqx+x5H5fRPOTZ2yJHCToPyc1fDBrXo=;
 b=h0BcZ1/qlLGUqNThiaO1U692jQLYA/G+AyWQerbOrIm+Ftzy+I+8El/ryhh5WIJFAK
 F6/51jREWzdE4TooE5KzfbsqGYIuuNCAjp7JElmAkLy0X763iMNnRURmMmfi6S7bq/Fc
 5TXlcCQEMM5WTpUemg7s1HPPomLpiON0Dr5Cn+TSn+HVX2FOZqtJ+fCvDswH15TJ9yx4
 rJuDWCX2KcdYl9vSB0DXgnK6csSFcNENFFqKpcEbfcRt+r2HLA+S2AwXjGNTISx1pFo2
 3i9SHUhh7KP8X/j9hYsL35Bg/WOz+WxMTh5dDm9r04Ju751Dvq7aRZONo9Lj0LF3BVbw
 50Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtMsiYB7Y6KBxLM7sHTPW9yuLWsqPEk9axwwVENA0m0oTovzoGgIwsGDhUwNBuBRqaCbjveQdc0qIqo5jeyhW8+X8QA8E=
X-Gm-Message-State: AOJu0YxOYeLe3Ugt5kZUTftKpO6CPLPem/84K/QCkiRKnb6EWray1G5D
 dJrdCSiwATpMfNT+tWd9A0UFpbEql7Bxel+t/kMTLQIHoYTPUJuR+r0HujX6ICs=
X-Google-Smtp-Source: AGHT+IF1rIy3lgHi0cqKNCeFXCz/pivBudH2Q8V+AYPXBuRJPhb6O1unumfy9xSUzRP28Z7Vp90uUA==
X-Received: by 2002:a05:6a20:734f:b0:1be:c4bb:6f31 with SMTP id
 adf61e73a8af0-1c4a12a8082mr8458446637.18.1722225427700; 
 Sun, 28 Jul 2024 20:57:07 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee4e79sm71824555ad.138.2024.07.28.20.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jul 2024 20:57:07 -0700 (PDT)
Message-ID: <87ca1589-089a-4ebb-90dd-21780897da98@linaro.org>
Date: Mon, 29 Jul 2024 13:57:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/loongarch/tcg: Add hardware page table walker
 support
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org
References: <20240729013939.1807982-1-gaosong@loongson.cn>
 <20240729013939.1807982-6-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729013939.1807982-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 7/29/24 11:39, Song Gao wrote:
>       /* Mapped address */
> -    return loongarch_map_address(env, physical, prot, address,
> -                                 access_type, mmu_idx);
> +    ret = loongarch_map_address(env, physical, prot, address,
> +                                access_type, mmu_idx);
> +#ifdef CONFIG_TCG
> +    if (!FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW)) {
> +        return ret;
> +    }
> +
> +    if (!FIELD_EX32(env->CSR_PWCH, CSR_PWCH, HPTW_EN)) {
> +        return ret;
> +    }
> +
> +    if (do_page_walk(env, address, access_type, ret)) {

When called from loongarch_cpu_get_phys_page_debug, you do not want ...

> +        index = get_random_tlb_index(env, tlbehi, ps);
> +        invalidate_tlb(env, index);
> +        do_fill_tlb_entry(env, vppn, entrylo0, entrylo1, index, ps);

... to modify the TLB.  This will cause gdbstub to modify the behaviour of the guest, 
which you do not want.

> +        entry = ldq_phys(cs->as, tmp0) & TARGET_PHYS_MASK;
> +
> +        if (entry == 0) {
> +            return ret;
> +        }
> +
> +        /* Check entry, and do tlb modify. */
> +        if ((tlb_error == TLBRET_INVALID) &&
> +            (access_type == MMU_DATA_LOAD ||
> +             access_type == MMU_INST_FETCH )) {
> +            if (!(FIELD_EX64(entry, TLBENTRY, PRESENT))) {
> +                break;
> +            }
> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
> +        } else if ((tlb_error == TLBRET_INVALID) &&
> +                   access_type == MMU_DATA_STORE) {
> +            if (!((FIELD_EX64(entry, TLBENTRY, PRESENT) &&
> +                  (FIELD_EX64(entry, TLBENTRY, WRITE))))){
> +                break;
> +            }
> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
> +            entry = FIELD_DP64(entry, TLBENTRY, D, 1);
> +        } else if (tlb_error ==  TLBRET_DIRTY) {
> +            if (!(FIELD_EX64(entry, TLBENTRY, WRITE))) {
> +                break;
> +            }
> +            entry = FIELD_DP64(entry, TLBENTRY, D, 1);
> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
> +        }
> +        stq_phys(cs->as, tmp0, entry);

You certainly want to use a compare and swap here, restarting if the compare fails.


r~

