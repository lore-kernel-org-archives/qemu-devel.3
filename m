Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C4ECEF173
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 13:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syA7G-00080x-4z; Tue, 08 Oct 2024 09:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syA7E-00080N-Ca
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:19:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syA7C-0006Ty-MR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 09:19:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e06ba441cso1516970b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728393541; x=1728998341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vUtWP+u6fE63bthqpfLYVO0uC7oFUPoAQibLzBQsyDo=;
 b=XnF5ZSwBE/XZr2hRCZMJuCbwSGhaP8xb5tRt1bOjRl2M+Cz+19+SIeMkq7DRy9pE/a
 fqnzBTXmlxTOR5gDWlk5WScHSHl5U99mknzRoc8nfnnbHT93rt2gjXbTuAMRRb+FCDF7
 FVLsX+MKpkmEtJQdTp8YRDaND893OhtHnXrrW94ZQVbq3Su1v0eWSfx1BM53AElwVGxC
 Rr5D3mmEoqiKsalc7jPjsjMQmgIUJ+SUsHc8Pj8Og4L8QUUvJgEDR54515eZBxWf/yuz
 fdHI+epU57z4ukiEZqtavlBWQDY4ytb6DMpMlMHX4J3EgbrZAjLP7tjYaxIxmEcByKWV
 NAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728393541; x=1728998341;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vUtWP+u6fE63bthqpfLYVO0uC7oFUPoAQibLzBQsyDo=;
 b=dW/1Ux8TWBcdY1Yo54bYKPr3XduopX7BCP98ObYRgaRwMq1azNTmBsYkB1P1ZpPOH+
 LTFJOO51FWFAXGU3oM8CyWEsqUe+i8s/tCovs0g/eUFlvQHFL3Ax6b/6g0X9rtzipDlh
 nbAXSYPnHPX0QfEKzBhPozJkct+V1w9jMM+qSNgZ8igphodGOZvHgGOGPeJfhdH82lfx
 I1jvUpFghKLbwuaUA9HUqOSF9YTXJO5JrMI20o4/jzy0bvd1GzD1nm6tdTNdOSFdlmjM
 F5E25tLlitYfKMuPNXfAGkdz6xnvp76T0gUFI9SdpM/ihQwn+RxywBvS9wcK36tIn9FL
 EqbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbGIUynCVnOhBE2gFsLhCMcAYvNEF98ymJzHxFXRnaJhWNxQ7va0vytCdKMT/b1XRVO/eoiDn+aTe5@nongnu.org
X-Gm-Message-State: AOJu0YzuwRFutdYEXWLVx4R/efpxuwImON5vvmLFxZFH19WF0cVNuf+M
 xqw/HeeucnzIukm/7quISdrBAg+UjkKOol4ZRHvCTrivmR7GjgtYqhqfmZpzuLM=
X-Google-Smtp-Source: AGHT+IFRaK32VGNx4JvMuNiGzmCwsEjodo3m7EovrXjrx68PTurvuMFanv4rTJyKTCiu112MVq6Vtw==
X-Received: by 2002:a05:6a00:ac1:b0:717:8aaf:43be with SMTP id
 d2e1a72fcca58-71de22de04dmr25890024b3a.0.1728393540732; 
 Tue, 08 Oct 2024 06:19:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6833a95sm5803560a12.52.2024.10.08.06.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 06:19:00 -0700 (PDT)
Message-ID: <4a1bf9c0-7dad-4762-8131-709c1013469a@linaro.org>
Date: Tue, 8 Oct 2024 06:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] tcg/riscv: Add vset{i}vli and ld/st vec ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20241007025700.47259-1-zhiwei_liu@linux.alibaba.com>
 <20241007025700.47259-4-zhiwei_liu@linux.alibaba.com>
 <a370de66-d966-44d2-9dee-091b28082fcc@linaro.org>
 <e6cd032a-e183-445c-821e-9fed93fe0389@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e6cd032a-e183-445c-821e-9fed93fe0389@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 10/8/24 01:51, LIU Zhiwei wrote:
>> It occurs to me that, rather than caching valid_frac_lmul[][], we can pre-compute 
>> encode_vtype and lmul_eq_avl.
> 
> Do you mean cache vtype and lmul_eq_avl for different (lmul, sew) pairs instead of 
> valid_frac_lmul?

Or even one step further:

typedef struct VsetCache {
     unsigned movi_insn;
     unsigned vset_insn;
} VsetCache;

static VsetCache riscv_vset_cache[3][4];

static void set_vtype(TCGContext *s, TCGType type, MemOp vsew)
{
     const VsetCache *p = &riscv_vset_cache[type - TCG_TYPE_V64][vsew];

     s->riscv_cur_type = type;
     s->riscv_cur_vsew = vsew;

     if (p->movi_insn) {
         tcg_out32(s->p->movi_insn);
     }
     tcg_out32(s, p->vset_insn);
}

static bool vtype_check(unsigned vtype)
{
     unsigned long tmp;
     asm("vsetvl %0, zero, %1" : "=r"(tmp) : "r"(vtype));     /* in .inst form */
     return tmp != 0;
}

static void probe_frac_lmul_1(TCGType type, MemOp vsew)
{
     VsetCache *p = &riscv_vset_cache[type - TCG_TYPE_V64][vsew];
     unsigned avl = tcg_type_size(type) >> vsew;
     int lmul = type - riscv_lg2_vlenb;
     unsigned vtype = encode_vtype(true, true, vsew, lmul & 7);
     bool lmul_eq_avl = true;

     /* Guaranteed by Zve64x. */
     assert(lmul < 3);

     /*
      * For LMUL < -3, the host vector size is so large that TYPE
      * is smaller than the minimum 1/8 fraction.
      *
      * For other fractional LMUL settings, implementations must
      * support SEW settings between SEW_MIN and LMUL * ELEN, inclusive.
      * So if ELEN = 64, LMUL = 1/2, then SEW will support e8, e16, e32,
      * but e64 may not be supported. In other words, the hardware only
      * guarantees SEW_MIN <= SEW <= LMUL * ELEN.  Check.
      */
     if (lmul < 0 && (lmul < -3 || !vtype_check(vtype)) {
         vtype = encode_vtype(true, true, vsew, VLMUL_M1);
         lmul_eq_avl = false;
     }

     if (avl < 32) {
         p->vset_insn = encode_vseti(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
     } else if (lmul_eq_avl) {
         /* rd != 0 and rs1 == 0 uses vlmax */
         p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, vtype);
     } else {
         p->movi_insn = encode_i(OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
         p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtype);
     }
}

static void probe_frac_lmul(void)
{
     /* Match riscv_lg2_vlenb to TCG_TYPE_V64. */
     QEMU_BUILD_BUG_ON(TCG_TYPE_V64 != 3);

     for (TCGType t = TCG_TYPE_V64; t <= TCG_TYPE_V256; t++) {
         for (MemOp e = MO_8; e <= MO_64; e++) {
             probe_frac_lmul_1(t, e);
         }
     }
}

So that everything is pre-computed at startup.


r~

