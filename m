Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C13AC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZonS-0002bv-51; Thu, 10 Jul 2025 06:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZonP-0002X0-SU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:46:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZonM-0007CE-Q0
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:46:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so488806f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144387; x=1752749187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D03FnMWOzpAFkdAuAaIpWdB+dvO3rfLnQg3ngzegba4=;
 b=vyZklB8MaIXku5jNgQOEmwIw0FlaECYd667NtQQ6NLHf1oN/cC3y6ROFr2KqK4m71m
 86YymbiaR1hs4sVEzM+vY25s/oYBV3tzT7Lt4eIBcGGtV8Hteu52AEFA/Yhjf1l2GmZR
 fqr8OLXSPINPCD0nDNK+somND6KHpe/heQV+ECVpl9sGlYq3CN6Y9IzukdcTKga5i+w+
 8kQlwzdOG9H2V5vu9Y2P0unOqE/Ex/u46hDefW6xxqTMA5CUSwM5Ru0eHlgcxGpp4aF+
 DxpfmT3CDTo0c6f0wm9SA0rCZqid/18d7BhC7TyTvLMiSu2MGUY3fxnot9SDdxolA0PR
 2fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144387; x=1752749187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D03FnMWOzpAFkdAuAaIpWdB+dvO3rfLnQg3ngzegba4=;
 b=u7wU6CXYOLrnxiVm5VtOXlgm1SQyFXQpId0Ho/zU2436BSHNcsmkV/dQvTsPKmTB3I
 acsZFbKKg/cOUBz5t4wkvRxH5tIC3G/XnV00Xyrj86LB1tFHTvS8P2GSq0uVNFj+MPOq
 eF4EWGIYGMyWVVD9tNQvSwvPJIZBDguWPiAD717+cKkQI19EwifmJ2WpIzaPQre3mL+E
 gEj46yM3EgFKo8tRF3NaVVvIu8ysmxzvqfYWuREiHPRlPpm3DnrNNgLz/xSe8X3bT3MT
 IeFw3jbprh8q5EeosmzgAasjrwQJsrEu806dKAxlcGKIWrjHF24hPC4hWKn4IuHKcij1
 FZBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwT6LDBA9OEXllb9kFtDy6qbUmitk0buTt3F4QZ/OV4SNia03fD++XBWGZUvqZ86yTmLDLH3O91jCN@nongnu.org
X-Gm-Message-State: AOJu0YySl6nmUNv6pmyH35xw48Gtf+gPECWLUg3bKznkOWBcYovyEfmU
 5jmwMkJDqBmwabQC9197QZAAeUTT5OMh7m0HZQQghVtYgAqrfbbtfKEzoCX/jdxFkJM=
X-Gm-Gg: ASbGncsw3FeknOgeosNQ122mwADuO6gvkrGXlqdj4xAsoDAlrn+IiF3IB4QXdNqRNen
 hY4FN5Sm6Zy5g0eKMu96xQ811rUbiCql6CrI7/FyKLUdyYGD/2aeJvBDegQ+I7m6PxvxXrfexgh
 KCoqzFGzNp1S2B2rkN8sKOGsFk6y4TiKdsfe77L5OTw95t7E6ISjIG0TCtP06GzGrSaIv9D4pWv
 4sgVY4/cuDL0DvAp7cfJ/Ekq41Zbjji17IDoRIa0sjeWQbWUBMOWm/EunoWORnLed5/fHRMLmVT
 iEpQjFo9Zozr+5v6mZz1kR7EtwImea40gKigv73TTiDosVgidQwYB5mS4/VpMJGtXo7us5AJa2w
 0nDqhReEAorHkiZVt8UlgeDZ8bduv2un3B6azj20b6ps=
X-Google-Smtp-Source: AGHT+IGCApOwEBLyHULh6jot36PYlbIaXAbIdR1l3REQEkiKDG7A58dF3xodPZdaO5xx3VYX3DR4Yg==
X-Received: by 2002:a05:6000:2283:b0:3a4:d685:3de7 with SMTP id
 ffacd0b85a97d-3b5e7f0efe6mr2384182f8f.8.1752144387060; 
 Thu, 10 Jul 2025 03:46:27 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc1fd7sm1514622f8f.26.2025.07.10.03.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:46:23 -0700 (PDT)
Message-ID: <a1bc9aea-4539-400c-ad82-916cf8ff22a7@linaro.org>
Date: Thu, 10 Jul 2025 12:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/18] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-2-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710085308.420774-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/7/25 10:52, Mark Cave-Ayland wrote:
> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
> possible to specify any CPU via -cpu on the command line, it makes no
> sense to allow modern 64-bit CPUs to be used.
> 
> Restrict the isapc machine to the available 32-bit CPUs, taking care to
> handle the case where if a user inadvertently uses -cpu max then the "best"
> 32-bit CPU is used (in this case the pentium3).
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index ea7572e783..67c52d79b2 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -418,6 +418,18 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
>   #ifdef CONFIG_ISAPC
>   static void pc_init_isa(MachineState *machine)
>   {
> +    /*
> +     * There is a small chance that someone unintentionally passes "-cpu max"
> +     * for the isapc machine, which will provide a much more modern 32-bit
> +     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
> +     * been specified, choose the "best" 32-bit cpu possible which we consider
> +     * be the pentium3 (deliberately choosing an Intel CPU given that the
> +     * default 486 CPU for the isapc machine is also an Intel CPU).
> +     */
> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");

Please warn() the user, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    }
> +
>       pc_init1(machine, NULL);
>   }


