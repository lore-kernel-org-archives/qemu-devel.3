Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C86CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyUp3-00083E-Oj; Tue, 16 Sep 2025 08:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyUoz-00082Y-FE
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:30:10 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyUor-0000jw-HB
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:30:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so4630745b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 05:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758025798; x=1758630598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g9nZX1UZzMon5KE8z2cEcBk1rAUf4QpC5CCJVBoyGg8=;
 b=npRYU8W0elegC2UZ+ddwGIosCkvtz3nAj2wy37SuXDZNhMNVhBKOL1qmJUL5vqJ/p0
 ZPrrXK6Jo4RQD/4M/8sjfuqO2nVSkMDAthFVzUi03W7hTYcqLYuvyP7MiApo53xV0dty
 Dibi9Vpjwis+qcBTEPF6E5ChmYwYln+10ErIPyMUcHNhZNg25cd36q5zF48FUQI4/zuv
 8vwFGMlNXqKHeMq0eoj3LnfRKY+UrGjwCbNPFTNDvnGoFJPBP3ZdVG2DHW/GJi1nQm9P
 Fm7nD5kBOF3MT8AjTsFm+O5vP8KV2cvIZ5AURAHB7zNr1UiYHa87Be74ZgTO4M7qbGz9
 vT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758025798; x=1758630598;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9nZX1UZzMon5KE8z2cEcBk1rAUf4QpC5CCJVBoyGg8=;
 b=FhWaPIGQZvhJSzAtN9AlbSLQdyxBuE+zMkxrDs0N/7BqU0KrFmcXKgiHbtL8r0K/Yd
 8J7tS6zrG+A1x/tyVKQD1M5icDsk5viwq04a1aAZZHw70ZYId/tYhI4k/Pxc47wYOQus
 kQ/blfxS6P05D+XJRdSZe7dmz3Jbncf7EI2UAdQoNVqKbbbpvq0lEF7H/+FuM+MTujQM
 KtP+AYAEX57RHIOmXKKhBApxxaBSYUL7Crjyx+OqGbPejiqgttB6vd4/1EqzQzrIO6XS
 tNQTX4TS4r+c96ZTre79PB3wOObgqH9b3XQoBe3+Ezow1x/MnFf2ugKvVG8NZKodth6F
 oM9A==
X-Gm-Message-State: AOJu0Yy/d5B0d6GLt1jhi38F+UHtMX4lj8sHH8CW60ChdjZnOdV5fsAd
 YvM31bwJwxPQeTy6p8yO7N+x7lBFurHG9utegt0/PSuIr2xrDIRXjdOppoJdbYuWX5c=
X-Gm-Gg: ASbGncsuIqg++O3yKfu8ASfUEjLaD1e10iEt9xnjR7/u1zhDhFLNjL45Jnys0jhCO2k
 zjf5Z6uDdSIEquqNN63mtNzs1bgFfpm9vR9Fhgof2R7t2UATqJ4jXXrlG6bYV5Vr6aiY3frZ1YV
 8HDfIrfE6KeCB8AgwK+XJbphZTONBHe9kkahvpV7fYUDAbyvqae5nkdyKF6mgfmA8K4dxwv2u+n
 befqTzn0Z8AVn3betB27OLRZvgJdpBvpReoxoVGEvoMifxmp234jMwH6pdsigELNYRHXushX0r+
 FWRubHSrp4Lrb39538Z05Gv6gPc0E2zqxwtL5Rekgmqx8YCMQX9w3VgVobhpB+S1C5KaCW10CSa
 nQ5cZoRlx4qgMMbBFC82zRnnHb3JTOLC2r25p
X-Google-Smtp-Source: AGHT+IEtqRs8Q5xfBxFGParguuRMRO31Nv09sXciV1q/3XsN1riw+eUNiRr+3fYxF09jez2ZnIJe8A==
X-Received: by 2002:a05:6a00:b8a:b0:770:49ac:50b3 with SMTP id
 d2e1a72fcca58-776121a7ff9mr21317453b3a.24.1758025798005; 
 Tue, 16 Sep 2025 05:29:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77618e200d3sm12409418b3a.17.2025.09.16.05.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 05:29:57 -0700 (PDT)
Message-ID: <fe87b5e8-856e-4257-9a8d-40b0bd0b9360@linaro.org>
Date: Tue, 16 Sep 2025 05:29:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/61] target/arm: Implement FEAT_SYSREG128
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <CAFEAcA9Any7XcejhUsCQDkseV8J0JQYq1YMDrM_eL7uJmDwcjg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9Any7XcejhUsCQDkseV8J0JQYq1YMDrM_eL7uJmDwcjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/16/25 05:14, Peter Maydell wrote:
> Is some of the early part of this patchset useful refactoring
> that we could get upstream already?

Up through patch 36 reorganizes VHE to operate more like NV2, redirecting cpregs during 
translation instead of using runtime thunks.

In addition to a being a nice cleanup on its own, I think it would simplify the EXLOCK 
changes to ELR_EL1 in the GCS patch set.


r~

