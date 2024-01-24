Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1733C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSd2f-0003C3-7k; Wed, 24 Jan 2024 08:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSd2e-0003Bn-9M
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:11:44 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSd2c-0004cK-NM
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:11:43 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so7445022a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706101901; x=1706706701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1+yriHzBSrvhdxwzLlgEROlha6tWGWtUuK0s5iAD0tc=;
 b=eaIeDpsnihWBp59SJT4zLshSc2CeeCCM6y0f3oX0o49PF759csqTunQA3Qu9KUo+81
 B729cJpIi8BF1B+uSKiF+tBzqF3ucZWuJm7cQ0GHon9TmQ5berYfwWdWBL5AQRybp83U
 sJy7wEwj88KfHqsSDOR8SwBs6mGR0VdTx3/FWl7fuDkmRZXf/OjRE0sl18J786ZYtK4A
 1FS6lmN107zTjvixlGez0o7K9cJkmLKV3tFpA4D2+KYXeLD2T8Xp4UUGhNDoyxrjSR82
 tikv0ptVlsYr+WzbTqval3N865/0TEWXCrotvx6UKQoH1rEFqldIHANBAWO4g3J3YZcX
 oyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706101901; x=1706706701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1+yriHzBSrvhdxwzLlgEROlha6tWGWtUuK0s5iAD0tc=;
 b=DHI6X6WZZGJXq3W15y3u5K/XvVHOgbnHavjFOvQ9EUKMPcJRO9NQeAwOZVkyK09uwU
 jtml0GlDE2BT4w2MXXhJAd3hXTSnja6FurLmfypMsXPumKUqj1TUiAXIZaGjRvtcwN84
 eDi0OCY3Kw5xdk0mghT6xo8+Zu6D+M5j+BGoqxQhGOyIBoD/bm/2VuUPIEbq66HaEtui
 Chr8ZgBH91FKJuF/oMBGyneedwXn2v5/Ssk2S9Q4OH7fuMXVs/pCaGvnsoRQeBtExaQI
 wQVJx2jXIxW7PSoexJzi1mzXXLHFs6XvWSqtQWaJQ0HCxA4fYo/POPFoPnhe0czphYuM
 yRMA==
X-Gm-Message-State: AOJu0Yx560i0mteYvcG+TyTp0/f6RPwGkRiarATx4r1cUAe3eYSEnREO
 +NN7OmuRP3VSb58VrA1bpO3nh+ZOfy4Hxdx5ew3YkxNowI7R2LyxuvW6HS0NSYc=
X-Google-Smtp-Source: AGHT+IGnJW9bKwi3tYYJAmCQt5Nil0FhR5NX4LLCFiljPA0UDRhpGmUNhtKvvNjjf7kcsXzgtL5UmQ==
X-Received: by 2002:aa7:d88d:0:b0:55c:9237:5fcd with SMTP id
 u13-20020aa7d88d000000b0055c92375fcdmr1265423edq.21.1706101900829; 
 Wed, 24 Jan 2024 05:11:40 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 g2-20020a056402428200b00558a3268bbcsm16334626edc.53.2024.01.24.05.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 05:11:40 -0800 (PST)
Message-ID: <37ca639f-ce64-40f7-9e17-5fb32770142d@linaro.org>
Date: Wed, 24 Jan 2024 14:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] gitlab: fix s390x tag for avocado-system-centos
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20240107170119.82222-1-npiggin@gmail.com>
 <20240107170119.82222-2-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240107170119.82222-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 7/1/24 18:01, Nicholas Piggin wrote:
> The 390x tag should be s390x.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

FTR this has been merged as commit cdd30f369a.


