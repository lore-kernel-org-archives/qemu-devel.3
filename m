Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DB7C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMNA-0004qK-Je; Wed, 13 Mar 2024 07:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMMy-0004gb-FC
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:02:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMMw-0008Jf-US
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:02:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-413eb712c3fso1317175e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327715; x=1710932515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5W1nqcVIiKssophBMPWMbjdS6mkm3GH9QEVl++hxMs=;
 b=Gwii47+YRN0chBY4YpWZ2ZrY4I7Ikug3kT7h1sxKVlqUxTEg01eZW1opfe+NLSlMYB
 0fvjVhuk184+l6gkTUDq43M+oYi2H03ZnJmLcPhRL4cCDVaz+3hblxYX9EjXkgKkuVzu
 nt9ULrncVZNSvUM42uH+8ImKhrMSU8Fc+Hopt5j6tLWwOwFjMkV2ePthIGGHH5LWf1Sx
 CGj2z8mpn+VDcxUSjz8H2cK88swHsBealn8UA7OCfP8/S2pwJm0VimoBviBzRb7eAoA/
 H5PSEmaGWAyFPgNfb15SBZmX0KEV52Zx52ZXjdYxQa0j+DXhVLRbSSnx9BS1eXiRJadu
 7B0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327715; x=1710932515;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5W1nqcVIiKssophBMPWMbjdS6mkm3GH9QEVl++hxMs=;
 b=IzNvqFF04D9+8T/Ni6m36C1wTRtkt3s2jR3cT40O6VALaL3cgfkgMHMXggRK1oKYpM
 b4dbhgXBv1npVZn4XAwmcVkKIqyexYgKKsLHcio5x4CX+NQeetPvvZUtDiJ5oE4T+VZ7
 OpVm0NfzaxWHKjeYLL7Wg3ItbaMWEK188NS56YGHyvKj9LiGNi3FWVHeK2ZwYShLw8oV
 py9H0Prxrc1J8ieDemyy3uhmZFjg5jzM2UGYy/aIGgECj8IUpFs1Od91k/1UIONi5ADO
 gS8HAckyfc+8SFs57u9HePZCQWymkWP4d6KeyIbGehtqWZbizB4qxUxT1ubCA4cu68gk
 pPlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx+/mB2IH+VjpEBCS4H5chgfO/RzzxbfuApcrNO35ba8hnuU7MUu4NmDDTN+tK59utMaxlB02jmRqBYUXgAtwqKgc5+wg=
X-Gm-Message-State: AOJu0YyoLOL5crdH6vzjT9xj1CmtlvYf2lM0MZfnSu3jkGiG6aIM8wfs
 aNuNWDe8Bj3UKKpweA1o1pfxjTghuLdIdfMV8Fe4IYsYRnNGwVucvGDlxdat4s4=
X-Google-Smtp-Source: AGHT+IGTtngW5tDINcmbHKo9uKUKFqC2YOobtnYkolm2F/kCKMJgvUJinW3Di2X1MXE0tKsDeHmL5g==
X-Received: by 2002:a05:600c:1e12:b0:413:ea5c:1c69 with SMTP id
 ay18-20020a05600c1e1200b00413ea5c1c69mr727025wmb.16.1710327715105; 
 Wed, 13 Mar 2024 04:01:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 fm26-20020a05600c0c1a00b00413ebdca679sm841873wmb.37.2024.03.13.04.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:01:54 -0700 (PDT)
Message-ID: <25f0bfbc-d4a5-42eb-a6a3-954291089431@linaro.org>
Date: Wed, 13 Mar 2024 12:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] esp.c: remove explicit setting of DRQ within ESP
 state machine
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-17-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-17-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
> Now the esp_update_drq() is called for all reads/writes to the FIFO, there is
> no need to manually raise and lower the DRQ signal.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/611
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1831
> ---
>   hw/scsi/esp.c | 9 ---------
>   1 file changed, 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


