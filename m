Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5574D2FEDF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 21:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkqSY-0002ky-4K; Tue, 27 Jan 2026 16:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkqSL-0002hQ-RE
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 16:18:38 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkqSH-00022w-R1
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 16:18:37 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so5324463a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769548710; x=1770153510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GjlaZFr4xdFpGWFEyEiPzXcXtlPknWQHPkErncN7Alw=;
 b=S3ZTa0O1stbef42GViFrmz1PEZ7AbvKKgsWOnrc3bdkLN9ko9emqKSfg4EU5zADwL0
 6KX8OUb5q8KDjuyBGCYWppqVA5Wf5pB+bAUteU4SIGO/ikiaJH2M1QdYo60bbDWjNU0a
 ns2McWWki0dv9Jmrsr079Gr0IM5dRyIpfXio9TQu4yR5LK2BSSLOVWZuLz0P5DR4i3zk
 iw2+Pa0iG3qTNKk7QQ2LeOS+EAxFXfVz1Of3ILMEf6MHJy4EYwT2DrkbnUBzHoIVKjj3
 rkilll5YMRdcnpUNYsGwdoa4Lunvt5NDwn2tgtMbtBYwp3IiCDJL69MemHmhQ6+jTbrG
 /Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769548710; x=1770153510;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GjlaZFr4xdFpGWFEyEiPzXcXtlPknWQHPkErncN7Alw=;
 b=iBehzlUEMXlfVtHKB+guy87mS40AXwpK69+XGeBVGOUAxsdqSF4EBdfb0Fp9MBT4uU
 2S6GB7WW05LopRdTB4AsDr3aS3Co/c/jUp8ebUlmoHWJt88Qppq8XhUmpmQyByH9rwqw
 AP2Qtu4WuJB9Um0FvLi5OBIyM3+ahR/IcTqbnnPbhfKGhRUG0qN9yHPHioqZdGFglmGh
 vpzHnJ/FfTZnD+JgO//wbJ/hqWNFK9ddWr5cQ6kbEZ8HrkoDelomEK2j7zVb9uNVUoJS
 HQ9hizYFLfplyt/F/JDK4wldrjVJtIMxFT84K7mrLpzlEdnjEcT58TUYUNY/6nidswGM
 rpYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1YylkXXJr6GpHY0dqmgAFiFQ7sQVodkFc7sBeEBXvFmfxgq/pvCmYIUJmZjPcWq2LEjEZ8Ne2Ggns@nongnu.org
X-Gm-Message-State: AOJu0Yxj0k6S+m1EVECshYXy1T34/MfiO9gDSIBP8BETbL96flbXIAPh
 d2MUT2asZe7StNh3l+oHVAFfyY4rL1aszqeS8gw7g6EHW8TdSL6BymQqsBlwf/SvAuA=
X-Gm-Gg: AZuq6aLaetRfb0StJG5/as2TpNzmZgexRGHEMSBfDSe7swfwtSlMiKxeCZpM9159Zxk
 druXxTnk4O9z+y+HoolMbw9f42KkHTOHzlfmCfUl/sCpx8tGwuB0rP6ddIA8kw6b0xlGsIFHvJL
 5qKPokAvyS5OMefXN15QVTYy9CSshRlyEfDFARr+h3tjiZX8GfwilmSpCi0NdKXupQbsw+w8f1+
 7jonzVNY0VzcsVZAeJfW8FeXGW/hEoEhEPwZ4vpBTWB9GcLzyJoh+38F27lTspnk7s9polM1aqz
 viIj46OqiilkOnXcO6oxSE3mMS0YhhVOFdD+4Z5QxBC9CNTEFOxDwL8qqBpAVaN4yb0y/opI+a4
 CSYeKWeN0gaQa5YUb6qEhYOIhGnYM7Vn0+dhsvbiaUg2vQAoI+VwvNYvWIW/nMyOJ61hIoVIW3v
 3naDkBQVW1kPskK/j1GgzWFbm+Odi9vZ/OM++m+RtndDGliELFFrF4B2L4
X-Received: by 2002:a17:90b:5485:b0:34c:a35d:de19 with SMTP id
 98e67ed59e1d1-353fedb1534mr2767858a91.33.1769548709644; 
 Tue, 27 Jan 2026 13:18:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3540f2cb419sm338415a91.1.2026.01.27.13.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 13:18:29 -0800 (PST)
Message-ID: <b137fa07-7079-4200-b08b-9de18fa50dc8@linaro.org>
Date: Tue, 27 Jan 2026 13:18:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/33] scripts: Add a script to run the wasm-compiled
 QEMU on node.js
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
 <2af460d17a47ec69d691dfb876f834e4685f9d6d.1769407033.git.ktokunaga.mail@gmail.com>
 <6dce5ad6-e88b-433c-8eef-98dbe72acbbd@linaro.org>
 <CAEDrbUZhz8hLQJ=Cvpj9MAy0f+bLqOk8wonHHLMaYEKEQAAFYA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAEDrbUZhz8hLQJ=Cvpj9MAy0f+bLqOk8wonHHLMaYEKEQAAFYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/26/26 6:36 PM, Kohei Tokunaga wrote:
> Hi Pierrick,
> 
>  > I followed the instructions but could not get this running:
>  >
>  > $ /usr/share/emscripten/tools/file_packager.py qemu-system-aarch64.data
>  > --preload pack/ > load.js
>  > $ ~/node-v24.13.0-linux-x64/bin/node ./scripts/run-emscripten.mjs
>  > --preload ./load.js ./qemu-system-aarch64.js -- -nographic -m 512M -L 
> pack
>  > file:///home/user/.work/qemu/scripts/run-emscripten.mjs:51
>  > if (preloadModule) preloadModule.default(Module);
>  >                                          ^
>  > TypeError: preloadModule.default is not a function
>  >      at file:///home/user/.work/qemu/scripts/run-emscripten.mjs:51:41
>  > Node.js v24.13.0
> 
> Thank you for trying the script.
> 
> That script requires the --export-es6 flag to file_packager.py. This flag
> was introduced in Emscripten 4.0.13 so please update the Emscripten tools if
> it is not available. If you're using emsdk, it provides the way to intall
> newer tools, such as "emsdk update" and "emsdk install 4.0.23" [1].
> 
> [1] https://emscripten.org/docs/tools_reference/emsdk.html#how-to-guides 
> <https://emscripten.org/docs/tools_reference/emsdk.html#how-to-guides>
> 
> Regards,
> Kohei Tokunaga
> 

Thanks, this was missing indeed.

