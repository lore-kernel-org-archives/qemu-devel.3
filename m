Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62717C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 18:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX3ph-0004br-85; Mon, 05 Feb 2024 13:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rX3pf-0004bZ-QA
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:36:39 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rX3pd-0002S3-VZ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:36:39 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-51032e62171so7547909e87.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707158195; x=1707762995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y0CamCJHuYdaiJG0th0yVmC02W9WZBXCOTVtIM67PW8=;
 b=zS05+F5r9fwb4f4a9IyLANstXJAEwzN3MRlIBY4XyLuLyhv6/cSvH/0Rns+3M2cV6Z
 GNVKHKKWAg9Z8OoNtiWkk84ttXEvn1kAuUbP4sOb3B7l2Tv0eOxsCi7oBowxrfkb7wG4
 QmKMcUySkxN7oz5pAigM0NYeo6X2z7yJxFifdJVSB6MoGndQYEeyTq/FkI9kBx8AlaZ4
 Hg2wIxfBch+DotPIJke1IexUHzpvsuRHUa8C6N7LfgmfKpPwwflnrLU3LzDZANOTzohK
 lUCF8O7286AsRSPvxc4dEWfIuaitLxf77Vg3QgipOrnPE9RjZUvZb4t2hfV3MTC3Mpfl
 PAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707158195; x=1707762995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0CamCJHuYdaiJG0th0yVmC02W9WZBXCOTVtIM67PW8=;
 b=hVWuRSjSB1n67P/DAtQv4j4d+pxY0Nneg79KdPRyJQRcGzXSJS7QsA0A1vhi8xABMy
 hdlyrpTaizee2ZNEGMTt+VyvQbPVZH9ntjdd4iK/34pRwiPpVcWN0byBb+iGi9rENAIR
 mcQ58IX42BSeAh/l+QvbBXdhreZLdIjGoa5OrFfEuPbQlWRaxD3/gWZun/jjOGORGYmB
 zT1HJznejQFmNElJtpTzdxIpQrQRHdW3H2NxdbAsh3xr4KeM5fxzsV3mr6gz7/EMxJNe
 PXpXMFMCSiRyhO5DFQWQY9aOqQUJ7/IDjuh9ZNQTfCn5eHdlEWqHa5RrPie5pgDCv7y6
 qcwg==
X-Gm-Message-State: AOJu0Yz9p5OR0vwKe2CYcxRAumi3uuP9nGnJtrpTrM2yCYnmSmyYi56L
 o1z9LdR2nANUIgMf5ovrKKyILfFlg6H+kez2bpqaVl6Zcp9CYEJVCGK2jqD3bKM=
X-Google-Smtp-Source: AGHT+IHj+Nn4yVJuEWkuyp0B+NCqmZ6vKvqcW3NYhRfIgpHIazSNufRmf7WvfIQGkHy0U/HhnzHKOA==
X-Received: by 2002:a05:6512:a90:b0:511:448d:c962 with SMTP id
 m16-20020a0565120a9000b00511448dc962mr370538lfu.33.1707158195604; 
 Mon, 05 Feb 2024 10:36:35 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWv0JnlVA++zjdm/YLhTbX0WsZTKx+u8BfmAJDWSKUPyZYQoeNxXkY47EnU/ZV1Z45MKcvji9sCjX2vPs6C/8mM9QYqN4p54P4RL92uuOso7IMP95gLtirWmJmXBbghOgbyQT1DP5/0ulzqs5aU4dkv8pmI1C9Pr+fUkss5HFfH6S4S9XiwBlCuC9JitKBI0lZe56Hl0tNgSiyQSNHhM0jpI2AwRRZlBJDK0xddMhRgEYibZf4ZVvEiu70fYYOfKCU2qPXmRydHoKAL0u45EkSIqhinj3KyZPA1OQEYzdyUN1SumG4EWmhLgra8b+iOZIjR9w29oLPecpHM67ZUYw8kSTX8QMKmiRsybbI=
Received: from [192.168.69.100] ([176.176.171.36])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a1709063fc400b00a34c07816e3sm124064ejj.73.2024.02.05.10.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 10:36:34 -0800 (PST)
Message-ID: <b6ab054b-47b4-49e5-ada7-6a407d54207b@linaro.org>
Date: Mon, 5 Feb 2024 19:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] meson: Link with libinotify on FreeBSD
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
References: <20240205181352.1567-1-iii@linux.ibm.com>
 <20240205181352.1567-5-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240205181352.1567-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

Hi Ilya,

On 5/2/24 19:11, Ilya Leoshkevich wrote:
> make vm-build-freebsd fails with:
> 
>      ld: error: undefined symbol: inotify_init1
>      >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
>      >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a
> 
> On FreeBSD inotify functions are defined in libinotify.so. Add it to
> the dependencies.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   meson.build      | 12 +++++++++++-
>   util/meson.build |  6 +++++-
>   2 files changed, 16 insertions(+), 2 deletions(-)

(for some reason your git-diff context is very verbose,
  making review somehow annoying).

> +# libinotify-kqueue
> +inotify = not_found
> +if host_os == 'freebsd'
> +  inotify = cc.find_library('inotify')
> +endif
> +
>   #################
>   # config-host.h #
>   #################
>   


> @@ -2376,61 +2382,62 @@ have_asan_fiber = false
>   if get_option('sanitizers') and \
>      not cc.has_function('__sanitizer_start_switch_fiber',
>                            args: '-fsanitize=address',
>                            prefix: '#include <sanitizer/asan_interface.h>')
>     warning('Missing ASAN due to missing fiber annotation interface')
>     warning('Without code annotation, the report may be inferior.')
>   else
>     have_asan_fiber = true
>   endif
>   config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
>   
>   # has_header_symbol


>   config_host_data.set('CONFIG_INOTIFY',
>                        cc.has_header_symbol('sys/inotify.h', 'inotify_init'))
>   config_host_data.set('CONFIG_INOTIFY1',
> -                     cc.has_header_symbol('sys/inotify.h', 'inotify_init1'))
> +                     cc.has_header_symbol('sys/inotify.h', 'inotify_init1') and
> +                     (host_os != 'freebsd' or inotify.found()))

Maybe we could use the same pattern as 'have_asan_fiber':

  have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 
'inotify_init1')
  if have_inotify_init1 and host_os == 'freebsd'
    have_inotify_init1 = cc.find_library('inotify')
  endif
  config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)

I wonder why we don't need the similar library check for the
inotify_init symbol.

Regards,

Phil.

