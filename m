Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A9BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weycq-0005Mf-G2; Wed, 01 Jul 2026 13:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1weycj-0005MG-3b; Wed, 01 Jul 2026 13:21:22 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1weych-0003sU-EE; Wed, 01 Jul 2026 13:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=GoYJQ573z0pU5GFeE2XcZCT3+/7TAMDh9TYy5uOxzZc=; b=oZrjUgHUI37qzl3FTXBS27MMzL
 e9hmJ+EtOc39dbBcfyX0qgLucdQ9SMM2+Q16PvhK3OuMZNWGNgqLiQgJYGg2u/Q3HnbD5j5IPv4Ju
 SG7ESceO57x5RPsUefUtD/2sOr4x83SLGRyjWPNJNtc0qHDb2wNatz91VmNxPiucjeD5+cPBKdmSE
 jDHSgVilC+/1HAZmlkfYxywPm99k84L12bHWfPiJbroS3gVqetp8t0vqrAC+X6MWCy6F1YDl8ZNtT
 /SC9AW1h1+EVfUurECqTacd2Fzz73azVO0FFGuHnuaDvDltGsdhLWtlAacsUrTNm9upryQppRMtYR
 osGYnlgCbSGji/4SZqUyYLwfXzYmiBv1q49zSQ+K8NLYV/PNTUUcrBmgQv+XW6wL1ww9FNK9XysrD
 BO0kCYoAg3vqKYykgQD7n+OdUM1rKYJyIZyfFiYtY8oV8ZnIXPjOlw4o26SzDAti8UvPp+eO88+fS
 qgvqSh7FEyb6+fqnP4CM4rwBy4w+KqtInePrRHvmtngYCf9xouKQ7QlKYRK7aD25uLA6F0pjVp2JZ
 FXHCqsjefgIl3aLqU1/9dhjveRp0lQ62s6en1XTZu8FzhY+IX/WnQLYGRHFylDh7Jw15tO+BebG86
 ObV/vxzMc+8uf9PpGhe4hB2bwvV5flohunngLPSiQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Feifan Qian <bea1e@proton.me>, Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PULL 00/23] 9p queue 2026-06-29
Date: Wed, 01 Jul 2026 19:21:13 +0200
Message-ID: <1932698.atdPhlSkOF@weasel>
In-Reply-To: <e825ad7a-a183-48d7-ae5f-1e3c5e30689b@tls.msk.ru>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
 <e825ad7a-a183-48d7-ae5f-1e3c5e30689b@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Wednesday, 1 July 2026 12:15:23 CEST Michael Tokarev wrote:
[...]
> Thank you for this work!

Hi Michael,

> FWIW, I've applied this to 11.0.x and 10.0.x.  For the latter, I also
> picked up the following two commits which are simple refactoring:
> 
> commit c84ebaa6b2cf9a27fc051b4692a42350adf6358e
> Author: Greg Kurz <groug@kaod.org>
> Date:   Wed Mar 12 16:29:28 2025 +0100
> 
>      9pfs: Don't use file descriptors in core code

That's actually f2bb367d2b265c6c0ead1e0d4a8f7c43310b3107

> commit 29070a13e7c131448ff35c90c70ff42e2989d420
> Author: Greg Kurz <groug@kaod.org>
> Date:   Wed Mar 12 16:29:27 2025 +0100
> 
>      9pfs: local : Introduce local_fid_fd() helper

And that's 4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e

Both are safe to be picked and required for the patches in this PR.

> What do you think, for older 7.2.x series, which was an LTS but now
> security-only support, which of the above should be picked up?
> I mean, which are the most important ones here?

Good question. It depends on what the exact policy on the reduced support
level means (for 7.2.x). I mean these are essentially all security related
patches, but with different impact:

- All issues in this PR require full root control over guest. They are not 
  possible exploits by regular guest users (so low to medium severity).

- Patch 8 prevents a potential DoS combined with unlimited host memory 
  allocation / exhaustion.

- Patch 9 also prevents a potential unlimited host memory allocation / 
  exhaustion, however that's a bit tricky to pick alone, as it introduces a 
  hard coded limit on the max. amount of open xattrs to client, a limit which 
  did not exist before at all. The limit is chosen high enough to 
  theoretically not cause issues, but you'll never know what happens in 
  guest's user space, therefore patch 10 introduced a configurable option for 
  this limit, which OTOH is odd to be back-ported to such old stable branches.

- Patches 21 .. 23 merely fix a rather theoretical issue. I have not 
  identified a way for a exploit on this issue. So probably can be omitted.

- Most of the other patches are test cases for guarding these fixed issues. No 
  idea if you usually pick tests up or not. They are useful though to verify 
  whether they fix the issues as intended. Note though that they are 
  registered as "slow" tests, which do not run by default, e.g.:

  cd build
  tests/qtest/qos-test -m slow

Also note that Pierrick reported that some of the tests introduced by this PR
failed at their end. I couldn't reproduce so far, it might be a false
positive, minor issue with the test environment, in worst case I still have to
fix something on the core patches. So keep an eye on that, please:

https://lore.kernel.org/qemu-devel/53159abf-ae84-465a-ac70-8ad71fa6c045@oss.qualcomm.com/

/Christian




