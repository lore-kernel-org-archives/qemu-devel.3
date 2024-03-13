Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E54C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMFA-0003iB-91; Wed, 13 Mar 2024 06:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMF5-0003cN-Mn
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:53:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMEz-0006n0-Of
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:53:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33e9def4a6dso2211071f8f.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327224; x=1710932024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UbFqnJ+K0UFOsKL4269RCM2vFlEAhVLAKKnSc/TH0bM=;
 b=wJuBCJfrrrMmdrtp518zSTwYRjU8ickmMb934AhvqcsLF5N2c017+1ZkHzAfUjuVkq
 m8SA7enjZbSrQyxqspdCgWSrCo1iWkzHrho0O+tDWxIBYTax4+jkB5sckknfxmZfqzE8
 /FJGvHMZpa6RSCrtlH2cXlkruz4q0vTfDRtPKQGcU4LJbM8E8BrbIeCKpLCF+oOKxzKE
 76G7rNeIzN9Z4PnhWbjsuO41RpIwgQWOKeGuU2Dd3qh/cOmikNmfl1+/7OcXKhazDRIM
 8xK2iITY0gO995SY1TZmgN7nflS5rRtn4iiRmht/MuZVY7CGWpgVGoJVKTrUYjjqo7IH
 c2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327224; x=1710932024;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbFqnJ+K0UFOsKL4269RCM2vFlEAhVLAKKnSc/TH0bM=;
 b=TeavYRe+ux9xhGxhjSk6Ativ0j4hcy7X/EKKN2O4YoZ67vOOn5wD56ErmkdNOKGXP1
 wQvt2Cry8tylnkxMOZzHPOtwEah9nHczrbGwxQlkSHsfxhc9HZc15QDpjHcAwOC7L07p
 Msrnh3yVilOtFOCkBzS9CcDUSphdNicMJB/5ObA25UQbnrtZarDIWzzjX3UWDbywmd2F
 vR2brAW7tF27+IBflK62Tkofh5VfaJC1FF7TQBoowHCVT3GYIijV4Q/KLQjrqQufWWUF
 VFLZY/IsDSEaeqGfKMhDB0L6ZPo2GDhivv9rY1/UOLbyz84foESE5KXmVbmMgUzQmylg
 /aaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDOdq3dwboi9QgONaWCoxYFwTEkGgg2kRoFH/ih+YiFdD0cQajxz7zCEbaXCVoPGikcMKV5ZMw3sLJn5U0u5t+atw5TzE=
X-Gm-Message-State: AOJu0YzYWzORpMWAedbCN+YgAysaPN33r++XLe2lhPYg2tOT0wXh2dcJ
 5d0UIzQkSCvXJWB4aUvCgap++6pGJkszcdoEUJgJ4lvrUkKT7/qS6gUwOlq7rGg=
X-Google-Smtp-Source: AGHT+IF9dMb69EqFqzKGSE8lWI0+AR0QtN4RfHSp/SOLRh033H67IfcRs0+X9XyEupWU6L1BLVErqQ==
X-Received: by 2002:adf:f644:0:b0:33d:d4c2:8ba5 with SMTP id
 x4-20020adff644000000b0033dd4c28ba5mr1530705wrp.5.1710327224081; 
 Wed, 13 Mar 2024 03:53:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b0033e5c54d0d9sm11371978wrq.38.2024.03.13.03.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:53:43 -0700 (PDT)
Message-ID: <885810d3-7e89-47a2-955e-688901f0e56d@linaro.org>
Date: Wed, 13 Mar 2024 11:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] esp.c: use esp_fifo_push() instead of
 fifo8_push()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
> There are still a few places that use fifo8_push() instead of esp_fifo_push() in
> order to push a value into the FIFO. Update those places to use esp_fifo_push()
> instead.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


