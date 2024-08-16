Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8221C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 22:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf5Bs-0005PT-P7; Fri, 16 Aug 2024 18:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf5Bp-0005NR-1Y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 18:12:58 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sf5Bi-0005LQ-HV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 18:12:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-201f7fb09f6so17053455ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723846367; x=1724451167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+jB2t0pzkd7OcKIlMJrfFknrqGwNWdZ7NHYp+2Jggvw=;
 b=NDnr+iEtglP84uWYfK4vS7Hyg82zxPOX17Jz2PEz3ysbX2V3FP3iNsH6SoS7vSQ1dA
 /LO9pT8QUtsA8qmUTHsgqEYS1JIi961b+nDtmZ5LZ9Ri6pqQfVWo2aYfOurx2MPvs6Qm
 zKcheiwM2wjnyMreUp/hNUrP7ceC8YCUT0tJD2SfRHfaNQ0ugXuOGeHWLBhc3fcA3CGM
 Wtj5QpDizoa5Ju8LBjIuAHHgGCzO6JL2DpKrlzYwfqhUFlc360gpEpwX7w37chgXuT2z
 cU76ZelJ5w3LE9xbFMfZfVZcpQz8CpCEkqyg5giPz8vzIFJOU5Fy/tMChYVjwfgEztTO
 1fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723846367; x=1724451167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jB2t0pzkd7OcKIlMJrfFknrqGwNWdZ7NHYp+2Jggvw=;
 b=NphRxVECMFdaxu+QijZALTzDBXdPvSEE+hzGzg+EmGgzC/61E9HqTXM0pfdwoYp5uZ
 5TPbWBgMFPSTvB/aXsnAJlNVygXWgqsvCH3raOYjw9chw8oP4XPgVXG7Too+23EBLEbM
 IL0zcUW7SykwYFNXe5UryWWyeLoHh0L1z/ttEPSvpdog+kEygDs4TFhGmm/mhE/DKx0e
 IUHS65ox6xht+Cr97bXXQK2IrG0ihiC5leMkN+EYH3eem02gfrKsraFzspHC/DNUoYSx
 furBh/fgsxWGORT5T084wibWY6RLQ+E/qQcHwboWFvIVb2KbXseVoDWPLPpI3N6cu/BC
 263Q==
X-Gm-Message-State: AOJu0YzNuRmqKpMo3v1HuW9fCLCsYMchxh0P3TLvyb/nEnLoYDRtxOOL
 GSxSboYtg2TYILkNVPq+eangVAZBioiLGo/AHGBvIICXWJObVXAYBeNBP2KvxEsPxW+FeK8ls0D
 EhC0=
X-Google-Smtp-Source: AGHT+IEZYkVBO/r1hkzvTpwjd0wm1ADzuYZo00NYjhDk99A2Mo6gmFexYM1/dpikhlNvij3CBDX3LA==
X-Received: by 2002:a17:902:ced2:b0:201:ffcb:bbcc with SMTP id
 d9443c01a7336-20203f082bamr62658315ad.39.1723846366840; 
 Fri, 16 Aug 2024 15:12:46 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201ffb8f129sm21871965ad.99.2024.08.16.15.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 15:12:46 -0700 (PDT)
Message-ID: <d369a4ea-67cb-46ab-ac8c-75c4b8a44f71@linaro.org>
Date: Sat, 17 Aug 2024 08:12:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins: Add a plugin to generate basic block
 vectors
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org, Yotaro Nada <yotaro.nada@gmail.com>
References: <20240815-bb-v2-1-6222ee98297b@daynix.com>
 <8e027dfd-4fa7-4eab-852a-6f9d649c4b53@linaro.org>
 <f6f9f742-3213-436c-8f73-d4f32da5d7d2@daynix.com>
 <748eeda6-0400-4cbb-9322-57e092afaa0a@daynix.com>
 <6c0077f8-ce8b-438e-9c3e-9a97fb074f7d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6c0077f8-ce8b-438e-9c3e-9a97fb074f7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/17/24 01:42, Pierrick Bouvier wrote:
> User mode uses a shared code cache while system mode uses a code cache per vcpu (thus, 
> translation can happen concurrently).

Not 100% accurate.  The system mode code cache is global, but is partitioned so that each 
partition has a different lock, so that multiple vcpus can translate concurrently.


r~

