Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165A2606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=cQqKO6y6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTvQG-00023t-71; Thu, 19 Nov 2026 01:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTvQ9-00022b-06
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 01:14:58 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xTvQ5-0007Yd-FM
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 01:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795068882; bh=QptSNibHapONhNENVd26RjsUF5XVpZ3Itey/pviYsEs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cQqKO6y6AitTWvuThHLsCo2gx3MJpf1LUZAtkwO/PwHGbFO31AWSDX3+IJnvd3JAk
 UCB5G7e5whkNXskbz0iJvqCioj2u5WGN1nJ8EFQh/hkNE4p1eaW7EtDqS7rktgJNMh
 QXX5Xt3zVJrlE9EcUFTTQackHlJoGzO+ze/raDjc=
Received: from blackfin.pond.sub.org (p4fd045cf.dip0.t-ipconnect.de
 [79.208.69.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 920512073E;
 Thu, 19 Nov 2026 07:14:42 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0B8021E6A04; Thu, 19 Nov 2026 07:14:48 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org,  kkostiuk@redhat.com,  michael.roth@amd.com,
 dholler@redhat.com,  fdeutsch@redhat.com,  yvugenfi@redhat.com,
 kramdoss@redhat.com
Subject: Re: [PATCH v4 0/2] qga: Add Windows driver information commands
In-Reply-To: <20261118080610.1322669-1-eashurov@redhat.com> (Elizabeth
 Ashurov's message of "Wed, 18 Nov 2026 10:06:08 +0200")
References: <20261118080610.1322669-1-eashurov@redhat.com>
Date: Thu, 19 Nov 2026 07:14:48 +0100
Message-ID: <87pkw1cppj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
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

Doesn't apply for me.  What's your base?

