Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017FCC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQGd-0006NM-SH; Wed, 13 Mar 2024 11:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkQGK-0005ii-By
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:11:30 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkQG8-0006ix-GY
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:11:24 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d28387db09so76731941fa.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710342671; x=1710947471; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pcuf9ExumrJw+NY8zgL95k/yxfqZ38jP6HeYvh0wAKY=;
 b=JqBUsRflzyjBbnlKCPWkHk1wakqBm02mfrtAcQufJ0JcEWImVJCxnAYiPZ2tFIvVQe
 qD2yJzJHwWKlighYuBDz9OBHtb+SfEZqlg2THaJ/vOnFhGDLIsHQ7wTBQj3oI2J43g/Z
 Sx58fnjZa8xd6qaopK5EQ+Trso3A8bAR1w0hMkqeqm0TIrVdrb/QUpsAb2sbwCWSnVc3
 AJIP2KRpGvSOpwKG6Bq9P75gnb4qg4tHrGs8Wp5iPI1jAVhHEIOGhUKa0BHLOkXrKR3T
 frkCXkqsYcLbOKy1k26tIrfBOxF6fdUtm7LI8fkCa4JvR0In9RnTitUB+MCHNSjxdmlT
 Mpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710342671; x=1710947471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pcuf9ExumrJw+NY8zgL95k/yxfqZ38jP6HeYvh0wAKY=;
 b=m38qJpE4xFrzaad30xzQdToLdAdjFbdHJ4IlekroJmuTjOSR+DOiVvDNZiqrzXGGJb
 AGiW89s0ZrC9JmwjFgPEVtqhxHdgYFENWv5M9kmT7pg4s2Vy9o7uWgZq4GDE9SbOiwmp
 TN0zkGjEgTJPEoZGseBJkvlOJlmncZooYguQjbLvUMn3CzmE3aJnNGrQ2T1hKP0+Y5qz
 MNxFM9v+fi8WZlTgLaDSDN8Xn8hs7mL5EbEoeV6sEbfaW0zijo7GROHeeN74Ga83oL8Y
 9BN7HTEilcbEbubvfb14PD3kk67v1bBciS4jkDskQxiWx2ArxjnK9iB/df9w1KfYCLKY
 jCNA==
X-Gm-Message-State: AOJu0Yz+RsQq5nPhopwWKlyT6U4RZfmWGJu3CZcjPu+lYO0J8GUOUlT/
 GPSYEisAH4vzMVCO5lpNWXgOXCTBpUS9XNKMWVVUnOeHu0WmiFlJJ5j3pvd5BUHLAbqcIvcQDMh
 /rIiVPQOrx4t5jF2Jr8FrPb2YvscTtkUK6FcrQA==
X-Google-Smtp-Source: AGHT+IHVSV9AaflNPIKnXkwz3dAo5Qzv+l0Yx+tjBUSHsRLrhYwme4Oeqh7VPVVpTMc1CqNLI/aKLvhXq7Y7l/VY7Sc=
X-Received: by 2002:a2e:b889:0:b0:2d2:e2b1:4488 with SMTP id
 r9-20020a2eb889000000b002d2e2b14488mr10121095ljp.22.1710342670895; Wed, 13
 Mar 2024 08:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240312165851.2240242-1-npiggin@gmail.com>
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 15:10:59 +0000
Message-ID: <CAFEAcA-XDaVY_0RSy48rdC6Co_B6d0dE2afJi2_fgbdV-O8Y3Q@mail.gmail.com>
Subject: Re: [PULL 00/38] ppc-for-9.0-2 queue
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Tue, 12 Mar 2024 at 16:59, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The following changes since commit 35ac6831d98e18e2c78c85c93e3a6ca1f1ae3e58:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-03-12 13:42:57 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-2-20240313
>
> for you to fetch changes up to e1617b845104032f0aaad9b91dcda56c7c437998:
>
>   spapr: nested: Introduce cap-nested-papr for Nested PAPR API (2024-03-13 02:47:04 +1000)
>
> ----------------------------------------------------------------
> * PAPR nested hypervisor host implementation for spapr TCG
> * excp_helper.c code cleanups and improvements
> * Move more ops to decodetree
> * Deprecate pseries-2.12 machines and P9 and P10 DD1.0 CPUs
> * Document running Linux on AmigaNG
> * Update dt feature advertising POWER CPUs.
> * Add P10 PMU SPRs
> * Improve pnv topology calculation for SMT8 CPUs.
> * Various bug fixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

