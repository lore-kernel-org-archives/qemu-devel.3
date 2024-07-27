Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D7C3DA61
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 07:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXbcU-0001GN-4q; Sat, 27 Jul 2024 03:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXbcS-0001EY-OC
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 03:13:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXbcR-0000Bb-2x
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 03:13:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so11048265ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2024 00:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722064408; x=1722669208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIhjJ4c0xYrUtdWdkw4bZlNJNbpikzNAqEFfGumYL5Y=;
 b=NRyPyo0691cnhEGsJx0j49fL+45ZwQE191Z9kxLjZ35Qq5sHgV+rjoeait0yK6G4EG
 guQFiRAj6nnYq0cqhWfnVgGQAyAt/loA3sstj+jn5/oFDsEwgwMQe6f4Ow9grHSc5xMz
 h5mher0eXlrm2kKcztW6XbgeV+/cjc09PXB+TkoVQGSlKncX6BihLpKiVTLig2AfBlCP
 U0nNLj0f/BobApSPYurb8i7z7aXbty9qp3gX1hCsJVFdXxmnNLXqiHD5yiP+gNHskHE2
 /vr77n1SIKwwwcjG6oklnHlIO2ta4EBFhD5TwwVArznHeC4PExT02eOH/s6mzbhk1ADI
 PWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064408; x=1722669208;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIhjJ4c0xYrUtdWdkw4bZlNJNbpikzNAqEFfGumYL5Y=;
 b=rkQ+89H0ePAWdSJK4Ne+EgBBU/tQitZvzXIXEyrMbKTFF/PhwwZKDzz4OfPkNFHl02
 QYtqCCLr46iFkUiQkPXIpJdX5eNfUKih9RvjLO4FU5Uzxct0bYC7E/a6Q8zIa/ZvHpgP
 njN8nDk0CUVIQ2L80TsPE6EJ1kbazfRAs25drKVldhYW42OCJ6kJiraCyQL+D2xgW8c2
 WWnY6ra7mmJVib/0QS1QOHPsTLNeQ9XLDiNpZt0Zk6M5yr18N/RB2c7NfURzQGbLHBoA
 wbO1hG2ceQjX14/1kFMg2CX9BjLHw/HR7+wOlaPcnmbZWZUwSJHW7COIkeBCE30F7AZI
 8uhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBiExLO5GHNAc2ao89Gm9bDpHXjXKhb0X5Otg/33R3wkRTw+PrA3b2eGtoWUeH4HYVUga37VbLcXFhHM7nvkCVPOZbWbU=
X-Gm-Message-State: AOJu0Yw9EWJysBTbftDNdvooEiZvk+8B3NBJM8HFXmPRnvHMrelVYKXP
 /bAd1v5oKSlUZ/T0SOI/m3eeahtZFHNUA1a2CrZPpqcElhVEsbcVpLjNEUi6Psc=
X-Google-Smtp-Source: AGHT+IHtuIvxBlGH8gb+TyrZrgj72p9HYldkixW/A85Eg02n/vjxhA+QDMegSRrDyDxuCcO1NSBHpQ==
X-Received: by 2002:a17:90b:3d2:b0:2c4:dfa6:df00 with SMTP id
 98e67ed59e1d1-2cf7e098515mr1757442a91.8.1722064407464; 
 Sat, 27 Jul 2024 00:13:27 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb74e8478sm6628745a91.37.2024.07.27.00.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jul 2024 00:13:27 -0700 (PDT)
Message-ID: <aff5f930-d291-4ff5-8f24-53291059d59a@linaro.org>
Date: Sat, 27 Jul 2024 17:13:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] target/riscv: rvv: reduce the overhead for simple
 RISC-V vector unit-stride loads and stores
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
 <20240717153040.11073-2-paolo.savini@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240717153040.11073-2-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/18/24 01:30, Paolo Savini wrote:
> From: Helene CHELIN <helene.chelin@embecosm.com>
> 
> This patch improves the performance of the emulation of the RVV unit-stride
> loads and stores in the following cases:
> 
> - when the data being loaded/stored per iteration amounts to 8 bytes or less.
> - when the vector length is 16 bytes (VLEN=128) and there's no grouping of the
>    vector registers (LMUL=1).
> 
> The optimization consists of avoiding the overhead of probing the RAM of the
> host machine and doing a loop load/store on the input data grouped in chunks
> of as many bytes as possible (8,4,2,1 bytes).
> 
> Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
> Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
> 
> Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
> ---
>   target/riscv/vector_helper.c | 46 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 29849a8b66..4b444c6bc5 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -633,6 +633,52 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
>   
>       VSTART_CHECK_EARLY_EXIT(env);
>   
> +    /* For data sizes <= 64 bits and for LMUL=1 with VLEN=128 bits we get a
> +     * better performance by doing a simple simulation of the load/store
> +     * without the overhead of prodding the host RAM */
> +    if ((nf == 1) && ((evl << log2_esz) <= 8 ||
> +	((vext_lmul(desc) == 0) && (simd_maxsz(desc) == 16)))) {
> +
> +	uint32_t evl_b = evl << log2_esz;
> +
> +        for (uint32_t j = env->vstart; j < evl_b;) {
> +	    addr = base + j;
> +            if ((evl_b - j) >= 8) {
> +                if (is_load)
> +                    lde_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                else
> +                    ste_d_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                j += 8;
> +            }
> +            else if ((evl_b - j) >= 4) {
> +                if (is_load)
> +                    lde_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                else
> +                    ste_w_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                j += 4;
> +            }
> +            else if ((evl_b - j) >= 2) {
> +                if (is_load)
> +                    lde_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                else
> +                    ste_h_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                j += 2;
> +            }
> +            else {
> +                if (is_load)
> +                    lde_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                else
> +                    ste_b_tlb(env, adjust_addr(env, addr), j, vd, ra);
> +                j += 1;
> +            }
> +        }

For system mode, this performs the tlb lookup N times, and so will not be an improvement.

This will not work on a big-endian host.


r~

