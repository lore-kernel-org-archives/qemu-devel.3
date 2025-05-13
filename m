Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A321EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmaV-0004IQ-Pc; Tue, 13 May 2025 06:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmaO-0004Ea-Hk
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:10:09 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmaM-0008DI-QD
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:10:08 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so58735745e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747131005; x=1747735805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NOAigfDLRAGWVzplLf58yZ9Svxs+dmsZC52tDhTGccQ=;
 b=Eg1xhLVdeDNNLYsbyme6Nerew7Yc8Xc6biHLrL2bVJBW7MpYG7UhBUtqBNFOMjFhLe
 /cCTSzuog/EJQOSxQl4tfZpCnAo69LbgbwYopiyGBS1z7n4cq9VIo9xHPu0z+MaS+/r6
 IvLEC6hnpYsrogRT6P76gd1eJy+IWExvgnSqTXJ15d5ExLR9UAASzM/z/YgWI04iS8cJ
 C33m7aiti3KIwDJTlrbWadmDJXSgQNGJuS5hT5/VhJBiOERHq0bA1+4+kcfZ+DR1826M
 NJE+sxdBX+m1J7PvXJ7Posu4ul6/uqrKBOQ+GfxTx6MNQ08+L0MzzyR14YSFGbyE0P1B
 zwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747131005; x=1747735805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NOAigfDLRAGWVzplLf58yZ9Svxs+dmsZC52tDhTGccQ=;
 b=Kk+sdp69Zyk+H7E+KS7LPaE1/MLJSVnodtjvqXpOTOkDCLsl6gb8HxjjT0B0RSg8TN
 i4JthK+C9Ya3BtV6p1VbcwBwgrhTCGXxHKTP/DEbmYl7WvdTx7JBdXel+nEHA+W5/tB8
 E0xRneOAGnIltHGHizADUdKjYW6WwwYHhZbaH3i3A0EGQtJT7Kl+xxslt2badd9PnGWF
 0NnMZKhMZPgL9bRJc/+CPaWAmdAKrYpfAHBlY9MqvHus/Ib1NbfE2e9f/pKupRKgnbd+
 qtdhRw1U23O3DTSpqbiWWHYX9KAFG1COdcVJ3gmx5ZVMW2CgelGl00zoVWFCkrnh11Ya
 RpQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0XFGD1dYJi4K0CzTVU8wuudoBmoauKKbwVz1ljqrZ/NLyBRQPXiJpiapOSvVWqpWPqGG/b1QXMYwN@nongnu.org
X-Gm-Message-State: AOJu0YzenjCDgL4DYB9hoSKgvod1lUH+ZwRAt9dhgjUT63GjhdOgqVWL
 SWE+BWvOs7FYgvgGWdVqg+q2KafCP8e+iGqohwa0oBieH2BOsto1nWqvLxcpK5o=
X-Gm-Gg: ASbGncvQ1DdMO986M14YTN4a11srkMPZWBYN9ukcncpBiMeaqx7MLEpzNOuiVOOdfjJ
 m6mb/myuBfQ5a68kfgNw+9IReJcAEA4QCas3222nQdVi+chHpDTcshveWEkacRbZ33r14mErWSS
 HWewFZ389kJwq77nZ6YcqpztPjHHwahX9unbVzTY33gctMeOrVhlxrGuS7L5f8ie4uooo/uZ5QF
 3Hq2vRk+QXclB+m1RhsMeVLwdISKvwwMQJ+d4FYHMP5XL4iNZrtAk3xg910Mhbndzrm2Q0jmFQf
 wQdd9s6KCyfwGIce5rF/IRVt2KMyAdUgHpxEuMbMXdtvSS69YFUZXCF9iPAzZXLU9kBiMwBgJiy
 CwzCJCZAqUtFA7FELNQ==
X-Google-Smtp-Source: AGHT+IH/BJmKeG8sCCjsrnEU4GvBCUJ7l4E3/vLrsI8yqEHlrC8lIIvVJnGpT7mn94M2UYA/kQCk4g==
X-Received: by 2002:a05:600c:8284:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-442d6d1fb3bmr160420685e9.10.1747131005348; 
 Tue, 13 May 2025 03:10:05 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb79sm205060145e9.27.2025.05.13.03.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:10:04 -0700 (PDT)
Message-ID: <69c83783-e2b4-4487-ba0c-d94fae9c7b75@linaro.org>
Date: Tue, 13 May 2025 11:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 32/48] target/arm/meson: accelerator files are not
 needed in user mode
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-33-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-33-pierrick.bouvier@linaro.org>
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


