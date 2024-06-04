Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99D0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUIA-0005cR-QQ; Tue, 04 Jun 2024 09:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUI9-0005c7-37
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:33:33 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEUI7-0005dP-KB
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:33:32 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a20c600a7so6316442a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717508010; x=1718112810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yRHtjBg9/1hYx02vHTpH7vP5+aPrJ9ZCWQtdUmK19Uo=;
 b=QFvRHoMMHIdkEHuqkxzlt15cT0rNa7xmKRQNEqfKw6entkjM6a9aRbgJIfGGDn0WwK
 QnEPuy6u+6r7Ug1H8cl5BYVzT87ZUFvDRcQ1GCgLrhBD6MM4A53S0C2yPx581vGcOaeP
 ZRX/ip+nzVZQnEkHrwLn3KTx9sLTZnNShNcpd2PV5PXmGMOw5jQQvK5uzIHK3yY0pk2c
 YgqzqFOizL/1NLrNmDof/9P5qY4GbTgTXvHWWiN4zog8JM12K4LJ7+3PF/sK+sOGaYMp
 KH9HrP24IZbN0VrFGxX2yrqNeQRlbR/9APghTzLeuf4d+MNOg8QbP+BbDyX5t2UPe4Q+
 dDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717508010; x=1718112810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRHtjBg9/1hYx02vHTpH7vP5+aPrJ9ZCWQtdUmK19Uo=;
 b=wMFWuELIyS5SOGcL0GqXtWuG4fl0f6PpIpG/vpeqg4hqBP4S99JKuQlzlBOdWyOfI1
 AzWuA+Mv0+gie5XOGqurGE9JeKnmgMDpatVf089/h2zrZvcrIFMYpl+jTVD1zOhxl2uj
 5DRbBS3Lkx+QGRquSzxc87ZVYlKPKgPjjQSqt5uN5Vu0FKvCQeXrvKDIrWbYjUfo10lb
 7GzqD86F7fXd7Hzq9E+mwtDCLVX+8xa/bbC2Bdncl5TCugbJ4HYRru0SJucmttw5IKnQ
 nqRi2bbx4w3HmRAwOqNjO0l3GYqfSE8tgbXd7DGedI/f6kIt57e54zDH2Ov3SKFSXETO
 xnfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyFrx0CedvYRgWEhZuXY1jaF07+mjNUpWfOliiQPSqBhTevXBvGO0IlLkdD0cs0jO68pYByWkC0a8deMLqRwd4prlVE6M=
X-Gm-Message-State: AOJu0YwJWTTOycCQJdKsez9D/0TdkUiBb6KOEL5+g+VpCOw9Ms/UR+Rp
 iceCwVca1V5nEBp3jOAM+6BnSwHQeFYkU87qzklNOXASGPGMrxaTLi4OdT4HHbE=
X-Google-Smtp-Source: AGHT+IE9jZjXPTFeVGz44WOmXtW2gB+PdIUzma1psnfw8KiotS6N8dAlQZ81w133jCRy9caFlT1Hog==
X-Received: by 2002:a17:906:3f89:b0:a66:b27:f9d4 with SMTP id
 a640c23a62f3a-a6820be9275mr727014366b.42.1717508009898; 
 Tue, 04 Jun 2024 06:33:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f39b9294sm377688466b.180.2024.06.04.06.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:33:29 -0700 (PDT)
Message-ID: <3390c235-c98a-469e-8fa0-5690bdb27507@linaro.org>
Date: Tue, 4 Jun 2024 15:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/37] target/sparc: Implement FMEAN16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  1 +
>   target/sparc/insns.decode |  1 +
>   target/sparc/translate.c  | 30 ++++++++++++++++++++++++++++++
>   target/sparc/vis_helper.c | 21 +++++++++++++++++++++
>   4 files changed, 53 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


