Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91656606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qz634MwR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CkZhN1Ux
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryk-0006RK-S2; Mon, 19 Oct 2026 14:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryc-0006OV-C8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIrya-0005oa-71
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kVe91FgL1GFZkmSSwIkuV/RkX2OsckqJV2w1HHz7QNM=;
 b=Qz634MwRDepYTceO+7vzwZ1T31tYmRw3SICJYKv5sGrBw+Te1kYoyKpeO3FtIEtSmCdVjR
 /SNxwcXMs13nd6zWC3zSeKxbAssSH6Oc1NlpvEBsBwnm0DmihoqD6RESn20kU6hBTZ7Lyl
 QX5VrU++7l5Je5uYSCmQF1Qi6invluk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-zj9Fjpu5NoazOPd8JjJLRg-1; Mon, 19 Oct 2026 18:20:39 +0000
X-MC-Unique: zj9Fjpu5NoazOPd8JjJLRg-1
X-Mimecast-MFC-AGG-ID: zj9Fjpu5NoazOPd8JjJLRg_1792434038
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1bfd5516bso24287825e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434038; x=1793038838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kVe91FgL1GFZkmSSwIkuV/RkX2OsckqJV2w1HHz7QNM=;
 b=CkZhN1UxBMAwTglL1NMQNkJD/mzEY9IQDG/Snt+gdetfyVJvc5gU7N1aW/bNBF4tzW
 4Fhzr1j+6Lt1LoxpP3Tkx4MhlCVhbPX/UNf7HGyEITxPPAOl6afzpXx0B3O2ClxDV3r5
 lWx1gb2oTLCUFLuufXSgeqQEY8pNQ2BpFun+B+W/N8/JiT8d8x4CrgkZv28no0mOer6t
 dZ5n19CjFEqjYNUsb/fa8ncMZ4XEIwq29ROn/nYfWBxp0xbBRQYB7g26Gqq/K3BvtPQ/
 kUjpWnU7IvV+nO5EDSlUdyhVgDMPkTFzL9EMs0GSsFUXOLyhjD/t+I0evi8R+JgRUhNb
 PCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434038; x=1793038838;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kVe91FgL1GFZkmSSwIkuV/RkX2OsckqJV2w1HHz7QNM=;
 b=Za5DBfIZGHzOyOT+ocSd4viSwShPb3et3MTRP318DxFoPt4CzQ8GWjXuuhEShjPqfa
 S3wu3mQ3KT4MsAJ8rZ+pK1DZghd9YV7e44rhPOGwYLjJlUr2qLr2wlkNfvv88oP4hLLQ
 GornzrsRDTFH0o+oLOOsIXRRIGoroKZlFbZmiWnEmsYpqKDjIigwA69RzG928it8dTYB
 2mUzu9s9NSPOEqoChEvevMftS1LWU5nMTF7gljHrQLfHjLy44yPA7vTN3QgbfhOaRE60
 JCn25QPBsOKLhnTsMT435L5J0lqRx/j7spENK/aTpCYZ8NNsgUPbFNrcM/Z5ijew+ssl
 gdpw==
X-Gm-Message-State: AFq9FYKYphuoFyMMOA07h/WEH+1d/hKg7OUQd5MpvszQDcodyOilapVO
 Pf0ZyKWkEq8uZbBLNA1Awg4RhHCfpT9yPqFosSLRmZ+T7tcXJGH2rTzHzptKka55/k56fMKDFKE
 j3m344OBPNBguTRrlIFIve80DRLwqhtwOpRARwsWDxVgTUr0VQji4HAq8
X-Gm-Gg: AYBFou2QNrq2bhbkZpcFleQel/a82eoJRvOEpOnDin+M9HqS337XnDqYN58Wy3X0uPD
 cNAUt8KDMhA2p0eSG8WI+DHHUcJg8cPn7UZGvmEELO+MrjBkYNLMVSCWSt7QkUqqh87w31YmRRk
 h5bE4FIq/5EjdEunX0+e+Fsrj+Y8oP4QzEX8kcXeCNccMPBPdzoANupXXiM0ICirbdhCxzf5qW7
 mCOK+jNCJqHdA1KGTWHddVXIc9nt040D8ci0Tjr3ctQd9JWNmJ8T8K0dyILRyT5jSz/jgydc38v
 naafOGOmfsUIDSAdWHABvOPuZ3xZt4tTcfLcacBjw2itPNwqNbX3wOL/oBEDukEh8886ynKeqZY
 xpvVJYiyvDWuQDQm7PuG57pXTpeNtYLC7XdqFUwZVPXpyfH5cwG3/cf7sbQ==
X-Received: by 2002:a05:600c:8b6b:b0:4a1:e7ce:10a4 with SMTP id
 5b1f17b1804b1-4a1e7ce1832mr78499215e9.29.1792434037623; 
 Mon, 19 Oct 2026 11:20:37 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:4a1:e7ce:10a4 with SMTP id
 5b1f17b1804b1-4a1e7ce1832mr78498845e9.29.1792434037159; 
 Mon, 19 Oct 2026 11:20:37 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d838dd6sm453067f8f.58.2026.10.19.11.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:36 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 00/12] block: BLOCK_IO_DELAY event
Date: Mon, 19 Oct 2026 20:20:16 +0200
Message-ID: <20261019182028.45305-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

v1: https://lists.nongnu.org/archive/html/qemu-block/2026-08/msg00701.html

I’m told there are installations where storage is very slow, and some
would like the VM stack to report this proactively.  To do so, we should
(via QAPI events) report on extremely slow I/O requests.

We already have the latency histogram, but this is not deemed sufficient
because it is not proactively reporting and would require repeated
querying.  Therefore, this series introduces the event still.

In contrast to v1, this version adds the delay tracking to the
BlockBackend request code instead of using the existing cookies from
block/accounting.c.

As explained in the v1 cover letter, in order to be able to raise a
BLOCK_IO_DELAY event exactly when a request crosses the threshold, we
need to keep requests in a list, which requires trivially verifiable
resource management, i.e. trivially being able to see that every request
that is begun being tracked (and thus put into that list) is also
removed from that list once the request is done.  This was not possible
with the accounting cookies, so instead, as suggested by Stefan, this
version adds its own tracking directly into the BB-level requests.

The downside is that accounting and delay tracking thus track different
kinds of requests.  If that is unacceptable, the only alternatives would
be:
- To do it with cookies, which is basically impossible, as explained,
- To change the cookies to be tied to BB-level requests as well, which
  would (A) be an invasive code change, and (B) change the existing
  reporting in an incompatible way.

Personally, I found the divergence to be more acceptable than having a
go at said invasive change, and having to defend the incompatible
reporting change.


In addition to what v1 provides, with this threshold-level reporting, we
can now also have the VM stop on exceedingly delayed requests, so the
guest would not see that delay, as a last-ditch effort for guests that
find extreme latencies to be catastrophic.  (Which is to say Windows
does that: It throws a BSOD when exceeding a certain maximum latency.)


Note patches 3 and 4 that might not really fully fit into this series;
they fix a pre-existing bug around the runstate transitions between
IO_ERROR and SUSPENDED.  An AI review tool informed me that the
transition between SUSPENDED and IO_HANG was missing in patch 5, but
given that I had just copied what IO_ERROR does, I felt bad adding that
transition for IO_HANG, but leaving IO_ERROR as it was.


git-backport-diff against v1 is not so useful here, I’m afraid:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/12:[down] 'qapi/common: Clarify what IoOperationType is for'
002/12:[0004] [FC] 'qapi/block: Add IoAccountingOperation enum'
003/12:[down] 'runstate: Allow IO_ERROR/SUSPENDED transitions'
004/12:[down] 'iotests: PC-only test for I/O errors during suspend'
005/12:[down] 'qapi/run-state: Add io-hang state'
006/12:[0017] [FC] 'qapi/block: Add BLOCK_IO_DELAY event'
007/12:[down] 'qapi/block: Add BLOCK_IO_DONE event'
008/12:[----] [--] 'block-backend: Public blk_get_attached_dev_path()'
009/12:[down] 'host-utils: Add u{add,sub}{32,64}_saturate()'
010/12:[down] 'block: Per-request delay tracker'
011/12:[down] 'block: Add delay-report-ns and delay-stop-ns props'
012/12:[down] 'iotests: Add io-delay-reporting test'


Hanna Czenczek (12):
  qapi/common: Clarify what IoOperationType is for
  qapi/block: Add IoAccountingOperation enum
  runstate: Allow IO_ERROR/SUSPENDED transitions
  iotests: PC-only test for I/O errors during suspend
  qapi/run-state: Add io-hang state
  qapi/block: Add BLOCK_IO_DELAY event
  qapi/block: Add BLOCK_IO_DONE event
  block-backend: Public blk_get_attached_dev_path()
  host-utils: Add u{add,sub}{32,64}_saturate()
  block: Per-request delay tracker
  block: Add delay-report-ns and delay-stop-ns props
  iotests: Add io-delay-reporting test

 qapi/block.json                               |  90 +++++
 qapi/common.json                              |   5 +-
 qapi/run-state.json                           |   7 +-
 include/block/block-backend-delay.h           | 112 ++++++
 include/hw/block/block.h                      |   8 +-
 include/qemu/host-utils.h                     |  62 ++++
 include/system/block-backend-global-state.h   |  11 +
 include/system/block-backend-io.h             |   9 +
 block/block-backend-delay.c                   | 326 ++++++++++++++++++
 block/block-backend.c                         |  50 ++-
 blockdev.c                                    |  16 +
 hw/block/block.c                              |   7 +
 system/runstate.c                             |  27 +-
 block/meson.build                             |   1 +
 tests/qemu-iotests/172.out                    |  76 ++++
 tests/qemu-iotests/tests/io-delay-reporting   | 187 ++++++++++
 .../qemu-iotests/tests/io-delay-reporting.out |  90 +++++
 .../tests/io-error-during-suspend             | 155 +++++++++
 .../tests/io-error-during-suspend.out         |  22 ++
 19 files changed, 1244 insertions(+), 17 deletions(-)
 create mode 100644 include/block/block-backend-delay.h
 create mode 100644 block/block-backend-delay.c
 create mode 100755 tests/qemu-iotests/tests/io-delay-reporting
 create mode 100644 tests/qemu-iotests/tests/io-delay-reporting.out
 create mode 100755 tests/qemu-iotests/tests/io-error-during-suspend
 create mode 100644 tests/qemu-iotests/tests/io-error-during-suspend.out

-- 
2.55.0


