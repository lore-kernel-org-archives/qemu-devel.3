Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AB3EB2714
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpuca-0001C9-7v; Tue, 10 Feb 2026 15:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpucH-00019w-T4
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:45:50 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpucG-0005kj-3g
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:45:49 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aadc18f230so19257605ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770756346; x=1771361146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LpWfv89cTEW2lDnFmRmsb6tYCtaFP6mlcRJtptspNtU=;
 b=PwAYDhWCvMyXjNUYo8utkUSv8ev3YamItMyAXcuVH42VLbFk3IpkOb1mRn1B3ukghN
 pbOJH8qVUZOkSyOHQEI5RPvupKm/MK9nBCbmcXW+UHyU7yWumS1jbwA5KGpxfVQHchvh
 X0JXOmidjbXVL3qRjT8OxHNqIfyp+Tezshq8pNCaDXYHJoLJ55mEnmtwrLOdtnIzmSi9
 7U2TjzkMPsQlfAoto4f24umluCkYV2g2oPIdE7JWie2uVnLmqpcSAn4rUhfd9nezDiR7
 UpHIgNn0JVRNai/hfwWK0RZol4IGXJjgJ49vmp7mP4mki84Ir2ERjekvaOAdvXJ2wJEL
 O76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770756346; x=1771361146;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LpWfv89cTEW2lDnFmRmsb6tYCtaFP6mlcRJtptspNtU=;
 b=CpXIREXo2Db3geHAIM+PeHS4Kcz4EwVQKEZheSlbx7Tk3sWEE5ZT5/baBBznXSr6+p
 oc+N01bEqFoAINJRajhh5rMmQ8WWprszY1fFgo18L0y5V77K6nXtJJ72/HD5dIXdaGMh
 sultZ3g86Kt9zeKuKSdviMYmSU84IEDCV5Rgn1s5wGesO/77DZ1C2/78nrT55LBRnN3A
 sCaZ0rSbH/QiIVl+hlK+cfvOJdyuzaZB/smj8ncfxiIEJqoW4CcISY9uFI+Qpa1CBwu4
 YWyBbI8tjoZ9CpWxH+BBuXakfdyIJjbw+dX8oGIIx79vJvrD4mL9QsVqJB5Xj7hTR5HA
 8HRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcH5hWveMsnSnPnxu7Yj9BlGdn91erEm4rdn+qVN2gnlU5ROLXh2m/GENyFwASF251jLmGV7lBsh5W@nongnu.org
X-Gm-Message-State: AOJu0YyFXke8wMO6Do+yg6rSCuqb7F6D4CcUW4Y7DOi7/QptEZPVfVHd
 Ucu713auwQM92A/ZJhJzv05uHx8GJ8S5zaJt/talByjg9J0/lrK45qMyazdv8W3BBtE=
X-Gm-Gg: AZuq6aJ0AQ+mAgd8d/fjwv7jpkXZL8WEWqXZaPSZC6mIU0WLFvrx4LixWQlgIHHm7eM
 bPCnC1ODpwznO1n25aAbUeNp4j2opLJ3iRec5/LwhH4uCP/A+HqkDixEWbZN5IGBcpNR0vewvVr
 QwxQhFMeF5rZqp3b6aJV2O7rQiQa293Oy+G3PI4ca4V0BwJxU2vXN0W3IJO5yVdnNypJFUr/TAv
 zVYxYHhD6L14wvv9yGbbH4/ymgkpZh3Nln+XmkDUYATKgGDI9xZCKdCIVB55zDqZ7yU4LJPOCG+
 CG0Y7ke/IXn35hYxXrpV9Uubvp7P77/aujClcUzwE0e5PU9vAZYVBwMntdImhv6Xfaz2V2Twa/d
 Dius82Sc+EQ1WS9AmZNOcs1lRGToi3QjCtUzTxL5qWRmIhhmTYP3RQvjTPHWz3fovZqUOcw0IOt
 6upLHHFXkjHP3Ehk8b+hkAZiV3YKXnFeiFU/blYlYAEyIkMIzzH4pveFDaifhQZAfurYnS
X-Received: by 2002:a17:902:e74b:b0:2aa:e114:2f5b with SMTP id
 d9443c01a7336-2ab279103c6mr4664275ad.17.1770756346485; 
 Tue, 10 Feb 2026 12:45:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9521b9f53sm183015715ad.57.2026.02.10.12.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 12:45:46 -0800 (PST)
Message-ID: <461df3a1-b3ae-4be3-aae4-598bfa56575f@linaro.org>
Date: Tue, 10 Feb 2026 12:45:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: fix cross-build using LLVM for Windows
 targets
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
References: <20260210040722.11375-1-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260210040722.11375-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/9/26 8:07 PM, Mohamed Mediouni wrote:
> llvm-dlltool assumes that it's by default targeting the host architecture
> it's running on. That assumption doesn't hold true when cross-compiling.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   plugins/meson.build | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 34643e2cea..9899f166ee 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -41,9 +41,16 @@ if host_os == 'windows'
>     # to find missing symbols in current program.
>     win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
>     if meson.get_compiler('c').get_id() == 'clang'
> +    if host_machine.cpu() == 'x86_64'
> +      dlltool_target = 'i386:x86-64'
> +    elif host_machine.cpu() == 'aarch64'
> +      dlltool_target = 'arm64'
> +    else
> +      error('Unknown machine')
> +    endif
>       # With LLVM/lld, delaylib is specified at link time (-delayload)
>       dlltool = find_program('llvm-dlltool', required: true)
> -    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
> +    dlltool_cmd = [dlltool, '-m', dlltool_target,'-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
>       win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
>     else
>       # With gcc/ld, delay lib is built with a specific delay parameter.

This is a good candidate for qemu-stable.

Thanks,
Pierrick

