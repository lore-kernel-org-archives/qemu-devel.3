Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51228C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 01:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTAtc-0004T2-Ue; Sun, 14 Jul 2024 21:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTAtb-0004Q0-1C
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 21:52:55 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTAtZ-0001JI-FC
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 21:52:54 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-38b4e08c3e5so17384915ab.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721008371; x=1721613171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=akjSYTi/SIhG7vng2qickbX58PdWGOOzZOgyUEXA0bQ=;
 b=cNjsSAQiu7Pf/P2hRf0+vw+8GhqerLjM5EoqOgMBBbK2jpOa07gXrFVn6eX3BvTVLN
 9oohZscbXqVU18FQo75GCC7vDMfr6w+9VTc9LMnSis/1FuOC/WELVnzvxmBJMo2lBsZH
 ZF/jZx3L6+m7MNgcoEckmrjrXwaWh/L0IMytHa+WKrjzWA12VtbVgCfOMpz8wMgdKX/4
 I0pjaTg95od+CcyzvERx6MMS70skxmwK3b2mwOaOU0YBic/FiPUPil/i7iSsNlMb6bue
 kNhnsT0VbBCqqzE8aux3bTJPPWjETtlJdpnoWHzwyYC/4AKC7ZBW8A9G9UXYvFjQ0pmC
 BIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721008371; x=1721613171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=akjSYTi/SIhG7vng2qickbX58PdWGOOzZOgyUEXA0bQ=;
 b=k8fRDfpJlMSaOI22bXV7eQFsNrMNaKSFvYDRIYrab3eEdvKCZXD9eMNv1HAmUnmEow
 c5c1akxsmiJebB5EmgICGIBmHNIo1C1sbLqnC1wMFMNUlMvgasKqd0DkEQ45QYmmX/Ro
 GZYC1LUsEMYgvff7wkKDOiDyMTx4w/oaR62x0TJ66Y/YcQCyKF9rOV3v+VKuHDO4EYlt
 37KZppjLkMPccEEMiiv6nGfVHxY+rNUymbUL4nPc89it6XNIzc1UbwPy+QuZO0FGmBs9
 z9nzgYxafg2Oiwq1wtOMeJA7Vi39xhDZvFjK9F48sOfjBZN2dDIBH5PIkYzd4LAvbRLf
 OkgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFCvQA9vKq4AyBnPIXOCa7yksS4bnegvCtgjOOd0DGjnistFdXtu82ALVcYtNFJiViZdJ7aExV+ZzZGlqucCJZsM0KCqQ=
X-Gm-Message-State: AOJu0Yyhfmn7oRXx4n8nKWi/vG2X3u2A2wVfOY7kpCm8JZJbBKcZbarY
 SVzCok5qwIu337YzPC2T1IunsXT7piRphzcaDp5RTmOL52VeeepoJLaZFtMRuII=
X-Google-Smtp-Source: AGHT+IF+jX1G/VdAz662j+sSCwOjHuUcKXhWxL5aqJJmKtboiM5AYhuQuvDaDTBS2RbpkMLBxfP3hg==
X-Received: by 2002:a05:6e02:1526:b0:381:aa0b:3ccc with SMTP id
 e9e14a558f8ab-38a592f4bf4mr215060645ab.30.1721008371278; 
 Sun, 14 Jul 2024 18:52:51 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eba0de4sm3169605b3a.3.2024.07.14.18.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 18:52:50 -0700 (PDT)
Message-ID: <bbce3c1f-5d6b-41ab-8450-069089ad66fd@linaro.org>
Date: Mon, 15 Jul 2024 11:52:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/1] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, thuth@redhat.com
References: <cover.1720944812.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1720944812.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x133.google.com
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

On 7/14/24 01:24, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit 37fbfda8f4145ba1700f63f0cb7be4c108d545de:
> 
>    Merge tag 'edgar/xen-queue-2024-07-12.for-upstream' ofhttps://gitlab.com/edgar.iglesias/qemu  into staging (2024-07-12 09:53:22 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git  tags/pull-ufs-20240714
> 
> for you to fetch changes up to 50475f1511964775ff73c2b07239c3ff571f75cd:
> 
>    hw/ufs: Fix mcq register range check logic (2024-07-14 17:11:21 +0900)
> 
> ----------------------------------------------------------------
> hw/ufs:
>   - Fix invalid address access in mcq register check
> 
> I didn't cc qemu-stable@, as 5c079578d2e4 ("hw/ufs: Add support MCQ of
> UFSHCI 4.0") is not yet included in any release tag. If I'm wrong,
> please let me know. Thanks.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

