Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F9C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcFT-0006t5-Fk; Tue, 15 Jul 2025 05:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcFF-0006nW-9D
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:46:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcF8-0002QT-IA
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:46:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so12647445e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572793; x=1753177593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZVH7bhoN4o47thax8UXEi1gfJHkSU2D8TvVIB53qiq0=;
 b=UCqC4cqTBVeLSDtH/0Tlp/Tyqse6xgYu9HywT+y6SylOsYsS6Lr2HSa92uzb2b52BZ
 d6qng9HpDksqsOYtRoEdVxwPMdWIC0kMbHnb1D+e73NYqaX2mwW4cIrjTi5s/j65RPDp
 B0U9ghzFM4yYIE1SHWAbuyWcQbmbloJGKSU5eXU8zPJkbJWzQladadtbZQlTW8Z6Tx8c
 DcbhiVBKSsbCy0qXdvJ8uw4r5jUUgc71ecYgjTyxnZZBmc/1is/ZWxA6AhDUL+gr0AAG
 6r9PP7tgjV4kmWBAj1K3gkPEY6feT/HdnDafFQ9qIb0C82IPGQX4fYR6rIADnHLHaemI
 Fgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572793; x=1753177593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVH7bhoN4o47thax8UXEi1gfJHkSU2D8TvVIB53qiq0=;
 b=b0aEZYvRQW4c/MJ4MFXShIswGHjGx9rsNZXSR7L4TQGdQfvbFwXKVTdsRtSUjj/cR3
 NwUJgce5c/BbSgZvxDPTgS+Jc+fa3TiHZpJzyMF2YZqv0CuAz5hor1TiQpLO/RP5U3W5
 UXvlzy9V137SPigsln1C8U+ELsTQsonP0OAwJRl5roxvnVWA3CS/fI5w48MZMvUlIPq1
 MRkcyef+xTmxjcHV8eCcSJDtwotSizK+75HKLRzzW0UWkx0wsMqk9hGcVt/1rSQC78YU
 honRFNWNHspWDvjNyLvZesW39c+n5sxQimfrTMbHwrI5mXz3KYQGh2Y2akri6iZPcTWg
 9vyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDcOgvOw5rqnNTL4HniMQx2mR5k9zmaQQ36dXB6XWOsRNHqdSqnY6cC3zHPa5ddA2UHkKWtdR3799L@nongnu.org
X-Gm-Message-State: AOJu0YzjBgmtoCZJ2QZumGMSmBP9Sl6Tb0wTP5HR1LSMhCtJtiN2FYxe
 fc0PmgFgWgl4miryJXcS4HkH3R3XtDLzNw9dXbgABEMMmHhWTx1cuVlQwoiohOiq+L+KaFx6bKb
 7BaWp
X-Gm-Gg: ASbGncvYxR9aD6og+0EdN5AGeEJJT0RWl8t3irMT1BH6tLc9VRVdzVJp+R445ZQDytS
 zcHsWXWxDqlx0cZDdIZIqeUtez0dzGbbNpn79SAp3IjlKQB5gyB0L8wlSzkeWaz26K5Uvj6reYH
 MbqShnFmNRqISir/ZW/y7UJMjWY0cytNQZnT4DX7tDUbCjz1h85AqZGBl4/n5E92IBmZdtija3F
 oFRuhtxCnSKT/wra77JKFE/wQH73ikc+0QudlO/Hf1loswAlLkvH55ickQOGBsZnQXEOA2rzYwZ
 um3McJdGPRkperyOvStMersTh5MNAL1+cjhQ8DmoQV/4RHbr5NFSeoNeO6TKDXHEmuD561oXr5F
 dIgXiBNvnFd2txuQJrhjD/iXyy5dM+GeLZKlNTJf8kNNMH+xkCKO1jY7y8uQuStcedXbjmD8=
X-Google-Smtp-Source: AGHT+IH6NgNDYquxc7Qq+RgZ1RT64PiQRrVQ4RNvcs+U6tHtCyQOoX2I4h2Ttq15Gd7GtBZSaPCXfA==
X-Received: by 2002:a05:600c:548c:b0:456:22f8:3aa1 with SMTP id
 5b1f17b1804b1-45625e124d7mr24510605e9.2.1752572792658; 
 Tue, 15 Jul 2025 02:46:32 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45617dc1fccsm66232805e9.5.2025.07.15.02.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:46:32 -0700 (PDT)
Message-ID: <fa670d22-d882-409c-af3d-1669d6386800@linaro.org>
Date: Tue, 15 Jul 2025 11:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] crypto: allow client/server cert chains
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: matoro <matoro_mailinglist_qemu@matoro.tk>
References: <20250715092932.1395271-1-berrange@redhat.com>
 <20250715092932.1395271-8-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715092932.1395271-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 15/7/25 11:29, Daniel P. Berrangé wrote:
> From: matoro <matoro@users.noreply.github.com>

Should we use <matoro_mailinglist_qemu@matoro.tk> here?

> 
> The existing implementation assumes that client/server certificates are
> single individual certificates.  If using publicly-issued certificates,
> or internal CAs that use an intermediate issuer, this is unlikely to be
> the case, and they will instead be certificate chains.  While this can
> be worked around by moving the intermediate certificates to the CA
> certificate, which DOES currently support multiple certificates, this
> instead allows the issued certificate chains to be used as-is, without
> requiring the overhead of shuffling certificates around.
> 
> Corresponding libvirt change is available here:
> https://gitlab.com/libvirt/libvirt/-/merge_requests/222
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: matoro <matoro_mailinglist_qemu@matoro.tk>
> [DB: adapted for code conflicts with multi-CA patch]
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlscredsx509.c                 | 157 ++++++++++++--------------
>   tests/unit/test-crypto-tlscredsx509.c |  77 +++++++++++++
>   2 files changed, 147 insertions(+), 87 deletions(-)


