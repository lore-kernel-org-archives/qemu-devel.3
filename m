Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73107C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvVY-0001TF-1c; Wed, 03 Jul 2024 04:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvVV-0001SZ-4f
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:38:29 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvVT-00006Y-EM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:38:28 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52cdcd26d61so5725749e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995903; x=1720600703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6FH9RnHj+2V6lBso7vQOvj4Kswm0JUh+dJIw7qWgDEM=;
 b=iCuKZLCcOdENk4g8IOtKU46kaOfz/xlXMsWBubCp0fYdwlJ9rSAruwja65dz43dfTi
 4jPmCxrHzarV4a6nCQE9KbNT7g1NDL0B1YqpQAsEkFDHgoq9SELRTRzDgIM7Q7LMO/dJ
 f3lyRuRVJ18tti51bF9wAOch+ZWsMFQ0qGTjPm7KpP8MSduCJG0ja6K+TXb9cYrWTSKb
 e4xro6WYZX88dzHOClMIwKv5xoPb8GR8SZSy49rMYHmDWxdgceWZobYVVDEPwTLpZ7L+
 qapb8UH/6Jc4jhgaZLweQCPg14RmPHnULd59TycMmCg59tKwtqxVeYwAx68M5AUvfe1t
 mtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995903; x=1720600703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6FH9RnHj+2V6lBso7vQOvj4Kswm0JUh+dJIw7qWgDEM=;
 b=hyZQYK8zdwAHULc0/qlncxx4dITJnXil8IQb58cXWh/Jb2mg8pZnf1xAqLgdyT/ew6
 yUArE7pnQAYY3C3EA/bDwIErWwM5P9T2aOlGLXPRBATX/u2yEJN+ubIF+UgvZ1l88Njt
 QvyWT8+1Rm+j8gE6NsXtog9odHvHoPc709qrQELumFg6Q+v2wbo4+osxKf8zJ41/bAGJ
 BIEXEhlXh1Yu9UuQ2aT3gTbAGOpe/j1W8zy3vEscIKutGTJX/geByOhJdOXdprBpjKEv
 iur6BU6h0qQ6IqG6tPJSMyhNx3rcARgE/QxzkcZdv1YMyy3TcOQSmsAs1kM/3uSv/WgD
 1DSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbhe49ZfPSZN+3rdBXp59ZouH2bHpGd5+viU78YNaTUFNSMVnAmQOJXX4+rxS75cwRWMroja0ryWKHpnReUGXY1iHTYrQ=
X-Gm-Message-State: AOJu0Ywmhg6dzSFHnqevWvSOTw/k2ThDn8upmzxsHMuTooRpleg2N6pb
 jtd0Ujn2cKdBb18TqPWCrKG8GIJ/r9VlH4DwyYtzSdK+Of09lXrDb5cGASZf/9c=
X-Google-Smtp-Source: AGHT+IHbmFO6VjSzJu6WCy1wipm2TCfM6CxBdxFQGHwc6jExrG1A14Rbeudn+skLfniPPSfhIYz3uQ==
X-Received: by 2002:a05:6512:33d1:b0:52c:e3af:7c5c with SMTP id
 2adb3069b0e04-52e82686b63mr7205295e87.34.1719995901311; 
 Wed, 03 Jul 2024 01:38:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a94csm229283225e9.33.2024.07.03.01.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:38:20 -0700 (PDT)
Message-ID: <4f030afc-9a81-4738-9e4c-83cbf861e117@linaro.org>
Date: Wed, 3 Jul 2024 10:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/22] qga: conditionalize schema for commands
 requiring utmpx
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-11-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 13/6/24 17:44, Daniel P. Berrangé wrote:
> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
> fully exclude generation of the get-users command on POSIX
> platforms lacking required APIs.
> 
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
> 
>      {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
> 
> to
> 
>      {"class": "CommandNotFound", "desc": "The command FOO has not been found"}
> 
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-posix.c | 10 +---------
>   qga/qapi-schema.json |  6 ++++--
>   2 files changed, 5 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


