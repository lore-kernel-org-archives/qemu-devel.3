Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717D7C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKKP-0003A5-VO; Tue, 06 Aug 2024 09:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbKKO-00036O-Us
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:34:16 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbKKM-0006P0-Mx
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 09:34:15 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ba43b433beso672048a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722951253; x=1723556053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+bzf7UTfWNtBZ5IHph82N7P6rbHPP38Abl59ip1cI4=;
 b=QM6MSZfKexWRGE44eIzoszSzMF8aOx3Ukr8tghzU9tLTPSuxwP1/5gc5vQ8Ilz4bH2
 VH96F8SOh8TexR+GGbVq53PsTjyHKluwcqbDdOVporKnOY6cL4Wz556fYHWISLWB9dR8
 jQel9qe5oSHNoNN+PBZcUtdY3MhbUpelToPNE0NffjZ1d3gNl5r8fqQSmJ2JhT4JrK3C
 m5ceLAjsVgLkviRElZY5W/09ojq3eV+L4eK4SXL1aHbqe0rRLEu7ZyxWF4rjNhlfl1jJ
 XFGm+q1cFjp6tEKh3Wc0HUVe5gc3RzzXtRxH5YZmmPofT63jaEoOWWbFR1PUaTW41EO0
 JPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722951253; x=1723556053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+bzf7UTfWNtBZ5IHph82N7P6rbHPP38Abl59ip1cI4=;
 b=XK7e58q1iTIS2Ak29UBjiGeg9uq5sM5llxLg3/4VIvUJ3iZ5wNRr1JN+q52ZLHCQ7u
 cxU+TzMfQYvgx8nMWUrMyk8cjYKQ6MdxL+wMiPyDyBpmiOxiJ4bD0KEUqWdJP5bRl1cE
 /1ZUrGsOPs2YNqokKJLH6TcsncJwG7AViUIPjEeh8HdwcWHg1l4S+j7rL+TpeXoe6G3c
 EV/1vNTtqtKRFxihmZ0bW3zDvpSCkyYqIj0i8Cjh8aECFRa/PgTtXfjKEnIXyC/5HVkX
 bkLMuXJRSRH7qrDv5v75uKhNBXe98itXoj0g+ohWPQn7w8YiXC9fRoed5qFrvdDGqX9J
 jaDQ==
X-Gm-Message-State: AOJu0YwHis3YWZxPgaNFZU6DsNtawouTAIxe4YLaQFJZN4FIAWma37pO
 VxPceXNQ/EMSXnVFrPAM8vSIiMJjV1VWnB3xPjvBY2fUw5mrlE3+HE+8ZUqYybQ=
X-Google-Smtp-Source: AGHT+IHMV/nm3YeCdRs4k6HXgLCdrml7n5P4WREP4DDjanQFlvvyDqiZtDNa4jhF7r5ugCVxOwB39Q==
X-Received: by 2002:aa7:c599:0:b0:5a2:2fa5:f145 with SMTP id
 4fb4d7f45d1cf-5b7f57f3128mr11459406a12.25.1722951252880; 
 Tue, 06 Aug 2024 06:34:12 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b839610c77sm6010863a12.9.2024.08.06.06.34.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 06:34:12 -0700 (PDT)
Message-ID: <48f48b08-c092-4ea2-bf07-f5377bed061a@linaro.org>
Date: Tue, 6 Aug 2024 15:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/ppc: Fix mtDPDES targeting SMT siblings
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240806131318.275109-1-npiggin@gmail.com>
 <20240806131318.275109-4-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240806131318.275109-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/8/24 15:13, Nicholas Piggin wrote:
> A typo in the loop over SMT threads to set irq level for doorbells
> when storing to DPDES meant everything was aimed at the CPU executing
> the instruction.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/misc_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: d24e80b2ae ("target/ppc: Add msgsnd/p and DPDES SMT support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


