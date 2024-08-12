Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C95C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdSFQ-0001Bv-Fl; Mon, 12 Aug 2024 06:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdSFN-00012y-Us
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:25:54 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdSFM-0003Am-1v
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:25:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6117aso1681327a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723458350; x=1724063150; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sm2GIJ2MV1pFWLUHd4aACPU2WYSf1ZB1mCNDbQp1Ubg=;
 b=N7RYbr70ksg0T+HQI3amJDE25qoRPBVqJIHCY6/DdLGrsOPxTrtzHeXzQqhwJGNmbG
 9+FPSOgOp632JJcBAHFehF1CnNczs+A2QJvglsA8wag+58AoVkLnrSfMQCO2cQpRhCo9
 k2/dVnlXtB4/YtM4qlZ7xW9p7WtnDDw0P/ivP4CWf5VYlcYY/+9Mo3iPSxpvwwqk8nCJ
 MduAKsd4uq4l/ZkWijX8KLZJG3Hz7K89cGT5kC+u3F3FYww5ewF5Wnspz964PO0gpn5d
 eo9ZQk6MdmF802bQ1hNowBm1yTkHuPUe/w7F7aidce7KqnFr7UsTE/TArUnmvXM2hYjc
 8pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458350; x=1724063150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sm2GIJ2MV1pFWLUHd4aACPU2WYSf1ZB1mCNDbQp1Ubg=;
 b=mvEp6HDZfSdsBDbsDdk/Un2jG4SlSUQZB+QWrdX7X7I53iSXQeGo1Gy1PhahtYzddD
 j5reBlOJIqEzxn1URe7H0dibPhVytTyaO8zCGYepmM0YIWNWKP0ISyxVCbcvWUtZ19Al
 7I90ZXNwpf06eEK8p7hPgjnA2SMsqeIg49POA9U5LMrtvN0zMwEd5WgG/UZGZLavEuZi
 GpZJo+z4HqQdsX2sELXn6DH7wpodHQd+7GAVKO7wAfOTX6vjPSnYQz6m4ahDKQ7EAWUo
 fW/p0wlHrCfdrsA1oN+xwVWDgWfb403Z2wvXrdvfEop5JeCxKKitURb8eZJSiLagnfED
 nnDw==
X-Gm-Message-State: AOJu0YxZMHTbIebIuxAGduLsm9g4raO77yu6PuLWqy5xt/FWKdnnDSep
 eJ/0BdiEJmnv/aUtSjR7ITjwSXxMdgwTfYK9NTIEERiXntSE82sQjFhlTkEobGuK3Nj4tvxJyqe
 TDjtniQglzQi7cjadrJ5ia9ZfSDidO9BkPyDNyvDfV++14wVT
X-Google-Smtp-Source: AGHT+IFqaVxighkEVXiwJemVMJK4TPs1f22RSFYBt5zDW1v14ViM5FkPfQx/8mdNtFIaKltF1skCvqrcusGBZwyiFTs=
X-Received: by 2002:a05:6402:5246:b0:599:4d01:1fb6 with SMTP id
 4fb4d7f45d1cf-5bd0a53d325mr7757895a12.16.1723458349911; Mon, 12 Aug 2024
 03:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240812072810.5247-1-jasowang@redhat.com>
 <20240812072810.5247-2-jasowang@redhat.com>
In-Reply-To: <20240812072810.5247-2-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 11:25:38 +0100
Message-ID: <CAFEAcA_QBaq_mLTkMW1F-rLhWjPOWbE0bhjbX26237d-JWtQFw@mail.gmail.com>
Subject: Re: [PULL 1/1] net: Fix '-net nic,model=' for non-help arguments
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>, 
 Hans <sungdgdhtryrt@gmail.com>, qemu-stable@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 12 Aug 2024 at 08:29, Jason Wang <jasowang@redhat.com> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Oops, don't *delete* the model option when checking for 'help'.
>
> Fixes: 64f75f57f9d2 ("net: Reinstate '-net nic, model=help' output as documented in man page")
> Reported-by: Hans <sungdgdhtryrt@gmail.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/net.c b/net/net.c
> index 2eb8bc9c0b..fc1125111c 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1737,7 +1737,7 @@ void net_check_clients(void)
>
>  static int net_init_client(void *dummy, QemuOpts *opts, Error **errp)
>  {
> -    const char *model = qemu_opt_get_del(opts, "model");
> +    const char *model = qemu_opt_get(opts, "model");
>
>      if (is_nic_model_help_option(model)) {
>          return 0;

Will this also fix https://gitlab.com/qemu-project/qemu/-/issues/2496 ?

thanks
-- PMM

