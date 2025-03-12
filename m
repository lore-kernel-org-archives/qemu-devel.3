Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3532C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNYs-0006rE-59; Wed, 12 Mar 2025 10:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNYl-0006qc-H0
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:59:54 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNYa-0006U8-7z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:59:51 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-476a720e806so13267051cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741791573; x=1742396373; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7AwENeVv0I8y2TSpE5n+n0G9tTTO3yGcDWhy5ls1Sww=;
 b=K8ulZRA8Br35yRusUAmboTNXp5731ymRa1D7/rTPx9tg2iCOtWtC2mldND0OeObiA0
 4QXDDGDeIApOTZrUq2BZ/lhwehGyrQLOfm/e4EuGpO33hfwumbdO17R2QGliIo7zD9sd
 pCefJ33vyO4TJ3uKYaBaz3pFAiALpcKb4SAniiEwveepOs4kHgz3fpTE++p6qnJBR8b4
 3xlaN7yQ/7ycTgi3sBaZnHEw/XtYZ5Rmi3bv+h6Qb86L/anuks3M7UrFQFntf7PyIyYP
 icGcEKtT+/5hydg+2eii+eKUdK0bPRZE/+E/8xdK2agX1VXCtl1P1/6jl79YXMAsL4HX
 SZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741791573; x=1742396373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7AwENeVv0I8y2TSpE5n+n0G9tTTO3yGcDWhy5ls1Sww=;
 b=fIPj0arhg6F3/7OR1aUTSR0LQ2m04q2P0lt5vD08I9WedIZtjh7OJQ3SQPFuDG6OuA
 299yVmZIzaRwU6krX1FvdB4xs+Gl66BTIAnfxINwCOzek1geQ86lrxt46Ita6GJi0Bgi
 4SVWpEo7gXTVpIpJV8hE89yrxAmCDNrMbIjKh2oipjQrBDjy5yQXhRVPn3A6wFqX6je5
 eVzj8zLDs7AGGP6CXapux/TS8kOOLdPAgWqI5K7t2OS7IwUXpHfflJdJKMQq5Cq8PlPG
 6SGf0CWs8xfOvmHYsqiVsKFdXjhrDyYLbnpvea2JGyxBwkXBNR/towqIIMcFGayvqdFV
 tMwA==
X-Gm-Message-State: AOJu0Yz9c4Wc1IT+sYdaGA9sCfddXfmvoU73OaFh7KovFCfOUF4xbS0y
 CISiPrBXK8U2ptLU9ekIT4hvVvyRFsg+k7NhgZUfiaL8VJUQXsSlPVwOGdIN1uFxvdM/GT0Xcp7
 8lusLVb7iVduMwmCWV8++gTCo+Zeatz9oZs+h9phsGs4q9EJV
X-Gm-Gg: ASbGnctsSrxvNc8SePEL6yAnx/02aISXIEvlXtUE0xhjbhlCqZatlwZvrIFuLuIF75z
 hMQ1T9UEdevEMXH59oxQFmzn1QJQRL4Fxb6q6MnddSONycwLRkAG86ijsGDiSulbNcdTJPW8eDP
 jklHdkQlwpIFy+RcvPQfIpFUQdkvA=
X-Google-Smtp-Source: AGHT+IEO9YPpS5s3Bb+hYO1dwFTwGfYHFii0HdVFcPbdrKJyhzHFma/pZU9k3dxq1ZlTZi0YiRsYkR7naFUgj5GuBmU=
X-Received: by 2002:a05:6902:4886:b0:e58:cbe:75a1 with SMTP id
 3f1490d57ef6-e63b5158785mr9634412276.4.1741791052153; Wed, 12 Mar 2025
 07:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250312143504.1659061-1-armbru@redhat.com>
In-Reply-To: <20250312143504.1659061-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 14:50:41 +0000
X-Gm-Features: AQ5f1Jr-6gjitrew8PIxelZh0oGgPDcDU9q27urSvGaBkeYxm6ITxFBaNVvriR0
Message-ID: <CAFEAcA9NLE3+AXkWFhRRyAKXpPiwL+2zK+ATx=K85BNoqEwCRw@mail.gmail.com>
Subject: Re: [PATCH] error: Strip trailing '\n' from an error string argument
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, gaosong@loongson.cn, 
 vladislav.yaroshchuk@jetbrains.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=peter.maydell@linaro.org; helo=mail-qt1-x82f.google.com
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

On Wed, 12 Mar 2025 at 14:35, Markus Armbruster <armbru@redhat.com> wrote:
>
> Tracked down with scripts/coccinelle/err-bad-newline.cocci.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  net/vmnet-common.m | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/vmnet-common.m b/net/vmnet-common.m
> index 54d900ba67..ab33ce2b0c 100644
> --- a/net/vmnet-common.m
> +++ b/net/vmnet-common.m
> @@ -94,7 +94,7 @@ ssize_t vmnet_receive_common(NetClientState *nc,
>
>      if_status = vmnet_write(s->vmnet_if, &packet, &pkt_cnt);
>      if (if_status != VMNET_SUCCESS) {
> -        error_report("vmnet: write error: %s\n",
> +        error_report("vmnet: write error: %s",
>                       vmnet_status_map_str(if_status));
>          return -1;
>      }
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

