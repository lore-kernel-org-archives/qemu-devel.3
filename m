Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621AECD128D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcTT-0004yc-40; Tue, 02 Apr 2024 07:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcTM-0004xt-Ha
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:38:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrcTK-0001SE-Ch
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:38:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-415a84ea9bbso7919555e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712057912; x=1712662712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JOYj5N0y+6MDCuDdsB4i71ZiZ93XNZ466bYYcOGELQ=;
 b=x6hfV2ldfYDVWxvk/t5GzXG5Z91pKyOpIijOBAI6JIBOCVlxm7ZoD7mG5AVWRt/ICd
 mDgFwAt3M2VOCPKRCSuIOFVJYTRaERmZR99w6+XknBmujc0sZbmhddeOUpyWqCeLTMbv
 lk4KYi6VzZ19UmrvG16kafTISqOVV31MgUxPgySrGbaqzO3MMB/90xTeQyXVqhKGTbmU
 1/5o3t/LNCCgLy2m+G6fu6RsB4dXfuG2f94GfRAZqrwsX6SCZoNqt7AHfuO8PlvZr5Ow
 WxU4QlYTClrkUcrkogesJFz3kr7raz7QBeby4b87Ec7jqCO623HIbYx6vbtoaHn7XD9F
 ZNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057912; x=1712662712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JOYj5N0y+6MDCuDdsB4i71ZiZ93XNZ466bYYcOGELQ=;
 b=HtfZy2Oh5Ucwhu41GkpqGqhGqq26Bt7tj27UNI9ZpjCe5m1OpiWXh+JAj1cJ2WSbqP
 fHRXpoUNdmfR+yZJksvPyjOwXmXAcX7t9J7PTR522NXuJWjSABfpwlSOyUw4QWbjB7Y0
 sHs2cMjS8gHPlLbEvdViCUaEKwVo5/32+ExwvwU01L8U3J6jd0yHRueB41h0TOttFfEz
 QY0GvHt6ldAmTvwImqKjpcwHWiu7hGtLMUkPTtDkpNtm9+AvQxoCrDRLssfqul1dETeB
 QB2f3GzZO0j7RLi0Lag5bvRqwAXjoMW9MKxbxsBfaehvw5KKlcax7yVJ9VnhoV/TWYvx
 qVyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJuBPDS8nUP90HPfFKnH/y9hTZk3C7DPdNN2lhHJlgdrCi7Kne0EVqfhSR6ilypuvYIz0R+9wparHwKoKui9Gb1vNUZMo=
X-Gm-Message-State: AOJu0YzmtS8wk0Aak5qwgTAC0FhmSKjrtdQCgMkERu4VPRXG96bSWSpN
 wBYFu0FXgV0VE/jXnipsbE8R6vLUkzJb77m48ySDUTzr2V1XSR9Ym5XA5iCYtsQ=
X-Google-Smtp-Source: AGHT+IGx1RsrdCvaTs9T4kxebKnPuiOvxUTQQdtmmFw6mKrXpXkI6f3ev3Ekkh1k1vIH6XQf8iXUlQ==
X-Received: by 2002:a05:600c:4f47:b0:415:6cf3:ef17 with SMTP id
 m7-20020a05600c4f4700b004156cf3ef17mr1228042wmq.39.1712057912314; 
 Tue, 02 Apr 2024 04:38:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a05600c450c00b004154853f778sm16544212wmo.48.2024.04.02.04.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 04:38:31 -0700 (PDT)
Message-ID: <99ea70f4-470d-443b-abec-57436efa63da@linaro.org>
Date: Tue, 2 Apr 2024 13:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/17] esp.c: rework esp_cdb_length() into
 esp_cdb_ready()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-12-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324191707.623175-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 24/3/24 20:17, Mark Cave-Ayland wrote:
> The esp_cdb_length() function is only used as part of a calculation to determine
> whether the cmdfifo contains an entire SCSI CDB. Rework esp_cdb_length() into a
> new esp_cdb_ready() function which both enables us to handle the case where
> scsi_cdb_length() returns -1, plus simplify the logic for its callers.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


