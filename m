Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A38C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 03:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSED-0005UP-6j; Tue, 23 Jul 2024 22:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSEA-0005Ij-FF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:59:42 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSE8-0001od-S8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:59:42 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7a0c6ab3354so434714a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 19:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721789979; x=1722394779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vVwBeClorWq8ecMprQH8lqbKjMBAmwiFLMaETwaAYgA=;
 b=QBtV8+8RvuG/DX+m2aokH+4q1GbzQ9IHQ71K6DsVMiGHBlLpXO780vQvELXTzHU6Rs
 ZuHYdKyiUS8vCvs3INiwqY7RVVanJp7alRkFYWOF1bsLuNrBKCvBkcXKDIj6yVWiDyL8
 HoydwsCuFOymskZ3Xxuvpa5d5NWDJi50FeLrL3RItQgaLFV9QZD7AY7LcTi62XkMGENS
 cgUwibV13qXinquRcXSfu5mExiv5QVfEknKJ/MRWKEmRQvSKu2ZB+fRzRyqVrH4GkxFd
 SSPw474jRuUf7kkIBwEiW9+wMdlupQearR1p5kbC/S2OW2Fa2McAtgNuYM484ZPbvn0F
 tlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721789979; x=1722394779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vVwBeClorWq8ecMprQH8lqbKjMBAmwiFLMaETwaAYgA=;
 b=Ch8eaZ/5VCuXGAUrjV2/TAMxx0bYCMep4EXnlmz2i+MzjViTNwtFKDNguAMharG+S3
 0xkra21AsMrNKQouHlMMrTS0zcnmAPH6B2iefBUTcrXMhP58ShaavcgGT20ySAVj5OjQ
 LNX0ucVt0xnpaqcHgmVEr8RSPZsAMDVIBfV6uIADYRy93Aj+MFd6aXu/jrQNl2EfALq6
 lOhsiDe4fXcqemifQSoTVziq7BlLI8OAJO1xNYe0Tns3SnXpCcCoNT80eKCKHPfyHtRR
 6nmOGAza0VW2T3A4K00BtHfN8caZORkd/U42f8b4f5EoPKaC/Dj9/bwA1X6b6b59HEyj
 /OlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaYAdY5e12Vp4lUjS/CNg8SE7NlPlXHc+71/68uSAKJJsyf3OATNEpFbMeZA5NhIKCb8ZAOPDymQzdlZoP0CEODwP4J40=
X-Gm-Message-State: AOJu0YyeBej4mV8Vvnv16c8gPT1zEDuMKY9DDRiUYtNStKIRZnN4Mq33
 m2t+GuLuxoplYvQbaUtZ4Na5Xde4yVbbVPmpNFm0OF1cfKA7E7PYV1JudRFjp7w=
X-Google-Smtp-Source: AGHT+IGsvLUmUYj0wWlPsXFxUvis+QheZNR81WG4MLcX5jlj4+2Tw94zDAGQC8KCdC0P5NbAGEF6xg==
X-Received: by 2002:a17:902:ec90:b0:1fd:9238:40f with SMTP id
 d9443c01a7336-1fd9238072amr84246655ad.22.1721789979224; 
 Tue, 23 Jul 2024 19:59:39 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f4318f2sm82133885ad.190.2024.07.23.19.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 19:59:38 -0700 (PDT)
Message-ID: <9b5d9604-096f-41b7-8a95-48bdbfb0be3a@linaro.org>
Date: Wed, 24 Jul 2024 12:59:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Fix helper_lddir() a CID
 INTEGER_OVERFLOW issue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 lixianglai@loongson.cn, maobibo@loongson.cn
Cc: peter.maydell@linaro.org, philmd@redhat.com
References: <20240724015853.1317396-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240724015853.1317396-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 7/24/24 11:58, Song Gao wrote:
> When the lddir level is 4 and the base is a HugePage, we may try to put value 4
> into a field in the TLBENTRY that is only 2 bits wide.
> 
> Fixes: Coverity CID 1547717
> Fixes: 9c70db9a43388 ("target/loongarch: Fix tlb huge page loading issue")
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

