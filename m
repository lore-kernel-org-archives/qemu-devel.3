Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84316C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdCE-0004un-Nq; Thu, 30 May 2024 06:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCdCC-0004tz-SH
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:39:44 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCdCB-0002Js-DQ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:39:44 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-578626375ffso806275a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717065581; x=1717670381; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GpYc0ngpw2vITUnshkpnN6xzSG1f6EGhFjwdwAso4RU=;
 b=Mlx+Wnttf/xtAgGDEyaI0ekBLalTH6Cw/+F9XURzZykrCYJjWTbKn2UHw9ft+k9PMH
 jjefGm88uFLBRaTOdbYflxdxYHm3M+Gl0Q2wA9R7d0H/v7U8rx/ZL3gpyXND/L6xihzd
 tKLWXCPVyrRivxq6XfPokV9Xqc+UwFOJukbu3lMg7qql3g/40lStB8NVqF3mGBapNXBg
 9OCA8fQkUJIpafbAodoNR1FfUFKzFuJZnfT/xrC9vuXsLg+gwZC+A8gLBM01Qjh7Fp5s
 9RrmrUi9clpSifqtUqBMCKv2MehB7ZGkNq+lsUgMf/BU8jdNllOcCgxl/yxiwBbnKPxQ
 nJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717065581; x=1717670381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GpYc0ngpw2vITUnshkpnN6xzSG1f6EGhFjwdwAso4RU=;
 b=XdBZYXgKhQ/l4bb8WIWl+5WzsekOR/oseSOjNQeq2ucG0RiGIa4Pjy2QTnqBa3VsOr
 SErICwlOGyX60l7H6klouvl9Wl4SqgC1djlnhSVUbpgpyuEgxkKhDf0G3ZYyq0gqQ+yx
 e+KQAoXX3yumLgjA1F0PaKSe7WsYkMNm5neiCI8Yt7kY0aoWiV/wnMjKuFfy5LvsbmT3
 qGin8XAWduiPA9ze8dtF/qz/TTm/QIvv4OwMQ73A7b6ApmpH4eogpnADV4PWsiGFLJbr
 ngcsgF55HEnYCpcH3IAf16d1XOKWfyqY/cHDlRxMeR40kZynHIB9d6+caSWIxJruxzpf
 MqYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQOhSQP0olF3ednOvBf/O7bvD129/cDxS52A5OetQ2qzeOVLC3Lql29Vb4qSegLGMBpi9hcjH/T/0xICE/JWKj0m1KJGw=
X-Gm-Message-State: AOJu0YwwCGTEoLxOutkByxAA33Pmpyn4vJHhK8EghxcqlXogDizHpwuC
 o4yw25QVd0GziKyBnBtftDmnzSlskUH41NM9ojV1u6tDjwWbHkj7djZwhVMNAElzulREPmS7W6R
 rmDuV+IDIAPlox6EyXHPshh0okS6XThURw6yymg==
X-Google-Smtp-Source: AGHT+IHrA5PX+EvtOfPXvQQrlwjubOp7jSjUpRnpAAcvRxv1iFMiyuYJ3jw1sYQ1Tvh2hJMHPRxhwpqDdkjAreoglIM=
X-Received: by 2002:a50:8e42:0:b0:57a:2417:5ee9 with SMTP id
 4fb4d7f45d1cf-57a24175f84mr702356a12.26.1717065581494; Thu, 30 May 2024
 03:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240528084840.194538-1-lulu@redhat.com>
In-Reply-To: <20240528084840.194538-1-lulu@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 11:39:30 +0100
Message-ID: <CAFEAcA_c2Oxvug7+BYu_iTTs97V7pqsDEtEjikdN_R7_xm6s2g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-pci: Fix the failure process in
 kvm_virtio_pci_vector_use_one()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 28 May 2024 at 09:48, Cindy Lu <lulu@redhat.com> wrote:
>
> In function kvm_virtio_pci_vector_use_one(), the function will only use
> the irqfd/vector for itself. Therefore, in the undo label, the failing
> process is incorrect.
> To fix this, we can just remove this label.
>
> Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Reported by Coverity: CID 1468940, 1543938.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

