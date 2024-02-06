Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7480C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLoJ-0006Kw-Dt; Tue, 06 Feb 2024 08:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rXLoF-0006Hf-QG
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:48:24 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rXLo9-00045r-8N
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:48:23 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-21433afcc53so3401847fac.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707227296; x=1707832096; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5v+p+0tw6vGNGyQ57FAc9ILWdHrY8TIZGXvdyrT5ZLA=;
 b=blxfz3cvseCAY8cBWmu+c20x5oYV1HDe8EpIh8IR3dddsPC7P/g2P8pMOszPOJj4ST
 RB0IkuWfm5U/4L5JFlAswQn2ewIYIMRMCSp6tfFySuM1KjbJFANumORpF31SSSPZsng+
 59ZwUQ52GpyUAfcLzqUN97tydufpa4G6mZ3qHBql3OPi/uJwswt1qIjkDRR61rGg3Ofd
 lX7ZjAkAugZAGZJoc6wJcIqbTgmJBt8LaLG54itKzRFZTjz1uAwNUfyhM30l74wbBXWF
 xrlxijGsMV5GEpwaku9ZwkyK4iu0Qeh2D3IgOw6Wc2JOUfMMBfrTK80cZheT6dVuzjMb
 XNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707227296; x=1707832096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5v+p+0tw6vGNGyQ57FAc9ILWdHrY8TIZGXvdyrT5ZLA=;
 b=wr4QFOOQE15XraOt6UjB1T7+70JOVlwYjIwRZ4WyRjM3wWhDgUit0EYIamYffdk6mi
 iVYMZoYtAyEzmm+389rYEGJ2Lo8sgLthyVKI4NCb9SzdOStpa+aFqttN6v2O0VnVAIOT
 qS9oAQjj13RQ02jtdDOJQk7dKvbxC23KqTJFP2huKE9tjt4Bju4uJNnZYA6FGIUTrAUr
 kE2dKzIT/C5uvrhutCLELjeYIfEqdgAOsWid4y4DH9sSqw+J+rFMZ95rB1v0hzKbdurz
 83Oh4F7hA8TLuffZcDuqw+QLylHvd+ooqfCXHgIj+lU4wKeuOFsbEgYjCTGWeR5vjszL
 JTmg==
X-Gm-Message-State: AOJu0YyZeVHz6sCdflO9YUeiQYraUziTGOWM3826CfOEGUHJKY1unAN6
 t00QI2dLOi2zyPR4BEMlQ9fxA3k7Fc5ciPAsceAqdxN1RV1tD7dSOs9+JgAiMaQy8t5xVxgwk08
 bqHSdXtORmmwucKmMO7k7voE8ROg=
X-Google-Smtp-Source: AGHT+IHleDk6gxAb1p68PNANlXmQCoQVNT2YQY+a+zyCFTbiwIg9w3gXk2tE5UsW0UW3fnJq0C8x6JSGaYvckt1wAkU=
X-Received: by 2002:a05:6871:112:b0:219:69df:67fa with SMTP id
 y18-20020a056871011200b0021969df67famr3098586oab.52.1707227295911; Tue, 06
 Feb 2024 05:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20240205171819.474283-1-stefanha@redhat.com>
In-Reply-To: <20240205171819.474283-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Feb 2024 08:48:03 -0500
Message-ID: <CAJSP0QUPJyHd6E_OjQ=g-59efPXuzTs=rgyNHj0JzO0VRaScEQ@mail.gmail.com>
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 5 Feb 2024 at 12:19, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> C99 mixed declarations support interleaving of local variable
> declarations and code.
>
> The coding style "generally" forbids C99 mixed declarations with some
> exceptions to the rule. This rule is not checked by checkpatch.pl and
> naturally there are violations in the source tree.
>
> While contemplating adding another exception, I came to the conclusion
> that the best location for declarations depends on context. Let the
> programmer declare variables where it is best for legibility. Don't try
> to define all possible scenarios/exceptions.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/style.rst | 20 --------------------
>  1 file changed, 20 deletions(-)

I'm withdrawing this patch because it seems many of the other QEMU
maintainers prefer not to have C99 mixed declarations.

Stefan

> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b50079..80c4e4df52 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -199,26 +199,6 @@ Rationale: a consistent (except for functions...) bracing style reduces
>  ambiguity and avoids needless churn when lines are added or removed.
>  Furthermore, it is the QEMU coding style.
>
> -Declarations
> -============
> -
> -Mixed declarations (interleaving statements and declarations within
> -blocks) are generally not allowed; declarations should be at the beginning
> -of blocks. To avoid accidental re-use it is permissible to declare
> -loop variables inside for loops:
> -
> -.. code-block:: c
> -
> -    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
> -        /* do something loopy */
> -    }
> -
> -Every now and then, an exception is made for declarations inside a
> -#ifdef or #ifndef block: if the code looks nicer, such declarations can
> -be placed at the top of the block even if there are statements above.
> -On the other hand, however, it's often best to move that #ifdef/#ifndef
> -block to a separate function altogether.
> -
>  Conditional statements
>  ======================
>
> --
> 2.43.0
>
>

