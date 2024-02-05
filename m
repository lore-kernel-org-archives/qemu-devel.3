Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA5EC48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 12:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWyY9-0007x5-Is; Mon, 05 Feb 2024 07:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWyY5-0007ut-Ax
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:58:09 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rWyY3-00022w-Oo
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:58:09 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33b409fc4aeso419180f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 04:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707137886; x=1707742686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+k+FSsp4d6j+KK86AEkxLK8n1MZ1js5VNKD6QuCq2VI=;
 b=ljvy64nhrcBuhQQVmDtCcgWgvDPPtGg89s6EnibWwYho8vTCku5ufjhWrCyQ/3Flpm
 pxMJ7opB2Qgu/Y6hA41swiJeJ6ktsYUEfWWa7iyqgT713y6XVO2sJ43zTtaU+4YUgNCk
 9KXBxNvFo57lbG54u8SvYyuySsK4Y9jcfLz8r+Ti1qsGtDfwbURL5VMqGB/51WaBGVVZ
 g9lHb/xe8e7kJ4zZLT3IHK1qhuRuKgkAfMP+odxseTWcknOSeuUpQbbL3+SFnxtDSnbb
 M2VIkLTGg0pxUhm+gsscXv5nV14uF1k2/OLoqTaHWtzFzpQTBwuWu06NWYvwQ+RvN2zf
 9iIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707137886; x=1707742686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+k+FSsp4d6j+KK86AEkxLK8n1MZ1js5VNKD6QuCq2VI=;
 b=YSutvpoCqD359hQka+1eJTx/cjhXSIyzXIzYk1+snPksQtTdVqWc+ZMpqw06sUNumf
 U+rjTKZXnzpj3ji16/WY7ZhA5VcyWIsw45H7XEptJ9NskK3fVbhfFn6aUJt+ydKBvHfG
 IU915zOm4SFKq6VkCW+MJ/DI8LAK9EjvKMcDWO9N43k3hRiD7AFC86KpyZ5RVDu8DNCE
 UBaWGsUSsPMQiwZJRTIRpAN0Za8efhrDLxw6ipgryVL7lQNv4DXDihErjzPxwozNoCTj
 ith16mN8iQAPvdE6UCmH6ppM4Ylq4R9jyOP1hVmvX6KHvQ/afvqMCGDnr/PK0JG9HmsW
 gyZA==
X-Gm-Message-State: AOJu0YzsurCWmE+hoVaej50JZ6JY5hV4q9lmmQbdouFkj2Wnf3X3US7K
 5Db397doo0KEAKeJLLxI8z3yuOA6RZpNV/ze8nrITtYmbXn2UWO3k/n7ZoNWByc=
X-Google-Smtp-Source: AGHT+IHiX9K+iKigiu40j8CkW4k72Xci/EzlW1B1MfzQOViV2QmnZyRIuOE3tw9GkbVLUksEb4PSbA==
X-Received: by 2002:a5d:4a0c:0:b0:33b:17e3:60d9 with SMTP id
 m12-20020a5d4a0c000000b0033b17e360d9mr5849388wrq.1.1707137885737; 
 Mon, 05 Feb 2024 04:58:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUEpguJbMC+es5JoizCGKH2lhpF1ziP/q2Rt5DICF4w6Mwgp6lgl8ZAEswXoctjIig7wv1YE98KhcIQxkyfGTnwY9EOSWax9JiUg+r4DJClS7hMH3+R1D2NKvDs3X6uK8v+RPRm9LzQmvynsinZXk/cK1NhsLbKNxKwidKS1lyCNx19
Received: from [192.168.197.175] ([92.88.170.125])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a056000018800b0033b3bb05e19sm2725356wrx.32.2024.02.05.04.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 04:58:05 -0800 (PST)
Message-ID: <678324f1-2b8d-45a1-aea8-03c187f069d1@linaro.org>
Date: Mon, 5 Feb 2024 13:58:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/cdrom-test: Add cdrom test for LoongArch virt
 machine
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20240205021318.3759925-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240205021318.3759925-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Hi Bibo,

On 5/2/24 03:13, Bibo Mao wrote:
> The cdrom test skips to execute on LoongArch system with command
> "make check", this patch enables cdrom test for LoongArch virt
> machine platform.
> 
> With this patch, cdrom test passes to run on LoongArch virt
> machine type.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   tests/qtest/cdrom-test.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> index 0945383789..c8b97d8d9a 100644
> --- a/tests/qtest/cdrom-test.c
> +++ b/tests/qtest/cdrom-test.c
> @@ -271,6 +271,9 @@ int main(int argc, char **argv)
>               const char *virtmachine[] = { "virt", NULL };
>               add_cdrom_param_tests(virtmachine);
>           }
> +    } else if (g_str_equal(arch, "loongarch64")) {
> +        const char *virtmachine[] = { "virt", NULL };
> +        add_cdrom_param_tests(virtmachine);

What is the default device used, virtio-blk-pci?


