Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4876BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 04:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJnBs-0001qK-8l; Wed, 19 Jun 2024 00:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJnBq-0001pw-VS
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 00:44:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJnBp-0007jA-3Q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 00:44:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-701b0b0be38so5531486b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 21:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718772295; x=1719377095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Cp1GBDG94nB1Tc9OevdNHAXSBZL6zT9wcUPdQOM1sI=;
 b=Ag5EJOw425jMLtyjYuHzBDnsu3pgcomQ/FUpIcdQoAqBGBNMhKr/nacgMK4CcHegPJ
 l8HN52lged6/gOHalyBXx9xlI1U1IeWrhBVF/nrirvydzS5g0qFTkfLtmFxfLfXWmBSl
 R/czhHNVVC/kkkS6OXB+c9Y/8CZs7bKxZAhtYMNoqRWnudD1irnX55yi2+wqHy/pu99G
 K9Te6l1Shr1VErILrRvySptb1l0Hh9GXcIhQcseOFgk09mPXWkLgvnGPnBiNpnDWWoYs
 2SmctzmlUQUh0jKI2LX9tHPN3Px/c0sOA/ypabQbgeXQMlVcpVsV1elJphyZW3JuceUM
 vkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718772295; x=1719377095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Cp1GBDG94nB1Tc9OevdNHAXSBZL6zT9wcUPdQOM1sI=;
 b=TvsEyXWHhV3jjF6gC34gU/OlhCxJyFCR+74OY4uH3wu8hjoOgnDF7Iv+jFEIhtWimq
 Pdj0fR5v8Ii4WQGZsxXrMPTsehd9F33Op4+wZk9dKl5lNF8bl1regVdlpxREwdalr21h
 W/UvzV3duz/ktS+TLk+y67ovs4UwqVtD542+W8vuOS4JT14li8YiyERFWvK803O2GNjQ
 GDZ4JvRy4Vw6HDK5Mj1VPqvMm7QX0IH9io32SiOWcYa2Qy6lWxWVEj2CnPCYMqTSLd11
 JEL1CB21ku4gFn4xtiOTZan0X1EVYvrqkunwCDqgE+U0Llkij25U7jJQxc5Kha4BDomJ
 653Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXT7HbCOfyYOoqyefIdtalyAwbnQ/65b+aHbDD1QTiUZKd6pRTPBGWZZ3lnqzqRmdTLltWZ4Uk4u0JTVxI8R4L5uqV2/0=
X-Gm-Message-State: AOJu0YwKGTLqq4DsT7m/yJoyLzAngYnPv/CcYx8ojWguskPF6nhEmpp4
 FEExpsKhe2zt6KR8thOa/DFJkUCShz1JoQDnV8t4ANYddlOZv3gzj5ieda/SXvd03Zc4xlp3obu
 z
X-Google-Smtp-Source: AGHT+IFp9xZHgaf8g3BT4mlMfGkjXk05tY6bwkYmusFHk8CEgt2/ycSd91uskpwCxBRFRkPogoTJ6Q==
X-Received: by 2002:a62:aa0d:0:b0:705:d805:214c with SMTP id
 d2e1a72fcca58-70629c1ad2fmr1576604b3a.3.1718772295450; 
 Tue, 18 Jun 2024 21:44:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb3d188sm10050415b3a.99.2024.06.18.21.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 21:44:55 -0700 (PDT)
Message-ID: <ed69b9c6-2e86-484f-8e04-3b81b9acba33@linaro.org>
Date: Tue, 18 Jun 2024 21:44:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] build-sys: Add rust feature option
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <89b7d4ae6c03cf16ce9fcc95d0406c20627fd444.1718101832.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <89b7d4ae6c03cf16ce9fcc95d0406c20627fd444.1718101832.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 6/11/24 03:33, Manos Pitsidianakis wrote:
> Add options for Rust in meson_options.txt, meson.build, configure to
> prepare for adding Rust code in the followup commits.
> 
> `rust` is a reserved meson name, so we have to use an alternative.
> `with_rust` was chosen.
> 
> A cargo_wrapper.py script is added that is heavily based on the work of
> Marc-André Lureau from 2021.
> 
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Signed-off-by: Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
> ---
>   .gitignore                    |   2 +
>   MAINTAINERS                   |   5 +
>   configure                     |  12 ++
>   meson.build                   |  11 ++
>   meson_options.txt             |   4 +
>   scripts/cargo_wrapper.py      | 211 ++++++++++++++++++++++++++++++++++
>   scripts/meson-buildoptions.sh |   6 +
>   7 files changed, 251 insertions(+)
>   create mode 100644 scripts/cargo_wrapper.py

[13/5185] Generating rust_pl011_cargo with a custom command
FAILED: libpl011.a
/home/rth/chroot-home/qemu/bld-x/pyvenv/bin/python3 
/home/rth/chroot-home/qemu/src/scripts/cargo_wrapper.py --config-headers 
/home/rth/chroot-home/qemu/bld-x/config-host.h --meson-build-root 
/home/rth/chroot-home/qemu/bld-x --meson-build-dir /home/rth/chroot-home/qemu/bld-x/rust 
--meson-source-dir /home/rth/chroot-home/qemu/src/rust --color always --crate-dir 
/home/rth/chroot-home/qemu/src/rust/pl011 --profile release --target-triple 
x86_64-unknown-linux-gnu --outdir . build-lib
/home/rth/chroot-home/qemu/src/scripts/cargo_wrapper.py:14: DeprecationWarning: The 
distutils package is deprecated and slated for removal in Python 3.12. Use setuptools or 
check PEP 632 for potential alternatives


r~

