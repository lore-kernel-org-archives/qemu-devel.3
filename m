Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D92FCF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl31-00037w-H6; Fri, 04 Oct 2024 12:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl2y-00037X-Fu
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:20:52 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl2w-0004D5-OW
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:20:52 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2facaa16826so22263871fa.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058848; x=1728663648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zW55LOJ76NeoOT9W0YOfNGpNOQ9kwtN3+Sb2BN2bq28=;
 b=wfxKeYkPQy0cv1I1AvmOHjoQhI9Trl02tvV1z2V3vbPPbe8kuooe1Szeaa7NinoSz+
 kdTvI/XsRwSu0GiG2qkcpTEQXgGtNyRlHUZxArsY2jIyvYWTEbTHqdmvtCrv5VClxwEy
 ig5HVfzZytcKyRmYPFZxPsr104y0wDZPKJjR/R4r4Weg/QGxiWJjKVFeCr2/KdQ+j/3s
 25yUyBYBXajoAMJ5sCSPGDnB3X7lsxnzHeKpCz8Q0N37rdDXuTmTNfYXPrf6pXCAim4u
 iJM4+8gLGlSr9O/NkTzVQV9/6Y6W5I8yELXWGmVYBdaTNqy08W9nVWBGi/0rzJXIyHOZ
 3Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058848; x=1728663648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zW55LOJ76NeoOT9W0YOfNGpNOQ9kwtN3+Sb2BN2bq28=;
 b=QPeyp1vNLZVsFQsODsXlJbszNvCbuWwhWgNfNiqmdcvPeqXhkxk9ii45B0SF7sYCcj
 2R8z3I79v4qsVFZ2L3OYCiAfZ2ga9FbAMKjGRoaTlTgN/ofHb7UfsCq35FEC3HomFfAL
 pxdBe5WsoKh3beAPX6yYa+Ql+w8nKhFMnRvy+0HOpyW646Siw7o/o2ajAivu5Nc9a/h1
 Ezfinmex7HqkCpqTJ04qX2K0IvbMxhRIBqKtZaC7l+qhDrkmMZrDwbKOqvYsAEW2B9fG
 /qBUVN6+yCKHzZ3sx64dmP1d6t33BOyJDX7u6A97yMzwEf90ac6NKlaXFYzK4EoiN6Ma
 eOsQ==
X-Gm-Message-State: AOJu0Yw/l0JMeR9IDxST9pjD4I0mmV1MLrIKT13xnCX4mWUspv8N7lAS
 Aw4vUhfpCXjNFJg4y/Fha+QLxu9x3VG9Zdp4o/Lx12yxAWCiIgAIaX2NuVJ8YDZzudersa3lye+
 iW066vg==
X-Google-Smtp-Source: AGHT+IHeItffcZ7BrcsJcJh9s+eJfbY9xuAKcsYyHc2nZaW5V0+OuvCZYNOkK5swEPRF4FOKCyH6pw==
X-Received: by 2002:a2e:bc1a:0:b0:2fa:d25e:39e4 with SMTP id
 38308e7fff4ca-2faf3d8fec9mr19732861fa.36.1728058848210; 
 Fri, 04 Oct 2024 09:20:48 -0700 (PDT)
Received: from [192.168.39.175] ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b3b332sm147951fa.134.2024.10.04.09.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 09:20:46 -0700 (PDT)
Message-ID: <29ad8192-d60f-4ce8-a5f5-d39c864767fd@linaro.org>
Date: Fri, 4 Oct 2024 10:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] hw/i386: Use explicit little-endian LD/ST API
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Eric Farman <farman@linux.ibm.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
 <20241003234211.53644-5-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241003234211.53644-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/10/24 01:41, Philippe Mathieu-Daudé wrote:
> The x86 architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/multiboot.c  | 36 ++++++++++++++++++------------------
>   hw/i386/x86-common.c | 26 +++++++++++++-------------
>   2 files changed, 31 insertions(+), 31 deletions(-)


> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 992ea1f25e9..daa6a5d500c 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -586,7 +586,7 @@ static bool load_elfboot(const char *kernel_filename,
>       uint64_t elf_low, elf_high;
>       int kernel_size;
>   
> -    if (ldl_p(header) != 0x464c457f) {
> +    if (ldl_le_p(header) != 0x464c457f) {
>           return false; /* no elfboot */
>       }
>   
> @@ -669,8 +669,8 @@ void x86_load_linux(X86MachineState *x86ms,
>        * kernel protocol version.
>        * Please see https://www.kernel.org/doc/Documentation/x86/boot.txt
>        */
> -    if (ldl_p(header + 0x202) == 0x53726448) /* Magic signature "HdrS" */ {
> -        protocol = lduw_p(header + 0x206);
> +    if (ldl_le_p(header + 0x202) == 0x53726448) /* Magic signature "HdrS" */ {
> +        protocol = lduw_be_p(header + 0x206);

Oops.

>       } else {
>           /*
>            * This could be a multiboot kernel. If it is, let's stop treating it
> @@ -762,7 +762,7 @@ void x86_load_linux(X86MachineState *x86ms,
>   
>       /* highest address for loading the initrd */
>       if (protocol >= 0x20c &&
> -        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
> +        lduw_be_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>           /*
>            * Linux has supported initrd up to 4 GB for a very long time (2007,
>            * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),


