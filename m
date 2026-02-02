Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DFBE7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2n7-0004xj-8i; Mon, 02 Feb 2026 17:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2n4-0004xQ-3Z
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:53:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2n2-0003J7-LC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:53:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so3729976f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770072782; x=1770677582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmacRWtkKGaTtmeQcqqSjgi1/YleSFDIM/yHliWY6Fo=;
 b=xVtCYszfS8VZuJl8IVj29pG/4JN8X4JIUlu/5iV40sUyHzNZ6DUk1zCTsHe5r5lvNS
 mlBsS1iynsEEHRj5+Ja1ga742tKKHE0zt0s3DJXkeCdsS1jSwVV9RVZzAQOGvhUwIDSA
 UyookGapeijknniH2UCrAlGYksfnLYQVrsdK22O5n3LVMJWCrk3AkMqvMZngQ17Yqj7J
 bVEVRQK/A1DgSZCfp7Tde4sblEwXXssmsaNUKlTX2GLNZavogBrX8OxceZUvDuIE1/N6
 BQVcajTmcEuBM4IcSej+Y3s+R8V7I/OxE9fV0N7rzdHEvUqDc2ylp1lgyqNfDDw0hRE1
 R1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770072782; x=1770677582;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tmacRWtkKGaTtmeQcqqSjgi1/YleSFDIM/yHliWY6Fo=;
 b=BeP0r2Bj9jYG7bNsbxF8HeJSlrRGBv67OS0bwlHlnC7dudIoKUKBGGlMEaokLRkbZU
 6n0bOD7RIs81fgi3Uo9Jsh5ypbmHr0yONmgtfmA3Jv6JaQv+vUZNM0AlgFYANuCR6u3Y
 jJr26NrhCTn3gaRu9/qhVDSliw+QR5oR9z8uxg/UR90JgV4tjnv7MIJwSVcFP/UyH8pQ
 mNnWczIigYKutJ4SQ95vAONfFTzC/9GZiRa7xTBhRA1POLSWevQWPoJg1KtSPZ8j5MUk
 KLeVawIoAGzoyKQ5mvXAbWrsdZJZJFOvu1YGgnpYCjuzFAflfHTBVeycLYsX3rpaiHql
 +HGw==
X-Gm-Message-State: AOJu0Yxk23mQoV0c6rkhxclyNS/PCELL9PC1SCHU9w/0GwSLXFvk9eP8
 IZFzXDahudlX36ArqrkOdTQQamAYXJwafXOQTV7W4FxQHp1YPLyVkLXM+bEU2TwPpTbEkJhPWDY
 ivicRg4Y=
X-Gm-Gg: AZuq6aJ92pj2DyQ+dexRtshz5FqJhU45B8RSw8zGRsRQsI06WgJeqox+lq07ZoWGkY/
 6PiYsqeKD/GIa0PKZuz9m2wZvpcAlHhgkf5K3mizOQWyOhKKnQY70iLp5s6UPIIMfqleJ5Ho2cD
 GbBNlGS6ItXWd1io8ikWeVi25+YP2Pj7ae61a1LnYimGGnK9Xi/3D/qCYI28Ey+JML6bFAxtsmX
 p5Vl81BFa/lxZmxsYOUu4eXOhgSssvG2uW32iOP/yEJ9PKe3bf1OOdORwFrzBoFqe6jKAm9C9pZ
 V/R+vf7KVezE8bQBeP/oOFth7/7xru50RITs5iTb/Gl5MNlV4VG1KOkg2Isou7xaDN5yVXb3qKk
 oYxDbDpSee5lnZParI0zRI8aGz2QT4kzbFGlqkg3h0KyBdGP7w348C8aAn6Kk0INSgLYrGrs/Fl
 hus/8YRjXoFrdx9csRlPyiVQ+K0enMls/Yscrnb17bC7uSSHzZC2luAA==
X-Received: by 2002:a05:6000:2dc7:b0:432:dc23:368 with SMTP id
 ffacd0b85a97d-435f3aac762mr18421708f8f.49.1770072782529; 
 Mon, 02 Feb 2026 14:53:02 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm45353858f8f.3.2026.02.02.14.53.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 14:53:02 -0800 (PST)
Message-ID: <9d6496bf-c7a4-441a-a1af-18ddf88635a7@linaro.org>
Date: Mon, 2 Feb 2026 23:53:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 43/61] target/openrisc: Build system units in common source
 set
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
References: <20260112224857.42068-1-philmd@linaro.org>
 <20260112224857.42068-44-philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260112224857.42068-44-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 12/1/26 23:48, Philippe Mathieu-Daudé wrote:
> Since previous 2 commits and range 2795bc52af4..5b67dbf1dc3 we
> remove all uses of the target_ulong type in target/rx/. Use the

Oops, in in target/openrisc/ ;)

> meson target_common_system_arch[] source set to prevent further
> uses of target-specific types.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260107200702.54582-7-philmd@linaro.org>
> ---
>   target/openrisc/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/meson.build b/target/openrisc/meson.build
> index 31608b6dc7f..d51ea1ab753 100644
> --- a/target/openrisc/meson.build
> +++ b/target/openrisc/meson.build
> @@ -22,4 +22,4 @@ openrisc_system_ss.add(files(
>   ))
>   
>   target_arch += {'openrisc': openrisc_ss}
> -target_system_arch += {'openrisc': openrisc_system_ss}
> +target_common_system_arch += {'openrisc': openrisc_system_ss}


