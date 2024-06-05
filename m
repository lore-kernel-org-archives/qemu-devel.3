Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F10C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErsP-0002U3-9s; Wed, 05 Jun 2024 10:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sErsM-0002Sj-2w
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:44:30 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sErsK-0004a7-1T
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:44:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c1b45206abso4981527a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717598666; x=1718203466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ghXc0BKGmxEYcEMvhHZv6yabJjqxAzyNZ0qps6r06Bo=;
 b=G1M9/HGRaWz5PLFZrL8ZqffAaXCrkpqM3SAYpzMmhHtBK+yHhHbQvlcBX7ZtG47N1q
 Sbf40qsX3HX3FRaJpm6JfnFZeYpfar1OC9mr2d5SiLS6E5a1oT3LpwH8EglHhDmJB0iE
 i21ZX73L9nuolxJMhbs65QWHhDK48IJ5RYkRsA1cyhcueC43kbjfVt6T0G++xDfp+uFS
 9Lexdw90MFVacGqNUr6nZzwnMHNV7BVk05fQ2XWKozEj3I28fTDQjd5wUsJjhte79WXs
 SLFvBS3ySpUe1/gRzwRhUDTyHT38BdpHL93YlYpSYU1n7okBX2b8SsXMZ57Om7ujPJLR
 +8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598666; x=1718203466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ghXc0BKGmxEYcEMvhHZv6yabJjqxAzyNZ0qps6r06Bo=;
 b=iL/dY/zXz/2HZHxoWhDbgCHllKvZylDCA75yu5/XdKU2nFhYvoJVyoJ62ti7ljElxR
 i385ujU6VqhVe5bQg9/dyTIL/3k5fEfV9leXPyU9wi2COuedoMj4L/HqMz0ItL781BXd
 zqiHVNlYdOcc/z/VOBzgmACzZ98rGBn88J8P57tWIHf7yKgesyYhlME1J+bqeiXsf0+U
 jAHDO/xYAupBf+lGOCzCFQYXXXDPjip6z1gi3ZMIdVUPsrXtm75zOik8i5N7gNWrtEFp
 v6UQKSKx62xI1x6XEDF7QwP99FkOhQrGu35Q02Ig4BZUH4dxDfw5+48XiwAXReaNGSmG
 ZPWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ5pR3hxdJucAKTdRbWgUOVz7wslmzWT5FJtwM85gGTStUQIuW95snTf5qW/s3pEYpdKnP4mQaY4X7v94Dd/oCFZB1GA8=
X-Gm-Message-State: AOJu0YzkeZ0e1iZgF6A/RiczeqkOnbT9tGbk+nKi+E+BSL38OWtMOje0
 sSuNIso537eOoXSJj+cLgfDzf2iDeJZhcYn3QJBQbA2FNW1hvFZQnSSP5iqVAkA=
X-Google-Smtp-Source: AGHT+IG7ydFSNxPbk0OJUMPhwm761tFe0agCz9loXAur1c08uyqbF704N1ujF5fg3iFpYxKqAZk3AA==
X-Received: by 2002:a17:90a:c788:b0:2c1:a4fc:8ba9 with SMTP id
 98e67ed59e1d1-2c27db10401mr2428144a91.16.1717598666166; 
 Wed, 05 Jun 2024 07:44:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806399c5sm1572509a91.9.2024.06.05.07.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 07:44:25 -0700 (PDT)
Message-ID: <ad6d572b-f39e-43ff-b11b-74fbe8ae3148@linaro.org>
Date: Wed, 5 Jun 2024 07:44:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/46] virtio: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>,
 qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
 <20240605032555-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240605032555-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/5/24 02:27, Michael S. Tsirkin wrote:
> On Tue, Jun 04, 2024 at 03:06:01PM -0400, Michael S. Tsirkin wrote:
>> The following changes since commit 60b54b67c63d8f076152e0f7dccf39854dfc6a77:
>>
>>    Merge tag 'pull-lu-20240526' of https://gitlab.com/rth7680/qemu into staging (2024-05-26 17:51:00 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>> for you to fetch changes up to bfcacf81d63a3d95f128bce3faf3564e7f98ea8b:
> 
> Dropped a patch from this pull at Author's request.
> New head a2da15a164ddd798227262b58507b46ad5ab0ca9
> Sorry about the noise - ok like this?
> Don't want to spam the list posting v2 just for this.

When you do this in future, send a new v2 cover.
However, the bios-tables-test still fails, so I won't merge this either.


r~

