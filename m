Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC17C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGD-00071g-Na; Tue, 08 Jul 2025 16:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDsj-00016E-17
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:35 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZDsf-0000lS-3b
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:32 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4a9bff7fc6dso2420941cf.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752002487; x=1752607287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5gSjuATTx72GOZz467qIDKmTtfJ/K9yb+xo8zZDWtOk=;
 b=Kirt5ZXrdvRhbKeI9M03MR+uso2zRjZeMKS1X/mQIi8YPvhddf2gWL2a0DsHhZ+h+N
 la5NiiwNSkV+BnfOMmCUpFJrrXfe928thzd7RU4voAg8DUy7ZLYaqivd2EKzlGoi/wD6
 hk3xXyaGgaxbXlAVDWkY1+BLd3kDEZ7jrxde2RibkWPTs5GvYcoByObZbSc45SANyLLb
 gL0vk3ma3Wu/OmE1Vdc8HMEcC6rwCiaDCpw2S1IdFQhYNrkg8E37Ekd81av2QgdhMZ+U
 1oMakB0XbyNHohoYJcMUbydDc1jNJga/RLsSf6WdTTlTRfPp4ceMGI7H2eG5lfuKWLPH
 8MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752002487; x=1752607287;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5gSjuATTx72GOZz467qIDKmTtfJ/K9yb+xo8zZDWtOk=;
 b=oh8D++66d6aIzyIo3o5np9k9kv70zYNarGz6BBKnKdGrVxGkcStDDBXdQdzRNLXmv1
 VbkUvedq9xrZeoIiMhVbJehlsP0/7IoabuBlQzbPvgJ3MEC2Tob0Tqburf5Zs++zEj6v
 2d++y6wHa+bU15OmoD3B8dEgJc6GTSDLt7hox3xW6pI2uY7h8OIIXjRllLx7GK7KYmg/
 Ah7wbFVrVAAkoACSkQxKzKlTWCOCNMWL1N1/aM5I6kNMdtJuWeYZ2z9P4dxiiqb2EsuA
 z1d3CuHbclIoPqDNLus5N3bffhWPK5wqAS8o0OQGR+Wqy7S1P1YuuXcHv4EnG8u1K9sB
 x7SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8vOZ6h1zKMz7w/LXuCUlDrK1zM0ego1YxzHpYLg0y4aHJhFf+1g4nEud4HS3Q6aqgrSSdsGMvub13@nongnu.org
X-Gm-Message-State: AOJu0YwCWL6jj8whph4738OmkkIJWqOwsjzbFfGdTej6qzrY6rfTDCnd
 9ZPT+zjfzL+hBADTEka6t567C7hWH3sg82vlXAGPcf7t8xWJPa+QYmM1I+UxQwp7+OwHmvkTlMK
 mKuzh
X-Gm-Gg: ASbGnctEOdDgqC+j5WV9sTPBue8zPHYR7b+ibwHYlVycgANcWu+IpNIkhFkI6qANhWe
 2c0he4PhYvqBOiVHzqvV1noD91QxcCLHLa2Yur+0g0RYVG1B+dKaVxdeqZBLcPJSN3ZNVhi2TRy
 hFW/XLrazxuFEIqCloEPVsEV/EwaOHKMTn9ToZHIwaj/S9ZY0iSSTZfAZpeOIYujLkP4/x5QQfu
 anOiTMP7JVT3V6iA9Iue9B9B0i1bvcGQ143xgFpTJ0b8KTHFgHrzkjF8z7KOlfvqss0DB0LIRyk
 +Xz4g4Y6QY7x8lfmfmMLG64JNdlYrdWIPxwBX0JbsQb7dslS73ipxV2IxVBT1N7NzEtu+WLvezU
 =
X-Google-Smtp-Source: AGHT+IEkizQaQtMXancy/7xviF7/nV/9CuG4CcqSvXpkj09rbW5kDvKUk7aJ9PLQYz2Q785lGeVQJA==
X-Received: by 2002:a05:6a20:3d0a:b0:21f:4ecc:119d with SMTP id
 adf61e73a8af0-22b669e7f6dmr4910385637.7.1751995933879; 
 Tue, 08 Jul 2025 10:32:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3924868c3dsm4334342a12.23.2025.07.08.10.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:32:13 -0700 (PDT)
Message-ID: <4c89172b-1214-459d-9d0b-221347ce59d2@linaro.org>
Date: Tue, 8 Jul 2025 10:32:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 2/8] qemu/target-info: Factor target_arch() out
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x832.google.com
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> To keep "qemu/target-info.h" self-contained to native
> types, declare target_arch() -- which returns a QAPI
> type -- in "qemu/target-info-qapi.h".
> 
> No logical change.
> 
> Keeping native types in "qemu/target-info.h" is necessary
> to keep building tests such tests/tcg/plugins/mem.c, as
> per the comment added in commit ecbcc9ead2f ("tests/tcg:
> add a system test to check memory instrumentation"):
> 
> /*
>   * plugins should not include anything from QEMU aside from the
>   * API header. However as this is a test plugin to exercise the
>   * internals of QEMU and we want to avoid needless code duplication we
>   * do so here. bswap.h is pretty self-contained although it needs a
>   * few things provided by compiler.h.
>   */
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/target-info-qapi.h | 21 +++++++++++++++++++++
>   include/qemu/target-info.h      |  2 +-
>   hw/core/machine-qmp-cmds.c      |  8 +++-----
>   target-info.c                   |  8 ++++++++
>   4 files changed, 33 insertions(+), 6 deletions(-)
>   create mode 100644 include/qemu/target-info-qapi.h

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


