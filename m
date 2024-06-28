Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B152C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCpI-0001cD-PY; Fri, 28 Jun 2024 10:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCpH-0001c5-Aw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:43:47 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCpD-0008Bq-Dj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:43:46 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6fe7a0cb58so35029866b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719585822; x=1720190622; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q5kkp9Ko6ZNcq0+Spd9RzS8aaAAfUlw3qjDLQ2OSKm4=;
 b=iQYJIQJPHe1RQrh8WYBs0RoU+k9tqT1Ti0cgc6umsxgSCGse7fkAA5MpAoYk09AYqi
 CEJBM7TCBeTsBOcoZLnEBiBi4p37u6bHR6WXEgvV7yMdNHKqpXpQ3TexKF14GA7uSg9p
 kTeEaUk1hiwIKt8vh36rMjUhgm92YQreFcQYvRw+tl4AIlDih3ZH6TPES43IN/vVHosL
 N207BSyjGkAm18roa5nN8x6FeFQ5KdtPB9beXIFlvd6i/hDGj4qVylx2PyVlMyHKMopD
 Ke+L7JfpCcMRcu6WUQMTQUY4/SyLvRydGGID5PNxNUYtIDme1sbg9nKOYDU2Hv7ccPYX
 O+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719585822; x=1720190622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5kkp9Ko6ZNcq0+Spd9RzS8aaAAfUlw3qjDLQ2OSKm4=;
 b=GdofU0o7ze7BBZlalw6PJdTJNEcDwa970hBSZBVTmCc5Ob6TyEOhlR3TZmwWfnZDhv
 y4TpZs3KqUTao9nNKbInQDrfQMR2rLASfAgiye3e2eKxYx+MsBm2jJGERkKlLv2qwykK
 MlL0nfqL4oZxjsRfgQN9FchDmKxEAcQcWTes4SnDjwdl0+988oPxrq8VRK+tGvyGDOkM
 xZ/OaxCFjZ1nYBCNzqfM6JXEaD2S2hlVKaVW8jMe/2eeLwHtw/fQYeAsUR+I93KUKyx9
 wC9Q+4BEpuSKQvU+mrupQtjQ37SX71Iu/mtTTFGqkE0eii287BNBeKD8kwrnBoQFFvIg
 7GRg==
X-Gm-Message-State: AOJu0Yxe8S8Yum7tinftUDCUh3GryGjGG875B2CkaVRtBUMTv5DCPCM/
 i8ukzWyuFtORZOrOgYKlcsSU8vWSwW+W3AKLsNZozLZyiyGDXWpx36kiHKH4DFuyD6XKz5ySDn5
 DMWdwXeGrBUCv8t8s9KBvVWc2JaAFhJ+t2nloDBdQ+c51IIgy
X-Google-Smtp-Source: AGHT+IHWiPXQKo3q4vwwc/ep8Kmx9+/urxljFl9V/hZhoSzUU0eXyw6833Hah9JC2YI9rary5ewvrRQWjpeVihCfIWE=
X-Received: by 2002:a50:d653:0:b0:57d:3b8:85e6 with SMTP id
 4fb4d7f45d1cf-57d4bddfba2mr14062484a12.39.1719585821767; Fri, 28 Jun 2024
 07:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240626211623.3510701-1-venture@google.com>
In-Reply-To: <20240626211623.3510701-1-venture@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 15:43:31 +0100
Message-ID: <CAFEAcA_0Q8YN3juTCXPJL0C7YxiqyiWhS2XDEnTpd-U9kG092A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my family name
To: Patrick Leis <venture@google.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Wed, 26 Jun 2024 at 22:16, Patrick Leis <venture@google.com> wrote:
>
> Signed-off-by: Patrick Leis <venture@google.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19f67dc5d2..13255d4a3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2496,7 +2496,7 @@ F: hw/net/tulip.c
>  F: hw/net/tulip.h
>
>  pca954x
> -M: Patrick Venture <venture@google.com>
> +M: Patrick Leis <venture@google.com>
>  S: Maintained
>  F: hw/i2c/i2c_mux_pca954x.c
>  F: include/hw/i2c/i2c_mux_pca954x.h
> --
> 2.45.2.741.gdbec12cfda-goog


Applied to target-arm.next (since I'm doing a pullreq anyway), thanks.

-- PMM

