Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA35C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3FW-0007E0-Mw; Fri, 14 Jun 2024 05:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sI3FU-0007DI-DF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:29:32 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sI3FS-0006Oc-NW
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:29:32 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 480F3475D2;
 Fri, 14 Jun 2024 11:29:18 +0200 (CEST)
Message-ID: <1975e2c1-6c66-4249-8380-219b5f1c0ef2@proxmox.com>
Date: Fri, 14 Jun 2024 11:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] migration/savevm: do not schedule
 snapshot_save_job_bh in qemu_aio_context
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 Kevin Wolf <kwolf@redhat.com>
References: <20240605120848.358654-1-f.ebner@proxmox.com>
 <20240606183638.GC198201@fedora.redhat.com>
 <6d64f07d-1638-44dc-848b-b307c0ebd0ad@proxmox.com>
 <20240611140449.GA366375@fedora.redhat.com>
 <08689bad-80f3-4cc1-bdd9-39df04b40d89@proxmox.com>
 <CAJSP0QUJ2dsAgMaoesTSF7Ni+EPQsCxzOavTvU0sgj7h+7vkQg@mail.gmail.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <CAJSP0QUJ2dsAgMaoesTSF7Ni+EPQsCxzOavTvU0sgj7h+7vkQg@mail.gmail.com>
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

Am 12.06.24 um 17:34 schrieb Stefan Hajnoczi:
> 
> Thank you for investigating! It looks like we would be trading one
> issue (the assertion failures you mentioned) for another (a rare, but
> possible, hang).
> 
> I'm not sure what the best solution is. It seems like vm_stop() is the
> first place where things go awry. It's where we should exit device
> emulation code. Doing that probably requires an asynchronous API that
> takes a callback. Do you want to try that?
> 

I can try, but I'm afraid it will be a while (at least a few weeks)
until I can get around to it.

Best Regards,
Fiona


