Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0ACC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMDM-0001L2-OJ; Wed, 13 Mar 2024 06:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMDK-0001Ka-Dd
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:52:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMDI-0006cJ-Sj
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:52:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33eaafc4419so491826f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327119; x=1710931919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BvCBPzTxLJQmJLy0oW8IWgxZubfWgTOLY2MjRod67aA=;
 b=ATTBV3Li9qGuDO6trDX8aXu8Xs8mAO6dF77nclFR+e4eKAGHfg0GU3J5eE+zoz/fLF
 ElxtbENdCrrXagBiz1SWbliqI1zRtvAZHPajlWqf4zrfabcgBrp78Ejj96EgXBQVqFK4
 MKs/p7GoHQtJ6bEjXPKSLuFiv1k9u5rkHMVBiTak8JCgms9P+l0LwrTRxKSwHomMlxnM
 RXljh4HaQhQ/1A/6+dg+hLL2zTOfyqnwPF+iLeccUG+g0oatw5Ph+g/E6ntgvw8sMX/r
 5LSeCenF+PNMz7dxe0Vq+NLyE776EcZskxC/PJPpBltdWF9MQL8pPSRclIOqEOJR+IbJ
 K2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327119; x=1710931919;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BvCBPzTxLJQmJLy0oW8IWgxZubfWgTOLY2MjRod67aA=;
 b=nMwmJFxz3lBzxQTsozU9ZmisXDNMPBw1D70eKSZgZM0rUnRiOgjdP2nTTGD7YXwJki
 FmtN7s6wTaOsTIO/Gha4YN9wgq6XDRtMv3KD9xK9RdojiOdX6TXuicZKahqLp6mLlOCP
 0mmMn3LGakVXXK+msW2Z0l7qMd+fVqlgQpN5g2uAcwi7c846Tgxnqg+XA5vOfHZE29pH
 UPO3tFaoTV+INVCx3sabGt6NaNxPaP7B+St4fDSANRRrkROViiuAMMx2QpwAIC0/Tlmh
 Jv0RfeSLkZff/bzU0a6+P5WVhhRTYoKPvt2s0wacU5FnkrSm9RTT9jWtw2LY1RLU5JLu
 Dd/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuDXGQmup2I2eafspPM/ISp1g9HFquPjSx7Ij/r7W0EjhmuKNrFArtB5ZfdXE4Zwz4ZaX/HZYhc+EQKuXh60R+D46uUGE=
X-Gm-Message-State: AOJu0YzSofp83PwkmPH3LYySlS/nPb1fPW+Aq+ifdE1faA9KLiQUFft2
 kqeBfjnX7GzjFykfs2N2yXn26xyty7IzP6YKD2xNuRPUXKNvHNvZbwoUEg80m9HvEH8sYlPMA46
 rYVg=
X-Google-Smtp-Source: AGHT+IExXbZZqt+VnxhlHe0OV+bxeR3JJl2BYtmfTVcyn88+WBKVBo8zEgrHhaXP5pMEDfzTHo8fqg==
X-Received: by 2002:adf:ab16:0:b0:33e:1de4:59bb with SMTP id
 q22-20020adfab16000000b0033e1de459bbmr1806227wrc.23.1710327119241; 
 Wed, 13 Mar 2024 03:51:59 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b0033e5c54d0d9sm11371978wrq.38.2024.03.13.03.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:51:58 -0700 (PDT)
Message-ID: <57d0d222-53fc-4a15-af48-7cd253321253@linaro.org>
Date: Wed, 13 Mar 2024 11:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] esp.c: replace cmdfifo use of esp_fifo_pop() in
 do_message_phase()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 13/3/24 09:57, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



