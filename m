Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78372C54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricTS-00039j-8c; Fri, 08 Mar 2024 10:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTO-0002vN-LT; Fri, 08 Mar 2024 10:49:27 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTL-00047g-VQ; Fri, 08 Mar 2024 10:49:26 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1222B488C8;
 Fri,  8 Mar 2024 16:49:15 +0100 (CET)
Message-ID: <b246ef09-f945-4857-a083-9de168b8e7bd@proxmox.com>
Date: Fri, 8 Mar 2024 16:49:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] block/copy-before-write: create block_copy bitmap
 in filter node
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 alexander.ivanov@virtuozzo.com
References: <20240228141501.455989-1-vsementsov@yandex-team.ru>
 <20240228141501.455989-4-vsementsov@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240228141501.455989-4-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 28.02.24 um 15:14 schrieb Vladimir Sementsov-Ogievskiy:
> Currently block_copy creates copy_bitmap in source node. But that is in
> bad relation with .independent_close=true of copy-before-write filter:
> source node may be detached and removed before .bdrv_close() handler
> called, which should call block_copy_state_free(), which in turn should
> remove copy_bitmap.
> 
> That's all not ideal: it would be better if internal bitmap of
> block-copy object is not attached to any node. But that is not possible
> now.
> 
> The simplest solution is just create copy_bitmap in filter node, where
> anyway two other bitmaps are created.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>


