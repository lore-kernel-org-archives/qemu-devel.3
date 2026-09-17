Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623FDC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7JLs-000522-Qu; Thu, 17 Sep 2026 17:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x7JLq-00051g-Iw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:09:02 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x7JLo-0002Pk-T8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=uogshYKGl6rVz2gBg0PMRn0dEylTfc2ZZQ19mqKJotE=; b=aVRTtO4R4coRTBy7
 x36fWiNL1ftFZatm8zUd11+bhe4LTI7H7PpOcMT13hER4JVjjXC6rFmC+l9tBtCWkDr8EL6kvl9fV
 PVo5kkk0IVe6a707NWGU0ujY1To6fxToukG8acucHACIg3z7I6dxDlmJiuxqyd2QI7Z2pJG6w9B4i
 wHipyajro9DLLEDCBM7OShFIe/FIRYtYhVXOenzyUBujfQWLDzvkvmqGRTnB4K2QbVfYHeUFpWUGD
 6lnEXUR4g1wcv77OfwATamnOdc9yyP9eqvRDXS5Mv1SHie28eKg155772+OefRx5y4FuDDE7febnO
 8EJVI8iMJk6FIZnsYQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x7JLm-00000001iY9-2nWL;
 Thu, 17 Sep 2026 21:08:58 +0000
Date: Thu, 17 Sep 2026 21:08:58 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 12/20] migration: Change HMP 'info migrate_parameters'
 output
Message-ID: <aqxW6uZU_ttnPS6f@gallifrey>
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260915000209.3692668-13-farosas@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 21:02:57 up 5 days, 8:48, 2 users, load average: 0.02, 0.03, 0.00
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

* Fabiano Rosas (farosas@suse.de) wrote:
> 
> As the HMP output is not part of any ABI, remove the units from the
> output to avoid this requirement of having individualized code for
> every parameter. Next patches will take benefit from that and use
> generic code to output the parameters values in HMP.

Yes, it's allowed to remove them - although it was helpful.
IMHO the cause of what makes it hard is qapi not having any finer grain
typing, too many things are 'size' when they are in no way sizes!

While there's comments in migration.json - they're not structured enough
to allow the extraction of units, which is a shame.

Hopefully Rustification may someday lead to proper typing so that
times are compared to times and bandwidth rates naturally fall out of
divisions of sizes and times.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

