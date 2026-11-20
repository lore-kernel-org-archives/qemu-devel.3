Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B0606A6C6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x/jz2Q4d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUT3-0001db-GD; Fri, 20 Nov 2026 14:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUT1-0001a3-Oo
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:40:15 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUUT0-0001bH-5S
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 14:40:15 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so808472a91.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795203612; x=1795808412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FXP+bnNZDIDREOssD2/+buOGcw7dtvcdrtJWu4Z3JZs=;
 b=x/jz2Q4d5kE1uEVQnucbJDj0n1DCRzBRaNribyaJV8XeVL+GQppJi6jD9ltBGENcvB
 abvKMDjmovh8wh08kK4SnZ0TxK1jFOqtHOkkE+B7sFcRg4YFJeO4woJWmhMYtNykEZhl
 Lxdr4np1LhjO1j51UL/xRarHMnu/wX4xv+jy0b+ejvl/pmL7oq3EufGGM0Rg58waMycT
 eDFZoEnPrqP7QNd8NlyqY3X2bbhe7Zp6TC7sIFQP3jnApDMahYNX6B6z2uIHOKFmnGU/
 0en+95mW0Blg1vuUVgv3Td8rAw4+P7DJNV9RvyGVvxmPT//ogHCPz+y7FdPr365znx2J
 03Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795203612; x=1795808412;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FXP+bnNZDIDREOssD2/+buOGcw7dtvcdrtJWu4Z3JZs=;
 b=DzQ2Wv1hXMkbZri8KIHV/RXEg2RPpUqdbCi37lDQ4p0UkOHt+gQn8ghCZ8f/nJasUG
 0kd5G2CuZ7gkeHspL4O1+vAGl4tmU4yw3iZGfJAqkTIFBwSMBEZezskfZd3rjkRbBwWW
 7hphzGpRDciviIwBRq9seTZeK6XC37spGkwbMrdDvAUxks0F8YZzSaT0N85d7w89DuxJ
 1VQPxOHMFD3GWs6H1eIwyAguY5dbmry5otrkFWeNOdFO6584A4uFeg7zsLwHPa0PRASJ
 gJ4XR5VAxdDvWsWWjSl+kD0DAhMUyRdoPAUw7bN9PC9wDt+Vw4zIZ+O0YlHRMrv8+lXw
 qwcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGwP0fCjtdlshrrNLETGea1c7uXQf0OlejlMNN/4SWAUEObudewGnHwCud5NSd3Kxz/MQonK6kaEq31@nongnu.org
X-Gm-Message-State: APuU4Z9/lMmCc1gT1fyCIz73wb/jrRPrpK7Xs+V/r810qbuU5G7ceI4I
 uBLV+123dmUWYkFixMKALfpwBHpp/bf4hR5QyZUOsVu72Rc6efsS6vn3fEJDHlifkdk=
X-Gm-Gg: AZFdTZdTDgV3tcNIbIsNZAYJR++hvQBD/bLPA7nXyWvHS0pY5y7d1JnkgJRa7GZsBdu
 gdb2Ip6UET4u4+mNAW+w6V0eMu0qy0H3UiBx6UgZYMdlsmTxEC9s6GuSuQkhK0MmG+dCl8rRPEO
 yLseIpQbhCmxesejlY0S/nWOce7oLshd6m2rxGSEsbGVNLvDSX1wLhIt9rJyn6a8JiTw24LwLKk
 ZUnuwx0pPqzifflYX1UBi4icYgGKxTAya5vodh9ogL5C6d3Ax+hrl7DUNV1kTBcisC7rlq4aBry
 kjMxDTSzdQrxUHvzY4jezHs/GcU9ugfrEvJfp6wtwecNTn0O4k0KtG/aaikNQ3P145XQR4YfUbf
 Qa/pm/Lim2bNl+P6aSfa91zuS5sbPkupQ/9CFgPqusoQ+6ZmfTCqDNqusNu6bq/i7D6AVkJrCbX
 juKjODOzKweLPlpAJREGowsyRP6UaxTPDCWKlb2BMkuRiEFE2FtjDbHcYgCh9nrhAyKtXotGCn0
 n8qnfB950C6lt0VG+jB+FEow06UbITymzWuBkpJ820ITpaH+G5qoJAZU3wPPHgdLIq6Yi+0qokj
 YzP78KoGJbKmu+JuHgZvyBNm61YLTdPfCK74O2MQ0oBfWvTDhGzGv8DB3oNl+H14NHIc022N
X-Received: by 2002:a17:90b:3e81:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3b41c7bc57cmr2490682a91.6.1795203612283; 
 Fri, 20 Nov 2026 11:40:12 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b776a14sm242204a91.2.2026.11.20.11.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 11:40:11 -0800 (PST)
Message-ID: <5522812c-456e-4d9d-9c26-5d992abad8be@linaro.org>
Date: Fri, 20 Nov 2026 11:40:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] Revert "target/arm: don't pass env to the sev
 helper"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ashish Anand
 <ashish.a6@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261119225514.4080-1-philmd@oss.qualcomm.com>
 <20261119225514.4080-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261119225514.4080-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 14:55, Philippe Mathieu-Daudé wrote:
> SEV needs the issuing CPU to distinguish it from other vCPUs
> sharing its host thread under round-robin TCG. Restore the
> explicit environment argument before fixing that comparison,
> avoiding a dependency on the global current_cpu pointer in
> the helper.
> 
> This reverts commit c5ec1bfad10346aefb8d7a18cea5118f2056f8a6.
> 
> Suggested-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/arm/tcg/helper-defs.h   | 2 +-
>   target/arm/tcg/op_helper.c     | 2 +-
>   target/arm/tcg/translate-a64.c | 2 +-
>   target/arm/tcg/translate.c     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

