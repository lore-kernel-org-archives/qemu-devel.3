Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F38606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=D0h86zM7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOPqK-0004Mp-Ks; Tue, 03 Nov 2026 20:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOPqH-0004MM-Cd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 20:31:10 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOPqF-0001FW-HI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 20:31:08 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-886e61fa30fso110942b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 17:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793755866; x=1794360666; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ctu5CuVupMBkVayQeHr4FJFzLIikrK48zTOdxSSYw1A=;
 b=D0h86zM7cINY7jLq38AXISfxEww88prFd0jmllhvaQv/op8pQ7cf94zjmDF2lisaO6
 ZiAZEW+cXiucxIp91yX7DwaKhOyl+xpVDNddvfmKRFLTljVMAUew6/VLO145OGdZPiw/
 Bh8MpdniM947Cf+L6IoPLG+KV8paHby8Bi9lqF1otaeyvZLFbLPrkKD8QGq6wNyRcSEh
 CHawemX8ctMHaQrCb+dmCSIVhvaUNaw6+QADd7edBheNeSCNjtCR0VqbM56bSj46GxjO
 owR7yqIhP4TXSgv4iGmauuOpLo7dQUMwLP/qaRGL/mTRJxzrPqsNGk9rRSSy8UqK50+V
 S1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793755866; x=1794360666;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ctu5CuVupMBkVayQeHr4FJFzLIikrK48zTOdxSSYw1A=;
 b=lHnpZlY0I7dpXVMDQL9h6DV5fdzsQT5jMl1xnICuZvO0syM2CpHy3qT9UUyDM2j5AB
 Tq5gOdviZvas9x94cJEmV1CZap49pa9XMUR9TuIyYy8L3EPGxRbEQIMRUUV6DJe4Ad8n
 L8wzlvA4a0r/lp1hLsnj4j4+G9DuR2fqa2JWOY4cXY+hN4UzTX4WCrTZ14UOhc6qU1R9
 j3TA3r99goK1TYM0W6Xnzwy3AkykQ49WGCsCsK3roZIMyIw6BrJNhjRZys9XfaOilj4W
 w2gaLGratpVYDnC2Q05yppjXIzwYI+tf4cEm7eMvsby2+yuWx4jSkRXpKa8BEgQ4Lcdf
 Dh5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqmGwuu6T1wrSJiDYb08T2ObCUjKYzFETnv4zE9LfZhNB1YMRQ2hFC9kXoIJzoUYopMYzbjQ2nHfiX@nongnu.org
X-Gm-Message-State: APuU4Z+pWIP4dR8bOVw9yAKHg22C4DwzHQn5AdKJbEazv5t4qZv5k5g4
 dgC87BXfieMMw8ANEtCdI7XjLSCyPmRzzXGAw4TNwfTU3Itj58neMqBcAZJJ/UYBR60=
X-Gm-Gg: AYBFou38k9CWYay9kn2RA+6fSvB1IQPdmFDvC9eWlDMIFrSX/IlWlkC+xcTwu/vCM1B
 0MfUVtvsrdL2iZg8wvfZVSpgtGKtBK+c+vD9s8BlXmUYS2IsWDOuDtVgLnYsqcjO5WeIc2Rm3oY
 3dKD0ibEjZPyiCD9RjE5ByjgK4ZPtPtbZzJMobluB/8aAHjm5cuRWsBmQK1f4jo9oHUbJnHKG3P
 LIrsX+SgEq1fnUbGWrtZEUGhHH30YVeYTieU3zKQ8A20SZk9KFM2hqDwDAm7+BXapCojZetLqLI
 3PwxqzHfWd3yw10GJGbfuXFSYX4vV839AqhbvIT8aWYlS30W7tISGyGC4bIFbg/m8dfOsKM8ies
 el/TQZ/7arn3mndnCNNn97sDmznoOP+UPNAKG8HT81xZpzW1Eoq46Wa8cgr+a1tjtH24XAxJSMX
 v1kVLnZLXEVD3M1wZl8dh8hrzvHviwUiqheRh/YjUQDpBj2R9B/QbBrIxeK7m20I8LWVSiSI1+l
 d8G0tXO1LRLpSMqbaw1EqPVEeDi1IIqD2LswhI/BeBY1kzfT+XgATDVKSjH+znmGzH//7NU+/GE
 2dPh8LZU2psmtewP4tVfKSMRTO07c4flY+TE74QGI4ZHP5ml0MLLb9gbs5lq9dseknVLdQ==
X-Received: by 2002:a05:6a21:6191:b0:3e1:885f:b4ab with SMTP id
 adf61e73a8af0-3e928751caamr10050221637.8.1793755865507; 
 Tue, 03 Nov 2026 17:31:05 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09bc40bbcsm206076b3a.51.2026.11.03.17.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 17:31:04 -0800 (PST)
Message-ID: <54b50d70-0f9e-4e37-b973-0ae838e8e0ca@linaro.org>
Date: Tue, 3 Nov 2026 17:31:03 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] i386, AGENTS.md, meson changes for QEMU 11.2 soft
 freeze
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261103133500.2295582-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261103133500.2295582-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 05:34, Paolo Bonzini wrote:
> The following changes since commit 74f7bf4c59e6b6d50dbc6e124d93440be8be4386:
> 
>    Merge tag 'pull-target-arm-20261102-1' ofhttps://gitlab.com/pm215/qemu into staging (2026-11-02 20:19:27 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to ab78ac76f44a1241e76fd32d248df62d83f1ea58:
> 
>    meson: rewrite scripts/qemu-version.sh directly in meson.build (2026-11-03 14:31:24 +0100)
> 
> ----------------------------------------------------------------
> * target/i386/tcg: bugfixes and cleanups
> * AGENTS.md: add final instructions
> * meson: rewrite scripts/qemu-version.sh directly in meson.build

Applied, thanks.

r~

