Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E4606A332
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDb+Mviy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xV3Wf-0001ZV-SF; Sun, 22 Nov 2026 04:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W3-0001Vl-N6
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:44 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xV3W2-0000xv-5t
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 04:05:43 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c511cdd5a82so263375866b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795338340; x=1795943140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2SKL7kARjOm7FPfIWW+JyJAeiNcJUngT4Q6XS2xibkk=;
 b=gDb+Mviy3evM934Q+4jKPMCqv1clVVqCMfpr+xbWRsdkjcTtaGDmpAko945OsfEolG
 unFE0JpLgj5hGhQ5VZInxdR/lQiohoWCSmhyyY3/ipkJhlv69jtEUE2S8MSW0U0vials
 fX1kn/UAeyu15ZEnQJTLTxu3E3l5RGRDew7K3p4UTyO0WpKcbS3455nC2pyhwJxjzejX
 4N/QnM+51Jsa1j44QWJ7/w49uraJSWJLG8YJeZTMydYpyXRKX21IW1sbJIpFXe3n6c2B
 rac70X3LotBApHhnRo50zpQC01FRKENkiw4VRfBjH5HilCdyOozr9kObn7SNLraWzQOf
 4/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795338340; x=1795943140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2SKL7kARjOm7FPfIWW+JyJAeiNcJUngT4Q6XS2xibkk=;
 b=CdsuB0lSyrIoV6S18FC/7LgxP+f7cdvZ0vOAW22i6xt6jh34Qn8aHIwC8UwjuQ0csm
 Z8zBlzGLLPsYVJNKoPQmsf/yJVh/slBuVUANJ34bTmvWKjxqk+guRgR6N/qV0YLu90KB
 RHWc1+zy2yoxiYHbjFEMHllkYifgvfocLPj65/xq8n2itMpTbIhMU+NHWNT/iRUYJZJj
 B3HXzsjJ5V4qFGizzkzJRtCaQviwILRsX2JeM07/7AkLVdDoEijGmvwnifBOSW0Dl/CZ
 Pwu+2vUtW658ZUN61vjtV9V9lYzbIkHHCa8YT6hl0l/YYM520lAxr9UarkKdb8HT7PDp
 n24A==
X-Gm-Message-State: APuU4Z+8TVZ7rsiVrxXeWN77TCJeOskiJ6yKkCeoCccfFL/pqen7vLz1
 95VzJw/gp9Z5NpBIyIav7g5PK6D9EzDw1sca5eahtDLgSsU3cy2JXzskCIsTiEah
X-Gm-Gg: AZFdTZfbZIANQ+iwD5FK1sKTHkCix2eV+0SiUajjSYlgyabHI0HZUaO9EM7J7WJk6dX
 CA8ECqr0VFcRUXOJ2NYzCJQYr7nxi7J9sCmK+KfiKKBE0yNfirRfn52TMveoP6oU5w0wSiYgQY4
 l70yPoHtMMtxelAMh1LRGRULVI8aPDoVxyjPkR/aIIqKodtGMXEULsyH4dnZEz82vw2hb9Sd7Vg
 rU6t210czxB4M+8o/dKUrUZiRMMovq7Gt9rkODbH48MMbW3TFG0PqmqJOwLgHBTxnL+uAi9im/9
 Iwo6uTA2lVx2+SOizUQrwf79wgmBK7J4Q9hPRQQulagQOErb78lVIjiJv9+gkgxt8TRJfT9QMmQ
 AIETP7Od15ekyOr89kid2vUwhf8dQPtNi7EJX+6Zfsor54CZa65geZ5PSbzl2luXa0iPxftZjb1
 JWyGkJHcYsObrevLH99ydKiN+hmmP1CCxyiJesC9MzYGR+4dNkM0jG2f9J4TfRfEmneiSXHL9Qc
 q9C0gxdYwPEkz33x4MJETibWZnm1Tp/neXSu9P95LqY+NTbexEM5UtoDL4A0N05gc0r8WkyJ8ve
 gV7Ex+n4YSfJXuRLVzfzvjDzALIhwKLuh+pUMYJ5a08FJ6gIzRNX28EnQ4/0HecJ/EuWR6QstY2
 JKiJaw+5492jNyiD982hU2za/L0+P4ZgfrygTYYY5AYynTd0z2eApy0pD8xiB
X-Received: by 2002:a17:906:5492:b0:c51:caa:607 with SMTP id
 a640c23a62f3a-c513ab0c394mr501381366b.19.1795338339867; 
 Sun, 22 Nov 2026 01:05:39 -0800 (PST)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ad010a6sm298893666b.7.2026.11.22.01.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 01:05:39 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>
Subject: [PATCH 0/5] qga: implement more APIs for FreeBSD
Date: Sun, 22 Nov 2026 10:05:05 +0100
Message-ID: <20261122090511.15121-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds FreeBSD implementation for:

 - guest-get-vcpus
 - guest-get-cpustats
 - guest-get-disks

It also adds new test-qga tests for 'guest-get-disks'
and 'guest-get-cpustats'.

Tested locally on FreeBSD -CURRENT amd64.
Tested with libvirt/QEMU Linux host and FreeBSD -CURRENT amd64 guest.
Compile tested on OpenBSD 7.9 and NetBSD 11.0.

Roman Bogorodskiy (5):
  qga: implement 'guest-get-vcpus' for FreeBSD
  qga: implement 'guest-get-cpustats' for FreeBSD
  qga: implement 'guest-get-disks' for FreeBSD
  tests/unit/test-qga: test 'guest-get-disks'
  tests/unit/test-qga: test 'guest-get-cpustats'

 qga/commands-bsd.c    | 171 ++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json  |  61 +++++++++++----
 tests/unit/test-qga.c |  66 ++++++++++++++++
 3 files changed, 285 insertions(+), 13 deletions(-)

-- 
2.56.0


