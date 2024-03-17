Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CDEC54E68
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 20:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlxHW-00077j-Q2; Sun, 17 Mar 2024 16:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rlxHT-00075o-Ra
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:38:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rlxHS-00087D-AG
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 16:38:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4140efa16caso2852175e9.0
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710707932; x=1711312732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tLK6FJu9XnfNBenMVgFM4irD6sMjkIZ10X3kqRT8bA=;
 b=o1yTwqA0h/R9/YQJvQq5T6wh6LEntDVZ7Pb3sPgTONjncr5jdIv7Pw/HXJeXYqx7Zy
 S4Cn6MdFV4PCNIjtUxmWWpDxpM+ani5CbfGE1iAvpoqUZkyiGLlXdD68Sz0p4ktIyWBs
 YEsGQOnq+xXINdJFAfCW3hWVKQkWjL3rR48lZ0gKE90l+rJbPvxlh6tQguOQFrCV6RvF
 ykAWUx1RbtQxTXqM5ehhudcKQPwuVBYKlJxQCNIgypon7er34crJSPQ7G76pnQJABziT
 fAnnvBww0GufloSVvcgvC5SRMfHJhOpw+oHcarB+AC0lnXF4GEG6Nw22ZCP4ZzfoSZa4
 sSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710707932; x=1711312732;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4tLK6FJu9XnfNBenMVgFM4irD6sMjkIZ10X3kqRT8bA=;
 b=kXcK91ujbZisHRZdAuRDetBv/wafajIh2qGmTDE562DWrE/1WaBekuC+0Dov2o93eo
 S3XbtnGE3zTi3JQ2OYjzLo4qPl5ts2ZGvkoC+olESxKYqsFTfpFtpc54nXRIgK36Z/tj
 H2bXE18XgvD6uW48hUuOLFUJkE2HQuL7H0av7EKdCjKTBwW3aAXEDbh24pDUltvUf0Ln
 SnQIf2VVS2U6qLEa8Tn0CVq1D9teBfvU+kBjUhvO+Y1vfYC2BEYeAauJpRwHEIMhvrw5
 VlaNBY5aYHLmpxXq8vpFyfFR2VzztK6uAiFgCAPc10ORLEcCD+XRnVdFzhaZDPskkfmc
 Lxow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPMu4FZ5QWPdtu7YQr4QFWdDPpB9ApIpIDd4NWO/vaZyAkfUeKJIr4MYD1FqycgTMCgLDrmpdMj+zVrumebxhRTrUwpZA=
X-Gm-Message-State: AOJu0Yxx/U/eDIUrIN0jaIOnu6JH8+0QezhLoj5KKVAHGOSsKR+E9YLC
 ahAeTwfRXulcKghs9vw16GsS5hlQ2zHINsY1XI6KIDZRY6OisRqiBtfNWjp5yW2CbGFn9FjJd8g
 g
X-Google-Smtp-Source: AGHT+IHuRttkncVO+UtIk+N4TXSeEv6pf90Sgg0z8c0kj82qrE/OW2Y2gzUflFS/GRY4KbS28MR64w==
X-Received: by 2002:a05:600c:1c84:b0:413:ff10:cee with SMTP id
 k4-20020a05600c1c8400b00413ff100ceemr6122493wms.13.1710707930984; 
 Sun, 17 Mar 2024 13:38:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c191300b00414055f20a9sm6760289wmq.26.2024.03.17.13.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 13:38:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25A325F885;
 Sun, 17 Mar 2024 20:38:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user: replace calloc() with g_new0()
In-Reply-To: <20240317171747.1642207-1-phind.uet@gmail.com> (Nguyen Dinh Phi's
 message of "Mon, 18 Mar 2024 01:17:47 +0800")
References: <20240317171747.1642207-1-phind.uet@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.2
Date: Sun, 17 Mar 2024 20:38:50 +0000
Message-ID: <87sf0or3tx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Nguyen Dinh Phi <phind.uet@gmail.com> writes:

> Use glib allocation as recommended by the coding convention
>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  linux-user/main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 9277df2e9d..149e35432e 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -928,11 +928,7 @@ int main(int argc, char **argv, char **envp)
>       * Prepare copy of argv vector for target.
>       */
>      target_argc =3D argc - optind;
> -    target_argv =3D calloc(target_argc + 1, sizeof (char *));
> -    if (target_argv =3D=3D NULL) {
> -        (void) fprintf(stderr, "Unable to allocate memory for target_arg=
v\n");
> -        exit(EXIT_FAILURE);
> -    }
> +    target_argv =3D g_new0(char *, target_argc + 1);

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

