Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE5AC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv9Z-0006Ns-0l; Tue, 13 Feb 2024 10:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv9X-0006N4-4A
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:56:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZv9V-0006z0-Bg
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:56:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-410ed9f8621so15334125e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707839815; x=1708444615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wg1u4oQEQo0c5GRHn3wONODuz+v0GcV405uV7jCTG2s=;
 b=GG2zy2Ni8BEMAe1sWA49q8FRYm0M6Y+h+3kHneqZIzpjKRtDj42DHjYcISLGM+59+x
 J8XNxGdB+J+H18gaZ7JZPb5WQLIQSwV0YZG0doXz7K4x85kZqHUx+vQMbuAxd4CM5NWK
 GGEBigm+8vjrImWaaY4QogBspyOmB5OnJ9UvyqOdLCAGpkhYrFMVNU6R82sTnuyOeOa6
 0dyFMyA9JqMns8pQJPGJs1TkJl2Ety+euOqkd7AGvnnOs18J628j5ORKemnys183N+Mc
 q9c2RnDd5/IFWaS9bidmWfpIz8Qbxkmg/+AKX/iONSgu/D83ypGOBCa5LnMun0xH9jFd
 1YQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839815; x=1708444615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wg1u4oQEQo0c5GRHn3wONODuz+v0GcV405uV7jCTG2s=;
 b=N06G36YBmPfVPb4xHY/XTiuU+54LSumMz9fqB66GaELulKqWlaaJSCqQUyaY9M5KHE
 SS9VeIfArXdcNGs+mc1nqcPr1Ih/ukJ23KZGRVVrBqFOHrPBmQlXiOU1qnAQJN+zhpw3
 UVeWrEn4mLSzK9nrk4tD1fPb+9r3cArslXtMPP7CMqoTGG5dFDhVS83TIvZiWU9U6Qh6
 wOfnj05WE+L9HDw3F0IAwwwV+7O46efJ5IXCOaG/s5nSWK5Pe8SlVd6gsMA5s1XAN8iw
 CUlF++QTq7u9N1zQrZHJkM2M2RROVWVRMHJ31dMXUqWhRk7e4nFjnq28sN8Zn1e99iWF
 zaKA==
X-Gm-Message-State: AOJu0YxZjdpkT3Y8susMUOZjzo3ch5p21+3WWjzWfv7ejgc9aUIA5i0z
 1oBogrtBNR9WXM+9JVmogRzMqI1OSb80KToogWU23Y3GuA1sAD0EJLB/5H+WhtYNYrtGjWgSsgc
 W
X-Google-Smtp-Source: AGHT+IGl/kmhL2TIr2ohlKtwdUizgyos+tVay/Q7P+GcFkFf2X9V/aNno2e0Ey/fYsgxNA8HZrnSEw==
X-Received: by 2002:a05:600c:4e50:b0:410:48dd:c397 with SMTP id
 e16-20020a05600c4e5000b0041048ddc397mr34578wmq.40.1707839815459; 
 Tue, 13 Feb 2024 07:56:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVN19mr77VppPCFcgbvgH0KzkHapGBDOEuOj8jG40PLfINw0Ghuvj5rD/DPyVebbjCIXshcCn9y9c9iaSwFe1+OruPIRR6jIUTWS1t9UqlOUGrHUobkS/aojm9eVrhT9ZfOmaQOiqE8RXv4oNyLOyjWC8InXV/o/QbGDk6d2cRwYrpbJrKVZneBzU68XWaTtuJhilaJiw==
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 dd18-20020a0560001e9200b0033b3d28ef1fsm9835141wrb.65.2024.02.13.07.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 07:56:54 -0800 (PST)
Message-ID: <4f7d9677-ea56-42a3-baee-5cf017f5d212@linaro.org>
Date: Tue, 13 Feb 2024 16:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/qtest: Reorganize common code in ivshmem-test
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: thuth@redhat.com
References: <20231127052024.435743-1-gustavo.romero@linaro.org>
 <20231127052024.435743-3-gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231127052024.435743-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 27/11/23 06:20, Gustavo Romero wrote:
> This commit reorganizes the ivshmem-test qtest by moving common structs,
> functions, and code that can be utilized by other ivshmem qtests into
> two new files: ivshmem-utils.h and ivshmem-utils.c.
> 
> Enum Reg, struct ServerThread, and mktempshm() have been relocated to
> these new files. Two new functions have been introduced to handle the
> ivshmem server start/stop: test_ivshmem_server_{start,stop}.
> 
> To accommodate the new way for starting/stopping the ivshmem server,
> struct ServerThread now includes two new members: 'server', previously
> present but not a member of any struct; and 'status', a new member of a
> new type, ServerStartStatus, used to track and handle service
> termination properly.
> 
> Additionally, a new function, mktempsocket(), has been added to help
> create a unix socket filename, similar to what mktempshm() does for the
> creation of a shm file.
> 
> Finally, the ivshmem-test qtest has been adapted to use the new ivhsmem
> utils. Adjustments in that sense have also been made to meson.build;
> also 'rt' have been removed as a lib dependency for ivhsmem-test.c.
> 
> Two lines unrelated to these changes have had their line indentation
> also fixed in meson.build.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/qtest/ivshmem-test.c  | 113 ++------------------------
>   tests/qtest/ivshmem-utils.c | 155 ++++++++++++++++++++++++++++++++++++
>   tests/qtest/ivshmem-utils.h |  56 +++++++++++++
>   tests/qtest/meson.build     |   6 +-
>   4 files changed, 221 insertions(+), 109 deletions(-)
>   create mode 100644 tests/qtest/ivshmem-utils.c
>   create mode 100644 tests/qtest/ivshmem-utils.h

LGTM!

