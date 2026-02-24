Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C618FF4BB80
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy1l-0006AK-8M; Tue, 24 Feb 2026 14:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy1X-000628-Su
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:24:49 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy1V-0007JT-M1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:24:47 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c6e3e4e7388so1956866a12.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961079; x=1772565879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UaN0WEk4AzrWoE2crj6EAah7PAdDbNHGlzuLj2NjaLg=;
 b=kW+QBCybeXmwxOkE4Eta0Y8vxc/Kz48L+vu2SgbDhE7c8jYjALtKaVQHW4YTE1+43x
 UObK9wFOwq+bhvPbpCSZPoqe7XnQfNlERwEg/Gk4cO77qQwTfvyxFXgFeTnVKBpSmvvi
 munALsD1nGTnJdp+8BpREmXZqUU0vCLgkw8O5yfJW1x6YViIngu1sZ3TyJdDIBh5V3dw
 AzAfIa05aka1UhqrrcgdlLKEVcKqBS9XiANv+B4WiobQeijRUxmGq4nMFz3Gh8YrHBfy
 P3TesC+AbPGQCPCxpY+9zbWfUlqBgD1jYrCiYsvL3NR9wHkLbkD1TI/HnUfM8vrk2i8S
 8DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961079; x=1772565879;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UaN0WEk4AzrWoE2crj6EAah7PAdDbNHGlzuLj2NjaLg=;
 b=oWFnQPQXEk2PmjXUDK3mv66Bd3p9h8XLLtL6RUeghnWNBZChP4CnkfzX2l3ojAv6nE
 glW+4YxqhzDfDhrAiNjV20GvHMyDur7N2Z9GlQnGChal23wORAabM3nRTHZjlA77HwMG
 LtPnvWs12nvCXQGObckVQCZR2aS4qt8Kr3RGAHC0InCYN8QFRY2KDhARG92ZHsHHMMZY
 CRYtVSNRkLgePjIiKtsJYaAVEM09vcJjbAgMlyszvKLYOP2o5yxRGPg/0g1fxAv1AOdf
 3PCZ52bNVsJ1gaTu2c60KSfT9q+TWvHLc33v1Reohy6J59cuUOIi+V1ma52EmDZLnBVo
 AtKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVK5FrFMikSEVBbGIk0UydQ+Y5RowxnsONJXEa9+FbHgYY3Q0o58638+54s4DIOmN9CZdg0puy941D@nongnu.org
X-Gm-Message-State: AOJu0YyLWUCg5xIgmHRbYS//jNiZl+mqmevCwX5dKTp3M7VKrSiiMTAY
 nZZxSDVwbaEeZVBMpIxBTB2udLr0Dj36QBAWXG2rhmGPBVGnjW6nLt4UKNzfegbKhxw=
X-Gm-Gg: ATEYQzzlqSWWGhlZLbGNEdO5qZ0cN/lLklvcYCYNWS6Rq/vQfLYBplHcKXCcmNNv7QE
 SydtdFNnqj0jlZ/sFyWT1sdB/9ktnaWyRxTLLEO3FYKACv8nKwKsM4PhqO7ULSu0zDIwB+xbXWg
 l8EeR0xGx3ByVWVHGRCuXSHctUVKCAx49ixUToFq8s+UDZkzZ9+TJ/8Y8E9Lo3h7f1AnTXHuaPz
 eyQ1sdOtuqO8IAHQwuk7rO5eB0MKnxQuzoWNkuJbgisCwIyEXgleuVjHiKVxVcfWUG6vaSbKjMU
 HpmQR5vma/3tbzLXys41ivYrrGqFeTo+A4mibFc747tLoSdxhdqVTO2GwHnm0E+Qg9PsEBRkFyI
 bJe0rGstCmk5Xj0ZEQ6u/5kNgskPesLDshmsIDyVAU0+uZ5UcmrZiarunymCJVUHbC8h192Bb2N
 8I9IBmVaXKPZDKyGn7dvlGMrTzgv26nGzJXdbvjiIEvAQk7ydMQUXDj/il90uRgzBa9Mud
X-Received: by 2002:a17:90b:4d10:b0:34e:630c:616c with SMTP id
 98e67ed59e1d1-358ae8e5e39mr10646603a91.31.1771961078772; 
 Tue, 24 Feb 2026 11:24:38 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3590241e8a2sm622480a91.12.2026.02.24.11.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:24:38 -0800 (PST)
Message-ID: <3f39faa2-17c9-4734-b25c-cf6a9c363737@linaro.org>
Date: Tue, 24 Feb 2026 11:24:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hw/acpi: Always link QOM interfaces with system
 binaries
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20260224182017.99865-1-philmd@linaro.org>
 <20260224182017.99865-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260224182017.99865-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/24/26 10:20 AM, Philippe Mathieu-Daudé wrote:
> Now that acpi_interface.c only contains QOM interfaces,
> unconditionally link it with system binaries, regardless
> of whether CONFIG_ACPI is set or not. It is now easier to
> deselect hardware models depending on ACPI.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/acpi/meson.build | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

