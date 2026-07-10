Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE41C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8nB-0003gn-20; Fri, 10 Jul 2026 06:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wi8n9-0003fl-G5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:49:11 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wi8n7-0008PD-TO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=ZxBz3dGKoX9k4/LR4IvUOHUh8yCekljbu49gPeqKTcU=; b=i30YPI32x9QGHNY4nR9VzsZ0Fj
 TN+Z/gdwukmezxexAmH8+HAbmrI0JpULrvTQVcEMbfy2D8tu5b7G9YFbDE8BRjLvJ8IW7iu1pld4C
 XF8tUZy26iiWTgFAaRdNcYZ2X/j5S/Hr5Di3+kg5z6YU6ae9UWV3D5pyI2OJePNHjv5r/U3o8cS53
 nH8jp/6aZE43NrtVz5fpNZQQ1/qLX8P4nIZYAnUys4EosflJtIoKz9sUDhEWKOTvyXxddjTpX9vay
 +OppwIq9932pbPPv01dLtLcctNBouNefTmxdN/yOnLC1OosBXIPlAYj/i99mSXDi9FAP4ygnUijIq
 Kb3qrRwgI2X2BZqipILfDpfgqNhrz8sHYOIuyxiFRGC/2f0hdSkkvOZ5hU1nl26TjeOM6o5GkBryA
 8LDFcZ8QTGWe9r9htjPQ4LcDE2VvRLHJsv8pZ+kXtBo5hz8GRWcyigjQJ+YVYb+a1O/pPbfyF/euK
 WRHySwaORRNpkMUT3iyIZTWS+kmmjf72NJTtyk0tI8x89n1z1oqkj27dWPVJbx2zLlSAOaoeLeS4v
 DiWTz9Zw6oN3eQev/+f/u0NU2WzDQWWzZFSxDWzpofporfUn3kzsDrunx2d+xhdN4D4RqfjIaqMuV
 MKnqEF+I9gETH4YnxkKdWI1it/5nav1XMRbpwmfA4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Cc: Jia Jia <physicalmtea@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Date: Fri, 10 Jul 2026 12:49:06 +0200
Message-ID: <2355649.iZASKD2KPV@weasel>
In-Reply-To: <20260710122345.6a6dd56e@imammedo>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <6008134.DvuYhMxLoT@weasel> <20260710122345.6a6dd56e@imammedo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote:
> On Fri, 10 Jul 2026 10:06:29 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Friday, 10 July 2026 09:37:37 CEST Igor Mammedov wrote:
> > > On Thu, 9 Jul 2026 15:50:36 +0200
> > > 
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > > Harden security by disabling hotpluggable property, to prevent
> > > > issues like fixed in the previous commit.
> > > > 
> > > > Virtio-9p is a pass-through file-sharing device that provides a
> > > > guest mount of a host filesystem tree. Unlike block or network
> > > > devices, guest-triggered hotplug of the 9p device has no practical
> > > > use case: the guest cannot recover from the device removal, and there
> > > > is no protocol-level device-loss scenario as with block or ethernet
> > > > devices.
> > > 
> > > hmh, I'm no maintainer of 9pfs, but to me it looks like any other
> > > storage device.
> > > One should be able to unmount/stop using it and unplug
> > > (it doesn't really matter if unplug is triggered by guest or host side).
> > 
> > Guest could still unmount and stop using the 9pfs device. But why should
> > guest be able to unrealize the 9pfs device at any time? What should be
> > the purpose for this particular device?
> 
> unrealize is part of unplug process, at the end of unplug no device should
> be left attached. You might not need/use it but others might be using it
> actively.

I got that, but my question was: why would they want to do that with an 9pfs 
device? Can you make up any real-life scenario why a guest might want to 
remove a 9p device, given there is no way for them to bring the device back?

Looking at the fixed issue (patch 1), my impression was that original 9p 
server developers were unaware that guest can actually trigger a device 
unrealize via ACPI eject. Most probably because hotplugging is enabled by 
default for all devices in QEMU

Independent of this patch here, I'm therefore currently investigating whether 
enabling hotplugging by default in QEMU actually make sense. To me, this 
should be an opt-in, not the other way around. Because device developers 
should make sure that ejecting a device a) makes sense for the device type in 
the first place and most importantly b) that ejecting the device works 
(without data loss and without negative security impact, as it was the case 
here).

> ---
> 
> In QEMU impl. it's cooperative process (we don't do surprise removal of PCI
> devices), where host triggers plug/unplug process and guest side completes
> it, by: 1. freeing resources on its side 1st (hopefully)
>   2. issuing eject/poweroff (either via ACPI or native PCIE-HP/SHPC
> interface)
> 
> If guest fails to do #1 it is able to abort process, or it might continue
> and do #2 with a risk of loosing data but it's guest's business/policy.
> 
> If you need to disable hotplug for a specific PCI device instance,
> use 'hotplug' CLI option on pcie bridge. If you use other than PCI variant
> of virtio device, then unplug as you describe it isn't reachable, and if it
> should be disabled in code, it's up to actual frontend device that exposes
> underlying virtio one.

What does that have to do with this issue here? The normal 9pfs live-cycle is 
to create the 9p device at QEMU startup, and unrealizing the 9p device at QEMU 
shutdown.

If guest does an ACPI eject, then the only way to bring the 9p device back is 
to restart QEMU with the required -virtfs / -fsdev -device CLI options.

The Linux 9p client (guest) does never trigger an ACPI reject on unmount. It 
just marks the virtio channel as unused. If client would eject it, it would 
not be possible for guest to re-mount it later on.

/Christian





