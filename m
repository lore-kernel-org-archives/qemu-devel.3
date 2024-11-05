Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21968D40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SW6-0002p3-FV; Tue, 05 Nov 2024 17:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SW1-0002oq-Rp; Tue, 05 Nov 2024 17:59:13 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SW0-0006jd-AB; Tue, 05 Nov 2024 17:59:13 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43169902057so46849925e9.0; 
 Tue, 05 Nov 2024 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847549; x=1731452349; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aHQu9ZcSXTqfvIlyDPTW67TGxyaJxXaW81oHUVLwj64=;
 b=lQ1g6nUk82WhSTYgrHJfTMJXa7VYc7vYwoRUo/ITqKaRueK9t/2pdLg10eOtiDgqNP
 G7shQSuQebXVgEPEWEkaXJBMEPD6jCZ8m7v3oqCiHLX9y5/uhjmSUjGenLBtg3Ghmtq3
 x10Iz8zOnBnl5CN5GqzCyEnCMZuEADR4tdTQTMna2Vj7hrJhO3SP9i4ytCSlFYiSjLzb
 RUG/oPsqw9kRxF9gLdMefcQcMLX5C6ZmdBjDOIVydDXNco9pEE0DTEud85J5bLA/Z0L3
 pKNxN/SNg0inuByG2yW2wKg/ulIXllKtILq19e3k1CkKcAy5wIIC7s4RakK5xNJ1KQJ6
 WyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847549; x=1731452349;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aHQu9ZcSXTqfvIlyDPTW67TGxyaJxXaW81oHUVLwj64=;
 b=gQW3UM7RuKlWS71Rr+2e3dXj9LolcYyF4UG/60eUOeaMrM9bBpV/9M5Uz2mRuyMe4Q
 YKctwl/mRMKc/j8voCUKWd+yvy4pycgR//RdxFy8rR1nfl3JR2rtWHIsPXXQy2lEQLkp
 uEN0R5ACX55UozsgT59qH207EtYTaAQq+HSNpz5SK4v2BK5zE3pn9rvH6e/u/tdmUBGC
 uGkRL8LPPV3PlDEdfZNWasDHuxOEhMNmsMKa1+R18RCdLYrftzKcf5iEb0Hu7Z4cvhGM
 Q4BkS40gLPpJFKOeobqVAnHvIB/bpMzYV4eg/9s9gom+UsaXM/cD3urVQv8kdulCytXf
 DknQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU1ivy5mhgpqP8lQkhxNGnD/pvHKxnlLY06c4pLM6aKn9V3CQqTXXB/KoMq8eL7Ht+WmRC84Rvbg==@nongnu.org
X-Gm-Message-State: AOJu0YyV48Dex8MaXIavlTmptknXnxbYfQZZHuGdI4nJn7X0dKbZdl6k
 TGafcevPTA54sfeRbUibZotB8tYOvM7kz9/bmn++Pj3E/ajWQXgB
X-Google-Smtp-Source: AGHT+IGaAKjaBV9mWuDlb0SMdEJE23HRs1MNWFVEk43ZavYOd+FnHlAXt7H3YC5qG1LzdqF8CHo0UA==
X-Received: by 2002:a05:600c:3b88:b0:431:5e53:2dc4 with SMTP id
 5b1f17b1804b1-431bb976d14mr208072825e9.6.1730847549271; 
 Tue, 05 Nov 2024 14:59:09 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6eb332sm1201865e9.40.2024.11.05.14.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 14:59:08 -0800 (PST)
Date: Tue, 5 Nov 2024 23:59:08 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 03/19] hw/microblaze/s3adsp1800: Explicit CPU endianness
Message-ID: <ZyqjPJmRb_-xEP9U@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-4-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 05, 2024 at 02:04:15PM +0100, Philippe Mathieu-Daudé wrote:
> By default the machine's CPU endianness is 'big' order
> ('little-endian' property set to %false).
> 
> This corresponds to the default when this machine was added;
> see commits 6a8b1ae2020 "microblaze: Add petalogix s3a1800dsp
> MMU linux ref-design." and 72b675caacf "microblaze: Hook into
> the build-system." which added:
> 
>   [ "$target_cpu" = "microblaze" ] && target_bigendian=yes
> 
> Later commit 877fdc12b1a ("microblaze: Allow targeting
> little-endian mb") added little-endian support, forgetting
> to set the CPU endianness to little-endian. Not an issue
> since this property was never used, but we will use it soon,
> so explicit the endianness to get the expected behavior.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index dad46bd7f98..37e9a05a62a 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -71,6 +71,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
>  
>      cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
>      object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
> +    object_property_set_bool(OBJECT(cpu), "little-endian",
> +                             !TARGET_BIG_ENDIAN, &error_abort);
>      qdev_realize(DEVICE(cpu), NULL, &error_abort);
>  
>      /* Attach emulated BRAM through the LMB.  */
> -- 
> 2.45.2
> 

