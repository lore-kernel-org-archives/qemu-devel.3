Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1F2C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 13:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc475-00080R-F3; Mon, 19 Feb 2024 08:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc472-00080C-QN
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc46v-0004gG-Ft
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708350906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KOmKu+Rzp/lTJ/ZVZrnXclE2BJLwrNZDXnxjwtEc9xI=;
 b=HwwAo0t/Vmd7XyCm0F2w9ja/fo5jZFs6yZ+wukKBvGFx2ztHcHh/pWoPFOxvBbPw1nkAWU
 UvkU3/KkewgSmulZksSrZBefPETQWNJXJWI5E/RX+mEk2sVqIfDsMfzwEzr9NfquTYXPD0
 UGnY4wsCnX2KQ6mrt37Ehmo5he45swg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-qMg4keTVMPGYCQZY2hxYng-1; Mon, 19 Feb 2024 08:55:04 -0500
X-MC-Unique: qMg4keTVMPGYCQZY2hxYng-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6082ad43ca1so17518007b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 05:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708350904; x=1708955704;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KOmKu+Rzp/lTJ/ZVZrnXclE2BJLwrNZDXnxjwtEc9xI=;
 b=nPmzQLj+wBZSaoUhZ2d57BpXnXCuSiErlAHfWRoc4Cb31XVEkkTkCkzJrtfXWQSva8
 tlYU4qK7xoigkdhAAH6EDZQp55TAaTSvQGkkkgixrViowuQfLAorKlzGGzACBQqm+Kqs
 cZJImFkd4t8sPeq2VqkA2gryScQgvkW+nPSPZXrAJjB0k5r2aVewFQcOhc+bQJ1pkdu4
 gv6Ho2lpHM2dU9mmV0RKJN548DtLRGT9SWrvE7xndUgcYtzag7oRBMZi3f+6d+FoTrGC
 3lCub6B9xDdCkJPllfNpJgPfg4PYzbFFqtwxtKN4O5sZOn9kHcCSk3CFdXMALhreOvbn
 VTFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzihGidU09ZNiXKBG+Ru4q1cvMVhmCpWwRd9vWS6TBu0OsKu1KoowyYIcYe4vajOQlG0YkEWlmElaqs3AmGWNJmEG6398=
X-Gm-Message-State: AOJu0YwjhPABXpIEgyflzE0RQvB2Hn+ecEVaHxdTgfdYFiKbo8yeJdUx
 wJ0LTjrALusd9lVyiXZVSgkBz1hGONjzvKzqE9oXiDJ6rTzPSVw6uuZP7IpcW1m9ZAJaGZnvKIS
 6gg+RLvjTiG5Nr5BPe79HuY8ukMZ7KLFSf01LethRNF+7y3dZp4/y
X-Received: by 2002:a0d:cb89:0:b0:607:c93f:2c2a with SMTP id
 n131-20020a0dcb89000000b00607c93f2c2amr12158215ywd.46.1708350904224; 
 Mon, 19 Feb 2024 05:55:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkC6aVf187EA1M5JCRfL+PLyp/XJwSQl9NknL8vlhmP6s5/rxMW3HiGI7Uw2h3/YW72UIZGg==
X-Received: by 2002:a0d:cb89:0:b0:607:c93f:2c2a with SMTP id
 n131-20020a0dcb89000000b00607c93f2c2amr12158197ywd.46.1708350903924; 
 Mon, 19 Feb 2024 05:55:03 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 f20-20020ac840d4000000b0042e14c58ee1sm700128qtm.26.2024.02.19.05.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 05:55:03 -0800 (PST)
Message-ID: <fb09a916-a17d-4d2a-a04d-8c44f73fc1f7@redhat.com>
Date: Mon, 19 Feb 2024 14:54:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tests/qtest: Reorganize common code in ivshmem-test
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
 <20240216144456.34992-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240216144456.34992-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 16/02/2024 15.44, Philippe Mathieu-Daudé wrote:
> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
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
> Message-ID: <20231127052024.435743-3-gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
...
> diff --git a/tests/qtest/ivshmem-utils.c b/tests/qtest/ivshmem-utils.c
> new file mode 100644
> index 0000000000..b9578ab554
> --- /dev/null
> +++ b/tests/qtest/ivshmem-utils.c
> @@ -0,0 +1,155 @@
...
> +gchar *mktempsocket(void)
> +{
> +    gchar *server_socket_path;
> +
> +    server_socket_path = g_strdup_printf("/tmp/ivshmem_socket_qtest-%u-%u",

Can we please avoid hard-coding "/tmp" in new code? Please use 
g_get_tmp_dir() instead.

> +                                         getpid(), g_test_rand_int());
> +    return server_socket_path;
> +}

  Thomas



