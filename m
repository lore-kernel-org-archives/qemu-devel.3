Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06320CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHK0b-0001kH-Gu; Fri, 07 Nov 2025 05:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vHK0Z-0001k5-Ao
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:47:55 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vHK0X-0007Af-9m
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:47:55 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b728a43e410so129745666b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 02:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762512471; x=1763117271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CJuuhavDSYmR6sdINnL0eQumxUohYj0y7rw1W1vxE1A=;
 b=hYRTxY+7TeXilLr7ymzgtR5KlHZfb9QJBD1KJd54zSO7oeLhYFN5lHwOIQ77aLF4E/
 pWpxezx+PfisNBw9/3w2+lG1hrCdWaWZsv8J/6kqK6Ypr8y/PASE/KlV6MvWPIYmK7yb
 Ni9tQn2Ch6lc3ftZmeGG6Ng4UdJIAaMnlL07zIlDj4nO4DckWxZvOz36CcJh+JUMj0Gl
 h004VdQiVs2omoeUcR/MIOvmKckoNlHNwYHhRA9cZGvgOons5LxYVImOulUKW4PNmN3Q
 a6HZfzW0Js3A3K9a3jXa7X/RY+VSyqmLvxGVCCScfzWWonpH9G/EF9Yag/b2GD3DM5Dc
 UZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762512471; x=1763117271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJuuhavDSYmR6sdINnL0eQumxUohYj0y7rw1W1vxE1A=;
 b=JEc0B3xGvXqk8ZhpmouB1cfjtvKORznr4o+W1pAo83EaEyscCp8q4E4M/1cdQZ/i0J
 fIexErM1d/MGNsXRmaiHEXzYcy3gWmNzRXGvSQ+K4ATdq61fQVdSFcV9WKcdu9DNvD11
 OEz8kjsviIjnUE0UnlgH2yxvnEzS+16OAqixCV5zZgkKt0H46dn6cbbP8UrhYGG4yL4p
 I9jXQu255x8Dw34rrvEl/YvWvlOMpIA8wULX0q36uFsuCqIzldHI/rcc37hl18zT2vtB
 6HOifo/Yb9ECga2cpQcgUTsv3aeARPsVfKdmPUFOcfLMw1rVSjH+72O1Yt/zwMUDSxJh
 n3Yw==
X-Gm-Message-State: AOJu0YwuYppx40AbSpxt89xweUB6lFif79ISI8PAUNBT5bL2e35CKEZ1
 HRKFukaYvFYisy4/Au2oBwk021SBeSTAvWc8ik3vSiMJNqw81VMJ056AyexPsxPWJxDtYBB8G6k
 HPJCY
X-Gm-Gg: ASbGncsmTvmIrV45Fcdsxg3LKwSVMfCCznbxz/7Wvn47aoxkhq34SdHTMsRcQQpK57E
 VzDugWQ73oPqooZSakLFrxVODmjYutH4sWuQneTWxmncYvSSkrl7eJIVtLikjkcK16j8B1HK/G4
 g604ck0iJqQr7alYuu3U01k9sVzdNgSsbGCaIe2Rasu6EfPh74dyhd4E0roYn/aaz0kjBBtMb46
 vFe+peIU41kBlEZI0FG+NrYQ8iSmwSctfHAc3VOyZUJ08LCCKA1E4H0zXXT7EvbZePo2rQ6aZVB
 wQCciFBXVSbvPvdnns+iEz9/0j1JhenVtINC1QYyPoEVHR/l/0WG8mS+8iAk/DWbSrDa6ptKs8U
 S9XLgEpMiQ6C7If+Vq0pTXFfPUq8Us8VZV14iu2pj3Ju9TrTj0LsblbcIrIng1gvVPcEoT8ZTCH
 qScnbJIOUIsX6pjJ52ubY7+Fex2FaEI80LlUFyAplVbDmL1nc=
X-Google-Smtp-Source: AGHT+IE6ioHguIeRNdxHA9OMSVijcR/8ty6y8YZ/OCpo0qYQgtJNWMEvPL3m9VW3VSOlhRvIKKdSWg==
X-Received: by 2002:a17:907:971b:b0:b4a:ed12:ce51 with SMTP id
 a640c23a62f3a-b72c096d5b2mr247507066b.23.1762512470761; 
 Fri, 07 Nov 2025 02:47:50 -0800 (PST)
Received: from [10.138.103.228] (31-161-187-132.mobile.kpn.net.
 [31.161.187.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf97e606sm206867266b.38.2025.11.07.02.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Nov 2025 02:47:50 -0800 (PST)
Message-ID: <8b0761c6-1d83-4068-bf94-caa671bfc1ab@linaro.org>
Date: Fri, 7 Nov 2025 11:47:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about/emulation: update assets for uftrace plugin
 documentation
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251027085808.2306054-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251027085808.2306054-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ej1-x633.google.com
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

On 2025-10-27 09:58, Pierrick Bouvier wrote:
> Linaro is discontinuing its fileserver service by end of the year.
> Migrate assets to GitHub.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/about/emulation.rst | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 8a5e128f677..320443bfe61 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -886,24 +886,24 @@ As an example, we can trace qemu itself running git::
>       $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
>   
>   For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
> -<https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz>`_.
> +<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
>   Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
>   using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
>   Some sequences taken from this trace:
>   
>   - Loading program and its interpreter
>   
> -.. image:: https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
>      :height: 200px
>   
>   - open syscall
>   
> -.. image:: https://fileserver.linaro.org/s/rsXPTeZZPza4PcE/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
>      :height: 200px
>   
>   - TB creation
>   
> -.. image:: https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
>      :height: 200px
>   
>   It's usually better to use ``uftrace record`` directly. However, tracing
> @@ -916,7 +916,7 @@ Example system trace
>   
>   A full trace example (chrome trace, from instructions below) generated from a
>   system boot can be found `here
> -<https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz>`_.
> +<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
>   Download it and open this trace on https://ui.perfetto.dev/. You can see code
>   executed for all privilege levels, and zoom in/out using
>   :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
> @@ -924,27 +924,27 @@ taken from this trace:
>   
>   - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
>   
> -.. image:: https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
>      :height: 200px
>   
>   - U-boot initialization (until code relocation, after which we can't track it)
>   
> -.. image:: https://fileserver.linaro.org/s/LKTgsXNZFi5GFNC/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
>      :height: 200px
>   
>   - Stat and open syscalls in kernel
>   
> -.. image:: https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
>      :height: 200px
>   
>   - Timer interrupt
>   
> -.. image:: https://fileserver.linaro.org/s/TM5yobYzJtP7P3C/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
>      :height: 200px
>   
>   - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
>   
> -.. image:: https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview
> +.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
>      :height: 200px
>   
>   Build and run system example

Polite ping for this simple patch.

It would be nice to be able to integrate this in current release, as 
fileserver.linaro.org will be discontinued before end of year, thus 
breaking documentation for release branch.

I will be out of office next 3 weeks, so won't be able to ping another time.

Regards,
Pierrick

