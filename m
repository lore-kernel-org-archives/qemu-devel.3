Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFB7C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 00:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZJFL-0007sp-7R; Wed, 31 Jul 2024 20:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZJFI-0007mB-Et
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:00:40 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZJFF-0001W8-Mv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:00:40 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db14339fb0so4254272b6e.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722470436; x=1723075236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POBy1K5mCGt/b/F4FfqA83WcsaZvWr/V0+OpFVVRIWI=;
 b=kb3ln5CXl9dNDEHbVctSyW36Hw79VgVrmpKtXrSzNRqzBqraIMAlpYkx0jNdkzZ/66
 IBtfxo0hUwqK7VQ7ei+WPNbL1y14RBe1qUY83Rp4HK9aWre20uO4shMY9SvMT8U7xJop
 dgzu/3pSmGMuCmsV50NprO68Ri9qGBW0sC5aOCpgzYta2MnstPU2vm8pA9DglnYI87Rw
 focfh0gKaQLiu63UREcqW9zc/OSAzHcRraGDjzEF8066ZjsUc3/3su9W1WToZt5g2PG9
 ak6aR64pcUiyNe1llRPVMvHmjOayCCfJE/J0GRTleIPJKbvzYkzFwx0K/ZNwZKCmFyKY
 dgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722470436; x=1723075236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=POBy1K5mCGt/b/F4FfqA83WcsaZvWr/V0+OpFVVRIWI=;
 b=FWWr4oAGkdxoF7jd81ZXmiEJhGbta6/54jX3SWWzRdThCHIOPcoeDNKipFjOdXDmjq
 C77nt43LjxyDnHVEU6cOnsnY34vkjnEiC4WQ3YQwpYjyiSVQyykRySEmCSjR7TO4+ScF
 eza2jXoDderxnkjuRpTg3ocOLD01WPT1Zs5p9zY10FJTiNFAPOB0detUgbQFCiVkE9e3
 9e112OzodGFnVcBQcloDARCAZefEGwFiBAYzCZmQWT4TbqJ4xmeSxPIIAj3bq4v1k37U
 cKstGhFnr4Wd7Wbf2F1cA/BbOLjYCCxtrM8CfeILUBaENSRcSQ2uk0taTlthBXKvA5Mc
 XKHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0kc0Ek13tsM26Kwnw0dfv+da8rb1JCkdTb4zZifrxYu7sBhgZAmzXQT2c8ZFs0LguDqmlqfq7Ak52yPS1rSm6F7rXtRI=
X-Gm-Message-State: AOJu0YxnsXM3cIdun6o/m59YUam2CsRD988hlOsirgg1arsOHFREScd1
 ZWov2mBg78sIaVRfSfSNf9h3qpbOkp8j7Tgp5P9ttl3JiP9GJ/L1EzNr7HdbUjw=
X-Google-Smtp-Source: AGHT+IE3RYYDW3a7+e9z+4h9AhfBKMmEzeNEamH1mpVcoxenEMdr9Eo+x+vBhzZplg2PfeQpkm+hPA==
X-Received: by 2002:a05:6808:1984:b0:3da:9f65:ff6c with SMTP id
 5614622812f47-3db511e59bfmr779163b6e.22.1722470435656; 
 Wed, 31 Jul 2024 17:00:35 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f8754a3asm9445140a12.45.2024.07.31.17.00.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 17:00:35 -0700 (PDT)
Message-ID: <69136855-0b85-4f7f-9d77-20cbffbc20f8@linaro.org>
Date: Thu, 1 Aug 2024 10:00:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] i386, tests/vm changes for QEMU 9.1-rc
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240731111806.167225-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 7/31/24 21:17, Paolo Bonzini wrote:
> The following changes since commit 4e56e89d6c81589cc47cf5811f570c67889bd18a:
> 
>    Update version for v9.1.0-rc0 release (2024-07-31 16:21:21 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 2a99c2ba822ef9758d739ffdefbe6252520c1719:
> 
>    qemu-vmsr-helper: implement --verbose/-v (2024-07-31 13:15:06 +0200)
> 
> ----------------------------------------------------------------
> * target/i386: qemu-vmsr-helper fixes
> * target/i386: mask off SGX/SGX_LC feature words for non-PC machine
> * tests/vm/openbsd: Install tomli
> * fix issue with 64-bit features (vmx kvm-unit-tests)


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

