Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE7606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Iq1eMLli
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT1Tt-00038u-L4; Mon, 16 Nov 2026 13:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT1Ti-00037f-1K
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:30:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT1Tg-00084P-EG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794853850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6v+gV5sl7qdF4I4+MWrX4gZgYp8A0rI/bvJxNG+sYto=;
 b=Iq1eMLlin9FX62/Naax8URnOaCbVKvfg6RC/TrFUgT7vf5kuL140mcVhjYUtpGI2WKUx+g
 1aRm//UnwX3Qnj28JeVl/2JmdT7CdeE8oNkisegerbJBwyVyKI65dU/w/0TvvkvyM/23M8
 ASZPAE13cAWiqvb8BO3wChyF3Rj2uq4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-7mhrPzmVMzq3Npp5Ll2elg-1; Mon,
 16 Nov 2026 13:30:49 -0500
X-MC-Unique: 7mhrPzmVMzq3Npp5Ll2elg-1
X-Mimecast-MFC-AGG-ID: 7mhrPzmVMzq3Npp5Ll2elg_1794853848
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BB8195D018; Mon, 16 Nov 2026 18:30:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D42FD3001DAC; Mon, 16 Nov 2026 18:30:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PULL 0/2] Python patches
Date: Mon, 16 Nov 2026 13:30:43 -0500
Message-ID: <20261116183045.118241-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5=
:=0D
=0D
  Merge tag 'pull-nbd-2026-11-10-v2' of https://gitlab.com/ebblake/qemu int=
o staging (2026-11-13 08:44:16 -0700)=0D
=0D
are available in the Git repository at:=0D
=0D
  git@gitlab.com:jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 8ff6cd65b6e4a9944e54dd27aa3a72ebef8f93d4:=0D
=0D
  python/utils: fix accelerator detection with annotated -accel help (2026-=
11-16 11:53:21 -0500)=0D
=0D
----------------------------------------------------------------=0D
python: pull request for-11.2=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (1):=0D
  python: add support for Python3.15=0D
=0D
Marc-Andr=C3=A9 Lureau (1):=0D
  python/utils: fix accelerator detection with annotated -accel help=0D
=0D
 configure                              | 2 +-=0D
 tests/docker/dockerfiles/python.docker | 5 ++---=0D
 python/Makefile                        | 4 ++--=0D
 python/qemu/utils/accel.py             | 5 +++--=0D
 python/setup.cfg                       | 3 ++-=0D
 5 files changed, 10 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.56.1=0D
=0D


