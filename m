Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4399606B1A8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=taktcycles.com header.i=@taktcycles.com header.a=rsa-sha256 header.s=takt1 header.b=Q0nGVvZl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrjA-0001H3-Mz; Fri, 13 Nov 2026 08:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRmPs-0003gy-OD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:13:50 -0500
Received: from mail.taktcycles.com ([136.243.71.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rdmitry@taktcycles.com>)
 id 1xRmPr-0006Ot-26
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:13:48 -0500
Received: from mail.taktcycles.com (unknown [192.168.64.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
 (No client certificate requested)
 by relay.taktcycles.com (Postfix) with ESMTPSA id 726328ABF;
 Fri, 13 Nov 2026 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=taktcycles.com;
 s=takt1; t=1794557617;
 bh=zmIzkhzOGqc0v2kWXU3q8eDb3uk4eNWF9Xx/P+RMc3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q0nGVvZlRJmem2zeEg/cd+7/H/MTXzjoYmVGWD/LOD8LLXOHxqUSHqBW09wtMV+rF
 d/rjsf8bnc6uHJFMurNX+3tVV8q0fyCn55YTCcwsIVCF1YCK9NtkwO0DpI3Qf4Rukj
 yKO3GIf56kGKtIS7q3fLjv1PTwpCitP1qmWp3CO6EBlsilqDn3etw1UVIURaHg/BVA
 C8+IBEMxijFXMjuwwTr8AdxMR4pmChm6YX5j0Ride4vsGFKBBX2MQNKWuR/RCDTSlr
 4p4QBd8mbmrJZz962h9dDU3N5X6lgBeI8zlAawiLsZooh21mDAFmnS+EKUS61E9SKS
 WvJV7R8kcI8/w==
Received: from [192.168.64.27] (localhost [127.0.0.1])
 by mail.taktcycles.com (Postfix) with ESMTP id 187AE1DEDA;
 Fri, 13 Nov 2026 08:13:37 +0000 (UTC)
From: Dmitry R <rdmitry@taktcycles.com>
To: =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Dmitry R <rdmitry0911@gmail.com>
Subject: Re: [PATCH 2/7] contrib/vhost-user-gpu: reset the frontend socket on
 stop and start
Date: Fri, 13 Nov 2026 08:13:19 -0000
Message-ID: <179455759969.604939.10654785289183889711@taktcycles.com>
In-Reply-To: <20261112-issue-4848-v1-2-aeba1cfe2c03@redhat.com>
References: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
 <20261112-issue-4848-v1-2-aeba1cfe2c03@redhat.com>
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

On Thu, 12 Nov 2026 15:48:45 +0400, Marc-André Lureau wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4849

Without the series, on master 49559567 and with no display client:
after stop/cont the backend logs "vg_process_msg: assertion
'g->sock_fd == -1' failed", the guest times out waiting for cap set 0
after a reset, and the next stop/cont aborts the backend on
`g->wait_in == 0'. With the series: no assertion, the guest driver
comes up after the reset, and the backend survives the second
stop/cont.

Tested-by: Dmitry R <rdmitry@taktcycles.com>

