Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB84C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZ08-0000sm-9r; Thu, 15 Feb 2024 05:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1raZ06-0000sY-Pe; Thu, 15 Feb 2024 05:29:54 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1raZ04-000265-OZ; Thu, 15 Feb 2024 05:29:54 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D5DFD48427;
 Thu, 15 Feb 2024 11:29:41 +0100 (CET)
Message-ID: <ec0f365a-3db1-48b7-906e-7195b8a5c64f@proxmox.com>
Date: Thu, 15 Feb 2024 11:29:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: double free or corruption (out) in iscsi virtual machine
To: M_O_Bz <m_o_bz@163.com>, qemu-block@nongnu.org
Cc: deepa.srinivasan@oracle.com, qemu-devel@nongnu.org,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@kamp.de
References: <8b81d02.69e7.18d164d6764.Coremail.m_o_bz@163.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <8b81d02.69e7.18d164d6764.Coremail.m_o_bz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 17.01.24 um 08:23 schrieb M_O_Bz:
> Basic Info:
> 1. Issue: I got a " double free or corruption (out)", head for
> attachment debug.log for details, the debug.log print the backtrace of
> one virtual machine
> 2. Reproduce: currently I cann't destribe how to reproduce this bug,
> because it's in my productive enviroment which include some special stuffs
> 3. qemu version:  I'm using is qemu-6.0.1
> 4. qemu ccmdline in short:(checkout detail in the virtual machine log
> message)

Hi,
sounds like it might be the issue fixed by:
https://github.com/qemu/qemu/commit/5080152e2ef6cde7aa692e29880c62bd54acb750

Best Regards,
Fiona


