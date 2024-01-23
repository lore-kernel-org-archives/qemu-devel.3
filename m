Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01129C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 21:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSOFX-0008V5-8y; Tue, 23 Jan 2024 16:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSOFN-0008UG-Ml
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 16:23:54 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSOFI-0006hy-AI
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 16:23:52 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6dbb003be79so4169867b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 13:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706045027; x=1706649827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LKS8HF1IzMzN3IpYc7t40qCt+rc8/FF/9zQ1oVgE2IA=;
 b=SwinIda5s8rC16zi7wOsos8i6Ovtuoia4IKhRNGs9DYATUQIdxJOPeMYDecd93XnZg
 1sve77LFp8pfAJyJFKGQjCbjUdST9aCSbBGfAaPiN3pL02Rye+EBteAVT2pT16tvkhu2
 wB+jRFYsocuZP43bbc+ND2TvoYJtJ5XAd2sj2p0xvpRWULNaDw4c3y4gJFIrI7qktZeQ
 WXGCE3kPFBviON0sCOjyEQk9jPrRNGk+PURj0Z+67Towh36P8rWBbBbypR9VuqYdZJ60
 Xh95M3w5NYe1+cvW/fTXVjcvaeHLjgScgh83zOZ0gwoEvRUECy6aI4AVxHKPvCWOyp1o
 d0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706045027; x=1706649827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LKS8HF1IzMzN3IpYc7t40qCt+rc8/FF/9zQ1oVgE2IA=;
 b=ZoN0+oVX5hwQ3s41oL2Hr5YHGd9vC0z9n3lnRVkV6Q/NAAuW7LlTccHu5TJKblxSd0
 iWuGiL6gmE/tRpDw94ew/5pcQuT7WSWzwxoPz4KHc7WQmcLs9K95uDdSb7mmlbwQCCY+
 Ie73qya+AiBaREd5hn0Ov1kbg0j1FOk1GjINGc6mNEzd/yUhnAbKVNkm7qmtrxbxxkis
 m8A01N5YK0RYl21mDH8ZST/R7OVDJU9pqNv7zd7zFeS8katqH3wFmmedLqi4sOXNyL3p
 gC+Tma41oSt7P2yIBP5g2M4/IFBZqNzkNeynuWVyAkgNNL+RZEES9NXDc57HFlv4pBKg
 3jNQ==
X-Gm-Message-State: AOJu0YyORg4jRCT7BWR9CnzVP1Jvw9qdBfa68I3nJb2Na8+RJ31VI25N
 b4XmUcnuTKJnfEnTsUi7RpcpkbySmrP9iNuaWWAx2XBdre9LOJOKY0qhti+pbBw=
X-Google-Smtp-Source: AGHT+IHRpx2kfw3LdTM25czFKiI2D+s+k/dVh32cWNDu47aUhvl+YXx+YCT5hXbr0OloOfujVmlgOQ==
X-Received: by 2002:a05:6a20:9f4f:b0:19b:46c7:c986 with SMTP id
 ml15-20020a056a209f4f00b0019b46c7c986mr304935pzb.16.1706045026709; 
 Tue, 23 Jan 2024 13:23:46 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a63cd0f000000b005ce6b79ab6asm10655125pgg.82.2024.01.23.13.23.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 13:23:46 -0800 (PST)
Message-ID: <1ba077ad-6959-4edd-b08a-24c5145c1c54@linaro.org>
Date: Wed, 24 Jan 2024 07:23:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] util/uri: Simplify the code, remove unused
 functions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-trivial@nongnu.org,
 qemu-block@nongnu.org
References: <20240123182247.432642-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123182247.432642-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 1/24/24 04:22, Thomas Huth wrote:
> Thomas Huth (4):
>    util/uri: Remove uri_string_unescape()
>    util/uri: Remove unused functions uri_resolve() and
>      uri_resolve_relative()
>    util/uri: Remove the uri_string_escape() function
>    util/uri: Remove unused macros ISA_RESERVED() and ISA_GEN_DELIM()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

