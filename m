Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0D0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogdh-0005Hx-Jr; Mon, 25 Mar 2024 05:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogdf-0005HP-NR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:29:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rogde-0004uw-8k
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:29:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-414859830f2so7375875e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711358944; x=1711963744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8UD1KqhjMpRyUpaYxtPeUfGjffxMoqYw1nFKvrqlXt8=;
 b=aZFleA3GHuruddmU2S97ZMKgzGRdNBEeJHj8vCZMVXv7vX3tGRqA+FWNrvEsR5F+Mp
 jfwFyT8VmWZOgc+c+X16FKRzW8niUxjVw4Xq8TNx+7d2tEwnEq+zqdo9HAVtyI3/5DPb
 2nXTg1afQAkMIxJtDADsoOb9I7g9NJedPTslaFjwzhJuQJAQ6ambYZrQ7CDCBbQ8AsjX
 +5ZUKHKSzrcIin/QMFLIALBc2kpJrDi4hGZB7MPMzRFjNcYPr/rSLejhSkExWFT9rJbC
 /u5Kea9IhQfvv9zjDfsbfASG7npqPMkBYe5ZF1efip9HNhYOEypsl5rHegMQ590UXmRc
 xsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711358945; x=1711963745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8UD1KqhjMpRyUpaYxtPeUfGjffxMoqYw1nFKvrqlXt8=;
 b=hh+8b51XVqjZi1OSv5ZQ6SE/wZCU/D9CfuAatHPKiNtDS4Dl1BLDs0/RBpJw7ypyKp
 RGrH08YQHsis7XaglES9hxrdE0DM+bDXfDcJ7xkaQVeaYn+jkvZI4SoMn80CBeFbZ7rE
 6XOqCzMJk2aN0n25EmZReq7f3Dp+0Kl4XymruvcqDbFCiCJ6ANrQgPnH2AJrVUVVKwnK
 6tSgErXuNNvMXcX5CT5Viu6f7vaIZvwR3KsaZSxtWHj9kOPju+5UHZrJHbwT9aLGbvii
 VnvQmpfWESnuInXKlg+yQsfGNLFYGbKM6ex3gae0c2egV1WUbQB2Q8cM/G6exrY8jizv
 LE2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx5oaZ36PQKzzGxwHkCGoNXLZWVNd6pr2PEiRsOHR9O/n8zms2ProaRsZqcbTHUr92JtmeQBEyYa3MktzJ0VeC7hRdygQ=
X-Gm-Message-State: AOJu0Yy4tmA5yyW40M7vTCBhw6dY/KCL590vYv2YyOG0GiLxF50TtdRZ
 +2nidWPHBZtiXOGBch39Unv0I2swojxTs21pADjpJzsdmubPGevRP/c6/aSxcik=
X-Google-Smtp-Source: AGHT+IGOECRCJf9ZYfyrTcQre2P4FqB44OVLrlWY2JfyeQdfwoL2S+2mLfttEZQad+w+JhJD3XsfqQ==
X-Received: by 2002:a05:600c:4da4:b0:413:f290:c747 with SMTP id
 v36-20020a05600c4da400b00413f290c747mr4665447wmp.33.1711358944710; 
 Mon, 25 Mar 2024 02:29:04 -0700 (PDT)
Received: from [192.168.163.175] (237.red-88-29-182.dynamicip.rima-tde.net.
 [88.29.182.237]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c1d8c00b004148b8fb25fsm792985wms.22.2024.03.25.02.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:29:04 -0700 (PDT)
Message-ID: <93004298-25d3-485f-9d25-22e9398bbe02@linaro.org>
Date: Mon, 25 Mar 2024 10:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/26] target/i386: Implement mc->kvm_type() to get VM type
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-16-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322181116.1228416-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/3/24 19:11, Paolo Bonzini wrote:
> KVM is introducing a new API to create confidential guests, which
> will be used by TDX and SEV-SNP but is also available for SEV and
> SEV-ES.  The API uses the VM type argument to KVM_CREATE_VM to
> identify which confidential computing technology to use.
> 
> Since there are no other expected uses of VM types, delegate
> mc->kvm_type() for x86 boards to the confidential-guest-support

s/mc/cgs/ here and in subject?

> object pointed to by ms->cgs.
> 
> For example, if a sev-guest object is specified to confidential-guest-support,
> like,
> 
>    qemu -machine ...,confidential-guest-support=sev0 \
>         -object sev-guest,id=sev0,...
> 
> it will check if a VM type KVM_X86_SEV_VM or KVM_X86_SEV_ES_VM
> is supported, and if so use them together with the KVM_SEV_INIT2
> function of the KVM_MEMORY_ENCRYPT_OP ioctl. If not, it will fall back to
> KVM_SEV_INIT and KVM_SEV_ES_INIT.
> 
> This is a preparatory work towards TDX and SEV-SNP support, but it
> will also enable support for VMSA features such as DebugSwap, which
> are only available via KVM_SEV_INIT2.
> 
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/confidential-guest.h | 19 ++++++++++++++
>   target/i386/kvm/kvm_i386.h       |  2 ++
>   hw/i386/x86.c                    | 11 ++++++++
>   target/i386/kvm/kvm.c            | 44 ++++++++++++++++++++++++++++++++
>   4 files changed, 76 insertions(+)


