Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48679C47DA9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 06:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTyzJ-0004Ri-J2; Sun, 28 Jan 2024 01:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTyzH-0004Px-AT
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 01:49:52 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTyzE-0007wk-VQ
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 01:49:50 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cf450eba00so1797369a12.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 22:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706424587; x=1707029387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eo6kJMxU5o1LNw4YmzyHnxQq+8llwHzhpgYGCIu5R+c=;
 b=RmcoHCggIcBK+n2b/MW2906gOtyG/Jxvt/j8ZomzvZ7Z1sbbdsfnAFKQmPTBRwl63O
 rkVVfSTdY2nVzHrff6HuwIMY52p0hmhzrGuQ2/c2ldhJdOOS3ET2lIulKDAINFVBkfp5
 iDC4iK9b42LzA1P1spzO4rQ41YnyS3HbIV3ti6B7/L/S1Xe7iymIpdc1JrHiq6lGZUdE
 mlmBLAlVKQT8s2r52h+l5Vtewn0j09ibPiJB+8eaE70rQNK3o8ANcLRkCaGaPygZ8tet
 dIlivbcGAWkXYy+ONKf6UJzfcO7dkEN5KYQ0SGptJ0YQTItpZev3LvfLzy3MY39L7FvM
 BT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706424587; x=1707029387;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eo6kJMxU5o1LNw4YmzyHnxQq+8llwHzhpgYGCIu5R+c=;
 b=B1F1a2I0t/iJ/Q61VNmkO3su8KAyvn/aSi4TTx3eIdaAfI0c1ejD/CA0KUCgASK0TR
 NrxCKEe1P+dFdVg3uhjWYLf0UYD8Od7m0BB4Kdv6cB13zM0k/AiSXfiKH2s5dLnWT9Zf
 wUHkJ1yHdqdIhR/LwBSTTSu+qIKRQzOKZJ5n+zvYEaUZ+e+cs/cM4MYx9+HnQeFT4r4a
 n6cj2pFL7Ld02YANyTTS/kFL4N8BOeXRomN4VpY++HWY1HAzxkM6uQG9yOhQMj/YLo9W
 +12Z8kV035XwXTfcGzRNkkASvyYm7Ec4Fn3fCaE3kzfnvYizyJG7NiyjT9e0cphLZG/g
 Ycrw==
X-Gm-Message-State: AOJu0YzLaVG9iKqiaytJiIxKgkPFJuZVKRSFmrlZ6Tp1Q2pudw/Gu597
 r10xAMFbeI/gZpRNk6e6r9TVmqSuvfBVyexC493ttXm7ypid5aEnjvjJ9W/SHG0xwgKBaJL8Nid
 5COc=
X-Google-Smtp-Source: AGHT+IE1oNu9DeYzvR+a/LMUqAVY6+MbZNplnHa1vkvL5ef38ggE5N3MS879DfHZDP1VO1O7HXnTaA==
X-Received: by 2002:a05:6a20:bc85:b0:19c:a2aa:67f8 with SMTP id
 fx5-20020a056a20bc8500b0019ca2aa67f8mr1191350pzb.24.1706424587303; 
 Sat, 27 Jan 2024 22:49:47 -0800 (PST)
Received: from [192.168.198.227]
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 k130-20020a636f88000000b005d32c807296sm3765481pgc.68.2024.01.27.22.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 22:49:46 -0800 (PST)
Message-ID: <a96a571b-55b7-46b4-a793-bb405ef10467@linaro.org>
Date: Sun, 28 Jan 2024 16:49:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] target/sparc: floating-point cleanup
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231103173841.33651-1-richard.henderson@linaro.org>
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 11/4/23 03:38, Richard Henderson wrote:
> Major changes:
> 
> (1) Get rid of the env->qt[01] temporaries and use TCGv_i128 for float128.
> (2) Perform ieee exception check within the helpers, before any writeback
>      to the floating point registers.
> (3) Split env->fsr into pieces to simplify update, especially compares.
> 
> 
> r~
> 
> 
> Based-on: 20231101041132.174501-1-richard.henderson@linaro.org
> ("[PATCH v2 00/21] target/sparc: Cleanup condition codes etc")

Ping.

Prerequisites are upstream, and it rebases cleanly on master.
For reference,

   https://gitlab.com/rth7680/qemu/-/commits/tgt-sparc-fp


r~

> 
> 
> Richard Henderson (22):
>    target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for ASI_M_BCOPY
>    target/sparc: Use tcg_gen_qemu_{ld,st}_i128 for ASI_M_BFILL
>    target/sparc: Remove gen_dest_fpr_F
>    target/sparc: Introduce gen_{load,store}_fpr_Q
>    target/sparc: Inline FNEG, FABS
>    target/sparc: Use i128 for FSQRTq
>    target/sparc: Use i128 for FADDq, FSUBq, FMULq, FDIVq
>    target/sparc: Use i128 for FqTOs, FqTOi
>    target/sparc: Use i128 for FqTOd, FqTOx
>    target/sparc: Use i128 for FCMPq, FCMPEq
>    target/sparc: Use i128 for FsTOq, FiTOq
>    target/sparc: Use i128 for FdTOq, FxTOq
>    target/sparc: Use i128 for Fdmulq
>    target/sparc: Remove qt0, qt1 temporaries
>    target/sparc: Introduce cpu_get_fsr, cpu_put_fsr
>    target/split: Split ver from env->fsr
>    target/sparc: Clear cexc and ftt in do_check_ieee_exceptions
>    target/sparc: Merge check_ieee_exceptions with FPop helpers
>    target/sparc: Split cexc and ftt from env->fsr
>    target/sparc: Remove cpu_fsr
>    target/sparc: Split fcc out of env->fsr
>    target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK
> 
>   target/sparc/cpu.h          |  39 +-
>   target/sparc/helper.h       | 116 ++----
>   linux-user/sparc/cpu_loop.c |   2 +-
>   linux-user/sparc/signal.c   |  14 +-
>   target/sparc/cpu.c          |  32 +-
>   target/sparc/fop_helper.c   | 510 +++++++++++++----------
>   target/sparc/gdbstub.c      |   8 +-
>   target/sparc/ldst_helper.c  |   3 -
>   target/sparc/machine.c      |  38 +-
>   target/sparc/translate.c    | 799 ++++++++++++------------------------
>   10 files changed, 680 insertions(+), 881 deletions(-)
> 


