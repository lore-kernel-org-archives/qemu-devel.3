Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3DFC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpUK-0002xb-TW; Tue, 13 May 2025 09:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEpUA-0002wu-3C; Tue, 13 May 2025 09:15:55 -0400
Received: from out203-205-221-205.mail.qq.com ([203.205.221.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEpQE-0004hB-P4; Tue, 13 May 2025 09:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747141894; bh=WtCpsQDOXNPoZbwE8FLuwq0q20nvtAmJi3ziPV3rGzA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qLt9pZMrdqqFnaiEMT6vRjdghh8b6IyT903Es3cR7C0ozcObgzqKILIXgk/VZWtEe
 Kdk1quTwCwt3elEMYzJadVEcufIN8YGgfP3lTPLpght9atdx9tvQ4nX7l7MFnBG0x+
 HirOpqOCqfziTq8oj+kDV8iiUZn0IN4XgN7oeKCc=
Received: from localhost.localdomain ([117.147.34.74])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id 2DF956A9; Tue, 13 May 2025 21:11:31 +0800
X-QQ-mid: xmsmtpt1747141891tugy34rgx
Message-ID: <tencent_4312D7015D59B7B3D52642DA387A00796C06@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GEK5JRVY3AjKCNbe2T4BRW+6jgcIF0n0KYtUIoS0djrGMLbdhtO
 wEcak2KRVDw7sebCXcanpGkMekGiucMW7rZes9Y9X1gaM9OKpxHLE/JifJ8rYraoSfbeyk3K4EKS
 dn4CPpZu1xe6Ozr1uSRQFbh/JuQ0GL8JNk5yfC0gMkyf2vvUupQ1uxOombQK06s/Xop2PNJMgURu
 5H2M4nmw/GBOK3Ni0cQYSLkDuNBw/X425gwW4CBlcCda//4kVAb/HkDlFhgV8ssVcd4jsaL35cFV
 QK0ABG9cf4yU0pgT1yvNzgedk9KjO/ZNML53GAv+5S3XyshqZagzSA6yErb/+XOFDjo9uErX5Scy
 hGvvxgwKx71RqwvXBUeSgYqY1ID485yM0CrWWl7dAIMK1lHp8/UJnaTZTaai2w5jd5BjxDnd4t2S
 6UfYChjw4OihP/pD0abwS3pWi5M9ERwl7cHkF/4kFgAyxkzThkSayckRmsYO7LHqznuLGprCYGL8
 L3ADk76CBdTJk4ysVFVs4s8MxjE8X0XusHa7i4z//FVon4EVIuGBpUY3gb2XhSJTjql1qreXel9E
 /fGyGUmZdJqJGrQ5zYQZJAkYydzLSet4FY2FOg1prZT+Zu1yiZZ/ZEJypy3IpJlb4ns5tFZgjUF2
 sZoqGeU+dU0aAu/hh5FDnyypxmmgIDZnFR9rbwfAXKWXJSsmGE05W+57KeugSpaWIkDd5iqeR+MS
 Mg43ERYqXEU7wAU1EqggQZx0z7LC2aq2xpwNLv/c2KbOcu75sNztCYUKZHcK14qiJm6FeuhwCUVq
 4TmJQ1i/dsNSzvaeAsj/5gurlVdyOyAbFa1vuqvI7NANyiuG5pqTVkwpUwXj0OhZPeCAUw5W9B7G
 kQ6JCBc7/EgQdcWOoEGdX5ag2vh5ZlHI/BJWyUiyspQSXpDOJDST+o7B49j1Y0Y/ySDba6MLL6DO
 GynV6aQhWjMu6Zjlq944vR5zxsnCBRwxlLx1Cz2HBJQ93X3lOf1FVw7nagZqaBjE995om4TAVbin
 XXNwV86qp/Raxd+1wetFBwa0/gqS3hhql3409a6S+9gW+KQ/Zsa4yOQNKKL74pgqiXoai/hA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 10/13] mirror: Skip pre-zeroing destination if it is
 already zero
Date: Sat,  3 May 2025 08:51:35 +0800
X-OQ-MSGID: <20250503005135.49627-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509204341.3553601-25-eblake@redhat.com>
References: <20250509204341.3553601-25-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.205; envelope-from=sunnyzhyy@qq.com;
 helo=out203-205-221-205.mail.qq.com
X-Spam_score_int: 67
X-Spam_score: 6.7
X-Spam_bar: ++++++
X-Spam_report: (6.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Fri, May 09, 2025 at 03:40:27PM -0500, Eric Blake wrote:
> When doing a sync=full mirroring, we can skip pre-zeroing the
> destination if it already reads as zeroes and we are not also trying
> to punch holes due to detect-zeroes.  With this patch, there are fewer
> scenarios that have to pass in an explicit target-is-zero, while still
> resulting in a sparse destination remaining sparse.
> 
> A later patch will then further improve things to skip writing to the
> destination for parts of the image where the source is zero; but even
> with just this patch, it is possible to see a difference for any
> source that does not report itself as fully allocated, coupled with a
> destination BDS that can quickly report that it already reads as zero.
> (For a source that reports as fully allocated, such as a file, the
> rest of mirror_dirty_init() still sets the entire dirty bitmap to
> true, so even though we avoided the pre-zeroing, we are not yet
> avoiding all redundant I/O).
> 
> Iotest 194 detects the difference made by this patch: for a file
> source (where block status reports the entire image as allocated, and
> therefore we end up writing zeroes everywhere in the destination
> anyways), the job length remains the same.  But for a qcow2 source and
> a destination that reads as all zeroes, the dirty bitmap changes to
> just tracking the allocated portions of the source, which results in
> faster completion and smaller job statistics.  For the test to pass
> with both ./check -file and -qcow2, a new python filter is needed to
> mask out the now-varying job amounts (this matches the shell filters
> _filter_block_job_{offset,len} in common.filter).  A later test will
> also be added which further validates expected sparseness, so it does
> not matter that 194 is no longer explicitly looking at how many bytes
> were copied.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> v3: add exemption for "detect-zeroes":"unmap" on destination
> v4: Rebase later in series, revise logic for pre-zeroing [Sunny], add
> in python filter
> ---
>  block/mirror.c                | 24 ++++++++++++++++--------
>  tests/qemu-iotests/194        |  6 ++++--
>  tests/qemu-iotests/194.out    |  4 ++--
>  tests/qemu-iotests/iotests.py | 12 +++++++++++-
>  4 files changed, 33 insertions(+), 13 deletions(-)

Reviewed-by: Sunny Zhu <sunnyzhyy@qq.com>


