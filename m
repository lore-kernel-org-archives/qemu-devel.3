Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB99C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoHc-0000nA-F3; Wed, 07 Feb 2024 15:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoHa-0000g3-3K
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:12:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoHW-0005ot-9W
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:12:31 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fe03cd1caso10091415e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707336748; x=1707941548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uz7apUMENsvpWFZMa+ZlXUpHokO0Hq0jpvo4zH28ScM=;
 b=h7CoJpOFCVTj8UTYSnLFe3seVihAOK473DXmm77OTswJeOBGf1gfsdJIdVGWa0wb45
 Y+fSQzknbthLak62LkEHEv73+HX0LeE727PeR/g4orHGKoXYULo5SsFISe4YRb4o08bB
 hK+XpLDHxm9pzYxB7a0qCwcrAgBOoMP7QwTBNYn0ijDG8niB8Iw5MkY5Vy2x+Vyew4Rz
 npMYLM5zUudmqyngr7D2ZVHWU/8t99tI6NVKdDd+FdXXMmnxahljiayCQi8G+ozYzmQr
 i5RCvtfhCYTyBD+5QHUb6zndO/d2r3jVX14M2V1xJniDI6hfXt+3PtgrpUeT8WjNUGsu
 yEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707336748; x=1707941548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uz7apUMENsvpWFZMa+ZlXUpHokO0Hq0jpvo4zH28ScM=;
 b=DttNrFSHIOEsP7Ygo2KAAQKsp06LvoYBoFnK7tN7JbeoDkTLEXOoeDQOqYoJMXuyjF
 ET2LuoCT2ECH2zOxUIpCq+xgGaDHwiTXzODyymLq9TxmabZECqh6efRY2p8OinJO6MJE
 WKsvY0hmcTvqTpfXcPuUfHM3KlBX1IEA1iRjDOLvEKeO6Z6+cSwbIobUpHvlS5x65sm7
 b95mjygrLDXporaHzR3s4pcdl5FNvvfqaQ/HKNnMNXvPWyjhTHuq8vLZv84oZA727cVE
 Y5tz0OALMM9aSFHJ/kRWJP7UpXkBqun56rsi29SRYstuQFd/OEp4qqNHNAPNjoPTzO+x
 7E/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtw82a+EHnWXsABuAJYybXQTBdPp2jAZYO6EOnoz4polVcMbd45Us5qWmdbpLXC+TQ2PS4U+qkEQ07er7hcijzh4HfBkY=
X-Gm-Message-State: AOJu0Yz5Wh60R95XTTNj0ta+ZHMa/IJyXZbNlsoCad3OTu13NUpRU6pz
 hhkWjXqcvQx9zEf09u/SYQeyooWRzduVpbdM5dmk+KqXd2xhtXxm6sYtOxPrWfw=
X-Google-Smtp-Source: AGHT+IEuma79ubahG+OB2Vuk/S3CljRmGVlWU6ix4hDB+hc++8M2m9tZFhlRvLkmJkArkDtqhNd6kg==
X-Received: by 2002:a05:600c:4f41:b0:40f:bd81:e738 with SMTP id
 m1-20020a05600c4f4100b0040fbd81e738mr5392243wmq.29.1707336748594; 
 Wed, 07 Feb 2024 12:12:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVm0JNPcLxjw4QFapKsijKN6nZg4fdLJY+OIyLvMVdjR2fzaETCFY5JqzdEJTcnogSygoqxtjIrmef+HQQPEORRwkssODIB2lXhvUi8/83N0VyFUPBF3qbFbebUqinphsO/vnmBpGlcGfz5MblG9BwyHG8=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 l37-20020a05600c1d2500b0040ee8765901sm3083435wms.43.2024.02.07.12.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:12:28 -0800 (PST)
Message-ID: <79662c36-506b-44cd-8245-6a9ecbf60a18@linaro.org>
Date: Wed, 7 Feb 2024 21:12:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] migration: Add Error** argument to .load_setup()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-3-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207133347.1115903-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/2/24 14:33, Cédric Le Goater wrote:
> This will be useful to report errors at a higher level, mostly in VFIO
> today.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/migration/register.h |  2 +-
>   hw/vfio/migration.c          |  2 +-
>   migration/ram.c              |  2 +-
>   migration/savevm.c           | 10 ++++++----
>   4 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 831600a00eae4efd0464b60925d65de4d9dbcff8..e6bc226c98b27c1fb0f9e2b56d8aff491aa14d65 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -72,7 +72,7 @@ typedef struct SaveVMHandlers {
>       void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
>                                   uint64_t *can_postcopy);
>       LoadStateHandler *load_state;
> -    int (*load_setup)(QEMUFile *f, void *opaque);
> +    int (*load_setup)(QEMUFile *f, void *opaque, Error **errp);

Please document this prototype. Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


