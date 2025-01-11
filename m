Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96369E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 15:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWdiU-00065p-Aw; Sat, 11 Jan 2025 10:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWdiT-00065d-5F
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:48:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWdiR-0006cY-DR
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:48:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43626213fffso25139605e9.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 07:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736610478; x=1737215278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXnEMdaJmB3wmmJxgorT/L3VHkT9x6PzpoX3V0r81nU=;
 b=eO5Tj7iatta5fialXiKC/IOnzdpiY1yAUtre/vlqmCL6KHLXDd9geHjma7SXltWZUc
 4f6A5WTGeoRKplZ6dRRYOrSks7jYQR2qZnaYjt4tcHR0L54UOXPEQE/xJLyig3az9icw
 Nja5NBfrfi/TYFxsCqhcLIsSqdXUycKkVbb2Vqd7dIfZptZ64am719X8y3SmWbdXAZ4D
 EQqst+8VfJhYxSNyF3pFfe2/0zDk1IWFrYX2NRgiDeyGbP5EWccWgFnTf8bQGZS8UXdx
 GPQ6teq6vbrNYj+917RP0Nz29L5H0uOLaOdp2hOqORLztWXOZXThb0rVIqNOHMfMXhFJ
 9tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736610478; x=1737215278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXnEMdaJmB3wmmJxgorT/L3VHkT9x6PzpoX3V0r81nU=;
 b=v6HQLiLZ31iiK0LfSW2u8I5ExMzzJ816Dh4WGsN08iz1Xn/j10/6Zs6bQ0tBoULDOq
 286XOmxF+FMyvKc+yjT8qQ05B4gWEGYKVQkYT0MtLAatd+T1cLA4Kwc6Fg0XJaCbeeSv
 6xyu1BiG0RA1y7Uvh7QNkC6kUDMHh0Aqj/M2FWOFz80+aqJYj+VCLLnbpeEyAEv0F+qX
 ZXuvLwceOQMrta1IpU09yka7l+bg5d7tGNv4VuQYlY/eten9vDboIwIdCjb+ficgcPPs
 iD3StCTCrQh32rdf1SutVBf1tBeJpYwG5V2Pb1mDyLQ9awgLcxNRKTk2p7Gfg5gxg4oM
 YOeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdoDcS5pFroP7TmWoXV0gy0DgB/44AebD5cIISvnJWZtu587n4kpka4PxbhETNce5JRFLL87dEtKPs@nongnu.org
X-Gm-Message-State: AOJu0YzuniPhU5yXoGQ2UDukZzWcCqH7ll6Korq3EXHQaoHoh93hz5nM
 PCQbhmr/2m9xrwyhf3h0lruG+Nb5NiZHnyWyPHTWP9oXSGMU0XAMprMXbh6i++A=
X-Gm-Gg: ASbGncuBZTy7msEsh+BXT4Yl00Mf8lhND1DRzbIyPU6i4FzcTJeTB97snk/Sq5SlEJG
 1997LpHGOIDZuG6F01xV1n8Z9bzvCr6VQlykkkzmst6tCb0xqpjxaRPorogsQdgxdhLLu4DHlIG
 K9weHY9mivm2vxxuyOE9uQ/kOtA1PP2PkmIBWmvJIWq9LTqyfbL3d+vN2TqeYWQFZ1DrYdbi6wS
 TYWBeMxAfASrhWUV1zVXHn3W1A/opQyP3xdISVGD/BUZy9KovU6kTxpsFFsynssotnA0rPabHxd
 760krC7kLB9J62QtQw+/lBV0
X-Google-Smtp-Source: AGHT+IGqG9PjbDiN/sUC8Uoo28b3oa62gRC02x9PEhjrBgt7SGiSrZRyaotEa/wiRLOI08dsrw5Nhg==
X-Received: by 2002:a5d:6c6c:0:b0:386:4244:15c7 with SMTP id
 ffacd0b85a97d-38a8b0faaadmr10482632f8f.25.1736610477864; 
 Sat, 11 Jan 2025 07:47:57 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2df3610sm119858985e9.20.2025.01.11.07.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jan 2025 07:47:57 -0800 (PST)
Message-ID: <bc22d713-201e-414c-838e-6c0dc1fb3807@linaro.org>
Date: Sat, 11 Jan 2025 16:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <73fd2f38-76a0-4274-875a-6f96faed79f6@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <73fd2f38-76a0-4274-875a-6f96faed79f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/1/25 21:37, Pierrick Bouvier wrote:
> On 1/10/25 12:33, Pierrick Bouvier wrote:
>> For now, it was only possible to build plugins using GCC on Windows. 
>> However,
>> windows-aarch64 only supports Clang.
>> This biggest roadblock was to get rid of gcc_struct attribute, which 
>> is not
>> supported by Clang. After investigation, we proved it was safe to drop 
>> it.
>>
>> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and 
>> aarch64
>> hosts.
>>
>> v1 contained warning fixes and various bits that have been upstreamed 
>> already.
>> The only bits left in this series are the gcc_struct removal, and 
>> fixing the
>> plugins build with clang.
>>
>> This series is for 10.0, as we decided to not include the gcc_struct 
>> removal is
>> 9.2 release.
>>
>> All patches are now reviewed, so this series can be pulled. I'll 
>> report that to
>> MSYS2 too, so we can enable clang environments for QEMU.
>>
>> v1: https://patchew.org/QEMU/20241031040426.772604-1- 
>> pierrick.bouvier@linaro.org/
>>
>> v2:
>> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
>> - add a section about bitfields in documentation
>>
>> v3:
>> - explain why gcc_struct attribute matters in packed structs in commit 
>> message
>> - reword the bitfields documentation with suggestions given
>>
>> v4:
>> - edit for bitfields doc requested by Philippe
>>
>> Pierrick Bouvier (3):
>>    win32: remove usage of attribute gcc_struct
>>    docs/devel/style: add a section about bitfield, and disallow them for
>>      packed structures
>>    plugins: enable linking with clang/lld
>>
>>   docs/devel/style.rst                      | 20 +++++++++++++++++++
>>   meson.build                               |  6 +++---
>>   include/qemu/compiler.h                   |  7 +------
>>   scripts/cocci-macro-file.h                |  6 +-----
>>   subprojects/libvhost-user/libvhost-user.h |  6 +-----
>>   contrib/plugins/meson.build               |  2 +-
>>   plugins/meson.build                       | 24 +++++++++++++++++++----
>>   tests/tcg/plugins/meson.build             |  3 +--
>>   8 files changed, 48 insertions(+), 26 deletions(-)
>>
> 
> It would be nice if a maintainer could pull this, so we can get this 
> merged upstream.

That'd be Thomas or Alex I suppose.

