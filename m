Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2865BCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGHR-0005s5-EB; Wed, 10 Jun 2026 06:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wXGHQ-0005o2-0b; Wed, 10 Jun 2026 06:35:28 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wXGHO-0003Md-5f; Wed, 10 Jun 2026 06:35:27 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4FD47451F9;
 Wed, 10 Jun 2026 12:35:04 +0200 (CEST)
Message-ID: <1edb7531-1294-486c-bbd4-bea0f74e08ae@proxmox.com>
Date: Wed, 10 Jun 2026 12:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block/mirror: fix assertion failure upon duplicate
 complete for job using 'replaces'
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com
References: <20260325111140.347421-1-f.ebner@proxmox.com>
Content-Language: en-US
In-Reply-To: <20260325111140.347421-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781087656286
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

Ping

Am 25.03.26 um 12:11 PM schrieb Fiona Ebner:
> Changes in v3:
> * In the first test, avoid testing that all requests complete in a
>   given time. This is prone to flakiness. Instead, complete the job
>   under throttle.
> 
> Changes in v2:
> * Drop already applied patch, only the tests remain to be added.
> * Use throttle limits and issue requests in a way, that actually makes
>   throttling take effect.
> * Use a second VM instance for the NBD export target rather than
>   qemu-storage-daemon, since qtest is needed for stepping the clock.
> 
> Fiona Ebner (2):
>   iotests/041: add test for mirror with throttled NBD export as target
>   iotests/041: add test for duplicate job-complete with throttled target
> 
>  tests/qemu-iotests/041     | 177 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/041.out |   4 +-
>  2 files changed, 179 insertions(+), 2 deletions(-)
> 



