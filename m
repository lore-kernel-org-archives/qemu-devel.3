Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C6FEE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE0S-0001tW-Nu; Tue, 10 Sep 2024 23:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE0R-0001ma-0Q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:26:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE0P-000116-CN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:26:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-718d91eef2eso321900b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025216; x=1726630016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7eODV1uHjgn2SlGVWkI/yPrh4k94iEPleJQ6XdqYt58=;
 b=HUTIRC8TR7yMIEYuW1oEz6rXgnIfmj3sFb3v3eJYpqRfITPJmIXPoLX8TsvTBJ0TJ+
 PJrg7P+Zus6dydToOGSKgDZ5P254NJ5Qw8UlFdbwS9cPUa+kCR0lfzjkAzFeZZvhvHgY
 62mHoN2jYF+3WlupHriJagryNQnSSLPM9qi5By1TZBs+lsifXyw1zG2NZNvYSmDmZoCD
 IjCO/6atq664U6l8+O3+O0hHTmaJoll7P7VrwoOhUq0SqBLeb7hurnlaNWrgvw6wEJli
 0M/14RtVpYe9qzBAh0djWJCEQqeeBJ2lYzkXSGbRlgxO7vCp59auks0qyo/Q2fDmNWuC
 9iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025216; x=1726630016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7eODV1uHjgn2SlGVWkI/yPrh4k94iEPleJQ6XdqYt58=;
 b=SCmO+ZkuROKZUf6sT6XDOHOcmtw2gvfJRy2zaEvSAmf2DNvsGYFbUc7K5yXWPSkK+m
 tbv41KUX8LUR0NOK7Fjjvpz4irQtf/uaemFJS0GgdB83GS4i31Z8VCsg4JOvZSR4W1g7
 /gFMvDUsojSwgwo4j0yxLaUei2NGJZCTmoynWDd4JvuYfTAxljbNiuy8cSFKTMfeFmDY
 mN77iPAx/O/2foZyhE0pVTh0o9+jGHt1hMgopi10mfnd2hYftpkGaNozKNTOkl5JAR75
 gyW2dV04U/3cn7wY68PDpjUNJV/O5TUI941bVuXKs0L7hyrrSqYTZgh9fRnZNhRcy7Yl
 vBlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTJro74bNrZcCo16yB7tvhwfh6Mv/njYLLR9U6LLjYnmp0KD6NLYD7U/rXOVYUQEO7DAmEKBloWLpk@nongnu.org
X-Gm-Message-State: AOJu0YwiF/040f4m0pLS+HY8M2AhzGGlelKIU8+jMYQDgIdBXg4e49vG
 czBIquDpGc80bIXR3sUzIK0DVlT2KkoyjOu8irLj9ylepHA6DLp0If++5hi4fERzYRsOUMHfYZX
 U
X-Google-Smtp-Source: AGHT+IGPRA5aLFc160ZMpFeChTHxlC4UlElaOh0z9OZV5Hit0n/NwU3F1CWskohm4kI/nFlHt5klHQ==
X-Received: by 2002:a62:e717:0:b0:717:8a7c:dd82 with SMTP id
 d2e1a72fcca58-71907f55c29mr7557628b3a.9.1726025215653; 
 Tue, 10 Sep 2024 20:26:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7190909273dsm2058978b3a.107.2024.09.10.20.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:26:55 -0700 (PDT)
Message-ID: <88e0a280-fe1a-45bb-b245-8ae411512ad7@linaro.org>
Date: Tue, 10 Sep 2024 20:26:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/39] migration: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-22-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-22-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   migration/dirtyrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d9db812990..a28c07327e8 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -228,7 +228,7 @@ static int time_unit_to_power(TimeUnit time_unit)
>       case TIME_UNIT_MILLISECOND:
>           return -3;
>       default:
> -        assert(false); /* unreachable */
> +        g_assert_not_reached(); /* unreachable */
>           return 0;
>       }
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

