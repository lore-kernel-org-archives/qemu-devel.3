Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8962E68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MaC-0005A0-Kd; Thu, 31 Oct 2024 00:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MaA-00059W-2H
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:14:50 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Ma8-0005t6-DA
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:14:49 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb3110b964so4077211fa.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348086; x=1730952886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J7d31BGxue2X8Pw4rOY+QdEij3GfJfT7MLA+8nCL8lY=;
 b=WViqcZXcIjKxZ7mzwacrdGMjA0h/xtECsfY48Zrxub+y+iFUnM7kNdFtYTtdWruPMl
 4FTZJQyojdojLgWaDTsTRJr4iJYswI3UqJtnDGao78Qh3GDOIwraEUU4kyGYbE74SB8l
 EoPiB1cXziAj/CyxFS+YGzik7yEOBQbR1SyW5yd0keJoRlHB5WNqEK8oyoqMIY/Z6Bf6
 KY1obt3IRFR+nslykRUBdXnoAjjGzWknZzxOd5pks5zg9Hm3S2SENyy7CIsPrxJQ11qT
 hA5iABrVLKC2x7oEB9S+DAtpQg/MDrEGHcD7lhY1csLkdY7urhXKMxkTXm8hLp2XUn6v
 t4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348086; x=1730952886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7d31BGxue2X8Pw4rOY+QdEij3GfJfT7MLA+8nCL8lY=;
 b=n1XRt6WdKIDuV1LkGhfLmWgsYrM/w88tzXCfVCfN8XqA53SDDA/0dopLpcH1TURoQU
 +rsYfXFH4JD6YhwUMr7xqnKCZaRikM6N8lIckzaYwFKZ49or5+3NC/bKIL220TkxEPRp
 n7OcxGaSH1Ru3VWFe2NRPc1WY0UnPaYyIx2Jd4moq9uaL/pf7cJKjxt4t5ZQ4l0TaL0N
 LraS3oBmiju/G6vyxljg2vdz9bJaf8r7hlMuAFYPbk6mUt0ykcvV36w+HlxsVEoyrMK+
 ykiJsQt/7GqNSDONiPDqCJO35qtzUc70jCADuR3w7iiSUHtY0wrZoaBjw0jhO02fR+mi
 8L2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVitBjqNNu4ffyMmbk0WLGhGZr9jblRrAivwi01Y6Vu4zEG3xQzlEV4AUfpN1aF/YYewY8TXOY4Svj/@nongnu.org
X-Gm-Message-State: AOJu0YyeAUplMCr5J/ywWWEH2IkGIm3UQ/gjJC5EcvGUIMavZ+FnO5q5
 x0QwoWOlNsTrdEV0+qL4e4Rg24kdYsXJpFXftHmNhHdYLDTpd2Tqv+QrYJ3LabEoImcQ32ZJDGB
 W
X-Google-Smtp-Source: AGHT+IGQ+mxuTN2uJ8P75L9xnBxb2Qvt+FqyZZ+RuExsErnr71Vx8ZWx7yBAecyYyM2l4rqzD7tzYw==
X-Received: by 2002:a05:651c:b20:b0:2fa:d723:efba with SMTP id
 38308e7fff4ca-2fcbdf6380fmr90603391fa.8.1730348086493; 
 Wed, 30 Oct 2024 21:14:46 -0700 (PDT)
Received: from [192.168.21.226] ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef3b8ecasm956691fa.11.2024.10.30.21.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 21:14:42 -0700 (PDT)
Message-ID: <afa5451d-901c-4b50-aa9d-6c4d977104f0@linaro.org>
Date: Thu, 31 Oct 2024 01:14:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] plugins: add missing export for
 qemu_plugin_num_vcpus
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-10-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241031040426.772604-10-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/10/24 01:04, Pierrick Bouvier wrote:

Fixes: 4a448b148ca ("plugins: add qemu_plugin_num_vcpus function")

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/qemu-plugin.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 622c9a02327..0fba36ae028 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -803,6 +803,7 @@ void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
>                                       qemu_plugin_udata_cb_t cb, void *userdata);
>   
>   /* returns how many vcpus were started at this point */
> +QEMU_PLUGIN_API
>   int qemu_plugin_num_vcpus(void);
>   
>   /**

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


