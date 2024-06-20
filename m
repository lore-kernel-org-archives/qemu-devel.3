Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18063C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNfy-0005Ar-L1; Thu, 20 Jun 2024 15:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKNfx-0005Ae-2G
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:42:29 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKNfu-0007Hb-H7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:42:28 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5c1d42d4470so5304eaf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718912545; x=1719517345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B8c09gyVg4suTweViKzPKTHfMFZe6PO5yiNJHqcL+Uw=;
 b=dFgxNulQhfHJt2PSPNBc2YpJgI97xB/8xONb1U6rxsrCLu5zk6Zn+vaxJt2UgjFt4V
 LjGb/oQ09Gr8wHtfRDSozR+FMPURrvMoNR62qbvfiMIb0O1CN0QC2mnm+pspobz73bdT
 UCBfeKbLYYldNZc+hGVQvQh1Qwj2tM9YqVsVwBtU7CU/EbELNJK+Rpse25XagexzrgWJ
 eGluhKdh6vnQi3QgQlrOKNueSPIZ5t+LSxg1tD2jD47MfpvwLCyzRIF9DIkn0aaJq9CL
 p55C11Lo4HxjLIsi3/JD1fdbL6nXbCBjS8BFJbvqDj0XDhbCHADjGzTaUvF3JH5YjDP9
 EHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718912545; x=1719517345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8c09gyVg4suTweViKzPKTHfMFZe6PO5yiNJHqcL+Uw=;
 b=a+DlpiBqveNP2lgKiQRIRGrdxUYy9q49Fb8NgD2i3mSl2GjdkKScYcgyJ15bFk262N
 NciL+QRTwR2bWdWViukZ4IgdBKwMla1X1m+ZLr42PuEF1wFyzXsMtz4Kn/AIuW3zROBR
 C1xyt1w0amX1Ja60+Ybl722h7w1jCmv+EnheOTS9jgVys4adXDli/KOvUX4py/mMLsqp
 rU0A7MjfzHQ+SKq5IMumX8oiAJAYSLnqmnMy5wwKVqv8RNCaz8LiOLW1dU9JDRE7nBM/
 fiXwWEraVtOM6x++XAzYD8kzDk+yG/a6ertvdNEWHXLkCRROw27iFls8HAi0Ke4scDZu
 qJeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc0VYfot7sYYp62w338BIJUesrI5U2N+s3eRzeZ9rKacjtfUVzIFkLiKliGs9xmIeQZA+z0oxbuuy+oB7IbFWGN9kXu+Y=
X-Gm-Message-State: AOJu0Yyd4tX5utJxS7chzx3yF/6PCWPet1RTevp75q9mt0Q/Vcfgr/vM
 vu/mkEHQUk9QORnmQLzfVzIfFdchFSQO76H6Mx/cvJcsBuAgBo4jmDMUrT6o60o=
X-Google-Smtp-Source: AGHT+IHE0JATf2n8P9GlJc2odLj02vFYjIQSiv4WlNCd5I4HSh4dYsyg4RppY/HdKQI5c55AYDUNKg==
X-Received: by 2002:a05:6358:78a:b0:19f:5c8c:e2fe with SMTP id
 e5c5f4694b2df-1a1fd3c5955mr769379555d.9.1718912545110; 
 Thu, 20 Jun 2024 12:42:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fee2d3673dsm11432148a12.69.2024.06.20.12.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:42:24 -0700 (PDT)
Message-ID: <bb72b78c-3b2f-426b-8d91-9252b10d6a54@linaro.org>
Date: Thu, 20 Jun 2024 12:42:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] plugins: add migration blocker
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
 <20240620152220.2192768-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620152220.2192768-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

On 6/20/24 08:22, Alex Bennée wrote:
> If the plugin in controlling time there is some state that might be
> missing from the plugin tracking it. Migration is unlikely to work in
> this case so lets put a migration blocker in to let the user know if
> they try.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Suggested-by: "Dr. David Alan Gilbert" <dave@treblig.org>
> ---
>   plugins/api.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/plugins/api.c b/plugins/api.c
> index 4431a0ea7e..c4239153af 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -47,6 +47,8 @@
>   #include "disas/disas.h"
>   #include "plugin.h"
>   #ifndef CONFIG_USER_ONLY
> +#include "qapi/error.h"
> +#include "migration/blocker.h"
>   #include "exec/ram_addr.h"
>   #include "qemu/plugin-memory.h"
>   #include "hw/boards.h"
> @@ -589,11 +591,17 @@ uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
>    * Time control
>    */
>   static bool has_control;
> +Error *migration_blocker;

static.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

