Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13576C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4NI-0003G9-ER; Thu, 20 Feb 2025 06:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tl4ND-0003Cd-OS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:05:44 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tl4NB-0002hn-7r
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:05:43 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M9Frd-1telEv0JeR-006usl; Thu, 20 Feb 2025 12:05:34 +0100
Message-ID: <14906c81-a057-4de4-a34b-a5ea6fb5803b@vivier.eu>
Date: Thu, 20 Feb 2025 12:05:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] binfmt: Normalize host CPU architecture
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 David Abdurachmanov <davidlt@rivosinc.com>
References: <20250127182924.103510-1-abologna@redhat.com>
 <20250127182924.103510-3-abologna@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20250127182924.103510-3-abologna@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qmQRK4OhQ70VJ20z/SGV4a+umVAYMeyWJbvRsr4RKbQy4PVeBGh
 j0REPBKi8n8QOFrcExjbXJ+1NqG6bB/phF5f0Gb6nfNUTB9KRYEGIbhQCP/pGgMuuprUjpC
 Ns1lrculrFznoD5j+Ts3dVCybg1HG8LmlkYGpYDEvoVKdWHGJ6oO3gcTGuGQkArF/AMe1IG
 c+GW6Y9hdweUzsenW40XA==
UI-OutboundReport: notjunk:1;M01:P0:Y39oyGafjLw=;rJJpa7oFUrPgVno6p9uzM+bUD0Z
 6myvoI0VvKyVgk/StYxjMmwsBKxVdazIbyl41HtirEvvRGyW96WhSk9hIGtvv3Tzd7joW8oh2
 IMzh0CrnGXVnCEmPFMCX6htVV+ooeku6TwgnrDYiGylQQDjj4zw2YPVMm06ghuosxgCbgfugk
 uSGOIWjxFuzWBFzSIump2hnsNvRYpVAJCpngVFXfTDE1vulXn9DYJU6rQH7uSgVvNQ39DWeFJ
 u1YJ8wF4SazasqpLYDzcC0T+nQJd8q/NEXzGtJLDZRfdGrNSl2AwzxDAsIIW+xtYBtsCN0jYY
 wvkrnyD1CXzekgRPrs5K0jWSgBtQlfkN2TnugtCJSEJoqahRHD8Mx4JQQZ8vNSRymSwM0zH5y
 swlodOiet1KgBpAwIrBD+hCIjIv19rYpRNuGwZwJShFyQ/f2Seyccuwkax4r59g8gjs2LPwYk
 9QhBecXLxyQ3283RP4dXBOcCVp653eBPCmj0AMbf87VGzCM6c3MO69PzMQJBbJkx6CjGBPrlN
 VuFLjq3IEmVTksf8gb2GWV5CWYbZejeYj+IrCLi7xEiPvg6zYbX55NG3ykcv81hWcTZ4oBP/U
 GA8ZQ2tRIqrQ6CqXSfmIRoDTVUSpgJMllW65gJCcA/pPDzOEgwK4by4XyLmUi0izyuVo15Lp3
 9nRmScBRa7+CoLsBKZ6jBMWdj7E9FitHXBkuVtIjTWz/L/qLdhjG5cuNvAqhm+wFdoKBmZ27a
 w5HFQHtsRSA8b8ccew+wci1uSl1uUSgqEEOSxido0KOnF8sBiSB38nzsw9uvEcujcHsqjhTQU
 ho01M4Alo7Y4iADiZ5b/AOR3Ywy5gYHXhuD3Ouy2jptPGyOAlFNoqBTsem5R+HEiL38MgYyED
 +Pnn8JQXJ8Md+63SYJM61cH/fDfQgUKgZhpISNxGmJc/l5ooj63cHqOalalxGQs/SEqYZpNF/
 p5XzHlXzI5HLxj41JBiFW7vsr0oZh9SMYCWYRWS5E30mL78QoJqprWIC1rNfw6gweQdkFrKfS
 dtrS1Oi6geIH2+M21tUzamqyX0Kz+gfDuw3+HktKLyyEPPTPxsFsdHiOLgDt25zVqPH2xU4Ix
 3BIUguwb1VF5Ji/7Ys13X+Rv/7+bIPW7KWMH4YenL3CJRhgIFg1w8CZkE6CeVvELVrJ/aHOSx
 lUh0RWLrmfkpXLNQZ+yUB6Lg9q6uoH4wn5OriVf2KF+eAt+f4IlKg4iWbwZVz+QqHTDBout9h
 QjoDF85fkeEUhZ/wuVZQF0BhCnmkxxgUN4EbkgnX/zmblzwm3je5XCT2RgmOaCJalkfVp26bF
 akRtk50jqXxTr6GoSbkSO2W00/kMWkCoL4EUC2+aIQsjUmkmxr5Q+zpQKVpZnb8WnVV
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 27/01/2025 à 19:29, Andrea Bolognani a écrit :
> Right now information regarding the family each CPU type belongs
> to is recorded in two places: the large data table at the top of
> the script, and the qemu_host_family() function.
> 
> We can make things better by mapping host CPU architecture to
> QEMU target in the few cases where the two don't already match
> and then using the data table to look up the family, same as
> we're already doing for the guest CPU architecture.
> 
> Being able to reason in terms of QEMU target regardless of
> whether we're looking at the host or guest CPU architecture will
> come in handy to implement upcoming changes.
> 
> A couple of entries are dropped in the process: BePC and Power
> Macintosh. I'm quite certain neither of those have ever been
> reported as CPU architectures by Linux. I believe many more of
> the entries that are carried forward could be dropped as well,
> but I don't have the same level of confidence there so I
> decided to play it safe just in case.
> 
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>   scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++----------------
>   1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 426f075e31..8d9136a29f 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -144,35 +144,35 @@ loongarch64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x
>   loongarch64_mask='\xff\xff\xff\xff\xff\xff\xff\xfc\x00\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
>   loongarch64_family=loongarch
>   
> -qemu_get_family() {
> -    cpu=${HOST_ARCH:-$(uname -m)}
> +# Converts the name of a host CPU architecture to the corresponding QEMU
> +# target.
> +#
> +# FIXME: This can probably be simplified a lot by dropping most entries.
> +#        Remember that the script is only used on Linux, so we only need to
> +#        handle the strings Linux uses to report the host CPU architecture.
> +qemu_normalize() {
> +    cpu="$1"
>       case "$cpu" in
> -    amd64|i386|i486|i586|i686|i86pc|BePC|x86_64)
> +    i[3-6]86)
>           echo "i386"
>           ;;
> -    mips*)
> -        echo "mips"
> +    amd64)
> +        echo "x86_64"
>           ;;
> -    "Power Macintosh"|ppc64|powerpc|ppc)

I don't know why we have "Power Macintosh" as a valid value for "uname -m".
I think it's a good idea to remove it.
It's here from the beginning
08785f48b73c ("updated so that PPC/ARM/SPARC executables are automatically launched when invoked")
Perhaps it's a value coming from the OpenFirmware or MkLinux.

> +    powerpc)
>           echo "ppc"
>           ;;
> -    ppc64el|ppc64le)
> -        echo "ppcle"
> +    ppc64el)
> +        echo "ppc64le"
>           ;;
> -    arm|armel|armhf|arm64|armv[4-9]*l|aarch64)
> +    armel|armhf|armv[4-9]*l)
>           echo "arm"
>           ;;
> -    armeb|armv[4-9]*b|aarch64_be)
> +    armv[4-9]*b)
>           echo "armeb"
>           ;;
> -    sparc*)
> -        echo "sparc"
> -        ;;
> -    riscv*)
> -        echo "riscv"
> -        ;;
> -    loongarch*)
> -        echo "loongarch"
> +    arm64)
> +        echo "aarch64"
>           ;;
>       *)
>           echo "$cpu"
> @@ -309,7 +309,13 @@ EOF
>   
>   qemu_set_binfmts() {
>       # probe cpu type
> -    host_family=$(qemu_get_family)
> +    host_cpu=$(qemu_normalize ${HOST_ARCH:-$(uname -m)})
> +    host_family=$(eval echo \$${host_cpu}_family)
> +
> +    if [ "$host_family" = "" ] ; then
> +        echo "INTERNAL ERROR: unknown host cpu $host_cpu" 1>&2
> +        exit 1
> +    fi
>   
>       # register the interpreter for each cpu except for the native one
>   

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

