Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA26C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKbd-0005TH-5O; Fri, 12 Apr 2024 13:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKbb-0005RL-LE
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:22:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKbY-00025y-SR
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:22:27 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso11306155ad.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712942543; x=1713547343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y+Nldyl7g0I+a02AfLgs1eTD0bN+c/wBf2PpeWyYDks=;
 b=L0FiCrHfCKBTo5BQALl3WeU3dhR/zp3Krr0S7vkUw4sj61nhP5FlAAcRMIYQjeCyF1
 87JSfzqk8miuvdAFcqNB3TbyUQrk/n3oHUcl+BOGMOhDwD9G2d0ffGeRoCLAK/ouWOr1
 PPghdXP6MTgzNWjCZvVTx3OfoFcumtJjvcIk6r5tWKDHrqVkeFA5Py3Wn5dTamWg2Tqg
 GCtYuVSJldBWhIOlCcgHgIsaitNojglDubx2UgDiRD16plqMLgIU6trN+PWa5p/Tte0u
 VQliW8ScvRKvkuqNZeoZca9VJpeXANo5TQbThFEC4+wkQsyAZvxfvDveSk5B3dqr52Jg
 TD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942543; x=1713547343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+Nldyl7g0I+a02AfLgs1eTD0bN+c/wBf2PpeWyYDks=;
 b=IZgZKc/TLSbBl6wEHL1STGyv+IU/3fH45BiB8YsR4N8F19aJYcdQxaZ5evEVHgkELN
 zzDfIQKiuCAXNxd3OSwL6YZCQZDZAFmelHAFNfA/J+vHUjdH1WJpNylURUQqeX0dh01l
 HbMunFaFkpEIfAw8QBsuRPKmQGXOLRiJZz3JV8se6nIIJGc8bSP9UAz6KoUmgbx5gLLg
 +H7TNwGrwuSRqcNplfWfkij1Hk1/HXnsRLLpLkODc80mIGwQ4Rx8STLCHx32JifBlPO+
 vLQhszPC3YO59tBseUR9YuqM6n5x99Ta9uMdQFsJt3CQIUfNJZEUhfZJ6PPKNGhfcfcT
 qbSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCuwk8eHSmw5r9fF4HZujH/ziTRuFvilH0aN4Vtq2XA9Kd5v1SbNl9HxIsZpx/AIDEcffOWjIQ15Lbc0dWfrq+//iBa4w=
X-Gm-Message-State: AOJu0YwPb20Krer9jaY3cQRX1pRXLRoLOf4aAcMfao+c+TODlaoOyzvC
 KENT/pJnRi+E1DbxI/STuX6pQWwgbj4g0pTFqyq4Y6K0hh9lnPcDOusjv/kHqfE=
X-Google-Smtp-Source: AGHT+IF5EOLzo80pf0QUde3EnJ1fBwkC+wnz3nPh55HCvjCOBdSE5UpGc5BI0z2cAVr/dfCp8JMqSg==
X-Received: by 2002:a17:902:76c4:b0:1e0:dc6e:45d6 with SMTP id
 j4-20020a17090276c400b001e0dc6e45d6mr2728440plt.60.1712942543392; 
 Fri, 12 Apr 2024 10:22:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a170902e5c200b001e446fe6843sm3234601plf.79.2024.04.12.10.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:22:22 -0700 (PDT)
Message-ID: <98876248-d2b0-4765-9f3e-277145ed2e4c@linaro.org>
Date: Fri, 12 Apr 2024 10:22:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] allwinner-i2c, adm1272: Use device_cold_reset() for
 software-triggered reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240412160809.1260625-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/12/24 09:08, Peter Maydell wrote:
> Rather than directly calling the device's implementation of its 'hold'
> reset phase, call device_cold_reset(). This means we don't have to
> adjust this callsite when we add another argument to the function
> signature for the hold and exit reset methods.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/i2c/allwinner-i2c.c | 3 +--
>   hw/sensor/adm1272.c    | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

