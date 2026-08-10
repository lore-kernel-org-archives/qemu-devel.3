Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E15C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXzk-0001aq-St; Mon, 10 Aug 2026 17:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXzj-0001aa-Ar
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:57:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXzh-0001xD-EI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:57:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALXb9A2522623
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 O6iI8x4PoNwrijOMLADuF+yU9Utb2MmXBGnonkdemR8=; b=I+KNeihGHE5/XTpF
 HjgG6MmCm7a0YAwRopENyS5ydJmVa9YIVQ+3TvpIUCqXNnYHHBO8KBbEPUaZ6kIM
 fhO5hABaJATDDwxo/g6ULlRILfx/uk9ncq8FZz9a1P6Bq21k4l475GJbNWR5eDSz
 dapAl4W9xYm21ne0fA0lM5uWzd9AF2wuSXZ7WbV7tmndF37XBNoaSwZJWJneCLXB
 3Q8hwjt+btN/+26mqO1pwOELoLVz2FmlUy4rxvxEce3GRtGSaVWCOAaqEk1eCVMv
 5amG/yTwPhQm98ElWARCHJ2GrFIk1BJCgkQnyv0T4quJ2tGeo1u8Avcz6Il6EMEE
 BlUAoA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjsh8ay-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:57:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso32322171cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786399034; x=1787003834; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O6iI8x4PoNwrijOMLADuF+yU9Utb2MmXBGnonkdemR8=;
 b=aQYI8BJQEUGv+4mAA2miGoC/hRP455EY+i7gwZu+E5mSqK1yJxopQGsHnleGWG+UAV
 d7mGNzMasRoByDhutiiYuQX8mfGQ5dDG6tZ/b/AkDU1NMlv/pMH82x0K66eEjO7XVCQU
 ibyvBxIG7PB4H1Pn0xHFVNuRKh4Ag971WAZamdFXceYwW+ea2M+ghVPkPdFeRHJ2EiGu
 LSJwIBP4RILL5AVLsrRiBjhtVL0/P/KVoGiUk9viXrg/cfp7u//x9gLGZUDLqHXLQ8D0
 balFcZohOECOoUSLWHeQi+22p169lsFJr3BHKCDj3gEc8rpr0mAdLGit+4LTVjB/JVm8
 MGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786399034; x=1787003834;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O6iI8x4PoNwrijOMLADuF+yU9Utb2MmXBGnonkdemR8=;
 b=CeRrD3fN0z2wfA7LrlaGqMtc9c7UVvtaaJ0ngLT/azolPoGG1YuHDWYaPSUmSM7iRJ
 udMyY3gfe+mIqJ43nH+h2sQyQQfg9tMxcsrcbJXxtk+dywa6KlWs63XkT962XdhsIFnb
 Z6tfNUfygommZokvFoej5FdVn3PZjL7qtckoRNi+Ui3wp1tsadvaaREgdsTitLvFu3VY
 uS/yXpLrTEqx7iB44hKvEmxeM1B+7FzSeNX/xj6d9lUfWMAR4JNrdcT+JTRI9gJcs/r4
 0QiMR8vwlF94IOm7gZh3OkmXGE39w3mbRhbsULfZ8PR9cl3GUx3m6kwt6Ez0vSFRfuj5
 kgZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrE67yKzKbOz/Yg7EkDhkMDmAmO8QlWp9/rSidBD4a3GyUangNr1OSuI0Uj5Pjul4iYFWCjIV6NL8Pl@nongnu.org
X-Gm-Message-State: AOJu0YyJverMxc7ZkTagQS88ZOf6k35BUJJpUp19SAaqfUtMYlRxh9p0
 shPpIYxoKkCPhrt7ocRsedJ17nQ5afuCO8LyjiSsW0Umo1ZD/wM4M10GzVbt0LUW2fyh+7uDukA
 PxeR2fMxG+JZUxSwpBZbJkCdvpsDQ+dDK/euVZVQwjLkApUDJvGNt6DYWqQ==
X-Gm-Gg: AR+sD12n6PmOQYj5lzHxmzbHTfiIsirH/fPETeYF5QqTvSkZWS2Q1w9ixur3BzbAk8N
 /qb4FaJ3LtKNAV2weHdMQl03dE99wK8WUVZnFnJ3ASi6GpQQYZKxXFYPHS2gQN4j52bhSndJZO+
 PhMXrttAZee1rhTZIwGbP8VYoRqSBN9DrLTtVX2kMqMtyiJ52EAE/xaPEcgI3RfkcK3SVh7frQN
 k4LGc60MAFEv56uA5Lqdbxu9kiATxSrxOfAOwT744N2CY4wpEPZ1dsG4rKHrRLz9hGAqj4NZnNQ
 NR7lBRGN/irAakhRCc52FSLIETvSOcAsvGA9vqqRnRWWDZeIFAp3OML3z3KN8wlewfSDoxKiL7M
 aHIXPeJLKgvdflvDY8WXV7S3nuiz3cyD9pato3vnm
X-Received: by 2002:a05:622a:1482:b0:51a:8696:cb38 with SMTP id
 d75a77b69052e-52ce5f616femr489509271cf.7.1786399034418; 
 Mon, 10 Aug 2026 14:57:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1482:b0:51a:8696:cb38 with SMTP id
 d75a77b69052e-52ce5f616femr489508911cf.7.1786399034007; 
 Mon, 10 Aug 2026 14:57:14 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8c5asm39797614f8f.18.2026.08.10.14.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 14:57:13 -0700 (PDT)
Message-ID: <a3083a7a-bd51-42f4-add9-2d0e1586abfd@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 23:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 088/103] tests/tcg/tricore: system tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 David Brenken <david.brenken@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>, christoph.seitz@infineon.com
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-89-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728044248.137626-89-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4NiBTYWx0ZWRfX6Q0nAEg99uLS
 s6/OFVKYnDtf8Kqost2JmaO9+N7juA1KhkDszN/4jhBwbx/Z8Mcvg9WiXJw0TxF02MC7vfneWQT
 H0foLI2nn7NWUukK0mUhxvMxuShYKBY=
X-Proofpoint-GUID: uW4CWcgEzJXvH_tfTmWnGZsAbB8gRfNC
X-Proofpoint-ORIG-GUID: uW4CWcgEzJXvH_tfTmWnGZsAbB8gRfNC
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7a493b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=YkNAQLq2q_0T-xClkUkA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4NiBTYWx0ZWRfX/I05zr8xIp99
 WHKMIHjy2rLIiyS7FRO3VoyJ4pdc7GL5dmknBz2SbsQ+IQv1gCZANGxdFDQRwJryHT35ZwEOHXS
 01IEeLDmuobZVHBQ81UjjuTdgwYhTpOl7ruuyOuRqUBnbnbFTVehXFZY5aoss4A8En1zvAWLwxT
 tAY/5pMIAtXO7QgirB0W+gUGw6dy0XxiXYh8z6051HhZDw2Ms7J9nHCe8P9YqkFm4RPAT8FSZ27
 l5ktZXyTOLXiNF6x5IbJJGOO2W+dN0bdv6rBLrm2nxN7fBfb4mrt/grK3c+gNBbj7AjmIWWRLZr
 KwZhS/l10PaIFYH7qxMFtzvbf6MlFZpXpsGmLA4BKbtreWuQuISqf7dU0u440tubFJ2GP1lzzkj
 QhHMXeTHHKG2p/uDlwLHlCjK1fhg9NpHsuXELi5lU8ubU4TK3O61jYPId1MBvC8zg6nB6lCHEga
 ioYvF3PUDJ7WWc9FFIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100186
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Cc'ing Parthiban & TriCore folks

On 28/7/26 06:42, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build                     |  1 +
>   tests/tcg/tricore/Makefile.softmmu-target | 53 ---------------------
>   tests/tcg/tricore/meson.build             | 57 +++++++++++++++++++++++
>   3 files changed, 58 insertions(+), 53 deletions(-)
>   delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
>   create mode 100644 tests/tcg/tricore/meson.build
> 
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 5a132d9021e..992913fa21c 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -154,6 +154,7 @@ subdir('ppc64le')
>   subdir('riscv64')
>   subdir('s390x')
>   subdir('sh4')
> +subdir('tricore')
>   
>   image_targets = {}
>   exe_targets = []
> diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
> deleted file mode 100644
> index 258aeb40ae8..00000000000
> --- a/tests/tcg/tricore/Makefile.softmmu-target
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -TESTS_PATH = $(SRC_PATH)/tests/tcg/tricore
> -ASM_TESTS_PATH = $(TESTS_PATH)/asm
> -C_TESTS_PATH = $(TESTS_PATH)/c
> -
> -LDFLAGS = -T$(TESTS_PATH)/link.ld --mcpu=tc162
> -ASFLAGS = -mtc162
> -CFLAGS = -mtc162 -c -I$(TESTS_PATH)
> -
> -TESTS += test_abs.asm.tst
> -TESTS += test_bmerge.asm.tst
> -TESTS += test_clz.asm.tst
> -TESTS += test_crcn.asm.tst
> -TESTS += test_dextr.asm.tst
> -TESTS += test_dvstep.asm.tst
> -TESTS += test_fadd.asm.tst
> -TESTS += test_fmul.asm.tst
> -TESTS += test_ftohp.asm.tst
> -TESTS += test_ftoi.asm.tst
> -TESTS += test_ftou.asm.tst
> -TESTS += test_hptof.asm.tst
> -TESTS += test_imask.asm.tst
> -TESTS += test_insert.asm.tst
> -TESTS += test_ld_bu.asm.tst
> -TESTS += test_ld_h.asm.tst
> -TESTS += test_madd.asm.tst
> -TESTS += test_msub.asm.tst
> -TESTS += test_muls.asm.tst
> -
> -TESTS += test_boot_to_main.c.tst
> -TESTS += test_context_save_areas.c.tst
> -
> -QEMU_OPTS += -M tricore_testboard -cpu tc37x -nographic -kernel
> -
> -%.pS: $(ASM_TESTS_PATH)/%.S
> -	$(CC) -E -o $@ $<
> -
> -%.o: %.pS
> -	$(AS) $(ASFLAGS) -o $@ $<
> -
> -%.asm.tst: %.o
> -	$(LD) $(LDFLAGS) $< -o $@
> -
> -crt0-tc2x.o: $(C_TESTS_PATH)/crt0-tc2x.S
> -	$(AS) $(ASFLAGS) -o $@ $<
> -
> -%.o: $(C_TESTS_PATH)/%.c
> -	$(CC) $(CFLAGS) -o $@ $<
> -
> -%.c.tst: %.o crt0-tc2x.o
> -	$(LD) $(LDFLAGS) -o $@ $^
> -
> -# We don't currently support the multiarch system tests
> -undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
> new file mode 100644
> index 00000000000..d0bf55dedce
> --- /dev/null
> +++ b/tests/tcg/tricore/meson.build
> @@ -0,0 +1,57 @@
> +tests = []
> +
> +link_script = files('link.ld')[0]
> +crt0 = files('c'/'crt0-tc2x.S')
> +asmflags = ['-Wl,--mcpu=tc162',
> +            '-Wl,-T', link_script,
> +            '-mtc162',
> +            '-nostartfiles']
> +cflags = [asmflags, crt0]
> +qemu_args = ['-display', 'none',
> +             '-M', 'tricore_testboard',
> +             '-cpu', 'tc37x',
> +             '-kernel']
> +
> +# Multi arch tests are not supported
> +# tests += tcg_tests['multiarch-softmmu']['tests']
> +
> +setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
> +setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
> +
> +tests += {
> +  'asm/test_abs.S': setup_asm,
> +  'asm/test_bmerge.S': setup_asm,
> +  'asm/test_clz.S': setup_asm,
> +  'asm/test_crcn.S': setup_asm,
> +  'asm/test_dextr.S': setup_asm,
> +  'asm/test_dvstep.S': setup_asm,
> +  'asm/test_fadd.S': setup_asm,
> +  'asm/test_fmul.S': setup_asm,
> +  'asm/test_ftohp.S': setup_asm,
> +  'asm/test_ftoi.S': setup_asm,
> +  'asm/test_ftou.S': setup_asm,
> +  'asm/test_hptof.S': setup_asm,
> +  'asm/test_imask.S': setup_asm,
> +  'asm/test_insert.S': setup_asm,
> +  'asm/test_ld_bu.S': setup_asm,
> +  'asm/test_ld_h.S': setup_asm,
> +  'asm/test_madd.S': setup_asm,
> +  'asm/test_msub.S': setup_asm,
> +  'asm/test_muls.S': setup_asm,
> +  'c/test_boot_to_main.c': setup_c,
> +  'c/test_context_save_areas.c': setup_c,
> +}
> +
> +if 'qemu-system-tricore' in emulators
> +  tcg_tests += {
> +    'tricore-softmmu': {
> +      'cc': 'tricore-gcc',
> +      'cc_dockerfile': 'debian-tricore-cross',
> +      'cc_docker_host_arch': ['x86_64'],
> +      'folder': 'tricore',
> +      'gdb_arch': 'tricore',
> +      'qemu': emulators['qemu-system-tricore'],
> +      'tests': tests,
> +    }
> +  }
> +endif


