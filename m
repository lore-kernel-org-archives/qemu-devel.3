Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B73C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwhxj-0007zB-Ou; Tue, 16 Apr 2024 08:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhxi-0007tK-2U
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:30:58 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhxf-0001Xg-Th
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:30:57 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57009454c83so3673431a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713270653; x=1713875453; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=74hBo5tQWYHUUKJPIbIA4TbuliQqcOU/eiu9phJa+9s=;
 b=EVcHVD/D/bdv121HSNzB3bzqUbwrQgwgquUNdE0sgnVb51/4kuC3/da+jZ1+m/QcxD
 GUeO50OWYCH/GRwtNNjKmaKULYhDA1+lvBwjJMD0KJZEU1MfBFn9EY2xCzW+aU3PF+uf
 CDKKeWhH6pw40gwV2Ry3RrCrtEtsE8V57ZSJCad1LwuOHHXXgWBC1l7+lPi5nkaLwbmp
 mqfmejzBhaeqBblYTK92cHXD5a/j1w+j1p4bFkbMQBR10JxORkNCZsDB8wlsRmUVb29S
 E1rl5ZOkvnehyRUAizw5sHPh2HfT6VJFvx/FtQkjxlcn1hfMvZElbKXL1hPW3KNrThCc
 oCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713270653; x=1713875453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=74hBo5tQWYHUUKJPIbIA4TbuliQqcOU/eiu9phJa+9s=;
 b=HfEqyiXObmbTFHZ4tGku8UT9vNVkQRdm7dqII5bnlOlwPeVsJGVDDz4iynf+zE4DYE
 doDecQHjCzvP/ZStYSGw6nY2rhFAr2IzOYEPL3CFacKkuUrH6UvcJwOzUeB3O8Hv0mcY
 zeH+86F62f/acqzKGzkJzwSM1+vPeOSjDUf5VG4AtVySm1Pb5M2j6tV0TXswvW3PwM94
 d+g0W0lxgwWttF5iHzLfy5ZqdWviM+ZrCeeisaxTPhVYxwdBjrIBFO77ArKKftbwdwfA
 jsUPrlnhIqEn1uZGsu5PWOazcgWs7xZdfCI9e2/NE9uZfukMFtJDr72Is0y/F/kxocnG
 e89w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbitdMGgPmhgcvLllTItm5J4r0/psESQs0N5JmrN/gQCykpsMDJ5VHpYXROfIdPpea0nUAIxv+cTx9oMQMud7VpxIT5Tg=
X-Gm-Message-State: AOJu0YxFvtu5lJSjWuteCsHjrZmp8h+xtByeJrYzMLtnlJlGSnKZCxUq
 GAIOiHwF9m5Rcdo7h1OzKP1/K0PeOD9Eqh3nC1xiG5f3Sxn9VWWpqhmlonoSnMt9s7ebU25htR9
 8EMuyxyD07qCWL2OdpS18aeAI1mQV+cZaAJ8Cfhdjm7mPnxD2
X-Google-Smtp-Source: AGHT+IFyTvmGfbkAEHzEt/qZSTKo2dMHwPXSXVaxpeb4ZIT1VeIlvuplPYyIyBEWXLpiSyQNha8ShxORSFHlriq2dgo=
X-Received: by 2002:a50:d79c:0:b0:56c:3b74:ea4 with SMTP id
 w28-20020a50d79c000000b0056c3b740ea4mr9108857edi.21.1713270653035; Tue, 16
 Apr 2024 05:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240416122919.597819-1-lulu@redhat.com>
In-Reply-To: <20240416122919.597819-1-lulu@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 13:30:42 +0100
Message-ID: <CAFEAcA-PbZd9vjyux_HqDKf9y6PxgBXJ9W21zLheE0hJOrLEFw@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 16 Apr 2024 at 13:29, Cindy Lu <lulu@redhat.com> wrote:
>
> In function kvm_virtio_pci_vector_use_one(), in the undo label,
> the function will get the vector incorrectly while using
> VIRTIO_CONFIG_IRQ_IDX
> To fix this, we remove this label and simplify the failure process
>
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index b138fa127a..565bdb0897 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -892,7 +892,7 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
>      }
>      ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
>      if (ret < 0) {
> -        goto undo;
> +        return ret;
>      }
>      /*
>       * If guest supports masking, set up irqfd now.
> @@ -902,25 +902,12 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
>          ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
>          if (ret < 0) {
>              kvm_virtio_pci_vq_vector_release(proxy, vector);
> -            goto undo;
> +            kvm_virtio_pci_irqfd_release(proxy, n, vector);

Are you sure this is right? The kvm_virtio_pci_irqfd_use()
just failed, so why do we need to call
kvm_virtio_pci_irqfd_release() ?

thanks
-- PMM

