Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64820C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrWL-0001WG-5E; Mon, 22 Jul 2024 07:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrW8-0000cz-QG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:47:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrW3-0003BR-K5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:47:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a88be88a3aso572574a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721648862; x=1722253662; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rqZt2GBDBlRHU2MNPIjWXtmJTTnY6Ryl785kfDf2JBY=;
 b=VgE/dP7xezEcMQmohkE6dmwihylU6GLJvkla1pmy1HFJkXUWQS4fvcZGd8lpj0QOI1
 wQ+EKBXt1JJDa9hgpcMa3SK3g7Z1NlZYiYjmA/LC5q/baa8Djw/81pGsRqfrJCNgFXBv
 EIarZq+tWOi5TB94tKQHr2VUkDeBzBETZ3GOok01rgtTCg+uFwb63qFhsmfhqmAI3qA+
 fxvD5ya6g4zD4iJ+HMHqFTJUlRzVt+RCgvla21LJauS3c5VIETO28Q1wXFB6DtVG71Q1
 WpwqrYnysFjFshopoR25CY0Nk0k69n8VSvAP4m/J5vWqV0cUVJbJPo94m656JaqQYQpk
 wieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721648862; x=1722253662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rqZt2GBDBlRHU2MNPIjWXtmJTTnY6Ryl785kfDf2JBY=;
 b=GrwtVMT9dn6Psz0ow0kfUNZdGk9yQ3/dvN7RbtVKXmgu0WTIGU8ZyYDowJdV8O7Q3V
 Ci5jLjUjfzA3ZyHMplbPoEruW+rMll+J1XP/PM/8/X5O8MxHw6eIdbzcvWF+kdLWOXAU
 dwaHl9GWpfatJYb148t1mb/fZ+oVZVuz2LgsJAtOqu8QD4qSjeNCq7eo+LDe6cY3oEh6
 iPQDZniMqfDxYO2LWZEH9V+QOTbPBCajV55qSANfmBezYOdOrgpzCsQMwsyuFWq4IJ7j
 D+bkSz0v7gIQe/hHGO0gI9xmV8psFhLovqMj6nCxIZv+1KxBDuWjO03dkhkb6rxMD2mg
 U8PQ==
X-Gm-Message-State: AOJu0YwsAly3x0cDaUh8RoDsRBChRiC2dLLQLoSCdBR6H4O34xc+PSSO
 E6ro/75PHCLKPd3+PY+io0+X0rkcQpB8E49fCem1PMWMkaMau7+eyy3as2LJF9E6ThAkaWAwaZS
 2gboRCBiMd/iLTbjSJu4ydKkvfoo3iD8XM9ESUQ==
X-Google-Smtp-Source: AGHT+IEx8mRQyp963eeXXdoV+BXKAU7bLrV30LptSyhYM2vBHx7uGr9vEf/gx1mCsDuaMBMONGysXyfnnaxRXKtLMQo=
X-Received: by 2002:a50:9fa8:0:b0:5a2:6e1c:91ed with SMTP id
 4fb4d7f45d1cf-5a47a61f401mr4248220a12.27.1721648861960; Mon, 22 Jul 2024
 04:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240722091728.4334-1-yaoxt.fnst@fujitsu.com>
 <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240722091728.4334-2-yaoxt.fnst@fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 12:47:30 +0100
Message-ID: <CAFEAcA9_Q91hj7=Zok2de7ekqz+YQ+Jit7MBxYQ1aPZah9PgeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips/loongson3_virt: remove useless type cast
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 22 Jul 2024 at 10:19, Yao Xingtao via <qemu-devel@nongnu.org> wrote:
>
> The type of kernel_entry, kernel_low and kernel_high is uint64_t, cast
> the pointer of this type to uint64_t* is useless.
>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  hw/mips/loongson3_virt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 4ad36f0c5b64..408e3d7054cd 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -355,8 +355,8 @@ static uint64_t load_kernel(CPUMIPSState *env)
>
>      kernel_size = load_elf(loaderparams.kernel_filename, NULL,
>                             cpu_mips_kseg0_to_phys, NULL,
> -                           (uint64_t *)&kernel_entry,
> -                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
> +                           &kernel_entry,
> +                           &kernel_low, &kernel_high,
>                             NULL, 0, EM_MIPS, 1, 0);
>      if (kernel_size < 0) {
>          error_report("could not load kernel '%s': %s",
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

