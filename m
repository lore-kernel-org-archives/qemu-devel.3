Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA702C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 19:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVGeP-0004SX-EW; Wed, 31 Jan 2024 14:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVGeM-0004S3-UP
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:53:34 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVGeI-0001ZZ-5P
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:53:34 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55a9008c185so175793a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 11:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706730807; x=1707335607; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3VF6lpaPU53G4kmZGCqLdquJ0utRnyKLn4SAedfQvnE=;
 b=I0Z+C3/2UDH+sR9RsrFZ0RkSbqLxBfKN5/1MdhZUd6Cax9n7jCuqHhzlmOizE5WFP5
 gbpz94abjLmRcsDbn5DAoyJKI6d6GognxLYdY6ALFHk1IkZbycxTqyEZcQDbMqDbbNJ9
 ZNFOuZrsH0F2PHNyqjMP+NbV/3uk59/F5jBufkNkzq0aTQRXiUP4DIL26f3t3oqBHl8Z
 TxdkrHxkUiIX7p1QCLHZ2aW9Wj0OzPXrLM5/AdCTMJZj5fpQ+5IukpEvjG6Eblrev3f9
 rSyzkpHBVFJgzLccg8ATdmeG65pQeTPtLYqdH7vo0So1nAeJezmJOG2+3u/PtOGskP58
 bQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706730807; x=1707335607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3VF6lpaPU53G4kmZGCqLdquJ0utRnyKLn4SAedfQvnE=;
 b=jhA9ZxPN3sM3thjl+jcLKXpa7G1K+jd8mAcDjTPKjhOk6OdSFe1LoQYy8JCX3NX7qa
 lzIFwV145l3dKjTwAbZwTSgY4RlE9uX4z0X2lNtcBOVOeoNgoCnPjHhUodJ2xjtmwG99
 TKbXQP4PFcQrP6sEkLfnl7IuUzmTyZKBl1Md5A2pn1oZj36kvMUBUivqE1CVG4IuVEPJ
 yaJVA8649lSKQVQsLnLxxXF0Mx1dKvc4aluAAAt0oAuecCfJpUskL72e5+D1rzQXlZAV
 n61fNE8ZnuqWt5+6HdT6P/Zs/rJJEGGoVQRZIbl6asSrUDMbR/FNvJTl9kOHtw5G1BKE
 MNXw==
X-Gm-Message-State: AOJu0Yx3I4vN7NiS7dpkStq10D3D63DyGDGc/OiuKz5+q2Nu2B7ZGmAv
 QZVIVTnMQI3tSN1mtBBhKZdnOSoxt6VFFbDavj0MjDx9F2O3Azln+rZrPBgcmFMTbId41GDSBBu
 Sd/O8K8dHzsLLEqVMAuxG8ppDCQs3ODPFL43Omg==
X-Google-Smtp-Source: AGHT+IFtCAKEb9RZzwPKY+sQ4OCT0ZVynZMvu4sIE+2L0/5JLySl645tD4owbmmPlW+81sleOJOhBj92OpaHAvOWzBI=
X-Received: by 2002:a05:6402:26ce:b0:55f:992a:6214 with SMTP id
 x14-20020a05640226ce00b0055f992a6214mr1638981edd.4.1706730807510; Wed, 31 Jan
 2024 11:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20240130105856.27178-1-kkostiuk@redhat.com>
In-Reply-To: <20240130105856.27178-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jan 2024 19:52:57 +0000
Message-ID: <CAFEAcA-h8F+WZHp2xTK8_cHZkPPX4pJYEXgiZ1OKTUa6B9Qc3w@mail.gmail.com>
Subject: Re: [PULL 0/4] Misc changes guest agent
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 at 10:59, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
>
> The following changes since commit 11be70677c70fdccd452a3233653949b79e97908:
>
>   Merge tag 'pull-vfio-20240129' of https://github.com/legoater/qemu into staging (2024-01-29 10:53:56 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-01-30
>
> for you to fetch changes up to b3e0f64487a4b937d871ce4ce9c259e02ec02191:
>
>   qga: Solaris has net/if_arp.h and netinet/if_ether.h but not ETHER_ADDR_LEN (2024-01-30 12:14:28 +0200)
>
> ----------------------------------------------------------------
> qga-pull-2024-01-30


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

