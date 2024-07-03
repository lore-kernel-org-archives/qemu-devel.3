Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4060AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvXv-0003eZ-HD; Wed, 03 Jul 2024 04:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvXc-0003aS-T6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:40:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvXX-0003eQ-Al
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:40:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42565670e20so2207455e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996033; x=1720600833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=67INKYe0/0fw4nNGKrd+W7Zo/eNs/qRSWAEnaczS/+s=;
 b=LMStGL8EoQtMIsspHNAB13t4A/7lFyAiY4p469H2bKNGUe00yul7So7Qv2t8WAvSFf
 BKm+W4xiaS/C14IXjZlLAVaAdH5GHfFwu/fUlXGJW7BIM6n8MeV8Q9g19O1CCgGqBIRV
 MBfc1pNoSxCNZBDnhSuKbkmXAV786MlK4puBqEl+swdE0CXCYTdoHoeNIu3CHn3joydV
 wDjI7FfrxFfoU9R+GLXWM/g/fsycf5UoJjr8NUnWajKQ+xdbkQKn4Dt87bwFv4P5gV0Q
 4PveX1klTrFLhwE02JeAFMDxMtXOR0QzdvNhFCtboYSEOjA7ocnI9IDWprYptTD43UUd
 wlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996033; x=1720600833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=67INKYe0/0fw4nNGKrd+W7Zo/eNs/qRSWAEnaczS/+s=;
 b=e1frodd4appjU+Zoxw+K1jakWDxj+xaIOLIkXmuTkbIERyrWuaDAavdYJbsrhbgNmz
 7p7YZEld4Tx2AdFIxfXUQF5bXp8zls/NvBpgmu5HvibEKwXXpXJ81omNel8kYHxwhT5v
 BJ9hXlfIyH8B9LUpkyEh7I5L0j4kbvGink93SVu2Vc0xfS1DaeLCKEL9FmWcQHEektv2
 y1Qdi1Q6HkdtlxYIgRsYrPFLrfyk/vI4Gu50+fELXRM0jhm0geTTt1bPQl3ED0ylN1eo
 5+gcjx9nLv8TNCHye/Q+qBc0fb153HmFvzrKPKa72K7TBWhzKJSpsA80hSMroAWI5Aa6
 UfTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8QzlLWJ1F5+XGqcVcLqip14FNFRPYJTQiJ5kHLCS4HCeR33wgfz8i/+lC8xlCdeYMvVEmMEAJWRF2jyLbVF5OsdeMv5o=
X-Gm-Message-State: AOJu0YzhdSvfZrERk3bw7KhVZcuWPb0yRwayMUXt5fFdiRAjkiQQfW2L
 5gq3wpkNdlnbWRmSSkEjZGXGsv4Cz7V5+eh2DrTdi/g0BUa+WbTWxd2O4LL9sqM=
X-Google-Smtp-Source: AGHT+IFEi/mqyxqBvapJINuUoiwE5AfWzsH1i7RnHLhEnFD1Z8bSA5PIUz/kee5WrFZSqkAV49oLsA==
X-Received: by 2002:a05:600c:5249:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-426408eb490mr8065395e9.6.1719996032837; 
 Wed, 03 Jul 2024 01:40:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257cdf4982sm150807765e9.47.2024.07.03.01.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:40:32 -0700 (PDT)
Message-ID: <a3221816-dd71-4805-9ec0-5d3a949f690c@linaro.org>
Date: Wed, 3 Jul 2024 10:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/22] qga: move declare of QGAConfig struct to top of
 file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-14-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/6/24 17:44, Daniel P. Berrangé wrote:
> It is referenced by QGAState already, and it is clearer to declare all
> data types at the top of the file, rather than have them mixed with
> code later.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/main.c | 44 ++++++++++++++++++++++----------------------
>   1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/qga/main.c b/qga/main.c
> index 17b6ce18ac..647d27037c 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -70,6 +70,28 @@ typedef struct GAPersistentState {
>   
>   typedef struct GAConfig GAConfig;

Matter of style, personally I'd squash within the
typedef.

> +struct GAConfig {
> +    char *channel_path;
> +    char *method;
> +    char *log_filepath;
> +    char *pid_filepath;
> +#ifdef CONFIG_FSFREEZE
> +    char *fsfreeze_hook;
> +#endif
> +    char *state_dir;
> +#ifdef _WIN32
> +    const char *service;
> +#endif
> +    gchar *bliststr; /* blockedrpcs may point to this string */
> +    gchar *aliststr; /* allowedrpcs may point to this string */
> +    GList *blockedrpcs;
> +    GList *allowedrpcs;
> +    int daemonize;
> +    GLogLevelFlags log_level;
> +    int dumpconf;
> +    bool retry_path;
> +};

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


