Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED27C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMHq-0006xZ-Nw; Wed, 13 Mar 2024 06:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMHk-0006kA-Ps
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:56:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMHf-0007NB-MW
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:56:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-413385f1a0dso9997805e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327389; x=1710932189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CROdx12QKl/1CF1N/rB6ZStXhwFFSus0g/BOxVcdlUw=;
 b=Wq2TJDIL5RIxBfthsAXovDqQMAPTz9snIVyYF+rRCM9MQqUCCs5RBZ/ZP3QE6zYkTm
 5Uy7Fj6ohce7DcIKbMRS7qon4ALbMmfHODu/0qLIzMuUMPulr2k7mzlvz2bCkF+MoxMz
 hsAS/UTdamqF/gqp6+OlmuGUj0qdDbr23mFZdMUpAcOmG38s5SLblq7KFAWUu3UJ0Mbx
 5UFvk2mNnabm0A+whL9nLeORV9u/Baz3mchVqk6xnu8Yyu+krMqDi+EWrOPvR8Owc9Kl
 OAreMl0RcdsjkFrXkurWz3eFGWzebAyW8PSJEqUAF0j+zodYgnkacimiFvHqeghHf1ib
 B+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327389; x=1710932189;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CROdx12QKl/1CF1N/rB6ZStXhwFFSus0g/BOxVcdlUw=;
 b=ITxw8Lrfz653viCkNOLvZWfNBZs0X/ItgFQwMb5ELhmdvB/2MiEgrdvrvKfCfXrWWN
 vqGmhCMW/3RR+//gHkj+yA64BknbUKzXlj6pgHSgq101a3UDlpSjK0rvOBgZivPEOoSZ
 VTziTMC1oacD2sozrIYLcH6jK6wWgGbS+Cq6AdG0FW76HYYZHszuzJ16o5d0nrF7B9LV
 kV4ZxI+blYib8VxXAEYrtpyHFDq9p4TM1/A4retRBkOZAzNY+4xTter6vwkcvpfGcpwa
 8snh8nG2Gfu+6xF/rSfi3N3ZIdrykZJwMp9lrpkf8Hn9+ElWDmm1hw8h3/NKIV9ZJIW1
 ZNjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa37wZCLNOdYasJ5l4ir7MNxKDmz+omqwiY2z6TKM9wVmwtryxLD09/LmRoxFomRfPUXTvpoAX0INyEF2J2hVqThxAsFg=
X-Gm-Message-State: AOJu0Yz8anX520rje1jlQc3nzYC4DTDS4gbbmC5b9h1XlS8QQHYjV+Q1
 s//EXLhggSl3K3C5b6oWSJ/0o3MZ9rrySvUYqhOpCMpDRB4NxNCqwFBmUt67dto=
X-Google-Smtp-Source: AGHT+IHqVlUnu5bms0Wbfd1pOkRKwSzFUfHtjvBmbh8Qa8wCgnMYSe4K7KjtaK2Oj3Uv96xe6tFhkQ==
X-Received: by 2002:a05:600c:358f:b0:413:2522:a9f5 with SMTP id
 p15-20020a05600c358f00b004132522a9f5mr7866140wmq.21.1710327389228; 
 Wed, 13 Mar 2024 03:56:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b00412cfdc41f7sm1441780wms.0.2024.03.13.03.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:56:28 -0700 (PDT)
Message-ID: <a90a7f94-df7e-4597-8953-3cb54efa4d15@linaro.org>
Date: Wed, 13 Mar 2024 11:56:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] esp.c: don't assert() if FIFO empty when
 executing non-DMA SELATNS
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-10-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-10-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 13/3/24 09:58, Mark Cave-Ayland wrote:
> The current logic assumes that at least 1 byte is present in the FIFO when
> executing a non-DMA SELATNS command, but this may not be the case if the
> guest executes an invalid ESP command sequence.
> 
> Reported-by: Chuhong Yuan <hslester96@gmail.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



