Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BEAF9D0D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeyt-00069C-K5; Tue, 14 Apr 2026 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wCeyr-00068i-RZ; Tue, 14 Apr 2026 10:43:09 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1wCeyq-0002vg-FG; Tue, 14 Apr 2026 10:43:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F7F760018;
 Tue, 14 Apr 2026 14:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D949AC19425;
 Tue, 14 Apr 2026 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776177779;
 bh=2WpOj6taseqBidjihcW9XRHVqfeQr6sfPKeZa635VE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VGzvYagnI4cjcGsO3eruVWvUXRCtNo9DUq2Up7sSJEK+M1orK+MQRoEqMbBA0MdUF
 yzEbBA7AZIHg7aDjGNKMCa4YojWVH7Oaj05vOL+3vktPtVeXDfXhGB0lm4TyteYW90
 8WlSNCiJkKoigJC5fvTwD0aG3NZRbNbbCsMgfbVO6dY1TW+t1cglSMLHPKZ2qYmjYj
 h4hTf4xLEZ1Gxg+h7G6ZCS8C10WgO6Xq7KI9tBzfrM5PhVis8/MkENemj+Tw46+8Li
 9SKcJ2GUumZy5isFEPE/nAT7fBoXvOjdFZXUBq1ziuQn84uBZLs4zywvP+W6SNoD7v
 zqZ7rykalJNWg==
Date: Tue, 14 Apr 2026 08:42:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Klaus Jensen <its@irrelevant.dk>, mr-083 <matthieu@minio.io>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mr-083 <matthieu@min.io>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Message-ID: <ad5ScUYqe8RWC2y8@kbusch-mbp>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414124221.GB111076@fedora>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=kbusch@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 14, 2026 at 08:42:21AM -0400, Stefan Hajnoczi wrote:
> On Mon, Apr 13, 2026 at 07:17:37PM +0200, Klaus Jensen wrote:
> > On Apr  9 08:01, mr-083 wrote:
> > > This series adds two features that together enable transparent NVMe disk
> > > hot-swap simulation in QEMU, matching the behavior of physical NVMe
> > > drives being pulled and reinserted in the same PCIe slot.
> > > 
> > 
> > I don't understand this. From an NVMe perspective you can't hotplug a
> > namespace. You can hotplug a PCIe-based NVM Subsystem.
> 
> Hi Klaus,
> It would be great if someone with more NVMe experience than myself can
> find a definite answer, but I think the Namespace List can change
> asynchronously even on a NVMe PCIe controller as long as it supports
> Namespace Management commands.

I think there's some clash in terminology. From nvme protocol side,
hotplug refers to bus events detected by the host, so something like
PCIe slot capabilities defines how that works. This series is doing
something behind the scenes from the host-controller interface
visibility, so it's just coincidence that framework is also called
"hotplug". From nvme protocol perspective, this patch looks like a qemu
specific out-of-band method for namespace "attach/detach" via the QMP
interface. Sounds fine to me: the nvme namespace events are not strictly
tied to the spec defined in-band attachment status.

