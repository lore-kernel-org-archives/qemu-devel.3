Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5AEC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 23:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPVtg-00088y-Hj; Thu, 04 Jul 2024 19:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPVte-00088F-M0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 19:29:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPVtc-0007aE-HP
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 19:29:50 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fb0d88fdc8so5231125ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720135786; x=1720740586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w2dvW7M1iFA3FFbkY4h0dPk0JdYeO8OBVYzGyI8Z0qQ=;
 b=sSGBSgj+ZZYFAsIF221I+nrGXI90RSlNOO5FH6K6sp6ZkQF9jd3ZUMUz/52i2GeV6r
 Cvj9iPVKee3RNV+AzruqhKQpcpJhoOzjRffxVM4dJWh5lvLjU2an/o+VBREVbuu++4xa
 ZxHUlPqSMkaB3W0XIZnmGYcHv6ctquDAFzNp2E4BnAOE8N4hMh3v7mNuhdYfXB4Z2e/t
 9aaKOCRU9eRulwwsD0BvlNmd4d4BZ3mlhl0Rw1oVzgVpOjloUxjFXD6REKx2LFFAfYUq
 ULaG5w7FhoTGj4As0yHXcreHvc+NeqdzKQbiTPbS05w8JvI+xxueKgLjGj27Tz+BCo9u
 QX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720135786; x=1720740586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2dvW7M1iFA3FFbkY4h0dPk0JdYeO8OBVYzGyI8Z0qQ=;
 b=tc+yT7UlxFVqCv+YcJ8TnhtrEVS4NiQSau71a+gbdtAMQdXyzxl7DeJ3HkshvmOrSL
 gpd1NQxX/fKEt5+sFCxoNiAoPrAgKFN88//apWZ6bjf2HAopf5QIMOZaRMqSgxkoLCyB
 ceZdYSEAlntd+dE/qmhXeioyN1vmpWv1ckoOtyObNaEa1hwlihov4n5cybEn/fhMMV/3
 hQmCpn2HKx7+1PW8+oilTVFyIOa+dX/KiNeQQiIpPrkCzyYepYYsSiRnJML5NcI8wt6C
 pghPQJ/uboa2WA5lNGTAvkvuQLFrai++LVBdbVPYmEEjLoOaC78MVyNMM6Bhg1F1JkZI
 /Zvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb7VyQw6Gq9JqoMqtTIvb27n0VgX2CwhHqXDl1lzC8jEaS/uaLLpjujqa7hvhaKdcbrZbUxrrtqlFkyxmr3enFw2RgXCc=
X-Gm-Message-State: AOJu0Yy8iI9YatVDM1NwZwR2V8+ZLjOe4KD534vSvQ/6VDl2K9ZUzuKb
 4hZgcnzdXuYcSfPvD0bJSyRjHhLESowWf300UsWvB6V1lTnYMtAr0fRwok9o0T4=
X-Google-Smtp-Source: AGHT+IGax/SyC3hrvRXb0S731zxyoQUklJ61zoSdEUij4OMO+BVjO85dtpj1AqKwic9wcnuk23Bmnw==
X-Received: by 2002:a17:903:244a:b0:1f7:345a:e23d with SMTP id
 d9443c01a7336-1fb33e7ef9emr25545505ad.31.1720135786219; 
 Thu, 04 Jul 2024 16:29:46 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb48dc7220sm2535365ad.145.2024.07.04.16.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 16:29:45 -0700 (PDT)
Message-ID: <a33d67fd-878c-4f27-9994-05ff4a861064@linaro.org>
Date: Thu, 4 Jul 2024 16:29:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] tests/plugin/mem: add option to print memory
 accesses
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-7-pierrick.bouvier@linaro.org>
 <1b23fba0-ab69-444f-8299-9db4f33373a9@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1b23fba0-ab69-444f-8299-9db4f33373a9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/4/24 09:30, Richard Henderson wrote:
> On 7/2/24 11:44, Pierrick Bouvier wrote:
>> +    case QEMU_PLUGIN_MEM_VALUE_U128:
>> +        g_string_append_printf(out, "0x%.0"PRIx64"%"PRIx64,
>> +                               value.data.u128.high, value.data.u128.low);
> 
> PRIx64 does not pad.
> You need %016"PRIx64 for the low value.
>

Oops, indeed. I'll output all values with fixed width.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

