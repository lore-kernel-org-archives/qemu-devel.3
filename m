Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294CCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITBx-00070W-88; Mon, 10 Nov 2025 09:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITBr-0006sg-SQ
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:48:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vITBp-0007tR-3d
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:48:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso14247175e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762786095; x=1763390895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2DqN+FPTSpBkeMxrAGlxlUbG7G2thsuKCA3Kp8vCG2E=;
 b=EdrHkhgVa0io6eTYQU5vjWZ+NqHQIHLiqIYhOoh5vzlxLODWIjYJnaJdKhKhdozaXc
 n7xD1dTrBdYhH4+yCVQMuuPclVFlTFb7mB+7URqW1HNlv8NPlrEX3n0y+HbvHCF3/zAQ
 8YHjKwuOE3DaPu8aU6WVjIoKYY0x34L/CurC3KoWmDMeWhIvdSS50DlKxpvSabPQrhWl
 pyyW+naBp4QeS4loFHyKOGoZ8FthIlysa4SYIXIqL4yokwWWKxZOYU3wuLzLiE5FpIsy
 qAMAnuV4UYHNJ5BAFwReecbjEpsEr5fJ9RTJ8/7H2J7lVfHO3RMLwc8kHcHvvSc4SBsR
 GWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786095; x=1763390895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2DqN+FPTSpBkeMxrAGlxlUbG7G2thsuKCA3Kp8vCG2E=;
 b=abAE89aqK0HTY2OgihqR1UD8AGNPGPfI41fNYxS6N5Teu1CnGG1A6DYk9nV5d4qYUR
 DaLEiTJpPRE9X/C2W8Zy0hTdOQ0IWe4WU+qDKRohDccLYFfebSSwO5l+1/BALpBW+2Ov
 DwlM0hFFE8EYBvZodytMvS+S8HIcH7yNwJbjYWE+lWB2Dj9+a1jAXxw0Jzd67Kv6A0pc
 mXtogtZF+buGLkKEe31MRJk73loMNE1f7HfNmQ2Da+fbdRuO/qXOjJS/W5kbYqvrel9h
 tZt2vK8G4TQU804KdMSxPZ7V3W1uU06zi9U/OLBBCtvWR/zRbYCUk8KKNo4rLps+Iw2n
 +/1g==
X-Gm-Message-State: AOJu0Yx4CTaCDxCskXkn6ZB1OKQqgK0KaU8Y4uC5+lG0neu6tvPOl0vV
 DB+g47DjeylcLMHqqnx8VSVLSRi2RMUGHsYbJ2EUYHQak8douFw2UYgnPQSh+tp0zbA=
X-Gm-Gg: ASbGncsUtGpyx8R9cPwOnA20QcocAfKej7rCIKqCN7/5uYh+a2CFjtFJHWUkywj//Os
 CEdZtTaC/Prk5eYuvkN9PrSodCmimjMBEbdmbIXvPx5t1pNFBqEO6JBZ1qHBvj4/OB2p2zfVDqd
 39p63bFUIba5FFewuRODE/tjA/qSYrIQD+JL6x6c+4S9onnTmxn1ja/1oGT5rn6CL8SkKDPLTSY
 oceUNQUywfqED1iusgIlYbrVvYD9fq0jxYDx0D8rbK85jQX9ew8MgdI/++88mFIMRrSFO39WeTA
 WCbKrH11NZKLz0uMY64xJoYM812WW223JZlIBF8xufAn+SjDQ7VdBqFD/xHyvmvfL789Nf9QxCb
 i3obZVa44Zj8OvB8k0ntA/nMtp+4RYcRTLi2sVlMvIfxECXxlxsiCJZjb9LZ5GJkiuUz9YXAGhS
 T2vjcGYL0wn+soh2d7an417y9CnVrLNIHPSZwDKfN9YSPqsKs91lqdU8g=
X-Google-Smtp-Source: AGHT+IH1ArGP/5OqMJwZzl6VhfTwHpLQtZ8ctao7C/xw2ugQTXAiLtqk8Gwy3mGAAnNTbnpw7kSWUA==
X-Received: by 2002:a05:600c:8215:b0:475:d278:1ab8 with SMTP id
 5b1f17b1804b1-4776dc4ddb0mr115628715e9.2.1762786095526; 
 Mon, 10 Nov 2025 06:48:15 -0800 (PST)
Received: from [192.168.68.117] (anancy-654-1-85-43.w90-26.abo.wanadoo.fr.
 [90.26.70.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67921c3sm22933736f8f.40.2025.11.10.06.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:48:15 -0800 (PST)
Message-ID: <7ae1ee01-5d3f-4afd-af9a-ba9bc62f3541@linaro.org>
Date: Mon, 10 Nov 2025 15:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] acpi/ghes: Extend acpi_ghes_memory_errors() to
 support multiple CPERs
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-5-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251105114453.2164073-5-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/11/25 12:44, Gavin Shan wrote:
> In the situation where host and guest has 64KiB and 4KiB page sizes,
> one problematic host page affects 16 guest pages. we need to send 16
> consective errors in this specific case.
> 
> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
> hunk of code to generate the GHES error status is pulled out from
> ghes_gen_err_data_uncorrectable_recoverable(). The status field of
> generic error status block is also updated accordingly if multiple
> error data entries are contained in the generic error status block.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/acpi/ghes-stub.c    |  2 +-
>   hw/acpi/ghes.c         | 60 +++++++++++++++++++++++-------------------
>   include/hw/acpi/ghes.h |  2 +-
>   target/arm/kvm.c       |  4 ++-
>   4 files changed, 38 insertions(+), 30 deletions(-)


> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index a9c08e73c0..527b85c8d8 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -57,8 +57,12 @@
>   /* The memory section CPER size, UEFI 2.6: N.2.5 Memory Error Section */
>   #define ACPI_GHES_MEM_CPER_LENGTH           80
>   
> -/* Masks for block_status flags */
> -#define ACPI_GEBS_UNCORRECTABLE         1
> +/* Bits for block_status flags */
> +#define ACPI_GEBS_UNCORRECTABLE           0
> +#define ACPI_GEBS_CORRECTABLE             1
> +#define ACPI_GEBS_MULTIPLE_UNCORRECTABLE  2
> +#define ACPI_GEBS_MULTIPLE_CORRECTABLE    3
> +#define ACPI_GEBS_ERROR_DATA_ENTRIES      4

Alternatively using "hw/registerfields.h" API:

   ...
   FIELD(ACPI_GEBS, MULTIPLE_CORRECTABLE, 3, 1)
   FIELD(ACPI_GEBS, ERROR_DATA_ENTRIES, 4, 10)

then use FIELD_DP32() to only set the correct bits.

