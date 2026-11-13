Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D966074118
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=c6c3Jebx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrj4-0000y0-2t; Fri, 13 Nov 2026 08:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRmPw-0003hY-Pp
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:13:54 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRmPu-0006PI-Nq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:13:52 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id C9B578966;
 Fri, 13 Nov 2026 08:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1794557619;
 bh=MPgTJli1Q1QnHeljrnFQkES2h5IWY6gOVSHftjjwRhc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c6c3JebxckQHmVi78829oU+fNXYpQz5fk0Wuuw4RzUR3I0kNjvG+YtPg2lSs2EFuu
 yKm5QHVFHu8pI4sNLse8eV91X4bmUW7bJQ0QRq6iSGSYI4yjyrXbZpHa0XFOJENuik
 x3YRNnlfOzLRgWsnSknUvbclSm0n+3Y2a7b5q4trJmMNL8s1ZEX44sKtghmY240/hb
 AoRWTK4ddR+HJ42pE3NIidyucOZdFODuZKFCmzAaBUNx1lqxYDqp7rLQZ4PPpB/zru
 i9wOap+u9RmF5mb5G9HkEAgtKuPR74Py8cM0bR7P2oqo/GKfBEWVzCUKTzy7JkW7Hp
 JAx3nd0D6x/Ag==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id 6E5A81DEDC;
 Fri, 13 Nov 2026 08:13:39 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Dmitry R <rdmitry0911@gmail.com>
Subject: Re: [PATCH 4/7] hw/display/vhost-user-gpu: don't set an fd handler
 without a socket
Date: Fri, 13 Nov 2026 08:13:19 -0000
Message-ID: <179455759969.604939.16454694289095340233@taktcycles.com>
In-Reply-To: <20261112-issue-4848-v1-4-aeba1cfe2c03@redhat.com>
References: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
 <20261112-issue-4848-v1-4-aeba1cfe2c03@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=136.243.71.244;
 envelope-from=rdmitry@taktcycles.com; helo=mail.taktcycles.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:54 -0500
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 12 Nov 2026 15:48:47 +0400, Marc-André Lureau wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4847

Without the series, starting a VM on master 49559567 with a D-Bus
listener already attached gives about a million "failed to read msg
header" lines within 90 seconds. With the series there is none after
51 acknowledged UpdateDMABUF calls before DRIVER_OK. The run then hit
the abort I reported in reply to patch 3.

Tested-by: Dmitry R <rdmitry@taktcycles.com>

