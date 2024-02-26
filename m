Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48F5C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWet-000465-Lb; Mon, 26 Feb 2024 03:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWel-00043y-KF
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:48:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWeg-0000gq-Vc
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:48:13 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33dc3fe739aso722663f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708937289; x=1709542089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o4QuUVMa/8riGap4wQPSzLfqOnNru0vzY7BsLOLWHSE=;
 b=RIs65FJpUY7Q0acLr0xujBSY7T0Wtl2EYQzHSNLq/DY7JjrsHHv55flAPrT8nSntwa
 TwvldOpj3/7B91NDz80732jiqgkdZQTTZ/oUZocdgM+TtrykUjsx6l2/RlO/sIMVyd4m
 PqgOQy7w3xWLOZJY/+MfuFwH4Kxkj2Vvd9Zn2tTASbfp/OFkL+ePAyDPbMFqeXREzeZ5
 79Q2dFReeikbut64aOh2aubiX/v2U2ocVyef0ufsPLMjq0IvQjDOSspbJfAjmYB60Yu+
 fYccbA/qEZLA8Gu8g9usL8iSvVS/AfYHRkac+vVW9oRiwQcHdq8y11swBZW+wYsKVflk
 8ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708937289; x=1709542089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o4QuUVMa/8riGap4wQPSzLfqOnNru0vzY7BsLOLWHSE=;
 b=BOqJXC4M3wgOJOf5z06QUAkSgKsGcvGKR9qztwoj6XSX5cK6M3biEoFCimVnkUyPAc
 t6U3T6XXKmT0iCZ5GoTGUYO6zYr+cUsLDL7UhjXQrJkJdRbQ0AMFdxWjtn9zAYZFzC4z
 yCNrH77adfGRk9lDVSx/9YpEopfrmpkHEh7etuq3X2DTj4YhirSS6ejUOd7qB6xIEVAk
 zxKxVZHq9oy62a9YW3GIeIdtrnJSAE0jLHtZqvFbnVqlfpd2QRC8dQLsRMoA96bnZ0VT
 N5ztbU3A4NCnJXZ94UWV5UbmgRxxqlL3BKwog6lGm0yJNOnh+gIr4/7cDiuTShqp79+I
 kyAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEVjSU1uih73gsNEE72OJ04Su8HUq12jkt3EWTXAx6Ag3p4WZ0puYtVrsWQw7Rq+VZgba6iPLUbJ490RX6Tln9LXeVmlc=
X-Gm-Message-State: AOJu0YzRU+3EhPj9UrfgrWlyFUMlLCdE/opeS2b8TsIi/4wnFYfVFqTn
 mcP6ETXYOY04OF7IWYlbHZu1suSCkU3n+mLBMh8j43J+tNv/BlLRIBCPI+8DSL6DxXtDUeElkz/
 h
X-Google-Smtp-Source: AGHT+IFVVBxgIny3rkSUlHtywxq7Pi75bQ+ik9Bkyyzzi+PoX3L9SACJ47r2B4OfyMG4JGXVHQG/ng==
X-Received: by 2002:a05:6000:1007:b0:33d:8ebf:4f6 with SMTP id
 a7-20020a056000100700b0033d8ebf04f6mr4797923wrx.20.1708937289450; 
 Mon, 26 Feb 2024 00:48:09 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a5d4e83000000b0033d12895cfdsm7555529wru.61.2024.02.26.00.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:48:09 -0800 (PST)
Message-ID: <ec5f9189-9ec5-4b04-8da2-cfb9969970eb@linaro.org>
Date: Mon, 26 Feb 2024 09:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/unit/test-util-sockets: Remove temporary file after
 test
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org
References: <20240226082728.249753-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226082728.249753-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 26/2/24 09:27, Thomas Huth wrote:
> test-util-sockets leaves the temporary socket files around in the
> temporary files folder. Let's better remove them at the end of the
> testing.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/unit/test-util-sockets.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index 63909ccb2b..4c9dd0b271 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -326,6 +326,7 @@ static void test_socket_unix_abstract(void)
>           test_socket_unix_abstract_row(&matrix[i]);
>       }
>   
> +    unlink(addr.u.q_unix.path);
>       g_free(addr.u.q_unix.path);
>   }
>   

Maybe:
Fixes: 4d3a329af5 ("tests/util-sockets: add abstract unix socket cases")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


