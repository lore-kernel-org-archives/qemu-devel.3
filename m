Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0FDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPb4-0006vb-QO; Mon, 29 Jul 2024 08:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPax-0006aw-Sb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:35:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPav-0001xF-CG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:35:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so3952745e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722256514; x=1722861314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wyPxvs4SlQ8LjSfRgj44BKUpOdXt6RFny7aa9iXPYpQ=;
 b=q6oSFcqfragnLMgqH/o0lAAqR2XHa8zjV61Gxc+0UBokc9ZZUUPizR8Qe6aBr8FFeI
 BiqePpIszVQoyecRbZg6KHUn0pMV6uytTvY5jQJJWMAU756P121BBl9b0G3IvdAHxeug
 2GtCzMKx0+tXTT61DptMdU+dMuEwqlHNmb++vdohWa09GwsqM40jMnFnSZVxnKsgHRVU
 UmNc2lhdmadxA6VYhbHV5LhblSOouwNoIyi3SZMjxTy5x7Lmy2X+10Ym8PsCmEm/Gq9p
 R1yfef679KlYTimM4ogYdjoYlIeNDuoawY1EaWjVACOhz9oQoO8q5r6hs2Ikl9yKEYZx
 smpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256514; x=1722861314;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wyPxvs4SlQ8LjSfRgj44BKUpOdXt6RFny7aa9iXPYpQ=;
 b=CMrN3oubqRcf0g3sULQXAbRr11KDoGsSQpRs1NBrBmgtuKW/aXRSG9yWMWJclLYwd1
 CBj2/5B0h/rp67UpZiG0i2073VsGoUNNDJwVaedq7DMf10GoT2lUaBM3rJbF64orc6ro
 hAdDVzIECajb7CvWvMPrRdsY5WpO0JmDX8gQludIwU6H4T9Mx7dD8Op/zAZezSGMTxEo
 LEjtYPIhSQm5Va+qqBKsb8OcBIrEzKd6PZ51ADokUJ63As9yfEDQfSuzhBJp9hlmvGZ5
 14GFKpc0V0xVARctqQTFSV7Xnhv8qrOHMo0ZQ/jlx2rOTtc6Q2exroymTOQ2/mhGxPcw
 FgPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOo/KAv3TY9k/tN7NHCWR/oSLR6CQIi9YntTltma+KTM55PCr+rSAf67inegp90R7/wubSFXr3paUAsjlbrJoWJRBjO+A=
X-Gm-Message-State: AOJu0YwLtoMdwzD3dy0xdR4j1/L2Kszj847X2kuRzbhseEtqPetpV7mX
 AbLqEneoj23VG00TMriRbnQKLQ8wbJlgIlUgcJ49mFre6PLAyfDS5v6AlP82FEQ=
X-Google-Smtp-Source: AGHT+IHowIxpeyBhHbj2VyYxOqv5cDirvqyDzeHdhgTtpLyVu6Fz9PhuFSqXkqcLFsrOcCxtkcF5Xg==
X-Received: by 2002:a05:600c:1da1:b0:426:6765:d6b0 with SMTP id
 5b1f17b1804b1-42811d9c8f9mr46133515e9.15.1722256514148; 
 Mon, 29 Jul 2024 05:35:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281e72c21esm24155135e9.40.2024.07.29.05.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 05:35:13 -0700 (PDT)
Message-ID: <8d0b87f1-dbf5-4588-96fc-cf1cbf3f9b6a@linaro.org>
Date: Mon, 29 Jul 2024 14:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/23] tests/functional: Add base classes for the
 upcoming pytest-based tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 24/7/24 19:52, Thomas Huth wrote:
> The file is mostly a copy of the tests/avocado/avocado_qemu/__init__.py
> file with some adjustments to get rid of the Avocado dependencies (i.e.
> we also have to drop the LinuxSSHMixIn and LinuxTest for now).
> 
> The emulator binary and build directory are now passed via
> environment variables that will be set via meson.build later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py | 328 +++++++++++++++++++++++++
>   1 file changed, 328 insertions(+)
>   create mode 100644 tests/functional/qemu_test/__init__.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


