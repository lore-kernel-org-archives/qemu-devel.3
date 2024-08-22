Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41A6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8Gu-0001cA-EN; Thu, 22 Aug 2024 09:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh8Gb-0001Tj-Ev
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:54:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sh8GZ-0002Wo-1L
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:54:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37182eee02dso476236f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724334855; x=1724939655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1TQSLIq57iobIWGDTSxG+4h2QSqHXqmmDiJaZypcQHU=;
 b=HSN3FulF/8rVDFiloShiidKfblBKgjSnVF3r9roNJRZvI1Ga+QhjsRFIpZlmGZrC60
 /bapOk4VRaCnf79V1QG9fGQSkZ2dX9Qd9MhaOM75n0AyysjiPaarOUtnzuqhBfkbJMF2
 XA6UX3EH+GYwfKvMNl+Ktqz+r5cy0dq10URUpUYoMzDP1IVf/CqOPQ8Af60jMnV6qVMv
 iTOy5c8up5HUKBSGKxIVCUoNJlVua3wqGVFrCHVcjS72XJdyrUU2RHKUjSKQzDq5Y89C
 YJrhRjxEdycn8z0lxhcJczs8RXfc3pLWBu6NZ9pTipcANxiWSgMOkil3cDKPyWyOxh3f
 c93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334855; x=1724939655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1TQSLIq57iobIWGDTSxG+4h2QSqHXqmmDiJaZypcQHU=;
 b=oDpv1Zf46tUX5Z41JssBQpeLonIIcUrMQtOHn9x0JagAErgHuBePwhpSVvd/OnjSmq
 J2PndQLai38mEREwGx0ZIE+RTHORtSKdvPXrPewqCdGPawiMWQtTAZQj7hJybQ5mwpNK
 C0yfdZw9jydf370Wv5wT2ijrVp3uw7/n8KaM8MhiZ5A+iOps/mULcWpRbSPCiBbckTjH
 z/8K3bbvnumJUFtOTzOsDF2rJzX0RStZsXeAZUmLZLmdKGeKe/N9+X9d8Pq7SpVPsgKa
 BmAAO3NnXb7QktwUQdcyFMRX7RVgRNNWVMt5GEFYTrk9mCRn00fra4oBZQCHhAdhd+7H
 mDWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/7ZWqIyqPTKC7adClGcGJ585RQwdUWHye2FTzAdeL+jkz4lezwy/J5O3NFoRG9M4eM1hkfnU6DBPh@nongnu.org
X-Gm-Message-State: AOJu0Yx5LD8YWHOkobEe/4KBu0EvK6AdN1XTH9dQGMxTXtURcEvQTf86
 eMf5ccks9pqNmkl+2Q5n+dbGz3UpN+R89cMunBkpZmM+Z6aMqaXRsSNvJaEFdIA=
X-Google-Smtp-Source: AGHT+IE0wvkxem0zPetzhTO42yQ2Ur3FmE6bfFu1Fufyg5xYw4UdIsR+FDGExEMBwIpdrfOU3JEl4w==
X-Received: by 2002:adf:edd2:0:b0:371:8685:84c with SMTP id
 ffacd0b85a97d-3730526a2f0mr1832546f8f.15.1724334855462; 
 Thu, 22 Aug 2024 06:54:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ff5acsm1744656f8f.69.2024.08.22.06.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 06:54:14 -0700 (PDT)
Message-ID: <6850ee92-e4ce-42eb-b816-d86574abbae3@linaro.org>
Date: Thu, 22 Aug 2024 15:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1?] system/vl.c: Print machine name, not "(null)",
 for unknown machine types
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
References: <20240822122310.561885-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240822122310.561885-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/8/24 14:23, Peter Maydell wrote:
> In commit 412d294ffdc we tried to improve the error message printed when
> the machine type is unknown, but we used the wrong variable, resulting in:
> 
> $ ./build/x86/qemu-system-aarch64 -M bang
> qemu-system-aarch64: unsupported machine type: "(null)"
> Use -machine help to list supported machines
> 
> Use the right variable, so we produce more helpful output:
> 
> $ ./build/x86/qemu-system-aarch64 -M bang
> qemu-system-aarch64: unsupported machine type: "bang"
> Use -machine help to list supported machines
> 
> Note that we must move the qdict_del() to below the error_setg(),
> because machine_type points into the value of that qdict entry,
> and deleting it will make the pointer invalid.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 412d294ffdc ("vl.c: select_machine(): add selected machine type to error message")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tagged as for-9.1 because this is a sort-of regression since 9.0
> (in 9.0 we didn't try to print the machine type name at all in
> this error). But it's also very close to release and this is only
> cosmetics in an error message. The cc-stable is for the case where
> we don't put it into 9.1 and then backport it to the 9.1 stable
> branch after release.
> 
>   system/vl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Oops, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


