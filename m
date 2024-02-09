Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBE0C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYDM-0005Ku-BJ; Fri, 09 Feb 2024 16:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYYDK-0005KW-LB
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:15:14 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYYDF-0007GA-70
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:15:13 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40fb3b5893eso11275695e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 13:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707513307; x=1708118107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aK5KX+3ZynB+mijEgyS+GWcIBjAuopdeuGMPxkBkOyo=;
 b=FjXq6D7EV2PCh6tceBoNp4zy4X2vL1QJxDILg5NWj9Ypw/Sw4u7sNbNirW2fv8tLXp
 weYVp/sBozuHifizCEOeDtONBvo8/T60kTJF/o16lN1+4ojqUrLNTq0StD6w/SpGRhVS
 0bwc7+8zEba7Cqco5fAcigCdAoTFBC9AMVlrp4Q3MSs4LpRrxaTEjFsBTFK19h6+fh1L
 9gnZQ8cJk+WYXjJqydS1D0YWpkIqaEtyG+Ap6O6z2/WcoGlxqbQxmOZx/MvTXhuJuCcj
 z2PwgmOSswUafCwI5qkgBN6FEZYOn9CUJ0Dq2dQAaq1V4MF5WwrOO+revW/o5HmmlrmC
 C5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707513307; x=1708118107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aK5KX+3ZynB+mijEgyS+GWcIBjAuopdeuGMPxkBkOyo=;
 b=mgxIzv79EbqO1Wc1+CeiMi7qtdMqoznmiI0lE1I4aBOBB694/cQ0D2eWnGOgn8maU3
 DAwAs35XoV/efwff00yWgwyi6g686SaJntWF5OpE9xMGZANl+ckuG28k8U4TGUGsTiQL
 IMscqYVmLBLfy4D1BaPNgEQvUNfvypKiVGt0mBMHZC9F2Zu6INkq8lLX65cn1KSFmLfl
 GC3AmZ6ygVJa360xL1nWaiuFmh0Dh1mhAvxbJj7EyCmA4qhZcfcuvLkZ7hX9gY1JVlN8
 LVH75S3IXtqkcgvkmEtXtYsxfbIZO1UhE6M31PqmPhpK0i/Gkqe0XpSXq6u6/5pFmjxd
 vEqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSHYM59FdZlxucWHZg3uc3vmfvlRrUEScjeO/CGrTFTlUD+C7Hl5o5wBTzggDntjZ0iMAXN7MlYBRRDat+Quk+l3djisc=
X-Gm-Message-State: AOJu0YwGYATC20XXwBNZvWzUR7TgnHT50ryJbucMjBzoUJmCRzTihakV
 fFSqJlP5MrtGb2nuXSM0nF1oHbK+F8hohG4+HTxxull4F/GI5K5mFvzwEacB0FA=
X-Google-Smtp-Source: AGHT+IHvR8XaVKebKMc3Btnrf7OD4Ueo4/V06hJ28RXPIBPoXnZw8kYdFK4bwr4HOrcKntZ/Ewc/vg==
X-Received: by 2002:a05:600c:314f:b0:40f:ddff:9cd1 with SMTP id
 h15-20020a05600c314f00b0040fddff9cd1mr427686wmo.6.1707513306905; 
 Fri, 09 Feb 2024 13:15:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXF1ruGt0LT0I03SgXTE50YxUVHTHpIEzUzq1in55c0mlDaOeMTHa9/3WrY4J38/U57BSB1HY+GOhgzT/e18j0tR72lcZk5OB1OjV2PWAxSgskS9IKHOfA2puaJ7iR9Qg==
Received: from [192.168.69.100] ([176.176.147.207])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c204f00b0041044e130bfsm1625788wmg.33.2024.02.09.13.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 13:15:06 -0800 (PST)
Message-ID: <3d787d15-9dff-479d-a96d-ad9d7bc67ab7@linaro.org>
Date: Fri, 9 Feb 2024 22:15:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community Call 6th Feb Agenda Items
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>
References: <87mssij1y2.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87mssij1y2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/2/24 16:55, Alex Bennée wrote:
> Hi,
> 
> The KVM/QEMU community call is at:
> 
>    https://meet.jit.si/kvmcallmeeting
>    @
>    6/2/2024 14:00 UTC

BTW there is a KVM-only community call every weeks
on Wednesday:
https://lore.kernel.org/lkml/20230522072508.GA326851@chaop.bj.intel.com/T/

Maybe time to name this one simply "QEMU"?

