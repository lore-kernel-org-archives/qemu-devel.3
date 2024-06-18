Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D068C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhCv-0001eQ-HN; Tue, 18 Jun 2024 18:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhCu-0001bM-J3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:21:40 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhCt-0005RG-76
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:21:40 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c31144881eso4867178a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718749297; x=1719354097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gYPQY4nYAEF2xO8cNJd4S4vwQYjZohbGXMZ+/0NO6Xc=;
 b=s/28uq4Sr15rDQdFCJeyojpmH2hcIwDq6xAeTQWXhpuqD4El9OOvGERfX6u+giBwBv
 aupswzgqZzKXAnnrkVGLBAsAscfxsklFucGS37Fapw68i8cOvbp9F9MolBZ2Yxn37kRb
 +SEaaiFVK2017xMqd7gd34halR3+CYxE8kPW22mQRmR5MGVzBhIANKUDvSmVNqZFmGF1
 ykXD+hzejUEdFZ2w+FgTELuPX8yBdiEILMl4i65iUuLUtVWcpE6UeAcY7Am1IlG0A6Mv
 RB3yznzWK7OAcoH8koCTQ8eOQLeoIL9P+N1/cRC6op0TUnjNPI1l0lsjuawFf3zXjNHg
 Buqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718749297; x=1719354097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYPQY4nYAEF2xO8cNJd4S4vwQYjZohbGXMZ+/0NO6Xc=;
 b=gA740W5F8BDBPSEWI7HulOnWe1BdzSOVUEQrqnFaeYSaoAt/uFK9XUx1B5lUTpwniT
 JbQBQFiY3aEa6grx1nuC1jGN/Cc8YsjplEYBeQ1mvJOh5NjHLBeV8+/SylPL0oVF2vBF
 lR9C8dKNBRxlWpqwUPv08mLjvbYsQiI9jK3rR4QxQOweKncaMkMGm4Uw5bc7yC2bkcPW
 tTiIlePFG7Mtg99hZDPTloYDyJbBiQDNWBQkopjHxVz/D81SYWQg5vXPjo9rR+yqhVMN
 Pad5sP26oZ+BsihSh47LsEKY+Uj1/unFUe3S1H6jCJlFxKEaRC6xxlKwCvvx8uvnkOoh
 rMPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Vj2VOdYuFN3tjIx20Ih1Bq8ddanz5LPV5MBPe2WU7bYV5TKNCv6wWu5AFYJavtcWV6bHWtKjnHSkVAlFFfMymlaIpP4=
X-Gm-Message-State: AOJu0YyiJaoY2XHcC019jOJAz0gsy2caw9oQ84HHF2U/rWx4O/DCvCv1
 l0n/jrPStC1DHgPHBeKQ7mlUH+Jd6qUdkaX3yQwISWEz2QLBhHDbWhcJjEOWE3I=
X-Google-Smtp-Source: AGHT+IG1k89AAJonEPGYLrr2QBvWgZzkhZbpKhB/ohIxmS+LicjdgwNRhNAJge/r0pRL3lHezsjugg==
X-Received: by 2002:a17:90a:8c16:b0:2c6:de10:6ac3 with SMTP id
 98e67ed59e1d1-2c7b5d7be3bmr1130245a91.31.1718749297388; 
 Tue, 18 Jun 2024 15:21:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4e4a3ba94sm9052040a91.17.2024.06.18.15.21.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:21:37 -0700 (PDT)
Message-ID: <65c00be3-d072-463c-b37a-87986a684138@linaro.org>
Date: Tue, 18 Jun 2024 15:21:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/23] Add function to retrieve ARM AArch64 hardware
 capabilities
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-16-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-16-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> The function initializes default hardware capabilities and
> finds additional features using the `GET_FEATURE_ID` macro
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_elf.h | 38 ++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

