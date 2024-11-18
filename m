Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2DAD60CEC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 22:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDA0D-0002bY-Ui; Mon, 18 Nov 2024 17:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA06-0002aN-35
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA02-0006ZS-6n
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731968015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=toNY5QgJF0pLvE90n/G7g88cxQO4aglxHkMBCarnipg=;
 b=JfOuuXrFZ/yUrob+2eqWrONEW+JeDvhsGoKDao/7oL33nMwljHrwKIvrajhPI2OWSQSdTD
 b/SP7xuMzev87wK2VbmQHUoBEVm+ki2w8ftIkBOHY4kQuqDnonHH/ICkyAXZSwhvxqVj0A
 Mn17Rkd8xElNoj49ateeKSHJ8Tg8vnU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-OKVr8dwJNxmaPs6K9XnoKQ-1; Mon, 18 Nov 2024 17:13:34 -0500
X-MC-Unique: OKVr8dwJNxmaPs6K9XnoKQ-1
X-Mimecast-MFC-AGG-ID: OKVr8dwJNxmaPs6K9XnoKQ
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a76d10a7dbso14160495ab.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 14:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731968013; x=1732572813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=toNY5QgJF0pLvE90n/G7g88cxQO4aglxHkMBCarnipg=;
 b=EI6tM0m1cxY9SLHwRh5ltuuMRtgG1uHPTsT3oaih8Ruhe21s04p7WeaKmxo6ft1Jmc
 qn02l+Ll3I2s996pTW2M6zejQUn2fOEsEbmUdIBqriO2gMgvapu02xcYFyNfCTHvffJ9
 BwRL9LRgPwakLaZ4b0q3ubvIBT92kD/jhdICi/lhIsZ+b9hWXkIktpV9Mauuy9u73KW/
 Csf8iWNXOB6nE1BijVwOFGq+EJFV47LV8YR6vWvyn6icNrfKYDcvWhywOcy46nZVXu8G
 lunFf1+N+h7S9/aqOHrcUSYkEfv/bfWPypW7F7qyE8sUYBHEKKRRt9PEiuii9+Xw1fW4
 Uziw==
X-Gm-Message-State: AOJu0Ywv56CjTmyfBRGSyCBAcX+kfm7Aq86BMHlHnMn0Xm4Ar6gkE7w1
 Ml38lDeFTTP9OaPrESrQ7yPdi4PCFj4/adYBXzBbZBuhm0kaUTu9aU+729/g5vvPvVsbCDvRaOn
 P5PydFPDJUmw3H74A5XhkSM+J2danyqjrb4jCERwxceKhhgwnpLPYl7GxvBaGrK1QPNxlXdauEe
 kZ2tQ7V/cxMe3Q9Z3mdlSj4Utd+Fj9CnL/8g==
X-Received: by 2002:a05:6e02:1c2d:b0:3a7:74e1:d54d with SMTP id
 e9e14a558f8ab-3a774e1d777mr23368925ab.21.1731968013581; 
 Mon, 18 Nov 2024 14:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzqMdqBfPjF+5q3sKxqoC62SShHGRfi14GXCcVYLOPUrQX3QAq7/dcPE2m1l1RPIe8h7yGBw==
X-Received: by 2002:a05:6e02:1c2d:b0:3a7:74e1:d54d with SMTP id
 e9e14a558f8ab-3a774e1d777mr23368595ab.21.1731968013202; 
 Mon, 18 Nov 2024 14:13:33 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6e7fd9sm2298599173.9.2024.11.18.14.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 14:13:32 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/5] QOM: Enforce container_get() to operate on containers only
Date: Mon, 18 Nov 2024 17:13:25 -0500
Message-ID: <20241118221330.3480246-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

[This is not for 9.2 release, but for 10.0]

QEMU defines a frequently used helper container_get(), which (from its name
implies) should return a container object of a specific path, normally
starting from object_get_root() (aka, the root of QOM tree, "/"), or some
sub-directory of root.

We mostly use it correctly across the tree, except two use cases that may
abuse the helper to be similar to object_resolve_path_component():

  - qdev_get_machine()
  - e500_pcihost_bridge_realize()

In the two cases, container_get() might accidentally create a container
even if the goal of the caller is trying to fetch some non-container
object.

This series cleans this up by firstly remove these two abuses, replacing
the container_get() usages with object_resolve_path_component().
Meanwhile, the last patch adds not only rich comment explaining
container_get() usages, but also added a lightweight assertion to make sure
container_get() will always walk on container objects, and always return
container objects.

There's another implicit side effect that container_get() may silently
create missing container objects while walking the path.  We could switch
to an explicit way of using containers in the future, but now leaving that
behavior as-is.

Note, patch 3,4 were picked up from the previous singleton series [1], even
if the vIOMMU patch wasn't present.  It's because they're still required in
this cleanup series to either clean up container_get() user, or to avoid
breaking test_static_prop_subprocess() similarly there.  Looks like that
test is so far the only test that can try to realize() a qdev without a
machine object.

[1] https://lore.kernel.org/r/20241029211607.2114845-1-peterx@redhat.com

Thanks,

Peter Xu (5):
  qom: Add TYPE_CONTAINER macro
  ppc/e500: Avoid abuse of container_get()
  qdev: Make device_set_realized() always safe in tests
  qdev: Make qdev_get_machine() not use container_get()
  qom: Make container_get() strict to always walk or return container

 include/qom/object.h  |  3 ++-
 hw/arm/stellaris.c    |  2 +-
 hw/core/qdev.c        | 20 +++++++++++++++++---
 hw/pci-host/ppce500.c |  4 ++--
 qom/container.c       | 25 +++++++++++++++++++++++--
 qom/object.c          |  4 ++--
 6 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.45.0


