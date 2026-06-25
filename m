Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B69CDB47C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZ0l-0007GW-OK; Wed, 24 Jun 2026 21:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wcZ0h-0007Ev-K4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:36:07 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wcZ0f-0004N8-IE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=1cF8c1jxQTI3JZm5hH0rMXYZcQlbkIOofK0CnUDpv0Y=; b=HPJuimD544aTC1lI
 0vKu6OA2aL+yycB8Ya7fDabZg7XXJFldDL/ufhTkM/cVmk0jkhMb9nEiogQT8n9jvD0ZDdp8vKzq8
 Pe5GFG/zKcbA8Q/rRsVvvuC2XD1fcLCFGs2yo5DMmYDhkx8ra+5bVk8ORqGwJT/+YpZ264AIjgEpP
 5gbGhFgGFzeQ3fsJ5CKC7Qts5rnsMGNgvyCieClgiJNa8wW6qDAjyphaWRDrqdP05Ro/luQPVI0ao
 5i93gwmaWLe/8Q+M/bcLTmRw0L9ujXB3XbYFA46rDZiuWLhI45aINY1o1iuVtGZWnkEVmd2tr1JCW
 sv4L1dC0Kgye6cUkZA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wcZ0Z-00000009sKK-3Mch;
 Thu, 25 Jun 2026 01:35:59 +0000
Date: Thu, 25 Jun 2026 01:35:59 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com
Subject: Re: [PATCH 1/1] migration/cpr: Add HMP support for cpr-transfer
Message-ID: <ajyF_xQR9dgOp-z_@gallifrey>
References: <20260621072646.517545-1-dongli.zhang@oracle.com>
 <ajp7GduDZGjei3Gz@gallifrey>
 <f537ffc5-1f5e-4cf4-a197-6a06eff85079@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f537ffc5-1f5e-4cf4-a197-6a06eff85079@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.88+deb13-amd64 (x86_64)
X-Uptime: 01:35:10 up 40 days,  4:47,  3 users,  load average: 0.07, 0.03, 0.00
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

* Dongli Zhang (dongli.zhang@oracle.com) wrote:
> 
> 
> On 2026-06-23 5:24 AM, Dr. David Alan Gilbert wrote:
> > * Dongli Zhang (dongli.zhang@oracle.com) wrote:
> >> Currently the cpr-transfer source QEMU instance cannot be driven entirely
> >> via HMP.  The source must use QMP in order to specify both the
> >> main migration channel and the CPR channel.
> >>
> >> Extend the HMP migrate command with an optional CPR channel URI. When the
> >> migration mode is cpr-transfer, HMP uses this URI to build a
> >> CPR MigrationChannel in addition to the main migration channel. The new
> >> argument is rejected unless the migration mode is cpr-transfer, so existing
> >> HMP migrate usage is unchanged.
> >>
> >> For example, source QEMU HMP commands can be something like below. The
> >> "unix:/tmp/cpr.sock" is for CPR URI.
> >>
> >> (qemu) migrate_set_parameter mode cpr-transfer
> >> (qemu) migrate tcp:0:50002 unix:/tmp/cpr.sock
> >>
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> > 
> > Yeh this looks OK to me; I don't see a check for if you do:
> > (qemu) migrate_set_parameter mode cpr-transfer
> > (qemu) migrate tcp:0:50002
> > 
> > Does that get caught by the qmp_migrate or should you add a check here?
> 
> I did test this before sending the patch.
> 
> With cpr-transfer mode enabled, missing the CPR channel is caught by
> migrate_channels_parse().
> 
> (qemu) migrate_set_parameter mode cpr-transfer
> (qemu) migrate tcp:0:50002
> Error: missing 'cpr' migration channel
> 
> ... including when the second uri is not a UNIX domain socket, reported by
> cpr_transfer_output().
> 
> (qemu) migrate tcp:0:50002 tcp:0:50003
> Error: bad cpr channel address; must be unix

OK, great.

> > 
> > I do have a slight preference for using flag optional parameters rather 
> > than positional, e.g.
> > 
> >    migrate -c unix:/tmp/cpr.sock tcp:0:50002
> > 
> > but I wouldn't insist on it.
> 
> I will follow this as Peter also voted for it.

Thanks - using a flag like that is much nicer, because it gets even harder
if someone wanted to add a 3rd path on in the future.

Dave

> Thank you very much!
> 
> Dongli Zhang
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

