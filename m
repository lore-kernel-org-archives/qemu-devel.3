Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9D8C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 06:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN4x9-0008JB-07; Fri, 28 Jun 2024 02:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN4x7-0008Ie-Mv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 02:19:21 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN4x5-0001KR-9S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 02:19:21 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec002caf3eso3310811fa.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 23:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719555557; x=1720160357; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nac15weJy2n70ADaWLadboiJpUDMd0DFCULHo4IUwtY=;
 b=a1i6grq0E7fWnGmWWsXy0131T/XWbDyIhQKuZn/mXQOfGfQlsOGlw2ZTNGo11cMJ2z
 ris0N233yDE9iLEkL/0KEZUkpZcdxtm7LUnxY8nPjgY6prIQ7PK/4/Dt+wNgWINcl0Zc
 V4aKvrbG/tC4oCilsPpYzAlfVpQ6pUm0LroqoIH2JYhO2Uhcd+ZQ0fVGkuke9QhIbBww
 afJ8NhQvfQsAjcIk06g7Gz1PPY7FC2JM9LTNJZEJZB0JPda/64Cn2lZGLwHFo/iCZBXR
 RGuYMd+berqWrD+ROoVCTp5yRBjvAJD93QBnoCXIBaAzJv63shUnMxsjvTFQUDZiJ4OC
 kTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719555557; x=1720160357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nac15weJy2n70ADaWLadboiJpUDMd0DFCULHo4IUwtY=;
 b=bSrfoy+qLOUP4LwO0iJyUX/jtl1gEmB/nq2QJDKkl63XjYiFDYD/qSnftgMOakSy+C
 OsA5B5RyTyWFkZ+iM27Oh8o0/K/Xsk28K/Bblqo7OJ08+k8kEkcjgrv9p6vrKcVIEcBq
 eZgN7MM1EAse7flTr9Ad4l5MAwcL+Mtgb6QnxvARepqMVwGEud6VenDv5C5R8JpqLBlV
 JykGVrGt2kKws7ddi1F3XD8EJfRF9RkTP8ja37qH0Y1b4zgO5YELjA2sVLqQahZexp3m
 B9/54kKI8geyGHHGScbxAAQtImLAa9fIk88M/jjnrSSXBthe7OJmOrZliosLSt77YGCl
 TsUQ==
X-Gm-Message-State: AOJu0YyOkPuCCGEfWD58459GAs2eKUnKmuOewtzD6tbs5aDVgZisHKxd
 qbAQBb97ikz6BUkCnaesWbRoMunxLosfdlpLshhBH2IeMul1TWNHekvGtA0ci8nv98OLe6dEFSp
 oWd0=
X-Google-Smtp-Source: AGHT+IHxI7vYp/W95VNs2Nsrxirhsuqtph4rJzieiWISuhOGqN5Qzcxn5gitUdQB9TCRn9FNj1FmKA==
X-Received: by 2002:a2e:8242:0:b0:2ec:597f:664 with SMTP id
 38308e7fff4ca-2ec5b2c4fa1mr111251491fa.2.1719555556846; 
 Thu, 27 Jun 2024 23:19:16 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fbbd4sm1228880f8f.84.2024.06.27.23.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 23:19:16 -0700 (PDT)
Message-ID: <ce55f409-a343-4cdd-8a34-ba8a87b95c9b@linaro.org>
Date: Fri, 28 Jun 2024 08:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Always build Aarch64 gdbstub helpers
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240619124903.56898-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240619124903.56898-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

ping?

On 19/6/24 14:49, Philippe Mathieu-Daudé wrote:
> Merge gdbstub64.c in gdbstub.c and remove uses of
> target specific TARGET_AARCH64 definition.
> Small step toward single ARM/Aarch64 binary.
> 
> Philippe Mathieu-Daudé (2):
>    target/arm: Merge gdbstub64.c within gdbstub.c
>    target/arm: Always build Aarch64 gdbstub helpers
> 
>   target/arm/cpu.h       |   8 +-
>   target/arm/internals.h |   2 -
>   target/arm/gdbstub.c   | 363 +++++++++++++++++++++++++++++++++++++-
>   target/arm/gdbstub64.c | 383 -----------------------------------------
>   target/arm/meson.build |   1 -
>   5 files changed, 364 insertions(+), 393 deletions(-)
>   delete mode 100644 target/arm/gdbstub64.c
> 


