Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B83CD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOfJd-0003HT-Pz; Sun, 17 May 2026 13:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJc-0003F3-KG
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:30:12 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOfJb-0005M8-7d
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:30:12 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so719809a91.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779039010; x=1779643810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fU/R1CUNwlWYUcgqp8AA9UKHEF/WRkXItQgjzhOu1Ac=;
 b=QNPnCzmGc6hr3/lmFCuipiDIxC5HSwDWL6GKsryemwiicFduyQQ0O2ygzJUQmTTT2o
 /7tY+hpIWqj0SNpxuKvHrK+lLDWrw0+tLf/8w2DPSzeYNgDJMizyjeuyK3a4YyPi1ly8
 1pBJr+4yMADeorJZ3qDAn63szQk3wbXLfjUb866jZ9aaguls506tWiRmBjGYuHpGENnt
 g1B5nvChZTOVVOXf6VLToyfwo8bjymV07pTFN2mg/uecNKmGrcoEbXbspGMM0nklTJuA
 1pT9NTyio7uTs1vAn/heCPjwaC2IgNHfbUecrixRxm6PgXdEEhEq2owdsByQbjiwz5Y4
 4VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779039010; x=1779643810;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fU/R1CUNwlWYUcgqp8AA9UKHEF/WRkXItQgjzhOu1Ac=;
 b=CfwG20Jel63Ny9/XfvxtDvkCHNNu6ySmVmyYIquPIHZQhJi+wqfuX75nFEilFdXDAX
 peF1pngrx1F2A1xDm/0s0JsI9IVDGsXV1rUouPKfvCoh9IcfkAgxEjWD2t/+oNkbHEt+
 /Ix5aEEuQHB+8eoBoI+fzLnEu1lQIvMEp6UHqnE6bR0E8tsMSr3EYQPH1mwG6zGeiKLt
 afdtSZf8MmI1EFUlRgJXMpsGWzDcUKf3wzArBXOdR2OnJvYW+6OJ++YDObusNp3qcKwL
 70k/l8++eX1cV1A2QadR27poqbymTj5s+mynPZg3lL7KGOS8vKT2e6x+l3XPU3Utw/Oo
 nQDQ==
X-Gm-Message-State: AOJu0YylhrmCZGHUrmT1sC//dIm4VE7e2v8v/nD/mcxR4Ar3iSNZdUI9
 ICL5pvAiaiG13DTfKmtpR9ZmFPNBfW9YDI5ILfHdmJRLEZrRbgqUeKeIx/eC3xgDVb3LKR54px8
 HA+DG
X-Gm-Gg: Acq92OEpwxLrvjcx4JyrWeoLwL9m3jCxeHc0QIFApkpy5Pr5dXKpDH+pIdaotiv96rg
 PIYSrgwJadA8Jby5EU7DC4U6t9uei/WeyqAczJM70260I75bqa6Qlos4ujMXF2MZoRfr8XBwWqu
 3lLzHyrUo70ohe8I+Bpnc84Ww2F2XtYhS0sUSBXfuK17ryCUP7jwE6onwmHbgGcEcApTYyE2PQl
 KRMo55c/fL1q8t4fKBPyTDQ997+wfg0v3AR3QSV3nnhvUY1s0ri/MdqcYxSCCz6o2pAbp/NBUzb
 IsBuV8kUFjz3TuleeqzWIjJY/08IjFJzKssAQPWVQ/cqN+Pcia7xfNGN/G6HozJFAUNgDgRkVT6
 fkX/AuQsZb2oim4r/ONlmvgc5a3LSALMnqFklj2ek7ZBJytLWHQzgmsSu3+tetDeNeVbJJ1zRRH
 lnLmNE7YvcjTo/w2iLUHMjEYGc21jZLlqgtGbK
X-Received: by 2002:a17:90b:1344:b0:366:4f8a:9847 with SMTP id
 98e67ed59e1d1-36951b711dcmr11934364a91.17.1779039009548; 
 Sun, 17 May 2026 10:30:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517d8570sm8939411a91.14.2026.05.17.10.30.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:30:09 -0700 (PDT)
Message-ID: <b005550a-8d83-47a0-8b46-7b32e84c41dd@linaro.org>
Date: Sun, 17 May 2026 10:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/35] target/mips: add Octeon MTM1 instruction
To: qemu-devel@nongnu.org
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
 <20260514-mips-octeon-missing-insns-v2-v7-19-226686be4ce1@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-19-226686be4ce1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 5/14/26 10:37, James Hilliard wrote:
> MTM1 loads the middle Octeon3 multiplier operand pair from rs/rt into
> MPL[1] and MPL[4].
> 
> Like the other MTM writes, it resets partial products so the following
> multiplier operation starts from the newly programmed operand state.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MTM1 out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Describe the Octeon3 rs/rt MPL[1]/MPL[4] pair handled by the shared
>      MTM translator.
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

