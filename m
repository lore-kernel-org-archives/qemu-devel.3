Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8343EE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZWt-0008N3-08; Thu, 12 Feb 2026 11:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqZWr-0008Ml-Q4
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:26:57 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqZWq-0007Zg-A1
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:26:57 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so2451175ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770913614; x=1771518414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=60oIabqW2E0633q7tT64MAUWtuRGVW1IbMR/gWDJ6ys=;
 b=jYAaNzigBNU45GJaCpQ42nfyTy+TUg8KiW/Vdk3bUZNUoUfFTIsEbcZQwfsq2+hkYt
 KcJ9PzlhGfgqHmZmOYEUnyCGWQvqxzhFOL7VEijn9cuButkNlWehsPhLRFD7i8FGfsFA
 yrcDQZb0B+nGASzYvug6TjFGcEdlWXPyY+HZtn6kWWs8RH8LahmQAzth41AMKuaYGcmq
 HMezvd9P97lB5rjFAvoiz2PB7Okc6YiWdngyvJ7x4uO5R8phkx8OugSWVKkyImoSapBj
 uMHNtNMtDbGL5TpreXE+8TcIgwTWib1xE2gcqe/oMNln47uG0JRrYpOhFD91Yubmq4I+
 1vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913614; x=1771518414;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60oIabqW2E0633q7tT64MAUWtuRGVW1IbMR/gWDJ6ys=;
 b=ZAeQY4LqnXSwEUg8djIH5IYQudi9o9bVUBcwr++Yu+54XQuVa+Ik9WkGA6D0O5eLd2
 z7L5HXkscOu+Wbl12gOZJuGnWAqaeP4Hck/Z0z73ag25WVycmIfHhiIaQoc6qbMAeGQq
 UnTIHrmucPNdAxYnbgFMqXf9D01uIblsefCXsYv0p8FT/mXzPU+lXL5Ib6tjQhxciLeY
 +868GjyLO1Gm/29o4Px4RlTOCjFoQ1UcZccH+hKF7iG9xULME5CdNguEWJSzw1i0P2Vl
 vkc3u9AkxQaBbyTz1/Jpero1S4OCOPvvzhZEXlPQojkEJIylXNmoVf8aA8PU71pl9CIY
 41aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+cnuXI5TN4DbgSOu6siHLV5CGHLORSWkKtdm/ZO4AeFR/wbdzbDmqB2NpwGhcEgnU3ufTSkJg2mAT@nongnu.org
X-Gm-Message-State: AOJu0YyVQwW3w4PbA8Ahj5VF9QTMV+CTuweWXkPiiMufMO+FpDCYNAef
 Q/BtKXGsmIeoqerY5Yr4WeqxedfyR3Pm3hLbhTEC8V8EVXMpAtCrN8/YZZwRRF5j1+4=
X-Gm-Gg: AZuq6aIsnmAikdtK63Zejutc7fG1VDW+wjmIjcgsZknayW8twfmp5hdNfwB9N7RBKng
 uYrqNsLrqDuu8vJXbqEfYxsGH3P3VzJoZM/qKMFxsqEUfvCICxvmS6VHx85zQgeB2kwg8DKsqMM
 TaUF0Z6bZeK09IVBwVICz3SeX9Nn+RMizbtqWlkT9x3TBbRCF12+tfDQ2eYCx9j7a9LMeCVlMqm
 8S2mj9kxErr/xBpcH5vudrdifFsJ2ACdD1dNNj08UOmaQQjPVt9HGAz/XQD2Q0AE6CvuVUAeYjz
 fJyecp5cKrh5m2cPhicVEXTsGmV/dvX6o5q/PUCYIRewEvvQNVJKeYjStyE2W741xOpttyAgCFb
 U/6v3XxhkD6EUyxBQrgTNrR49+ArwT2efKt3DTyVLejmFsKYAPG95LaakYHt/FQC7HHJZ19iwBO
 ssyaTPKFYeConBXYh+H1O+/5EDUBxyDiU6eGO/7O6SR7+lVfCr6YYrpaeUrdxcD7cZ6Zkm3mHYx
 vuvqRA=
X-Received: by 2002:a17:903:8c3:b0:2a7:90f2:2ded with SMTP id
 d9443c01a7336-2ab3aa8ed80mr34772995ad.16.1770913614331; 
 Thu, 12 Feb 2026 08:26:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab29979b13sm53843185ad.61.2026.02.12.08.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 08:26:54 -0800 (PST)
Message-ID: <0cf3e5a2-73d2-44a8-b4d0-cdaef67294be@linaro.org>
Date: Thu, 12 Feb 2026 08:26:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] plugins: fix cross-build using LLVM for Windows
 targets
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260210040722.11375-1-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260210040722.11375-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


This was merged into master (c848bce26151c21d785bcd60acff6e746852060d).
Thank you for your contribution!

Regards,
Pierrick

