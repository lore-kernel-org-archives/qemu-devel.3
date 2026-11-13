Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB2606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=p98BCuo8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRry1-0006nE-Az; Fri, 13 Nov 2026 09:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRrxy-0006bH-Qn; Fri, 13 Nov 2026 09:09:23 -0500
Received: from 2.mo508.mail-out.ovh.net ([5.135.90.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xRrxv-0004Mw-7R; Fri, 13 Nov 2026 09:09:22 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.54.78])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jQzdl48SFz7tBr;
 Fri, 13 Nov 2026 14:09:15 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 13 Nov
 2026 15:09:14 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <armbru@redhat.com>, Guillaume
 Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v2 0/2] nbd: Add an unstable query for the client state
Date: Fri, 13 Nov 2026 15:08:50 +0100
Message-ID: <20261113140852.702959-1-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 1876593670808879544
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFPxGSbK1a2c80rbR8s0ZaNLcakiVj95wwGIoBgWgQKD22nCOFRRyEglwsEWxsLOE59c7EYGL0B+N59XeHWptpe6GiUpyl1+ufK7tL9jnEmgHYqU/iD0o/nVVWPvlf1mKuM6wYypvTY1tjBSbL4jTgec6nP5FDDdHLOBAz/NnpB11xtATOjuXfTu/Ru9eLdijrR7jLQhN+QAgoSzpphNcv3QfKA5qGX4Emm30w7KHunZV4BAm7if6WEOrB2NVMEnC8YAujuZ/0PIADfu90aWIA9lBu3E0+6f6wqeQbMQmq3qLLwgtkhodT1ENqxcL+AbRTb/04lpQ1KcSw25++DbxLOR1OaTc8Mfz8+lSu2te0wvbZ2BkznNalgFVM2qEnD2JAAr8/qyVnGInWcFkvpSx1lhFm88HqPxbmEwQTPD4NHJLJPUjkmwo2sLO/2ZlzAhXXzyhkjco+SStVjkXV6eDlkaiyYAJ7dsHoxgIdV4ai7slOrgGza+yo5dH2AeMkWPqgw5rD2/KNH9M6zKyLybsXp6/I/Z9AFkCaUSg4LxfN/xKfD3z5LRYnesJ1hfuHEkcoFyuMIyhNoTRxc/yG6CerBS8ZPA66SSdpj6fx8xRVKL7jNSn+YTWLVBIdzTcVzlr5D+CVjJ0B05CAe38G8EHq3DUWAaVCfJp6p7IU0O7gr8g
DKIM-Signature: a=rsa-sha256; bh=nYK26kZcGiG7nmWejIMB3snANgFUF/nD/33sKB9+Ycw=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794578955; v=1; 
 b=p98BCuo8zAhX3m3b3o0A5MwjZe+d48Y8ZTL6IFG9l4pMlcUdcDBt97B3gVZIsXMC6nDNmfr2
 JSj9OfTgZWOFsZWCwsllpO1q3VjZ6kQI6ZFnn2hpEusNnqk51su03h+UVR83QCc9JxCVwhOxZJB
 4p4GiB8sve5jlCKBgLSGe4yA=
Received-SPF: pass client-ip=5.135.90.177;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo508.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MXG_EMAIL_FRAG=0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MXG_EMAIL_FRAG,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Based-on: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>

These changes follow the discussion on:
https://patchew.org/QEMU/20261105164124.249395-1-guillaume.vincke@ovhcloud.com/#au4tsMuhKjq62dVB@redhat.com
Even though Eric Blake suggested a query for NBD server state,
considering the nbd-stale-connection test we are trying to make
deterministic relies on qemu-nbd, which does not have QMP, this
patchset adds a command to query the NBD client state.

The created QMP command output lists the client internals. The
connector field is used to give the NBD client connection thread
details, i.e. when idle, running or when a channel is ready to be
picked up. Other fields such as in-flight or negotiated size can easily
be added at the top level while others like the connector's last error
would be added into the connector one.

Considering this command accesses the client's private state, it is
implemented in block/nbd.c where BDRVNBDState is defined.

v1: https://patchew.org/QEMU/20261109160609.1434289-1-guillaume.vincke@ovhcloud.com

v1 -> v2:
- patch 1: Connector is now always present, with an idle state. Read
client and connector states under the same lock. Add the NBD state
information to the QMP documentation. Fix documentation wording and
version number.
- patch 2: Simplify the connector lookup using the new QMP command
output.

Guillaume Vincke (2):
  nbd: Add an unstable query for the client state
  iotests: Make nbd-stale-connection test deterministic

 block/nbd.c                                   | 57 ++++++++++++
 include/block/nbd.h                           |  9 ++
 nbd/client-connection.c                       | 22 +++++
 qapi/block-core.json                          | 87 +++++++++++++++++++
 tests/qemu-iotests/tests/nbd-stale-connection | 17 ++--
 5 files changed, 187 insertions(+), 5 deletions(-)

-- 
2.43.0


