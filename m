Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93D1D4117A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 12:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMho-0005By-HH; Thu, 15 Jan 2026 07:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgMhe-00057e-LO
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:43:55 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vgMhc-0002Cl-Kh
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 07:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=TbUoHSTJ1accY/D1GRuHOh0KgzPA4Rs+R6ccR2/LtWE=; b=qVtmV1yxpUx5kS8b
 IxnK2aOo4oSjJr3xax2BCQWmFwH7Cd8SlFJcxHpIR9ngpxluQ6koKjkp8WYs8Dmm3rlK4NRKJSjdt
 Ffw3Na3BLrmcOX3Vx07WosgP4HVEf4yfrDQP+bOlgx3mQFgFcZSv5R5vFkQYWduT5bZBJniDIG4PF
 0XhrglPaUzf0Q6NtgdDt8jy36BE0macMFAAkY2DCBwIFkJLrEvUUj4+mSaNVIfx/NJYDNcltirPGN
 ycoVFdUfNtxNcfpJ9TTjmLQ3GmqRcKru0usMoWfIQq2WJzW2F5yOrVwwgFmcBlGgzsBNgBVdzvqAG
 OlR8XzINk7G+4A5eaw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vgMha-0000000ExaZ-28RM;
 Thu, 15 Jan 2026 12:43:50 +0000
Date: Thu, 15 Jan 2026 12:43:50 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hxtool: Error on missing docs
Message-ID: <aWjhBneLj-GKDzfz@gallifrey>
References: <20260115020423.722069-1-dave@treblig.org>
 <20260115020423.722069-5-dave@treblig.org>
 <87tswnvznc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87tswnvznc.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 12:42:25 up 80 days, 12:18,  3 users,  load average: 0.02, 0.05, 0.00
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

* Markus Armbruster (armbru@redhat.com) wrote:
> dave@treblig.org writes:
> 
> > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> >
> > Error if a '.name' is seen after another '.name' without an intervening
> > SRST, this normally indicates missing or misplaced docs.
> >
> > We can't check DEF (as used in command line options) because those
> > often have multiple DEF per doc.
> 
> Pity.

Yeh, I added the code to do it and then realised it was broken
in too many places.

> > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > ---
> >  scripts/hxtool | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/hxtool b/scripts/hxtool
> > index ea2accef98..f310071daa 100755
> > --- a/scripts/hxtool
> > +++ b/scripts/hxtool
> > @@ -1,8 +1,14 @@
> >  #!/bin/sh
> >  
> > +printifnotrst()
> 
> print_if_not_rst()?  print_h()?

OK, I'll add the _'s and renames as suggested in the others as well

> > +{
> > +    test $outsiderst -eq 1 && printf "%s\n" "$str"
> > +}
> >  hxtoh()
> >  {
> >      outsiderst=1
> > +    # .name for HMP
> > +    seenname=0
> 
> I'd prefer seen_name.
> 
> >      while read -r str; do
> >          case $str in
> >              HXCOMM*)
> > @@ -13,6 +19,8 @@ hxtoh()
> >                  echo "Error: SRST inside another RST" >&2
> >                  exit 1
> >                fi
> > +              # consume the name
> > +              seenname=0
> >                outsiderst=0
> >              ;;
> >              ERST*)
> > @@ -23,8 +31,18 @@ hxtoh()
> >                fi
> >                outsiderst=1
> >              ;;
> > +            # Note the space at the start - we need to exclude something.name
> > +             .name*)
> 
> This works?!?  It does in my testing.  I'm amazed.

To my amazement as well, but I couldn't find a clearer way of writing that also
worked.

> > +              if [ $seenname -eq 1 ]
> > +              then
> > +                echo "Error: Seen another .name, maybe missing docs?" >&2
> > +                exit 1
> > +              fi
> > +              seenname=1
> > +              printifnotrst
> > +            ;;
> >              *)
> > -            test $outsiderst -eq 1 && printf "%s\n" "$str"
> > +            printifnotrst
> >              ;;
> >          esac
> >      done
> 
> Could move the printing behind the case, and continue the loop in the
> case SRST* and ERST*.  No need for the function then.  Matter of taste,
> up to you.

Yeh I prefer the function than clever continues and stuff.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

