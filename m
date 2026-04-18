Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21686F99C63
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 01:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDuMG-0000ug-Qo; Fri, 17 Apr 2026 21:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1wDuMF-0000tX-1Y
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 21:20:27 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pali@kernel.org>) id 1wDuMC-00051v-Jo
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 21:20:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EB48435CC;
 Sat, 18 Apr 2026 01:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62FFC19425;
 Sat, 18 Apr 2026 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776475220;
 bh=YeYRTPrrBEPKm22asE9VB7a9abr0+ToKQdlr7FB4lWE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f9DWy5lqlIqQ0R2gLOD2ot1isJFYX8FPuKfV1bipAstuKq+ROqLU7e3RpHHAe6CD+
 br1N8HIuQxDVJWvgbfnqOLxhwZfL5kiKueU8p5VXXWVt7AptrAF4blarGbUBVYDH+H
 gFdETQlhZIfhneuek3INqgul5wtmZJamw3ENIx7oMiGmXS7aVnqconmJdOPV7SfyOI
 t0kqvQSk6sDV+hWzuWkDcEMmpHYKl4qzJ4SqvdfkuFRINYXthfjKU4uVyNcMfmN5Fe
 eCzCoqAPSeI1PAdF+mktel3L6EM6pS2OWcXHI14jZCt7/1h6NtnvN6meF8IzvBZMMj
 xO8MAf+evIpVA==
Received: by pali.im (Postfix)
 id ECA1D59D; Sat, 18 Apr 2026 03:20:12 +0200 (CEST)
Date: Sat, 18 Apr 2026 03:20:12 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowang@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
Message-ID: <20260418012012.by2qdlkbryjf2ugv@pali>
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
 <20251109134141.ur2s3bk5e6dgquxv@pali>
 <CAFEAcA8+cycE_JvFDEtAmbJtXwRVwU026rOBYNV+cZaq5wZ+XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8+cycE_JvFDEtAmbJtXwRVwU026rOBYNV+cZaq5wZ+XQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=pali@kernel.org; helo=sea.source.kernel.org
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

On Friday 17 April 2026 14:51:38 Peter Maydell wrote:
> On Sun, 9 Nov 2025 at 13:42, Pali Rohár <pali@kernel.org> wrote:
> >
> > Any comments?
> >
> > On Sunday 10 August 2025 15:09:48 Pali Rohár wrote:
> > > +cc slirp & network maintainers
> > >
> > > On Saturday 02 August 2025 13:05:49 Pali Rohár wrote:
> > > > Add #PRE and #NOFNR flags to LMHOSTS example line.
> > > > Include information about LMHOSTS path on Windows 3.x.
> > > >
> > > > Windows NT 3.1 requires #NOFNR flag for successful hostname resolving as
> > > > described in MS article Q103765 because qemu/smbd does not respond to
> > > > netbios name verification queries. #PRE is suggested in that article too
> > > > and decrease delay on Windows 3.x for the first connection.
> > > >
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > ---
> > > >  qemu-options.hx | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index ab23f14d2178..d5654756f125 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -3307,10 +3307,10 @@ SRST
> > > >
> > > >          ::
> > > >
> > > > -            10.0.2.4 smbserver
> > > > +            10.0.2.4 smbserver #PRE #NOFNR
> > > >
> > > > -        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for windows
> > > > -        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
> > > > +        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for Windows
> > > > +        3x/9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
> > > >          NT/2000).
> > > >
> > > >          Then ``dir`` can be accessed in ``\\smbserver\qemu``.
> 
> Apologies for this not having been picked up earlier. The problem (as I
> mentioned in our IRC conversation) I think is the lack of anybody who knows
> anything about SMB or old Windows versions who felt competent to review it.
> But since nobody has, and as you say you've tested it with this, I guess
> we should take it.
> 
> My only concern is whether the "#PRE #NOFNR" advice is still valid
> for newer Windows versions, or whether it really is only something that
> NT 3.1 and Windows 3x needed. In particular this more recent LMHOSTS
> documentation from MS:
> https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-nbte/01f85bfc-cfa3-4be0-b659-4ca0eddb5996
> includes #PRE in its list of LMHOSTS known keywords, but not #NOFNR.

I was trying to find documentation related to this topic and found this:

Q102725 - LMHOSTS File Information and Predefined Keywords (NT 3.1 - 2000):
https://web.archive.org/web/20130727015114/http://support.microsoft.com/kb/102725

Q314884 - LMHOSTS file information and predefined keywords (Windows XP):
https://web.archive.org/web/20130426133556/http://support.microsoft.com/kb/314884

Q103765 - #NOFNR Flag in LMHosts to Communicate Across Routers
https://www.betaarchive.com/wiki/index.php?title=Microsoft_KB_Archive/103765
(seems that web archive does not have copy of Q103765)

Q106169 - Windows NT and HP LAN Manager/X Version 1.4 Interoperability
https://www.betaarchive.com/wiki/index.php?title=Microsoft_KB_Archive/106169
(seems that web archive does not have copy of Q106169)


#PRE and #NOFNR are documented up to the Windows XP. I have not found
any updated KB of LMHOSTS for Vista and up, maybe it hidden somewhere
(like you found that [MS-NBTE]).

#NOFNR is documented in Q106169 that does not apply for NT 3.5 (and
maybe up too).

I did experiments with NT 3.1, WFW 3.11 and XP under Wireshark what are
systems doing with and without #NOFNR. NT 3.1 without #NOFNR is sending
NBNS packet (udp port 137) to specified IP address with name query of
"smbserver" (the configured hostname). If there is no response then
accessing the SMB share fails with error 53 (same as described in
Q103765). Without #NOFNR it is not sending NBNS packet, it directly try
to establish SMB connection over tcp port 139.
All other tested systems do not try to do name query independently of
#NOFNR. So it looks like that non-NT3.1 are behaving as if the #NOFNR
was always specified. (NBNS = NetBios Name Service)

So based on these experiments, the #NOFNR is required only for Windows NT 3.1
because Qemu does not answer to those UDP NBNS packets sent to internal
10.0.2.4 address. But it is harmless and not needed for other Windows versions.

About #PRE, I have subjective feeling for persistent drive assigning
(those which are restored on every startup during login) for more
Windows versions is #PRE causing faster connection and login.
The most visible it is in WFW 3.11, where File Manager is not able to
access network disk for more seconds and show error message that disk is
inaccessible, and needs waiting... When #PRE is used it never showed me
error message and always accessed network disk without delay.

> I think also we could probably helpfully explain what those two tags do,
> something like:
> 
>    (The #PRE tag tells Windows to pre-cache the mapping to speed up initial
>    connection. The #NOFNR tag tells Windows not to attempt to send QEMU
>    Name Queries, because QEMU doesn't understand them.)
> 
> Then anybody who finds they need to adapt this to some other version
> of Windows will have a better idea whether they can just drop them
> or what they might need to change them to.
> 
> thanks
> -- PMM

Yes, this is a good idea to mention. Finding those information would be
harder in future, specially when Microsoft already removed those KB
articles from own servers and web archive does not have copies of them.


About about path to LMHOSTS file. On 3x/9x/Me systems it is <WIN>\LMHOSTS
and on NT systems it is <WIN>\SYSTEM32\DRIVERS\ETC\LMHOSTS
<WIN> is the Windows directly which can chosen during installation of
Windows itself. 3x/9x/Me has default C:\Windows; NT 3.1-2000 has default
C:\WINNT and since Windows XP it is default C:\Windows. So path to the
LMHOSTS file depends on installation and default path was changed more
times.

Note that Microsoft Network Client 3.0 and Microsoft LAN Manager Client
(both are DOS based) also need that adjustment of the LMHOSTS file.
Default location for Network Client is C:\NET\LMHOSTS and for LAN Manager
is C:\LANMAN\ETC\LMHOSTS. I check Network Client 3.0 and it is working
fine with and also without #PRE #NOFNR.

Maybe the documentation could be extended and mention something like:

    must be added in the file ``C:\NET\LMHOSTS`` (for DOS Network Client)
    or ``C:\LANMAN\ETC\LMHOSTS`` (for DOS LAN Manager)
    or ``C:\WINDOWS\LMHOSTS`` (for Windows 3x/9x/Me)
    or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (for Windows NT/2000)
    or ``C:\WINDOWS\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (for Windows XP and new)

(People who are installing to non-default location would be already
aware that would need to adjust any WINDOWS related path)

