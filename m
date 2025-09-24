Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF128CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1SXv-0005sL-Jk; Wed, 24 Sep 2025 12:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1SXi-0005nF-1a
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:40:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1SXZ-0000RP-40
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:40:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e317bc647so3710075e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758732017; x=1759336817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gu6yUgiVh9d5U81j9Y3EUC7hWTF1x0xYVkxXp3FokLU=;
 b=KWAt+biJKWUKQA6KtM7xQcQ7jfWBtMcMg8ufZcnTEOV6y+28TjhvyNaxvTdFcs7mWy
 WlOI6p6/b2bPp3IwBcft7q0uY59Ud+HuMaD1CljshVaivTII20b9qDDV2jepOsjQvh/p
 CRndUnk/MEMhHr1j2jRyZU9Mv20oQ5uXy0Q5UTij5yNXoZfH2luZevdEljXtV8nRlSD0
 aiSeMsmoN1toupQtV0aZUXwiYJer2by6SimHYlesabmVZo1uVOpmeMlXhkQP93MwTX5+
 lGc3HziWykntGfpO1gXy5RIm356oBvyCWwQleDdkmb+qI4cK3GxBnikAk3hL79Ac90L8
 brtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732017; x=1759336817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gu6yUgiVh9d5U81j9Y3EUC7hWTF1x0xYVkxXp3FokLU=;
 b=UygoWuuGSQjLlaXe7SZLCFbc96gWUXUyg89n8wZHRAUQudwgD13ZbAKORnFWbxUsh8
 cAVCNV9/7TRuSq1UaGwVtiJ84SEI7BQMXFDTF8JprlG19UMa9F3diHs4G3jYlNWGHIia
 OGadw/Tk/6xDM1rHgEUtRQ+a+TQZDKV7GGdkV0mOXS5HdVGVCXoPliUHQ1MMD7jayGfV
 SLu4+vTdSmfzaWccPUrODw2ypLD4JUmCZhfMLfwjjnoTOi1T0mcnJmmnrli4gE1VuWp0
 OGu2RC7gQ14WVjbqhnvQHwl2yi/EZe60Du9rCgTiH4cGmTAvc1f5bcpX3cwE3UURqSin
 0PYw==
X-Gm-Message-State: AOJu0Yx1dYATp4sA4OEH/BqAuFg5JAhC/oefYXbZQRYZBtgZ5VKm1RiL
 SSHo0BQV2dCPcOjgmuFglLZ8HhSuJgunmRn7Mp3qiPP4vVOFnG4XMGZbQDCq7i7lxTBEv4rfLg4
 wzx+qEBvqdtkU
X-Gm-Gg: ASbGncuO8s/bB6RfV2uHrAA0kvWlZ6POHIJX0m47HpjfAGbAD1XHQjPkGAi+9vcFe/h
 sErpi6lUt3BxCi97UoMV5uIM95s+EXUsyVS7niTLIOl9LzhC52p64OtJDzBRc2pimzgQGUGBUiF
 lyv45M/JfLhq5bb70znVuWfqJkfML+Q2s19L9Az+rpMa6ssI62cwsz4lAYIc4NFuodQqu2sIn1W
 2S988lKAF27uEV3vy1MuQVJJ+kuDEJpuhkMEJgm0Ap1HMtT4x+OnyaiUvKonbnMPMr2/be+4kkw
 QFcIFHQK5zqFNKSvjkKvGabiOA0/b6Tums5wkq5mWJnoWkBTMZF2hMqgzVzQE/cubn3qLJXlSuf
 zMJmhBs0bKm8gLXICRKpAcyxIw2vFho69J1cGuPCGxR43dRbOCiF4yfXlv7J1DNoCTQ==
X-Google-Smtp-Source: AGHT+IGbRnDibNupntsRWTL9/Xpllt7LcnVbncFcVKCBgEPCflFms08wu+bTXhsDsXDvysmZohpFEg==
X-Received: by 2002:a05:600c:5297:b0:465:a51d:ab with SMTP id
 5b1f17b1804b1-46e329bbf5amr5447735e9.15.1758732017098; 
 Wed, 24 Sep 2025 09:40:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f70b47ca57sm18186683f8f.0.2025.09.24.09.40.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 09:40:16 -0700 (PDT)
Message-ID: <2891f8d5-e4ea-433f-84ba-a878875bb4d6@linaro.org>
Date: Wed, 24 Sep 2025 18:40:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch: Avoid recommending legacy
 qemu_bh_new_guarded()
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20250924163911.51479-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924163911.51479-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

(forgot to Cc qemu-block@nongnu.org)

On 24/9/25 18:39, Philippe Mathieu-Daudé wrote:
> qemu_bh_new_guarded() is considered legacy since commit 9c86c97f12c
> ("async: Add an optional reentrancy guard to the BH API"); recommend
> the new API: aio_bh_new_guarded().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   scripts/checkpatch.pl | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 91616c974f2..6a0c06bebb9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3197,9 +3197,9 @@ sub process {
>   		if ($line =~ /\bsignal\s*\(/ && !($line =~ /SIG_(?:IGN|DFL)/)) {
>   			ERROR("use sigaction to establish signal handlers; signal is not portable\n" . $herecurr);
>   		}
> -# recommend qemu_bh_new_guarded instead of qemu_bh_new
> -        if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\bqemu_bh_new\s*\(/) {
> -			ERROR("use qemu_bh_new_guarded() instead of qemu_bh_new() to avoid reentrancy problems\n" . $herecurr);
> +# recommend aio_bh_new_guarded instead of legacy qemu_bh_new / qemu_bh_new_guarded
> +        if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\bqemu_bh_new(_guarded)?\s*\(/) {
> +			ERROR("use aio_bh_new_guarded() instead of qemu_bh_new*() to avoid reentrancy problems\n" . $herecurr);
>   		}
>   # recommend aio_bh_new_guarded instead of aio_bh_new
>           if ($realfile =~ /.*\/hw\/.*/ && $line =~ /\baio_bh_new\s*\(/) {


