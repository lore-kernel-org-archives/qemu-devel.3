Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB3C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 20:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUuOl-0000kO-8y; Fri, 19 Jul 2024 16:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUuOj-0000jq-D0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 16:40:13 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUuOh-0001gw-PA
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 16:40:13 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5ca9835db95so1205372eaf.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721421610; x=1722026410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sN/v9R3dnYzIWekbesxwcSLmHODk81oJFLxH50uyO1c=;
 b=ZUnwSbKM2+SJ1K0qgcyKLF7V2QZjEsH80nWVQiQXnx9IhVfLZHkh31MWII2hcFgFD/
 DN9WvP/8Sj7z0dep9XjKIDJ4PehJALI8R7RaSqH2yLijoeHmkmVnJny8ZhzumrsWiAVT
 nzJpjXvXF8re8INYaA7TN+8wNx3aep+DRH72vL1PT+8PQrVoBn9EsaQ9Z/3SkNGAaLRT
 ulhlpMwaKWC6aNGGhaiYySw6hRaN3jZKRV0kyrD9O+pSukCRt9OpmuVguTz6end3NqN+
 SDeCrGEeausZBWYuq0QJF9FdCaJT5IgIycABVCHygTyGRbwP6PvqwYLxRIPqRoaAUe7g
 AbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721421610; x=1722026410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sN/v9R3dnYzIWekbesxwcSLmHODk81oJFLxH50uyO1c=;
 b=n9w2FeJ9Q2T/yJ3nwivZLNEyYO1s60oKW2EwtZJBwJjQMpAKeQKLZABALmwZoIk3X8
 wngtHO8lyjMRJZIX5MAaRUw7CcT/AOI+iCPmakOY1UiiiD50oxo12mf7PntpfFXwEZQZ
 ZS5Pqck9W9UpH9UQf7ga1pDQF4LYl+z9LgMT2nE1pNT2fvWwFjecSvwN9nKvRaxEUVuT
 V9jAJQgxYC64uWN7XKlz+h7wAfydmZ349nJSV5eHobXNrNmV4oVcAKJ4i2KBoME65zQ7
 Mup2UEEDGOCDWeZV1vTMKWds2+JTf+5mvu5CMDSv6hgvWGWHpxysTxTcHno+k6GAiX3Z
 fXew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI0wlf2D6irgGdglDMl18aSuuZWJCaIlt+G2nGg6Ts2oZ034+2QM/ODc2IivDskwL4pl9Mz9uLRVpKOtK28Wmm8FJ8n8I=
X-Gm-Message-State: AOJu0Yz4qsnvBGvcjX8WguckNVmnPdBQfDYkeFUKfuKShURdZxxDQ3GT
 PqM5sW2ro8Ed1v4QmXyaveOmDp0xX7cewx+UVhiYffejBFpuCnzJ57CJjyyeOQgXVxANbJezLCS
 qPL1ieA==
X-Google-Smtp-Source: AGHT+IFu8qN+3b+3v/Y0Lt5Qx7vexvlzdubwlyt3IjFZRnr1EM/lScw1Q5xR5AOXPy1km134Ph+k9g==
X-Received: by 2002:a05:6870:968b:b0:25e:eab:6d32 with SMTP id
 586e51a60fabf-261212fcdb6mr852018fac.5.1721421609925; 
 Fri, 19 Jul 2024 13:40:09 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff59e2d7sm1630313b3a.170.2024.07.19.13.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 13:40:09 -0700 (PDT)
Message-ID: <2ac62489-2735-4631-a95b-ee312d56264f@linaro.org>
Date: Sat, 20 Jul 2024 06:39:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240719022604.781608-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240719022604.781608-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/19/24 12:26, Song Gao wrote:
>    Merge tag 'pull-target-arm-20240718' ofhttps://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-19 07:02:17 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240719
> 
> for you to fetch changes up to 3ed016f525c8010e66be62d3ca6829eaa9b7cfb5:
> 
>    hw/loongarch: Modify flash block size to 256K (2024-07-19 10:40:04 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20240719

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

