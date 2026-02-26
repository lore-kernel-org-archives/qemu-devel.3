Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288D1FD8FD7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vveUe-0004rv-Vb; Thu, 26 Feb 2026 11:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vveUb-0004rW-F3
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:45:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vveUZ-0003Rp-7c
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:45:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so13459225e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 08:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772124331; x=1772729131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PrMfFphaiP4Q7DRoDXeIcRwJx9e31eeEatDkF6+jABg=;
 b=xr+j0tPU5vIvblzIIBjVkGuiRWh+V+LzSwCnj6uRCc0WzP0RTuoYqlXIBO/W1WLFAS
 yTDfEEzn6EUiyXhSoEL8WtTDF12dxu1e0ng31Z+nL39rDHLmmMkgKowJtT4ilND1yAUz
 PWPBw1kBsiFG1W4ChrYDkscRACJs/n1f8CAnj6oKMrI0Dsh+FKkwU9qNqIp8OYq/ACkV
 h1q4BVnzqaG95cOg3P3jdnRX3jgOXboJUHIxgVEYj2g4JFaYXm702Ub8OHi3pCWNrWyN
 A4lBrw8xR3TpsnYXFknBF3PN/xciHjvkRBKhlu6HKBAAwqhYBAs/LLMkmSMLr47qvwUp
 KxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124331; x=1772729131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PrMfFphaiP4Q7DRoDXeIcRwJx9e31eeEatDkF6+jABg=;
 b=o332YvGriM6pILjXPnt9Hx39yujU1UUcRmdiHxQWGVhaP6sRF0wUJiBKqRyN2Tgeoj
 8ukLjJBOXV2KUqXN92mrD0PtSfqW44Z/iIpNicshVlD3jYJtRt94+AgIJbxuOi5+/Tjk
 qpdcHyNwYxTucEoejff517tB0bYBVlkjl5TGICKWBDHdr5mCjCceFE2McvSAfugbYyUi
 tk5qfwLmQX66e/L8x4bewM+JS12H6oKGGh6ctXQfU3N5DBOeaigypLRk+ZMvjuYJjiZ5
 Lx3nn34Di2Dkjw4Wz9q5GorV3HpraMWbEQcrlYDEOR1F3bevGad0jWebDtWBIF/k6X1M
 RZAQ==
X-Gm-Message-State: AOJu0YxdkK8FulfKDoWIYvHu/k5M4cWfPkz3F0YzIwnrruvUvAGQPiJ3
 2Z6GLIlMarg0EJOPy5eE+01g8FKLQ7dipKH+85TnoDnkXr1gAWbSxCb/bKd4Qpta8yIgkOukly1
 yjPqqmbo=
X-Gm-Gg: ATEYQzxQqeffq9IOisv/AjtNI3UCzLgG3wpY3WupHXx7JsKfTpoLeu/61AI4FyGB4MU
 vrVCIfRZwA1QOZzFvb6kLOGXErULjoN5UU2CQF2MxarI5XKB5oc5gXpNv4MnKQQmzUODy59Auql
 u2r4b1joFjM2uF1Gcep36MlYsV7yTLpy0IcL2hA9Kb7vis7vQmipine6239RyvodiCnsQi4IuuM
 29uUi1G2rX/n5pg3tIPK15cFNIhY7wMTpYPVwaukdYo6aVqUUBuKCq3znOzy4ap77Rlitep57uc
 Onckb/opYsVrzWUyNBQvAJW8AXaHDApzVFm7tEyt7Tejm/lspm8OmTga+FhvPTOWPaVJKhCbkoa
 2LgL0kgTD/ULONktsHG2hVd5OhGFPHJh26lbcQgENJE91qubIxu9GHyxSLS6PvOn6UywxHF1HXi
 UixGfRo8hdYWyki61WFZsYjOPiI/se2iyBj7uG5MCYZYB5uda8QgJYwnXeHKQ9yFBIVkQyUNelW
 3YF
X-Received: by 2002:a05:600c:8287:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483a95e205emr321849715e9.22.1772124331517; 
 Thu, 26 Feb 2026 08:45:31 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70f50esm618332f8f.13.2026.02.26.08.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 08:45:30 -0800 (PST)
Message-ID: <982a1207-b808-4a04-abcc-e71ba695b61f@linaro.org>
Date: Thu, 26 Feb 2026 17:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Build stubs once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260225044225.64059-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225044225.64059-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/2/26 05:42, Philippe Mathieu-Daudé wrote:
> Move stubs to the global stub_ss[] source set. These files
> are now built once for all binaries, instead of one time
> per system binary.
> 
> Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build             |  2 +-
>   accel/stubs/meson.build | 19 +++++++++----------
>   2 files changed, 10 insertions(+), 11 deletions(-)

Patch queued, thanks.

