Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DBAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weJeo-0006mW-9o; Mon, 29 Jun 2026 17:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJem-0006m6-Tj
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJel-0003jj-6r
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r1/3WCB7J1KfpyxbMqsTPjUmH4YQamwrqSS/U8KRduA=;
 b=C6NQ58saWSthjZjw0EAFnsx3jpDIUJ/m1GXZCgdSZp100a79kMXY7kRxD1dJ03b0bsY+Qh
 Z9P5MIpqH0z1XOM5DECYAHsUsVOtcjTFxE12nX7AB2oifWvvlJIjpEnq0WO2eeobgF4z7i
 iUvK1ij42sMbQiZl81XrAxK+7L4pLMw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-YXo-i3FUPFOxKOMOqIO0Sg-1; Mon,
 29 Jun 2026 17:36:36 -0400
X-MC-Unique: YXo-i3FUPFOxKOMOqIO0Sg-1
X-Mimecast-MFC-AGG-ID: YXo-i3FUPFOxKOMOqIO0Sg_1782768995
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74CFA1945105; Mon, 29 Jun 2026 21:36:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 425441956096; Mon, 29 Jun 2026 21:36:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/14] qapi: convert to explicit intro section syntax
Date: Mon, 29 Jun 2026 17:36:10 -0400
Message-ID: <20260629213624.936258-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2638342206=0D
=0D
Hi, this patchset converts some of the most trivial modules to use the=0D
new explicit intro syntax. This particular patchset does not=0D
differentiate between "trivial" conversions and those that take=0D
slightly more liberty in refactoring, but there are (debatably?) no=0D
such cases in this patchset.=0D
=0D
John Snow (14):=0D
  qapi: convert intro sections for error.json=0D
  qapi: convert intro sections for acpi-hest.json=0D
  qapi: convert intro sections for ebpf.json=0D
  qapi: convert intro sections for uefi.json=0D
  qapi: convert intro sections for compat.json=0D
  qapi: convert intro sections for vfio.json=0D
  qapi: convert intro sections for trace.json=0D
  qapi: convert intro sections for misc-arm.json=0D
  qapi: convert intro sections for cryptodev.json=0D
  qapi: convert intro sections for machine-common.json=0D
  qapi: convert intro sections for accelerator.json=0D
  qapi: convert intro sections for authz.json=0D
  qapi: convert intro sections for yank.json=0D
  qapi: convert intro sections for replay.json=0D
=0D
 qapi/accelerator.json    | 18 ++++++----------=0D
 qapi/acpi-hest.json      |  4 ++--=0D
 qapi/authz.json          | 21 +++++++------------=0D
 qapi/compat.json         |  9 +++-----=0D
 qapi/cryptodev.json      | 18 ++++++----------=0D
 qapi/ebpf.json           | 14 ++++++-------=0D
 qapi/error.json          |  3 +--=0D
 qapi/machine-common.json | 19 +++++++----------=0D
 qapi/misc-arm.json       | 24 +++++++++------------=0D
 qapi/replay.json         | 45 ++++++++++++++++++----------------------=0D
 qapi/trace.json          | 12 ++++-------=0D
 qapi/uefi.json           |  5 ++---=0D
 qapi/vfio.json           | 19 ++++++++---------=0D
 qapi/yank.json           | 28 ++++++++++---------------=0D
 14 files changed, 94 insertions(+), 145 deletions(-)=0D
=0D
-- =0D
2.54.0=0D
=0D


