Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C0C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts2G-0002SK-Il; Mon, 08 Apr 2024 12:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts2D-0002S6-K0
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:39:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts2C-0000x3-5x
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:39:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e244c7cbf8so39192805ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594388; x=1713199188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dK86kLH8h+bVJlAsuIisqVKoN+GDJAirziHOKV75zy0=;
 b=hiUGVnGOjaQxkzdzvOdhSTqX5C+I5csmNNi0BVxL/A7P2yDCxlP2weaJbAmG96L7hO
 VLwNoxpjbp70oRBHubiEmTKwS7Gu724pgRtcRsBVAc6Aq4KwMALef3/WjOKZOLUUAYrW
 TPUELKhhLX35+GI4mgx6iLHmLOGaUDxTNGhNXO7MofITqyNMsVK5NdqXeD0lldcSSria
 zHgK7+XnPfvlLDzNfpkWEcsle+0QUQq5zIKQNdxyw51pscc/7liyEDOfy/5QNdUvDb1w
 K3Ewcm29zo0HISlCwko6gKmGozJa8FojIlwp7U/IvGJLs8YUI00yufINLNVWgl0J9R6S
 dKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594388; x=1713199188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dK86kLH8h+bVJlAsuIisqVKoN+GDJAirziHOKV75zy0=;
 b=IlmEamgfdI+tSppn6gbDrR4VXbi//mV8JuVpP7vSOwV/PYhj9uYQfcStYgmtHAI43j
 92Suzj1hAZ3rw6pJkFtTgoQA4lwgfyd29NVYBhBp675ucQ6G+J0sPIzjfuXs43Oh0Nh+
 UcDsgNtBrFJs2BnCwwl6dxVfM2rGx1AKIp9P5GyiNJeDjiIVlyMiHlxWHkMg92j65quf
 3N1jZOJw8J8MHXb4Rc49mNbilipgsnknpgkRfu1oJ/ZVzyqENhMtfbvsJo5KJYWhj9XJ
 dqBkmoyRnkuP4TtScmplhUN3VQX7qgWXBZIEX0hQ52hphXWjqxNwSFZPIdjI8klUUXdi
 1OQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+n7MRmYrqekgEv/zhKJinizfHnyIOwcfGi2gt7IAM1jV099RCQSWncnSnFt0C1quCuWYadWl+W/QlHr+UTSWV2ZnKwW0=
X-Gm-Message-State: AOJu0YzMseI3IQ1pLljfUydPiybg+n5dEw/iIyuwprZUJB1qTfatI5sa
 vjaQbTR2n9IOHEEA+jeu4Ae3cgQuQEyYi7WZc6kGgq7toYtDwi1sCL+gc24Z6KU=
X-Google-Smtp-Source: AGHT+IGlwkDjWiiho7njvEtmVj7KAbdgY0nmKrfpz6J9sfnYAfmb/6WKN82YNv9kewKEnXqSF8zF4A==
X-Received: by 2002:a17:902:d386:b0:1e2:c334:159 with SMTP id
 e6-20020a170902d38600b001e2c3340159mr8911222pld.22.1712594388489; 
 Mon, 08 Apr 2024 09:39:48 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001dd59b54f9fsm7334868pln.136.2024.04.08.09.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:39:48 -0700 (PDT)
Message-ID: <d610c2d2-3576-4ca2-a2b9-4f9a5390e3d3@linaro.org>
Date: Mon, 8 Apr 2024 06:39:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 3/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20240408083605.55238-1-philmd@linaro.org>
 <20240408083605.55238-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408083605.55238-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/7/24 22:36, Philippe Mathieu-Daudé wrote:
> nand_command() and nand_getio() don't check @offset points
> into the block, nor the available data length (s->iolen) is
> not negative.
> 
> In order to fix:
> 
> - check the offset is in range in nand_blk_load_NAND_PAGE_SIZE(),
> - do not set @iolen if blk_load() failed.

Do not set, or do not set to non-zero?  I had been wondering if the final assignment to 
s->iolen should go into nand_load_block as well...

> diff --git a/hw/block/nand.c b/hw/block/nand.c
> index 3627c799b5..d90dc965a1 100644
> --- a/hw/block/nand.c
> +++ b/hw/block/nand.c
> @@ -255,7 +255,9 @@ static int nand_load_block(NANDFlashState *s, int offset)
>   {
>       int iolen;
>   
> -    s->blk_load(s, s->addr, offset);
> +    if (!s->blk_load(s, s->addr, offset)) {
> +        return 0;
> +    }
>   
>       iolen = (1 << s->page_shift) - offset;
>       if (s->gnd) {
> @@ -780,6 +782,10 @@ static bool glue(nand_blk_load_, NAND_PAGE_SIZE)(NANDFlashState *s,
>           return false;
>       }
>   
> +    if (offset > NAND_PAGE_SIZE + OOB_SIZE) {
> +        return false;
> +    }
> +

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


