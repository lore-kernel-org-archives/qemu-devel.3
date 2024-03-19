Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFB0C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaPD-00075h-Kz; Tue, 19 Mar 2024 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaP8-0006yQ-CI
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:25:26 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmaP3-0006Ch-Ua
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:25:24 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d23114b19dso68817021fa.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710858320; x=1711463120; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBm4ZLRN5LUdojuR0nWlqBhCP643bCu+gA6N3tStEgA=;
 b=UIVoeWZ2YdSLh7gkmg9KCZ/6xakyL/vURocBMGsh+HJYRKPpRufYvwqLYboGlRIZf/
 ytaUabAGXoMFCOt3S/qcAcyz7JFPiaq+/AyfqG1icKdGmtgMHFPTQJDr/XT8hDyAIEG5
 oY6ExzgZcRUhMYYT2Bg5AuPP0PDYvESk3zBVeHFgmS+nr1Wgr0XwMGJLUQi/mYdGS4oV
 S0+XHxrvx9uAxkr7N9+BCfsZ3CVxaKiMNaz2qyfApNBEU6uOPoama0tZUmvXKwrueKiA
 4wWNPLhLfagUqpRC//bhN1Qiw16oI18B5C2yQPcXwqvCawoYgwJxvYacBui2sjwP4dys
 g2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858320; x=1711463120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBm4ZLRN5LUdojuR0nWlqBhCP643bCu+gA6N3tStEgA=;
 b=Rk3WqUSAenNDXn7xtH65Aeme4GDKehELYEfxLR6udfZ26UdLOTqzUfthCXLFHPAbYp
 BWOtVQ4fVeMiBSXwBapeLVWxP6DLUnzU8nl2dJeu2a1/kcUzOLA6H7QKy9w4JUBJjhxp
 r+fD+XaLDdwOduPGSBM6uMIPt9+IDFnpqKpUGfspeiJKCWjZGp5v2P7tGi7ONT3BVtsG
 WlKeuhf7bYc+8DVXhCHQd2cJjinUfVG8E09WbfMlL/V8PuFvMx6E4yLRmIa4XzgfNPUL
 VZbvOGFuRnzoq5yGa+4ypX2LG5duvwqyjTaxq86hiskxBy71TDHJPrsnYt3i9CAceNJu
 kHlg==
X-Gm-Message-State: AOJu0YzNoePEkl7jKZZnwk7OVyVs2S+9fil1fSL4XW9E3H+nYlZZXSzq
 SoSfsL6lXiyFoVD3wsmdjEvX4ohwC0yt8xCEUI33nyBZf8Lf33FaGlZh/9hpPreQWOKT9/h4npL
 DPYfpREynBQv5vMr/S5qoYEnlpd4X3H5Eks3J3A==
X-Google-Smtp-Source: AGHT+IEhi76qhH6txqO5M1B6yYOjs+S65Xk7LRnQK0ghMRD6vaQNqD9xp5CraR37EwMuy/qLueBWtoUtCJQ6SQGjwUE=
X-Received: by 2002:a2e:8912:0:b0:2d2:2c3e:70e with SMTP id
 d18-20020a2e8912000000b002d22c3e070emr10738620lji.4.1710858320192; Tue, 19
 Mar 2024 07:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1710778506.git.mst@redhat.com>
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 14:25:09 +0000
Message-ID: <CAFEAcA-5ahotZduJTsUndKMyKKvpKKnY_wK_2qzCwnKuNZFHPg@mail.gmail.com>
Subject: Re: [PULL 00/24] virtio,pc,pci: bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Mon, 18 Mar 2024 at 16:15, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:
>
>   Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to bb949df637bdb6136a9acca55a2371fe1721e109:
>
>   smbios: add extra comments to smbios_get_table_legacy() (2024-03-18 08:42:46 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,pci: bugfixes
>
> Some minor fixes plus a big patchset from Igor fixing
> a regression with windows.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

