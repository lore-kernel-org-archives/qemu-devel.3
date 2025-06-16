Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA8AC71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 12:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9J5-0007dW-Vp; Mon, 16 Jun 2025 08:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uR9J2-0007cu-VY; Mon, 16 Jun 2025 08:51:21 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uR9It-00018Z-Na; Mon, 16 Jun 2025 08:51:20 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id BC6FB45E28;
 Mon, 16 Jun 2025 14:51:07 +0200 (CEST)
Message-ID: <b0f1ebc4-c7fd-45f9-aa99-a9507c1df55f@proxmox.com>
Date: Mon, 16 Jun 2025 14:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/rbd: support keyring option via QAPI
To: Ilya Dryomov <idryomov@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-3-f.ebner@proxmox.com>
 <CAOi1vP_kEY31-brzTfG6K9y0Wbv06e=9vH=rqD9ouwq32VaYAA@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAOi1vP_kEY31-brzTfG6K9y0Wbv06e=9vH=rqD9ouwq32VaYAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 16.06.25 um 11:34 schrieb Ilya Dryomov:
> On Thu, May 15, 2025 at 1:29 PM Fiona Ebner <f.ebner@proxmox.com> wrote:
>>
>> In Proxmox VE, it is not always required to have a dedicated Ceph
>> configuration file, and using the 'key-secret' QAPI option would
>> require obtaining a key from the keyring first. The keyring location
>> is readily available however, so having support for the 'keyring'
>> configuration option is most convenient.
> 
> Would such a setup have a ceph.conf file that is shared between
> multiple users (or no ceph.conf file at all if the monitors are
> specified via QAPI option) but individual keyring files for each
> user?

There is only a single Ceph user and we could create a ceph.conf file
with the 'keyring' option set. It was just not required in the past,
because we specified 'keyring' via '-drive' directly, so having this
option would be more convenient for us.

In short: we can still make it work on our side if there is no interest
in adding this option in the QAPI.

Best Regards,
Fiona


