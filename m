Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C56C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtA4-0000zS-Gj; Tue, 13 Feb 2024 08:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZtA2-0000yb-KF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:49:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZtA0-0006z8-2s
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:49:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso2975436f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707832158; x=1708436958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n9W+Jb0hH+wTobwNzmliQTUJnEc05+nax83krVuZs6w=;
 b=jO4SgmpT09tAC5qxppwhUMXItDL6UF+58i9k/81oQk2vtSM8aiMvRteA54Hfv5fy1w
 TM2kvRVfaRnno3ZYZfti35BdBr9ONlZfzN7aECMHY0cIotdjbPulwnlTNCa2EG9LTLJQ
 31oku5WZBkHpQCr7i6lsd5dX6x1W7shTmIH875vglH/ZtSX1HMxF9adttiJumOLo5Q6r
 04KfXIKoz+GFzPPQ40NJ4TkoRsOQorDvCJsXN7QzFcUFYxtGP6oRM+E1fCg4LymOSSgl
 nqHMGteAAJq7ThWEJGbj6BEKqJzsD0q1BmiYoEp4IchFMKOwZoTqAt9AwDHeLuQo43H8
 EMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707832158; x=1708436958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n9W+Jb0hH+wTobwNzmliQTUJnEc05+nax83krVuZs6w=;
 b=CkrpIG/9Eg/HLD8Tu8fQnwvMIsj2+vGyze23K7S7mhsVgu5TP4qwOlxEPxX20BYVW7
 uHYttXBLiD1efcT9fbPpB5wsR8pJoB4NPAsud6GsxyLBudH6PmG4mrV+iLPTkq4wcfqz
 jyP7hbfW7b+DL/t/Bqp7lwsDUy2lhgKoiw2CJfTO+Fkgkq17wfUtuSCEBZSeOyDTu7EN
 GyNHr86MCevuwkHqIdc+xtb7qIpE8HOxFFwSt2x8Dt5kNxzEdpB1lILYXjhERB5iEHJ1
 XMN/MSOiGauOtVakP3NH/Lop0JJYZkBO/uqErl8MG7y986OACpcB+wAcQNFbd7t+rLxf
 hfug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbnph9SODs3fyTBttOwSCdmV6OlX9Pdg8bhXwAwqUM6oMXc7yPZvGVPMmPH4qwED9YUrxUwH0AzyQftgKcgqGSNw5lgqI=
X-Gm-Message-State: AOJu0YyN9i162jjy3E+J/yMlTuhlwxB1jeqBeIgu0J1/CTYtXDlJR+4e
 u5D1nPiGAHsomLkiOOS76HptPaS1tXOO6NB9I9y+yrvrw+7YS0MWVjdTzWObxvQ=
X-Google-Smtp-Source: AGHT+IG6stAZTQ3nrSsxH7LYTKbVyAXtHFF7uFZcnh+w80n1cszsW0ySas9tQjP/EdN5r82XoujQYw==
X-Received: by 2002:a5d:4441:0:b0:33b:24d5:f542 with SMTP id
 x1-20020a5d4441000000b0033b24d5f542mr7831503wrr.6.1707832158388; 
 Tue, 13 Feb 2024 05:49:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUNdf0KE2iq05VhlzGy25MTX2IHwrn+Po9Bns0rm0+lyEPOxCfx4eF0HsAVfSLK9Twbk/3GgscRSyyfjctun6pi3P0+i8savV472cdJ5ViNI1ZB6+i+zTvs3JqyXTVDZyJMp6BWiwmei1sgXShJhTOzDKBIMiCp1dYGSqt/LBl8HKY2OkdHdCfOaJHWTr+f1+6eMGAfthDecKQmfXdXlsUn/UoYCBo=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adfa410000000b0033ce1ff5915sm635544wra.89.2024.02.13.05.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 05:49:18 -0800 (PST)
Message-ID: <f161b17b-03a6-4fa8-a1da-ff2df2ea4099@linaro.org>
Date: Tue, 13 Feb 2024 14:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 37/88] esp.c: introduce esp_get_phase() function
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, hpoussin@reactos.org, laurent@vivier.eu, thuth@redhat.com,
 qemu-devel@nongnu.org
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-38-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240112125420.514425-38-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 12/1/24 13:53, Mark Cave-Ayland wrote:
> Make use of this new function in all places where the SCSI phase bits are
> manually masked from the ESP_RSTAT register.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


