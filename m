Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF9ACD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAgA-0006rR-Sz; Wed, 13 May 2026 10:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAg5-0006r1-9m
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:35:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAg0-0006gO-Hh
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:35:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ae6a0e523so1408334f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778682906; x=1779287706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qO1n7RphMju9fZjwX/hUbU0/CzZWUlgxAPDLO8UYFO4=;
 b=Qtxtmt2gonS3MP9EU8c4nFw1SG1qulqkkpZFJCZDOIXmdi06uwhockqfgBPoT7Yuc0
 3FVeuAGBBT/ItumPAZCDD+iXPJ/+leNGEONUHlIVjefdmJuSxoI1en7qKFReyNqODtYG
 VX9OqRXy+/0jy2ZaWOlvCfQlgK0/lxDpmmXzrh9ihvyHS1KmhkB7TlKTUhmVbkhwxr98
 M+7w1ZtKdVqF4mn+VxEoquFrwqa1I5a/kcgiv1U4JVUfx/5yPKfCkAPwCJSO+jHov/fn
 6pQQPwlHchP3/rdxzKwGJGM02zygNRuPedi7E+VyP/hjoVy+BURAaf3fITPQSMJhmuj8
 H9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778682906; x=1779287706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qO1n7RphMju9fZjwX/hUbU0/CzZWUlgxAPDLO8UYFO4=;
 b=D26y4j/KJNy7LXDI+XrHZQr9v4m9nNkICoXkFMCPk5nk0KuG4nXhO5+h+eW/WcbP6X
 2bVoWYVAUfUoQQ4KiBbC91/kkJoF0trLZrQRU6etXc1vyAbTYbM0qzGDopEu3iRDXPc6
 OTlHuEHXsQaeA8ebvo0Yki5d72DN+9fB3gNYBU4e4BkUkuA0hVeP2yUem+AsUVg4Wl6t
 lq61jNVnNqxxPcHwDgbgglDmCM0U9u+MjIAP/ZfxoL9rO/DQmNT2qPHoj91aV6RNQdLs
 SlBZb2ugA9k0jKpzRB9N3kWlyiSgehaU40bXdcBFxNd3aVtiFlOziEvg9nk4PjKtosGj
 hH4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4OUfjLQJEjW6tvNMW9sT7hXKGLqLGmuO3djl1MvQFXLxZo6TiHi5332QwgcMTkgDBwl8Wnoh+DhJs@nongnu.org
X-Gm-Message-State: AOJu0Yw+h8Z4/i7dPE41Nn38xnrqyWMjBPpc7461tXvW9ra6GAY4Fjb9
 ZBSIje56JGEDDU0mT1d9UMYLTvN9UalCfJbW6qaYxLaqautdDLtivd4dzzRtJfsD1z8=
X-Gm-Gg: Acq92OFiFv1rneFKs9o7OLejc7vNdd3gqqiXMSZZvctkvyLt4+8UXk0pt1ECC+Zv7V2
 eDkQsVgHgTVZJqH//+uIEcAeXUTyt51XBhHtenHh6TdWQCdVClDgv1fZG783jPahSovpo+vSKio
 Xc4Z4e2QFt39+K1W4hbo/w6KGUWtrfsU05E4FW/VAJjsrtvAYNPWaGb7YhJlGhLc+nTqtxlOani
 jksMQxPecyUekRG7t+3lz0/CSx8vDn7jbHqqRNz6AB7572eLYea6thPXMCgh1+sJtSN6Pil9WG4
 p7TqLMBP0ZHuNwJ+iont1qLmC6q1LV9pVTej25FWaxokE/6nyISFL10zmcKmDWY/kdkXEqruLE7
 BYJqRjchaco7fNKuRchE+ZImcPHKsmKfxJRqfKm86hdycklFh2Gq2NUnP4yV2fnhzTVP+Vnyms6
 jzG6BmUUR12ZTH0SKFofX5Pq32cjugJxb51RIBYuLCgqXD6Wq4+B8lVRbb0RWcnOtpwg==
X-Received: by 2002:a05:600c:48a2:b0:489:1c5f:3a9e with SMTP id
 5b1f17b1804b1-48fcedbbd0dmr26073725e9.13.1778682905798; 
 Wed, 13 May 2026 07:35:05 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f445f83sm41062745e9.29.2026.05.13.07.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 07:35:05 -0700 (PDT)
Message-ID: <92c54e48-b580-497a-8fbf-0d2d4b6849d8@linaro.org>
Date: Wed, 13 May 2026 16:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] qom: fix ability to create objects without a
 parent
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
 <20260512122958.788097-9-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512122958.788097-9-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/5/26 14:29, Daniel P. Berrangé wrote:
> object_new_with_propv allowed id/parent to be optional, in which case
> the caller was expected to own the returned object. Unfortunately a
> trailing object_unref() meant that the returned object was already
> freed.
> 
> It is confusing to have a single method with two different ownership
> scenarios for the returned object.
> 
> Make id/parent mandatory in object_new_with_propv once more, and add
> a new object_new_with_propv_parentless that does not accept id/parent
> at all and lets the caller own the returned reference.
> 
> The helper method has abstracted the way properties are represented
> and set in order to facilitate the subsequent commit.
> 
> Unit tests are added to address the root cause that allowed the bug
> to slip through in commit 6134d752.
> 
> Fixes: 6134d7522e570a30d7f0d1e092ee37351c5183ed

Fixes: 6134d7522e5 ("qom: don't require user creatable objects to be 
registered")

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h            | 47 ++++++++++++++++++
>   qom/object.c                    | 74 +++++++++++++++++++++++----
>   tests/unit/check-qom-proplist.c | 88 ++++++++++++++++++++++++++++-----
>   3 files changed, 187 insertions(+), 22 deletions(-)

