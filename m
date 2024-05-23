Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25682C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 11:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA6sw-0006DL-5s; Thu, 23 May 2024 07:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6su-0006Bm-Qv
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:45:24 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6st-0007BY-8O
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:45:24 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-572d83e3c7eso12072593a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716464721; x=1717069521; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4L8NLVIqvGTQx7vUyls/DMMh6Z76vf/Iu0cfOHaawyE=;
 b=ELTUSez7ZrLh3l3OKSTTsI/HX7OgjbrMiHG0Zqe37MaCAhR6pTWaV0Yz5qx275Xj/O
 RU+MI26EYYBeiWGjNvgJrX+hr8TPn35N1FMsXQEmCedEmZ34Ydws/6j37QcicoOZaK0n
 hW8Qiz5IQEp62Ki9acNHVXViW6v8WwGNsZ+HvrY+HlqOn7pewKLIDBHdJcLBcAfR9xZt
 w6Cmt7bHelSk9/d8+WLImc3hK3pz6elBG2Xh5eH9YHdcNcDooxfoyugWCgEfKcykj8Dz
 134bgYM/os2h4O0SadzUeT/bOpGq/y5NGY6EyelDD2rxT9bhqfYqogoV8HGftC/IYjwH
 ENrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716464721; x=1717069521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4L8NLVIqvGTQx7vUyls/DMMh6Z76vf/Iu0cfOHaawyE=;
 b=mnCDvLZsmgtHhB5Toa16uYc1mP2amH9n3ZHT1MBVQoxnsW6QGd0QN1KQ+tiTKKsalJ
 J6z66aroakzM/RBxWn+MeOamaRupwgAch9HmbFmsiGmFATFo4CoiSgOoOUXp/+ZBDmH+
 0yp4HJ0IG2wjzYn/fk6fjWG/SaGW8IkHwQJlB8w0wzNsWxy5BH+zpwENHcbWW5lbU7uL
 Npp+5KBaQVrSk8j4zUeIxpIVRzEN17BPB7I8s+sd4wB2MjSWy/iVkB21dxdvs6fnggcr
 Dvj1XpN9GwvfsqxI9vGBJzTwazJe6GFK/C6eexQ9uJVBgEG1uESpu6NnAX1cMOVfqS37
 6G8w==
X-Gm-Message-State: AOJu0YwBjYKyH55UCfTMwueiqmt73/05zysduESJLCsfbwlWnhQPJVQp
 xxKNvTd5ExSk4eOBgMlkMrTY+Eyl4pLj/cdIvi5dJwndoi+QZPO1l4wXve+tne07RYRyhmyVgw8
 ceDRyB8hoTvaX7LVITBvhOoT1/WtZAf4uXKYmY0W+LWu1HuqN
X-Google-Smtp-Source: AGHT+IGbneQasGy1wHcywurCF4VgGk7iFXLOAGpPOTQWW4IEHWnDUUlpjdUYe8VF+xLes31zmn2UU7XJ/mSBbSmz5aQ=
X-Received: by 2002:a50:c2d2:0:b0:572:a123:5ed0 with SMTP id
 4fb4d7f45d1cf-57832a8913emr3501243a12.21.1716464721271; Thu, 23 May 2024
 04:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-16-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 12:45:09 +0100
Message-ID: <CAFEAcA-WwJVE=XVXFYA1n_XV1HcmQNL=ec3kMqe0P-aej+7UWQ@mail.gmail.com>
Subject: Re: [PATCH 15/57] target/arm: Expand vfp neg and abs inline
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  6 ----
>  target/arm/tcg/translate.h     | 30 +++++++++++++++++++
>  target/arm/tcg/translate-a64.c | 44 +++++++++++++--------------
>  target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
>  target/arm/vfp_helper.c        | 30 -------------------
>  5 files changed, 79 insertions(+), 85 deletions(-)

> +static inline void gen_vfp_absh(TCGv_i32 d, TCGv_i32 s)
> +{
> +    tcg_gen_andi_i32(d, s, INT16_MAX);
> +}
> +
> +static inline void gen_vfp_abss(TCGv_i32 d, TCGv_i32 s)
> +{
> +    tcg_gen_andi_i32(d, s, INT32_MAX);
> +}
> +
> +static inline void gen_vfp_absd(TCGv_i64 d, TCGv_i64 s)
> +{
> +    tcg_gen_andi_i64(d, s, INT64_MAX);
> +}
> +
> +static inline void gen_vfp_negh(TCGv_i32 d, TCGv_i32 s)
> +{
> +    tcg_gen_xori_i32(d, s, 1u << 15);
> +}
> +
> +static inline void gen_vfp_negs(TCGv_i32 d, TCGv_i32 s)
> +{
> +    tcg_gen_xori_i32(d, s, 1u << 31);
> +}
> +
> +static inline void gen_vfp_negd(TCGv_i64 d, TCGv_i64 s)
> +{
> +    tcg_gen_xori_i64(d, s, 1ull << 63);
> +}

These will get a bit more complicated when we get to
handling FEAT_AFP, where abs or neg on a NaN doesn't
change its sign bit. But I guess we'll cross that bridge
when we get to it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

