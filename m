Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEC2CF3959
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 15:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srIqA-0000ng-SV; Thu, 19 Sep 2024 11:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srIq8-0000ft-Ow
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:13:04 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1srIq6-0008Ra-CM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 11:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=h0jpzkag006RczGeMCnr6BKjrfdEO/NylZjdESEjlyU=; b=qlLIudBzAU8DITXj
 v6NyY0hqStoQk93Eig6WJLK/csjpwT78RK3EtU2qVc631oeOMpUpraRJwBVCARYIrGSN2VoG+3Pae
 NywIc79kmOkCK2gjdrGAw2YI9R01MVvk6Ncewy0Ak+UIXbXTjOrgTMYSCzilm8ER/Y5gWKbxsADZy
 ZE/nBaycUcbHFqnPhCcTBNZs79WXr/g6zM5KQANnyFFdF+GJy6sEmZCWRisjyNJBe8unyYJpvTRi6
 ZshSEzkJTnbPcaOZye/RpQ8s69L0lY7oDJ4o+jpj4T/t93EX5ORz1fXBbgvAXMrM6pSTM/uFaWpxN
 LonQ3WAlntbLL+cxyw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1srIq2-006RQ2-25;
 Thu, 19 Sep 2024 15:12:58 +0000
Date: Thu, 19 Sep 2024 15:12:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Jag Raman <jag.raman@oracle.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: of remote_iohub_finalize
Message-ID: <Zuw_erEDSNMyQldP@gallifrey>
References: <ZusHMRnxjeS5qOd6@gallifrey>
 <38410E7A-7058-466A-ADAC-AFA494BF4890@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38410E7A-7058-466A-ADAC-AFA494BF4890@oracle.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:12:51 up 134 days,  2:26,  1 user,  load average: 0.07, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, SUBJ_LACKS_WORDS=1.831 autolearn=no autolearn_force=no
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

* Jag Raman (jag.raman@oracle.com) wrote:
> Hi Dave,
> 
> Thanks for checking!
> 
> remote_iohub_finalize() is a relic from when remote iohub was a separate type. We aren't calling it anywhere; we can remove it.

OK, I'll send a patch later.

Dave

> Cheers,
> Jag
> 
> > On Sep 18, 2024, at 1:00 PM, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> > 
> > Hi Jag,
> >  One of my scripts noticed that 'remote_iohub_finalize' in
> > hw/remote/iohub.c is unused; before I go and delete it as deadcode,
> > is that actually just a missing call somewhere?
> > 
> > Dave
> > 
> > -- 
> > -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> > \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

