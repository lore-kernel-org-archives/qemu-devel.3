Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F7FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0NCw-0008Oa-1q; Fri, 26 Apr 2024 11:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <egqac@eldondev.com>)
 id 1s0M0R-0005ZA-4u
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:52:51 -0400
Received: from npcomp.net ([69.61.8.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <egqac@eldondev.com>)
 id 1s0M0P-0002rz-Ig
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 09:52:50 -0400
Received: by npcomp.net (Postfix, from userid 1000)
 id E910028282C; Fri, 26 Apr 2024 13:46:33 +0000 (-00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldondev.com;
 s=eldondev; t=1714139193;
 bh=CaCSVmLjcMI14UpWpgjxZLzGpMMhWlBKk1IARDo0pUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GqfE6GH3M47ZoqJCnqklvQq37w+H4fX/qgPhF0IEDgWtyoGo4qYRtfq2rWyQ5DhkF
 cy2i2GSynH4fKMujW/R+QMPKdzxpehc7zxyDabPODM9RI51ewBW7AjKEW7u6E3P/8O
 igHoTu1muN35spJVXcPi8lUo3uMuai1/Bm5RD7lg=
Date: Fri, 26 Apr 2024 13:46:33 +0000
From: Eldon Stegall <egqac@eldondev.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs
Message-ID: <ZiuwOYf07wcLRa5O@localhost>
References: <20240426113742.654748-1-thuth@redhat.com>
 <CAFEAcA_gEyBXecGXP3x=uLJQTaE9=5Ubf0bGeSALskTfFoNQ6g@mail.gmail.com>
 <5b79efda-2774-4e76-8bb2-a1d70e8bce2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b79efda-2774-4e76-8bb2-a1d70e8bce2f@redhat.com>
Received-SPF: pass client-ip=69.61.8.91; envelope-from=egqac@eldondev.com;
 helo=npcomp.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Apr 2024 11:09:48 -0400
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

On Fri, Apr 26, 2024 at 02:47:20PM +0200, Thomas Huth wrote:
> With regards to NetBSD and OpenBSD, this is not a step backward since these 
> gitlab jobs were never run anyway (they could only be triggered manually, 
> but hardly anybody did that AFAIK).
> 
> If we want to have proper support for those OSes, I think somebody would 
> need to set up a custom runner on a beefy KVM-capable server somewhere where 
> we could run the "make vm-build-*bsd" commands. By the way, are Eldon's CI 
> runners still around? IIRC they were capable of running KVM ?

My datacenter had a power outage recently, so I disable my runner, and
haven't prioritized bringing it back up until now. I am glad to get this
going again, I'll look at it this weekend. 

It is a dedicated machine (R610 or Cisco UCS C220, I don't quite recall)
with I believe ~2X cores and 100+ GB memory. I hit a couple of minor
hurdles when CI started utilizing kubernetes runners, so one question I
had was whether I should install a lightweight kubernetes system and run
the gitlab kubernetes CI operator or the normal gitlab runner service. 

There should also be plenty of space to build *bsd VM's. Do pre-existing
upstream BSD images have an nocloud support so that we can build from a
stable updated base? Sorry I'm not super familiar with the BSD
ecosystems, but happy to try to fill in the gaps.

Thanks,
Eldon

