Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687FED591AC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 18:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD6EO-0002yA-Hp; Mon, 18 Nov 2024 13:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tD6EM-0002xV-Hj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:12:10 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tD6EL-0000eY-2W
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:12:10 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c693b68f5so33875635ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731953527; x=1732558327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oEe4aKYCCqICkCpHHVQQhZO5iDc/lYj0mFzN2UGt0QU=;
 b=Q+4JMhB2o6nBBHbgN2BpG2+HzLnjqovohRvRMUOM/OJO2DSP+u6RicWrmOY47SdJCD
 9SrP3fmNfRub2sVANe34P1KpDNIDo/qbbGejBb9Zz4w5ID4Zz7o9TZrvuQT040oSGqKc
 gbJTGI1k6vNY+HNXNDcmf6V3CkfFZVYpU4amT4yoE9bqzxsRXGie8vlpyHw1zDKVqSBl
 w2kU0lS/HUtI8Whv5XuxqjMt4iQSD6JxHzcq7cNq3sKQO0KhSYOjvaXY6QsdpOWnjjN2
 I+b/6R4Vx8nnTQRUhrIPmV91fz6nemPBOgLb1bj/7B/yu3wli85eWl/SCU4M+6ilj9H2
 ck6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731953527; x=1732558327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEe4aKYCCqICkCpHHVQQhZO5iDc/lYj0mFzN2UGt0QU=;
 b=UJncGMyfxACE6bE3VZj5dpfCMl2IUtJ5q5Swjk/xkfAWU32Zmfe8/iDKoveC+Q//Oi
 37Wk0Sfpp294XDc0DT6Nde6VXYrS5si5963ldOxe/BaLOGASEanJjikjVwDMvbHOvlWK
 JCnQS3QqZPzfFhSXrYwl4DIbykam1JhcRjxCh5S/i3PE/5qvHEeTJolpToIsRbxAO/gJ
 54Ok6PNxUa0ju8+75qhxHFqQ5yR+A7K/s2hKCIqsIY737/TuyQhbdVSgUCFNWyTu6HZs
 uq5e1An2dW3aKl84a77Scute1EdHauR4m4R7d7idzob+V1j4nMA2gMjTu7eIeC16wvbC
 7HCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbLmR3QeytfkkH2K32duiz61radRS5V4rKrj35BnBRDKPDbzcB30bnVgjoOQ96GFhKBtNssNRegsVO@nongnu.org
X-Gm-Message-State: AOJu0YzlIdB3g5v6E2QSkDs8yZE4D5hUjJLjCpvKyvNJhjcRxiXLLcEJ
 MyXiG6A1OPtsstlJeIV+S21Rnz01Cuvzyqo+apv9qhZ0XWsQNE7GjW/eC5qWah8=
X-Google-Smtp-Source: AGHT+IHSJ2CzbkLZQ6mYUghdw6lw24R6B+3Ki9pAyw/aND8qpkQStUGSMwd/hokjCVVg/gmp+4IYNA==
X-Received: by 2002:a17:902:f60e:b0:212:4582:37fa with SMTP id
 d9443c01a7336-21245823ca3mr21334845ad.53.1731953527615; 
 Mon, 18 Nov 2024 10:12:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.139.183])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72477200e52sm6751269b3a.180.2024.11.18.10.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 10:12:07 -0800 (PST)
Message-ID: <54fa63c5-e20a-4fc6-9b71-d918dadc26df@linaro.org>
Date: Mon, 18 Nov 2024 10:12:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust/pl011: Fix DeviceID reads
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-rust@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241117161039.3758840-1-manos.pitsidianakis@linaro.org>
 <875xoku5vd.fsf@draig.linaro.org>
 <CABgObfaVs-3aXKXtQRLDbzCL56gbimWZoMchYi5G+QGu8r0AxA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfaVs-3aXKXtQRLDbzCL56gbimWZoMchYi5G+QGu8r0AxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 11/18/24 04:40, Paolo Bonzini wrote:
> More reviews are welcome; in general, we should define a convention
> for Rust functions and constants (is it okay to rename constants in
> the Rust bindings if their C name is ugly? should functions keep or
> lose the "qemu_*" prefixes?).

If the C name is ugly, feel free to fix that too.  :-)


r~

