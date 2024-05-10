Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9583FC25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 15:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5S1Z-0000aQ-MC; Fri, 10 May 2024 11:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5S1U-0000Ts-U4
 for qemu-devel@nongnu.org; Fri, 10 May 2024 11:19:01 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5S1T-0008C0-A7
 for qemu-devel@nongnu.org; Fri, 10 May 2024 11:19:00 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so575637266b.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715354337; x=1715959137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o+JojfD7UGkwg9QpNn+Z/HuiJfXgwjr4h7uy4Vfib94=;
 b=e5Yvy1mPV4KxENnR1C9SzF4Qwd6mQKQvRQhdj4bqLK5uexZRgB+9xSecMSWyWJxOmh
 6dTlNajm1rV/mmf1pG2Rldb/3hvB7k7qYUZL7lB3KiMaxb8rYn1xFiCKvYdKliCEno/H
 EyxRaCYScuLIoY9scShjP4xOKLyezgyNhWOn4bIc9jlq1PG2yPHcctpPlYNw8W4wbudF
 s2c1Dtz5wdMMVa6eV/X8LgW3MN8YaJaCq1bonuF1dqzzzwprWU7iItwEjXW30A/+a2ao
 fWQ7d2O+emrWryJiLkCoCAQLQ5xK4Dsd1t/dK0Di9FWHC1ii2E6u/vG/1ihAOKtAUa2r
 LTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715354337; x=1715959137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o+JojfD7UGkwg9QpNn+Z/HuiJfXgwjr4h7uy4Vfib94=;
 b=xLGUnpb1zPdgg74TSywQGuRw7CNxAeCXvQUG3qYRt8vvvbT38RRksTCEzVOlxJqgwe
 BIFM0t2xWjOQUlJIRayy5dZFdICKyNTWTMJ1HHoaYRpoIg4SwrWJ5q8qUGbxZoTtHUrC
 MB0k/cmb9XBohjtGuqYtAxE0C/MxPN+8bOoPUwK0gLfV1YOeoM1P331QyLe25CspTON/
 oQm7Fga6TTxJZ7wTqBoAEtkI5d6CL+5slyq1hjmSEKzXqNA1AbXE/CjbPAJA17xKR1oc
 nprChRqKj9kaSZcP11YEiwDVHVCg+mkMA0g2bTZE1i/o8oE1ywD/txfZUNAFVruCYt6b
 gblw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUshe3LqWCY8qxJj0PQH5yIC7FEnDkiQElG08QzX1eNWP8DC0YUYr/8KLlfCszLuHe2CMFeLsIR1JJPxQKAURkqVktpWw=
X-Gm-Message-State: AOJu0Ywq7hxx6m1H44c0u0ciHtKHSSUp0ySDYgq65F9uPSfWf2nk+Ewj
 QYPYap+GUtwq3+7r0TMZltXqVDP7mKioKVrO5JwVyxzseIQh2BMbD9jzy8alQK4=
X-Google-Smtp-Source: AGHT+IH6LL+2lMj88HESq7dxAspn07d3AGSwvsVLTiBI/dBWZviDSRTKBgLSbotscUeNO29tAiMxew==
X-Received: by 2002:a50:8a84:0:b0:572:7280:89d6 with SMTP id
 4fb4d7f45d1cf-5734d597a25mr2337901a12.7.1715354337673; 
 Fri, 10 May 2024 08:18:57 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-573409d7763sm1746742a12.75.2024.05.10.08.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 08:18:57 -0700 (PDT)
Message-ID: <f99584f9-9b43-4c63-b7cd-6012eb85f212@linaro.org>
Date: Fri, 10 May 2024 17:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/41] target/sparc: Remove gen_dest_fpr_D
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Replace with tcg_temp_new_i64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


