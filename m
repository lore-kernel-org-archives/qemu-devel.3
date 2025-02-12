Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A315C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiENJ-00006C-B6; Wed, 12 Feb 2025 10:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiENG-00005C-Td
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tiENF-00065J-66
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739373000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v4kPYKvc/51i1YMt5zGWEUewlddDuQWvYAXetin8ggE=;
 b=essJGW8AA7gVcBQ/odu7lvaxibqmPfpI2jKCgv9fDc9jS6YiauCGmsGdf1gjUUKBrAf1Fl
 42gR7py8Pn+JgAq3GYsaZ/h5kkjN7hak7UjlWGm4rPYmWgYKI/CRo0heu8PHsXvGqb+gd+
 eRxu+uRGKguZYf2/7IN97BE7pC3Baso=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-Zy4E9ZCiNhCelwuKK_usZA-1; Wed,
 12 Feb 2025 10:05:30 -0500
X-MC-Unique: Zy4E9ZCiNhCelwuKK_usZA-1
X-Mimecast-MFC-AGG-ID: Zy4E9ZCiNhCelwuKK_usZA_1739372725
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25BE71955D6A; Wed, 12 Feb 2025 15:05:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8680A18004A7; Wed, 12 Feb 2025 15:05:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/1] Tracing patches
Date: Wed, 12 Feb 2025 10:05:21 -0500
Message-ID: <20250212150522.202022-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit f9edf32ea2e18a56de5d92f57e9d10565c822367:

  Merge tag 'pull-request-2025-02-11' of https://gitlab.com/thuth/qemu into staging (2025-02-11 13:27:32 -0500)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 9976be3911a2d0503f026ae37c17077273bf30ee:

  scripts: improve error from qemu-trace-stap on missing 'stap' (2025-02-12 10:03:18 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Daniel P. Berrangé (1):
  scripts: improve error from qemu-trace-stap on missing 'stap'

 scripts/qemu-trace-stap | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.48.1


