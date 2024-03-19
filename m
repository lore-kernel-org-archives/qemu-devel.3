Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF2DC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 21:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmga4-0003Q8-68; Tue, 19 Mar 2024 17:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmga2-0003Pn-3R
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:01:06 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rmgZz-0005j4-MB
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 17:01:05 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d28051376eso100519881fa.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710882062; x=1711486862; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1rPO6hRo1h9sfy9uQrRga0g/pQU16/bfDnAmxyQovB8=;
 b=k2dVwHiF93YaJkMOn+5a953aHdpS/I+v6f7ODUgxlCRcII5uOB3sHZsQE9+l640uNc
 LDn9oSSB1Zb7ZR/HZIF8uB4/zrrn57x8eKR4Gb6QDjRNy3d6+AHl+7wHI/izgMpkiA3m
 OCoH5L65rWohvKJompWy9qfgP878TQJYBP5Aj6FMZgqrmjJEzeHx3T2DVHZRVbMoNSta
 +2Oc0rVQQI+i9PyjFvBQ3n6RZSq/6mYKSECRoqSpOL/24GgSW4LV4xbCGbpvTm+FLlk/
 reLF8WHZyuTYiN8AUP1rBnqfEsJdXFR6WpJeOFXM63BIuv9EGukchg8lHtg5wUwxkIk1
 v1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710882062; x=1711486862;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1rPO6hRo1h9sfy9uQrRga0g/pQU16/bfDnAmxyQovB8=;
 b=kf1CyMgNmIRZ0I+qAekvuEFD02hAEmkuOiibHoOaZY04wD3upecA1hshAcOiK3DIJM
 pE7Xw+qBo8tqy9kjrryHxYHibkPM64hp9ldj3ZwStvL5mX5qFwRN+3kgPuiQbhtlczH3
 NSdcre2mMgg/bo8r7Wwb0RaGSNx+ztCKZDd7OWEZeaJE/Fed2b4pO1+G3qtgX5sGIBxn
 fB+dKDUs6EDMkS1DjrkvRIl9Kdcn0t8I+xWyvH5wkqGkHuMeZsttZzJ7rM2RmRVIQqKz
 MQvTelFAo9na1cT8+o6xI2sBMeuLYgPEbPRDzR4vD502Fu8tk26445UXWO5dahSKWVok
 4xWg==
X-Gm-Message-State: AOJu0YwSpXqfjAXhAxjPmO3neDAEgOaUgVznmiGUecpUAthy67ZzEkrH
 SzhNjxYcvD/LkxBSccajoLMH0f4Z5RJTjXKgul5qS11tstTFeyXnN7v3Su5KWL9k2g==
X-Google-Smtp-Source: AGHT+IE0fhZrwrUc/43A23+R5bLL91rOQIwoTqooIsIiy2gfyNFZ/P17kh4FNVCf18dyJOKSCFUlfg==
X-Received: by 2002:a2e:9847:0:b0:2d4:7455:89f6 with SMTP id
 e7-20020a2e9847000000b002d4745589f6mr8929507ljj.40.1710882061496; 
 Tue, 19 Mar 2024 14:01:01 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a2e86cf000000b002d361916b1fsm1952091ljj.32.2024.03.19.14.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 14:01:01 -0700 (PDT)
Date: Tue, 19 Mar 2024 22:01:00 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 4/8] target/microblaze: Use 32-bit destination in
 gen_goto_tb()
Message-ID: <Zfn9DMZ6xLdMUDYL@toto>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-5-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
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

On Tue, Mar 19, 2024 at 07:28:51AM +0100, Philippe Mathieu-Daudé wrote:
> cpu_pc and jmp_dest are 32-bit.
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 4e52ef32db..d6a42381bb 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -121,7 +121,7 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
>      gen_raise_exception_sync(dc, EXCP_HW_EXCP);
>  }
>  
> -static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *dc, int n, uint32_t dest)
>  {
>      if (translator_use_goto_tb(&dc->base, dest)) {
>          tcg_gen_goto_tb(n);
> -- 
> 2.41.0
> 

