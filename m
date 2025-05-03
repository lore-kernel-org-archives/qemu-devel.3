Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B57C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpMv-0004rp-9Z; Tue, 13 May 2025 09:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEpMd-00046r-JG; Tue, 13 May 2025 09:08:08 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEpMX-0003vY-I4; Tue, 13 May 2025 09:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747141673; bh=rCp64CidhJFV1LgqHpcfwxv/ML/FFcIF3dq+8H6iyXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QIGTRXTExXYnBiQX3Aqq278DGAXRrf0LMrYpo1nf2PsO8z5jFBG3MrVY+imxHzR+p
 L1GtM8gCMcMfuwUsdUnIHPX/afwu9XPGHjDJtCoStlTXUQoIPCvrB4OieUOVeR3pFK
 gTTEH4vyGBHQ8Y8w712ZiHFWKbmwKiUhneL0jqgY=
Received: from localhost.localdomain ([117.147.34.74])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 1EC2347F; Tue, 13 May 2025 21:07:44 +0800
X-QQ-mid: xmsmtpt1747141664tawhybrsp
Message-ID: <tencent_C7B266679FCD9E34167410F2A224BE83BB07@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznKzBbCqIyiOz0GDf70mi/Z0P5NudvEPDnY2aiW1dYO9d5D2PcFT
 /dfjTkX5XqzaApP0hLDKZBSEIhpMgbuKGzjJiqlmu/X8FY3G5wHB0yS+bzqNSCbwR5YO2xJ4qnV6
 6+twDjEAz+W4b9Q3PCfzMrXLJl98R7hylhF1gPCD9obLb9iqKb+RtidfqjFDoxmVeUw4wUuWnZkE
 cbmK7Dgxv2dVTibnagQZJc4p6X6Q4QaI9v0sbqOOBeZfnS8ckhXyDnKeUO+ycycqGL81qYRfPY6w
 QDdRlC9X05+IcPrJvdzH3AdxSO1/idPmY7CxIGRECVlndVo/zywBsLHNksAUd+jywC+p6TNpIvrb
 APbTOwOIQYlLWQ5U7+hMnE/fCPHdkvZKmXJn0wt8iTv2rMHCIfLG0Bl2CQERC4JmAAI/we6nKs1n
 53pdevLzY0Glq8HkBAPQz0TON0ZUJjLAv+knp2YOVcvMMDg49QuJOBEevKGz+RJA5i6DjTPKguvb
 tfzzcfccqkf69HYpLpPua/MDS4WniSvgDWtUwo9ZblQpEBDyhamzmEj2ioru2AliDCWGDFR2mfGE
 H5IEz4H0LYA2P+V5niJuK82sUaeOHP4WQVvyZC78jwZxrM3fXJi83NyRONt8TFWF3fUe+GNF6inL
 I6c2TmqE7l050mmIOe0kWWa2iYb6CS57EzUj0hSNFshfVUBWh7M8Jsbfb6qhPwIyjiFSE9xo54z5
 WbPXc1m367Pl9DTCtCfx3l9DiMF1JVLcYOLVNllotW6SzR/gx5KYaCfNX6yE91uv4uAy8EzALe3X
 beCWJDpMNhhJynuxUj1iWmf3Q/YG/d51RGrvxDmmR649ojSaQVdoT3leW5HTncdk4uu2L3QbU80f
 BQyadY2kVr2mrV27QQsTbeD/gc2KCWNG2nzo9s3M0HZ7W6TPuKAilXmrFCr4mbiYm73cgBvj6Mvo
 EzyBmxmfeRI7tYi80s08JtDPHQtzqMtHz5+olGS/4zgQ/Qe9N6H26Y9fL0oLoXDUTgPwJyZWkiD1
 RNx0H534ByZVQUs8taYNrHmihIpuk=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 09/13] mirror: Drop redundant zero_target parameter
Date: Sat,  3 May 2025 08:47:29 +0800
X-OQ-MSGID: <20250503004729.49529-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509204341.3553601-24-eblake@redhat.com>
References: <20250509204341.3553601-24-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.87; envelope-from=sunnyzhyy@qq.com;
 helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: 67
X-Spam_score: 6.7
X-Spam_bar: ++++++
X-Spam_report: (6.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: reject
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

On Fri, May 09, 2025 at 03:40:26PM -0500, Eric Blake wrote:
> The two callers to a mirror job (drive-mirror and blockdev-mirror) set
> zero_target precisely when sync mode == FULL, with the one exception
> that drive-mirror skips zeroing the target if it was newly created and
> reads as zero.  But given the previous patch, that exception is
> equally captured by target_is_zero.  And since we recently updated
> things to pass the sync mode all the way through to
> mirror_dirty_init(), we can now reconstruct the same conditionals
> without the redundant parameter.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> v4: new patch
> ---
>  include/block/block_int-global-state.h |  3 +--
>  block/mirror.c                         | 13 +++++--------
>  blockdev.c                             | 15 ++++-----------
>  tests/unit/test-block-iothread.c       |  2 +-
>  4 files changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Sunny Zhu <sunnyzhyy@qq.com>


