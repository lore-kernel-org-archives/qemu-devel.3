Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B57C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 16:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzfLQ-0004R6-7d; Wed, 24 Apr 2024 12:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzfLO-0004QT-92
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 12:19:38 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzfLM-0004Ka-59
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 12:19:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6edc61d0ff6so82644b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713975574; x=1714580374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+DCqDUDSMDifVRXyPxGaer478v67Ao175nZK6IgHwjo=;
 b=sWw4yQSqGnCLJGAv/rwurYfzc6HOiMDH7hjvlF5F8dQcofBFwyVN5qnRIvCT3Mj90G
 hbi7YSMJTYP3NJrPsb8CWbV+gi1pS9lKEL2YphXxB3fuNXrpHkAlkFzyWc8faebXrCkG
 0YRkpDWERkmGh5wfp4RHVGWVX2I/bRgQJMSsw4QRInqUnlW9BjF8WfhsSPIG2NUs5PE9
 vGYYz1chz4eMlcd3J6lSD2QqSDJMZQ7rQO1nrh0ujLKePMwZCJuQAcpMi65tnOF5sifj
 bC0+bhbCHbL4UY8NPI+lxg2K2lccOdX9we53CumnfrWJKVjUHVr+vrP4SwFNpUQvMBou
 3bLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713975574; x=1714580374;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+DCqDUDSMDifVRXyPxGaer478v67Ao175nZK6IgHwjo=;
 b=ogLoXSMPv73G+Q0sHPoStJwnA2qOIm5JrecO10AUU3ROBeevnk+Eht/8+XCx3IpdlL
 OSCqTM8vOMR6UuMBmtOuJ1Ri+qcmHKMICGJPE3p5TB8HJKjAHwO4gBfDV7/lDILQ3wx3
 1dOHop/adul7XX1YEB5pwKGUUG4b4tMZnQclHcuji9BYBjDhMqVnxHGKlXoDKgbhSEsg
 AK3k1KpeGruZ82hnY8yTWKQdONrlth1Ukd+JpJNM7EwnsOyZSZKi5eALCrhjOI+kXMJX
 fa2Wy6LsPg29b/4M4iFECdMLgr6Pr6mBWBgLb0lgZkTCoMl93j7pTZC0FRwss4T1WQpE
 xd5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKXXWXXUhqAgqGtffEsumlQbDh23kWileUv/vnCocoNEA+mqNeKBSt5Ty9ScVWLh29T0gjfx7FNNCD/0mn90dxEPY9Yys=
X-Gm-Message-State: AOJu0YxzUvKWj0bnutLvmj9/byxWKV+Q99v6vUxhxSXsYWFG7QudTSkl
 ua7N8j/LuU9jxk4y6BZbx++CYYtj47iHbSzTQ91SQ2gCaQduMRVkciY/4vMdWjY=
X-Google-Smtp-Source: AGHT+IHfJi40VvLoXNWKvF+RTDHIcWEVGciA1kdO5NGeRK9mPwwhVaXROku3sjaZ159hsD2Al/fsFQ==
X-Received: by 2002:a05:6a20:12c7:b0:1ac:34cc:b323 with SMTP id
 v7-20020a056a2012c700b001ac34ccb323mr2999800pzg.33.1713975574223; 
 Wed, 24 Apr 2024 09:19:34 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 gd22-20020a056a00831600b006e6fc52ecd0sm11585594pfb.123.2024.04.24.09.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 09:19:33 -0700 (PDT)
Message-ID: <49bf70e6-ad71-4bb4-80c6-2bab08a3145b@linaro.org>
Date: Wed, 24 Apr 2024 09:19:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/17] tests: Update our CI to use CentOS Stream 9 instead
 of 8
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
 <20240424075735.248041-13-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424075735.248041-13-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
> RHEL 9 (and thus also the derivatives) have been available since two
> years now, so according to QEMU's support policy, we can drop the active
> support for the previous major version 8 now.
> 
> Another reason for doing this is that Centos Stream 8 will go EOL soon:
> 
> https://blog.centos.org/2023/04/end-dates-are-coming-for-centos-stream-8-and-centos-linux-7/
> 
>    "After May 31, 2024, CentOS Stream 8 will be archived
>     and no further updates will be provided."
> 
> Thus upgrade our CentOS Stream container to major version 9 now.
> 
> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
> Message-ID:<20240418101056.302103-5-thuth@redhat.com>
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml                    | 16 ++++-----
>   .gitlab-ci.d/container-core.yml               |  4 +--
>   .../{centos8.docker => centos9.docker}        | 34 +++++++------------
>   tests/lcitool/mappings.yml                    | 20 -----------
>   tests/lcitool/refresh                         |  2 +-
>   tests/vm/centos                               |  4 +--
>   6 files changed, 26 insertions(+), 54 deletions(-)
>   rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)

This has missed a bit, since the centos-stream-8-x86_64 job still exists, but now fails.

https://gitlab.com/qemu-project/qemu/-/jobs/6707154779


r~

