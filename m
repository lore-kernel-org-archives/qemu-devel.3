Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D37C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 22:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdeLu-0002Um-EW; Fri, 23 Feb 2024 17:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rde0X-0004qU-Fj
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 17:27:14 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rde0V-0006Su-5x
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 17:27:05 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5a027fda5aeso680891eaf.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 14:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708727221; x=1709332021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h6sS8PkCJMQluzisGMcenbsk9akHBkUGAnM7ELliy7E=;
 b=QzO5pAuNIlF84twPz3zeWS4Qa0mJerz1yN6Xhp1oIY7qfoU26YzDFsqiVlk7rvflEj
 MJ7/KC2i/3vgy+s0Nk0XbqDMrJZJO1jbSMMgqaUdxsv4F4YiCdUpDTwcpeYfRJc4HiHS
 invCjfsbf8myyxz0djCX1QCuT9j4fO7AkK1YGSKO4s9oQ+RHgMDF0nleCGqvXA//dwSm
 6edyaLeJJs4qDLY6C8D3K7+0jAQCOdEd6xnwwVWg1t0tCQIWh+aby8MZJTITUjwD7mmh
 SC/hlW2gMx+oLh2vI7aVX0+ST3TgGJ7MYOeYvng56hr0YqU2I8dGp0sOPAc1p1OnOwvj
 CA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708727221; x=1709332021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6sS8PkCJMQluzisGMcenbsk9akHBkUGAnM7ELliy7E=;
 b=u9CPITlfS8xaDYzWcENTBnRwHDzBvFP6CrbLKfo46Rg5WuqihLMNZfNfTMOl5J9DNP
 ZPmDZpnL0TUGbXag/hPObDitMnDZ7hbZ5UYi1dpIHptwFzSls+OWWP7+Q1BPcfGsQMHb
 Xzmax/UYOdsuYd7mXzt8Sq6oDn1/fhcYIEDtaI27jSRc1RTbwS7JWgs9QcZALS+RYk2Y
 mlmB+KIk3EFvQa5NmSPYwkJq8x1LiZjpCdDehstz7XfPhFyaUKQH4esS51ZNqgpptN++
 3f/WylSjNkcU6/IY6IW0ksoczhWXXkeuMJg8rbFdYw+BSmR68LQjm8M5xYWO2AGF8wHn
 ZQzQ==
X-Gm-Message-State: AOJu0YzbsrLJBOEp+KUxyqRx/CGY4vbfmNFtb/51tkGmYovPzbIbdqhI
 tYH5F0yOwOd1sYfIscvwyiUme/4MGbOMoIYQmDzH7fITuqmINcNSwXIoHdbfs9A=
X-Google-Smtp-Source: AGHT+IECou8zA6cR+Sf7ewDVM8qFG+SkCdRjZMYq5GcwDukkU7WXOfK1qDDuA/Lw04lEkdwIvOyCcw==
X-Received: by 2002:a05:6358:7f9d:b0:178:be64:c3bb with SMTP id
 c29-20020a0563587f9d00b00178be64c3bbmr1608571rwo.14.1708727221490; 
 Fri, 23 Feb 2024 14:27:01 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 s23-20020a656917000000b005d8b2f04eb7sm11054487pgq.62.2024.02.23.14.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 14:27:01 -0800 (PST)
Message-ID: <d4fadd4e-5f5f-41b3-9152-fe94a1e9fefb@linaro.org>
Date: Fri, 23 Feb 2024 12:26:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/39] tcg and linux-user patch queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240222204323.268539-1-richard.henderson@linaro.org>
 <CAFEAcA8jChwScfQikL+0wxHJgdnLz8_Ed-RKmZ4-UFMhWShkqA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8jChwScfQikL+0wxHJgdnLz8_Ed-RKmZ4-UFMhWShkqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 2/23/24 03:45, Peter Maydell wrote:
> bsd-user fails to compile:
> https://gitlab.com/qemu-project/qemu/-/jobs/6241616724
> 
> ../bsd-user/main.c:379:30: error: use of undeclared identifier 'arg';
> did you mean 'argv'?
> if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
>                   ^~~

Grr.  I think it is An Error that make vm-build-freebsd does not test this.
Alex?


r~


