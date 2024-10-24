Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB08CE8E7E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yiM-0000AA-W2; Thu, 24 Oct 2024 10:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3yiL-00009r-Vr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:21:26 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3yiK-0006QX-Ds
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:21:25 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb561f273eso9552981fa.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729779683; x=1730384483; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0ddNpKDV5zUgomts8miFnSCnXj9Zn6B0bFSrFbn3114=;
 b=Fnkn0IQcHF5PBl7i8cwWxPopq5vUPDQY50L2tHF1lMyEuAGpUgWErSH4FO35v6G1Fv
 8rpsxP7SpqW6OJX+2+FAHJ5XUwqbyyh6YMTuirJFvinfkt/HXP0pBbWgkOCj21o1Rxu+
 I3BT5AthUVyGZ1iV9xWlu0nMxN4xg3zZRb4rifyP0wZBwqtd7g4VsieLDeq1QkylAUlG
 LlArZWovVwSWMuNgVnm/pJN2+/xa9oqUF37HFHpRp/R0/dY0IqfvQAxgQATsF3nGDmPD
 8lnidruTs1snyiYHZxtqi9hdhqp+h+KQo8mmGbao0E/gcGaTLJLqin8q7XaYPaYaCd8g
 BODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779683; x=1730384483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0ddNpKDV5zUgomts8miFnSCnXj9Zn6B0bFSrFbn3114=;
 b=ZDJEY86r1LBYI6oNNyfHBQ2cu9ReYWLH9isOIvSqZ4r+gLQhJmp3GFwZ4PDCBnR/B+
 nX33XjDbUeRPY+vvRaWvUBljcuu2GWxMF50izN45Auv6gfOq7YEuj8Zj1BkJInI5GRn+
 NB0hLr4axA0eBavSSLTf8Iho+/2fAGAATxYshj/5KHTEwzuFMLf9jXU/e52GE0V7eeuV
 gWOfeMxX5s++B/iRDfPnmJEjhrDhsOamYXQjiPpYSbpli9J7ToRtklyG4kYAcdR2Vr8S
 Ms5kS3dI8m30SqxZbqufbtCwGsUG9OI4pSUkhmuXaPMnSx3wHCGsaj90DP4clkJv4D7P
 3AHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBbdIiZso4Ar0SoW1CulKTvWYy1znAQWMRnXZTvuplzQya+l35No8cYds5+0ghjRC2goErbzONvH0y@nongnu.org
X-Gm-Message-State: AOJu0YxeRU2R0wM2XHuR1Mc1NpC+YvNP3lpBDHDK5edhtVaeoyly6HGK
 Fg0dUsxARrWLhPjDKNqOdWtQqJVpveBhSyS52A7eGZJtp25BkpX3wdWMH8RvufDg6wyL0r8zsQC
 Eeg4DJN0VhISmj7g7oRPohPwKZ6pnR2Zeoc9R7A==
X-Google-Smtp-Source: AGHT+IG4CklBc8CORmkbiGcRVKDPktNldZeWkAzNCHcEhnii/BPFUWxV6QZsvPvhpNKgk6nupVUa91SwQ6XXux+0b4k=
X-Received: by 2002:a2e:b8cd:0:b0:2fb:5f9d:c296 with SMTP id
 38308e7fff4ca-2fc9d33af84mr32477711fa.4.1729779682602; Thu, 24 Oct 2024
 07:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241022164903.282174-1-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2024 15:21:11 +0100
Message-ID: <CAFEAcA-oDF_FU6zH6cDRsYxwh3D_oc4WqJxkCeKw=zi0d2i1ww@mail.gmail.com>
Subject: Re: [PULL 0/9] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Tue, 22 Oct 2024 at 17:51, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:
>
>   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 04bbc3ee52b32ac465547bb40c1f090a1b8f315a:
>
>   raw-format: Fix error message for invalid offset/size (2024-10-22 17:52:49 +0200)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Event throttling for BLOCK_IO_ERROR
> - iotests: Fix backup-discard-source test for XFS
> - Coverity fixes
> - raw-format: Fix error message for invalid offset/size
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

