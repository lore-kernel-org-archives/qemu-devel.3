Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7268CC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpU9n-0001us-6b; Tue, 04 Mar 2025 10:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpU9k-0001ui-FG
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:26:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpU9g-0006xV-81
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:26:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390e3b3d432so3927260f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741101957; x=1741706757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrdFaMb1bsrPRcXQA3q2himvvObzSSzihFqhleSodQM=;
 b=M1UKK7injwqU+5/4UFUWhoTFsox1KcYyc3bt+nUKCrA+CfxLyfflth7wJDcuc7kPkr
 ROeq8svmqqogD8AvV5491DAEeJGUygzWC5Y0BOcgN1gL+YMQ1cR5ojhidMP8vt/E8A4C
 ruNWA6T54NCijt+Lsugmhpa8m7qi+dmrPSOdpnF/bHCafocWDvMTgsWxAUSjCdhJjtEX
 a+qsgZFhh7ci1B4YBkSiU2pDE9acCReqXnpdfYbinlL9R2zzbMa+QjTGzcKzDtYG4fMF
 j4MwFjakAOMFhrBYPkEcdRAlmo6JxuuvZKaemwKKLueI0K4y7HaUj3QNeH6JYscrVS5W
 z9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741101957; x=1741706757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrdFaMb1bsrPRcXQA3q2himvvObzSSzihFqhleSodQM=;
 b=E7CkWHWLTjOuqfaST2SyPio6hVDXlXN9t8rkqWZUQTmSfOux0ldvLYI+qdw+zrk8+v
 DoIG/iJC7j2glfdox25+AI3KZlrQXJEwXNQ4ORflwIOFWMf3N8KjWqE1qPE6NySQVtIL
 9e5f7IU4sPvXBOTjQBiINf7kPwMrdCpCMUQ1o8p+7TaRWqqtbVUPUAygJAHDGrAjGmTJ
 S4vcIdJTmH/DHoCD5DB93S3GffKIhI1wDh2kAM0Cfe9unyg6CF+H1u2OUf2RReNZesUX
 W2mrT5RGJAekbqqb1AxoUe7TgSnea5j4DGfbnH4Wabll5AtpTQojCGNH943h0nsst21E
 D6Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7/7lTDXg4vnb2MGlWmMJkNMYYbdWoIq4lZXzmpMV0rrSEDnIK+y/eM5wYRNZHztt+V5CvEvjR3f/O@nongnu.org
X-Gm-Message-State: AOJu0Ywq42Hb9Pp6uFpgjUvyNlzJsJwAuz6et91LkqvJkVV1HLlHNIv5
 0PAH9HAUf9nkDlxKHcG+pzoDAyi6WfhQ0Ty5cmYdGdaYaYtIvihTYecyb1Crpps=
X-Gm-Gg: ASbGncu5iUK538x8KKoSfm9RKPk6skaJHVmjpZBjLYSdZpi1w6laHSHPiPhXShu5eYE
 ULuLTMuPFN1mdUEyamPUi72XRQuBkIP0AtlmVRSnuBJ6Oev7CJqriCNpBfozttj76bMFbH+Erjx
 tJqc4a9v9T9KKgrWkbAB8D9l1FRGcEDrnmed2LA2MvMcqtzbWLDMa/qfETL3GiAkUn4Bqxrkgx4
 L4gQtRkaGUGLw3iSW1T+NOHAP5uQx7lOw69ILo6BqpoKMbJ2bUwR754YF6lmQFgozjq74K4VJ3Z
 bcnruVm6QtBfpLBb/0gnCWB0Y13Zf4bJI96fOAF1fxRzs1OxAZv4IrYockEcDNeQNuhfQ2Co6WR
 TqYbCSA5zRso3
X-Google-Smtp-Source: AGHT+IH0BqrOp8knZJPb/4X4LCwMVQUydUYzr8dNWcKTI8x8mtD1Bp6LiYscr2naWEKrb9kdB/Szeg==
X-Received: by 2002:a05:6000:1563:b0:390:d796:b946 with SMTP id
 ffacd0b85a97d-390eca414efmr16827648f8f.44.1741101957367; 
 Tue, 04 Mar 2025 07:25:57 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e045sm18180034f8f.99.2025.03.04.07.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 07:25:56 -0800 (PST)
Message-ID: <d95ebf5d-c1f6-42c5-8aeb-65764fa87125@linaro.org>
Date: Tue, 4 Mar 2025 16:25:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] target/hexagon: add build config for softmmu
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 ale@rev.ng, anjo@rev.ng
Cc: richard.henderson@linaro.org, quic_mathbern@quicinc.com,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sidneym@quicinc.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-7-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250301172045.1295412-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Brian,

On 1/3/25 18:20, Brian Cain wrote:
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 | 1 +
>   configs/devices/hexagon-softmmu/default.mak | 7 +++++++
>   configs/targets/hexagon-softmmu.mak         | 6 ++++++
>   target/Kconfig                              | 1 +
>   target/hexagon/Kconfig                      | 2 ++
>   target/hexagon/meson.build                  | 9 +++++++++
>   6 files changed, 26 insertions(+)
>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>   create mode 100644 configs/targets/hexagon-softmmu.mak
>   create mode 100644 target/hexagon/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0fb5711184..deeb7878c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -241,6 +241,7 @@ F: linux-user/hexagon/
>   F: tests/tcg/hexagon/
>   F: disas/hexagon.c
>   F: configs/targets/hexagon-linux-user/default.mak
> +F: configs/devices/hexagon-softmmu/default.mak
>   F: docker/dockerfiles/debian-hexagon-cross.docker
>   F: gdb-xml/hexagon*.xml
>   F: docs/system/target-hexagon.rst
> diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/hexagon-softmmu/default.mak
> new file mode 100644
> index 0000000000..08e709aea7
> --- /dev/null
> +++ b/configs/devices/hexagon-softmmu/default.mak
> @@ -0,0 +1,7 @@
> +# Default configuration for hexagon-softmmu
> +
> +# Uncomment the following lines to disable these optional devices:
> +
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_HEX_DSP=y
> +# CONFIG_L2VIC=y
> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
> new file mode 100644
> index 0000000000..8c208bf468
> --- /dev/null
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -0,0 +1,6 @@
> +# Default configuration for hexagon-softmmu
> +
> +TARGET_ARCH=hexagon
> +TARGET_SUPPORTS_MTTCG=y
> +TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml gdb-xml/hexagon-sys.xml
> +TARGET_LONG_BITS=32
> diff --git a/target/Kconfig b/target/Kconfig
> index d0c7b59d9c..37781146b9 100644
> --- a/target/Kconfig
> +++ b/target/Kconfig
> @@ -16,6 +16,7 @@ source sh4/Kconfig
>   source sparc/Kconfig
>   source tricore/Kconfig
>   source xtensa/Kconfig
> +source hexagon/Kconfig
>   
>   config TARGET_BIG_ENDIAN
>       bool
> diff --git a/target/hexagon/Kconfig b/target/hexagon/Kconfig
> new file mode 100644
> index 0000000000..7e556f3506
> --- /dev/null
> +++ b/target/hexagon/Kconfig
> @@ -0,0 +1,2 @@
> +config HEXAGON
> +    bool
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index aa729a3683..d2b56b9e65 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -245,6 +245,7 @@ decodetree_trans_funcs_generated = custom_target(
>       command: [python, files('gen_trans_funcs.py'), semantics_generated, '@OUTPUT@'],
>   )
>   hexagon_ss.add(decodetree_trans_funcs_generated)
> +hexagon_softmmu_ss = ss.source_set()
>   
>   hexagon_ss.add(files(
>       'cpu.c',
> @@ -264,6 +265,13 @@ hexagon_ss.add(files(
>       'mmvec/system_ext_mmvec.c',
>   ))
>   
> +hexagon_softmmu_ss.add(files(
> +    'hex_mmu.c',
> +    'hex_interrupts.c',
> +    'hexswi.c',
> +    'machine.c',
> +))
> +
>   #
>   # Step 4.5
>   # We use flex/bison based idef-parser to generate TCG code for a lot

Expanding diff:

     bison = generator(
         find_program('bison', version: '>=3.0'),
         output: ['@BASENAME@.tab.c', '@BASENAME@.tab.h'],
         arguments: ['@INPUT@', '--defines=@OUTPUT1@', '--output=@OUTPUT0@']
     )

On default macOS I get:

   Program bison found: NO found 2.3 but need: '>=3.0' (/usr/bin/bison)

Fixed by installing via brew and:

   export PATH=/opt/homebrew/opt/bison/bin:$PATH

> @@ -401,3 +409,4 @@ analyze_funcs_generated = custom_target(
>   hexagon_ss.add(analyze_funcs_generated)
>   
>   target_arch += {'hexagon': hexagon_ss}
> +target_system_arch += {'hexagon': hexagon_softmmu_ss}

But then I get:
[1/1980] Generating target/hexagon/idef_parser_input.preprocessed.h.inc 
with a custom command
FAILED: target/hexagon/idef_parser_input.preprocessed.h.inc
target/hexagon/idef-parser/prepare 
target/hexagon/idef_parser_input.h.inc -Itarget/hexagon/idef-parser -o 
target/hexagon/idef_parser_input.preprocessed.h.inc
target/hexagon/idef_parser_input.h.inc:1:10: fatal error: 'macros.h.inc' 
file not found
     1 | #include "macros.h.inc"
       |          ^~~~~~~~~~~~~~
# 1 "target/hexagon/idef_parser_input.h.inc"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 423 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "target/hexagon/idef_parser_input.h.inc" 2


J4_hintjumpr(in RsV) {
     {fHINTJR(RsV);}
}

J2_loop0r(in RsV, riV) {
     { fIMMEXT(riV); fPCALIGN(riV); fWRITE_LOOP_REGS0( fREAD_PC()+riV, 
RsV); fSET_LPCFG(0); }
}
[...]

$ find . -name macros.h.inc
./target/hexagon/idef-parser/macros.h.inc

$ cat target/hexagon/idef-parser/prepare
#!/usr/bin/env bash
...
# Run the preprocessor and drop comments
cpp "$@"

$ which cpp
/usr/bin/cpp

$ cpp --version
Apple clang version 16.0.0 (clang-1600.0.26.6)

Since this works on Linux for user emulation, I suppose this is a
macOS vs Linux issue with default cpp command line arguments...

