Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07357CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUe-0008W0-D7; Thu, 01 Oct 2026 13:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUb-0008VU-LT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUZ-0006vX-OM
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GWuJQ0d+aFPAoFPOUS+rfKHLhF4rLurCL0+UcDyUFVM=;
 b=Rk1GRrB4ZqWQE1PWcKQ3ILqC30wAhufsNtJOSJ41pQqtr9jhLy5O3n4dgIJuX3Jw3Ax3Wj
 EO4qh/xyLJ6c9bcq2SNp3D0uC1xaY/uFjQl5RJZGQFXwHPTaVQMZzfRPLYmSHig+upULVV
 G6NvZ+ODyCN97t011ixn/o1qy/Ft72o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-wPzR_3BGNRmD0qwkVjozXg-1; Thu,
 01 Oct 2026 13:22:42 -0400
X-MC-Unique: wPzR_3BGNRmD0qwkVjozXg-1
X-Mimecast-MFC-AGG-ID: wPzR_3BGNRmD0qwkVjozXg_1790875361
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 539E9183459D; Thu,  1 Oct 2026 17:22:41 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B282180056E; Thu,  1 Oct 2026 17:22:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/11] docs/qapi: revise and expand QAPI documentation spec
Date: Thu,  1 Oct 2026 13:22:27 -0400
Message-ID: <20261001172239.2825745-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

This patchset looks at expanding and clarifying the documentation for=0D
... writing documentation. Primarily, the doc is being organized into=0D
subsections - one for each QAPI doc section. These sections are=0D
re-ordered to be documented in the same order as they are expected to=0D
appear in-usage.=0D
=0D
John Snow (11):=0D
  docs/qapi-code-gen: change "x.y.z" to "x.y" for Since: documentation=0D
  docs/qapi-code-gen: add "Putting it all together" subsection=0D
  docs/qapi-code-gen: add "TODO" subsection=0D
  docs/qapi-code-gen: add "Since" subsection=0D
  docs/qapi-code-gen: add "Details" docs subsection=0D
  docs/qapi-code-gen: add "Errors" and "Returns" subsections=0D
  docs/qapi-code-gen: add "Tagged sections" subsection=0D
  docs/qapi-code-gen: add "Descriptions" subsection=0D
  docs/qapi-code-gen: add "Feature descriptions" subsection=0D
  docs/qapi-code-gen: add "Intro" subsection=0D
  docs/qapi-code-gen: add "Tagged sections" cross-references=0D
=0D
 docs/devel/qapi-code-gen.rst | 136 +++++++++++++++++++++++++++++------=0D
 1 file changed, 116 insertions(+), 20 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


