Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AFFC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 17:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT34m-0004UN-Of; Thu, 25 Jan 2024 11:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT34k-0004M1-Bi
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:59:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rT34i-0001id-SL
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:59:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e86a9fc4bso89307805e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706201975; x=1706806775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=96reytnv8+HTkO2oJ/tOftaiR9k9T0T6mUoZlhceySg=;
 b=VtBKETwaiOQNDhuL3LZ3J2+O5Mq2y5Euf1YOIyHQOTKR3PlINvgd8hszUuK8eEp5Tp
 pFM88YaugRQC6bWDBct7nvect62gKQECKiNmmb5oxWbWvIDdzZjQHOg3OEj8A2P7+VEa
 NXmv2pifgMAqjizyApsgLYQNvDY2Dt4PjhnnnqY/N/dKHWoA7TE3QjaUBwUyXVciZaZC
 GAeWOq/VUU/nrGpWBa8GDQ/owt79M9Ap2PhIbNvcku5HK5bFDTZx6mS3cjUXuRfhb7XI
 tTYPiCEmfRH/m4rpxnx6QtBggCeFa8RLTMOtF1WSc+PAl5g9Pyyp6K/AT9fTfQBML659
 xmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706201975; x=1706806775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=96reytnv8+HTkO2oJ/tOftaiR9k9T0T6mUoZlhceySg=;
 b=VSh5F0wF5cHxRVjmLe3KEdDFg7t+2b5MO3qcrtkGPA08iUXiiEa8M1ekSuer2IzsHj
 uaT0JGmtWnNe24dPFP6Gu0IWPPSTP5k1SvY+mdrkhEB1WWg/t+3W7/cM8UjPGrq/UDsq
 H/TQiJXxiSOEibyvgVLh8pRUOoPRJpTGye2shyRngQvpqL41oiPxpxPx0/Cz8d4HYcHA
 f/w5GFItlq0YNp0sJ50sZ4QcX8wTPZoQvbCZSIgu+O0lz26rLoYDlQpJ/XXg5XNIiYMY
 nW13TEzmvxoPiAsCBC+C0kqT0MVyhjlSVyDzC7fGbgfRFmV7JoeXAaXg5uMocqLjLY6m
 +1Kg==
X-Gm-Message-State: AOJu0YyAeIr5Ufdf6DLzg2vDWl0aSP95SwOtzHY2saSacZgPXZXUg9SH
 8eVW2FtKgmwG2WueFBGdeDAL996Kb53qjO5/uIbNtHsYJL99UQAeUruyA4LNKNKz6eZD6QviSwe
 B
X-Google-Smtp-Source: AGHT+IHBMihjMXfKOP/0mZwUAH6ceQM2S604uw5bdQxaZBlFDLIDEDCRl5IENrbIOv7ZHt7cwMEGJA==
X-Received: by 2002:a05:600c:3786:b0:40e:b0e2:c6a0 with SMTP id
 o6-20020a05600c378600b0040eb0e2c6a0mr11849wmr.250.1706201975201; 
 Thu, 25 Jan 2024 08:59:35 -0800 (PST)
Received: from [192.168.69.100] (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d5608000000b003392bcd6c48sm12913879wrv.79.2024.01.25.08.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 08:59:34 -0800 (PST)
Message-ID: <3ebb1dc8-b62f-4cbf-bcd9-931e712a02b5@linaro.org>
Date: Thu, 25 Jan 2024 17:59:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] aspeed: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240125163408.1595135-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 25/1/24 17:34, Peter Maydell wrote:
> This commit was created with scripts/clean-includes.
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/aspeed_eeprom.h     | 1 -
>   tests/qtest/qtest_aspeed.h | 2 --
>   hw/arm/aspeed_eeprom.c     | 1 +
>   3 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


