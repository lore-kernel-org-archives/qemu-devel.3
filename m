Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60162C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 05:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXDFf-0000Dq-EL; Fri, 26 Jul 2024 01:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDFb-0000C8-R6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:12:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sXDFY-0007XC-EQ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 01:12:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d1cbbeeaeso516608b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 22:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721970735; x=1722575535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPmXWcow84RGSGwTlbg4B0zJEkR9oNwT5GyZI1wt3m0=;
 b=iYCscO9P7B+Lnie+lbWXcpEeS/QIetX2dcxpuqDtLjW5+Y6UFost5CEo3ltky17ey0
 gICZbVIM0QV3APIHyESnI15aA5IqlhVymqlyDJOTvR1rGZqss6Im7AebBKVo7z9dd4YG
 akXoemJtewUHVGutVQm/3WBwHhRnRCsAZ0fnq3X83OT1vUvC3wuywSEJdXVcR46DWLRT
 JkIv2hkmrdUuqOoJ+R1uG2owhKxjPeFpZJ17/pac4XY4eTOYq4M6ZEcl9OBZW10tvM4y
 VfDQVr2h/1JfdePMJmoCA1hFYpveypu0Es7m8gIcX8C9JZR2Z5DvpOS2dVG7CRWl8FMC
 Ofzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721970735; x=1722575535;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPmXWcow84RGSGwTlbg4B0zJEkR9oNwT5GyZI1wt3m0=;
 b=HFi6c+Io8XJu4MGlq7DseWUcNYE80lJvZtm580+1t0Ka2zpEw6NJI80Pb1wFUN1sVW
 8+twHCkFKodEHTLFowWyupbn9BdA/CC/ZxHetpKU+yqpGmEt0R7C1SAefL+RpWlPzfAr
 tQhmGR9B69BhkpYgepuWjwT5maQp5JuP1ofsQhoXOTmOQZhATkTnCq8VZdhjWZyWv2CQ
 O6FmFaLURqG2EuVga3sB3UXXC9Yb45TJ825alLISPs3heapLEsE3rrJJ30LTPJfCEu+q
 tzqN227rrYkthPe+KrkeYpJ9wtKvQ1QhSHBY1zxbQNBeVGb6yZAxaKddcwKy2LFyehkn
 6gxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvejE931/K2Lu8Y9AsCH5p9Sr/vxmgAQa9+cwAQKCiYoyZfa3Rut5MBjcbn4PeDRxbMu6h6JXzjIvIzXUFmDxNm8I9p5w=
X-Gm-Message-State: AOJu0Yy+PPTIcduu5KwF2vZ0IhNQYe2X2BxEjg+22nYx3oT2DdGPDcJL
 7XO7tEJGaBKEgHiID9FvRHtM52tRyB9OUHVWYFd0CFuV/51pkE6lYVQoWX0zzxI=
X-Google-Smtp-Source: AGHT+IGBmahW6CHLuPF6wxc6Mfm4Awxmr7GFsUQjiZrHfjIEPLwIntcz4h58QZFasmyA1/vy/pKw6Q==
X-Received: by 2002:a05:6a00:140d:b0:706:6bf8:bd2 with SMTP id
 d2e1a72fcca58-70eae965550mr4403921b3a.21.1721970734604; 
 Thu, 25 Jul 2024 22:12:14 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8a105bsm1930654b3a.194.2024.07.25.22.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 22:12:14 -0700 (PDT)
Message-ID: <e2c08955-2956-4d64-aa54-27569066d300@linaro.org>
Date: Fri, 26 Jul 2024 15:12:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <rth@twiddle.net>
References: <20240725201211.460318-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240725201211.460318-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/26/24 06:12, Stefan Hajnoczi wrote:
> The following changes since commit 029e13a8a56a2931e7c24c0db52ae7256b932cb0:
> 
>    Merge tag 'bsd-user-for-9.1-pull-request' ofgitlab.com:bsdimp/qemu into staging (2024-07-25 09:53:57 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 851495571d14fe2226c52b9d423f88a4f5460836:
> 
>    util/async.c: Forbid negative min/max in aio_context_set_thread_pool_params() (2024-07-25 15:57:38 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Peter's AioContext thread_pool_min/max fix

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

