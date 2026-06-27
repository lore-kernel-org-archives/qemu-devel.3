Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6193C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdJlY-00052B-1y; Fri, 26 Jun 2026 23:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1wdJlW-00051m-Bg; Fri, 26 Jun 2026 23:31:34 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konstantin@linuxfoundation.org>)
 id 1wdJlU-0004v0-IZ; Fri, 26 Jun 2026 23:31:34 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FCC84191A;
 Sat, 27 Jun 2026 03:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41301F000E9;
 Sat, 27 Jun 2026 03:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531090;
 bh=LKpAve4RF1AThYaIj70am/yYEuuIA1/C+IqH2KsO6jM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LQJClF9I57M7Je5xaoh4QeFa86Qje9jk2qQws8W0TT86xdPbzK8Q2Rq0yfmCoTm+l
 zCywqLFX7jciRu/OqLuJtwqNhiPAhBQbsfN1yMebWstLeX30+dUPc7kTPYkFasuZnf
 HyJ/CL9a6PdhgUgEzawZsXOmUnQpGjjbIGCuF+L0tqJu5hAHtYf9FdcVd1Q64vxmXg
 g6GhSqsmXDtTSHriv21aPWjy2MmRjl5ORCPdsooSY3L77YAZBvGP+DfPVFOfMHeNHB
 D9gzueTY/KBuA9PZ7reaOYMhBi367xdOsuXpesdFP2uCpuSI3TEurZf7ksEm/drb8K
 55T5Mru1cIW1A==
Date: Fri, 26 Jun 2026 23:31:28 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
Message-ID: <20260626-mustard-beluga-of-perspective-8dbebe@lemur>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
 <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
 <9d2737e3-34f0-4f68-813b-37059615bced@oss.qualcomm.com>
 <CAFEAcA8660BZOmX_KXeF7JJaJwgKO3zSRDEmJURg27FK=tqbZg@mail.gmail.com>
 <df4a5857-ec4f-4d4f-bc08-1a9c5caae100@oss.qualcomm.com>
 <0f2205d0-06b5-40ad-9952-e18a6a951078@oss.qualcomm.com>
 <fe77f7a1-1a31-457c-9dec-e1b49cd35371@oss.qualcomm.com>
 <d83a2e21-403f-4146-b129-4d9ee264282a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d83a2e21-403f-4146-b129-4d9ee264282a@oss.qualcomm.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=konstantin@linuxfoundation.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 23, 2026 at 12:16:56PM -0700, Pierrick Bouvier wrote:
> Based-on: is a QEMU specific tag, that is only understood by patchew,
> and no other tool to my knowledge.
> b4 has base_commit, which allows to give a specific base, but not a
> specific repository. I'm not aware of any b4 tag that allows to mention
> a base series. It makes sense, series are not branches, and stacking
> them comes with a lot of problems.
> 
> So it seems like email workflow is quite limited in this regard, and the
> only way to deal with it properly is to wait for base patches to be
> merged, or include them in the series.

You *can* specify dependencies with a b4-managed branch, via --edit-deps.
However, both the contributor and the maintainer have to use b4 to retrieve
and apply patches for it to really work.

If the maintainer retrieves the series using "b4 shazam <msgid>" then, if the
series specifies prerequisites, they will all be retrieved and applied.

See https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-with-series-dependencies

It remains marked as "experimental" simply because not enough people use it
and therefore there are still many corner-case bugs that exist and just
haven't been properly discovered.

HTH!

-K

