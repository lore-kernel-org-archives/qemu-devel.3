Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65139CA1013
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Sep 2025 10:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvCKQ-0001ca-5K; Sun, 07 Sep 2025 06:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1uvCKP-0001cM-4Q
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 06:08:57 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1uvCKG-00062z-FT
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 06:08:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 12A6B601F6;
 Sun,  7 Sep 2025 10:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A75C4CEF0;
 Sun,  7 Sep 2025 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757239717;
 bh=/n8cNcOpbt7EsGXufFv1x/Mp4M3G5436VXZqzpqp3Fk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=chrksk2FDlbgsmFv2sH9kly49zDn6X9CzQthrAPxvRsFqZHRmQzdFawBS39YMC5EI
 Qyc6U+GgW1kEE8gzZtCoBo+fR+dToMTpkc4Tg1zKOmW/S3gVy1jV1mUFLndASOLOGz
 TxulKM1UaO4h1VxPtcLYA0A0baX+x1SmbBgc5iGUgefhKd9YVbG+JnZLk8UB/5cOC6
 wTJyokuKNdO/2F84+8fGwzGo6UYAAErj7KFFvjz1JlqDEjjHBFnfwXpPtnD7iKvO6L
 jzw5YWFNG9QE1WixUt1hOkFOQafCaPSgNRIt+zSw4U4QXJY9Tlv1C1sI+HnXNtpDgR
 mrJMYkNG3N4Vg==
Received: by pali.im (Postfix)
 id 7D55FA1B; Sun,  7 Sep 2025 12:08:34 +0200 (CEST)
Date: Sun, 7 Sep 2025 12:08:34 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
Message-ID: <20250907100834.wezn7s37qynm4a3n@pali>
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250810130948.3yzymcxtkmfkgk67@pali>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=pali@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

PING?

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

