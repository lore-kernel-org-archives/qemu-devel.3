Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5BCC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 07:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjDsA-0000zj-86; Sun, 10 Mar 2024 03:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDs8-0000yF-Je
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:45:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDs6-0000qs-Vr
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:45:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so3220928b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 23:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710056725; x=1710661525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DYNSoXXZqDpmcPT9QJEfN/wtyVM9Abzp3MKNZnrOzsg=;
 b=ukMoEDOfdnvKMYgWpL5eHD4n0fX/1IEER9p3kAQcUVKHUs4qrczt0BwMEzSf3i0iGn
 aNCmAZQyds5TVOMHFeGaoD3R9CHN3X705EtO+kwQ3/d9B/BsPLxzWxy540eTbOPg0T7L
 4CqNmBixpQGZrglecqglbANXdgbomg4LRC4YXw6QNbjizDv1jTzeqyAqbcKL2r6NPnCD
 xIV2q1dmvSIAl4KUCCEgi1KCA77LRwOrF2yIxqiQvyx7ETn7+SB+8htAgCFReTJ3Vtwb
 0PBGMko18B07IYz5vxNKgCtTd2YoxGaYZ6O979nERL6oi0gc3sViy3LLa023v27LBkdF
 sQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710056725; x=1710661525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DYNSoXXZqDpmcPT9QJEfN/wtyVM9Abzp3MKNZnrOzsg=;
 b=US04oF4ZzWugX2Ru2wm/9P2NI3OdO3sd4RRpjboeKEI3HCuSnKG7vxFDHLzL5z9V27
 LqscIqI6pO2j7U+eLg0UvLzeeuRPXbM5M7nwGyaY6UGHUxo7NRwC9FXeM9QYDGS/oK7B
 YQ7nR4xtSYLasqyclyAQ8Uusj3IxmUfl1tIqkss/BZ0mPpUIB4LvqeiFouC7/mi/HygD
 TFszf17w/C8J2q4RLr7iOUrq6rPd7NZHOlm5PhKaf9JDMFCdwfnJ0MNH6m3TYDd57r5W
 BJ1FIsDQMxexkH69XKUp9To1NoZnGeTYJBgMSQPRQnYmp2tCVUNlDOL2j4v39EAUztUq
 WUDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTUCAHjEPM1UEXGoR/9xGj1qWiVNVTqNtdrCOJfLgZP2l1rGuvGzzAgviu5z8lOwdy5JM+ieN3IJdVwqNNsyNxQ+x2yHU=
X-Gm-Message-State: AOJu0YyR61uBvR91+kNOh7gn2LRcEohKP46khCQ3IR9qArbzx1ayZdvo
 67Em9vttxWNZeV8oQxwrxzkYIyqeBke6hQ/65ugOaVuN1C/wrF+rw/8bd2XRckE=
X-Google-Smtp-Source: AGHT+IH/NKhFWur9YObRzZiisxjHcAg6WACAzwos0UKZEtomaeqYLGad791QF5Sm++nqo5aTHVcFrQ==
X-Received: by 2002:a05:6a00:1396:b0:6e6:2781:1945 with SMTP id
 t22-20020a056a00139600b006e627811945mr5429337pfg.20.1710056725556; 
 Sat, 09 Mar 2024 23:45:25 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w187-20020a6262c4000000b006e68984419asm547911pfb.105.2024.03.09.23.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 23:45:25 -0800 (PST)
Message-ID: <27512a0d-2e43-4efd-8b4c-c261c70cbb78@linaro.org>
Date: Sat, 9 Mar 2024 21:45:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/10] trans_rvv.c.inc: set vstart = 0 in int scalar
 move insns
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-7-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240309204347.174251-7-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/9/24 10:43, Daniel Henrique Barboza wrote:
> trans_vmv_x_s, trans_vmv_s_x, trans_vfmv_f_s and trans_vfmv_s_f aren't
> setting vstart = 0 after execution. This is usually done by a helper in
> vector_helper.c but these functions don't use helpers.
> 
> We'll set vstart after any potential 'over' brconds, and that will also
> mandate a mark_vs_dirty() too.
> 
> Fixes: dedc53cbc9 ("target/riscv: rvv-1.0: integer scalar move instructions")
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

