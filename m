Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0959AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rohSB-0005k9-BE; Mon, 25 Mar 2024 06:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohSA-0005iV-5R
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:21:18 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rohS8-0005oo-Jl
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:21:17 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-513da1c1f26so5228647e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711362073; x=1711966873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3G/QIbsmNP4wQJDlS08lYCChY+0ZDNPBiDpdOeyZ7eg=;
 b=WFZTHpquzZb2NZffNrE51A8OW178j/IH05KZxZp6nzFA9bujYz2xbWib3A8tZntf34
 UjTy18yyifMMm7jJSSiS0krK5Q4wOQ79yVUbVgLmBjFbkgyyc7f5MkHIboBGJbMC7QuX
 Xnf2+A2EgFXQCoF5KuVzR6xw4ouCR2n99pDtxNPSpdoYGy+SSVETQ3SuD76vhLP7NcmV
 ibk58hvDR4NdZJD3XuLIQlEgWJp/aR+b9oH9+Nds4u5pvk9SDbim/Py+wy4EoLXbldfM
 hRCoDc1zHZA8maC+PpXq3ccw8p1NIsnPlD9ATh5yytCVYBlqAs+e5AL7F7sJam+nlow1
 4cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711362073; x=1711966873;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3G/QIbsmNP4wQJDlS08lYCChY+0ZDNPBiDpdOeyZ7eg=;
 b=Vv5oMo9p03/0NKMaQlrAm0vyMy6v5WW8zwKhxnyQfGbFSzat34rvIzM8ovNs9Jz9Yf
 AsfELVSzVyY2ZCI+rOfUCwX8vlJxy2WMwsHHFCVjq1EO3V9RA8poimV1hOcN7fhQkDt/
 W7yj0TPJu8vQh8fSMqaSvyyGDi/1WASdKIeahTXwe31AtkKplS5H50WFjBP5RzS5E42O
 aBThKtl401hgigYd2iHM1JG0AdGN0JYOLGctEueMS2BRyOLwb09SwNjk3bqo9+OUDvPg
 7i+EHy9DsBi3WGQRkzWRy0Gp9Qc6JzSuJ0nNz1mGEXvoJSuhE/YPJ+uq+HZVEq7SCmPl
 TyPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN3vM1swTwVtWjOvYilI6Kc+pQ+iJh3KmfSrN0FWzL0XlOK1TpdmzlocOIGdhF9Y9FY+dya4wa7KVer7FRCaPPshgCzDw=
X-Gm-Message-State: AOJu0YwcJNVgoTXIu7L4dajjU6jj5CrARiNG0un5ukz5i964sMWyuhu8
 gRv3E2dpyQyYKTuE7K0cNWdD57IY8GbwWmsoZFAS+AQMKjIToh3iB9MwNxvbzMU=
X-Google-Smtp-Source: AGHT+IHZ7M4GLayS+0MbTJH7P1XSpmsCly5ai1D0hYtQDTwMDKe0ku8ohEsLbRtfthrMlmdWtZYnog==
X-Received: by 2002:a05:6512:3104:b0:513:caf3:51b1 with SMTP id
 n4-20020a056512310400b00513caf351b1mr4224068lfb.0.1711362073330; 
 Mon, 25 Mar 2024 03:21:13 -0700 (PDT)
Received: from [192.168.130.175] ([92.88.171.150])
 by smtp.gmail.com with ESMTPSA id
 hy8-20020a1709068a6800b00a46c0191306sm2885132ejc.213.2024.03.25.03.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 03:21:12 -0700 (PDT)
Message-ID: <faf7f7af-955d-4196-b7a5-d4404e561785@linaro.org>
Date: Mon, 25 Mar 2024 11:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] esp.c: replace esp_fifo_pop_buf() with
 esp_fifo8_pop_buf() in do_command_phase()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
 <20240324191707.623175-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324191707.623175-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 24/3/24 20:16, Mark Cave-Ayland wrote:
> The aim is to restrict the esp_fifo_*() functions so that they only operate on
> the hardware FIFO. When reading from cmdfifo in do_command_phase() use the
> underlying esp_fifo8_pop_buf() function directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



