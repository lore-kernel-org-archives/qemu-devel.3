Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A412C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAlt-0001p0-4u; Thu, 05 Jun 2025 09:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uNAlp-0001o7-K5; Thu, 05 Jun 2025 09:36:37 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uNAln-0008LY-D4; Thu, 05 Jun 2025 09:36:37 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9A41244C06;
 Thu,  5 Jun 2025 15:36:30 +0200 (CEST)
Message-ID: <b6d271b2-00e0-4475-b96c-f96e3e2f12fd@proxmox.com>
Date: Thu, 5 Jun 2025 15:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block/rbd: support selected key-value-pairs via QAPI
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de, idryomov@gmail.com
References: <20250515112908.383693-1-f.ebner@proxmox.com>
Content-Language: en-US
In-Reply-To: <20250515112908.383693-1-f.ebner@proxmox.com>
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

Am 15.05.25 um 13:29 schrieb Fiona Ebner:
> Currently, most Ceph configuration options are not exposed via QAPI.
> While it is possible to specify a dedicated Ceph configuration file,
> specialized options are often only required for a selection of images
> on the RBD storage, not all of them. To avoid the need to generate a
> dedicated Ceph configuration file for each image (or for each required
> combination of options), support a selection of key-value pairs via
> QAPI.
> 
> Fiona Ebner (2):
>   block/rbd: support selected key-value-pairs via QAPI
>   block/rbd: support keyring option via QAPI
> 
>  block/rbd.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json | 40 ++++++++++++++++++++++
>  2 files changed, 121 insertions(+)

Ping


