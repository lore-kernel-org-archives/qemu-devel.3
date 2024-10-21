Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A59D15DA5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tnB-0004B6-Ff; Mon, 21 Oct 2024 10:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2tnA-0004AT-17
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:53:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2tn8-0001tu-4C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:53:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cd76c513cso38300765ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729522432; x=1730127232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KoYHEKo825nKjZAe6ktNq+ZTs3SdwvP8k8ILJUYkORw=;
 b=nbIKYSRQsFhtcwG7GJ7vdCikZbrJyN7/clDAplBr7GMXnVW1DstIHvU070+lcCmla1
 LjJE6/k1r7RKGhUpvTB/1TTz6J68fhLDQi5LLGCsY1vUhhtsCpQ8shFUD78vx53TKoeb
 U8/jbgbp6FYuzM5S+HH23hfbtMXPKq3FW7xjkmaBZcr6v1VZh1FHjMgNqBsXMlE2ZdH1
 NMHVVoqMEyfnnbCI0h0M3SumAwPx/YyAyA6edGAtFX0nc5yDtO9rvYlZpY+ME2pV3Mgp
 BlN6OB1ZERSIl6EpWVHdRfbNQL+TeejWS8rrcX+cf+WxCfoK7+bUMHBQgXX6JB+eJcL5
 VnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729522432; x=1730127232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KoYHEKo825nKjZAe6ktNq+ZTs3SdwvP8k8ILJUYkORw=;
 b=kLlNWcqnI+XAxQF4FYipuL+svb9CfEp32MROE0BAtIwRs1QZujnCSRNVDoMB/nebEz
 IDilEXzSVRC/CA7sxjsEoagFjtG8d70Cu084izAHEI9lJe4R0J+fh6sCmdJPwKRm8oJg
 An2ltGhrqVhhhw9rBTokE/73ykW0KM2IU/yE5F+4CgxZgQubq5JHCh87/1JFw1C1VVbP
 a4uUIt0TTQfJmMZ7YE4J9S/A6FPbAjeq2cjPO1+4ihDBPg+ObQCu9pRjNNFG9wQs4gtY
 DdD8Pz6zjVD90fkZjRTfq4VQlTtAfxpxhx43CfOh7AhChckquo2NLsYTQBgwzoP4LUgu
 F0+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn1+ak9jfVZ0WwsNPTWTO94hEZ2PEY5URMWJLk2miHKR3aJosIZE2MN/z4opIxtjhtA0H8AawMkGHs@nongnu.org
X-Gm-Message-State: AOJu0YwHG+jO1JijPjx5VvP2fr2/1X0LiHW9g6kSc6Nq/4X6Zfs1Xs6Q
 Bld82f7+MpT2wSLGRlMFJU7YdNh7+BOw/SW2O/o6zAWG8WyiWHlCwi1QxztT65g=
X-Google-Smtp-Source: AGHT+IGrKSKFUEmCJuFtkrRF8J38Ryn39C2rsbUVHh+FxhfnaZfFR7Y30Gox5K3s9Vy4yuyNTUe95Q==
X-Received: by 2002:a17:902:cec7:b0:20c:a97d:cc5c with SMTP id
 d9443c01a7336-20e9487dfbemr3109475ad.6.1729522432439; 
 Mon, 21 Oct 2024 07:53:52 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f64cfsm26802515ad.284.2024.10.21.07.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 07:53:52 -0700 (PDT)
Message-ID: <fb7712c8-0d80-4de6-872a-5d6022943b37@linaro.org>
Date: Mon, 21 Oct 2024 11:53:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Remove the macos-15 job
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241021124722.139348-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241021124722.139348-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 21/10/24 09:47, Thomas Huth wrote:
> Cirrus-CI stopped providing the possibility to run macOS 15 jobs.
> Quoting https://cirrus-ci.org/guide/macOS/ :
> 
>   "Cirrus CI Cloud only allows ghcr.io/cirruslabs/macos-runner:sonoma image ..."

Odd, Sequoia is still available:

https://github.com/cirruslabs/macos-image-templates

   The following image variants are currently available:

   macos-{sequoia,sonoma}-base image has only brew pre-installed
   and the latest version of macOS available

and is still published:

https://github.com/cirruslabs/macos-image-templates/pkgs/container/macos-sequoia-vanilla

Ah now I see before [1] we had:

   Cirrus CI Cloud only allows images managed and regularly updated
   by us [2] where with Cirrus CLI you can run any Tart VM on your
   infrastructure.

[1] 
https://web.archive.org/web/20240122002234/https://cirrus-ci.org/guide/macOS/
[2] https://github.com/orgs/cirruslabs/packages

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> If you still try to run a Sequoia image, it gets automatically "upgraded"
> to Sonoma instead. So the macos-15 job in the QEMU CI now does not
> make sense anymore, thus let's remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.d/cirrus.yml           | 20 ++------------------
>   .gitlab-ci.d/cirrus/macos-15.vars | 16 ----------------
>   tests/lcitool/refresh             |  1 -
>   3 files changed, 2 insertions(+), 35 deletions(-)
>   delete mode 100644 .gitlab-ci.d/cirrus/macos-15.vars


