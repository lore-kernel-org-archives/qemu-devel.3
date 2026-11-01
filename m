Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42D606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b=tI/QuaD/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNdgX-0005t4-SX; Sun, 01 Nov 2026 17:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xNdgV-0005st-IA
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 17:05:51 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1xNdgT-0007tq-JI
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 17:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=g+aJJJEjismYA1D+YvRU+b606zgCMmg/xS5LVP369iU=; b=tI/QuaD/U+GHxnt5
 2KCfrt5VV0sa2jDbhR0c4aSUt5PHxYWksilowXX05d6JK2r7BzVA+2ZTsGbeLxaBnDgxa0+RRy5yb
 JDYUBeymApo7pvnhAWQS68VXJxKXRlB+IF2ZKYVAWJ3fb58VQwwqfimlGKxmRKI5QY+5GMBQbMTqM
 6rzRIu60V3uKlRzC2ySzfDNCF7UgTunkNMBvoqj0UJgjJGiyiydSQmCb4aoIA8NGSRduped/SBBxO
 V58Kmxhi5Xt1sbfmFs0a9cvP4TnRi0QdPHdILN+DCGjJ0ds2Gg4brvJi/v35CWomDO6IXxlLjT92u
 33yHhP2EUqjuZGGDUg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1xNdgN-00000004gdZ-3B6y;
 Sun, 01 Nov 2026 22:05:43 +0000
Date: Sun, 1 Nov 2026 22:05:43 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org
Subject: Qemu qurt and fastrpc?
Message-ID: <aue3t9EKkoeb0FnG@gallifrey>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.113+deb13-amd64 (x86_64)
X-Uptime: 22:01:13 up 16 days,  7:21,  3 users,  load average: 0.00, 0.00, 0.00
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Brian,
  I tried your hexagon support booting qurt images, very nice!
I did:

  ./qemu-system-hexagon -M virt  -kernel ./qccdsp8380.mbn -nographic

and got something believable.

  Do you have glue that lets you run comms to the emulated qurt via
fastrpc in the same way that, say a Llama running on a normal
Linux host would?
  It feels useful for debugging/watching what maths kernels are
doing.

  (Not urgent, I'm just trying to get my head around it on my
X1 laptop)

  Thanks in advance,

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

