Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742B3D185F7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq3K-0002oT-71; Thu, 08 Jan 2026 08:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vdq3E-0002bI-ER
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:27:46 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vdq3B-0003aI-Nf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=XjnjC2LOeofvcD4YqjqJ341kVgYB6lNl4JQeQHegUMQ=; b=aEd2UNBUBiawTndy
 ciCoilcDNXZN4Vz4TR/Pg0VgBT/T4yQHXLw6+HEkxv8WTtGVVk2MQp0ha0yuKolrtrFdh1moIhxyQ
 7VLH3O3QAkGOreDh7/9dlIWhwFgGjg4nuj8/ty3qpC022wvy5mbBaZ1s9UTnTxfSb5jy0kb7+PUkE
 yoxSSdcXm83da+fCYY2zI64jAJWrDHmi3/va2reG4KNuGQMmdrVfOHXfw+f/uPY7CTfvufa4rqdZn
 eJS8kqKhZyJ+FuGmpn+g3xrEoRAvIedvIwBeyLNxetcxvkEQpMU6BLlanEFqpDzgspAA41qyygitA
 WvCjE0p3pfuRgRcPEg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vdq39-0000000DGC5-3EA6;
 Thu, 08 Jan 2026 13:27:39 +0000
Date: Thu, 8 Jan 2026 13:27:39 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH] hmp-commands-info.hx: Move definition of "info accel"
Message-ID: <aV-wy_jOgzzHsu8t@gallifrey>
References: <20260108083249.1602654-1-armbru@redhat.com>
 <aV91daSxVxvCGMCa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV91daSxVxvCGMCa@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 13:15:45 up 73 days, 12:52,  2 users,  load average: 0.00, 0.00, 0.00
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> On Thu, Jan 08, 2026 at 09:32:49AM +0100, Markus Armbruster wrote:
> > Commit c10eb740108 (accel/system: Add 'info accel' on human monitor)
> > inserted "info accel" in the middle of "info sync-profile".  Move it
> > behind "info sync-profile".
> 
> Opps, we have this kind of mistake over & over again. The .hx format
> is really horrible and easy to make this mistake with, and makes me
> rather wish we could eliminate it :-(

Yeh; would the tools need any change at all if we were to change it 

 from:  --------------->
    {
        .name       = "accel",
        .args_type  = "",
        .params     = "",
        .help       = "show accelerator statistics",
    },
    
SRST
  ``info accel``
    Show accelerator statistics.
ERST


 to:  --------------->
    {
        .name       = "accel",
        .args_type  = "",
        .params     = "",
        .help       = "show accelerator statistics",
SRST
  ``info accel``
    Show accelerator statistics.
ERST
    },

 --------------------
    

which might stop them separating from each other?

I can also imagine we could pretty easily add a check for a
definition that's missing an SRST/ERST section or an SRST/ERST
section that's missing a .name entry.

It also feels like it wouldn't be that hard to do:

s/SRST/#ifdef SRST/
s/ERST/#endif/
s@HXCOMM@//@

and then we can just #include the .hx files directly as headers
and fix up the docs script.

Dave

> 
> 
> > 
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  hmp-commands-info.hx | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> > 
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index 41674dcbe1..74c741f80e 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -267,18 +267,6 @@ ERST
> >          .cmd        = hmp_info_sync_profile,
> >      },
> >  
> > -    {
> > -        .name       = "accel",
> > -        .args_type  = "",
> > -        .params     = "",
> > -        .help       = "show accelerator statistics",
> > -    },
> > -
> > -SRST
> > -  ``info accel``
> > -    Show accelerator statistics.
> > -ERST
> > -
> >  SRST
> >    ``info sync-profile [-m|-n]`` [*max*]
> >      Show synchronization profiling info, up to *max* entries (default: 10),
> > @@ -294,6 +282,18 @@ SRST
> >      being coalesced.
> >  ERST
> >  
> > +    {
> > +        .name       = "accel",
> > +        .args_type  = "",
> > +        .params     = "",
> > +        .help       = "show accelerator statistics",
> > +    },
> > +
> > +SRST
> > +  ``info accel``
> > +    Show accelerator statistics.
> > +ERST
> > +
> >      {
> >          .name       = "kvm",
> >          .args_type  = "",
> > -- 
> > 2.52.0
> > 
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

