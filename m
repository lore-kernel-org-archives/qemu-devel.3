Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC98CCD199
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v950V-0007RX-NX; Wed, 15 Oct 2025 13:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v950S-0007RI-Mk
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:09:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v950M-0003er-7h
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:09:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so64643085e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760548173; x=1761152973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6bDDWlULllzS5o0lNXdgaLmawYNugK8vhDR1gWqCJs4=;
 b=vUB3e49AICYzh44nx6LQpJBjBhmthFnjqizIolakXgMrDxmxyu+9MRJhCs6a9FNx8Q
 pEkhhOVj8A0VAy8aQdEX1q5459NfrqmMK8HGSdaf5J7L8QJm9O8WlHpxSj0zqo0onYwk
 DhqPscnHqBWcPlFp5EMPNdAWXspbgP48fTZPGTuDp5blic236zQyTJ2a/fLRwJPqVTMX
 QsMnjkTBh2r1geG5RB6a4FGOPUwEnyASyV4lDtKYY998akxGp1B/mRJ9g+Q1G5lTiqJl
 cJfnUtGZMHJCJ0AmQX8SaIgYxNddBYENomNVfxAZqswIoPxQhH9B6AzO4HK+LFIa3UAc
 dxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760548173; x=1761152973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6bDDWlULllzS5o0lNXdgaLmawYNugK8vhDR1gWqCJs4=;
 b=ijTCT/WlX+VHN652H5BjAxTH/CB5+RNLdsIMFtNl+2lH7/VMLH6qN0+TM/DE6LzPZU
 WtwA12VCVY6kpl40HLJVWt3SwNZGibuQPk9RXWKTvplr4WOoNE5lqIoa0uPXHCLA1hb+
 9PSYqU4G0sgBaaEzcdTWIrA0zzJnnAP92+/G/+PwZzGj12VyK8nG4ZGYfY7XZIiT0elE
 T/3u6qnhGsLLDLiSHf8fH9UgIAYTCmvj17OnS8E7NxAZsBctVrmTy73X7+LlBj1cSHpM
 lcF0mgvn9MS+C0lUHd9gUf1jHtCN1EZr+GO0zLXUvNEE3RZy5xE8I1OVq3H+/FVEH6FA
 g41w==
X-Gm-Message-State: AOJu0Yz6pBL6nHa5/MZg3wWOHs6ekMWV+MhJQfC0wI6PZYhhzHWptBCK
 qvnqdxNXouKqYUKcX6gvPwAU4TYf+ftvuyXgzXiV4R6jbGwTJ/1OQdfK0ZgL8FaUhdSkbiPuCaC
 0zX7Li6i4kQ==
X-Gm-Gg: ASbGncuk38bxXrV/hwtedy8+8K0e/YWCZyBuLtnmYVK+m9lwNFWuHzE80c161XYw4E/
 ipQ9gYLeSXqpn97aBETfhgNfHfF91A5O7h9sQgCBpZhr7CJw3gxFoICEL0HbLGgWTyvZm7HEc7Y
 Vs6RgFQAoQkLNmR4IKkwKifJft/wHAOAhpKtDFQ6cLyVvwcTXUZVKUt54hBrMiPXl96Sf5Zkiae
 4xB7GnfdpLz/YCT1N4DdNlj7vUXzYWh+4hGqj96zzUZdPUKcWF/DemUYIHPisH5Auw3/o/ReQGU
 y+5iLy7Yc+GDN5vSS2sr8gkyLGWQhWt3MQDe10qc0qhB8/CfVJ4KSSYcoeWtBwBvRuXZU9YPUyb
 YCzCwgINkCC+lyiykWoJrrFSpwodjoFXC4H8aMVlj02s9iFSLhLxSqNqGEHxm3+pp8pQfp5zsQY
 zr6q0XTC1DU1NkqXHngrt0nJM=
X-Google-Smtp-Source: AGHT+IGHD1hsuw+H8wHvL182su/9GfSTLmc4g9bbxNSkJNgqh74KGEmx+UmTIWbPRUYQiCZxYzJDbQ==
X-Received: by 2002:a05:600d:8108:b0:46e:4580:c6c5 with SMTP id
 5b1f17b1804b1-46fa9b175a6mr211855205e9.35.1760548172632; 
 Wed, 15 Oct 2025 10:09:32 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d0011sm30563141f8f.31.2025.10.15.10.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:09:31 -0700 (PDT)
Message-ID: <1083d500-ace6-4212-a39d-3168d9341e74@linaro.org>
Date: Wed, 15 Oct 2025 19:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/hppa: Remove use of MO_TE definition
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009101040.18378-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/10/25 12:10, Philippe Mathieu-Daudé wrote:
> - Replace a pair of target_ulong types
> - Replace MO_TE -> MO_BE
> 
> Philippe Mathieu-Daudé (9):
>    target/hppa: Use hwaddr type for HPPATLBEntry::pa
>    target/hppa: Have hppa_form_gva*() return vaddr type
>    target/hppa: Explode MO_TExx -> MO_TE | MO_xx
>    target/hppa: Conceal MO_TE within do_load()
>    target/hppa: Conceal MO_TE within do_load_32/64()
>    target/hppa: Conceal MO_TE within do_store()
>    target/hppa: Conceal MO_TE within do_store_32/64()
>    target/hppa: Introduce mo_endian() helper
>    target/hppa: Replace MO_TE -> MO_BE

Series queued, thanks.

