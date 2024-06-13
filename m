Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8236BC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHg9r-00035I-DK; Thu, 13 Jun 2024 04:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHg9m-00034w-GF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:50:06 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHg9j-0007ST-NK
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:50:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57cad4475e0so2306760a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718268602; x=1718873402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nrdx98XNK/CiNcDQ0gSUjXNnqns2I8AbWDhnRFyKqLk=;
 b=tPX947CItN6wONY9Va33BBQA6rbf3gd5d5RhfenyqWXk18qMfjJ/WCoGdgjhtbDx0w
 DcT8mSwtFJvJdGvvzOvT4ZbpHSSIa+Tq1JVRY6Qe/F66HS3ciVI5d5XrNy+GJ5PhSAIe
 2TdZZZfwN9urQBqhp1EvFI0nmAC94wUUqGToYTYYLliViCSzBUkWH7x6wWq/MMFFEIae
 l/AUG9cXUfnvPd+J/WlgZVdfdt9BdC553BsiqcV68BSQC4wskItQeVyw9YpTyr0n4o5S
 ilVc3OHyDZYB5Aa192AHVGa7QtbRVeeQBsCQuGGbthcNOoNVAOd/IKmgj8D7ttWdjwon
 JLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718268602; x=1718873402;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nrdx98XNK/CiNcDQ0gSUjXNnqns2I8AbWDhnRFyKqLk=;
 b=VBBGHoMLP6XbP6ia+s6WXJzOqA6/zshGNnbt9mG98JY7tbLOzIWmm9NVOLIAMs1ZC9
 sc+OqZ0u17zF3uvW6L5ssBC1gJS8nYPPpobSd0yfanErHU49unMK6erDepZ6/wblzhxO
 AxwyxJZW/6IuH3uqMdTlOiHA5iX/+EgcqM2C9ojT+sLLY2948IZ93ZllCTq04bPzvVKt
 pZpYxp3Nimt3wrYpuSZyNlCbgbMUakggTCqs96twQ2aqm9wVnwKLuUXeXZUtOpKOBwXO
 mBkFp7o+Peei+TpAPBcWedHF3TyT91kK6+/4S3u1+GupabaHoYCWblnEbwagB18Zhx5C
 DzGQ==
X-Gm-Message-State: AOJu0YyGnMTq8D36Vwt5Os3ew1HBlq4PJmSLWaPijPrT/ssk3NjSTuD/
 BSBgEn7bcFXZTX0aHmTS3tMpbGa06FFYlZ74RouEc6NvSV8ZvPUmP7dZFOue06U=
X-Google-Smtp-Source: AGHT+IHU/4xjgDANYcYWpLqELeri7fZTDkaPTxxSgRXqV5dUa6cCZbU63uUozQrA6dXO/E16afgboA==
X-Received: by 2002:aa7:d153:0:b0:578:6360:aa11 with SMTP id
 4fb4d7f45d1cf-57cb4bb0d59mr1581757a12.5.1718268601787; 
 Thu, 13 Jun 2024 01:50:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdfdbsm629138a12.13.2024.06.13.01.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 01:50:01 -0700 (PDT)
Message-ID: <c826b3dc-2a49-493f-8e6d-efffbfc74f70@linaro.org>
Date: Thu, 13 Jun 2024 10:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sample 'qapi-schema-diff' output for v9.0.0 vs origin/master
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <CAFn=p-a4MOZGDd7nj_gEf0fT7nvwa40pLJ1GiGOTj3uNhSq1tg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFn=p-a4MOZGDd7nj_gEf0fT7nvwa40pLJ1GiGOTj3uNhSq1tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi John,

On 12/6/24 20:40, John Snow wrote:
> Hiya, here's some draft output of a script I'm working on to summarize 
> QMP wire format differences between QEMU versions.
> 
> This script works in terms of the QMP *wire format*, not the QAPI 
> *specification*. As a consequence, *almost* all type names are stripped 
> from this output and all nested structures are fully inlined - so 
> changes to shared data structures, enums, etc will manifest as many 
> independent changes. Similarly, changes to type names and type 
> factorings that do not change the wire format will not appear in this 
> report at all.

Do you include changes on unstable features or are you skipping them?

Possible feature request: skip them by default until a --unstable
CLI option is used.

> 
> This is still a WIP: if conditionals and features may not be fully 
> represented in this summary report.

Regards,

Phil.

