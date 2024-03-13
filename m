Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DB8C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMFg-0004EI-JG; Wed, 13 Mar 2024 06:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMFe-0004E3-Pa
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:54:26 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMFa-0006q8-0b
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:54:26 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-513c53ed3d8so979592e87.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327259; x=1710932059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6G3yWuMhOgNIrFL9qDzMBrktR9OeP65lnKQ3Ni7jVM4=;
 b=zJxsjGusIEgrPzxlncCeo79MvzfK4z7zzJUk+XO/AHA6/L5/5i8hr2zV4BGbIgFkP4
 HQD04jcKBEGO+9JLcsCxXFqKte/fYV6IlLGIZRz+XMzAq8+LsdfGAQQJpVwfNLf6LxoE
 ATrNGpbpTGOguES/9cMKeiG5n6JArKDK3HiXHbd74edoFWjqrerP96AcwG+aIpTLCyl4
 5bvIdt2MAEjQpaGq5UA6uSLAwqnDFMVhXcrD3tc6PEqa+KQDNQjgMW64l42BoHKMXqlT
 YUWIOwKH3NdbNdcMpsH8fR6j+PumSc8nB2mssF/Ox4qgp0ec9kBRCYQovo7mImJNgKoa
 AaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327259; x=1710932059;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6G3yWuMhOgNIrFL9qDzMBrktR9OeP65lnKQ3Ni7jVM4=;
 b=ekk8u69gfrZBrbjSpOZFaFqqvIU7AO9VVKq4jK/nBLA682eIOanZW79/j1dbwKhO4W
 IZji0XXIhZkHKy374VQSq1T83APsjKbC+i7OoNPnk8rUJx49JaYH3usMg4I6+hhXMd0Z
 +eRes12cfyVH6FVrp8UPZ+ekLITnxhVPapvxNRm08GfGMP2w7qGiXS4pCUi0xjJ24h29
 tY9/4RhZir9j9hJxgetH7c7Ol5Sf4lClZUXwLRd5voUWj63MYSzZ8JtcuAHMHY6eUfp3
 kLKzWxqqpyUE74bT3LyYbMS9Mr5TzPd8k1h05lG12/xloSn9Gr9xcuCjWZ1eLYQPUony
 AZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEZKiauyV6Zo+LJihNTGT7FHVQp5qleFGnExFU2roHEtfjM5L+OmiV8nMIoTVM29PaB2vBxDq7EfV/veJIQHx6SUrFy/A=
X-Gm-Message-State: AOJu0YyL9deZcFL8blIeZWuVfQ/XEJo8DR0so7u3n3TY0FmW5KCFrun1
 WE317B7jNCCL/O57+Py9jRXOpcfuI7Cb4DEHQYqSYM0bWH7y82D61xnxqc3vt+M=
X-Google-Smtp-Source: AGHT+IHu1YaGzWIgWKY+4d6xvf8mdq5RkqfvMkil/krNe5N7eA5Wh+CpyVHObf9BFbJ2gqlLXZ/ymQ==
X-Received: by 2002:a19:8c58:0:b0:513:1cc7:ae4b with SMTP id
 i24-20020a198c58000000b005131cc7ae4bmr1797268lfj.4.1710327259007; 
 Wed, 13 Mar 2024 03:54:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d4a07000000b0033e5c54d0d9sm11371978wrq.38.2024.03.13.03.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 03:54:18 -0700 (PDT)
Message-ID: <13adaa9d-7290-4502-ad27-8020cb961e89@linaro.org>
Date: Wed, 13 Mar 2024 11:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] esp.c: change esp_fifo_pop_buf() to take ESPState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-8-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Now that all users of esp_fifo_pop_buf() operate on the main FIFO there is no
> need to pass the FIFO explicitly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


