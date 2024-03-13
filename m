Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380D8C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkVqc-0000SK-Co; Wed, 13 Mar 2024 17:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVqa-0000M0-Hc
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:09:12 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVqW-0003Ik-PG
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:09:11 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29c6a917a8dso291589a91.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710364146; x=1710968946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kZO2F579L73KdcFyYgfeqSFrDYkw93kuImSXcRMRU40=;
 b=i8VerVd3utqe+upL3paKifaT6+BUJKRiLpFJs97QEiu5nZFs6S/dlYbEG530dgd+4m
 S6JzButbQE2pIQDzIqR6EuQ1hxHaNYFZ9THhKos5lAx0yY/VOBp0ixWDa0VG1K1mjCzA
 a68YFUBxLmd9uL5anLbajHKAudw8arqPthNTUWC+KtAEI4KkUgyZs+REoMQBEtWqZcnW
 K7xqHS29JKQmGyjauOjgXrowIzE806hVGhbNxSSJ4gjKBweQyoF1KE9BPbzNtZx0bBtt
 klUpXIQx3Q49xof466oMfClhhnHYu2L03fX7Vph2uQd4jIftJLpV8Fi2rk91QOXqbmnE
 6l2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710364146; x=1710968946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZO2F579L73KdcFyYgfeqSFrDYkw93kuImSXcRMRU40=;
 b=NkgNvLEztGs4A0z39v82QzQesk/EJsH7nDUDr2QMPCDNdT3u+o5uc/7l1PtbiQRZeC
 z1OO0WzL6+K+CkVTEqjEsKPLWfFDL7GEcB/fvc1cImrZsyC4lrnKpSaJurK+GTXNm4UQ
 Ssrv76+jYbcXefggGzSSmjqnRdhNcXv7x18qCkjwOlQPRiuk8Fb2EFHUB1lRs+Q0lz+w
 kcUfWjzPX7HYxC9XdBR2rJWYRgRVcTHG9edvx+t6L97uUbOnAVvuLHT3Q1JJ0iiQh1Sg
 VcwGgHSfvRmkXNXIkIWOAIIMiuJguDJ0fn0pg4myiCGe1ArdVPBxp0jPV6pQ1FAkNY7Z
 wm0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSiaLETs7Tgr4eW1yKT5ROwU2GMvjgM9PR99TcMOdWbVzimTKcSPeuk9Pfzchn4Ep5Uk1hRjYI90dXN+JhFzqahMF4Dks=
X-Gm-Message-State: AOJu0YxoR8q4uvi6ZUr5ELPCswkvM6cxqHvxGQo04OIGkzae4XVRyKYZ
 U+ZlnzOZ3cEF9A8od9SZgU/RbXx2amq60wFVER3pUqipOYeHwwh50/uPISv0uHI=
X-Google-Smtp-Source: AGHT+IGghtu5WhkaDG4JOgQ5j1bCM87e7ca3O5N+iG9wcZ407cz77L3Hp49xy/gXg7gku6TrUqWW2A==
X-Received: by 2002:a17:90a:f417:b0:299:a69:1f8b with SMTP id
 ch23-20020a17090af41700b002990a691f8bmr12032165pjb.23.1710364146529; 
 Wed, 13 Mar 2024 14:09:06 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 qc12-20020a17090b288c00b0029bad32fe5csm81470pjb.16.2024.03.13.14.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:09:06 -0700 (PDT)
Message-ID: <ed68d95d-7eee-40ab-b5f4-0030b0650108@linaro.org>
Date: Wed, 13 Mar 2024 11:09:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 4/4] meson: Enable -Wstatic-in-inline
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 John Snow <jsnow@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240313184954.42513-1-philmd@linaro.org>
 <20240313184954.42513-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313184954.42513-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/13/24 08:49, Philippe Mathieu-Daudé wrote:
> Compilers are clever enough to inline code when necessary.
> 
> The only case we accept an inline function is static in
> header (we use C, not C++).
> 
> Add the -Wstatic-in-inline CPPFLAG to prevent public and
> inline function to be added in the code base.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

