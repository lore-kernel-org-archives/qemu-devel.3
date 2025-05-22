Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B744C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 08:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI1gw-0000aC-R6; Thu, 22 May 2025 04:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uI1gt-0000Zt-D5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:54:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uI1gq-00081D-Nk
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:54:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6021b8b2c5fso4644972a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747904049; x=1748508849; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t79VfxOjD+riZyiBoYVO9ouA086RAoiB5JReeU9+PBo=;
 b=ugXxHKaY4NU7RPsK5i6jgxyza51XDl2uP50cMI6625VCrG4rIuj9et/jUDrpAyqzm7
 X6/tnNQv/GByKrSfS9/Sb7XGgcJlA/nCQR/uhdEeKFTo4sI+7UqiLuX5Po8cY65PbmR4
 nCFEww1K26a9S9vyaAJMdRf+7D8SCd9RS+k+HY4Zn9UOyCz/JOncPyeJiQWR2RMttfcE
 YwwbH2lnk1x3+a34TkCpE7sTk+TwZs3Ebr0sVaPfyUs6e69f5UhG0noSv4pVTvP9srHC
 21GaCNBDj7uCMIr/GiLk2aS4JSSp/FV7XDTQC+uVlCnwR0zNXATdLLnownx2tW9cDzxC
 oyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747904049; x=1748508849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t79VfxOjD+riZyiBoYVO9ouA086RAoiB5JReeU9+PBo=;
 b=og/+jqKIe2WFfP2PL6vahcBcQMrF1zBvSoJ81/SFXts4GiqMAR/u0jA6Wk7ynN44yp
 0wFtv1ENAFooEb0+B2uUH8a+apFjRfzGbQwas/dUiUFatgtJxj2im2z+DxInreBgvU9z
 bhn5pHHWqYgveEJF+CnNt0ETewDDy4oT7pvnma6SnaGqWkjYJB0kB/jucAzLaDpHErjs
 nk+8aPUW5YwSgu/EsmMr4ux1oWCSaoA/3G5kDEARAGp9IkqHct6X/wYBwzxfEcNmvfAU
 XwJdCUxEycESpSL27M/FEjW9PcMS+9TWNVOvzb8bVZq5J5NnFvCrdZwIyFvkxu7mIZv3
 Zc5A==
X-Gm-Message-State: AOJu0Yylo1G3NXUNVVc4SgkxvMeeNq2woGycZljMDYGe1aSQ9+aqsqI6
 dVyhTXyrXdnS2O5V6/NVqzErI+L815TdLltklJzW8+P6ixiXm/iu+vBhHz89Jw+RUCtudOqK4nw
 XERsslSl5jTJgmt8IqXSFphq4BYjjl7i/aWxe0NLJ6w==
X-Gm-Gg: ASbGncvI3A8FklZyCUzwU7AGYbeg2mtlyKEYpi9SwncTzQqzP//aSiwSxK4YWK2INDS
 OTKuWMxxLTbTAs4x2GNsGL4A5u8hPMb2Ip2k2Ssd+9wutGSBFIQgQT7Ou+Q5HdcMoilQWM2+A1p
 d+TGfa7Z6Vle1XuK6EPurwNDWUQ3ng
X-Google-Smtp-Source: AGHT+IHMgg8WtlBG9VaoOrQ5wFtw/w+UKNGWL3IezH4lAjJ1YrjVAVsRrAhavDa3xcS78dldaf2XwuqyKUTPPAO4FgA=
X-Received: by 2002:a17:907:9412:b0:ad5:69e7:181e with SMTP id
 a640c23a62f3a-ad569e71f30mr1152973266b.61.1747904049470; Thu, 22 May 2025
 01:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-2-rowanbhart@gmail.com>
In-Reply-To: <20250521094333.4075796-2-rowanbhart@gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 22 May 2025 11:53:43 +0300
X-Gm-Features: AX0GCFsW5fbVcc-Qoe0SxslKAcB2537ZG2iqLDVQrD5IpbRsEgotNNmcL6JcARE
Message-ID: <CAAjaMXYBrdo=F-eXy9R-wuYgzGy_0krG_AHgJmQau+Pjd2BZDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] Expose gdb_write_register function to consumers of
 gdbstub
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, May 21, 2025 at 12:45=E2=80=AFPM Rowan Hart <rowanbhart@gmail.com> =
wrote:
>
> From: novafacing <rowanbhart@gmail.com>
>
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>  gdbstub/gdbstub.c      |  2 +-
>  include/exec/gdbstub.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 565f6b33a9..5846e481be 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -534,7 +534,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf,=
 int reg)
>      return 0;
>  }
>
> -static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
> +int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>  {
>      GDBRegisterState *r;
>
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 0675b0b646..a16c0051ce 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -124,6 +124,20 @@ const GDBFeature *gdb_find_static_feature(const char=
 *xmlname);
>   */
>  int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>
> +/**
> + * gdb_write_register() - Write a register associated with a CPU.
> + * @cpu: The CPU associated with the register.
> + * @buf: The buffer that the register contents will be set to.
> + * @reg: The register's number returned by gdb_find_feature_register().
> + *
> + * The size of @buf must be at least the size of the register being
> + * written.
> + *
> + * Return: The number of written bytes, or 0 if an error occurred (for
> + * example, an unknown register was provided).
> + */
> +int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
> +
>  /**
>   * typedef GDBRegDesc - a register description from gdbstub
>   */
> --
> 2.49.0
>
>

FYI there's another patch in the list that does this
https://lore.kernel.org/qemu-devel/20250430052741.21145-17-mario.fleischman=
n@lauterbach.com/

Letting you know so you can track each other's series if need be.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

