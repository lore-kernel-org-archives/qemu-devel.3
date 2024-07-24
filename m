Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1090C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 23:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWlnq-0004bz-2H; Wed, 24 Jul 2024 19:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWlnn-0004aq-So
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 19:53:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWlnm-0006Cq-9x
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 19:53:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so310477b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 16:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721865225; x=1722470025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hJ/vGxsJP/YZ9njMBun5J/T2UlQmRVgXGZi4+AdlFYQ=;
 b=p5trHw9Ip9ffQ/PeT9Y9c9E1q7zqrLcVvnhDbuaUrZ7fWl25YA/7H/R6oitIn1QXRZ
 g1U72HJ8UxCqHRL1RrrPrNPebRoDBi9PxyCWNUkbOUyNROJp9Uflj3O7vs/Ou6FrbiDz
 9fP3gmfjTLuOkx4DyFVwWjCgNXXvfpF1D2gGRQEEMSxVxYW4GQfuOUvlOu0xXIFw57Jz
 fIljlff5/6vPt7Clp75WxvnLTzL0UhCvqytjY9N9J49o/Q3W7vhytSiETX0j3vXS3hau
 mtO7Bu3mW+KHudWn/fo/zy15tNeNl4AN7xniFmXwDx57sdUPerxS/SqoG9wEqg4snCKS
 Gx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721865225; x=1722470025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJ/vGxsJP/YZ9njMBun5J/T2UlQmRVgXGZi4+AdlFYQ=;
 b=VG0bChdPRIRfPH6giwC7nYG6AW1muishFQ132uDxHbBaR9gl7jPGDRJPOVMB5jqZFf
 7zgdFfef2ZMj6Fr0AL78eQHavhhUBeJt6Hzk1mf8iIZ0IXn/64tYg7rP5+hhIfGEcH6x
 jCsZiI3ZUs1B+A8Sn0J9ZNst4O4D6NCxxgQeq0mxXig99EXNpHrKuUuHPPWzbbFS8D8R
 D2gpz2ITv316gj/uZbjVTCxZFWU55OOTHShHuqX9uARpKJ3sgAinLHWgh7sbppMUQrzh
 IOEr8hv8HXwdwsOeccpphhz1LITR21Am6P8NJBKlgTxrEa4OddPoOWQUUlXaZngrL25Q
 iD0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5d1FFio29kpXtr3owt3ilqg2hXxm60znilpuOE2p5FQNQ/KkuH7brkiPOG+WX53KFvPqR0i2v5jWT7Kbh1sgUcHTXgRE=
X-Gm-Message-State: AOJu0YwZuV9mzeF9RgjDEre5UyhRurDmsyVxh4ut4yK7e4CGmNL8sIiG
 g+zj+dhYg9rWdqh85lyox/gBKtAJ1t7Ve8emJ9EFKpXVTHTORf97tLB1AzGKJlI=
X-Google-Smtp-Source: AGHT+IFY8pA/U6vQCDwLCmtCvYYpus2i5x5vlPNUZRDMOuhl6N/SWtlxxKfhZ8YF8QrEiDovf6Clng==
X-Received: by 2002:a05:6a00:21ce:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-70eae8e89ddmr170673b3a.7.1721865224631; 
 Wed, 24 Jul 2024 16:53:44 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead712ac5sm119859b3a.53.2024.07.24.16.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 16:53:44 -0700 (PDT)
Message-ID: <01aad959-8e16-4466-8967-7b05e7521387@linaro.org>
Date: Thu, 25 Jul 2024 09:53:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] Crypto patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
References: <20240724094706.30396-1-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240724094706.30396-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/24/24 19:46, Daniel P. Berrangé wrote:
> The following changes since commit 6410f877f5ed535acd01bbfaa4baec379e44d0ef:
> 
>    Merge tag 'hw-misc-20240723' ofhttps://github.com/philmd/qemu into staging (2024-07-24 15:39:43 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to 97f7bf113eb50fcdaf0c73aa2ee01e5355abc073:
> 
>    crypto: propagate errors from TLS session I/O callbacks (2024-07-24 10:39:10 +0100)
> 
> ----------------------------------------------------------------
> 
> * Drop unused 'detached-header' QAPI field from LUKS create options
> * Improve tracing of TLS sockets and TLS chardevs
> * Improve error messages from TLS I/O failures
> * Add docs about use of LUKS detached header options
> * Allow building without libtasn1, but with GNUTLS
> * Fix detection of libgcrypt when libgcrypt-config is absent

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

