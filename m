Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914EFC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 12:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY3an-0005JN-B2; Thu, 08 Feb 2024 07:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rY3al-0005Il-Rf; Thu, 08 Feb 2024 07:33:23 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rY3ak-0000Rf-AR; Thu, 08 Feb 2024 07:33:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d74045c463so16305895ad.3; 
 Thu, 08 Feb 2024 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707395600; x=1708000400; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=17EWTUqBeZN/nFuSY2VL0+zeR67GULiaclZdwjKMBrU=;
 b=Oi5mVBq58DlEaMBySYXy8Yylq8FT7jC+2OK1MM4hbsZ2LGHjabFED1THDBJniNe/n7
 cjW0h2jVPFkEt9Bs4HcN31O8DcWmp6Lq/X4TliELK99uimYuMiyC4/qhLLCfBZS4ZBC8
 iJlamc49qn8AZ+U+BYidb3gyp84PuRmvYWPUmS9mnNI8IWereAxWsQhYDCyRVWqro/J1
 /58mEYukbxFsvIVS+gPLMqGVkDrlHIBJ3NwADurVQSvER4SyPGn5djlra0PwaS3amTHh
 GWk/d/JfW5RRrsBQHlqvAkni/nOyrLoHaTIZ3yIQWHa+axT4SdyfNZD58JimMA3V9IcU
 WfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707395600; x=1708000400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17EWTUqBeZN/nFuSY2VL0+zeR67GULiaclZdwjKMBrU=;
 b=EvuRoLQfIRjW35WatLd67zIQBP3OzMrXXD7UJSfCsvZDxm7cdAoINjWavHGj1ipjYf
 ElwUup8hVrFmX3MNfruOx4dLvqpfeqSInde8TPGbos2sJoHYZKzORfac/YBlmiT2dCVD
 zypO7vdvRbLCCh0h5K/Vp8iavy7Vq/Fs82NWGQ7rQjfCfmLPN6ayxTZ+tFs4paA/s7mY
 nEchyJs5SoyLLi76zS/lfNLOW87IRMyt0Js182jskOJTacf7O+bDByTJ9H9m19Bzo4Qm
 5zgVfCH6xZgYmUtO5e4UNZQjX47aiGmyaGzZuQdEshud+stZbC/J3S30UF2gf5XrXrF2
 kiRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvZ3SZQA7G72fU5ojszSUdqHK75BeBiwGS9FoR6xWn//GV3GVYbEUcBfEJ1BFP86HFCT3iYcswhHBFFramwgNLtVGa/lZXQQDJ9S+WC4eqkfVRYLD17n+tRFNHfA==
X-Gm-Message-State: AOJu0YzfNYVVgpgDj7Ftm8Np+ygoM3q/hQMjQyzAz9dJdmMsS9oQhoKs
 peD/ikOLwbO7CUr6kN6zh1cTlTNDLO7HDiC/RKX5Nm7g5zMmjJOC
X-Google-Smtp-Source: AGHT+IFywrfUgHhbJ6f5z0cRciikUVba2Q2ILNaliSFNfKBPELVY0fKCi4LnsIR4mZNEJVu/FpGcqA==
X-Received: by 2002:a17:902:ed45:b0:1d9:5b8b:f70 with SMTP id
 y5-20020a170902ed4500b001d95b8b0f70mr7387979plb.29.1707395599972; 
 Thu, 08 Feb 2024 04:33:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXycx8a3sYVG/55sdfH6yFzW25p5hXUsWkIFS6jWNLFxFwWJibIlefwN5mL80JNOqdJh3zFjg8cnh7vQ7mcImSgXKdb37/r1v/kP8gnJFjCJResfGBkUmUP4WofRsb2ofD0C5aymhRliyi/QmyowU5+BkGm2i3MfgzK4Yaf6CErs0Portne/J/QBQ==
Received: from minwoo-desktop ([116.121.76.56])
 by smtp.gmail.com with ESMTPSA id
 ki11-20020a170903068b00b001d9a1d498e7sm3275364plb.280.2024.02.08.04.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 04:33:19 -0800 (PST)
Date: Thu, 8 Feb 2024 21:33:12 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Minwoo Im <minwoo.im@samsung.com>
Subject: Re: [PATCH] hw/nvme: fix invalid check on mcl
Message-ID: <ZcTKCAWaWzL6YT08@minwoo-desktop>
References: <20240208-fix-copy-mcl-check-v1-1-6f89df85f9d3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240208-fix-copy-mcl-check-v1-1-6f89df85f9d3@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x62e.google.com
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

On 24-02-08 13:22:48, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> The number of logical blocks within a source range is converted into a
> 1s based number at the time of parsing. However, when verifying the copy
> length we add one again, causing the check against MCL to fail in error.
> 
> Fixes: 381ab99d8587 ("hw/nvme: check maximum copy length (MCL) for COPY")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Hi Klaus,

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

Thanks!

> ---
>  hw/nvme/ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f026245d1e9e..05c667158a3a 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -2855,7 +2855,7 @@ static inline uint16_t nvme_check_copy_mcl(NvmeNamespace *ns,
>          uint32_t nlb;
>          nvme_copy_source_range_parse(iocb->ranges, idx, iocb->format, NULL,
>                                       &nlb, NULL, NULL, NULL);
> -        copy_len += nlb + 1;
> +        copy_len += nlb;
>      }
>  
>      if (copy_len > ns->id_ns.mcl) {
> 
> ---
> base-commit: 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440
> change-id: 20240208-fix-copy-mcl-check-3a6d95327154
> 
> Best regards,
> -- 
> Klaus Jensen <k.jensen@samsung.com>
> 
> 

