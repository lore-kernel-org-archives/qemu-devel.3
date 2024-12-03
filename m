Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0565FE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIW6O-0004WR-AN; Tue, 03 Dec 2024 11:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW6N-0004Vz-7v
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:50:19 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW6K-0004Da-OD
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:50:18 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so5370926a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733244615; x=1733849415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erMIYvyUXsUyrLA1JyT3yLPz7XcqsX4iWcGuz9Z/unY=;
 b=Op/rvlw5AiYM7dAAILb+2ziRxwclwkX/pwhfF8Vp51LD1HNPR2gFvOMfPaGPsiPZZz
 XY5SsYOdMHub5lGuSk+kN0EZ9SwztsdHEpn+pyvIFnIIPKipEWytqmGuEaoSj/tPNGiO
 7yjkTVdfBQC5nF0swN6R56icFyr6v2vxzcB1YKVqM9E/QdnSe1YtxArWNuZrfmaVTNQB
 wmPcMA0a9mMygLNhTvq7c7yIGeIcySafC83xSMVXSyuYGs4wkF3785gWztsHk+5NEgVx
 w2DgntmUxfT/ojVv5w/0b1QnlAyJXEaf9dWtQpsZ0yju5neehWiOl0BE8bO95yAVmwf9
 y23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733244615; x=1733849415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erMIYvyUXsUyrLA1JyT3yLPz7XcqsX4iWcGuz9Z/unY=;
 b=boaffXLIhI0TFy/mW6rpr7qdTTWamVmOyhwocxGjwSdi9zSdVn+bQGckGCPvwIcIuV
 4sH57whWmINuOFELm+R3ojItnMFdmpumzkHHyyJq+1jcni1la83xNGgik9lj7WCDHzUU
 Zi59bpR/TRKN9jGKb6pNg3nnPE2GhqqPfZ1GsaC7oQyfSV/zlronaT4D7B/aLusvZ0PT
 6XRT97Ng2prmU1m5hUyyEfCadsKMoznv9kNyCvxaagk+zGxKhTU+RlLrSq7gBpJ7Jl2G
 KuIlBMQhpHwu7ybRb2bN8g1bnekgUFmetFBChbFvqAMvTqNN2u5URRZ0AujkTRN0RzBp
 jImA==
X-Gm-Message-State: AOJu0YwvvdN7+1Pxon8Anj+A2faX32ESrLBiF0gWRQ3deteT8kb6qkL5
 0f5rrVExCylOa/DaLfnt7hT5tSRMrgAfU2pWdXmFdTJQKWF3oi6AaH+8arqzsMfLWqZUxdPDCsp
 9BVsa3JJjS1vaEJ+FWs09y7n3BkvAOis2kP2p5A==
X-Gm-Gg: ASbGncvyE1iAfgOH4LNuj4uQrdF/jfTksyDisiolUXVZNxG2pA1aO7aldOsaWf/62wC
 /V5riDkpZ/ScCaZApT8fkrG0mEfnF8SyI
X-Google-Smtp-Source: AGHT+IHGnHgliLJ6395/wnQZf1d5RtB6rguAHj8xVcqqx+c/dLsNKceNz6+r4/QRjriBOOp2ca/pdyMVp51Es5kg2uU=
X-Received: by 2002:a05:6402:4301:b0:5d0:f69f:70c3 with SMTP id
 4fb4d7f45d1cf-5d10cb54bdbmr3202248a12.8.1733244615053; Tue, 03 Dec 2024
 08:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20241203134001.750958-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241203134001.750958-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 16:50:04 +0000
Message-ID: <CAFEAcA8zzycB6VWNknKuB08WcZpcypcP=Ok-qDkj2zBkT8aQrg@mail.gmail.com>
Subject: Re: [PULL 0/2] chardev patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 3 Dec 2024 at 13:40, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit eb22a064455aeebc105cc89bf77f48aa18b529=
38:
>
>   Merge tag 'pull-request-2024-12-02' of https://gitlab.com/thuth/qemu in=
to staging (2024-12-02 16:16:15 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/chr-pull-request
>
> for you to fetch changes up to 3c8ab23fb30328111304cb8eab9bda769d52048f:
>
>   chardev: Remove __-prefixed names (2024-12-03 16:09:19 +0400)
>
> ----------------------------------------------------------------
> chardev patch queue
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

