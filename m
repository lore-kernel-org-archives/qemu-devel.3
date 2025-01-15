Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41309C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 07:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxz4-00058t-Dr; Wed, 15 Jan 2025 02:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxz2-00058Z-M1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:38:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxz1-0007q4-2m
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736926711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kLCCx4YxuI/iZRLI3X4S+Rad+SJHeFrtbJRlhGFFJRw=;
 b=DvpMaYK0oaaME1Z2PvxtNs+BsV7E0/MJw2s0nWSLXUP55AUYMK33Ppzdn3hEMQ9Rfa2aH8
 IAZ/YPsSjC81HL0x3JscB96WOMM+Zl/KKL8potGmEIvOudj3YjgAUo8L6KkqTVzhz4Ka0W
 wbJSo6ej71csIa7mg7YLhYnmySpNEm0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-VElDoI3rOXq8dmWIWCOw8w-1; Wed,
 15 Jan 2025 02:38:27 -0500
X-MC-Unique: VElDoI3rOXq8dmWIWCOw8w-1
X-Mimecast-MFC-AGG-ID: VElDoI3rOXq8dmWIWCOw8w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCF511956080; Wed, 15 Jan 2025 07:38:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C19B8195608A; Wed, 15 Jan 2025 07:38:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/8] s390x: Remove deprecated machine types v2.9 up to v2.12
Date: Wed, 15 Jan 2025 08:38:11 +0100
Message-ID: <20250115073819.15452-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

These machine types have been marked as deprecated two releases ago,
and are older than 6 years, so according to our support policy, it
should be fine to remove them now. 

Thomas Huth (8):
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.9 machine type
  hw/s390x/css: Remove the obsolete "css_migration_enabled" variable
  hw/s390x/s390-stattrib: Remove the old migration_enabled flag
  hw/intc/s390_flic: Remove the obsolete migration_enabled flag
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10 and 2.11 machine
    types
  hw/s390x/event-facility: Remove the obsolete "allow_all_mask_sizes"
    code
  target/s390x/gen-features: Remove the v2.11 qemu CPU model
  hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12 machine type

 include/hw/s390x/css.h                |  6 ---
 include/hw/s390x/s390_flic.h          |  1 -
 include/hw/s390x/storage-attributes.h |  1 -
 hw/intc/s390_flic.c                   | 14 -----
 hw/s390x/css.c                        | 31 +----------
 hw/s390x/event-facility.c             | 37 +------------
 hw/s390x/s390-stattrib-kvm.c          |  2 +-
 hw/s390x/s390-stattrib.c              |  7 +--
 hw/s390x/s390-virtio-ccw.c            | 75 ---------------------------
 target/s390x/gen-features.c           |  7 ---
 10 files changed, 4 insertions(+), 177 deletions(-)

-- 
2.47.1


