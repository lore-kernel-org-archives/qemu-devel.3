Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15044C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvdo-0007dO-Ar; Wed, 03 Jul 2024 04:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvdg-0007aO-J3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:46:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvde-0004i3-Uy
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:46:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-424ad289912so35747295e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996413; x=1720601213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N9bvL1+HdDzJokAo5TtS7mNrOx9Wbo7iYajtyDWJmzE=;
 b=yL4wyfQ+mS/G5bqzgL/W01dnzSZZd6osCXTds4lXrH2HjG50qGqROZO3phSfeymGo5
 /S8pavJPsBiAhYxOr7bm7KCfKhZKUf+heJc0WE94XZr56ifHVnvZnVRk0zHVtIPPANaM
 fc4n4PMoUV0rZ7fpVrDSz0RiveiKSWqb9R7Bt7k4l/GNcHc3/EzQEXX/TcDcGl0wsuo3
 BiBQIx7FiBlNg5liUrUPXFkSvNtvcHhHgjJT9dZcoEmBOxoq4HU6sAblM9uuBMBSSP2/
 spgnyGrN70k0YU/Sd7nkws4mDfgxF1ZatyDYd2wwoaoe/Lm8Nhn3DiY0CVx7KoVjldC1
 viQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996413; x=1720601213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N9bvL1+HdDzJokAo5TtS7mNrOx9Wbo7iYajtyDWJmzE=;
 b=cYTxJkirNno1enWJkjvq0ZS3E3HTZlbd24b5btktm6SizQOg23/DLV4k8Z7OaI23TL
 LDVAwWlDAUAUJQ8vuIwFWwEiI3vUnMwphfplSk0QO/rKloafKID4F6StZXvwUW1HtyEL
 xyH0wkM+M4ROmAGSGpO3c5SidkuBpcNBiJuYum5Zc/SEUyX6BjBpzWo1vKRWYBwGEyBV
 ZaVrNiK90dqXpnsVVJfpIhfNu8csNthTiaBZRhk3IYry55boox+DKHzKXt13FW9ba405
 /7k43QpjZgtgS8Ui9bb1fo/bj/JX1BgbT1A22i6A1a4UQ6c0G93BXGRR8ETbKYdKAJx/
 dpuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/nD2CBN2OL7JYtgMt6j/qNsrjtjXIAuCohZOqlmAyLJVh6t85a747N7O0COMDc4SMB8JDQCfJjFQQmpkRxFKh/U+S9+k=
X-Gm-Message-State: AOJu0YxwBq1OBOEsFpRu9F6r+APkTKZpFC28nMhVUXJoEJ81ZjA+TTzz
 lp+X8mZbL/BSmFv+QOooTTxcr2A0tkSgrCip2zpxNdrvEHHmt1XhjbJR7y3D2UE=
X-Google-Smtp-Source: AGHT+IFAvi2vH2INDoW2XHFejJQMDTU81dGcUzljaTOvyxrNicT8yBEDnLirkme6dENn5dXrfAWHng==
X-Received: by 2002:a05:600c:492f:b0:424:a5d8:ac83 with SMTP id
 5b1f17b1804b1-4257a03acddmr59977955e9.41.1719996413170; 
 Wed, 03 Jul 2024 01:46:53 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42577a0c286sm123494165e9.0.2024.07.03.01.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:46:52 -0700 (PDT)
Message-ID: <9757b113-b6c9-4676-a63d-d2b07a744be1@linaro.org>
Date: Wed, 3 Jul 2024 10:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/22] qga: move linux fs/disk command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-5-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613150127.1361931-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/6/24 17:01, Daniel P. Berrangé wrote:
> The qmp_guest_{fstrim, get_fsinfo, get_disks} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-linux.c | 904 ++++++++++++++++++++++++++++++++++++++++++
>   qga/commands-posix.c | 909 -------------------------------------------
>   2 files changed, 904 insertions(+), 909 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


