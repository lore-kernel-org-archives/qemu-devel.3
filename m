Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99CEC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 01:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trS0o-0001hs-L8; Sun, 09 Mar 2025 21:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trS0n-0001ha-7v
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:32:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trS0l-00077C-Cq
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 21:32:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso3050161f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 18:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741570374; x=1742175174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0ArSvTLunJnE5j6HgKsqPuX9CFb+vUZOMytUPOn3Iss=;
 b=QpBDTwMyPJvkG0dxaVgtpeey3biw39wAYHkOkG+cR8VOLPadML+eEVxiSLXf7d7B0T
 vLky3tq+aqoOkdMyu4Zh0UTT4fGPSxV2H55zjl0jsnanyOEK6HkkVCm8tupU+hWXaSH9
 F5P6t+GIm1ImuLRZ5A4YCF+sTFbebPJH4A9zPcEF9aHUuuSnufEqvpCKNrcUi6ALQHd5
 Iw2OQxXQ2EnF8jmeJXqfdVbMOH5TCkN19XmQ4XmVNyuxcXa96b5NccddNIFzD05QVSaH
 4OXguv4rLtsgPrqlFc51QV/sDBBEg1L3ecdnYGUiv09W7YPKl0ToNBeoBcwvgIAhYxTP
 rbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741570374; x=1742175174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ArSvTLunJnE5j6HgKsqPuX9CFb+vUZOMytUPOn3Iss=;
 b=pxVP/MsUqiFpPznYkkltyjm1ymDT78vbt7kyNtOo3Wk8zyQDxCX/9myI0pul4gqLbw
 lzncvrNk9vO3Hp5ReZb/Mz8at2vN6R8CNBYtHx2zwTER1C9YmLHCyxexwXa/lvF2A75g
 iYLXx1V/uc4gsOWRgqOmYom6VdNFHaBUC4p/qkFJIwZxi/iIgOkwqvfszjicDjRY2zUN
 SxjcEAKWh+ML7IrWemk8TQNfmqZaRT/fHYLyglG5X9jOcUVtuwxDtuKujFVRtJcp/JMb
 vwwy+gg0L2S4Y8vkNWpbtt/7Tpw9tugifZbkKZuAlj09W0Z4mn4jO1QZ7hQDDnx6if33
 hUbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb1EwZbxjtD1pdXPys3ed+O5m8MsoIw1zHUkfuqsz35MOhauQ8OmKb321RWEEKLQXIN9WxDDogeyqe@nongnu.org
X-Gm-Message-State: AOJu0YxlVHwWj6VQFQECymOMmek5VBpxrie/Hax9MzkfYQ6bbefj11rE
 UZ8HPPUsp2hO6y3rliIWwrGvQOkhThtBriaoGp0Vva7AXhVTiUIYJrDvXLJt6Z8=
X-Gm-Gg: ASbGncu2EtuTHHv9yyWkmwrm4FZ6a8Ykaj7e1KDkrNZmd9o+Vf78nc2h46xlSCRIHOb
 foQbImWVmnMFlP4M+eLgcga5hjTAu+AekrH7uEVHFC9SrH5y/9tAS7IflzaflHeQXaIz9hOGADK
 978IdlX6uA35IpirPo62FHJMScfMdxCbNAlE9TtEidx4xXeayH7wTcENrbGAVATbeBqQLc8cL0g
 4lxmW0cWGXr3z8PQc6ckGBL2rjQnndX8OK0z1YVqHhQL0sz1aVhm0PpTu6+15TCGs/c472Wlbol
 pKIidl/uZ9bhh7QCETr0Kd0A0Lz52wX7bdHqs6MJhTp3BJwN99WZ620fGZHPcfekslZ5vPdGB6S
 VopbxYFHG9GTz
X-Google-Smtp-Source: AGHT+IHh5nOPKuieTzaL9st8eTrgb3ByS8oesfR7d7LRS7/caxbZXPcsT7y6Qt3BQFFEtsn8E/z3ow==
X-Received: by 2002:a05:6000:400b:b0:390:f0ff:2c10 with SMTP id
 ffacd0b85a97d-3913af2de2amr4007293f8f.19.1741570373901; 
 Sun, 09 Mar 2025 18:32:53 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfdc5sm13058383f8f.25.2025.03.09.18.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 18:32:52 -0700 (PDT)
Message-ID: <b840c852-a33b-4243-934c-794053c55b6b@linaro.org>
Date: Mon, 10 Mar 2025 02:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/smc91c111: Don't allow data register access to
 overrun buffer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20250228191652.1957208-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250228191652.1957208-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 28/2/25 20:16, Peter Maydell wrote:
> For accesses to the 91c111 data register, the address within the
> packet's data frame is determined by a combination of the pointer
> register and the offset used to access the data register, so that you
> can access data at effectively wider than byte width.  The pointer
> register's pointer field is 11 bits wide, which is exactly the size
> to index a 2048-byte data frame.
> 
> We weren't quite getting the logic right for ensuring that we end up
> with a pointer value to use in the s->data[][] array that isn't out
> of bounds:
> 
>   * we correctly mask when getting the initial pointer value
>   * for the "autoincrement the pointer register" case, we
>     correctly mask after adding 1 so that the pointer register
>     wraps back around at the 2048 byte mark
>   * but for the non-autoincrement case where we have to add the
>     low 2 bits of the data register offset, we don't account
>     for the possibility that the pointer register is 0x7ff
>     and the addition should wrap
> 
> Fix this bug by factoring out the "get the p value to use as an array
> index" into a function, making it use FIELD macro names rather than
> hard-coded constants, and having a utility function that does "add a
> value and wrap it" that we can use both for the "autoincrement" and
> "add the offset bits" codepaths.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2758
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: 20250228174802.1945417-1-peter.maydell@linaro.org
> ("hw/net/smc91c111: Fix potential array overflows")
> 
> I'd only just sent the other smc91c111 patchset when I found
> another fuzzer bug for it in the bug tracker :-)
> 
> The "modernisation" of the code seemed clearer to me than
> doing a minimal in-place fix (which would look something
> like "p = (p + (offset & 3) & 0x7ff;" in both read and write
> functions). But it does make the actual bugfix a little less
> obvious.
> 
> ---
>   hw/net/smc91c111.c | 65 +++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 53 insertions(+), 12 deletions(-)
Well clean, thanks.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


