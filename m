Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52574C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 22:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIFJR-0000tr-Ur; Fri, 14 Jun 2024 18:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sIFJG-0000sY-FD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 18:22:16 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sIFJE-0004YG-Ny
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 18:22:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C2DDC61F81;
 Fri, 14 Jun 2024 22:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27A8C3277B;
 Fri, 14 Jun 2024 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718403723;
 bh=8I+zmkJkBIUDb3yoBICBcpojWc33gZ6igykEl7Lg2po=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=PWGkagiDUORmQSk5DAq5pio8+UK1fyuKKKDZ1lzvrht3Q1FP1nML4SzTybgPJ6/Zk
 ZTthBYQm5zVu4fr5Q42QApcbiBrWdO3Y6ZWZnEYGVgGFAT5gIKOzInXvGRNcJBQyG5
 O2Wyo8eOi33YtWz8ZH1q+2XDaxUL3i1s5xMIb+fgJ2xSMBC+xrit2c6MDN6P6z4duk
 OyITgjgxTxjXaycaS83mNuM/ZgxPswwdQXz2krUCzo0deEdEhhJBUpG1F3eXNK7nPV
 e3+EpUxX9THEuM+Ehk3OOPu6DCj26YMhDpVUzQIMnDm7TkUEC6+sawsfpdmkYDaWzA
 78hG5Nz+V/acg==
Date: Fri, 14 Jun 2024 15:22:01 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Richard Henderson <richard.henderson@linaro.org>
cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, 
 stefanha@redhat.com, peter.maydell@linaro.org, Edgar.Iglesias@amd.com
Subject: Re: [PULL 0/5] virtio-grants-v8-tag
In-Reply-To: <e3ab44a4-d5cb-421d-9530-69bf376a928d@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2406141502530.2467361@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
 <e3ab44a4-d5cb-421d-9530-69bf376a928d@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 13 Jun 2024, Richard Henderson wrote:
> On 6/12/24 14:29, Stefano Stabellini wrote:
> > The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> > 
> >    Merge tag 'virtio-grants-v8-tag' into staging (2024-06-09 11:21:55 -0700)
> > 
> > are available in the Git repository at:
> > 
> >    https://gitlab.com/sstabellini/qemu.git  
> > for you to fetch changes up to 6d87a2a311fe4a8363143e6914d000697ea0cd83:
> > 
> >    hw/arm: xen: Enable use of grant mappings (2024-06-09 20:16:14 +0200)
> 
> gpg: Signature made Wed 12 Jun 2024 02:25:34 PM PDT
> gpg:                using RSA key D04E33ABA51F67BA07D30AEA894F8F4870E1AE90
> gpg: Good signature from "Stefano Stabellini <sstabellini@kernel.org>"
> [expired]
> gpg:                 aka "Stefano Stabellini
> <stefano.stabellini@eu.citrix.com>" [expired]
> gpg: Note: This key has expired!
> 
> 
> Have you posted a refreshed key?
> The latest I can find is from 2023-10-19.

The key D04E33ABA51F67BA07D30AEA894F8F4870E1AE90 should expire in 2028.
I did another gpg --send-keys to a couple of keyservers and you should
see the new expiration date now (e.g. try keyserver.ubuntu.com and
keys.openpgp.org).

