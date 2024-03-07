Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C2EC54E58
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riIlv-00008P-AL; Thu, 07 Mar 2024 13:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riIlq-00005N-Pq
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:47:12 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riIll-0006QU-6E
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:47:10 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412f62edf25so9102665e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709837220; x=1710442020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N8Qz1x9clynGqowTz32C3Vm9jSdmorRYF1B/gnKBtaQ=;
 b=snUK9C8k5jSSixxw5LEZkl/XsUjgh4jfU6EY8uwP82Wx/+8FzOqZa9QKV6QpgQ+SfH
 Bt/QzfdUFjelVibEcMQUALBpcyukaecUNQTmCqsICIWk5m4QQkO9rSINSEkWjZz3U4jJ
 0vqX/XPE/n+7lGiwncUyO7wAstV19QbLuH6SWHzpaDko1mYDZA8NOscveCJEwJJqnv5w
 hXf1GuA2BniRYeK6wNZjLQYijg1EbghufoPncSOXIC2BPHLaTPtt2bY88IDYT1nNfVbS
 xWGFoxIZ4gZeh620KdXMHfeJLTBy7YWPinS9MzcR4EdCNH0IWOc2neMIMx4lpfkI7odD
 TZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709837220; x=1710442020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N8Qz1x9clynGqowTz32C3Vm9jSdmorRYF1B/gnKBtaQ=;
 b=l3TINozRx5SvN9qd0fqNu/YM2dbvBBmNGizLXtfFUxUAXODUyei2EtSjRiKRptgvfw
 Ki9ko3DrIRi8P3ImQaD3uxfTBonRtJ/0M4Bk9n/HJ3bZlHpE2RCdPnmB3NMZdIaM3Fsj
 4uxYtuPUXsS48fFKojuqCTg6ZvLGztMc7Enp0cJfDL08JRZ6SNJc/OgDnhfBQR7gz4yN
 K7THbv8Z+e3lBSWUfV3Yv3KDlQnylPXzjjVKYZZZP5j0hWl6M0n9Tz+VXyXvgWWLBTWf
 CUzw5ohoO7gVj1/gxTYi+luzadHvE65uPKKv6e6LSfczSPi3RcRVzyLmftydyyGnV+vL
 JXDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUXILGeB9v3Yu0XQtLxbX7pZ5nB3Jt97cfZlKRqVWsDkDa9MxZKhXGxqFVf2fYvVPt4rloGZRxSvwmS3YVCn2CMJku9qg=
X-Gm-Message-State: AOJu0Yy8Qb9xoaUBFHXBcJFbxN7KsgkkPKvrlhskqKWFUI5bCR1PR8KN
 bsjUg+Mx6pCeU+96VxRZb17VIuoZMiGrJmH8AlNe1vDqCvFDmd0Rwphd5t4X8ig=
X-Google-Smtp-Source: AGHT+IHAEhZMpnHD+zXbbvPpdzj4NPYMt2hmw0FvuWLWEJCfMUMoGrvgJTKaf8o+DIJggh2kfHGGtA==
X-Received: by 2002:a05:600c:5185:b0:412:f6cd:ad8f with SMTP id
 fa5-20020a05600c518500b00412f6cdad8fmr4296215wmb.4.1709837220344; 
 Thu, 07 Mar 2024 10:47:00 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c3b8c00b00412f698af9esm3794450wms.17.2024.03.07.10.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 10:46:59 -0800 (PST)
Message-ID: <6368b121-7286-471f-8d22-7aa2bdd16a73@linaro.org>
Date: Thu, 7 Mar 2024 19:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/sparc/cpu: Improve the CPU help text
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307174334.130407-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/3/24 18:43, Thomas Huth wrote:
> Remove the unnecessary "Sparc" at the beginning of the line and
> put the chip information into parentheses so that it is clearer
> which part of the line have to be passed to "-cpu" to specify a
> different CPU.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2141
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/sparc/cpu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



