Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B367C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpMm-0004Fo-O9; Tue, 13 May 2025 09:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEpMb-0003vp-4O; Tue, 13 May 2025 09:08:05 -0400
Received: from out203-205-221-240.mail.qq.com ([203.205.221.240])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEpMY-0003vo-0Q; Tue, 13 May 2025 09:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747141670; bh=bDSXgadzVi6cTqKnSNOmHF5U2q1vE9hhr9fwYa1c8HQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ATJ1P76vgICQEMRDN2ty4CXRKuziXZmItEJIN9Q8gq6Jo+Is96v+5z2GGkhRPguAH
 7SPSeTu7+LW8NGid98S7UalDwDRdPNWBK/bn2e+2EFDpB+EfAunEcrM7NajvoRFZqP
 JnCOlvWVNET1d8S+C3niyG+NMWAhJBsu2CbcX34s=
Received: from localhost.localdomain ([117.147.34.74])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 6594E98; Tue, 13 May 2025 21:01:37 +0800
X-QQ-mid: xmsmtpt1747141297tlmhnc3x5
Message-ID: <tencent_27B26167A5CD8BB469F408728C24B1839707@qq.com>
X-QQ-XMAILINFO: MeRnHSrEJzCruhXFZLV0u6YEJm5XecREYbza6BU53gM9uz3udA11Nn7/rrHLxe
 Gaqy20L20/zZYj569xuLI8lI0sYZ8xiibR1w6kF9BXvmTiTmt5J7XqKnBfDWw7q38Ih6n2EbIv3T
 oemWEAGQqSXSjBSkC2vT2kdhxrBWVRgABfB9lla1d7SVcza51fk8KzYSJ/eTHZB0qrNaPtOGTNYP
 uOGQ4DaPT2+vCK+uy4ZhM703HAxDnIsidzpTxZi1wl4GGJUhfB65HkthNYGiHn8f0TlEQ4tRNDUz
 cYI7fcmhRR/ENA/sq9x51tNDusJRHMuTbiQt9T8lTYPf6bX2qDdraq0r9wfsFQOMXCG2GIUCioNL
 CbHK2ksw3xGEN97WD9BgWmO/vBF3/rHlA4mFMeXY6CDNj//0LUqliZGB1eJ5hP28huUYoBR6b04l
 a6mkQyEnKsDbGvbvswtmIejWTO1k5ogUcOvsR+7CLrLrYeSBAAKELbcX/SqaDWn5xq2eSJG7QLWu
 VEgE0d8SFIPAbMOSw3aCtn2sgSg8s6PAuTPGI/fe0Li+gexieAY8UVxoywV5IG276pgvvfbXV9oh
 TUM+heDWGv6jxWwF2Aa/EIY99Uxy1YXLu1jxK6HGhOvu4OFICIpnQGWVgm5Qbwdr7Ahk99mSaVa3
 W0IaEmNLt2WzFfIeFWvElASK4Kbc8Q50z2haempSmBqLXnSdIscwh+ex1TPVoK70U5HS445RQJz2
 caVRhlxj194wO6TgaZ92GVQ5CNXooWuKoP/1GX7NiPRC1IoXlffVBw2DcyPIcz6QHDF+35m6/Zb2
 DMqIkLosicXntigh+eKNLpmY4JkrS6NWscSo8BNGtYjX7RQtoAQY33aTj24Eq5U91sd0EO+GUtwc
 a6oeV8eGx48fg5o+CASm09UXO21VkUqCzMC344Vh1VrdFaxAtcZWL7b4Xj6jVvVhzi9pSp8GHD/g
 DcQWu27yKkLuSGOnERA0rfPeWAksoeJqqtCE0JqAprxlLab2+ajYlR5FG+m6cbM6ksKwOmZX95vk
 QYRQipcXtELoTpuwwsW6y/+HcJcFEbdjt3A9ituRV+82biKVp4
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: armbru@redhat.com, hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 08/13] mirror: Allow QMP override to declare target
 already zero
Date: Sat,  3 May 2025 08:40:49 +0800
X-OQ-MSGID: <20250503004049.49482-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509204341.3553601-23-eblake@redhat.com>
References: <20250509204341.3553601-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.240; envelope-from=sunnyzhyy@qq.com;
 helo=out203-205-221-240.mail.qq.com
X-Spam_score_int: 42
X-Spam_score: 4.2
X-Spam_bar: ++++
X-Spam_report: (4.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 9 May 2025 15:40:25 -0500, Eric Blake wrote:
> QEMU has an optimization for a just-created drive-mirror destination
> that is not possible for blockdev-mirror (which can't create the
> destination) - any time we know the destination starts life as all
> zeroes, we can skip a pre-zeroing pass on the destination.  Recent
> patches have added an improved heuristic for detecting if a file
> contains all zeroes, and we plan to use that heuristic in upcoming
> patches.  But since a heuristic cannot quickly detect all scenarios,
> and there may be cases where the caller is aware of information that
> QEMU cannot learn quickly, it makes sense to have a way to tell QEMU
> to assume facts about the destination that can make the mirror
> operation faster.  Given our existing example of "qemu-img convert
> --target-is-zero", it is time to expose this override in QMP for
> blockdev-mirror as well.
> 
> This patch results in some slight redundancy between the older
> s->zero_target (set any time mode==FULL and the destination image was
> not just created - ie. clear if drive-mirror is asking to skip the
> pre-zero pass) and the newly-introduced s->target_is_zero (in addition
> to the QMP override, it is set when drive-mirror creates the
> destination image); this will be cleaned up in the next patch.
> 
> There is also a subtlety that we must consider.  When drive-mirror is
> passing target_is_zero on behalf of a just-created image, we know the
> image is sparse (skipping the pre-zeroing keeps it that way), so it
> doesn't matter whether the destination also has "discard":"unmap" and
> "detect-zeroes":"unmap".  But now that we are letting the user set the
> knob for target-is-zero, if the user passes a pre-existing file that
> is fully allocated, it is fine to leave the file fully allocated under
> "detect-zeroes":"on", but if the file is open with
> "detect-zeroes":"unmap", we should really be trying harder to punch
> holes in the destination for every region of zeroes copied from the
> source.  The easiest way to do this is to still run the pre-zeroing
> pass (turning the entire destination file sparse before populating
> just the allocated portions of the source), even though that currently
> results in double I/O to the portions of the file that are allocated.
> A later patch will add further optimizations to reduce redundant
> zeroing I/O during the mirror operation.
> 
> Since "target-is-zero":true is designed for optimizations, it is okay
> to silently ignore the parameter rather than erroring if the user ever
> sets the parameter in a scenario where the mirror job can't exploit it
> (for example, when doing "sync":"top" instead of "sync":"full", we
> can't pre-zero, so setting the parameter won't make a speed
> difference).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> ---
> 
> v4: hoist earlier in series. QMP design is unchanged, but logic in
> mirror_dirty_init is different (in many aspects simpler, but now
> catering to "detect-zeroes":"unmap") so Acked-by on QMP kept, but
> Reviewed-by dropped.
> ---
>  qapi/block-core.json                   |  8 +++++++-
>  include/block/block_int-global-state.h |  3 ++-
>  block/mirror.c                         | 27 ++++++++++++++++++++++----
>  blockdev.c                             | 18 ++++++++++-------
>  tests/unit/test-block-iothread.c       |  2 +-
>  5 files changed, 44 insertions(+), 14 deletions(-)

Reviewed-by: Sunny Zhu <sunnyzhyy@qq.com>


