Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDE0FDEE54
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG26F-0005gL-2p; Thu, 23 Apr 2026 18:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26D-0005fr-Se
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26B-0005mP-JG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776981637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Az8FOwflkNU6LVUkwPy9FYx12SR+O87ECfoZMmd72YA=;
 b=ZIKzh/fjAPm3WtZtvegLL0QiryEqrr+c4k72GiADHrWj7B11Vbj9icesF1I5G6Ta/pUSDq
 px3bO02Ms+WgJUzPCBEUCVz1uLEDB3RvclNJQWUUg5MRHNyTmC53x8Pyi/5EqgTCSXo3uw
 Zg2Zzx24QgfirJ850l0fDg0/iSQppXw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-LvMGL4HeOQyPafX1YdE1FA-1; Thu,
 23 Apr 2026 18:00:28 -0400
X-MC-Unique: LvMGL4HeOQyPafX1YdE1FA-1
X-Mimecast-MFC-AGG-ID: LvMGL4HeOQyPafX1YdE1FA_1776981627
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 227D818003F6; Thu, 23 Apr 2026 22:00:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E55CC30078C2; Thu, 23 Apr 2026 22:00:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/12] qapi: add formal "intro" section
Date: Thu, 23 Apr 2026 18:00:09 -0400
Message-ID: <20260423220022.2180059-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hiya, this is a series that explores a potential syntax for a=0D
designated "Intro" section. Markus knows why I want this, but for=0D
everyone else: a designated "Introduction" section is useful for the=0D
desired "inliner" feature for the new QAPI doc system. Commits explain=0D
a bit more. This is prep work and doesn't really change anything=0D
tangibly except source code syntax for the QAPI docs.=0D
=0D
It is designed so that this conversion can happen incrementally with=0D
no actual difference to the rendered manuals, so each QAPI module can=0D
be converted one at a time for easier review and merging in an=0D
arbitrary order.=0D
=0D
This series demonstrates conversion of just four modules; if I'm given=0D
a thumbs up, I will convert the rest of QAPI, one module (or=0D
maintainer stanza) per patch like how I handled adding=0D
cross-references.=0D
=0D
John Snow (12):=0D
  tests/qapi: generate output in source order=0D
  qapi/docs: remove unused QAPIDoc subsection members=0D
  qapi/docs: make remaining subsection members "private"=0D
  qapi/docs: add "Intro" section=0D
  qapi/docs: adjust stub member insertion algorithm=0D
  qapi/docs: remove implicit Plain section=0D
  qapi/docs: add "Intro" section parsing=0D
  qapi/docs: Add rendering for INTRO sections=0D
  qapi: convert intro sections for accelerator.json=0D
  qapi: convert intro sections for acpi-hest.json=0D
  qapi: convert intro sections for acpi.json=0D
  qapi: convert intro sections for audio.json=0D
=0D
 docs/devel/qapi-code-gen.rst            |  17 +-=0D
 docs/sphinx/qapidoc.py                  |  52 +++---=0D
 qapi/accelerator.json                   |  24 +--=0D
 qapi/acpi-hest.json                     |   5 +-=0D
 qapi/acpi.json                          |  23 +--=0D
 qapi/audio.json                         | 112 ++++---------=0D
 .editorconfig                           |   1 +=0D
 scripts/qapi/parser.py                  | 204 ++++++++++++++----------=0D
 tests/qapi-schema/doc-good.out          |  30 ++--=0D
 tests/qapi-schema/doc-missing-colon.err |   2 +-=0D
 tests/qapi-schema/test-qapi.py          |  15 +-=0D
 11 files changed, 239 insertions(+), 246 deletions(-)=0D
=0D
-- =0D
2.53.0=0D
=0D


