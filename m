Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884B5CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcLY-0000NG-6G; Tue, 19 Mar 2024 12:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmcLX-0000N0-7U
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:29:51 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmcLV-0005t1-QC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:29:50 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513d3e57518so6265575e87.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 09:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710865788; x=1711470588; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R/cDhK6QP4k/L9//egUAkrlLQRemQxMsH49fFAmjT1U=;
 b=CMc/eqicuNlh/Ou9kWWo9EfRQR3EC1yU80XHbSDU/0T3VQRFvkRayJip5+w+VnU+Oj
 9sxNBFKLW0WpjfX5sLnVg3mB9Of5r7H49FCqZRUM/yEWi/fjBRSmiNTtW0QZwYxmKi3k
 a5+Qlu+70GY555PLxPk7jt2geHxSzkaFZZ645AyEjgXyPvH9Yjj6lufYBNzU2Ijt30Tb
 7O42PH5030WuzG6XUPjcUhnvq4IhdyegcMF/fyOSzD8M6kjAzjtkqNszg2cRbh2bFrJN
 NoVRsM1JBfPL0i7YolB6ImwMohPB5TqCzPgDAkdUh0ZQEOuIrcCtrAZbUDIWAAcL29AJ
 lnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710865788; x=1711470588;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/cDhK6QP4k/L9//egUAkrlLQRemQxMsH49fFAmjT1U=;
 b=i0pn2fMWkGLfUHMSdsxoReT7N4rLDmRR6TN47GPjkbiJyCKwRjGSsMiu3ys4ThNvpE
 uOOlNoW2YtgccMBEf5ugIfmanFDSXRGJ7+6e3ml4NxHO839MCIWGSu4MfdgBc0sE1em5
 CuNJ7p/ZAovXqCf4HslV4YRxkmtHUzKg1Ywvwy83YtII5ooMeUwjRqIV8YMRh9os/Jcq
 007R28cwI5i62fI2mczi4IyjW1FzItz/Xlt/eL3Mr91NiwkAlPoUrHqo/7bgj8Zjflbh
 yoWhCZ6GdUALO3D1Gnftf8XGsOoMAon3GDP9oK6gnKtQSBFVn5Wjf1UOTSjspiCUMniA
 DRBQ==
X-Gm-Message-State: AOJu0Yz1nmw6aSKMPIY6inxpc3E6KvPWxEKTf5inMYQOumfrrWtD144m
 po4wStzCPR6dfIKwulFZtsgBwpX0MvI3hwGQQ6ESLvaxX+EqiBxD
X-Google-Smtp-Source: AGHT+IGfqxojxAFwzLyAl+sg9RlsfS0swrEUyRmnVReV4v1nuHMSo1sr9qOh421eliV5Ty4pDU2pXA==
X-Received: by 2002:a05:6512:6ce:b0:513:dcc1:4c35 with SMTP id
 u14-20020a05651206ce00b00513dcc14c35mr10440991lff.55.1710865787703; 
 Tue, 19 Mar 2024 09:29:47 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 q9-20020ac24a69000000b005139d7911cbsm1984447lfp.95.2024.03.19.09.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 09:29:47 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:29:46 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 2/8] target/microblaze: Use hwaddr/vaddr in
 cpu_get_phys_page_attrs_debug()
Message-ID: <Zfm9emIheJPvJh63@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-3-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
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

On Tue, Mar 19, 2024 at 07:28:49AM +0100, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 0a12c4ea94..3f410fc7b5 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -228,7 +228,8 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
>                                          MemTxAttrs *attrs)
>  {
>      MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
> -    target_ulong vaddr, paddr = 0;
> +    vaddr vaddr;
> +    hwaddr paddr = 0;
>      MicroBlazeMMULookup lu;
>      int mmu_idx = cpu_mmu_index(cs, false);
>      unsigned int hit;
> -- 
> 2.41.0
> 

