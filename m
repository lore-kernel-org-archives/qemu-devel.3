Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FE7C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVzO-0003FN-LW; Tue, 20 Feb 2024 14:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVzM-00039e-Ln
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:41:12 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVzJ-0000sM-67
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:41:12 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so4749434b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708458067; x=1709062867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jtsDoJciM/6pUTXP3+6qHL6cvLlJnrjX38O6eUHBOtI=;
 b=afV0uWGzf0Vvb5G2jyfc3OsTiPOsDzRsQDfgxmAKWAuFcAZ44/WKt91/AjHy122FcM
 qYYRAWwhN60BMRq/mfCVdgoP6n97uVBOu1fwGEzG41R0egnVKoUwhqBwlEm9hwbFhJSp
 Q0TtBE5Mqmoe7jhUKJ3N91FlPJD38d9ytDmi6CEhLTC3RTWO9Y2ddg0rIo7cuGz/W3Zk
 M1LMrBaCyT6rAjEkELYZCCB0W3lPdPNP8brU60W01RSrjM8j/OTvo2V1owbHZYhWl9uN
 eNWJFVZKRpS1SOvkogrMpPSp51Kg7XDZ5WH2FDIPZ6XvEDfTbcqhzSL9YV6AWoS0Vvx/
 TSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708458067; x=1709062867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtsDoJciM/6pUTXP3+6qHL6cvLlJnrjX38O6eUHBOtI=;
 b=FS8Nt8MCqDNEx4Bww7SHQExMScQttoBLhbxFEc+45HPNObQ+qJOl5RYdqv5cMC5lMU
 mGG9N1at6YUCBbP2odtf2y/6RQLxCr5QlSvbw+4+q3HZvB6ffpIGTm5HWKf25KoONkC3
 o93hSOlOEmVO6/kTmHNd31InSHV+Z/BrKK9wpGcrZ6or2OVVRXW574UpwNh9XSH2NvzX
 ztJl2vdAz61wiH3Q2g7B16PRjdlsF2lUexY5jp3sFD0CnP7OD+dMg+471no/rdBOOmcI
 XXfB7OOWbImO7Q4cccW5mglE9sLnTUMM7o05Ozba6o764wyXiGa+gJOTg1ymEDYGZWo/
 9t7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFGbIadCXtal/WumB1mQPHaXmFFXCBzXp+XbYHPjI5Q6KA3QIWi36JkODgL5pGB7yQpYH2b+HTVIxZ7T6C9M48Gt+8T0w=
X-Gm-Message-State: AOJu0Ywi59+HzJxxQxZgaIgv+LAL6rlK5iyJp7Bi6vWIZVi1uOIoiU3C
 BvwlDstn1Bf46GXkLbYW0PC16vy15O76oPx6zXg1fbu76D5lxsoGYyI8bMvPfTs=
X-Google-Smtp-Source: AGHT+IHm5v01osjgUnHw+Sa7ulmXnroCgTRWBRFLkcfqz0+N4EhcoUWqjiBHalTSW6wQrC1nYymdFw==
X-Received: by 2002:aa7:9a47:0:b0:6e4:6650:dc9f with SMTP id
 x7-20020aa79a47000000b006e46650dc9fmr6237364pfj.7.1708458066842; 
 Tue, 20 Feb 2024 11:41:06 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 du26-20020a056a002b5a00b006e45ce4ba27sm4982630pfb.127.2024.02.20.11.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:41:06 -0800 (PST)
Message-ID: <24c1910f-b7b2-4393-a0e7-7ee8dc72b995@linaro.org>
Date: Tue, 20 Feb 2024 09:41:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hw/core: Add documentation and license comments to
 reset.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 2/20/24 06:06, Peter Maydell wrote:
> Add the usual boilerplate license/copyright comment to reset.h (using
> the text from reset.c), and document the existing functions.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/sysemu/reset.h | 79 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

