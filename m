Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E96FCED611
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygea-0007Ho-9p; Wed, 09 Oct 2024 20:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygeV-0007Hc-Tn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:03:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygeM-0000YV-0N
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:03:32 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-208cf673b8dso3010145ad.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728518604; x=1729123404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fb08XXJrl+ZwravU7jGQqNAXaygFJQf5H/aUoDAYFEo=;
 b=QSlN/AIPK5xj5hPpoW2p7I39J0mrYSBniBPCYpt70K6tcTfPiAxhG0O5lrh6Qtn8dS
 /rY/jrkVYzaIbop/b8ZjLukE8otJhHDX5NPk235zehnHpuN6kIm9iMAKOMpVNh47FQf3
 E0+tJIH5jSLHmNx0vwqxNId+m8+o4B8vg7F/Hf+NA6SGm3PV5F9DeI9jjRIGbZSReAPh
 zHU18AYnprqNcLI8iirkPeYV3DcB2CXjDzyazw2lrpo3cXlsuSknRX7IR4krFXtgEVW0
 gpeqWxq1I5BPDs8dOTMC7d7pmLFeNIsL+AFB8+2pidq2/hn+xCLcMS4cXU5WLOtBsn5W
 FX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728518604; x=1729123404;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fb08XXJrl+ZwravU7jGQqNAXaygFJQf5H/aUoDAYFEo=;
 b=WI9BMCjx51PpDw/0V19yNZtASRrUVum9zl1X5mipseSRiHU22XdtM3pwVTyEaR9RQw
 joDc1iJn3sCdwl8ffpsTuZWSUHh5c8mhgTntRAMufZqIrdnx5HRAbUOGANAMvSVyr5qk
 L5P7nQaslYAlj0JZapJ12BGo6gJ+5SL/d1UDv3J34hDW0OtM80wfqA4cBwgP4k5d/cJt
 mU/2A8fcVTXlfkswwBW/rwQUKuY5X06HnD+6jbTxJI99YdI3/189pwAzu7yfqYphI2a3
 xLvNwX+YzL55CEisXIreRbIIAMbLbqrijK2aV73dZgmCDvzGuQr03FGIl4b4TWQX6DvA
 HWQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxkaA836A0t1raBKaNkkY5C+e3uAU6JkHfC0Mh7CnM70R3lQI2gOG4BWbZ9nhEtaWtpxHxeO2n2zoH@nongnu.org
X-Gm-Message-State: AOJu0YyaIwu5tpnfaM2sOh0srmQoMNq8dMWDOuq8hGbceqTOpEQJ6Gbp
 PnQjnc63YTjlOYWWD6OsngWrSrMHpvKbuHOhLOzgiyp5bchd2zyCzUDeCxERjHo=
X-Google-Smtp-Source: AGHT+IET40/TpnsmKV5vimt3fVlyFPJKPQfIy8MXPy4BQ2soBggbPxyNq0WOYl0QBGwQ/pC03qQ0Jw==
X-Received: by 2002:a17:902:e54d:b0:203:a030:d0a1 with SMTP id
 d9443c01a7336-20c6378f6fcmr70071345ad.58.1728518604073; 
 Wed, 09 Oct 2024 17:03:24 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c82ea44aesm2700605ad.232.2024.10.09.17.03.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:03:23 -0700 (PDT)
Message-ID: <dcfaafd5-473a-465d-832f-c8761abc050f@linaro.org>
Date: Wed, 9 Oct 2024 17:03:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/23] accel/tcg: Process IntervalTree entries in
 tlb_reset_dirty
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> Update the addr_write copy within each interval tree node.
> Tidy the iteration within the other two loops as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 709ad75616..95f78afee6 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1024,17 +1024,20 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
>   
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
>       for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        unsigned int i;
> -        unsigned int n = tlb_n_entries(&cpu->neg.tlb.f[mmu_idx]);
> +        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> +        CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
>   
> -        for (i = 0; i < n; i++) {
> -            tlb_reset_dirty_range_locked(&cpu->neg.tlb.f[mmu_idx].table[i],
> -                                         start1, length);
> +        for (size_t i = 0, n = tlb_n_entries(fast); i < n; i++) {
> +            tlb_reset_dirty_range_locked(&fast->table[i], start1, length);
>           }
>   
> -        for (i = 0; i < CPU_VTLB_SIZE; i++) {
> -            tlb_reset_dirty_range_locked(&cpu->neg.tlb.d[mmu_idx].vtable[i],
> -                                         start1, length);
> +        for (size_t i = 0; i < CPU_VTLB_SIZE; i++) {
> +            tlb_reset_dirty_range_locked(&desc->vtable[i], start1, length);
> +        }
> +
> +        for (CPUTLBEntryTree *t = tlbtree_lookup_range(desc, 0, -1); t;
> +             t = tlbtree_lookup_range_next(t, 0, -1)) {

How about introducing interval_tree_foreach function, that runs on every 
node? Running with [0,0xffffffff...] does the job, but it's not really 
obvious when reading the code.

> +            tlb_reset_dirty_range_locked(&t->copy, start1, length);
>           }
>       }
>       qemu_spin_unlock(&cpu->neg.tlb.c.lock);

