Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDACCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4158-0004M3-Oz; Wed, 01 Oct 2025 13:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v414u-00045v-CV; Wed, 01 Oct 2025 13:57:25 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v4149-0001HE-Ql; Wed, 01 Oct 2025 13:57:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A09656FC03;
 Wed, 01 Oct 2025 19:56:23 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id EZyKueCsLmtd; Wed,  1 Oct 2025 19:56:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3ED2956F327; Wed, 01 Oct 2025 19:56:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3D07456F320;
 Wed, 01 Oct 2025 19:56:21 +0200 (CEST)
Date: Wed, 1 Oct 2025 19:56:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/7] testing and misc updates (docker, ansible, .git*,
 gitlab)
In-Reply-To: <20251001170947.2769296-1-alex.bennee@linaro.org>
Message-ID: <4188260c-e8ac-9bea-5e05-6cd34c3e986d@eik.bme.hu>
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1694444252-1759341381=:80725"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1694444252-1759341381=:80725
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 1 Oct 2025, Alex Bennée wrote:
> My first set of patches for the development tree. Should be mostly
> self-explanatory. We still need to apply the upstream COPYING patch
> the u-boot-sam460ex code but we should decide if its worth mirroring
> or should we just treat the copy as fully "ours".

Which COPYING patch do you refer to? I have the upstream because when I 
submitted this I was told to do it this way instead of adding the u-boot 
sources to the QEMU tree. It can't be merged with the official u-boot used 
for e500 because it has sam460ex specific patches from the machine vendor 
which only supports this u-boot version. There are some updates from the 
vendor for real machine which I plan to add eventually but it's still 
based on an older u-boot version. With mirroring I can update upstream and 
send one patch to update the binary once it's mirrored, otherwise I'd need 
to send patches for each update and rely on somebody to merge them.

Regards,
BALATON Zoltan

> Hopefully I'll have the new aarch64 runner online by Friday and ready
> for the switchover.
>
> Hopefully I'll also be able to pick up Gustavo's reverse debug test
> fixes by then as well.
>
> Alex.
>
> Alex Bennée (7):
>  .gitpublish: use origin/master as default base
>  .gitmodules: restore qemu-project mirror of u-boot
>  .gitmodules: restore qemu-project mirror of u-boot-sam460ex
>  tests/lcitool: drop 64 bit guests from i686 cross build
>  tests/lcitool: bump custom runner packages to Ubuntu 24.04
>  gitlab: move custom runners to Ubuntu 24.04
>  scripts/ci: use recommended registration command
>
> .gitlab-ci.d/custom-runners.yml               |  6 ++--
> ...4-aarch32.yml => ubuntu-24.04-aarch32.yml} |  8 ++---
> ...4-aarch64.yml => ubuntu-24.04-aarch64.yml} | 32 +++++++++----------
> ...22.04-s390x.yml => ubuntu-24.04-s390x.yml} | 28 ++++++++--------
> .gitmodules                                   |  6 ++--
> .gitpublish                                   | 16 +++++-----
> scripts/ci/setup/gitlab-runner.yml            | 12 ++-----
> scripts/ci/setup/ubuntu/build-environment.yml | 12 +++----
> ...-aarch64.yaml => ubuntu-2404-aarch64.yaml} |  4 ++-
> ...2204-s390x.yaml => ubuntu-2404-s390x.yaml} |  4 ++-
> scripts/ci/setup/vars.yml.template            |  5 +--
> .../dockerfiles/debian-i686-cross.docker      |  2 +-
> tests/lcitool/refresh                         |  6 ++--
> 13 files changed, 69 insertions(+), 72 deletions(-)
> rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch32.yml => ubuntu-24.04-aarch32.yml} (78%)
> rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch64.yml => ubuntu-24.04-aarch64.yml} (89%)
> rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-s390x.yml => ubuntu-24.04-s390x.yml} (88%)
> rename scripts/ci/setup/ubuntu/{ubuntu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} (96%)
> rename scripts/ci/setup/ubuntu/{ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} (96%)
>
>
--3866299591-1694444252-1759341381=:80725--

