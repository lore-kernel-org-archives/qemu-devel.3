Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAC0C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3Cl-0006WK-BY; Tue, 28 May 2024 16:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Cg-0006Vf-GE
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:13:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Cd-0001UN-92
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:13:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so1487935ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716927224; x=1717532024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qLmoZ1PCdJaL9Lu9M20KAzr4Zmz5SO32acb13GDZn4Q=;
 b=CrW1wiJ54inMAf+/dwfGFV8M43B/9dDiVB4wRDzMDyXtHH9oAteMqs3eVtEh1Px0Jp
 RztL9pNx8rPPOL6vmYwSQ7XaBKTMPdvSOr9lhnsFMrR0n+/azrG6utVMQbY1swkzVQJF
 qPGOGPL9zW2hjoETO9SdXyZTdTdMVuVXA4hjFEgGvpUxFj0ltFBwlIO+ZZgtAv0gG4eK
 cCWpWCUFCVlYf3Ts3iLvdw6EoWC/UXD8QZnCqz8zAB1VrjS2GqnYgJ5VFnXXboc7i/tk
 FgRxxF1Tp7e1sbKbxBQw9IT0CrtUbKpqZycEDBviqe2vp5sShqk2qe+Ffqr2gCVf7IRp
 Ifrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716927224; x=1717532024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qLmoZ1PCdJaL9Lu9M20KAzr4Zmz5SO32acb13GDZn4Q=;
 b=F1R6QGewSeGBBth3N5XB328kUUzOh4JX59R05qh/n2jspoactBYv/Ugq3mj3sJgPFN
 oFpBObDKB5acmneFmw3f0ZK4XFTucEztskrvV7tIuQ1W3iOdn5krqmxWhvdKHE2KVffE
 vdr7F0zdtJFaeBy6sa9ozr9xgogCDsqYcoYzrmsKdKLnb+gUqh0hBlquIiotJ5+DvBLH
 GrOZ4gew+aDbI7EvugIMKv4c+6Cq7YDSAWUz/8M6gGjPrn9IORs6d3wkdPA6fnnOxtcB
 VQCMFO2tXSm5PtiVYZJA2LpUByoD4aEid29dMgaoai6v6BpraFuZwJ6Y579UUQesark2
 01Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdgCdp/g2puBoyatTVMgrlmvOGHu3shuzCXI6EXrDfpBRYqCg1W9+5neLQsdNE9eF9gD9UNE5Zgob75Ypc5ph7tsc/HxQ=
X-Gm-Message-State: AOJu0Yx05zrY01bPawa2HLRdx+xJd4/LUJ39z8a1Zf5w/upyP6v5uRWE
 XbGMfeDtDWP4201RWhQtDKO+Q7DOpmjBs6nC7RyTPxQodf7sk0WzFbz/wLR/JD8=
X-Google-Smtp-Source: AGHT+IF+/klyK1aWaYGMEcjj6V7rfJ3lxv6NSqBLK7DrRoLziMWAvJhb6onXdLGh95gYM+YBZaP41A==
X-Received: by 2002:a17:902:c402:b0:1f4:8500:9f6f with SMTP id
 d9443c01a7336-1f4ea6723damr1895075ad.11.1716927224495; 
 Tue, 28 May 2024 13:13:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970058sm86853515ad.121.2024.05.28.13.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 13:13:44 -0700 (PDT)
Message-ID: <0c541cb7-c9c0-4820-aec7-164594864678@linaro.org>
Date: Tue, 28 May 2024 13:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/7] Block jobs patches for 2024-04-29
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20240528135747.2476904-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240528135747.2476904-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/28/24 06:57, Vladimir Sementsov-Ogievskiy wrote:
> The following changes since commit ad10b4badc1dd5b28305f9b9f1168cf0aa3ae946:
> 
>    Merge tag 'pull-error-2024-05-27' ofhttps://repo.or.cz/qemu/armbru  into staging (2024-05-27 06:40:42 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/vsementsov/qemu.git  tags/pull-block-jobs-2024-04-29-v2
> 
> for you to fetch changes up to a149401048481247bcbaf6035a7a1308974fb464:
> 
>    iotests/pylintrc: allow up to 10 similar lines (2024-05-28 15:52:15 +0300)
> 
> ----------------------------------------------------------------
> Block jobs patches for 2024-04-29
> 
> v2: add "iotests/pylintrc: allow up to 10 similar lines" to fix
>      check-python-minreqs
> 
> - backup: discard-source parameter
> - blockcommit: Reopen base image as RO after abort

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


