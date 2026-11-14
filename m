Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CB1606A8B5
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=hgZxi9du
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSIT1-0000bF-Ns; Sat, 14 Nov 2026 13:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xSISz-0000a7-Ux; Sat, 14 Nov 2026 13:27:10 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xSISx-0005lf-As; Sat, 14 Nov 2026 13:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794680822; bh=DgGPT1CkK3c4OsRrghsrGXMC6eDuL94808+mWqrrBmU=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=hgZxi9duMxFeNzPQJeXmHDhQpEl2clTr66AKYEKiAycVNiekrl0rwRRClJwuwmHQV
 V7YiUvzIjyn/RWFoK6+ECy+lKq3Uae9ikJq1Q4M4cv5AOu4E8PraLOHP33FY+67xJz
 j1kaBxAu/YgD3qmi4tBV/1eu2OKYCNJ+/WPUihz+i1yFhUqOE2+tZCG5oTEJxI1Mlx
 BA14PreRzFN7CTBCMbGxvshYMb3E7/cZIwjLIO3UF8j1YzauUdapz2ZxbyOrgaDe3u
 42wkOxvZ1ScPlTk+7bB4gRrjB2zOArA5b/7x0RQSuTzJ2X7Qs44IBszhO0Gi+lKWy9
 q8aRpk5I+86yQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 530831E66E7;
 Sat, 14 Nov 2026 21:27:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 398C545C088;
 Sat, 14 Nov 2026 21:27:02 +0300 (MSK)
Message-ID: <b3079073-8de6-4a4a-af89-256c2a4bf351@tls.msk.ru>
Date: Sat, 14 Nov 2026 21:27:02 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/6] NBD patches through 2026-11-10
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20261113143132.2414774-8-eblake@redhat.com>
Content-Language: en-US, ru-RU
Cc: QEMU Stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261113143132.2414774-8-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 17:30, Eric Blake wrote:
> The following changes since commit 4bcd55a1f4b926ae86872087f7f3bc9f9e1d065e:
> 
>    Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-11-12 21:14:41 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-11-10-v2
> 
> for you to fetch changes up to e682c0e570179bd7fa01ea896358a8cdad196a3b:
> 
>    iotests: Add another nbd-robustness test (2026-11-13 08:02:09 -0600)
> 
> In v2, defer Guillame's patches (the bug was minor, and the unit test
> to verify the bug fix was flaky) to a later date
> 
> ----------------------------------------------------------------
> NBD patches through 2026-11-10
> 
> A few bug fixes:
> - Eric Blake: fix two low-severity CVEs with non-compliant NBD clients
> 
> ----------------------------------------------------------------
> Eric Blake (6):
>        docs: Mention security considerations for NBD
>        iotests: Refactor python NBD server setup
>        nbd/server: Reject rather than assert on non-compliant BLOCK_STATUS
>        iotests: Add new nbd-robustness test
>        nbd/server: Reject rather than assert on non-compliant NBD_OPT_SET_META_CONTEXT
>        iotests: Add another nbd-robustness test
> 
>   docs/system/security.rst                    |  23 ++++
>   nbd/server.c                                |  10 +-
>   tests/qemu-iotests/iotests.py               |  30 ++++
>   tests/qemu-iotests/tests/nbd-multiconn      |  44 ++----
>   tests/qemu-iotests/tests/nbd-robustness     | 205 ++++++++++++++++++++++++++++
>   tests/qemu-iotests/tests/nbd-robustness.out |   5 +
>   6 files changed, 279 insertions(+), 38 deletions(-)
>   create mode 100755 tests/qemu-iotests/tests/nbd-robustness
>   create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out
I'm picking up this whole Pull Request to the stable qemu series, -
besides 2 fixes it includes the tests and the documentation update.

Please let me know if I should not :)

Thanks,

/mjt

