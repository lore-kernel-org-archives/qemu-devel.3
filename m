Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E36C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 16:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzJ4P-00031L-3L; Tue, 23 Apr 2024 12:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1rzJ4M-0002z8-Jc
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:32:34 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1rzJ4F-0001Ax-5p
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 12:32:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CF0F9615CD;
 Tue, 23 Apr 2024 16:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913F8C2BD10;
 Tue, 23 Apr 2024 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1713889943;
 bh=w+KNgWrPEVs8x9tMDC6NYUvGz7wLZowPidUQjzR5xZQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eLeD6Eb0+pGQCPeOMPlbsgot8vG1fnXf4bcvZjLmcFkAs7tK05urfaSYDEuYlO+jX
 i2X6mifMoUsruwLLtcmBI9nonuI0qlsMcVIJJv4j980Ei67Zu6dImpcFuXiU09TDLp
 BgUV3/moUuUAWDGqubULNvw22aUygEoVaoxyJA3I=
Date: Tue, 23 Apr 2024 09:32:14 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
 qemu-devel@nongnu.org, Heng Qi <hengqi@linux.alibaba.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 6.6.y] virtio_net: Do not send RSS key if it is not
 supported
Message-ID: <2024042301-hankering-staunch-7363@gregkh>
References: <2024041412-subduing-brewing-cd04@gregkh>
 <20240422151803.1266071-1-vlad.wing@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422151803.1266071-1-vlad.wing@gmail.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=gregkh@linuxfoundation.org; helo=dfw.source.kernel.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 22, 2024 at 08:18:03AM -0700, Vlad Poenaru wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 upstream.
> 

Now queued up, thanks.

greg k-h

