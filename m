Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69315CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraNH-0001hS-P6; Tue, 02 Apr 2024 05:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rraNF-0001ef-SP
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:24:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rraN3-0003KI-QZ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 05:24:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-341ccef5058so3619407f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712049834; x=1712654634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1P3wQPzRso3RO32rKIIx8mc4oITjuFTlUxDdA/8ckJU=;
 b=O1CeR1EFnUoNeyc8z9M9y7XAdCAUVA6QQOe+9uGTzuTdbC2enPk+muWcxZ4Kc5dn5t
 9LNYAWyG+PracLSWipxcNOnfzqmeA0ImQXHZZIa05rEXTgUS9/Vi+osmnZhaxFVNBWdV
 GJIKEZwvy0tmjv5/toBbH/3fEjkYUomDynP4RXOK04kOdbTn78KMKOgH7MNV5wWETIYa
 pJUgMDHFZ41LYK+KtNHACARAQXoqqJLQLQ3rhFpWCPUkQuQ8P+fJGLTlCe0haehfhmne
 o2uMLWHuqc+nUoeS1BCkXfKcqZxeC/lkBkRbLhgsIAtCHtupWM60JpPVhyiQDPpfpTgv
 VDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712049834; x=1712654634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1P3wQPzRso3RO32rKIIx8mc4oITjuFTlUxDdA/8ckJU=;
 b=TnvRfaR6hiAgaFF4T9+QzOXsYfaW+39UD12LZJVnyiM2pdvQLuxVTq2bPDg2TJdVU/
 vxQfYvwD25KbW/o7ZIzQ92IVhZ5oz8xbk2tbLOFOqEYoSrirbBl4sbudvItcpaBS2A7i
 HBVEpsBN7HprHOMfriTXPwFd+O6orp0eUN2uhFedAgIlshelPLZm6rZ3EIjy+yf+pQBQ
 bAbDcwaj6pZnikehRBxVgXrPKowa50fiT91gWHe0IHNhI9inMXAVoyxekom2IcxPzgta
 2ZgblJnf0ARrBwaJJ7gZR8bJUKFy5skDw/DB+R+HQTwZYcWhqGAOJ7hpfmyiJHL6Vact
 h9eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdn2xl8EuIke7pyOYsi/mcdBYzJwPKvnETd6VHY+5dz8l/4mmW8URlxg4ExRSdUBVFMcFhCXocTck0B4WoBL3YJzTVw4c=
X-Gm-Message-State: AOJu0YypuZ9rwQlZCfK0Z0N+u6GMqwfeXZLIzrfrhR9zTiEeJPjJAe1X
 Hr1VqIO0H0aUL7BkUsUM1IWRa+GaA1EdSkYjQJHItn72KKXkbpiiYXNQOlPj9Zo=
X-Google-Smtp-Source: AGHT+IFMM+ndy0KJgYUiGlkgXPY5iv7gL+YLtwtcq1mSsCY2ISq4VEFssqoCI9DL7Jr7j/1o8LiTVQ==
X-Received: by 2002:a5d:678d:0:b0:343:2d43:2b00 with SMTP id
 v13-20020a5d678d000000b003432d432b00mr7536087wru.62.1712049833928; 
 Tue, 02 Apr 2024 02:23:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 dv10-20020a0560000d8a00b00341ce1b64f0sm13651807wrb.17.2024.04.02.02.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 02:23:53 -0700 (PDT)
Message-ID: <7eadc494-866f-4126-8f9d-5407a8003371@linaro.org>
Date: Tue, 2 Apr 2024 11:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] qga: Refactor common functions between POSIX and
 Windows implementation
To: aidan_leuck@selinc.com, qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
References: <20240329153155.17840-1-aidan_leuck@selinc.com>
 <20240329153155.17840-2-aidan_leuck@selinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329153155.17840-2-aidan_leuck@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 29/3/24 16:31, aidan_leuck@selinc.com wrote:
> From: aidaleuc <aidan_leuck@selinc.com>
> 

"In preparation of a Windows implementation, move the
  non-POSIX specific code to commands-common-ssh."

> Signed-off-by: aidaleuc <aidan_leuck@selinc.com>

As in v5 
(https://lore.kernel.org/qemu-devel/63600417-9187-4d0b-8bcc-db7e965ff008@linaro.org/):

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   qga/commands-common-ssh.c | 50 +++++++++++++++++++++++++++++++++++++++
>   qga/commands-common-ssh.h | 10 ++++++++
>   qga/commands-posix-ssh.c  | 47 +-----------------------------------
>   qga/meson.build           |  1 +
>   4 files changed, 62 insertions(+), 46 deletions(-)
>   create mode 100644 qga/commands-common-ssh.c
>   create mode 100644 qga/commands-common-ssh.h

Kostiantyn, if you take this patch, please amend the commit
description and prefix the subject with 'qga: ' :)

Thanks,

Phil.

