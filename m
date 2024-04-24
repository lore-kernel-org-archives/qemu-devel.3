Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7E7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 16:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzfNF-0005gZ-Cz; Wed, 24 Apr 2024 12:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzfNB-0005fZ-JJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 12:21:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzfN8-00057V-1Q
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 12:21:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed0e9ccca1so110509b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713975684; x=1714580484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XtBt1mpeViOW/2opm2LAqgkdm2oQdp4hI0Sv15vwrqk=;
 b=eH0xVNGcRbBx0ryK2nPH/4eTC6vXOphnX2ZLf/IBxlWc/mLWcC0EuY8sBzkGg//FMB
 N9+VScjMOw9rnooPyWCF+kN5otYSj0J4wfHRSQkaMGSrunP61MWC6tRMhXxEP6wE/KSG
 KT9iB2Nc3hNFZoPBwb4RPiry5DLFzYPxgaXaDkW5JsftVbueJcv1Xks0jdWxq/hlmyBA
 zea+AxEngh3QZWa8D4j/u424uiPgwRPsb5d1lP8tb/CQKQF88dG9sBwguojwMaEIb++p
 SaWoFNUB8PE/eW5O+OweaoGFD7vC8BuZiTyGxVT4bfEgP192u3aHHE0XtBjNkuYKQDbA
 RUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713975684; x=1714580484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XtBt1mpeViOW/2opm2LAqgkdm2oQdp4hI0Sv15vwrqk=;
 b=S9ym7H9tZ0KA0l9QZ8yakhsxagaSWySK7tqxSjARV3sezg1OlaroUK1OJ881+NX6to
 Q7VGPOqTX024dAsT/B43JNJn/DA2cxhWK4jEeR9sVpg7wNiH4V3eyyYyjRJwoiQuoCzn
 x+3Y9gq4I1Uh2WeULo9Fz0+iqvyk6NJcecldc1elHGP7QgVcTuPkgWZQEx2R70084ICf
 HMnzVy3h4FBWO4jklGz6FBrK3pES7yIbKVmoZndqu2zISS2BUxirWBcfiZ0sTOPnwwRb
 WEuy2JGXlYJ86k2UbqatibudwuFqrPMfpq2kkdGkM++ONVzkwiWOgqIUxXs4h7yjpHcl
 7okA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoT/u6m2joRmFA7kSuNouASYl1a6RifpdcfVh8PYNk8FeicxXXZp06h5m+pvryejbfomLyacHlaBy1pKXV46NJUg1H/zg=
X-Gm-Message-State: AOJu0YwXApVhMe2ctCu3wjc1c5f/lLOtkDgPHTu+dFY1O0A6s0mjgTlO
 uULoFUNyXajOIkjAZ0ryXEfbkKX0yBrRaKk/MBAlefMDOMYYegS6lj4+5k1RclQ=
X-Google-Smtp-Source: AGHT+IGV1z4ZpajfaVWoo7qXqW6PohFyKXPah/1GE+c44qxghBPiU5SB+MFqnv/+3yD3PO44rBrt8g==
X-Received: by 2002:a05:6a00:4f87:b0:6ea:b1f5:1134 with SMTP id
 ld7-20020a056a004f8700b006eab1f51134mr3715744pfb.27.1713975684637; 
 Wed, 24 Apr 2024 09:21:24 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 fa19-20020a056a002d1300b006e57247f4e5sm11623447pfb.8.2024.04.24.09.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 09:21:24 -0700 (PDT)
Message-ID: <d4b2c78e-c8d4-465c-a47e-53aa49efeb06@linaro.org>
Date: Wed, 24 Apr 2024 09:21:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] CI job updates, header cleanups and other misc
 patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240424075735.248041-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/24/24 00:57, Thomas Huth wrote:
> The following changes since commit 13b1e9667737132440f4d500c31cb69320c6b15a:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-23 17:35:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-04-24
> 
> for you to fetch changes up to 8f29bab03ea22694a127ee33edeb4ce99eeb124e:
> 
>    target/s390x: Remove KVM stubs in cpu_models.h (2024-04-24 09:45:02 +0200)
> 
> ----------------------------------------------------------------
> * Update OpenBSD CI image to 7.5
> * Update/remove Ubuntu 20.04 CI jobs
> * Update CentOS 8 CI jobs to CentOS 9
> * Some clean-ups and improvements to travis.yml
> * Minor test fixes
> * s390x header clean-ups
> * Doc updates

This introduces a failure in the migration-compat-x86_64 job:

https://gitlab.com/qemu-project/qemu/-/jobs/6707154868


r~

