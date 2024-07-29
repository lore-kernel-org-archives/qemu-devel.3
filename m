Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FF0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcdh-0006oN-SX; Mon, 29 Jul 2024 22:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcdg-0006n2-Ij
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:31:00 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcdf-0008Vz-5I
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:31:00 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7b0c9bbddb4so243003a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306658; x=1722911458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5OCvYJLFwaWOZQK/YmPu3k4wbezPG4IizxhWNA1iHtU=;
 b=uR2gfZXZb4TXduFHJaQN/orhB4PAXxFNh+BgxGc1n/APuuHimhzbrwUDUto+0mPPF2
 BPqCTKjomLwFIWafPc1ClbaG60VcK0bElfTflmseoiLSfT20rm5CqZXrUbNnlqImGCOK
 HwUDrmnYeYVOxGBZWk/9bd+jtWzdUM58EvwjSt0YPHRNZmDWcmte0KfZ+hjalVVdSiev
 fWlr1QzF+n1RKRHubWpawVmCmEmBv00QfvjtNvCsx1cLrjhyKbY6wSrZFud+UfQ2Ifpi
 6KxHuQjMu93ICfJlSAEiIuPWT/JmM7U3wJhqzNP/C0JaFMZbOftldRpQD03UqinzdzuM
 Yn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306658; x=1722911458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5OCvYJLFwaWOZQK/YmPu3k4wbezPG4IizxhWNA1iHtU=;
 b=g5mi8y2l4NqKlfaVU5wwhio5GzFbS8DS/MVzAF24oxoD4i8LgehTa3fXw/B6AIE1hX
 w2JPG4iWK4/zOztMT8aolUE9hCfOOS4ZTvdMKkCYmYU9TFw4Uv0CSnl6Nlhh9cMo/mbK
 JpEhoTMMc8AfmkUwOcoSQJ7t0cshQowe7Ozmfn6Qxh8mnHZLSKDhm9BZU2kgpn5KlKQt
 eCeFOhhDgJ1qEOKnAr5+lgsL5MdgizyrQ/cESTtkNBwKytPFa9JgsBoqmu54LAT3eP2m
 gwYw0ei8o3r+41wNw+SeUCfJN+xOZT3yGNrotB4t63Q1GnrM/EOV6nfQKHGP9uCQrOjc
 gX0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwQjk0sJmR8C6a/tepNh03AJ24+GlhqPYLL3XtYIoTiGCjnBIYJIjhozMk6RvSE0sTPlMvMOnmYvwMibjVt5udYoATml8=
X-Gm-Message-State: AOJu0YyN+Q6zVDYzNnxtBGmd42GLDICzQIwzGVMaj+DDh9NMIWlv6rEj
 oIluKQ7bjMLgXQ5P8+/eyYLPlFr4tPHTO3ROE7wjO80m2R4Spew/Ddzg1t925dlAp39zHKn2Yi1
 T04M=
X-Google-Smtp-Source: AGHT+IG0Vh40VErDTYK+K1xLuxxmZfAnq64VStSDXK7yAiAlO+pRXOseEx8yaCHpVC/I0+fw33MX1Q==
X-Received: by 2002:a05:6870:e38d:b0:264:9161:82e9 with SMTP id
 586e51a60fabf-267d4f346c1mr11042022fac.41.1722291952608; 
 Mon, 29 Jul 2024 15:25:52 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f9ec3bf6sm7651062a12.60.2024.07.29.15.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:25:52 -0700 (PDT)
Message-ID: <99265a8d-6a0c-42a3-843f-673f014adce7@linaro.org>
Date: Tue, 30 Jul 2024 08:25:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] docs/devel: document how to run individual TCG tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-8-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> Since 6f6ca067d2 (tests/tcg: add some help output for running
> individual tests) we made it easier to run individual tests for a
> given architecture. Lets reference that in the developer
> documentation.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   docs/devel/testing.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

