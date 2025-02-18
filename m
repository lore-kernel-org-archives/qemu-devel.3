Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F0CC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 09:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJba-0004wC-8U; Tue, 18 Feb 2025 04:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkJbY-0004vw-Sd
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:09:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkJbX-00067G-50
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:09:24 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43964e79314so47611815e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 01:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739869761; x=1740474561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XtZ35Q9HXYGYqMuJlD0ubU1N+t7pPICndc/oTot9foY=;
 b=ig7j7Xr7dN6+YeNPqi0jCRSMcb92LraThj9d/k96UkY2xFi+bTZqt4bv8+xpNEux+Q
 2nwk9NYz3NzO5R6jYUcMQdX4Jmn+7rRell7Fk/Rsi5VB74vhe5uiSmhcSru28rGbx6Lv
 jBJIzmbet/Dtj2zAdQE7UBY2VpihzonPDk9jtUSHL3sWAt2M2hebZ/aDl/RziEEMMcRY
 qXnZJ8YydeQMRFMvzVPZlLdJ7csJYiZlosO+DZHa/cLlES/skXTsdCr7I7vVU0tXpsAe
 IYUlQCAJ6xQ6DAKqA9yONdkLLCX2qp76mEXu4fs52aMz2jJ6boQ7NKkBxkTJceGz6pz9
 R0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739869761; x=1740474561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XtZ35Q9HXYGYqMuJlD0ubU1N+t7pPICndc/oTot9foY=;
 b=t/4afRIPd/3+MfDWQfUNTAxG8zrkermHzomq6+3JXVl7Ap6YfhKzuvx5Ge/2qVkn6n
 CUnhdq+lMHQVpDEGQN026q/Z5Be2eJmpJJczNRiy7+yJKtSzHHDZNV6CA0jV9OYLW6c6
 OJdM7GitFZUd09SBABmrS9I2pVVeGkT4hpYnorOGICXPElquZ1lURFT5gmBjS/b54xdE
 BmGnw+FkdYO/JqOuvloT+5760tl8aVNatnkSH8WFJBJU2gBVeMYW/RRutAUfEyLE4AMC
 qLyoZy2Bjz9FbQFqWw8FT++OydqabbfsbgD8eaPfP8laR+pPZKMeeeekNAk7tsQL2No+
 D7Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkHQmv6vb9TC9C3ELHQroi68yn+oUzpJ4XBxPdOr+FQFWuqzLTZsp7qkUplcz6veSrLFcqzeG9SswB@nongnu.org
X-Gm-Message-State: AOJu0Yw+IAO+qgp37ou4bAgpnkcbzjX1TuHaOftNXhxB+M3r29ilN+JB
 McR3DP12Hj3tTa6NcTAvvD7huJyrwf1A30YOTDrWIVsZBqUuiR3ybFJKIAWtpfM=
X-Gm-Gg: ASbGncuW/XbWuNET2birtJFX3pY9e0BGnsO9x08E8UA4ZqSIt7AMbKebdpWXu2QDsU/
 tRruM2sNS1p6Q0gkg4rIjtmAj1Mla5Hu8/stVng1HbFRPVzbxVlPsM0KZZoj+CwnhWhIZWsDpWj
 92jjwOckBfJwuux8t0dNfaZkxwCwykrnbleux5yf+5HEwIdallabmwN6cRvnq0oHyY4yuXMgg6Y
 zsKqebAMaiEvKmTJWY6qVuwiSy9/1x0b2wCcy0GgYI0pjb0IVlRnFTRH5Q8b6Wbq/gamRuCKd9D
 ZaBtwMs9vheePTHxFuWMCWJmXUmYkx9gUd+y7rY8hB17Gl26W+T1YAYp7Wc=
X-Google-Smtp-Source: AGHT+IF7KuaKb1OXWfYidgO2vHMFry6rIIvGnkJhqu2/1yEv/lgxypCckJK5zU8Sgi07Lc/t018oaQ==
X-Received: by 2002:a05:600c:1c9e:b0:439:88bb:d013 with SMTP id
 5b1f17b1804b1-43988bbd395mr51870515e9.7.1739869761223; 
 Tue, 18 Feb 2025 01:09:21 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43986320899sm46802175e9.38.2025.02.18.01.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 01:09:20 -0800 (PST)
Message-ID: <b92a2d72-7cbb-4a70-ad73-0af8150c0a8f@linaro.org>
Date: Tue, 18 Feb 2025 10:09:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: rust: fix typos
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250218080458.426402-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250218080458.426402-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 18/2/25 09:04, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/rust.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


>   By conventions, procedural macros are split in two functions, one
> -returning ``Result<proc_macro2::TokenStream, MacroError>` with the body of
> +returning ``Result<proc_macro2::TokenStream, MacroError>`` with the body of

Isn't sphinx supposed to warn for such error?

