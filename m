Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795B9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 22:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0U32-0008DI-GV; Fri, 26 Apr 2024 18:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0U30-0008C6-Bz
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 18:28:02 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0U2w-0005Xs-TE
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 18:28:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e9451d8b71so23815105ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 15:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714170475; x=1714775275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ieGbZ5/mGejfMPFDvPOEUPr/fcpzKz7pvJSk4sMgDo=;
 b=eoCUtxej2uEF8Z/sQZt5+QH5vY7Vj2he+mBsgWgtH9EYAabE91KJJZIsOcPbBf74Ov
 00SfPbl/W8y0kabQYrXP2BBO0og4wkgKLOcWqRmXQQFKbhkWm6pt3iV/qfPDZU7ak5my
 T41bHJRgBUx10Vn7Gd4x+KQpv1xMfjb2d7CMiFDUhoxOzouVbj2p8NAQmibl4CGJttHu
 X3f70vW6sNRz/jsv4ZEslU3twURwtGmovNE4qQcMwsfPxBLmUrjOi34WPRj9ofz9Fe9S
 NRsP3EZCvvofKMWfsVxJ1h9xED4X4SIsvBGqI6Nqk/YvUeP+hQjNxYIJGTdnna2W4p9J
 ECXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714170475; x=1714775275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ieGbZ5/mGejfMPFDvPOEUPr/fcpzKz7pvJSk4sMgDo=;
 b=whoT5W/oNvfPNfq69GADscQQLFB9orFS3O8c1/CIKPwK4XQOqrSAhYftB0gSRfl4O4
 PNuJzMl1vMOmfzznopXNZXsGnV3BSLkE6ZR7VeTcrFuTeIeM/7v50rR4nBCNP+BF798e
 sZfaYDnvpIZpOrmo+ulv3Q1Flo6K817TlDr4uBoaXzr6uHPDllA3a0gF424qgsnGhAOX
 paf7edpLiqsS2lZgM5PjCwHjxMtpSt6oLmzgncLEc1SpAp67QstucO3UCfobkKUVlsvu
 dxrWqDEpowwsO70AeYNAHaEcMNBzrt70bn06y9ZnP8S3OA8G8zf9ylAMOTFHU2vHU3tY
 RwIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSqXqkFHLo4iq4xMEr5tOwgTTDu4GXd3oOa8DUB5WOWjprib/tbxw/2R91M/UQ/Wi47jKz2Zr+tsTJ/HWzByvBkcNfLUQ=
X-Gm-Message-State: AOJu0YwAFJntkQXgQgk+J4mFQcwQIQh1yMhG1xFgzQ2al146MVa42IZh
 W+9sPCGYzBWclHUqAK8x1f+E93HHdozotkgNHkvdYOjYtx96Gp0WAEfiJDJ5yhw=
X-Google-Smtp-Source: AGHT+IELq5NOV8xl8AwkN6rNJntxaP60pHp7ffXr2VZY1piChwWviec0Mb5JnEuupPmBZb4FzW0T3g==
X-Received: by 2002:a17:903:11ce:b0:1e3:f4f1:a2c4 with SMTP id
 q14-20020a17090311ce00b001e3f4f1a2c4mr4657534plh.64.1714170475486; 
 Fri, 26 Apr 2024 15:27:55 -0700 (PDT)
Received: from [192.168.91.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001e431fb1336sm15942301plk.31.2024.04.26.15.27.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 15:27:55 -0700 (PDT)
Message-ID: <e1b2d8e5-2c6c-4a64-9228-0732a34a80c9@linaro.org>
Date: Fri, 26 Apr 2024 15:27:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] NBD patches for 2024-04-25
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Zhu Yangyang <zhuyangyang14@huawei.com>
References: <20240425214425.571652-4-eblake@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240425214425.571652-4-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/25/24 14:43, Eric Blake wrote:
> The following changes since commit 5da72194df36535d773c8bdc951529ecd5e31707:
> 
>    Merge tag 'pull-tcg-20240424' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-04-24 15:51:49 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git  tags/pull-nbd-2024-04-25
> 
> for you to fetch changes up to 4fa333e08dd96395a99ea8dd9e4c73a29dd23344:
> 
>    nbd/server: Mark negotiation functions as coroutine_fn (2024-04-25 12:59:19 -0500)
> 
> ----------------------------------------------------------------
> NBD patches for 2024-04-25
> 
> - Avoid calling poll() within coroutine

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


