Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED1BC54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmLL-00045t-HU; Wed, 21 May 2025 12:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmLK-00045c-B9; Wed, 21 May 2025 12:30:58 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>)
 id 1uHmLG-0004dk-K1; Wed, 21 May 2025 12:30:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B9AB543568;
 Wed, 21 May 2025 16:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C549C4CEE4;
 Wed, 21 May 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747845049;
 bh=jPZsmNkITI06LFGvRwpv3kF9du7ONQLpqdlQqeI0J58=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bbJZAyHYvUq6zlJ1dLfMFzNNWMqkYFuDzuI35O8KGUIgf5j5QCbrnnseARxXwIwSQ
 0DZMPxFXegHCluranFCV2qu0WNoZieoHEkLENRjJE20R2zPWW/xm7oeEWWUX7l6ueQ
 YYWlHkSWQVzustlyXapKUF5uJnWGTFduBWoYaIrvs4Hq8I2pDHmZ2snqVO0YuIYznV
 TiG/iPYTOoiRKM5h37iNaaaKj2X7HkBmQrCFnMSxGEA55JUHUeo0uFeTd0oz6JjmV5
 YMQHGxUtkDHA3htlv2sqJxeSbiJgnfsKvtB4WXw50JzmDdl0Fv50i5I6ptfv5m40PM
 CgbKWotz0M/bg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 1/3] target/riscv/tcg: restrict satp_mode changes in
 cpu_set_profile
In-Reply-To: <20250520172336.759708-2-dbarboza@ventanamicro.com>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
 <20250520172336.759708-2-dbarboza@ventanamicro.com>
Date: Wed, 21 May 2025 18:30:46 +0200
Message-ID: <877c2aylhl.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=bjorn@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> We're changing 'mmu' to true regardless of whether the profile is
> being enabled or not, and at the same time we're changing satp_mode to
> profile->enabled.
>
> This will promote a situation where we'll set mmu=3Don without a virtual
> memory mode, which is a mistake.
>
> Only touch 'mmu' and satp_mode if the profile is being enabled.
>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Fixes: 55398025e7 ("target/riscv: add satp_mode profile support")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

