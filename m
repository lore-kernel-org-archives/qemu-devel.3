Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A955C531FA
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 15:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo0tA-0004Qy-9p; Sun, 26 Jul 2026 11:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wo0t7-0004H7-NR
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 11:35:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wo0t5-0003xZ-I6
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 11:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=OcksZcbX7u9sUfBgJ0jSO7nvSKtE8/jCKGlyF9FAegU=; b=HpTYEdWcTtz7RNfq
 wjVvgaMzevGx9FcePs8j/rQ/fsZf08N+BFxs2xdB9sCrDEQn5ATeSfdKJaRkLFge5hzQ3w/VTCo/H
 jeXzCHmaJ7q98x6HGQ4/tB4W8hWWgqyLC3Xr9/IdPKsStIE7fT46PP6jcV/HvN08HHMmch2NkYJys
 SQaDWl0s3B4Hjr/muFoBzF+fzEoz5XK/WSJtcAY2Izg3h1FAhZtFC2eRp0u3Fr1Q9xIQtLLK7FGlw
 ODnWk25BlO5t1KXYRwlt2rRzyDLCsnkCGyuSxcD5/ShorA5lPIJPVJ99Yqm+r8PjztQSV5Rf8jSfC
 Y3iTRSC05OM5J67i5w==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wo0t2-00000005ZiC-0SSy;
 Sun, 26 Jul 2026 15:35:32 +0000
Date: Sun, 26 Jul 2026 15:35:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Tripp R <tripprobins@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] clarify address type in 'xb' cmd
Message-ID: <amYpRGZWpu80dG1J@gallifrey>
References: <20260726-xbhmpcmd-v1-1-45d79d0f28b4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260726-xbhmpcmd-v1-1-45d79d0f28b4@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 15:29:14 up 20 days, 15:10,  2 users,  load average: 0.01, 0.04, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Tripp R (tripprobins@gmail.com) wrote:

Hi Tripp,

> ---
> Implemented the xb (examine block) command to print the contents of a block     device to the console.
>   
> It is effectively a clone of the x/xp commands (examine memory / examine        physical memory), having the same arguments for those commands, albeit preceded by the name of a block driver. 

OK, that message is oddly formatted, and also doesn't
match your subject - your subject is about clarifying it,
but we don't seem to have that original command yet -
have you missed the commit that implements it somewhere?

> e.g. usage
> 	 xd floppy0 /510c 0

So that's 510 bytes as character starting at 0?

Dave

> Signed-off-by: Tripp R <tripprobins@gmail.com>
> ---
>  hmp-commands.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index db63b58a47..26b7cadcf2 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -481,7 +481,7 @@ ERST
>          .name       = "xb",
>          .args_type  = "device:s, fmt:/,addr:l",
>          .params     = "device /fmt addr",
> -        .help       = "block memory dump starting at 'addr'",
> +        .help       = "block memory dump starting at 'addr', in units of bytes.",
>          .cmd        = hmp_block_dump,
>      },
>  
> 
> ---
> base-commit: bcc42fe49f7aae8982604900e307d783615bc79c
> change-id: 20260726-xbhmpcmd-e8c82287a035
> 
> Best regards,
> -- 
> Tripp R <tripprobins@gmail.com>
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

