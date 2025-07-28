Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E31C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPyz-00040x-NQ; Mon, 28 Jul 2025 11:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugPyo-0003Bd-8O
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:41:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugPyl-0002Ux-GQ
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:41:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so30591215e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753717285; x=1754322085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hKb5zJwUZPm9BG/fd5+frzKkLkqao3oyQQDHdcX9Juw=;
 b=ih/ObfoyrkEcIJtV/IDcPlNrB8hlrTvUv9sPte5nCMh+673wfo67qipn5fkOitSYOM
 lnLp6I5DqDEeaidyHC4BZajOP2kmibpiTqe2WFOrQeuqxguupQTPv6+muDj41wXCxxrx
 CCrRZwGulkcod6VVzgBbLm3HwE5/vVlZUCeX62W+OeZgbKl5jZvnfGY6txSDwQ1u5ben
 QXVvCKMnMMfbtNLHRetRqEziqa0rSqSODENYH2HIQKpftaQi7XWKziav/s46UAe7RJ7X
 VxB1vb09Wy3AY6BqvidGFZLYqtgZsIvGlRTXgpPoNVyr8Vc2xoRSpWJd3ymJUIzSNYxI
 J65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717285; x=1754322085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hKb5zJwUZPm9BG/fd5+frzKkLkqao3oyQQDHdcX9Juw=;
 b=ZgNGlQ2CuyVIQ4ouqwLPt4PHxfQMf70JbCbnPggS3onvQtSbRBZXcqxa8OgM68pRw4
 0a6Ovg2pzXleK+4b1Xb+BUq89W7ehJMRui5PWEsuzw9JpYUKB+PPmfDKeq7939Mm6d6r
 eeiI3vJ6FwDRmOT+6pjU4Wygf7l3UhHVLn3E5A3asavQ9YO4/KFlAynZDCKHxxHPzOQl
 3CXu85TvE+lYECF1tm/TrwTTfdZ329xVESyLaZB8xBoI8yh5DXLUexIIygxZgxNPjBfm
 fEs1K4udXs2/Ue3MG39HfXW11lHxUrJcCnidmfbfXNzS9yeHVWsWmgFCbODLaE8iZfuZ
 w7fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYjyBkMqsGqEv1WTAJZYNLx/d4laQwDf1sK7BLfHBl2pzuvaM48rUgLLc5G89OLivA2i6j8ctSxMzf@nongnu.org
X-Gm-Message-State: AOJu0YzLX8gdLorBlSMNY/7qoddeY3VPFRW1W9tEFARG5irAPYdJW7wE
 pEG5XWJhDfAfR3j/+uJ0l/AOJ+hL+EPbZjb0K138kfKavEpdUiROFKsvfu8e7ZYM0hA=
X-Gm-Gg: ASbGncvCMSaJz6Ms6DRD6bZVeMeWTLsdMQ+aILBdqUPk0DnZu3Y0d2use1RYGByLnz0
 QxGtMogSHZjh8b4/RR9z/BZPhD17IvUGXdfa2V12RzyiXtxOS1WmscrqVxZ2h41deDfPsDKhpD/
 R7Xb2YvQXIOeKrlgLKTTsL+HiZ3z2qF+4Yyog3PBPn1otXQHcZFOC9rS6OW1Xa+4V+zht7T2Wvw
 OrHgGWNdoDWoQCUq8GiTm9WtEXI4El9nl0sEs07IlDPFyxAvbIAZZufjHrfFa8tl8v4swr4gzai
 0zn7nyFFPnr6uPgWyLYBB66qlYsaRsBAFr1qVdMOibQWM9MEO2Ij3z0S+SSLTVOG+mLLaTjOIyB
 BhaE6RVhwf9WdGC7/qjG7epK83vyw0eoxFchwknPw4aDBy4dYGaavAktc8eiqW3IJsJN0YquM1+
 hC
X-Google-Smtp-Source: AGHT+IHJiNDw87Yh+k9eS6evbiKiXGTaGox3c9uONPx5mS2vLcyhlcAjAEh9jsaoEynwW7fS/2Qeug==
X-Received: by 2002:a05:600c:1da8:b0:456:1006:5401 with SMTP id
 5b1f17b1804b1-4588b9ab31emr19944525e9.5.1753717284633; 
 Mon, 28 Jul 2025 08:41:24 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac661acsm106554185e9.23.2025.07.28.08.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:41:24 -0700 (PDT)
Message-ID: <c82d6abc-f974-4174-9fed-60a0567d76b9@linaro.org>
Date: Mon, 28 Jul 2025 17:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/sm501: fix missing error-report.h
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, qemu-ppc@nongnu.org, marcandre.lureau@redhat.com,
 berrange@redhat.com
References: <20250728090518.963573-1-chigot@adacore.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728090518.963573-1-chigot@adacore.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/7/25 11:05, Clément Chigot wrote:
> "qemu/error-report.h" was previously implicitly included. This is no
> longer the case following 012842c075520dbe1bd96a2fdcf4e218874ba443.
> 
> However, the issue predates this change as `error-report.h` should have
> been included when the `warn_report` call was introduced.
> 
> Fixes: fa140b9562 ("hw/sm501: allow compiling without PIXMAN")
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/display/sm501.c | 1 +
>   1 file changed, 1 insertion(+)

Patch queued, thanks!

