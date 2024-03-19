Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0AAC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgZp-0003MY-DM; Tue, 19 Mar 2024 17:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmgZk-0003Lw-Vl
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:00:52 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmgZj-0005f0-Aa
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:00:48 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-513d599dbabso6970609e87.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710882045; x=1711486845; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7/OnOw4OUQmhx9rP+AgZ1Oe+KaHMNvT+1NBhX9H1kko=;
 b=ULqdFUuSu6TRs7vRliv0+FGZmP212VY8Hv4tH9gam1R9lOr76TpdF4l15YSGryUWeb
 MjeZz9Ii3s4BcuzcA6XVmGjZSiVt3g/kZqHpU5L8e8iARuWUsfU/WeEmBqOmW3SXnYzI
 nngDYoPFzbRQxIOeHblzHSMQvNr5/qVITotdfKycxFNgOOI9GvETHqD2APpSlALJtilE
 D3sGsHmsDp0VMpzx6+6WURcgwqIhuWHEEFhXBe4dTLfI4urPFkrgEq+Uj1oFzSengWKz
 rdfkL6+SYyjp5a3eEVyK7w464n1IDlfcUsdkFfEMlUVSPZTrCLayNdPGpHnKZfW0bpaW
 HF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882045; x=1711486845;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/OnOw4OUQmhx9rP+AgZ1Oe+KaHMNvT+1NBhX9H1kko=;
 b=tPqrIQhy+Kdiwc3bQke9iFBurXr7BlXB/eNecpsvMCLr5lDdLu1EwyshQyoqoLHpFb
 JizdQaxf3I/0lBiiDXpqyj7QYaUxEYkC45GiCdsWmE3YqxQnb/vK4rSzdB5hfVSIVdGH
 C7UygpEUQC0vicbFaPrLC9rH/4P3UCtg5n5vmEYiQ5KSo7pQpxy2lRVKe6amH3cCNq0A
 RiCbcnZUsopg3z8iEfrmy2VpBv5G6/fOHbOgTYVTPZp+RgQsNuesSM5ehEKOXHbmJiCU
 yRh2NobA1vA1+R9KvNws7KTjY65KU3n02ha1nQOX5cdFmcPQi4A2hHRi70h/yKYbLuR+
 2yMQ==
X-Gm-Message-State: AOJu0Yx/9QMr8VSbOpbA8+ZqixB9qngBl6JKdlf4rJhCPl6Jc/zNMVq/
 IBXRqQT2zHd0zIrc+acuwuQimEt3CWnauVHZw6dPCcXHR6zKUROUiNRQtMpQBiuMHw==
X-Google-Smtp-Source: AGHT+IE8W0DXLoSPfO8vIAhNE4lZc3AtL3sc0yuXhR7xF80DTbzvyKp2erkdeEEnldh2ECFzX9aPcw==
X-Received: by 2002:a19:c219:0:b0:513:5971:10c9 with SMTP id
 l25-20020a19c219000000b00513597110c9mr2507607lfc.56.1710882045130; 
 Tue, 19 Mar 2024 14:00:45 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a197512000000b00513a11e9dc3sm1620743lfe.211.2024.03.19.14.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:00:44 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:00:44 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 3/8] target/microblaze: Widen vaddr in
 mmu_translate()
Message-ID: <Zfn8_Hz21GajuT1U@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-4-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Mar 19, 2024 at 07:28:50AM +0100, Philippe Mathieu-Daudé wrote:
> Use 'vaddr' type for virtual addresses.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/mmu.h | 2 +-
>  target/microblaze/mmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 1068bd2d52..2aca39c923 100644
> --- a/target/microblaze/mmu.h
> +++ b/target/microblaze/mmu.h
> @@ -86,7 +86,7 @@ typedef struct {
>  } MicroBlazeMMULookup;
>  
>  unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
> -                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
> +                           vaddr vaddr, MMUAccessType rw, int mmu_idx);
>  uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
>  void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
>  void mmu_init(MicroBlazeMMU *mmu);
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 234006634e..eb7c683020 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -75,7 +75,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
>  
>  /* rw - 0 = read, 1 = write, 2 = fetch.  */
>  unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
> -                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
> +                           vaddr vaddr, MMUAccessType rw, int mmu_idx)
>  {
>      MicroBlazeMMU *mmu = &cpu->env.mmu;
>      unsigned int i, hit = 0;
> -- 
> 2.41.0
> 

