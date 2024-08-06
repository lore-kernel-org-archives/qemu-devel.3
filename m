Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC64C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEv3-0004RK-7j; Tue, 06 Aug 2024 03:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEv0-0004Qm-TC
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:47:43 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEuy-000607-N5
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:47:42 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso664517a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722930458; x=1723535258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+CHXkFxaT4YchDwKIGJZbBvHArjllcyD1k5wBD5IyyE=;
 b=AsbWR0QLiK3e22n7O4wXu972GzE0HAzLQbeDZoKJoUQrHTXrb0yYdiJmIwvXUghJMN
 F/Od0JrqO5ZeeLXNZqRTEpSRGigxlq63C5hkvj+MbAyMy4xECEX2MvSy+lpHpjA1AOrN
 8J+edw9K4OmqpnvoQeLgAjfbhsjyeijRHnlVlHTelrMB4kGu3UitFAzCdBSNoKrNvQj9
 qxiL8ZiKeZTQtbULfvEc5gjIGMEY0netoq1j2FqaB0JYVGtG/NoqPTbK+pZcELs1bGtJ
 U8fo85WptTRU8caHuqzqRQD1xdKyFi4KCCuk91BzLd4nnCv5/x/ja4mcnswjrvqE1xzT
 Qaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722930458; x=1723535258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+CHXkFxaT4YchDwKIGJZbBvHArjllcyD1k5wBD5IyyE=;
 b=Lv8FLcrUfGc2lb3/LQJ1rX2KRsWtX8mr+8bCgUU3rCqSIYireRSNLj7llkTwsThB7k
 EvqvH/zKuGAUksCxJ2BiMij11A08r2/Zc0Imgl42rIyl96UsWie5jw6mk+Qgevz2F/pQ
 QCsh1BgllDq/o5vZd1Mu73YhaiSPh69YLMwpftRU9a/QCl1L+humorHODuhsRNjl1rGp
 0iZ5p4XEXGiJ61ANFd26Ej7zP8ez0r9AyCdEpmAfQTqGTVr6HYWx8S0OR1Fqtpj/hjvn
 G08rDFMkxzQNj77su3ehfaLv6YdM7bJOHFbWBZCf0diOxhsWdYsdev+p8Zin9p+wjY0e
 mz2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSv+qroLFt0AFV4VAhGsv3Afp1xo/kuSTxM86OVl9LHWPV41Cb6zXt9oe62GMC7l5Qc1Ex5ed3tinbsFJNk6DfcAsZ2tg=
X-Gm-Message-State: AOJu0Ywa9UCwkU+YVk3zXm9ihzt8nSTkx/jtmvMKg2CZhp6tNvTqIX6i
 ZnU7z0J51/8YwYJ62DqYI7TaHqaU36kJ3VPOqeA/SvbJYfNykPlEw8sfp57Aq8g=
X-Google-Smtp-Source: AGHT+IHH92y0eOGSv3Mbrokg1+6JGjTK161xsrFJZB3nireEsMJZtgEErvEDFCHpWxZc7qh8zjBifA==
X-Received: by 2002:aa7:d49a:0:b0:5a2:fc48:db12 with SMTP id
 4fb4d7f45d1cf-5b7f40a91e6mr10224925a12.19.1722930458083; 
 Tue, 06 Aug 2024 00:47:38 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5baa6b916b8sm3420291a12.22.2024.08.06.00.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:47:37 -0700 (PDT)
Message-ID: <51733c53-c836-4d7f-9f0f-a40e5376f83a@linaro.org>
Date: Tue, 6 Aug 2024 09:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ui/console: Note in '-display help' that some
 backends support suboptions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <20240731154136.3494621-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731154136.3494621-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 31/7/24 17:41, Peter Maydell wrote:
> Currently '-display help' only prints the available backends. Some
> of those backends support suboptions (e.g. '-display gtk,gl=on').
> Mention that in the help output, and point the user to where they
> might be able to find more information about the suboptions.
> The new output looks like this:
> 
> $ qemu-system-aarch64 -display help
> Available display backend types:
> none
> gtk
> sdl
> egl-headless
> curses
> spice-app
> dbus
> 
> Some display backends support suboptions, which can be set with
>     -display backend,option=value,option=value...
> For a short list of the suboptions for each display, see the top-level -help output; more detail is in the documentation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The ideal here would be to programmatically list all the
> suboptions, so you could say '-display gtk,help', but that
> seems like a lot of work and I'm not entirely sure how
> to do it :-)
> ---
>   ui/console.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


