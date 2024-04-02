Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8EACD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcq6-0008AH-2J; Tue, 02 Apr 2024 08:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrcpA-0007UY-PF
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:12 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrcoG-0003Jx-Bp
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:01:06 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so9711565a12.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712059209; x=1712664009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgXm2nlfXFrP6jSWEzK73t/J4axegXUGk98VGIOpPgY=;
 b=EqZpSeg9M2WjxF9uC9sAUAV5OP3/aC5dttT345EIhcKPsElXX88XZeyhp9/PLjPy9Y
 UaoNU319TZf/DRcLQxz0RFoHIJSqxOg6kFKFZaef+L8boKTT66YCBbDvQsPY7XHI3ftN
 ipISVVpH1Mhv+yLgc0VRzftcyaoHIl6e8fyDejfqSerc6rr5rr8w8hYuPqaeqXuPfOp6
 nMNwLnZ5T4va+uzsX5Uf+8YufvNfdK5J9z9JkV7URbjj/kOyYMJb4YFtXNynQ11bGgIj
 zvER5jie8IyQfZ+oB3yJB0gomHf4409ix2s1R+MrTNUjpcCBvUz+CXO5eKMzPBnZN6aK
 IG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712059209; x=1712664009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgXm2nlfXFrP6jSWEzK73t/J4axegXUGk98VGIOpPgY=;
 b=LwfXE3N0ANEY3zzrrNoQs/Ai6QOmG8aeCZ59haEZQ58MntuawtWY5pCplNOuk6aNAk
 1dxrv9k1dIgTs/mYPezAriKbkZl0AZ4LLhdvTNwSKnbQhq9Q8K4z2DY42foVKrmkAJuf
 P1Xvtk7BKQvPnQpyO6OKZlY0nOv9uNJtlYZJOQZY/kJ63LN7OGn/mpGhIyx5C/SGtp5s
 +IR56xxJA6CVkxWJzTSIjwQ2lgGpfFNuXddCNYpjLzCKv/y8ATEaztvT7ZyiWb3JRcV4
 Z9FSN3A4P/6OBstTOQZrQlCoJO4/R7huDblxmqqsZfoNfbSDX7LgwocGjtIrSGWQISpd
 s26A==
X-Gm-Message-State: AOJu0Yw7+xF/G6otRIF0cc7CJirE51jFO8HHbOwpPcVbjabWI2u3tTmk
 iAQWkqpQAU65deTLQvUmTfeeumbzT/XgfwqRVdkfwIBcX5/ayCjRsMJWzG2t8/6ix/KYWpc5VV2
 a9AdHZuDFLCMfxcB1ZMpMALWgxA67J87dl5soue1qiap91c50
X-Google-Smtp-Source: AGHT+IFQBknMkfhTSx90+r8jOPkCnuujbvEiZc4TPHWmqXlPenQP5n2pMInjrcrZm1c8NXSw6TwjxU+NqpGO1RFn9hg=
X-Received: by 2002:a50:d6cb:0:b0:56d:c711:1538 with SMTP id
 l11-20020a50d6cb000000b0056dc7111538mr6863757edj.18.1712058756459; Tue, 02
 Apr 2024 04:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240402113015.66280-1-philmd@linaro.org>
 <20240402113015.66280-2-philmd@linaro.org>
In-Reply-To: <20240402113015.66280-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 12:52:25 +0100
Message-ID: <CAFEAcA8iCdNOdnrqY+7yupUvxQQfCLh17WRHZ6zFhVQrB4CXgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] scripts/checkpatch: Avoid author email mangled by
 qemu-trivial@
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 2 Apr 2024 at 12:30, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Commit f5177798d8 ("scripts: report on author emails
> that are mangled by the mailing list") added a check
> for qemu-devel@ list, complete with qemu-trivial@.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7026895074..4fe4cfd631 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1573,7 +1573,7 @@ sub process {
>                         $is_patch =3D 1;
>                 }
>
> -               if ($line =3D~ /^(Author|From): .* via .*<qemu-devel\@non=
gnu.org>/) {
> +               if ($line =3D~ /^(Author|From): .* via .*<qemu-(devel|tri=
vial)\@nongnu\.org>/) {

I recommend checking against qemu-.* rather than trying
to capture explicitly all the suffixes we have. (For instance
there's a line in mailmap for a commit that was attributed
to qemu-block@, which this change still wouldn't catch.)

thanks
-- PMM

