Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AEFC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxjv0-0002eB-8n; Fri, 19 Apr 2024 04:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjuy-0002db-SN
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxjux-0007YB-2f
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713516502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aTBKyYNbDHWjTOtutkCNcrbryR65acR/RnkNo7OyK2M=;
 b=Ondy32ZdA4qh2DAf3dnN0CDUyE9s6yFREVnke5f2aBe+A73WYkG0rH8MKaP1c/3XD62Fp9
 fyl0Sk8UtMDm8M9LTR7uPvJxZINh2TI4R4szn0zi6GumYLJvFQh+coQKN7APnW4sX7GQy8
 4iBQZZaE951DExJ5EmbqffiZ9jLpUXw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-LCha1Sg8Mkui2E3YpfeHnw-1; Fri, 19 Apr 2024 04:48:16 -0400
X-MC-Unique: LCha1Sg8Mkui2E3YpfeHnw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E0F6800CA2;
 Fri, 19 Apr 2024 08:48:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD6501121306;
 Fri, 19 Apr 2024 08:48:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 0/4] Sparc CPU naming and help text improvements
Date: Fri, 19 Apr 2024 10:48:08 +0200
Message-ID: <20240419084812.504779-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The Sparc CPU naming and the corresponding help text is somewhat
confusing for the users. We should avoid spaces in the Names and
provide clear information to the users what can be passed to the
"-cpu" option.
While we're at it, also remove the "+" from two of the CPU names
since this character is now not allowed in device names anymore
(and was worked around with an ugly hack in qom/object.c so far).

v2:
- Use "Sun-UltraSparc-IIIi-plus" and "Sun-UltraSparc-IV-plus"
  instead of just adding a "p" at the end
- Drop the sentence about NetBSD and OpenBSD in the docs since
  these problems are likely fixed since a long time already
- Added Reviewed-bys from earlier series and updated the patch
  descriptions a little bit

Thomas Huth (4):
  target/sparc/cpu: Rename the CPU models with a "+" in their names
  target/sparc/cpu: Avoid spaces by default in the CPU names
  docs/system/target-sparc: Improve the Sparc documentation
  docs/about: Deprecate the old "UltraSparc" CPU names that contain a
    "+"

 docs/about/deprecated.rst    |  9 +++++
 docs/system/target-sparc.rst | 12 ++++---
 qom/object.c                 |  8 -----
 target/sparc/cpu.c           | 66 +++++++++++++++++++++---------------
 4 files changed, 54 insertions(+), 41 deletions(-)

-- 
2.44.0


