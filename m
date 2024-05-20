Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B592C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 15:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s94lm-0003bX-FS; Mon, 20 May 2024 11:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s94ll-0003b8-DC
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:17:45 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s94lj-0007Cj-Od
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:17:45 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso8428386a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716218262; x=1716823062; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PofadtPjV50gLiZAVOOvtpW2alRq1pf8qNEAm+/jhS0=;
 b=F20LiyowI1xUnUAYXvSPfVsA13wuBteTEaf5+w1S1x+N2akma+p0TCQ0PLPeEgxkY1
 /h0rZq+rqVxjV/h6/1c/F8OnLbZWlzGEH3h4zPpmgRcakI+QB27ls20MDSQphSKNgkYi
 B/LNRRVleid3QciHgzGXAVyCZX+hbMWQL/kpojFqgkQz+XiLbRbih87CPyPv2t079fHU
 4wdz/NM4fliAvFdk4Xlgc1f/a/CymWmWlUnWi0Q3QZwcW1RZ0PN3DKICHK17qJ7gRUHa
 2XunKBTg3Z1ePa3QS2yzbQ+hxYpRsZnBTQrQhGnC3+GSrU+PXVTeiXsuKxz+ABEsV7xX
 8cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716218262; x=1716823062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PofadtPjV50gLiZAVOOvtpW2alRq1pf8qNEAm+/jhS0=;
 b=raLkyvZ/KyRuIuxue2L++86fM3KQOwv9/0sgYLJspxPUFQZXoB8cH/BhBVZ8t4v3Aj
 1ZYGzMTdPY6YgE3dBJDnmeMR6vmTZweGZxPr5rxRIga5r1pkM4qRMFaKbRy2OVrlU227
 k4FS4+RJ75/+DMShJengA3zeWlKEGKMgBJYM5x+HuWPYx3R+5T3gfW/rgzJ/aKxAbOUq
 C1eir/Fzl75K9SL+6PHsTDE6wPLYQW409H4WmE3QYyDlK7+AsPcibIZsud1eOPFHgo7l
 8CuPHbQTlNRNTjS/wHFAi4Hcf80HKy/yBOcnsN1L6kG3DvUWqAhxzjQjtLJ+nkHiFMBN
 e7eg==
X-Gm-Message-State: AOJu0Yx5aUnDVAs4ihP3g69cCgJ0K69XnbgsDmt2cvYyjjCnB9Z6I5xc
 eW9GA72jtEqpMrfvsvpYE5A/aTd4kj2hNPlRWlzB5PKwMa0YOtQvEcZzlvBa2pIKTL+qhQhSK16
 E9k35W1VnG2RQv96iyYWfU/SGWGNSlMu2F/rdCX9TRLtlQwNV
X-Google-Smtp-Source: AGHT+IFZDi1ihBetfZCvBQ8q86KuydsjQb6GT8OEIJn3zY8L53suS7X6X3bT00M9s/Nw6+snUbkzL4QQLQ76UB9pJWc=
X-Received: by 2002:a50:d5dc:0:b0:572:7319:ab83 with SMTP id
 4fb4d7f45d1cf-5734d5904c1mr21862907a12.6.1716218261691; Mon, 20 May 2024
 08:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240513113513.640007-1-alex.bennee@linaro.org>
 <20240513113513.640007-4-alex.bennee@linaro.org>
In-Reply-To: <20240513113513.640007-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 16:17:31 +0100
Message-ID: <CAFEAcA_E-kFwSVfN+egkUp4Ff6sCj+LXn78z9xbNHGJ96J9PTA@mail.gmail.com>
Subject: Re: [Semihosting Tests PATCH 3/3] add SYS_GET_CMDLINE test
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 13 May 2024 at 12:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We actually had the stubs to implement this. The main pain is getting
> the binary name into the program so we can validate the result.

Could you write the commit message so that it makes sense
without reading the Subject line, please ?

> index 5df95f3..268a9d9 100644
> --- a/usertest.c
> +++ b/usertest.c
> @@ -315,6 +315,26 @@ static int test_feature_detect(void)
>      return 0;
>  }
>
> +static int test_cmdline(void)
> +{
> +    char cmdline[256];
> +    int actual;
> +    const char *s, *c;
> +
> +    if (semi_get_cmdline(&cmdline[0], sizeof(cmdline), &actual)) {
> +        semi_write0("FAIL could recover command line\n");

"couldn't", I guess.

> +        return 1;
> +    }
> +
> +    if (strcmp(&cmdline[0], BINARY_NAME) !=3D 0) {

Why "&cmdline[0]" and not just "cmdline" ?

> +        semi_write0("FAIL unexpected command line:");

Space after the colon will make the error message a bit
more neatly formatted.

> +        semi_write0(&cmdline[0]);

Missing "return 1" ?

> +    }

Is it worth testing that the length value returned
by the semihosting function matches the length of
the string?

> +
> +    semi_write0("PASS command line test\n");
> +    return 0;
> +}
> +
>  int main(void)
>  {
>      void *bufp;
> @@ -366,6 +386,10 @@ int main(void)
>          return 1;
>      }
>
> +    if (test_cmdline()) {
> +        return 1;
> +    }
> +
>      semi_write0("ALL TESTS PASSED\n");
>
>      /* If we have EXIT_EXTENDED then use it */
> --
> 2.39.2

thanks
-- PMM

