Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E222CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 17:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfNhx-000367-Fe; Wed, 28 Feb 2024 12:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfNht-00035I-OM
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:27:03 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfNho-0000zb-SU
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:27:01 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-565a3910f86so26833a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 09:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709141212; x=1709746012; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nMu6mEziTJzS5nsqLZQuNOUmGFWK6fwWXtFp1gfLnrs=;
 b=KSsMJfJsMSKWaNLq4OU7aaS+Lsh2LQqcGkjFbePNTLR/ytew5ObUybyw950rn8dTqf
 RsLCtsrDk3aWjU9lygxmSRWYrozf84O0Zo5M3TLjNTJPnEvw448Nb1VhQUlKS2BVtDat
 T60htsUJHrU5YsUWHn56GiSlaOSuzxUTm/9JMxOafMBYli008HAm1FDMn4Q0+BRcb0bX
 zKTdq/5YFSw+JardTKPo19RXJREP/7RFGLTq/+AOqYzaFlAb+IJk6SCW5+UkRwuqmf5K
 dc5wUxSphoKR/zyjat5mFhvlh57SbSUyje1NA0n9tguO+zJTWCzksqXkfasdtAWZIbhe
 +kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709141212; x=1709746012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nMu6mEziTJzS5nsqLZQuNOUmGFWK6fwWXtFp1gfLnrs=;
 b=umPeXnuvq/GfREEoBIVD5At11Y2KaZD2UpvXx2RpA/iXdZKzjSmc4UoxFtDqOEOcm0
 yVt117UdTSE0MnBKE1Vsd7HnVZ1A0pe7iw9p/GnpsZn1zn5BByfqNYoSOlxgXulVkqVn
 F2Td1axf1cAUIMGBzr0ipMLTPoTykfFML5xobhchTIEGb9TttAekvOe7PQoBidATenK+
 fYGje2gBaDxcc3GGybfIJizSnV/2lpf6d7M/k9v+F+8mo5EGHIoW29o+dJRoOWpjgmvT
 zy4q5+umgL4UfBEQIAaH6Yj6OH1CFY8JNqqyMGXaN7gBFo2dxnko5edX47upEPLEnu/F
 QVUw==
X-Gm-Message-State: AOJu0YzOTykhBYwqZTPbq5GPG4TX2fyf9KxspmTdX+CHfFUe81d2Msso
 9Kf22j/FUiGmuEtYie8caB0DikRTKuChVhArIfCL2zleXSbF1A+f1tA2/R3MN+YA641ssGgKSuD
 VhAAmOFxDkM4yZh+C1G1ZVCoaK04qvLOy64SJAw==
X-Google-Smtp-Source: AGHT+IGDKjwgygxaU+uSx37JKEX/+IziE52f/i8mQR3bwY8c1Bojssfxxkrguo45qSbws7JLu24wGSFr4kCgX2RGiyQ=
X-Received: by 2002:aa7:c349:0:b0:564:3b2e:2a2e with SMTP id
 j9-20020aa7c349000000b005643b2e2a2emr56173edr.9.1709141211853; Wed, 28 Feb
 2024 09:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20240228080646.261365-1-pbonzini@redhat.com>
In-Reply-To: <20240228080646.261365-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2024 17:26:40 +0000
Message-ID: <CAFEAcA__SHnm6K8GS3Ae4nqkTCEAM5owab=80OEYVb3etgVx5Q@mail.gmail.com>
Subject: Re: [PULL 00/10] pc, target/i486 changes for 2024-02-27
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 28 Feb 2024 at 08:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit dd88d696ccecc0f3018568f8e281d3d526041e6f:
>
>   Merge tag 'pull-request-2024-02-23' of https://gitlab.com/thuth/qemu into staging (2024-02-24 16:12:51 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to e7028c36f0e4cb8e357b627eabfe6efee5cb4ed9:
>
>   ide, vl: turn -win2k-hack into a property on IDE devices (2024-02-26 10:17:16 +0100)
>
> ----------------------------------------------------------------
> * target/i386: Fix physical address truncation on 32-bit PAE
> * Remove globals for options -no-fd-bootchk and -win2k-hack


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

