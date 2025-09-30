Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB12CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3dCl-0007e4-RG; Tue, 30 Sep 2025 12:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3dCk-0007d3-7F
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:27:54 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3dCa-0004WI-0Y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:27:53 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b5a631b9c82so2009149a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759249659; x=1759854459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SPwAVZxmlSNrOaZrxkI8iwyQG2S8MXWihaQELs3iif4=;
 b=ALMJoS2MsR1zzXgQvbvX0SRRmTymiq0/mLYfFy2IuXhCBY2KPqY8Adi3rP1HSjNwX3
 sBFe5V0aSlA5QnKiFQQYK3sTWfuTHNJ31C7tXAeSdqULbzGQzGVbtRNAwsUu/57Wkktd
 X+zDGpHwLD+RjftWEbKE1GC75ai6AZWUVb3SzOx6/WgBRtzCRdpgjYDPYuUyrI0dwZz2
 meGZcMXsLxiw5oaM7zz8zSIu4ocWLtuHk5uP+rM9+8OkYB4R6NtrPQxxLVWXG6FprPF2
 StBD3eqv5kIXVBseQbk+9vp1PeEFGxQYjttX6OcD9tCpvuG7+Ixj5owTJ3tI0ZrebS7s
 7Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759249659; x=1759854459;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SPwAVZxmlSNrOaZrxkI8iwyQG2S8MXWihaQELs3iif4=;
 b=GSDeqnjCtQJehwI/4oBpr06XTznHzbUdzj6Q6sjfLTF8GjTLQyL/9j2SXt7er3F+3j
 Jj0zF8JbbkPtqMvT68VqnM8eNPfmFvn0u8E75puQa+0G2bQB1psDzcrORtAqwH9Wtfuw
 UL9/lfwPnMd+YlBKV1DGr8/vBCMMzRrLvTkVFk0+1Jv2/jQlRM8qzEO8dY2O4URFUuwO
 CFMVUd4BpgGoNTFELaiFWZXx2w1rLSCZxEr/HlkS/0zFHjQ7hyCyzCfquFEq0MPxJWtl
 OQQRV9WXvAwekKxtBfafza846lOefDL9FmAC0LEzBqb1WbvG740mn7xQ8aQHFvDH4pVg
 X62w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE3LHalpZuPP/wG9lWRZfSyQ051lmJM1+pVhNIcb6P3rngAWAEIpqMONsJGMdFNV9hELoRV5fkNnk4@nongnu.org
X-Gm-Message-State: AOJu0Ywl3rWprNsYGsReYJwHf5lQZKYAtCb5rqR1Q+rRkiKBE8CcmmBq
 gb93FpYLdSQx/SxlRjl3snt5gHyvG77W8T7DCYxseYBc0OwtAFoiGPeIlkaF7qqja8G6hxnjdcM
 HanwjBmTQdw==
X-Gm-Gg: ASbGncvTdP24XuKzOWfvmS6jZNJKqx+Jd1tZY5q40g0p+Z85uXIeCKwhm6UwydvdsUb
 mAVu446ffGLQzRUw7dcYx0srDgps6rw3195PbFIIN2HXEQa1tM46AZ8SjRSSP7YSnWmjEXOLjBP
 xKcJdl+/xtvA+TkyBSo4d+5UdQMp9SmFJOZxJ9dbT6h7rfwBfTTv+mLS3GFFP2g3HbCNvaah+x7
 Xq5pQEBlCWs7Z+IyLfRJ8mkyPbCCfLT/lluMI3M90BEvDYyKNc4J0A7uH/InyZ0uVdwDWZHegxe
 tkgkwXVZoPve9C6J5s0DMUjeCxuH/rix7xNKmlm7VaHL2+PC9caoXeZ+yLnk9MwOI9BJx/Isoh2
 jFuRrIStvZ39UwECdg2dbrLgjqctF35EWBoRPplQ5e6QuknxP7Y+d4ZVR6pPp
X-Google-Smtp-Source: AGHT+IFRglaQmXG6fYHYrEaz91F9C1JiTYzUyPN09axcLwoWBz/m4kuMIUp3ksoHQTxSzUgcfXMNTw==
X-Received: by 2002:a17:90b:38cb:b0:32e:3686:830e with SMTP id
 98e67ed59e1d1-339a6f3cd02mr61126a91.23.1759249658964; 
 Tue, 30 Sep 2025 09:27:38 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6f01566sm34609a91.18.2025.09.30.09.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 09:27:38 -0700 (PDT)
Message-ID: <fcd1c427-7686-4b55-8696-8a589b10964f@linaro.org>
Date: Tue, 30 Sep 2025 09:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/13] ui/dbus: Consistent handling of texture mutex failure
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20250930124653.321609-1-armbru@redhat.com>
 <20250930124653.321609-12-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930124653.321609-12-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 9/30/25 05:46, Markus Armbruster wrote:
> We report d3d_texture2d_acquire0() and d3d_texture2d_release0()
> failure as error, except in dbus_update_gl_cb(), where we report it as
> warning.  Report it as error there as well.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20250923091000.3180122-12-armbru@redhat.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   ui/dbus-listener.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 09d7a319b1..b82e7c7115 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -214,26 +214,31 @@ static void dbus_update_gl_cb(GObject *source_object,
>                                 GAsyncResult *res,
>                                 gpointer user_data)
>   {
> -    g_autoptr(GError) err = NULL;
> +    g_autoptr(GError) gerr = NULL;
> +#ifdef WIN32
> +    Error **err = NULL;
> +#endif
>       DBusDisplayListener *ddl = user_data;
>       bool success;
>   
>   #ifdef CONFIG_GBM
>       success = qemu_dbus_display1_listener_call_update_dmabuf_finish(
> -        ddl->proxy, res, &err);
> +        ddl->proxy, res, &gerr);
>       if (!success) {
> -        error_report("Failed to call update: %s", err->message);
> +        error_report("Failed to call update: %s", gerr->message);
>       }
>   #endif
>   
>   #ifdef WIN32
>       success = qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
> -        ddl->d3d11_proxy, res, &err);
> +        ddl->d3d11_proxy, res, &gerr);
>       if (!success) {
> -        error_report("Failed to call update: %s", err->message);
> +        error_report("Failed to call update: %s", gerr->message);
>       }
>   
> -    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
> +    if (!d3d_texture2d_acquire0(ddl->d3d_texture, &err)) {
> +        error_report_err(err);
> +    }
>   #endif

This doesn't build: https://gitlab.com/qemu-project/qemu/-/jobs/11550221970

I think you have one too many * for the declaration of err.


r~

