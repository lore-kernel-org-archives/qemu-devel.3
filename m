Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACBDC52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 08:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9Nw-0001E0-Eo; Wed, 14 Aug 2024 04:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9Nu-0001Ay-OW
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:29:34 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9Nk-0003tk-VD
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 04:29:34 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a80eab3945eso255588166b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723624161; x=1724228961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLikub/S5it/yNkS3p4Lua3X0XSWS5vsfui2YgVGLHs=;
 b=pfpyA8UZ2Ehu2AAp0wR9USZ04v5hUqdMSgIxtFDIOEq1srFUEyI6scP95lt7C/E5/Q
 nYv6cfjoPYpHd7z55t0olsjR2m8cbWWpySqKBGI8ROZlRINRRtCy0FYTxq3JaUKuII5X
 71TTRDpQPRdU+8m+Z2H8JBxJ0JaAhjykZDo6JLkmdjsUcGar32kp/b01O3kXXu+qxTzT
 4ib0aOJaMRf4p8HJAuJfBiAIwxP0w2iEVjZ2zpe2AFs0B1oeTPExcaUhalO5pKeKPWbf
 VnFzfw28F91rrIWPKzBXpjnWmzOmTUIVEk/G9SENjYtYb6qIQWxB2m2PoTfIDoeTk+1P
 muHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723624161; x=1724228961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pLikub/S5it/yNkS3p4Lua3X0XSWS5vsfui2YgVGLHs=;
 b=FP9q3I2rGgHBnRZ88eJCako41X+oUMZdhBq5yC3jlJHq3OHQGer+XsHvjhAr6sPZ4q
 S/5k0tGhaJXxrHdidC4sQ5iBX0gvEdnqfqBOJxRUQOEl7sWckqqn/YqlBrmv7F0eLru4
 mq6XqBTZ/dW4Rk7f9k/fhnu9lwP9kOQ1QQt89MUqzm3Is8qluWV8Iqu6HDByF2lvsBtE
 E71WVlBb38SecC+SmVltc1NwGp+xbJoMrlUnzWh1lnSj3r0Wp0qvORKjTGWLhjStLq/C
 sGF9Z0/fZOZfY+QD3y+cKFo4+bBmJ9LsupV1pxiRakPh0oWsrmJ26AI+7fQeREAX2fHL
 UIVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVza9QKJH4JDghj3MBWYXcXlGxILjDQMMDGHbD6Ivmd/5fo7k2SXe6L79j4HOyKvVnTvzRGbacWX+oEzQBs0YEysIq1DXg=
X-Gm-Message-State: AOJu0YzldVemzXD1jSyh4FXwORn6puhBBWCNepGiu9sxrqSefFwRU0Pi
 bn1pBIFAjapPtJOjGh6LAhTrFaqLrupj1w0bIY/ZfORnpfsDL9uHAfO4anmdwtw=
X-Google-Smtp-Source: AGHT+IGV1oNc8DiVrgtanEUXhh4oVOC5PGoYr7xIhYv82H3zWBsfv7B9ux9RTz4prrnu2K/Acac3jQ==
X-Received: by 2002:a17:907:7e9b:b0:a7d:2f42:db54 with SMTP id
 a640c23a62f3a-a8367086687mr143154266b.65.1723624161308; 
 Wed, 14 Aug 2024 01:29:21 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-161.dsl.sta.abo.bbox.fr.
 [176.184.32.161]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411aef3sm145561266b.106.2024.08.14.01.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 01:29:20 -0700 (PDT)
Message-ID: <3d03ecff-ab9b-422f-8b4b-6b3b1a20e810@linaro.org>
Date: Wed, 14 Aug 2024 10:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/21] buildsys: Fix building without plugins on Darwin
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Weiwei Li
 <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Helge Konetzka <hk@zapateado.de>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-9-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813202329.1237572-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 13/8/24 22:23, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Since commit 0082475e26 the plugin symbol list is unconditionally
> added to the linker flags, leading to a build failure:
> 
>    Undefined symbols for architecture arm64:
>      "_qemu_plugin_entry_code", referenced from:
>          <initial-undefines>
>    ...
>    ld: symbol(s) not found for architecture arm64
>    clang: error: linker command failed with exit code 1 (use -v to see invocation)
>    ninja: build stopped: subcommand failed.
> 
> Fix by restricting the whole meson file to the --enable-plugins
> configure argument.
> 
> Fixes: 0082475e26 ("meson: merge plugin_ldflags into emulator_link_args")

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2476

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20240813112457.92560-1-philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/meson.build | 50 +++++++++++++++++++++++----------------------
>   1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 18a0303bff..1cc039d29b 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -1,3 +1,7 @@
> +if not get_option('plugins')
> +  subdir_done()
> +endif
> +
>   # Modules need more symbols than just those in plugins/qemu-plugins.symbols
>   if not enable_modules
>     if host_os == 'darwin'
> @@ -12,29 +16,27 @@ if not enable_modules
>     endif
>   endif
>   
> -if get_option('plugins')
> -  if host_os == 'windows'
> -    dlltool = find_program('dlltool', required: true)
> +if host_os == 'windows'
> +  dlltool = find_program('dlltool', required: true)
>   
> -    # Generate a .lib file for plugins to link against.
> -    # First, create a .def file listing all the symbols a plugin should expect to have
> -    # available in qemu
> -    win32_plugin_def = configure_file(
> -      input: files('qemu-plugins.symbols'),
> -      output: 'qemu_plugin_api.def',
> -      capture: true,
> -      command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> -    # then use dlltool to assemble a delaylib.
> -    win32_qemu_plugin_api_lib = configure_file(
> -      input: win32_plugin_def,
> -      output: 'libqemu_plugin_api.a',
> -      command: [dlltool, '--input-def', '@INPUT@',
> -                '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
> -    )
> -  endif
> -  specific_ss.add(files(
> -    'loader.c',
> -    'core.c',
> -    'api.c',
> -  ))
> +  # Generate a .lib file for plugins to link against.
> +  # First, create a .def file listing all the symbols a plugin should expect to have
> +  # available in qemu
> +  win32_plugin_def = configure_file(
> +    input: files('qemu-plugins.symbols'),
> +    output: 'qemu_plugin_api.def',
> +    capture: true,
> +    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> +  # then use dlltool to assemble a delaylib.
> +  win32_qemu_plugin_api_lib = configure_file(
> +    input: win32_plugin_def,
> +    output: 'libqemu_plugin_api.a',
> +    command: [dlltool, '--input-def', '@INPUT@',
> +              '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
> +  )
>   endif
> +specific_ss.add(files(
> +  'loader.c',
> +  'core.c',
> +  'api.c',
> +))


