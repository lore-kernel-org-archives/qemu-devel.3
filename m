Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F3C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 06:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ2eZ-0003eH-ED; Wed, 31 Jul 2024 02:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ2eY-0003d3-2I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 02:17:38 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ2eU-0003SM-SQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 02:17:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ff4568676eso1580255ad.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 23:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722406653; x=1723011453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=22iGlF7PduofobGGW/9pgJTRCJ2IXrubcKAQYBgj4xs=;
 b=d7lfFsprDY4+UPPXSqKhXDe9nSIsxu2hBEm+yhlKvj7EFmKfzK8FWsYq3p0LMouHdS
 UIyTgUXh+gtO5/LDzS4c+neIDpHHgDuFM9zC+d8FFPOcnmAhMIFRRRUXzZCIB/UNW7uk
 QCAa27sxy9oF8xxgZ/3s1puWdShTSSaL4MfVElkLNRU+COK42JAOMpli7lvrLrBin6ak
 836HH1jmObTfPv7OTqDsgVgPTu7oA4jn1HQmtjTU2zF9R0I4/ELXpWBAEl6DyLRyJzmd
 oAI3x4ijXrdFARDBybMLyFRguuB6phJFY701ZCSmlm1Ufw0dFYsWKPtoaYPr8Bh2oCtZ
 +2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722406653; x=1723011453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=22iGlF7PduofobGGW/9pgJTRCJ2IXrubcKAQYBgj4xs=;
 b=hN0t8EoKgQaZYgiJmB+puLvIKmBTQqAvnLcCGLHxB76Lqnp06KdNhaa+305HjNOeVL
 2pFOZxnIdZsbXkSxJTZ9D6I/txGLjuXj12qJaEpnpXfh1cV6wsxcRMnXbjA7lo/qJn7t
 GJpZi94FUqK+TL+jBbKRNnU8G/KhVggTWP3tWKu2dDqqm6cyuNd+opTRzifyxA9cGjDG
 owRqqnrFwOcW6uSyGx+6f58Znqj3XnSpOPs60dSNkM/5g/P4BSDgoq8/DgfXj6na0Rim
 SBro5aDKC5H9WUsZuQwPTT1mMS9QjJDP0z6ufWjm5/iQ6KAoROFUC82fvzT+q/uxcmNY
 v5pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8wsREQRfNfrwR3duHvaRy9c6hC6RDjwJrtE/u7oyAMAomq1jlydJGDQ+DG97of45wK8oHYmxDGI9tpLD4Sy14pBCwdHM=
X-Gm-Message-State: AOJu0YzJtfADFWALBTjpo2p80/VgbncEcNQAw/6smMW/96G8PxC3HOtQ
 om791APRW/neCBF8HjmL7D5ROwKnnfwAvIW/bNdM61cP4N5F2aO0cbOmGnjzg4MUNQ8srwFiRVD
 o/Qw=
X-Google-Smtp-Source: AGHT+IGT6pAVR+u64nE/vCuGj6IWuWrrzNSldHKoHNhZc3B9n9M7uyjif+saDyX4T5Ok+elWII5fTg==
X-Received: by 2002:a17:902:a609:b0:1fb:5b83:48d9 with SMTP id
 d9443c01a7336-1ff04844d0emr136049505ad.37.1722406652649; 
 Tue, 30 Jul 2024 23:17:32 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ff072asm111823185ad.296.2024.07.30.23.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 23:17:32 -0700 (PDT)
Message-ID: <e2cc1952-55fe-4132-89b4-5a2fb8c48666@linaro.org>
Date: Wed, 31 Jul 2024 16:17:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL for 9.1-rc1 00/14] Minor bug fixes and documentation
 cleanups
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/31/24 02:22, Alex Bennée wrote:
> The following changes since commit 8617cb073ca9fa5588d7afad5c81b7aa6cd02f26:
> 
>    Merge tag 'pull-misc-20240730' ofhttps://gitlab.com/rth7680/qemu into staging (2024-07-30 11:12:42 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc1-300724-1
> 
> for you to fetch changes up to 7b690fd3d039211a5bdde6a74b0ff95cb8b872b0:
> 
>    plugin/loader: handle basic help query (2024-07-30 11:44:21 +0100)
> 
> ----------------------------------------------------------------
> Minor bug fixes and documentation cleanups:
> 
>    - display packages in CI builds to catch changes
>    - stop compiler complaining about exec stacks in test cases
>    - stop loongarch compiler complaining about rwx in test cases
>    - improve docs on running TCG tests
>    - remove old unneeded avocado test for memory callback testing
>    - move test plugins into tcg testing dir
>    - clean-up and move plugin documentation to emulation section
>    - remove dead code from cache modelling plugin
>    - add compatibility workaround for lockstep plugin
>    - make some noise when building contrib plugins

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

