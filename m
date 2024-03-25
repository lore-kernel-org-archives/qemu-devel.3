Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBF5C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 16:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ronSo-00086R-6c; Mon, 25 Mar 2024 12:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ronSm-00086G-KO
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:46:20 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ronSk-0005Hd-Nx
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:46:20 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513e14b2bd9so5597545e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711385176; x=1711989976; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cTbeXC+mMmpSJbHVNRJQCmToBlbWKcjniuNcm3Tv1Og=;
 b=jYiU+pB5jskZqmGKPObzAuVfd6xqWHUm01p245WsIsTCXK52vBqpZQ3WCr+mD+Uzny
 9c0IC/1MLoXrYibtLoy671TkWEruCnwh4LLjCal8Q8NwNajLqMvXpPkZk9XtiEZKa9kO
 wDaXkf1PQ6LmzLrBX0FWi35OUFM7hgLxgQbbm+1pITKYnxIR0ehcgBhXA9hUYv9PLQYv
 Cuf5z2sDQPUT1tvCNwwr9x8t+E8vAS5hLPT9/JgJvHxZRj2NJL54r9VydGzTblU8MiI1
 qTkrecuB7nyWoNGFJ5ibvzpThAC2MQSKpTJ6WFetqreJtisn4B0dNSDZc/GlAhIFaQht
 ty/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711385176; x=1711989976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cTbeXC+mMmpSJbHVNRJQCmToBlbWKcjniuNcm3Tv1Og=;
 b=G4vGFEN5M8sYDXf6FUzNts37gJmtlbaMX7QLDI5vUcMW3UwCNuAeYxE+G3Gw68oHG7
 zFxdp9k4hYSWOh+Rp0wVY5eqM2m6bFKH3taUSXtQgFmzUc0ntXleUFuFSMPxJ/GSD1jU
 /ETNvZRP6X1YUcKAB05+jp2V5r+KKnebwDFKz8UXTNmjKZlUeM6fnWELe6G/vFC8+wj0
 9GRwhL2DiusXpGlqJdsYUPzcYjLKXT6FHQwDXXWkLA0qXaGcJQdyjpZYSjsEeQzNvDvZ
 Ng/3bcLESJmYrpGoHXQit2pH+txDI4NbOCuQZgsRivt3zIcml2UUqQAXfHEDv0/72Gip
 APEg==
X-Gm-Message-State: AOJu0Yxq9hEb72FbakDwjYDY+qfDTU2icT6czf5JlWGL3SkELrlUKPZU
 GBkuMRbDj0vlCXkVbnXMSTNr2hIjed/TzYQVHGiw08H+DlE2i2KftFz2hSbCA8z7a8zLZcwYe3p
 XbNhLxVyuSqmbkMJgbOkZCySvyMXUWaKuEM12gA==
X-Google-Smtp-Source: AGHT+IG9/GWJFjnzqJQSSD0KjZySKHgfzZfceluVKzJSmNXp+F6owm+kWt0jaH/zCMvfyERiEK9uQUOI92hj4b+DwTY=
X-Received: by 2002:a05:6512:310d:b0:513:e369:cc41 with SMTP id
 n13-20020a056512310d00b00513e369cc41mr298534lfb.49.1711385175995; Mon, 25 Mar
 2024 09:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240322161417.759586-1-peterx@redhat.com>
In-Reply-To: <20240322161417.759586-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 16:46:04 +0000
Message-ID: <CAFEAcA9F68MgAorFt21n0Ys+SaRbo0s5C8a9sk4COk_xQf2=OQ@mail.gmail.com>
Subject: Re: [PULL 0/3] Migration 20240322 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Fri, 22 Mar 2024 at 16:15, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 853546f8128476eefb701d4a55b2781bb3a46faa:
>
>   Merge tag 'pull-loongarch-20240322' of https://gitlab.com/gaosong/qemu into staging (2024-03-22 10:59:57 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240322-pull-request
>
> for you to fetch changes up to 8fa1a21c6edc2bf7de85984944848ab9ac49e937:
>
>   migration/multifd: Fix clearing of mapped-ram zero pages (2024-03-22 12:12:08 -0400)
>
> ----------------------------------------------------------------
> Migration pull for 9.0-rc1
>
> - Fabiano's patch to revert fd: support on mapped-ram
> - Peter's fix on postcopy regression on unnecessary dirty syncs
> - Fabiano's fix on mapped-ram rare corrupt on zero page handling
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

