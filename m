Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F000CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 13:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI5gD-0004Lu-8J; Sun, 09 Nov 2025 08:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1vI5g4-0004Ia-PV
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:41:57 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1vI5g1-0000k4-M8
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:41:55 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B5A9D40ADF;
 Sun,  9 Nov 2025 13:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755E3C2BC9E;
 Sun,  9 Nov 2025 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762695707;
 bh=f2qJzdjb9gcZVcnFxwGyXzIcJOBccaTDcaHqKS8KDsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nuNi9hd9K8YAfA/lHZ8yIsft2H9WdtZ9TwyoeZNqdODqidInByCkLvy9d29fpO5v8
 UVDI5sgzcMi0Bua2BP81dd3FQLM13nhfJ5vXgHrjwspkbidqEuNYpO+2UjlDA1xQ/f
 d+fZnjgqn6qsdesscDuZQwWJcsrsAuW6tuwVV1mnr+NzPpLe4d3R0XvEX+FEkC4/Wf
 1XJxlbcycX5wkIjCiZRsSFrgctVARw12ucAFBpJgCUU6ftSkqlY+IMAkkU8B0cFbpS
 6a6sjk6M5Lzqhjmhma9NhM/3pvW0kiKySZa29Fu7XqOkZiS1uL+616oNrF3RMhvLXN
 pjfL7wDpup4cg==
Received: by pali.im (Postfix)
 id 5D597806; Sun,  9 Nov 2025 14:41:41 +0100 (CET)
Date: Sun, 9 Nov 2025 14:41:41 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
Message-ID: <20251109134141.ur2s3bk5e6dgquxv@pali>
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250810130948.3yzymcxtkmfkgk67@pali>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=172.234.252.31; envelope-from=pali@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Any comments?

On Sunday 10 August 2025 15:09:48 Pali Rohár wrote:
> +cc slirp & network maintainers
> 
> On Saturday 02 August 2025 13:05:49 Pali Rohár wrote:
> > Add #PRE and #NOFNR flags to LMHOSTS example line.
> > Include information about LMHOSTS path on Windows 3.x.
> > 
> > Windows NT 3.1 requires #NOFNR flag for successful hostname resolving as
> > described in MS article Q103765 because qemu/smbd does not respond to
> > netbios name verification queries. #PRE is suggested in that article too
> > and decrease delay on Windows 3.x for the first connection.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  qemu-options.hx | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index ab23f14d2178..d5654756f125 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3307,10 +3307,10 @@ SRST
> >  
> >          ::
> >  
> > -            10.0.2.4 smbserver
> > +            10.0.2.4 smbserver #PRE #NOFNR
> >  
> > -        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for windows
> > -        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
> > +        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for Windows
> > +        3x/9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
> >          NT/2000).
> >  
> >          Then ``dir`` can be accessed in ``\\smbserver\qemu``.
> > -- 
> > 2.20.1
> > 

