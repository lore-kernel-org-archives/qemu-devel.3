Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A84CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWxM-0004af-4b; Thu, 11 Jun 2026 00:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxK-0004aF-HB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxI-0005PL-Pq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781151826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SvH369xNRR447fk1hvE6sT+1Q/ldXYI0tqtjisLXCmk=;
 b=WZXlYw2mMf1WXqhqI9yPUR5yCkhLvKIxwWJ5OE5zDdsWBeJMoEvW11/wGUcyln0Uvzs4U2
 A/XCgJ29byU1jkH8wCYGI2SdHD+tQSMfRDYdlU3BjPa3GZZAsoYna5GXTgTvcsDBwcgxUc
 MRfsAm2dPU+EmtTj/9pigbGVpAzfcBo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-V1ibuMr3NPyivOvFvDWkJA-1; Thu,
 11 Jun 2026 00:23:42 -0400
X-MC-Unique: V1ibuMr3NPyivOvFvDWkJA-1
X-Mimecast-MFC-AGG-ID: V1ibuMr3NPyivOvFvDWkJA_1781151821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B5161800345; Thu, 11 Jun 2026 04:23:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F6981800583; Thu, 11 Jun 2026 04:23:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, linux-edac@vger.kernel.org,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 00/13] qapi: add formal "intro" section
Date: Thu, 11 Jun 2026 00:23:19 -0400
Message-ID: <20260611042332.482979-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
V4: A few minor comment touch-ups; omitted module conversions.=0D
=0D
V3: changed intro section syntax, made various fixes and changes; I'm=0D
going to be honest Markus I did not keep a strict account this time=0D
;_;=0D
=0D
V2: punt intro sections to the subsequent line and adjust the parser=0D
accordingly. Left as an RFC patch that undoes some things this series=0D
does instead of properly factoring into the series.=0D
=0D
John Snow (13):=0D
  python: temporarily restrict max mypy version=0D
  tests/qapi: generate output in source order=0D
  qapi/docs: remove unused QAPIDoc subsection members=0D
  qapi/docs: add has_features property=0D
  qapi/docs: make remaining subsection members "private"=0D
  qapi/docs: fix comment phrasing=0D
  qapi/docs: add "Intro" section=0D
  qapi/parser: move _insert_near_kind() method=0D
  qapi/parser: add mea culpa comment for ensure_returns=0D
  qapi/docs: adjust stub member insertion algorithm=0D
  qapi/docs: remove implicit Plain section=0D
  qapi/docs: add rendering for INTRO sections=0D
  qapi/docs: add "Intro" section parsing=0D
=0D
 docs/devel/qapi-code-gen.rst   |  16 ++--=0D
 docs/sphinx/qapidoc.py         |  61 +++++++-----=0D
 python/setup.cfg               |   3 +-=0D
 scripts/qapi/parser.py         | 167 +++++++++++++++++++--------------=0D
 tests/qapi-schema/doc-good.out |  86 +++++++++--------=0D
 tests/qapi-schema/test-qapi.py |  14 +--=0D
 6 files changed, 197 insertions(+), 150 deletions(-)=0D
=0D
-- =0D
2.54.0=0D
=0D


