Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B901C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmPg-0007FP-Gc; Tue, 13 May 2025 05:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmPT-0007BO-5E
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:58:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmPR-0006V8-Fp
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:58:50 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a0b7fbdde7so5189707f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130328; x=1747735128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWwzifUQhEG9S2dfaswiId+/tUog3ILaSkr5hNhPhRk=;
 b=huWmelHK+XIDQEzR6+MhzEHtpyw4u/KNpZgjvos0zXQlLTY6wsHJGR6O89rQ4XuNVZ
 CzqzzqCgOY3PImBe9ycY+OxYcgRW4BECYQs1QH13rwwZAH00stoH9LeX4f0gBJ11yzd0
 igANKAevj3N3LeykNCP7POKxXlzB9vO9WSQpEyGqnUz2/v1G6GOdISJU9A+GwGRIAfDv
 pTOl8xiCjTVOf4c7TxJ5AiEHgQcpiUXUlNuYfU/qIBKTDEHcPwON5Fw4VVWiAsbWPxEF
 JAIiDWb5UW7bKP0nflrOEruZB7BJ17S+9nyO/c000MDuAIMEdKyjfVeR/K8ufoZxar5D
 bb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130328; x=1747735128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hWwzifUQhEG9S2dfaswiId+/tUog3ILaSkr5hNhPhRk=;
 b=cHjhYDTggCezdBgSKQbPzXKK35uv7U9Hqa8TuUCIbsDtYQDPMdrm3iiZVz+y8n9sO8
 xceuuUqWBm39oOIOejcrM/YLzg5UhtPr4D3T2P/3DXKLC16LWb34yqzbnCN05qW7XKwu
 0oZmAxS9fQzOF+kEB7h40wO2kUJpGcBw/91gQoxyQX80Gvdf/63b4YyjRkyyRj+VlSIc
 joDju3GGH9EKguc/rpekto42KM9UORLMLNo2kBiGgQHuMRWBSc09+F5tdvCrmKszm032
 2/TfujcZ1JUeW33KDYp1drteTyGnh8FGump4g0nHKnlwHofnGuag4f8RlLjVLESA3zbx
 8XKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNb37otnPjlrtvywJUsnSjFmxw7fD+Em4v2TXYMTcjaF5EGzxr/5ZxE+oiMlSxBPJD2r/Zwp/l2HzK@nongnu.org
X-Gm-Message-State: AOJu0Yws/RUJYZWTrDvykfqXM7l79/sjYTZ3tCHKJ0r8BQdFJ3hBZqPM
 RYNEMOeAxcjOxZdTGeUck9wkNZttMyDI1JU8R4DgWZHBCeS1Zq/1IcuoJJoyOCA=
X-Gm-Gg: ASbGncuj5b6wqngnj5wHAgJOkB+8hpGMdXaaKpl6HQFMAY9HL1jrsa4ClKBFjqz33G9
 ar+kZ3CDnS7HqS/C9z69u61GSQLvVN+s5QS3BDO6gerrKmrYqS+hNMr40m0WaeAp3E606tJ6MDf
 QxgStRKbDkQUMNesfdejOfhiuQUgGI9MZF9H+fZNSm9xp9wFBOVJCfd2m650t5j/DbMDBpXEofW
 NLDuQLWAYrmWEQNxJis747bXMdGTCv0yqoB7OEh+MY79GqXsj+wC22ULXPjTVOmSXOmSwEFSB1A
 BYAeRGA+5X9bl6hYwvgC1wQyigy0OJ89a4nSWbnjMZaZVSSKTZCFgtntp7ZmpBLx3q5A3ueVHdX
 2T5MDOVlCAIKT
X-Google-Smtp-Source: AGHT+IHcU+q59/zdO9DEwOlbB2zFdxDyUb6T9cpL38qnSxJsCqK48oFjYOiXwo545smirO9ocba2jw==
X-Received: by 2002:a05:6000:40df:b0:3a0:8383:ef19 with SMTP id
 ffacd0b85a97d-3a1f64ac258mr12823489f8f.51.1747130327914; 
 Tue, 13 May 2025 02:58:47 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ee95asm15731410f8f.11.2025.05.13.02.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 02:58:47 -0700 (PDT)
Message-ID: <05211729-41d1-4509-9312-8f60ca2a2cce@linaro.org>
Date: Tue, 13 May 2025 10:58:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/48] target/arm: move kvm stubs and remove CONFIG_KVM
 from kvm_arm.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Add a forward decl for struct kvm_vcpu_init to avoid pulling all kvm
> headers.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h  | 83 +------------------------------------------
>   target/arm/kvm-stub.c | 77 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 78 insertions(+), 82 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


