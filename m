Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB3CCD13DA
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 15:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJCYu-000739-3h; Sat, 02 May 2026 11:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1wJCYn-00072z-3H
 for qemu-devel@nongnu.org; Sat, 02 May 2026 11:47:17 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1wJCYl-0005XF-9i
 for qemu-devel@nongnu.org; Sat, 02 May 2026 11:47:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AEEAA60120;
 Sat,  2 May 2026 15:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E774C19425;
 Sat,  2 May 2026 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777736818;
 bh=t7ob5xeY+v02ozXSJcHHJjaZmSqU4Ls62ItMms8Z0yg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S36XzK5JN6UiaMuOXTNN6whmF0Gu726kNU+LckQukXir+x3rKMz3U4y7GT1jujpdu
 B+a3r+T2R99rk3tjLUWioPyS7T5YATgUrUyUcaqduWfIWZwgwxyzXM2X3FZOfHSHeS
 SUtVT1QY/1VcUXKxGfAoo+qjeB8vkwBZF/jqEKUMxP2Nyyit53YQP3QmZ3k0R5fPb3
 ve6HjnqDDFv6zB+Aog8HcV4kdqDVD0QjCQ7oQgDqO9gMlgRWwmNXVua281vcJfSUX9
 +bzkisAm+l2j2WKVsm62ltVAgfgOqMbCoN7b83qydw7rjtP5D0lCZ8M0eWiVnM7Bub
 dn8Yp8h7LpF1A==
Received: by pali.im (Postfix)
 id 91B8A800; Sat,  2 May 2026 17:46:49 +0200 (CEST)
Date: Sat, 2 May 2026 17:46:49 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
Message-ID: <20260502154649.yuf7j7224duwveje@pali>
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
 <20251109134141.ur2s3bk5e6dgquxv@pali>
 <CAFEAcA8+cycE_JvFDEtAmbJtXwRVwU026rOBYNV+cZaq5wZ+XQ@mail.gmail.com>
 <20260418012012.by2qdlkbryjf2ugv@pali>
 <CAFEAcA8VcTN1ANX0EpCqCiyBVDckCp-D99TxabAghxtLdnMkgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8VcTN1ANX0EpCqCiyBVDckCp-D99TxabAghxtLdnMkgA@mail.gmail.com>
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

On Thursday 30 April 2026 11:58:21 Peter Maydell wrote:
> On Sat, 18 Apr 2026 at 02:20, Pali Rohár <pali@kernel.org> wrote:
> > Yes, this is a good idea to mention. Finding those information would be
> > harder in future, specially when Microsoft already removed those KB
> > articles from own servers and web archive does not have copies of them.
> >
> >
> > About about path to LMHOSTS file. On 3x/9x/Me systems it is <WIN>\LMHOSTS
> > and on NT systems it is <WIN>\SYSTEM32\DRIVERS\ETC\LMHOSTS
> > <WIN> is the Windows directly which can chosen during installation of
> > Windows itself. 3x/9x/Me has default C:\Windows; NT 3.1-2000 has default
> > C:\WINNT and since Windows XP it is default C:\Windows. So path to the
> > LMHOSTS file depends on installation and default path was changed more
> > times.
> >
> > Note that Microsoft Network Client 3.0 and Microsoft LAN Manager Client
> > (both are DOS based) also need that adjustment of the LMHOSTS file.
> > Default location for Network Client is C:\NET\LMHOSTS and for LAN Manager
> > is C:\LANMAN\ETC\LMHOSTS. I check Network Client 3.0 and it is working
> > fine with and also without #PRE #NOFNR.
> >
> > Maybe the documentation could be extended and mention something like:
> >
> >     must be added in the file ``C:\NET\LMHOSTS`` (for DOS Network Client)
> >     or ``C:\LANMAN\ETC\LMHOSTS`` (for DOS LAN Manager)
> >     or ``C:\WINDOWS\LMHOSTS`` (for Windows 3x/9x/Me)
> >     or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (for Windows NT/2000)
> >     or ``C:\WINDOWS\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (for Windows XP and new)
> 
> Thanks for doing the testing on different Windows versions. Based
> on this conversation, I'm going to take this patch, with some
> expansion of it, like this, so we explain what #PRE and #NOFNR do,
> and list LMHOSTS locations for newer Windows. Let me know if you're
> OK with this or you'd prefer some other changes.
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e780bc2ac0..98e39a1ad4 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3415,7 +3415,7 @@ SRST
> 
>      ``smb=dir[,smbserver=addr]``
>          When using the user mode network stack, activate a built-in SMB
> -        server so that Windows OSes can access to the host files in
> +        server so that Windows OSes can access the host files in
>          ``dir`` transparently. The IP address of the SMB server can be
>          set to addr. By default the 4th IP in the guest network is used,
>          i.e. x.x.x.4.
> @@ -3424,11 +3424,20 @@ SRST
> 
>          ::
> 
> -            10.0.2.4 smbserver
> +            10.0.2.4 smbserver #PRE #NOFNR
> 
> -        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for windows
> -        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
> -        NT/2000).
> +        must be added in the ``LMHOSTS`` file. In this line, ``#PRE``
> +        requests pre-caching of the mapping, which speeds up the initial
> +        connection on some Windows versions. ``#NOFNR`` is necessary for
> +        Windows NT 3.1 to tell it not to send QEMU NBNS query packets that
> +        QEMU does not handle, and is harmlessly ignored on other versions.
> +
> +        The ``LMHOSTS`` file may be in different locations depending on
> +        the Windows version:
> +
> +        -  ``C:\WINDOWS\LMHOSTS`` for Windows 3x/9x/Me
> +        -  ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` for Windows NT/2000
> +        -  ``C:\WINDOWS\SYSTEM32\DRIVERS\ETC\LMHOSTS`` for Windows XP and newer
> 
>          Then ``dir`` can be accessed in ``\\smbserver\qemu``.
> 
> thanks
> -- PMM

Hello, thank you for updating the change. It is fine from my side. And
it is really good to mention where modern Windows systems have that file.


I have one just question regarding the (English) wording:

"... to tell it not to send QEMU NBNS query packets that QEMU does not handle"

Should not be there word "send to" QEMU? Packet is "NBNS query", it is
not "QEMU NBNS packet", packet comes from Windows and is sent to QEMU.

E.g.:
"... to tell it not to send NBNS query packets to QEMU that QEMU does not handle"
or just:
"... to tell it not to send NBNS query packets that QEMU does not handle"

Sorry if this is a stupid English question, I'm not native English
speaker and sometimes I write or understand English words in wrong order.

