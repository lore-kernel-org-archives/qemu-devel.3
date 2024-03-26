Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD34C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 18:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpBxf-0002jm-IL; Tue, 26 Mar 2024 14:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBxb-0002e7-NR
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:55:48 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpBxY-0006Vu-QQ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 14:55:47 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dc949f998fso3497352a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711479343; x=1712084143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFhBkz2CwkDTIe1AnBh43all2ePo20R1ZVzlpzKXL3c=;
 b=F6IVu9DMljFrcjO3Srp3NljdY1iz+BZXQx9SIMlNZqPZsPqSUIpmOEw716LbX1I39g
 gHsSfuRyWuZ+/2A47UtJEditS2GGaSuJT6HOtbWBR4JIVlfxZgkwmuRxDmVlTmNOH9nk
 NxoepINHAnwwH0KqsRL6hZsYvsdVGHtw3c6XRD1nh1WEMNduhTRv7LXogmF4SM6jnz2A
 qToThBVyy0hpjm1InuYgsoISWLv4qL2xJ7LdFcXTKGUvpPXMEID8fioVQpFTx6kengCL
 0OxdWwH6OgaioLvGNccI0oiB70M/UjT+2CCbo3pG2Er5jaM9HTsFHOR6lRy1Pd0K4ZcT
 shVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711479343; x=1712084143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFhBkz2CwkDTIe1AnBh43all2ePo20R1ZVzlpzKXL3c=;
 b=jHMdQO1OhfjlrPnTzAznYhr/vM91ajA0NA+toviw6rmaxmaxU9N/+z4yc4zGDnwtM3
 gtE/T+4XZ9HuMYmmInKg3zV1yCRAYfvF/p4yil7qHs+gDH+2ftl7B3CY1ZQ/LvMJj5pj
 u5450SJ2R6RfOUuCggEV+yVb6sAMaGgN6PD+H25+VmN+5+bCt+qETCs7UUkdVW0kGZi1
 FcCUePH9vWPPjESU3Ujkxq0q4JbaPrRB9zLCTznajIF0wpvwt0iyg4lVHKLzRyTZmTCl
 wDsLAmgz2BB9MNlWJzg2JcOjzTzERmEEy6O9AlSnAXDv0BSJZLjASFQfGo0kH+BioOuf
 DilQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfmBwfxquJ48VWyxLQifm8DOHTL+U/AENJwO01GwHM08pU5suCDdiL9wdpIy5vGPab6RVS8dQ4UsPe6GD7p8cTNWvZD/o=
X-Gm-Message-State: AOJu0YyPG9O6Z2AlfYQGDNpfUYGa5bi2nEqqJaRDcPoFzFYtpRDKwbSU
 roBvtqeFMo0m2nzwRiAWTNwRtjXSTIpgJWQ/ebA0pCK86TsHZX1ESasLDTpX/78=
X-Google-Smtp-Source: AGHT+IEm3MtYlad+dGbzCgMRBnFvW5Pic+ZE/Ged83aIvhg/qxQk7nfrW2ubHJhpydcHXzBX2wBZ9g==
X-Received: by 2002:a17:90a:888:b0:29b:6f7d:b7aa with SMTP id
 v8-20020a17090a088800b0029b6f7db7aamr7847270pjc.13.1711479343217; 
 Tue, 26 Mar 2024 11:55:43 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x8-20020a17090a164800b0029de1e54bcesm13438789pje.18.2024.03.26.11.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 11:55:42 -0700 (PDT)
Message-ID: <c020d557-eb54-43f7-94a7-e5a0b06ccd1f@linaro.org>
Date: Tue, 26 Mar 2024 08:55:40 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] tests/plugin/inline: add test for conditional
 callback
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20240326123426.761473-1-pierrick.bouvier@linaro.org>
 <20240326123426.761473-7-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240326123426.761473-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 3/26/24 02:34, Pierrick Bouvier wrote:
> Count number of tb and insn executed using a conditional callback. We
> ensure the callback has been called expected number of time (per vcpu).
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   tests/plugin/inline.c | 89 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 86 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

