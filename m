Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC4EC4829C
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 00:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYxk6-0006uG-O7; Sat, 10 Feb 2024 19:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxk5-0006tL-05
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:30:45 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxk3-0001mP-FF
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:30:44 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d71cb97937so21650685ad.3
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 16:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707611442; x=1708216242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Y8P2Ef7ZEq/z42JvvdPEWyh5zmPZCwY6Y+S4VddpRM=;
 b=OyTyBdVFmg/XHcplFv0zTMBvAdzSebPf3i0YPR2J8eCuxLYyPdIaY8XP+/cEBhcvBN
 vkUPcX6p2t0uEQCoS7UgKPbkY+tiiKOrEEv+NsAiX6C7lFhP7mWsuDZN4LP+jADRykHw
 OTHrLHH1p+Re+qkj9jWGN59OUSFU7q3z1R/q18NjyB2m/cYaWaw+OWmFy1Z6HGwb1Yhp
 0Mc/qW0jqCShHF4CXDevAGOfCf9pe9G/+TjQq4fga9eUFiNcw0CKfqLC4WmqU03cV4Vc
 m5Dj/mDc1kLkJ/Ha8qUvIQtacAdJ9ZV/HhK1gcBHqep2rZ+e7H8Mj13NxTDCn1Qqty0E
 5ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707611442; x=1708216242;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Y8P2Ef7ZEq/z42JvvdPEWyh5zmPZCwY6Y+S4VddpRM=;
 b=ORPiKIFMaV7skmhD7DuNIJrqfTMjuVUgUZaMAeYDzzF0nkyF8OMw0rWhz6uKQG2r/t
 +yQ2lLGR7x4RtZqEfGpAJRm6dKHB/lG2ebJ00AQJKfWrsODYlPmBLn/UtrEnJwp6vunj
 4Rrcjl1fxZgfqdPgRAO3RM62nodKaBoYYZAQ9UbeD3uB4BDMT/ecWyNuBClMNY4XAaV5
 7ww43M6URIRrW8PBq0j4XxdbLZN3PP7HsbvTZOTkwAgB1oiP2PPAR6/vwN5vV9gmk0WV
 uDx5IuYMqaMIXv9d7XeiMy26jr1Sl+H3jhhw/0Jjep7eRtLTqmFEG3JtusOqrVHOQ2aP
 lcsQ==
X-Gm-Message-State: AOJu0YwiYgVe07y+x+QXdlA4DL7lfVrcfWkaoHEdo6jnA5K+aCbh1XEC
 8ScQsAEVvef8XVSimmN1PcJQNf4cwwu54YbF6vYJGY/at/dDqIs3ndHrmJy9PxgQUmYAixWC55p
 W
X-Google-Smtp-Source: AGHT+IHEwP/yjLv8pghX2iWXw1hTBJLeeNlD4qJYCUqLaktUTz9qF7a6+Du+pGXmCJsEyQwcn7X97g==
X-Received: by 2002:a17:902:ea09:b0:1da:232:df50 with SMTP id
 s9-20020a170902ea0900b001da0232df50mr3953160plg.6.1707611442244; 
 Sat, 10 Feb 2024 16:30:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWJXkWppnBCKG4Hp9ShqmEqniQwQw47z0+cE/iZDkRKILluNIQOfxzN6TIsyk4mDccmHFNgu7v29PRpG7aQx796oeqEBVTDiFtL1X6Fu1WNIbIykMnxh87QGeJZUi0qEVDWTDduUF/Tw9Y=
Received: from ?IPV6:2607:fb90:bde1:38:fbe0:8943:a8ed:9394?
 ([2607:fb90:bde1:38:fbe0:8943:a8ed:9394])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902bc4b00b001d6ee9d8957sm3502695plz.281.2024.02.10.16.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 16:30:41 -0800 (PST)
Message-ID: <9306761b-2d72-4278-a1f2-419e5073e905@linaro.org>
Date: Sat, 10 Feb 2024 14:30:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] hw/pci-host/astro: Avoid aborting on access
 failure
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Jason Wang <jasowang@redhat.com>
References: <20240209115633.55823-1-deller@kernel.org>
 <20240209115633.55823-4-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240209115633.55823-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/9/24 01:56, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Instead of stopping the emulation, report a MEMTX_DECODE_ERROR if the OS
> tries to access non-existent registers.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/pci-host/astro.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

