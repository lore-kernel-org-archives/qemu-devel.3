Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B89606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=SjpfX6MZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQRtW-00055n-1B; Mon, 09 Nov 2026 11:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQRtQ-00054z-Nk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:06:48 -0500
Received: from 2.mo508.mail-out.ovh.net ([5.135.90.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xQRtN-0005Q9-Ls
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:06:48 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.54.187])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jNZQy4176z7tDV;
 Mon,  9 Nov 2026 16:06:34 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 17:06:33 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <armbru@redhat.com>, Guillaume
 Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 0/2] nbd: Add an unstable query for the client state
Date: Mon, 9 Nov 2026 17:06:07 +0100
Message-ID: <20261109160609.1434289-1-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 17260608525730922936
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFUgqbp/RCEjtmVmhhZ6iG+x+mDtn0/Ntwp5sMLFEGIaE+bYel/TL5z0INh0IkRkC81RN2f3k2yBnWCA0hZhw60WWykCVCFEC2EVG1CjvsaG6XRqfRpxcYkfCTRS59aU6lMgbM9BobQbrhwy+D3BLRwyhGewhYGakX+ZfSA+Cnv9piYl3txw0sSOFK0G2XPmwY9cSuoFTubZcH5inXjOP8RP/ux5Hz6lIXj+Sv7E9/ghs1+dcWxYQDPA3rCf5zHWw1mO/vZpQ27wTmr5x4nM7Dt2IrUNEqsedJR8+hehWBZJCTObqFAEy/t89od4+3Azl3G4p+AgE/X+pVMgsGASlmfIcSpw4cerNaamax01msNG9ASPRLpVMLw+c2wfmMpRJy6yIqvloTS5MNC13JBc72RF5zT5Uy0+5LhLf9Ze4ZP/tCemD17u8ETnfs9kVyYW0qR5L4edzqK58Ku7FXMZOWaZfecDoLYWZ9osB23arytnPbNLONAQlZKUB5Zxa8WwXM8aFMNGwn4mPkAJVxQC05T8TXq+uT4P4uPwOQUtU+5XBWFCZTe5UVuzM477U52G+G0DMchUlqoYb4olWI267X4cf3tUBU+5EB4pJ3bpE2yaIExaAJapkiKhOS8H1PLu/P0K1tW/xPAdSTkuqyTZGi1YDmp0Ci+lTXSIJ81lLtxSA
DKIM-Signature: a=rsa-sha256; bh=LIb7dtDzGwnp9HYHfcvDiDT2RA4p2U59fSmpJ0seZpk=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1794240394; v=1; 
 b=SjpfX6MZF3d4o30SCjKDCLMpKEqrfrLoNLpw3lB2givwBfrUOckrLEgnV65FHow9mguzrAlp
 sanbyL+6Se92f/2IcrtPxEL2/ddwGMsxCbH5VFiQek4CL0418cLKVZw1pMgUXR9qgTnzH5Aay2r
 9UUL2D8mvnNu5XeEmzeRNH8Y=
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

The created QMP command output lists the client internals. The optional
connector field is used to give the NBD client connection thread
details only when relevant, i.e. when running or when a channel is
ready to be picked up. Other fields such as in-flight or negotiated
size can easily be added at the top level while others like the
connector's last error would be added into the connector one.

Considering this command accesses the client's private state, it is
implemented in block/nbd.c where BDRVNBDState is defined.

Guillaume Vincke (2):
  nbd: Add an unstable query for the client state
  iotests: Make nbd-stale-connection test deterministic

 block/nbd.c                                   | 57 +++++++++++++
 include/block/nbd.h                           |  9 +++
 nbd/client-connection.c                       | 18 +++++
 qapi/block-core.json                          | 79 +++++++++++++++++++
 tests/qemu-iotests/tests/nbd-stale-connection | 17 ++--
 5 files changed, 175 insertions(+), 5 deletions(-)

-- 
2.43.0


