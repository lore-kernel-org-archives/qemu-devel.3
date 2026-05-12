Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502E0CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdfv-000480-AW; Mon, 11 May 2026 23:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMdft-00047d-FH
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:20:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMdfr-0005Dq-O4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:20:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so59351505e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778556045; x=1779160845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lhPhjNqW9OfL4vNOKs+GkeWlv4YWJfVRcPQaaZEbreE=;
 b=i0qz2Gk9kdwaXemmQHDrAtxYqwqDe49OWQdkQ2tWyzp8J96k+iGOLEyj5O6pQTGDwE
 z6iMIbOod5zQOj4AvCypXQpSvHCD0+y3afQ/0GBMxdrBVLYQO2tRyChyotuehgEXRBjq
 Q4coptJxABVbPzhJKbucllSJ8kkX37mkG1ibfQkSC4muT7MB+nT8gLKWPedeCnocPg2o
 HCjps5Raf8SkrdwYYixA87KVDGfKiCgiXjsa9TbEizk7F08o0gy0IVD5XBDLnOaLtwRu
 IS7JuuWhXxViRkbTgsguv94r3HRrW9uf/vn2HPr1OD/aGbkjLQafm1MH9vKq0RGfUd+r
 5MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556045; x=1779160845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhPhjNqW9OfL4vNOKs+GkeWlv4YWJfVRcPQaaZEbreE=;
 b=MSlsoxy09JaXASe015iE5aqgcdEwqO/fYdBIyPIBarY4pphLv1k0Wtty8WpUI4VMO6
 xzhTdqCm4SUZNXWx1ubmDVD+chKgMccSg+8vHXBnsVOpBub2Np4a/z5HwRSnc7FPFmPa
 xDzcvuBKcuoDKGaeh1C48q2y1eYE5Cm9wlb2sveiOEhk1yM6iCBuBmWwGfGmlFtT4g7n
 GEB+D1EiwhevATEalgmAtvz1gSwJ4BGHUiWkpOaH4Uy0Ucj7iYUYA3m5WCkJm+UnzzNL
 apivlDCscukb5KKzN7EvmHOJdPn8ssSKDHWqt4LIeDqkfCkaXbZHNXJ3jFYybImojHmM
 YYUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bxy4vIoeNP4SW9rLPSjfZ8ziReg+hfbfFEJwJBgEM2TcO4zYdIF24TyryQJLrNBcX3GycS3hReM4c@nongnu.org
X-Gm-Message-State: AOJu0YwKRk04msuyyR83EFgEs8QYOACXbMhsFMFlh65+r/lcZvPADd9Q
 w0ZwUvZB4wAXoPK606ZDw09QGDF932jKmaXWAt4o5uTeNLyJnXIa02jvDzCRgk04sQg=
X-Gm-Gg: Acq92OE0Dmj/fQQHyJyHrMZyiAxOR5TNoHoNx/ZeNPpekaoQZkVlGLnuUlJ9wioVg62
 lS2JfdJjVmuftV3aCp8qX5+Ww23Eglc65E4qUt9J7xvx1KbwRtm1qFCGB2Li70fA9KG7uniEXz2
 qdjZKD/3nem3UrnQOQYyCojfO0zaIvB7fKRys8PaExAiWqMHftFRRSFVF77rlYcGSY+b0qyaJqx
 MNt5DocyWpDHhBnfO1noc0cjtQeI/0m1S8hhU2z1JT03/vxVaohBBWMiHt8hj3xb84CTS00ZjCI
 NgnTR+djnThrIrgRHBu9g72KOlyVr4pQhFW+CkwcRdukfRg1OYCSexEop46Q3+qvX+n2DVulb9C
 dVbd9UzhIhSRTq4MMaDUgqIFwCVWLNzBeDCb04N2DmnG8fJq+09rAcoLhYpoRUq464ND19yaJ1s
 +R1NSKdUaqK1AFmk2P0hBO0i2wir1s78JBEzyVPVgRrfKIEMydLGsktpuuDhoEX7gNww==
X-Received: by 2002:a05:600c:6299:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-48e706f11d0mr198459665e9.17.1778556045115; 
 Mon, 11 May 2026 20:20:45 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9055ec3dsm13590865e9.0.2026.05.11.20.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 20:20:44 -0700 (PDT)
Message-ID: <259bfc18-98f3-4cc7-9f9d-a060291d39b2@linaro.org>
Date: Tue, 12 May 2026 05:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target-info: Merge target-info-impl.h into
 target-info.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com
References: <20260511190634.472174-1-richard.henderson@linaro.org>
 <20260511190634.472174-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511190634.472174-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi,

On 11/5/26 21:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/target-info-impl.h   | 43 -------------------------------
>   include/qemu/target-info-qom.h    |  2 +-
>   include/qemu/target-info.h        | 31 ++++++++++++++++++++++
>   configs/targets/aarch64-softmmu.c |  2 +-
>   configs/targets/arm-softmmu.c     |  2 +-
>   page-vary-common.c                |  2 +-
>   page-vary-system.c                |  2 +-
>   target-info-qom.c                 |  2 +-
>   target-info-stub.c                |  1 -
>   target-info.c                     |  1 -
>   10 files changed, 37 insertions(+), 51 deletions(-)
>   delete mode 100644 include/qemu/target-info-impl.h


> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 23c997de54..c9f7f2aa26 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -9,6 +9,37 @@
>   #ifndef QEMU_TARGET_INFO_H
>   #define QEMU_TARGET_INFO_H
>   
> +#include "qapi/qapi-types-common.h"
> +#include "qapi/qapi-types-machine.h"

Per commit 0af00042a92 ("qemu/target-info: Factor target_arch() out"):

     Keeping native types in "qemu/target-info.h" is necessary
     to keep building tests such tests/tcg/plugins/mem.c, as
     per the comment added in commit ecbcc9ead2f ("tests/tcg:
     add a system test to check memory instrumentation"):

     /*
      * plugins should not include anything from QEMU aside from the
      * API header. However as this is a test plugin to exercise the
      * internals of QEMU and we want to avoid needless code duplication
      * we do so here. bswap.h is pretty self-contained although it needs
      * a few things provided by compiler.h.
      */

Is that no longuer necessary?

> +typedef struct TargetInfo {
> +    /* runtime equivalent of TARGET_NAME definition */
> +    const char *target_name;
> +    /* related to TARGET_ARCH definition */
> +    SysEmuTarget target_arch;
> +    /* runtime equivalent of TARGET_LONG_BITS definition */
> +    unsigned long_bits;
> +    /* runtime equivalent of CPU_RESOLVING_TYPE definition */
> +    const char *cpu_type;
> +    /* QOM typename machines for this binary must implement */
> +    const char *machine_typename;
> +    /* related to TARGET_BIG_ENDIAN definition */
> +    EndianMode endianness;
> +    /*
> +     * runtime equivalent of
> +     *   TARGET_PAGE_BITS_VARY ? TARGET_PAGE_BITS_LEGACY : TARGET_PAGE_BITS
> +     */
> +    unsigned page_bits_init;
> +    /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
> +    bool page_bits_vary;
> +} TargetInfo;

