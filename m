Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5208AE9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSwX-0005oP-Qe; Tue, 17 Feb 2026 16:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSwW-0005nu-9F
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:49:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSwU-0000Lm-J7
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:49:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so52309805e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771364953; x=1771969753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=utvCkmsj+touOyQEV38XHtgIsDxYA9wU/Mp3NYCotBY=;
 b=WPy2r1c4174rm8Fd2XuH5YimkdIRo82YcxGFXKs34PZVKspCn1U/hLHHnXZe0zffm/
 C5NdwOmlTpUh8s+XncnHeTWXdC5y+2Gp4mneYoWOll20PEjzkjsItFAjoEwrdHQLMT0x
 n7kvPAC6+G6mb3wW0oTxUZGNQYp1uDHzPJF6YILJJaDg/L6XnqOWCQZk8bY6NG1zyNOh
 KKG/QzbSv8D9x94D92Uz0IjhuzG6uJv6wJwuPRqrK2ORPaFQ3Bqi5AfdNwfWdlWdTsJX
 hprVSZObPULYe+htzGEQlTPh67B6ekBlFPXzTrDRbYjdJbVxqCWdkMH+NZLeHUlHSEFu
 U7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771364953; x=1771969753;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=utvCkmsj+touOyQEV38XHtgIsDxYA9wU/Mp3NYCotBY=;
 b=EWT1h0RaGLOdkeMvwpbGtuzapdra3QLsaEyf9ZWzeqtAkWrYWM1VC6p1FNj1U/BdJx
 0d3xiyglIDhYAMfwHgRaU67AiI2rfnBoshthXYRp2vx1TxLdtVWWXDDo+ntcnZ6f1gja
 c4UV3oHWeAUg1w06BnzgtIy7Z47v5SIitBQ9eHkUOxb+X3Yfn7zejfWrZTgUsH8nyjxg
 aBpWZtVsYV6pR4ylt3Vo65tArh87E2s4WYIN7aowK9cbiI7TQ5b6s4jkvO/mVAD4yOmt
 jm+iD9lWSpCxaB5kLw+uM+mK4HS9xjTat0JNb/5dtDiZ6zAKDshMXcGHcb0iRyd9Quoq
 bxdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUqwMu9Yb2QuYBO5FlLkMTUn3f7RrskAMytndSznSIR25N+gbbaxNDeC5N0LTTr4wCNvnKxPARdN9z@nongnu.org
X-Gm-Message-State: AOJu0Yzxhmb/9a8N9VT+45RJ4+vJM39/V5cOOxJuFR1qlX5lofdbkPpV
 t0BIe/PVTfVKfTCkSa2+3tQhUbW/hxoRkYb86btaWlJmcoCcuaYODGEfqOUR1B38wl8=
X-Gm-Gg: AZuq6aIfdM0rVtlEpTm8t417S7o7oaM/ugX4bY7tdiP30CgHUVxMBOLWlnuekOkMblj
 AARMlYxP3/Ndof1CCxmYMzjMiFq1T9kX2C5lKEpJUS2X9BfZ4JIeThRjCFYO9erp+hF42pErwpZ
 sZ5IFiA87JUDFRWIj9dBRvCRfNC9FeTgX3cv7dOqtQpqe6vwvQWpR6gpMoAZZXx6uvcbUZgRL9H
 dgIKHkzCcieLUmmZt+qtVcLHDh7VhKQlKhn/l/vZNvKa806Ag9KGNUP52/z94MnI1YBWvdjVGI5
 0ghGDTJ0CUUpGC+YQ/u9InYzItKSamnG4+9WNJsRKTyr/aPPG+8dmLqGfdP4U8JBNDp9ah9z9S8
 Q1ZKmRrjmUCHI4DDzAlbRI2OEc+4tnDSQVxYZ2HOac+p8DBYYd3IG18+gbtgCR0gqIpxEnHLW1f
 kAkWsvw4eNnjaVIAXxN7gF0Nj8sRYTIrFBlT3eLfGuw76TDSG7Ch69y/gIkUI/xS1J9SRiwLXv9
 e0B
X-Received: by 2002:a05:600c:4f0e:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-48373a1029emr286784975e9.15.1771364952945; 
 Tue, 17 Feb 2026 13:49:12 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837a5d562esm248105335e9.15.2026.02.17.13.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:49:12 -0800 (PST)
Message-ID: <ed97732a-a626-41a8-80f1-f335dd459201@linaro.org>
Date: Tue, 17 Feb 2026 22:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] page-vary: Build migration_legacy_page_bits as
 common code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260217095106.598486-1-richard.henderson@linaro.org>
 <20260217095106.598486-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260217095106.598486-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/2/26 10:51, Richard Henderson wrote:
> Use target_info->page_bits_init to implement
> migration_legacy_page_bits.  Because this is the last
> function within the file, rename page-vary-target.c
> to page-vary-system.c and build once for system mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   page-vary-target.c => page-vary-system.c | 19 ++++++-------------
>   meson.build                              |  2 +-
>   2 files changed, 7 insertions(+), 14 deletions(-)
>   rename page-vary-target.c => page-vary-system.c (74%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

