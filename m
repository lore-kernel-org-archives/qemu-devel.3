Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802BAC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugj66-0006ep-BB; Tue, 29 Jul 2025 08:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ugj5k-0006Pu-QA
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:06:06 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ugj5d-0007dG-Oi
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 08:06:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae0c4945c76so779664266b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790750; x=1754395550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CJv78PlQDkjzfKYZIEUNfbCZ8n5Ob7qF2ryqr4HbFE=;
 b=E7pJOexAKCNqWA5Igvkwx/CJllu/TPQtvXEB1JKQLmjL+Wu3zaidjemq99cPPUyhcu
 INZ17kchKBHEHo4uJFrqRj3QeAySxo5Q7xITiPFCioTojwf58CwFrH7npv8Zi1J/yNA0
 bJqmxuJ2IBZXYA6CJB8IshOnZDJ6YJxaMWipt/qBW17RtNIXdTgyN0JQ63BWuxCHAKjP
 xoeEWHSZ3PiaFuFeo+gDIQVl0aBcq9NP1hPHy52tHXGMSYkO1KPHklhlzStcLRhnedZ7
 Mny2CqqNrBD0oasXzLDEU30mIPULHkfDaUi/pgZ8d/an/WHFvWb9/YRxCXguGlhAQXEV
 1jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790750; x=1754395550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8CJv78PlQDkjzfKYZIEUNfbCZ8n5Ob7qF2ryqr4HbFE=;
 b=gSDqorC0+wBTFm6co6Zh4o5ZEage3U//kB73XoeiZYxRKNSkUsim/+ModjFyB7rzJi
 D/+2RSZDvZPcUE0kX3k8h+cmAzG5TBT/U88F6JSeKdSQF2A75/vynsyabg4XOk3q0Epl
 OP2iuNlYXGXO3MIUXbucEv9Lrvs2d3sRxbDdU6t6K6q1rHLgDhhgOz4MBglU8bAwCXG/
 JkpjWw2CtpNi671HSfgWAgAAevfW8OWd0EXZbbiw0YuRkdkWLXQtpd5Jl32f2nM94Vww
 fnZRSFvlqy3m6C0CrMZ5yninDyYiSaMvPHUojlmyjkCldTqDVax7SNcvrF0jcF25UR64
 FcRg==
X-Gm-Message-State: AOJu0Yz07JvLRyme5WZS98aHAzaedYWzbhPVEgG2RumM2o5cBfZ3VL+Z
 6TmLTM5XnNcL1cp14nHNoKbJuUQQeHYvfzKT9Y4yE0CifRauwjTKvKFYuSNciN7DyTZIA7xviqP
 /YpOslW2C1pKZ3zdu3Mam1lKXA22HfLckgFVS5MVeD8J4BaKCnGiqPpI=
X-Gm-Gg: ASbGncusd4JH01WCMx5oUqOCiSzmYwNd9KR86aouBGxJAhWi230MELyxqoxz35pOvw3
 kN9uMYj7EeMoTxx8D0RuPRu2sutPsiCPv/O9WbcypwhbqbUfnz5ZnF08pogNB1IHfu+DVWQiRPR
 iq6b+Q54YqUe0yKoA0r8eJLvwgAZzxeBfyBzZUz9z8G64PSQnKXEiGEAy/dDmWdBYEM/ZfxuwE2
 1OijQ==
X-Google-Smtp-Source: AGHT+IH2MWuvzd0Y2FR2tgeoIkgbWMB1iihsKCg9g+qhpneMZlWkjjA2SdmH+p7tZSmGZYzTqYBblHX0wWDZ2PHIZSE=
X-Received: by 2002:a17:907:3da5:b0:ae0:d4f2:e001 with SMTP id
 a640c23a62f3a-af619a075c9mr1611442866b.43.1753790749875; Tue, 29 Jul 2025
 05:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250729091642.3513895-1-armbru@redhat.com>
 <20250729091642.3513895-2-armbru@redhat.com>
In-Reply-To: <20250729091642.3513895-2-armbru@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 29 Jul 2025 15:05:23 +0300
X-Gm-Features: Ac12FXzM7b8woo_d-WTI7xzCG0L7q-JNgKhI__qOArDmd-_EFQCtNqBXugXGiU4
Message-ID: <CAAjaMXbf=J+_HnxNhjgQ76YFfz8cHq13XDxS9uk19XeoGBYYiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs/qapi-domain: Fix typos
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

On Tue, Jul 29, 2025 at 12:17=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/devel/qapi-domain.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
> index b71890f660..fe540d1e40 100644
> --- a/docs/devel/qapi-domain.rst
> +++ b/docs/devel/qapi-domain.rst
> @@ -9,7 +9,7 @@ in Sphinx is provided by the QAPI Domain, located in
>  `Python Domain
>  <https://www.sphinx-doc.org/en/master/usage/domains/python.html>`_
>  included with Sphinx, but provides special directives and roles
> -speciically for annotating and documenting QAPI definitions
> +for annotating and documenting QAPI definitions
>  specifically.
>
>  A `Domain
> @@ -101,7 +101,7 @@ without types. The QAPI domain uses this class for fe=
atures, returns,
>  and enum values.
>
>  TypedField:
> -  * Creates a grouped, typed field. Multiple adjacent entres will be
> +  * Creates a grouped, typed field. Multiple adjacent entries will be
>      merged into one section, and the content will form a bulleted list.
>    * *Must* take at least one argument, but supports up to two -
>      nominally, a name and a type.
> --
> 2.49.0
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

