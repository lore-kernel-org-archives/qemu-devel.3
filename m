Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A63C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1rb-00031X-8h; Tue, 12 Mar 2024 09:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk1rP-0002yg-Op
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:08:04 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk1rL-00050E-TQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:08:01 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d3b93e992aso50297591fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710248876; x=1710853676; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ynOkJk3qf6voyLcRAVcFG39fxJk/EvCvr0otbUA9gG0=;
 b=HONcNfv1nDQnom1ryVey49McPw/imZluqUbcFVD8IvBuLTX7GP3+0lxHep6QvMk0Pi
 28hbQ0VXG9yxFa41+mAlL2/klImM45zVXWiU9JlcCqkuFKVUy8AA7c0k0WtHax5rQx6F
 heddpz9FFfG4JIENEACCH8j7eYwKY/yVu+yL7fis2bqAA38nZ2TI4G44DeTsQ29QVx7T
 qm375lluDbpHnvw/5LBOBz+cTyhMg7HrEQ7gDIoEfYKW4ySNtWlYiRxY8ZQqKQxZFo+k
 6OQhsdZh/h+euSEAFP2JOXg05jGoYhoc+WKjjjWfWJlyWkJmElJJhFK2I8n+H/HNInL3
 IcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710248876; x=1710853676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynOkJk3qf6voyLcRAVcFG39fxJk/EvCvr0otbUA9gG0=;
 b=WeMZydjPKHZqLvkWaQ5TMVUkoZv9S7RNOaDwDOVVNPuxDeYSxecs2dciHwDjkSWeSA
 CcR3QfgnEqOWXNJ1kCUPFxGh8HUg9EgZL5WgibFxIquShdC+Wmg5kYBHLFp8QiIfAgkZ
 Im65R5r4kA+1jNNNsJxCaTDEjLPg0VXtDb4uRtY7otXNV6ZRc7FNznNoniA+ZeHkuo8o
 XeNifr9ypedT3h7P4wskIFyNEIYkFg1dYAR3Gn6J2WLDIQySVrmQXHWadLz9wS/RZZZS
 +/G8gO8f6aZQ2YTTEHHpGsZDSuVenTJVEdzmSAXcmqYtGQx6gUh/aSAxeYCty3siYb/c
 TLog==
X-Gm-Message-State: AOJu0Yw0RLEMYcxVgVnQPealnzeOulidbMe06zCjUY5brlffBUWCzUeo
 aaxcgJPOQhEnNrkju4hoT6psCEib2Mboe3YUQO9S7ALR1qgzt/wwSAwqiZ2jYpgS3fp7VTg4t4h
 TBFMRskydhFV/WcPTuaqQbU8RxT7+EEIeREnKIA==
X-Google-Smtp-Source: AGHT+IFJveOmP3Zz1bL25O/W5YyBh7sM+PEPxNf5D38sg8as0NatWDaHb1nbxeQ3Zlko2TyCK9NJ+vKDREAsC4gHoAU=
X-Received: by 2002:a2e:a98c:0:b0:2d4:3c32:816f with SMTP id
 x12-20020a2ea98c000000b002d43c32816fmr4751062ljq.2.1710248876365; Tue, 12 Mar
 2024 06:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240311215925.40618-1-peterx@redhat.com>
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 13:07:45 +0000
Message-ID: <CAFEAcA8dJWrGAzUDURCGbKRpfkCTXZCvk3aXV7X7QqWR44gqbw@mail.gmail.com>
Subject: Re: [PULL 00/34] Migration 20240311 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Mon, 11 Mar 2024 at 21:59, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240311-pull-request
>
> for you to fetch changes up to 1815338df00fd0a3fe25085564c6966f74c8f43d:
>
>   migration/multifd: Add new migration test cases for legacy zero page checking. (2024-03-11 16:57:09 -0400)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Avihai's fix to allow vmstate iterators to not starve for VFIO
> - Maksim's fix on additional check on precopy load error
> - Fabiano's fix on fdatasync() hang in mapped-ram
> - Jonathan's fix on vring cached access over MMIO regions
> - Cedric's cleanup patches 1-4 out of his error report series
> - Yu's fix for RDMA migration (which used to be broken even for 8.2)
> - Anthony's small cleanup/fix on err message
> - Steve's patches on privatize migration.h
> - Xiang's patchset to enable zero page detections in multifd threads
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

