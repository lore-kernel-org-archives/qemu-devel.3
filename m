Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1097C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 22:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2IEk-0006um-Qu; Wed, 01 May 2024 18:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2IER-0006o2-UY
 for qemu-devel@nongnu.org; Wed, 01 May 2024 18:15:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2IEK-00076P-7R
 for qemu-devel@nongnu.org; Wed, 01 May 2024 18:15:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1eb66b6953cso40141015ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714601705; x=1715206505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T0awCXyDmREBAF6pJPlOwHbfM1ESTmiQiJ3UpgpYVqw=;
 b=AzvYovs8q+haB+aJkzus4IJGDqm9bFA1maVlQ5v3QDc2ufK8OerG2xD322xse/v133
 vlr3ItgqekWYDSlFwj9/K36+0/KenxE9eQaDwgrlHn7GHCf8hQ+qimfpA5gnVr0CTPc5
 /P/qb2gahyaOuc1KhvhaoBJdwkBE/7wm0/Ld4B6wILSdLv6l+uRO5U4lLZkXos3NaQP3
 e4bGGZoMUD8iBpC4pO2pVIHP6lSERjWyHMMhsQzEBj+uku0E98WHSNwVlBRCB2AEC+BR
 HDfQ7hWNi/iMGE1y0sCz7vItpV72yTqGqlbywV1s8A0oUCBQZebcc96HaHkX114VidC6
 lWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714601705; x=1715206505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0awCXyDmREBAF6pJPlOwHbfM1ESTmiQiJ3UpgpYVqw=;
 b=pMVVScQwyNQVgR/wJGyOirJonBmJECNZKjM7dpZ774YMezNeQlUtfjlBhqGdVMM5A7
 FTOw87jPdcf+wneWSVbngOxpAFGH9VL/1JPDn7Vaq1XmtcjhGfSXrjZsHrUOntm2Aywq
 5L0XW2jpY7iUtXleQb+aWZrsv5tylATJ1as7lE3bqG4wSt+yJzPYxqet3JoW8S1waE4R
 mL5gCsxKpIe3eLO5KBEw/RTpt1orcdHFbmbZ4y/XQ2390jmat7hMqAtoPaK0cdTYz2lB
 gNjJxmKL0UFalnsPS1noBUupS28xQtjXnADaLRKVjk+X70H2m4k01TQJqEPaCtpJUY3g
 4u7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOxjDDnG8CT5YyCm5h7cJoRE3WiaukdKcmHhbEu1NjYnFBXkprq9DN00vpUH026XRmYNXs/Da/DIO/zbAhN6BXZw/50D0=
X-Gm-Message-State: AOJu0YyFAXmbjPEyQ+p1bNyVzbOxayG8kML46nCTmoYkJ7hbI5ugeKMN
 lIdTAGm+10scp7lXYUfZAzcJUgWle8zZNUkW1DNA5ExIvjXlkn+jgf2QRLvuz3Q=
X-Google-Smtp-Source: AGHT+IE9X6iaHXylnqWA9OlmTxScWH2TuLH1WbJIZUTiMPxXIPWHDvr9yNIxZ9OWC5DVAkgVb/YYxw==
X-Received: by 2002:a17:903:26c5:b0:1e3:e39a:2e49 with SMTP id
 jg5-20020a17090326c500b001e3e39a2e49mr3288537plb.18.1714601704764; 
 Wed, 01 May 2024 15:15:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a170902654f00b001dd0d0d26a4sm9934647pln.147.2024.05.01.15.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 15:15:04 -0700 (PDT)
Message-ID: <66a98cd0-d489-447a-9494-37be34802f33@linaro.org>
Date: Wed, 1 May 2024 15:15:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, zheyuma97@gmail.com
References: <cover.1714360640.git.jeuk20.kim@samsung.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1714360640.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/28/24 20:25, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:
> 
>    Merge tag 'accel-20240426' ofhttps://github.com/philmd/qemu  into staging (2024-04-26 15:28:13 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git  tags/pull-ufs-20240429
> 
> for you to fetch changes up to f2c8aeb1afefcda92054c448b21fc59cdd99db30:
> 
>    hw/ufs: Fix buffer overflow bug (2024-04-29 12:13:35 +0900)
> 
> ----------------------------------------------------------------
> ufs queue
> 
> - Fix ufs sanitizer vulnerability

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


