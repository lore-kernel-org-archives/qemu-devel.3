Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F952C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 20:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNe17-0000iF-Mc; Fri, 06 Jun 2025 16:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNe15-0000hU-LG
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNe14-0006oY-4g
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749243015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5A5ZHbNsHbHTDpcP4G0oHxVl7oIh4yuOlvJucVU/4b4=;
 b=EuNOwiwlw3fNBhOJMFC0yP2jbHQHj9una4zhx7s/4pSWAQFDtjyIbTwFCZXULt0GPAZOJc
 bp8mIIEWPlvoX+fdkrYSQTzJauOJGdKBxWbx64yi+Xsl5XkNYbVHVpsqsFoHV4pXOn/NIA
 1Li4euwdztRKhxttb58BrZARTmawfeE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-ecy61_o1O4SbuSVUzIAFXA-1; Fri,
 06 Jun 2025 16:50:12 -0400
X-MC-Unique: ecy61_o1O4SbuSVUzIAFXA-1
X-Mimecast-MFC-AGG-ID: ecy61_o1O4SbuSVUzIAFXA_1749243011
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 864981801BEC; Fri,  6 Jun 2025 20:50:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F1A930001BD; Fri,  6 Jun 2025 20:50:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 0/4] Docs: bump sphinx version to 6.2.1
Date: Fri,  6 Jun 2025 16:50:05 -0400
Message-ID: <20250606205009.584615-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a re-send of Akihiko Odaki's series, rebased and altered to cope=0D
with the new QAPI static analysis tests now running on GitLab CI.=0D
=0D
Changes in this "v1":=0D
=0D
 - Update python static analysis testing configuration to work with the=0D
   new Sphinx minimum version=0D
 - Small adjustments to qapi_domain.py in light of upstream changes to=0D
   keep new CI tests passing.=0D
   (Thank you for deleting compat.py, Odaki-san!)=0D
 - Make the minimum versions for sphinx and sphinx-rtd-theme more=0D
   explicit, including the patch version number; thiis is *required* for=0D
   Debian platforms which ship sphinx-rtd-theme 1.2.1 and will fail to=0D
   build docs otherwise.=0D
=0D
Akihiko Odaki (3):=0D
  docs: Bump sphinx to 6.2.1=0D
  docs: Require sphinx>=3D6.2=0D
  MAINTAINERS: Add docs/requirements.txt=0D
=0D
John Snow (1):=0D
  python: update requirements for Sphinx=0D
=0D
 MAINTAINERS                |   1 +=0D
 docs/requirements.txt      |   4 +-=0D
 docs/sphinx/compat.py      | 230 -------------------------------------=0D
 docs/sphinx/qapi_domain.py |  38 +++---=0D
 python/setup.cfg           |   2 +-=0D
 python/tests/minreqs.txt   |  36 +++---=0D
 python/tests/qapi-isort.sh |   4 +-=0D
 pythondeps.toml            |   4 +-=0D
 8 files changed, 46 insertions(+), 273 deletions(-)=0D
 delete mode 100644 docs/sphinx/compat.py=0D
=0D
-- =0D
2.48.1=0D
=0D


