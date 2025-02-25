Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55451C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmv4q-0007iD-0I; Tue, 25 Feb 2025 08:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmv4i-0007gc-R9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:34:18 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmv4h-0001KO-4O
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:34:16 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6fb9dae0125so46932427b3.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740490453; x=1741095253; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OxsrIWTDWI4PmB+DclrjQmRVQU20qMCsr2Y9+Qdy7vM=;
 b=CCemveXNxQRLt9ZQ1yDxp2P36847ZpTJkVjC7fTPmNkitVKkXIzrJWfbvyx0kpnX99
 6pxlaBdJCnB/DQ3MnsKeXuhf3TKQ7ZYshpb+D2mdoMJrCpmU9qDD4LTI6f+F+iKt03Eq
 7dwL96HyRY2AQhSxlKkaxrOlAroSPrudAheOuWJ68xQ+eeTDwjKuyRSVeRq8S3nsw9B8
 c7C4tloINo9EbmH/71ClfLnT852kxe98Yy/bNtUR7Pv6UBw0cuYAPVt5s+m48d+sxSCK
 btaq9yQYompy1J4m1RNPLlvAxjwCd1KvLLYs6alnKrJMgF2/8YBU+ylVatpNjDXqS4TQ
 hwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740490453; x=1741095253;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxsrIWTDWI4PmB+DclrjQmRVQU20qMCsr2Y9+Qdy7vM=;
 b=iRszScsTxJClKJSqQ/De0MGDyVpf3mCOMI48kR+Pe2NSIQ9O0qyMHNGf9TF8RpjsSQ
 WtBP208LIbLuPZkfWyhp9i5h7Ps/daupqw+J1+zKBMoCAO0shw5MBQYaKw3N1M40/BMT
 4hAFGWYYGg/XeQAvVbgoqDYg1ynjHqFD/AVK/9c/G6/1mFNieSoVvehtiCPgwFo9LfL7
 ze3JqD8IkFtxm0aqotNRkxo1En6JXXzdbHgynr8rRBDrYBczMSFCSUaMVHWkj1x9hNAg
 LlOlfZWnq0tcl0VC/cXEeV4x2K7DaYJyGJyxBhkwENoPY7tPLeyYlM1akNw7oFsmD07R
 BGzw==
X-Gm-Message-State: AOJu0YxiWmuIgNPBlwwYvv4f6UkwS1Qp7Wmb5VGh5sOJ2tZWOiZhmP/W
 0ya2aFgq0w9ybqGK4ItPNwWlAFOmDh1qP3wKNWd3uAahl0okLodBnzurgG+r+atB/UcMcHzHlAE
 13rezYWnioEEQJSk1+0zOoQ01hb7v1BOR/pHzvQ==
X-Gm-Gg: ASbGncuqvtuX0q7urlPImXhk7hAeK3L1xhhr1+A3Ymmem3CuBkA9fRqiPBU22ChWsKy
 VwwYhInVsfZ8y2IuD+lxKMVmufU9Ki4Sbk3d5zBYdEZRH7ecCah8RVSc/meK8PFYJ8/9C3hosPr
 qkjUByIk1v
X-Google-Smtp-Source: AGHT+IFtFX6My53gEVqsXJKnrkYbTZlu5Qqe1xhqwmTCqXKt8Yeb+cXHcyWgCyBH0FPRhmppOWzrSEmExbDCFIINbco=
X-Received: by 2002:a05:690c:6f0d:b0:6f7:4f5c:c2c5 with SMTP id
 00721157ae682-6fbcc3a3d7emr154533077b3.31.1740490453698; Tue, 25 Feb 2025
 05:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20250224184123.50780-1-j@getutm.app>
In-Reply-To: <20250224184123.50780-1-j@getutm.app>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 13:34:02 +0000
X-Gm-Features: AWEUYZmdji5XwKgZYKGtB1FS518mTcYuzcBjcwG4lqWvO2R6KKBW4-fU2DgAdrc
Message-ID: <CAFEAcA_woELyL3Ev3Erd7A=dc=o2eEvjbmKvPbA7R6Lm05iDbQ@mail.gmail.com>
Subject: Re: [PATCH v2] hvf: arm: sign extend when SSE=1
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Mon, 24 Feb 2025 at 18:41, Joelle van Dyne <j@getutm.app> wrote:
>
> According to the ARM manual, when SSE=1 the data item must be sign
> extended.
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  target/arm/hvf/hvf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 0afd96018e..43cf250eef 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1971,6 +1971,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>          bool isv = syndrome & ARM_EL_ISV;
>          bool iswrite = (syndrome >> 6) & 1;
>          bool s1ptw = (syndrome >> 7) & 1;
> +        bool sse = (syndrome >> 21) & 1;
>          uint32_t sas = (syndrome >> 22) & 3;
>          uint32_t len = 1 << sas;
>          uint32_t srt = (syndrome >> 16) & 0x1f;
> @@ -1998,6 +1999,9 @@ int hvf_vcpu_exec(CPUState *cpu)
>              address_space_read(&address_space_memory,
>                                 hvf_exit->exception.physical_address,
>                                 MEMTXATTRS_UNSPECIFIED, &val, len);
> +            if (sse && len != sizeof(uint64_t)) {
> +                val = sextract64(val, 0, len * 8);
> +            }

sse is only set for byte, halfword or word loads, so if it
is set then len won't be 8. Plus sextract64(val, 0, 64)
is valid (returning the input value). So we don't need to
check len here.

>              hvf_set_reg(cpu, srt, val);
>          }

I've applied this to target-arm.next, with the
check on "len" removed from the if() condition.

thanks
-- PMM

