Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBB1C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 11:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtsZ-0001oE-11; Wed, 20 Mar 2024 07:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmtsX-0001nz-Ph
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:13:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmtsU-0007dv-5j
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:13:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-341730bfc46so1946435f8f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710933180; x=1711537980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLT36zFAQpFoqG862E+tL4q0VZzLaRuVRd3ZBpHKoys=;
 b=agQys1dSKOOoSGUQJ0j728ZsDTjGadZoP4fsCt2YFcR45lz4d9ZSApjhQOvgCmSJUj
 7GRuMvn+QdHTXIt0fWf2C/PBEv8NSdLgzBzuJpdKI5xqzzkZhjuoWTvHMJ0Ti29kDn+q
 8Qwdp4PzIV1i3tx/dIyLSX00leBHFMLv+j1QwrcA8ZtWv0cHboznngnfS6nvy5DlvGV+
 9X4XsWJLo2anstO4P4z9owIsguSmj2LmjlKAt3E+uZBhCU7C9pX1Dp8RPnP+Om03z/13
 NjEHGfkwwrYrZx3r+vxtZ8IJgYz06xpDmdj3wOf3KeIQPLRQZvBfpuknoLzLJtG1Tvqf
 /+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710933180; x=1711537980;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLT36zFAQpFoqG862E+tL4q0VZzLaRuVRd3ZBpHKoys=;
 b=Ajj8mH3iKVtmsIdLZrynCwf4LQN/XmNlXFRnXxlW2fS12JCgPAAwoEMCKTKcJNN1o6
 NW5VGrfWAxccDcTa+y3JGjMAD2QC8aynwl56MroKLrlF0UxtyhX+If94YS5/pBXUgm+C
 /AP54UWVZpam9ksbI9X0bDXYV++DPHU8NKEJsIKUm07umwM41UDnyhApDIqUiQyxWjQv
 VuZqQeL07ppa+AbNvYMyrgeX2OiYdBL/MWO4k21kTq6Vk1exxg0637Gjtyl6Qc+aUN4D
 z2AcYlH6Ez4Dj+qBA6uBRhrBvmkvt9bHaX31jeSn/MeJoQCNl2T6u+ivbnZyf+Q51QbL
 0Ljw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU5gVDbM/i8vzcFakbemiCAPHqD9GF57rgarjWOdRAwYQAZz2jZHPmdJVHZbZsr5LED7dNG1epnUvw3QS8HwkIinS3cxc=
X-Gm-Message-State: AOJu0YxMzLu5ME1sL7XsXqzbz8pNA4Wibitj7yQ3jAgLp8KhqCKLjvsY
 zAQo+6r6ZR6gX8198Fpvw7kn8XoqaDZ00Tsvx5BfgQ/50Fn4QkUT4SqT917+BOI=
X-Google-Smtp-Source: AGHT+IGMdaFGmMw4JKZc3R2FDyx3KM7IASF8ZHrhZo3oA/g4S1EH8eZY2Myrnoq6+2P8iYgQaksaXg==
X-Received: by 2002:a05:6000:184b:b0:33f:8e6d:ab75 with SMTP id
 c11-20020a056000184b00b0033f8e6dab75mr12884789wri.59.1710933180192; 
 Wed, 20 Mar 2024 04:13:00 -0700 (PDT)
Received: from [192.168.64.175] ([92.88.170.201])
 by smtp.gmail.com with ESMTPSA id
 t11-20020adfe44b000000b0033e122a9a91sm14463049wrm.105.2024.03.20.04.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 04:12:59 -0700 (PDT)
Message-ID: <08726125-8e4b-4ae0-a095-f58d6c175144@linaro.org>
Date: Wed, 20 Mar 2024 12:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] .travis.yml: Update the jobs to Ubuntu 22.04
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20240320104144.823425-1-thuth@redhat.com>
 <20240320104144.823425-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240320104144.823425-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/3/24 11:41, Thomas Huth wrote:
> According to our support policy, we'll soon drop our official support
> for Ubuntu 20.04 ("Focal Fossa") in QEMU. Thus we should update the
> Travis jobs now to a newer release (Ubuntu 22.04 - "Jammy Jellyfish")
> for future testing. Since all jobs are using this release now, we
> can drop the entries from the individual jobs and use the global
> setting again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 8da88c4360..16cf706c07 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,5 +1,5 @@
>   os: linux
> -dist: focal
> +dist: jammy

FYI Peter suggested to Alex on IRC to wait for the v9.0 release tag.

