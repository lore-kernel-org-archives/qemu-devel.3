Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E2ACD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXG1b-00012H-R4; Wed, 10 Jun 2026 06:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wXG1Z-00011h-Mn; Wed, 10 Jun 2026 06:19:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wXG1X-00061J-P3; Wed, 10 Jun 2026 06:19:05 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4F48145716;
 Wed, 10 Jun 2026 12:18:53 +0200 (CEST)
Message-ID: <3982600a-61a1-406a-b1b9-246ae6d9a606@proxmox.com>
Date: Wed, 10 Jun 2026 12:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
References: <20260608165207.307488-1-kwolf@redhat.com>
 <CAJSP0QXjj32djLOFPNg2jKjNN6eB7VvRXVfz3XiNkWYjR0-S2A@mail.gmail.com>
 <aik5Ox9cX_5FQbO4@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aik5Ox9cX_5FQbO4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781086685992
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 10.06.26 um 12:14 PM schrieb Kevin Wolf:
> Am 09.06.2026 um 19:44 hat Stefan Hajnoczi geschrieben:
>> On Mon, Jun 8, 2026 at 12:52 PM Kevin Wolf <kwolf@redhat.com> wrote:
>>>
>>> The following changes since commit cc329c491768b2d91eb0b0984f3baa0bf805776d:
>>>
>>>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-06-08 09:30:30 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>>>
>>> for you to fetch changes up to 296b66d05bac7eb2b86600febdbd2bd8d410f026:
>>>
>>>   qed: Don't try to flush during incoming migration (2026-06-08 17:00:47 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Block layer patches
>>>
>>> - qcow2: Fix data loss on zero write with detect-zeroes=unmap
>>> - qemu-img bitmap: add sub-command --remove-all
>>> - export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag to fix regression
>>
>> Hi Fiona and Kevin,
>> Please take a look at the CI failure below. If the root cause is in
>> this pull request, please send a new revision with fixed patches or
>> without the patches that cause the failure. Thanks!
> 
> Yes, it's a new test case introduced in this series that doesn't work
> with the luks driver. I just declared luks unsupported for the test for
> now and pushed a v2 (will send the new cover letter in a moment, too).

Sorry and thanks! I'll need to remember to check with luks in the future.

Best Regards,
Fiona


