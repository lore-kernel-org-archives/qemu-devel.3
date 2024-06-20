Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18774C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKLOL-0006zF-35; Thu, 20 Jun 2024 13:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKLOI-0006yz-Pt
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:16:06 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKLOG-0004bD-8S
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 13:16:06 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-376208fbe7bso4161005ab.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718903763; x=1719508563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iMOzXAVz9g/6D7IcBunTPzUS6D6eX8YxQFJu2pcH5SI=;
 b=jCgeve5CBnBZ+UBzA0dmGP0vzhO6iRhMI307PfB19RG2awkDlPqcvbX7wUgr1BSoyB
 96WDsc04kR8a4uFk3KXponCuPZfnGLoy4kyutT+Gsz4DlNylxJ76bstRzLCCf9VxOU7w
 2fCsJq21HSTvikYpJdWa9rmnIPjGTU6Kg5DdWr8eM6jSjs4ZAbJlbzzsq0jDZrx00XIx
 HK+qq36dQDbipE7pGwOAjSlrE1j7PoMiclKtmJt2wi4ToqHlDcNH8PiHwvUnt5gkYCog
 NtCd7sMbiXLLyB/AjwR5pXGF2FacqqHLU0rwFglH8sf/csF2FpSXpcTMsUb3YRzKyDp8
 MG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718903763; x=1719508563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iMOzXAVz9g/6D7IcBunTPzUS6D6eX8YxQFJu2pcH5SI=;
 b=nllfq8tNjfcqDI1LIB5xkv7ywMp0QD+EyFZQ7AGotzU3hupLgNmj+g6foxRQI0U452
 UbETI+aX3fjpmvxL7CHILByJldSwXKMIt2zoVWVUD7ZQ6skRTAqFJYQtlahUhWIqbY6Q
 bBcuKAKKoEOfSNYhXFtWgurZGP44YXoXUART/8RcmbxUZE7qNcKQVTvDVMOq2wp4gvXR
 Oav9P8Pq3u6+I3BtX+A8fWN9t9iTOX6Zf+km9aZXblCbaDhZXN7Smk6FoYPnOjK3AdnF
 3I9qNyPXMVdU1NJjSD5xB6Gz5YPJh4ENz7FSb+YAER2P4v37X+5ySOqfnrPi7WVfYnIB
 dVaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPKQDVIxajOElN4kUM//wixlLYc4r/meSWYPHBPoYpZEDVSX9jMKbT58b86cPik3L9SE8OtjmNOMj2Z4P+wK8bc3zIYh8=
X-Gm-Message-State: AOJu0Yw6+Io97pazvO3uBOboEIexVbqVT8DwJxOt5bJR9STJY/SMOokq
 FNk/3JfFaiMWEBx/o5OcSH45Ix8qoaEEqbxIrSOTGo0rZiEJ1AapFd+8tDG9JnI=
X-Google-Smtp-Source: AGHT+IFSomVENBcfSxj2TSe78DgbJFZqpKy6gNWdlvx5qNOd0ScQ1/W1iCeQ+J3dZfQ1VgCYctWDFQ==
X-Received: by 2002:a05:6e02:1fea:b0:375:ae6b:9d9c with SMTP id
 e9e14a558f8ab-3761d710f83mr70394655ab.26.1718903762915; 
 Thu, 20 Jun 2024 10:16:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fee2d34be7sm11209369a12.63.2024.06.20.10.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 10:16:02 -0700 (PDT)
Message-ID: <56955999-6fe1-4f39-a519-2175988b1ff9@linaro.org>
Date: Thu, 20 Jun 2024 10:16:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] meson: allow configuring the x86-64 baseline
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 amonakov@ispras.ru, Warner Losh <imp@bsdimp.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-5-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240620130254.415699-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x136.google.com
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

On 6/20/24 06:02, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build                   | 41 ++++++++++++++++++++++++++++-------
>   meson_options.txt             |  3 +++
>   scripts/meson-buildoptions.sh |  3 +++
>   3 files changed, 39 insertions(+), 8 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

For -mneeded, we need gcc 11 and for enforcing GNU_PROPERTY_X86_ISA_1_NEEDED we need glibc 
2.33, so:

   debian 12
   fedora 34
   ubuntu 2204
   suse leap 15.6 or tumbleweed.
   centos stream 9

I believe the -mneeded option will be accepted by FreeBSD's clang, but the note will not 
be enforced by the dynamic linker at startup.

However, since this is all optional, requiring an explicit configure option, I don't think 
any of this versioning should stand in the way.


r~

