Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B1FC3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCIhy-00035V-4X; Tue, 06 May 2025 09:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCIhi-00033f-Id
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:51:28 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCIhX-0002h2-SK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:51:17 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7387d4a336so4673244276.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746539475; x=1747144275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GVBAH/ER4P8HVKndtng7LqW/m4jW3shxC7+d16Rca24=;
 b=u/jEdYPPzz8S3ACFVcTFBAapHnnCAUtXDZxcWtlmZGB4mYWqFe6zxYlZyvUcjGHAfn
 1qg6DCdYC5JBmuAjLokL5cwC/7dj/LnVIK70fz2ursILeytgBDWDxB/frnonHKNjKndx
 eKGd5Hqdysk0c2ss9q1VcH41q1xK02pnT/DDI6s69dzwtYdurCuvbVvMje6yR5waJzaj
 HuSrBc1lDwUmdF+zFDyDHeCTGjMahzppvVX/BEVaweaTLHVw6PTPSNB682nwGf57tIOw
 RshazkHB6GdKmqskeyEZ1kiOuRHqmTfCsDL3GvlZDEKDj2mOkNvfkXpkB2BOYemVZpG2
 ++Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746539475; x=1747144275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVBAH/ER4P8HVKndtng7LqW/m4jW3shxC7+d16Rca24=;
 b=Q4/cc4u94p+Uk2jR3kA0dgh735VIQHB4s11LhowyhXMn6p1qSv9RzVjHlZBxXo5LrZ
 EaWIfKde1qcp+MEOQctmf2Rz1yQnIWPsY3g5eTd/jqinH4ZKwQDpO2p6FlR4GEyYoTpx
 pSFtwqVWxRio43ZJ9o27w9TJVInqnFn6IQD3oGiXO+wSthC2MtNFbkhcS1f9q2nU/zR6
 KTeS9INiTN9Gy7wC50GLwk4txAcoVI+jfvsnNhvRXC6/JlXchQFIFwwAzbfZ11HsGieU
 9rqk890PwnVLCAI73F+C55NBAaYqTZvaGjOl/z6d3yWF0DBd1y0zT13adlDpu9oqZ1Av
 HMZQ==
X-Gm-Message-State: AOJu0Yz94Zn4xc/tEXS65Q+qpmYTM0wR66bHNgyx82ojQh/Ff0xD2xSQ
 0KCQR2AendbPjEcc4iahi/sa5uIIKXvvwkdy7rh6IweO4yATHG34s2wutREH6vRbD6IrmrQoQdl
 qeBUFuL+t9KHmGVkZUjlnoOG7STOW0U+jel3qmg==
X-Gm-Gg: ASbGncuzXOBVFLPJWxLlsuS/G+d5faasX45y+Rk6mB1KrW6BTANYsVLFS7Cq2oSdkjV
 OURKnX5IPiOAc4H7030fm1v8qmSNLd6FvHwVcsC6MYiRnYaaHi3vwpDmauD7rzW4fY7Z2+hkM+J
 svBR62EFrAiLrVTUGxFRqTHM8=
X-Google-Smtp-Source: AGHT+IFNMsCO1MCJW8nLsF/RUHAI5h8MpTO4AbYL0SNVoP+JniW66rKs/YU98IFniGrRN9z0W4RU8zoqTa0MSrHj82g=
X-Received: by 2002:a05:6902:2744:b0:e72:d424:8e11 with SMTP id
 3f1490d57ef6-e757d35c19cmr15113518276.31.1746539474758; Tue, 06 May 2025
 06:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250506134933.194740-1-pbonzini@redhat.com>
In-Reply-To: <20250506134933.194740-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 14:51:03 +0100
X-Gm-Features: ATxdqUEV_ThfIpeHOisfko8dxG95Qy3urIysCM7dp0LwNpIFD9l5XI2yXeGHoRA
Message-ID: <CAFEAcA_4vpG=XvVzCu1Lr+5XGVjQnmmdD1QSQewpMcP3XbB5Kw@mail.gmail.com>
Subject: Re: [PATCH] docs: build-system: fix typo
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Tue, 6 May 2025 at 14:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/build-system.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 258cfad3fe7..2c884197a20 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -168,7 +168,7 @@ The required versions of the packages are stored in a configuration file
>  ``pythondeps.toml``.  The format is custom to QEMU, but it is documented
>  at the top of the file itself and it should be easy to understand.  The
>  requirements should make it possible to use the version that is packaged
> -that is provided by supported distros.
> +by QEMU's supported distros.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

