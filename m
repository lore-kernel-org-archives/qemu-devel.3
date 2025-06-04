Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336BCC5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiiO-0007xU-KU; Wed, 04 Jun 2025 03:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMiiH-0007wO-AZ; Wed, 04 Jun 2025 03:39:06 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMiiF-0001H7-F0; Wed, 04 Jun 2025 03:39:05 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0D24C44A81;
 Wed,  4 Jun 2025 09:38:54 +0200 (CEST)
Message-ID: <6c281148-5ddf-4469-be8f-9aa25634c83c@proxmox.com>
Date: Wed, 4 Jun 2025 09:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/48] block: do not drain while holding the graph lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
References: <20250530151125.955508-1-f.ebner@proxmox.com>
 <aD8MnC9IEfz62O0m@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <aD8MnC9IEfz62O0m@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 03.06.25 um 16:54 schrieb Kevin Wolf:
> Am 30.05.2025 um 17:10 hat Fiona Ebner geschrieben:
>> There were no changes for patches 01/48-09/48 and 17/48-23/48, endpoints
>> inclusive. All patches starting from 25/48 are new in v4.
> 
> This is starting to become a little unmanageable. :-)
> 
> I'm sure we could keep adding more and more cleanup patches with each
> version of the series, but we don't really have to let the first fixes
> wait for all cleanups and fix the whole world in a single series.
> 
> So I decided to start with a prefix of this series and applied
> patches 1-22, which all had received review before and were easy to
> compare against the previous version. If you don't object, I'd send a
> pull request for those without waiting for the rest.
> 
> If the other patches still need some changes, you can start a new patch
> series at v1 containing the remaining patches. (No need to resend them
> now, though, I can review them in this series.)
> 
> Does this make sense to you?

Yes, that sounds very good! I'll try to keep this in mind in the future
and send follow-up series instead in such cases :)

Best Regards,
Fiona



