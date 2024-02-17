Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C38BC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRUx-0001dP-0t; Sat, 17 Feb 2024 15:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRUv-0001cY-Ll
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:41:21 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRUq-0008Rp-JN
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:41:21 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c1374db828so2690137b6e.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708202474; x=1708807274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7JzjLBKap7J0DbzYGpEUhSjnn0WH/hYWUzSacKN7Rdk=;
 b=OH6YDULZr4yRCBkBHFQRw7YCCewqiApRrxHDTw8eZPNJUQLLl1Glq5NR4whb5jd/Wb
 YI6trk12c27OWcqW/xFi9bd6psGoRaFVS6sarNQA1scJcltCspfgVuSCGj+lgYcglahb
 N1R2qmvzhXFBc3z/F8VBCNAPYsQvJW7wwym6HoQyv0yUXACJfL42+P76Z5qh5xbylwac
 PgDKKDYsdnWuta5Vt/kXeKqqp84USwlsz/dXyA6uzz7c03RwgLR4LEIbzVJt77FCQDee
 LcB7Z7dgqojgH3d3/5luOGFgEeSKbGCNjZVBdvUcKURN/sopd0/k587ml9ZvBeCPBpYc
 iBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708202474; x=1708807274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7JzjLBKap7J0DbzYGpEUhSjnn0WH/hYWUzSacKN7Rdk=;
 b=FdhZ2QhrvKQLZyMF5o1NHQo7Wi91o2lugaISnJvjT2fnUTCcYKkJUB7njBIzIFGNlT
 5IMNcLvQDNu1mew90jdp+0rzdSFy/nbNQJCggFzgyhowv5HjcJHa+j9+fUOriYaBtfUZ
 o1ercJOFtJ0goNAdnX5p9WPqjJoxm+uxIZM6hmsZ/0hNgYhUF+mgT+Sr3YhPopIdD52+
 O0T/utMgSAufzjj0Nb03xNE3sYrcDMPvvK7wn+nBWeS45byBK48p1H4MxPOn2TGaPudd
 O7ub7BTZ1lSokdOfIVaDZlbNW3k3vizB9wavmqQIP9yI805JczCYHL5nyk22xyvorixz
 8BWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4IHden1f6UL5fx8Cqn2fKy45f0ueoK9lbkbuOkw+mE+eZBNnm3QjWMqPJwFyZjdOII70LU1F1uoq0E/C0gkSLz14mMQE=
X-Gm-Message-State: AOJu0YwIdQJl/sKSN63TiyuHQgPNmzi/9ro+CMNiSZm3YIaC3Jwh8hB5
 1+u02tZbTVLkSaUxv3uhbDFQkF6KyZ/UITLUD1dYkdUlyTbAcReJ6hJMQLrgFi0=
X-Google-Smtp-Source: AGHT+IFS6AygoyOC4y1LWOPZSoJG6M4i4IMV1wp+brZBmeCioWUL1K7bqDY1D2ky/Mviw1WsxhwUyA==
X-Received: by 2002:a05:6808:22a4:b0:3c0:3733:bbe1 with SMTP id
 bo36-20020a05680822a400b003c03733bbe1mr10844398oib.30.1708202474673; 
 Sat, 17 Feb 2024 12:41:14 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 n15-20020aa7984f000000b006e0651ec052sm2049388pfq.32.2024.02.17.12.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:41:14 -0800 (PST)
Message-ID: <98343599-9a1f-4298-80ab-4c41c47233e3@linaro.org>
Date: Sat, 17 Feb 2024 10:41:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/display/pl110: Pass frame buffer memory region as
 link property
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240216153517.49422-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 2/16/24 05:35, Philippe Mathieu-Daudé wrote:
> Add the PL110::'framebuffer-memory' property. Have the different
> ARM boards set it. We don't need to call sysbus_address_space()
> anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c    |  2 ++
>   hw/arm/versatilepb.c |  2 ++
>   hw/arm/vexpress.c    |  5 +++++
>   hw/display/pl110.c   | 20 ++++++++++++++++----
>   4 files changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

