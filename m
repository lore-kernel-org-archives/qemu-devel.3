Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D13EC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzIn-0007r9-B6; Tue, 25 Feb 2025 13:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzIY-0007aB-O7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:04:52 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzIW-0001xt-Nl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:04:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220c665ef4cso105123145ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506687; x=1741111487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U82m7dkKC/kIuIP842fYZvqP9STmZDvfQLJOUhGWNMc=;
 b=HLacIpMNWqd+RqpXIJU9MO0/5vCmwijcva4WkrBYI64a18zUGBYH2au9R3N8JKeV28
 cO8PtS62VSgriTz0hm9/Lr4GLNjZacxTN40LaAQCiXToLU8DlbKbl/XB1ATFXmlFfbDi
 EtHw2I0QbdcO22y9kcR8DjW8B5Ioyd6LhJ4iU40OPVmOcC7yjBOZHpXKy38WHU23YOLx
 ff6k7bVv2+lSzeU/OZOIThyCXqx1dV+XDYhi3cQ1VCdcIOPCK+xxE2WQcnRXG2wse01I
 0yNZpfgtFI41oH0WL/cCpu3oFBE8S3zXo1ZAv5o6Wc8Vp7WSJ2wEFqR9LaxXtXVZFDd6
 0F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506687; x=1741111487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U82m7dkKC/kIuIP842fYZvqP9STmZDvfQLJOUhGWNMc=;
 b=w/pSyMlOYmAogMbB2DMvXru6DyJsCJEbJ9zGvOeTm/oNkw0GpmcsP6M4PLP+/vP1+p
 SWbzcqj5wdfHpOyXMNVLWwE9FQ0vnhltvU9h6xT7xVNGLNnokUWPQ8OqwC6y+5x7Wug9
 tanmkEjwi0xDVjryQ7Wci7JUchX/ZkXanEmw4/l6DnPFZAizLboUjji2qN7QW9GZBf9y
 m5+KhRQPobWSic9k3+k0sJgTnjD+29GPZU62McK3yBKVmUbFXu4Wb9NKNhqW5frs4eSx
 yezqX6Zc0I768gjLlPRfCmaMCytNA44d76L2jlgs+NM6N73yuYdtGIRDiPi0xlI0zyLg
 LhKw==
X-Gm-Message-State: AOJu0Yz1GsSiMA6jxGMqtqPyeOhzwJqtXThySWt8iZRSuvsECnPzQSLG
 9fdu0t5f2Rh3T+wMnCc3M9czdYCoyshvPNKqdyD5kuHStOLN5DPUruQqF5+C98NvHRUoUIb3+M4
 h
X-Gm-Gg: ASbGncum/PfDEja6/l2h1THyzkpvIzJyaQJPKnhdm/Dujeom2LlHr+uqfkewpr2Zcar
 mhu873u6dJkQa5Jnz1nPbVOfJKvSSqJUG5kFbDuA2F5LdreJwrL+V4NlsCWV6Ca2ER05NwuqtBE
 iOI6eGs39DuD0iHvHf8dSYtS6HviJxuO7Ek7HNQwToKE7FI/PU+v3R+qNQWgpzElV1GUAIN40/F
 MeNoK16+7z1pwj6zUrVb2JZk41LQjYDMP4dYJgr4SH+NXgeQ74NwdAsOBOyDIHnhC/IQiRmNyoG
 PgCtShmHB2bS5oH1ALVaCjFcUOGzbWMkDDhBJnc6tB1CTtg2Cv4Ndzu10VMrUF1YbNlXt8nWwE/
 UlfC7D0Q=
X-Google-Smtp-Source: AGHT+IFrERIm0sOq0bBipoDbb1ufahnWOsFAAWTazlEKxqp3o0FeK9XDVTdeGRM0Ymg26RRtMHzJgA==
X-Received: by 2002:a05:6a00:1955:b0:732:564e:1ec6 with SMTP id
 d2e1a72fcca58-73426d9915cmr26070450b3a.22.1740506686955; 
 Tue, 25 Feb 2025 10:04:46 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aeda75a056esm1692543a12.16.2025.02.25.10.04.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:04:46 -0800 (PST)
Message-ID: <c80c2db8-f68d-4463-82e4-7f3780a81768@linaro.org>
Date: Tue, 25 Feb 2025 10:04:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] plugins/loader: populate target_name with
 target_name()
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> We have a function we can call for this, lets not rely on macros that
> stop us building once.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/plugins/loader.c b/plugins/loader.c
> index 99686b5466..827473c8b6 100644
> --- a/plugins/loader.c
> +++ b/plugins/loader.c
> @@ -297,7 +297,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
>       struct qemu_plugin_desc *desc, *next;
>       g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
>   
> -    info->target_name = TARGET_NAME;
> +    info->target_name = target_name();
>       info->version.min = QEMU_PLUGIN_MIN_VERSION;
>       info->version.cur = QEMU_PLUGIN_VERSION;
>   #ifndef CONFIG_USER_ONLY

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

