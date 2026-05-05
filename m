Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D1ECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJtl-0007G2-UM; Tue, 05 May 2026 13:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wKJtc-00079s-1D
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:49:25 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1wKJtZ-0000o3-C6
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Mf5GRoDNdIQAywpfASe7YWsqqRp6HwYz3cFmBTDqwGw=; b=sDz4JSDPkymWraDd
 7D0WFA5p4yW3+5TOchI4S3fLieTnFrf+ZIHkvJvDK9elmdE6M/IuT7xGiVQ4btsEeAh/GdLeWHey5
 vBjLfXpFdjOdWzDzrTSZI9AiZ551EDaw8DZFnU2f4Lgd8YOvmQwXwfPzr/bamFIUj01WuCDVL+KEE
 xbClwZl5KoLi2nb4pTzyXO6lRtcXi7DgMDmmlXlp6d7Jqbl3jTNd9ZEFyRFbqQs7zmL9/mPGfRMli
 X+uKEMDEKCufvjFUzDZBzrrxCvW2dDYwTh1GW0VQrHwWLu1Eq/x2O4AESkrw03DfhdqBsevvRrJNV
 AB3wGxmT/tr/ETpwbw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wKJtR-00000000uQE-2nnf;
 Tue, 05 May 2026 17:49:13 +0000
Date: Tue, 5 May 2026 17:49:13 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, AlanoSong@163.com
Subject: Re: [PATCH 0/4] HMP roll up
Message-ID: <afotmdasrymFJ4Z5@gallifrey>
References: <20260504174914.122607-1-dave@treblig.org>
 <87wlxi0wsc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87wlxi0wsc.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.85+deb13-amd64 (x86_64)
X-Uptime: 17:49:07 up 4 days, 21:35, 2 users, load average: 0.04, 0.04, 0.00
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
> > Hi Markus,
> >   Can you merge this little set through your monitor set?
> 
> Sure!  PR sent: "[PULL 0/4] Monitor patches for 2026-05-05".

Thanks!

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

