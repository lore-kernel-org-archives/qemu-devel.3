Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iT8Av9Tr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrmx-0001cN-9f; Thu, 22 Oct 2026 08:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJrmv-0001c5-OF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:20:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJrmu-0003gM-0C
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:20:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1256842f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792671650; x=1793276450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NdlHaeBzQd+4+pLu9PoONYgcRR0SnxM9vr6CSJqYASM=;
 b=iT8Av9TrvPc4o1SQBE4Hb2ziqZpHA4Q4TC/J5+D9+jMnele087HzbOAoFrQ71xkuI4
 L7QCou+s+XPgc6QwH/3Ne7JPHADd1Y9SXwobuyiagrNQdJrsAYj4QYu9gkH2o6P6obE8
 sxFf9GWYTPfkBPtFPv5PZ422AW3Wg8pQovx1NFqbRNYbhXNESGLB8KvzqLinZy7Q8ZHG
 gL5uMYWA+4+GZMG7B4VP/dbHrImbmRpoCbAeYEaTJgHYk4FIWAgZHd3gHDSeFy6iJzWU
 mfvmE2e4sEO+ypXRpJq0xKGudFgJrSG8lGmTi+OKwSSeIdNVycf6Bz56d4blvpQC43Qf
 9rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792671650; x=1793276450;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NdlHaeBzQd+4+pLu9PoONYgcRR0SnxM9vr6CSJqYASM=;
 b=fEkxSR7tEq6kKtJbsfYq/B9/hUahmLnUwZXcL2jp+ztcQccelW/F3cNsp9nfT6mE4i
 N5qsGAyrOoqzkn4Y25ParW0nhZS92FANOrJYg+6bU8u6Ex+JfJ2raxHlkPw/NmEa8B8R
 KKIqJwQPLULR9bsXSZYWc+X5F1uY5jcGcA6eSQwso+j9zWtoNY0hK/f2SbOQQN40gQPR
 6PFDfkMv0461Y3gep942SzCYCCW7yxiD2/uWApXoAke7p6YiBVixU6RhMd1Vrf+aAyrE
 v+k/Mcsj/JixRgcnQ0i4XBHvPJq5C1XB0oBVqL41Y9rtM5HuBHnHIGc1jgMywRwgv+3X
 R57Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByW2hJ3nfnYGQ8OS3kJWviRlLJhAz1OAu13rpyYj3WarZgOv+zN4vpaXyQ7AP+um420uurJYftX7yfO@nongnu.org
X-Gm-Message-State: AFq9FYLk6ZGujWxgCkmBlioYeS1lxL1bmk9d9ATKC1mK6FSAr0hfC22x
 ImD4EqaruGuGHduQQjSyGKLRKaEuG0H6NxoOJfscSjuqJWcNZBCax7MqyO/m0xz6h/g=
X-Gm-Gg: AYBFou3tUQKhp+o2P8e5LtT76HoXPjMIwJ3hx+e2ZcCwYalaIjLS1w0tbv4oGFAkVLH
 aAJCDBIgJlDUPtQb3D7mZ3SywW28fOJW7BdcevtCqDwWBc9LBOFEElNRM/VrGpkiovvoQSXow92
 dqT0WPS1zyUBT20VAqFAGlJ0uI6PFKXW8J6b5FYDDFxhGO9PqVRxvatERfo+2rKScfS8wpA2BfJ
 ik/6PE2Hrc+XW3TVHtXErBhxxx6K90F93tcQaxEgHZnxStDgflkbQbPQewGQaZ0kuWOWn8Yp6tS
 B/lWvcasLL2hYu5mdTbgoQjWYn7wgE1+VPSYD5xDj8rjEmPD0lAeTrDNPksQ6tbGMgcTyN8MzD+
 j+4efo/67l08gldafN37fOq19rFfJ9BRn6+7I2GhYa+XxfEmEq7ph9Q3OXsFndHk7QBAwdmi3fg
 WmJN0F1CX8BNpZV4HDYmmFx6z0GQiGrlchk8nZXE9xq7iszVhn1EIJxyRLUnHkkfhEdGH3PxMgE
 T2sNDoR5+DNCwVtvtJNoWJHxvjKVn6vVEvHRCqcyAFDIur9sulmDymloplvqf0OUHfzhEYs7tMP
 ZZij2c/X/tRn+Q6DPQ==
X-Received: by 2002:adf:e002:0:20b0:48d:f14a:9188 with SMTP id
 ffacd0b85a97d-48e264c9937mr7978313f8f.17.1792671649735; 
 Thu, 22 Oct 2026 05:20:49 -0700 (PDT)
Received: from [10.178.56.227] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583f25asm11763433f8f.45.2026.10.22.05.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 05:20:49 -0700 (PDT)
Message-ID: <82a86eb5-a154-4d22-a064-caf6a40f2881@linaro.org>
Date: Thu, 22 Oct 2026 14:20:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] Various fixes for the USB code
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20261022103622.1151089-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 12:36, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:
> 
>    Merge tag 'pull-9p-20261019' ofhttps://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2026-10-22
> 
> for you to fetch changes up to cfa70f3a82f581ad758586ecf408fe7f3602850f:
> 
>    hw/usb/hcd-xhci: More reentrancy guard fixes for the XHCI code (2026-10-22 12:33:17 +0200)
> 
> ----------------------------------------------------------------
> Various fixes for the USB code

Applied, thanks.

r~

