Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A5606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=EjBCDPeF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPG2W-0003BQ-Bh; Fri, 06 Nov 2026 04:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPG2U-0003BA-71; Fri, 06 Nov 2026 04:15:14 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xPG2R-0003s7-PI; Fri, 06 Nov 2026 04:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793956506; bh=jPh9+1fND+aPHG6qJKIpKZKjxJeT/bu4w+giv2qFt7s=;
 h=Date:To:Cc:From:Subject;
 b=EjBCDPeFQYvFaaJU2u9BaBUo4nhxGEoQrmOBGm1Ieh4E9A55KXb1HGT1mNTOi3JZk
 dWT90zMz+QApsqxFV7kV4C5J88FKQ1MaydG3WJr6KzEEp4s7Ba+MDYmQsQH1b4dRGW
 XK9RM4nKXTefg61ZLaU6kcIQ7npUpJg7gOmkyVawFM7+4TVuCl8cEAEdZuiPfOX7wy
 t1tB5wlHRyqy+wYxHrY/GAn0gFuPFSPzZNdsUq97knYKBJ7fLT14ba0ZjJqr/HVqK3
 kSM6WqXRXjUAZ8gpxImnHMV2uXUYltI2ee+jyqwsxxO8OiVleDA4HMPvBIEFta5Kor
 HJRmLHyjpWkZQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 713FB1E4437;
 Fri, 06 Nov 2026 12:15:06 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 66E474553C3;
 Fri, 06 Nov 2026 12:15:06 +0300 (MSK)
Message-ID: <cfcac305-df2d-4b95-b27a-21518cb73841@tls.msk.ru>
Date: Fri, 6 Nov 2026 12:15:06 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Oleg Drokin <green@linuxhacker.ru>
Content-Language: en-US, ru-RU
Cc: qemu-devel <qemu-devel@nongnu.org>, QEMU Stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: fixes for stable qemu series
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Hi!

What's the way you use to find these patches, with security impact or not?

I usually quickly screen all new commits in the master branch, and often
catch things which aren't marked for-stable, - not everything of interest
is marked as such.  I also tend to remind the maintainers about these
markings.  But my resources here are limited, I can't try to understand
every patch, even description of it.

How do you perform a security review?

Thanks,

/mjt

